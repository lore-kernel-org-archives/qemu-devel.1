Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B92C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BAF2098B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bhChYKHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BAF2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBilY-0005cC-I1
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBijQ-0003BK-6S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:04:08 -0400
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com
 ([40.107.236.89]:15456 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBijL-0002OK-1K
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:04:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWCf2l6SY7RkMp5J0eBZeud+qtjF4Cu+nMMlA45wnk0dOcAldA1P33BiJUUNI3aiF+MIs0kQmwS/AU3zqMxS7EVERoKUiUnBTICQd2MdBc2LlNZaGXvka7ChvjUOqoJJeHJCyAE+BQ0z47Z0x9mgAwJpFw0K4U2mawBVFsyb8q4LNoGYkAuri7Q2yDUr5UTWJyo3JwtcqEIQgUPRAbCsQnLTgMiCcfskvRXfYpr8jQJBdug+3g+QiBK9I87XwdSomjATC4Hbkafo2nJf/Shm9imfdj3xmhVdYYqZ19fxUSjxTpDDu6IdpMRonaNNdcMlulg0V2tftPhdaXb5cgUIqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmTvCOeY/DJT5waOdWR47K0axfTb7lB7Pn84oMdFrg0=;
 b=ZkmsALG46T2gSnHebWvbF+tF5mbjMPqhcEppScxU175KL3LBQnreyJwlCXF/OnltJ2Bjc9Qp+hYWSzJIH3Q1U+W4EmmyIlhb70X/BBJJUnN9zJJkKD/iDxrCdOG516rEZcawdCQ++SWBVKMGhQ6pSeasgU5IGSUry3M4H6GEO2vllYUMHUiOU0BRkvdKnPkJIsSoAbn3/DYRGYQD8G6bEmxXSn72dqU3jfb2NFjsxN5QQVxW3WFWr4TdBCf21sgrK+P6FIxm4ZxGks4EYuh+TbktlvJzbkVOan+V2Mm28APMslUx/dEbOO7w+eX99Cb13DHsHjKYmcn2czviBAGGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmTvCOeY/DJT5waOdWR47K0axfTb7lB7Pn84oMdFrg0=;
 b=bhChYKHhRlcsSDZxQOGhxjr1I9G7JTjjpXqL/ACyfrRyGGxOaLqZ4KET76JoM4epOewwELlL+ICwq3at4FuFx3EeZykNmRNpgXZX9oBbp0b6+e5QyTJLY2Cosv81yXgV5rHK8GFhc8JKl3XpmkLiij1SaYNNJfwjbio0jEIPtzE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:75::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 18:04:01 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 18:04:01 +0000
Subject: Re: [PATCH v5 7/8] Revert "hw/386: Add EPYC mode topology decoding
 functions"
To: Eduardo Habkost <ehabkost@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <159804798309.39954.1879996211709102099.stgit@naples-babu.amd.com>
 <20200828172741.GO642093@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <1b7ce19c-7f93-ef76-a37d-2957c82c2c9d@amd.com>
Date: Fri, 28 Aug 2020 13:03:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200828172741.GO642093@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0028.namprd02.prod.outlook.com
 (2603:10b6:803:2e::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0201CA0028.namprd02.prod.outlook.com (2603:10b6:803:2e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 18:04:00 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7bdc07c-8fdb-457a-76ff-08d84b7cbdf3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2736:
X-Microsoft-Antispam-PRVS: <SN6PR12MB273641ADD71036A33CC3EBB895520@SN6PR12MB2736.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kKa4/Qhw3q2ga1121bCToV8rOZTLHfHIiDQStYNTXb9oTjyhjAgyWOMA7W3eI/QPOXi1xSuItPbIgn9gQPK2/jyBqP1rpQY839ByXU5o/y3M2js82zFQPmqtxZs9VRxJHxxjqXAgaK/YFHE1uB3/IjUk2JkHI1VSwySWpSc5QzwluFXqplRpjmFMtMhGvoGA0kseI8p18ZhOePVk/fX2HFlEHPvftuX4QpbqYzsCt9M1ti6KesXbx4SVw0z+WgXm6UGeVbyESoivubahzTSKJIeRDhHSj3PL8PGs7HcqAIAhFKpTWtRR91xp7RfhQc5lFdpfdQoCC2BchCQNmi+sweUN6wRiww6mCC6hYkpA86vME+oum+od2PKm/g2tZOi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(66946007)(6486002)(186003)(86362001)(2906002)(8676002)(2616005)(36756003)(31696002)(26005)(66556008)(956004)(66476007)(44832011)(52116002)(478600001)(5660300002)(8936002)(53546011)(316002)(31686004)(16576012)(4326008)(6916009)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JRZs24puv/7tjnlRFygKPb/tl8V9QWEthYYuUG+oTLorV8Tvz0fCTHDtt0Fz96PHbKY1U5lCmRIm5TtqqRuKSsoOiLiR8WGYXSj5CtM60o4WYYs7fV5Yn5vLahvKXTjD5qVzwmu/bdPY5YqMHWHhCq+t4Ykw+ydRUQvPpdZ9lmEoBNSnHuElyekda68Xnr7FbcdWLUZ984hNczxGKu/H1gKEe4Uem85peh1UwvSVW27Ss9zeA6wiSQDb/uwp0goA4ISO97zJGmqS/ugnGJNTv23CUcwD6CR7BufowJHFCsfnx9jORFGnrkZ+fHLaiasGZ2nPq70Cj1Vwe0HQYnX+4BHZayqX3+1X0DbPPIu+B5/L9cYRemSby+PUtELMsxI7TCoJNKDPHs3NFURZKXMk5vZw076G5hWmFSIzVxYJfh6B7yNV2jVDmqrMKu6dAKHsup0XiNrz0Ry0pnGwkp2Dr1KMPljmrcWQe6Au6I4trZfEVu/fcHvWsi/WZfIbkZqgGoqtdO/7awpuyRZuySSM9KmH1Mf4BNuZGybm/ISLT18wd/9Y+gvInHAxsV2vPWc9RMcbSjm/bgYKYrKAjuOjlbNbpYs2n2EnYpDBL9CuD5/jqd2A2HInLd0cqgLjJdO9+O/+oqZW1W/1c/xktYbF+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bdc07c-8fdb-457a-76ff-08d84b7cbdf3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 18:04:00.9371 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2L5bVAaL2U2MoAD2HMGVDvQYV2FqwIipffovhK6cAon8ArmONgozTLUZxlxFkMRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
Received-SPF: none client-ip=40.107.236.89; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 14:04:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-0.809, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/28/20 12:27 PM, Eduardo Habkost wrote:
> On Fri, Aug 21, 2020 at 05:13:03PM -0500, Babu Moger wrote:
>> Remove the EPYC specific apicid decoding and use the generic
>> default decoding.
>>
>> This reverts commit 7568b205555a6405042f62c64af3268f4330aed5.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> [...]
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 19198e3e7f..b29686220e 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -388,7 +388,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>      unsigned long dies = topo_info->dies_per_pkg;
>>      int shift;
>>  
>> -    x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
>> +    x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
> 
> This was not part of commit 7568b205555a6405042f62c64af3268f4330aed5.
> I suggest doing this change as a separate patch, to make review easier.
> 
> That line was addd by commit dd08ef0318e2
> ("target/i386: Cleanup and use the EPYC mode topology functions").
> Wouldn't it be simpler to revert that commit?  If there are parts
> of commit dd08ef0318e2 we want to keep, they can be re-added
> in a separate patch.
> 

Sure. Will take care of it in next revision. Thanks.

