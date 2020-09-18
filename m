Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21113C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7B7208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UAXTKxKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7B7208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOPF-0000Ce-Ff
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kJON0-0007Zy-M6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 17:56:42 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com
 ([40.107.92.89]:49889 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kJOMx-00068p-Vg
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 17:56:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP3EtwQ7msGAVyL1DQti5veKezxhP+l+bcpGwMCeJtfpIxY0f/4t91Dy0wP7XV7+AGA2DPPHAuDyjtwUuTsOlgfNuvR7p9BubcRaDp1UVZGNn8OO+m9OOHAR3ZcKmbJNLmdjFKDSvA1OsGkyqsnqvzDfY5q5SD/jeCXWQznJ2GsuLVyyMeDeJiKBpjKh41tzHUbIHUv9ItM6hVALjKt0Uo3Cs/ICoLkdMdObnzBHeS4k2A3irr9cC+DRaf3O4/k9QlJsRaZAMQ1zENKQpbrlrKiTEWNx5VJzEqhh5taC550XaPvhqhNqVS7CMg/sYsSj3mTg2vJCxYlE1+Zd7hPFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH6AFZB2bDQg1lmI/dmqxF3qPLDLOqBDK2vDWqaKeEQ=;
 b=EQQiI3okfezL2XnkOapNKjeLJZF4n5VDvEVakMN21VQnl1YBpPYzPDj6USbSFxVds3cMYmNufxAAa+pYoRIqsgA2KdNW7tqlg0kkPztZh8hU/kA/FmEOaU6WKku0UjSoSg2duhktaLmJHRIo7eaYnuovvFU3ULhWBl+LqEMKxaswGRDfhpVTkiZvuH7h6crXgBbyQkif1kloSTHMSq8rtbRVu3K9kIBdprh4Nw7vL8fK+65SiE9ioYgKAvaW8oBcVg/LZyoVWj+psLNb0ZucDFE7SWNIKtwBjdt/PhHdQLDdrWrbblcTbzVyYGzdn7uB8Z5SuwqMkCmXzFe9k2eqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH6AFZB2bDQg1lmI/dmqxF3qPLDLOqBDK2vDWqaKeEQ=;
 b=UAXTKxKVAd8yLCdgIw9rqusqMsOa8qCK928MUahM4bJgZE5gYigA1kMz/krChkUvr6CJWVq8OjcG3NJiiyih+xRaqZEh8YykbMSYbVdr6MkFVjQWSx5pUWaySUb+XiXmiooWbsw3HGvbXgkmUqiy9mvpwRaZiPT783VIaEK7IF0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4558.namprd12.prod.outlook.com (2603:10b6:806:72::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.18; Fri, 18 Sep
 2020 21:41:35 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 21:41:35 +0000
Subject: Re: [PATCH v6 10/10] i386: Simplify CPUID_8000_001E for AMD
To: Eduardo Habkost <ehabkost@redhat.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
 <159889938728.21294.12746724309255308236.stgit@naples-babu.amd.com>
 <20200918213802.GA57321@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <779ac8ef-95b6-c026-8336-570b207d1fda@amd.com>
Date: Fri, 18 Sep 2020 16:41:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200918213802.GA57321@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:806:d2::11) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by
 SA0PR11CA0066.namprd11.prod.outlook.com (2603:10b6:806:d2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 21:41:34 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3087111f-05bb-4bb5-1540-08d85c1b9d6f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4558:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4558D57E3A48C7698508797A953F0@SA0PR12MB4558.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvY4NjNDd7Jqy2hqO1DitEWL34AzfqtU0/a8HnXiYArUgeoN9JhqjT4mqKTnebaF/5teRMmZItJscg3gcpgoYCejKQmGTC59YKwrQaNHY2A4z7AcPW6C94dkQMxHi1v/YhUWZyNamhNRSkkT2Sb5wDxq40sryTl5qtfbIz6Eh6TKxlIgD7P3zAY0akquq5nSDAoFxQs3fI3Jt4rRU3Q0dZLmr5ODEZEVNVXFL/Je8oVhGKQrjrCymXZXEyTdNHX25pZRN4Vs+Pdk16fjB9zzcEVFdBIkYY33sD+rpTSy/lg+5fEBgVZXctkz71W46tu26aiktiPaS0pujcaJ65ikWAZ7/4t+E/rshedooJQJtckMWYoG6P8QjR2wOAuEQNFWuLBVpXvKTQY5hJMUOCvF3khUCQ1Ycqx0etaalHDM9pgYTUlyFYW39QlDh+FbfuqsHXxb0Lb5ZEDZOCXsGDT64Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(6916009)(2906002)(16576012)(31696002)(8936002)(6486002)(8676002)(2616005)(478600001)(66946007)(66556008)(86362001)(31686004)(52116002)(45080400002)(44832011)(316002)(26005)(36756003)(53546011)(16526019)(5660300002)(966005)(4326008)(66476007)(186003)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7f7rWtj1Ma4hhXsTsiRg3UlrEKdYO9UkVu5wgVtfkF5CcVJuTIKUyqw5TxHaDffm6/n6jloMpR6RRFjzMYOBrJx5kRFBPMMZLws5lZIyx9KRQ+VSBuDTcKzF4kphDLBVqtVkHSb06wUYRbmkCnRPEOtT6V5dn8y+XJaEzKBg9yjKf+QVd/ahxY5zR/DSWTnn5kvDfzL2+V1PNswt5SsEzqyaQ5f8zDTaldB6/OeuZPOs/VpKi5/cGZrjFomgFCNv2eYOeNJEWKU9JQksAac0iNxLq/Efbd07Ct7TUQCQ9cjMn//gquPY3CKBG1v5axJNAVADBPCytlkRgj8CcylaPvrBAuzwaOGWg1N8mqzYTwLcYMv5pn43Qtm1KlKdlzIz2knRNL9pgMxTorTC1hx00A2/fUqoeFlxhZ3XaFA3JAfH7sqYQci+ktqBqxv0Gc/nHw/YAUZBTaOwnmf56cnngBJbh2Dz1JT/yScoObWLHmm38G4U4hGksGvrHMkeGwFm3/Gb+hd/6QfsV7oVwT/cK1dYRNreQo2n50h1P/ovVcwBBJ2attdk8wGijt9Hgpzp2xjnQgtWvyhrqPBgLhNZdeJVQlBZ+Uy7Vy2kpKCiTBNwB/cFZfpQ00zLUi8gkCxggi13PPsitWsWfo1h6p4C+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3087111f-05bb-4bb5-1540-08d85c1b9d6f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 21:41:35.6655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE2mxkVTJiK0rZOfqYWAbznOZBenURmqRUu1AuGubJql+YcZOBIHB1SiJ5BGQ2r1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4558
Received-SPF: none client-ip=40.107.92.89; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 17:56:37
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, imammedo@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/18/20 4:38 PM, Eduardo Habkost wrote:
> On Mon, Aug 31, 2020 at 01:43:07PM -0500, Babu Moger wrote:
>> apic_id contains all the information required to build
>> CPUID_8000_001E. core_id and node_id is already part of
>> apic_id generated by x86_topo_ids_from_apicid.
>>
>> Also remove the restriction on number bits on core_id and
>> node_id.
>>
>> Remove all the hardcoded values and replace with generalized
>> fields.
>>
>> Refer the Processor Programming Reference (PPR) documentation
>> available from the bugzilla Link below.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C3d768d58412043311f8208d85c1b2432%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637360619193685138&amp;sdata=NEWhmXx4QbtPv9XVFOqw1i3AbSm74qjC%2FqZXU9E0BJ0%3D&amp;reserved=0
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> [...]
>> @@ -6019,7 +5914,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>          break;
>>      case 0x8000001E:
>>          assert(cpu->core_id <= 255);
> 
> I assume we still want to remove this assert()?  Do you plan to
> redo and resubmit

Sure. I will resubmit it.

