Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D998C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C662B20693
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="H/lL3lYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C662B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2IX-0005PS-0U
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jC1wu-0000Kg-Qw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jC1wt-0001DA-FQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:03:04 -0400
Received: from mail-bn3nam04on0624.outbound.protection.outlook.com
 ([2a01:111:f400:fe4e::624]:60198
 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jC1wt-00017H-4A
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPGYOf5ncg29gEuzx+izWeJt7qL5LRjhfgh18zLZOSPUflR3OeXWTg18j9huU6DI3jMVqTmrif+I+KlJ4+YN1kfdYXhVzEAOldRIOuHdpRIqNEwSYcLQDt9ZnBJfk+IMhkKvRcxzpdd9yj54CdU3z/VrRNVkbl5uHFe5OnjPD7NkbtGvUYJ9P6elgOE1npx3pP588Z3dE9N5vET3R3/tmrKJiRp8C1/JK2OYeKqVJotEiIjFfPM41JaD7W+Qlgmb9qx4S/MfZjLiaPFBQvCj0ssNQXY6L73fFOwl5bvKf/xuz7sU0nb7RjWKSJvxJx7uyxfhFHWc768zl8qd9W7qNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKeZ56dxyHdVyDeWgO3SOh7kypR0xgQvACYaHyBfZtA=;
 b=Rk0KvQSvi2A7/jnw/xATLiGmwdZdm/DQbGb5tbcKRIZIjOQnZOHDR0KeUOqkGFhd9ICH7yCJ3tcvHdvqHOQDtxG4hIRGRHRb68qz9MJM1AtxY+rfYAPMyT7Jdjx6W/213lCWnTwnhjr3xb2wGsvZLx7WHOnYxn4AIGYv0mkZpWGzy5FdLo8iro3NoAUK3BEz+oEL+88Kn+UZYis9pKs203TtnwXq/FZbkCQb0yTUmUlc/fGYZnb2jc34REUPanhdM32+szkDxBl7+hEKfTlP8ILzTMJ4u4XlAyhV+tERvbd74TBPyRDwyRaPKxMFqhoCV2f93uJd92BLQPU7CmwQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKeZ56dxyHdVyDeWgO3SOh7kypR0xgQvACYaHyBfZtA=;
 b=H/lL3lYt6tv4VIPFyBk+el6WoKtAswOPtODvsfcwb2vhMtZh9fZBTRR1Px8YfgDabgHB+4BszCnXDEvY5Rj95jAYx/af5u75NSPa2RwfVsG8PtSGirJ+8R6e1cGGSMb0CYdbexM2PEe6Xfrk7VHz14s0fx1jmC57yLV694plPDk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 14:03:01 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 14:03:01 +0000
Subject: Re: [PATCH v6 01/13] hw/i386: Introduce X86CPUTopoInfo to contain
 topology info
To: Igor Mammedov <imammedo@redhat.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
 <158389400579.22020.10755767480575663831.stgit@naples-babu.amd.com>
 <20200311123955.29a4c0d1@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <f506eba6-49b9-041e-80a3-58a3968beb93@amd.com>
Date: Wed, 11 Mar 2020 09:02:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200311123955.29a4c0d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:3:7b::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:3:7b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.9 via Frontend Transport; Wed, 11 Mar 2020 14:02:59 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bc842ce-45c6-4885-efb5-08d7c5c4e8a0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23665BBC3EE2A2A7BD13951895FC0@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(8676002)(31696002)(66476007)(66556008)(81166006)(66946007)(316002)(86362001)(2906002)(478600001)(16576012)(4326008)(81156014)(52116002)(6486002)(966005)(36756003)(53546011)(2616005)(956004)(44832011)(8936002)(5660300002)(31686004)(26005)(6916009)(186003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2366;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCWUzlGlpHYdujHwabl9WKK6/j/+V0uFH3p21vuyPIw7awCOdKUzLxsm+AGiE3drVrN3Xrt67aMvMfo5PMJs8tLLCsN8/gdZv0QpnZCBv1qoozb3BUCoQLL3L2hKjpo4AIbstaipFtoArxRO5YS1CSj+9wu4Tnf/68VQf0bnNva9pFIwbPP7bZvU9kxceoeeDgq+V8vnARPr6QM9YnL7ZBUB8nfzPWXMcA/3pILG7HvQP/1x6Jxci1zcA2o3A37d43krGMRHBeWZkDtTW9osuQOtKuZzFoDmCVPOrTy0Tv1RTnT9UtIdUvri7R2grQxG3VSRuOOLRr1zbnCUSwxHAJYsLx5qoDRJunwWqrwrHnVLV/obiX53ePaLcvhJseGWAqOb5BWrNSXvinrUa7suO/tl80m0rmWCbVqw13YXPyJGOvU0wSMUp3sk6VKixXz2036mtEoWS8A3alAzqL8NTWga2hVD9NSQU0N7T9h5jg4iH237kQvd4LjL51SRablwY3t0tpoUQCq21n2IvliPkA==
X-MS-Exchange-AntiSpam-MessageData: iDtqpZZxK08UUjlxuLZ87y2RJZes3QyY9Z1NnI+d5QwktA5EPJEEV/SDznA8KZRJeMskhhmhepEY//vNVrp3sqpjtCAbf8h35SJv3GJWEYybiB87oRB1MrHYkUJbUJjKpG1RKIhmHJ0VH2b3gllJPg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc842ce-45c6-4885-efb5-08d7c5c4e8a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 14:03:00.8614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KynPeQvBuZa6I+b2AkGZKC8DDAPnQKWeOwSHYRaX2xbKo8SRn8PSEKLK/3Y1JcnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe4e::624
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/11/20 6:39 AM, Igor Mammedov wrote:
> On Tue, 10 Mar 2020 21:33:25 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> This is an effort to re-arrange few data structure for better readability.
>>
>> 1. Add X86CPUTopoInfo which will have all the topology informations
>>    required to build the cpu topology. There is no functional changes.
>>
>> 2. Introduce init_topo_info to initialize X86CPUTopoInfo members from
>>    X86MachineState.
>>
>> 3. Update x86 unit tests for new calling convention with parameter X86CPUTopoInfo
>>
>> There is no functional changes.
> 
> patch doesn't apply to current master, so I can't really test it

I generated the patches on top of Eduardo's tree.

It should work if you apply after this patch.

https://lore.kernel.org/qemu-devel/158326541877.40452.17535023236841538507.stgit@naples-babu.amd.com/

Do you want me to generate on top of master ?

>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  hw/i386/pc.c               |   12 ++++++------
>>  hw/i386/x86.c              |   32 ++++++++++++++++++++++++--------
>>  include/hw/i386/topology.h |   38 ++++++++++++++++++++++++--------------
>>  include/hw/i386/x86.h      |    3 +++
>>  tests/test-x86-cpuid.c     |   43 ++++++++++++++++++++++++-------------------
>>  5 files changed, 81 insertions(+), 47 deletions(-)
>>
> [...]
>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>> index 322fb6abbc..03b8962c98 100644
>> --- a/hw/i386/x86.c
>> +++ b/hw/i386/x86.c
>> @@ -57,6 +57,16 @@
>>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>>  static size_t pvh_start_addr;
>>  
>> +inline void init_topo_info(X86CPUTopoInfo *topo_info,
>> +                                  const X86MachineState *x86ms)
> 
> not aligned properly

Will fix it.

> 
> [...]
> 

