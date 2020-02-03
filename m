Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45EDC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 21:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9E920838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 21:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0NM2LRLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9E920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyjc4-0007MW-Sx
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 16:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iyjbA-0006rr-Dj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iyjb8-0001AJ-Pk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:49:40 -0500
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com
 ([40.107.244.61]:6139 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iyjb8-00012C-Ec
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:49:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6oUFIH9tmHZpprGMnrowvQsU8rvx8Y8pGU/FYb+Gy7ji1oPcCoGDh+FhgO0w7//V4OcsZJ5EZRcv9TO0BY15jdZtsjkW5Lu2SFLYU4UmctjQlOWeQ9PX6OAYNzQmIwT+C/RkmChvFRx4yo/6SYdoO0x5W/rTpykul/yyhzHPI72lLQdovdR6wUGYe9P9IG9f+GLdpRvM4aWyXSnhCR31QM52no6hU8KHfoM6dQU7F7KXyhYeGc/Rl4LSo3aRKCMsq5ELi6eZ+XxYksvRGkjtmSsp383v80UGuPQDpdtGaVZKaA3kosuyplD0BUI9Ox9cyyq/hCCoPUoRaqULGS2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK+RkKemLKkxufSXDXGSxYz4dSyelA51uCZDJnFomm4=;
 b=mAlfYxVmoFWUHxU4oqac0EqPbkDLHSrq1lJCmh8gWw/DU/VgLxV/jUQWk3vjpKML1kcPDPnImKCacHQQzIUEQ5Wfw0MmnIcXkxHAGK7HatHP1xlOfiSr0aSLPbqmSvLPxogyCuJQxzleDV/P+sSXMvAVLFY4jCIM0GsCD2qNkOCSzKdkA1/yaFwYiWedmh6fZd6eGN3Sdyq9Ed2DksD3LlX/0PV8iSVyB4q7MrmJKiIIltCM21dDQdXYuwshfG77XPTQ59WQmQbEDUnVMjDUjxUmNtdh4VM5Ut7i9AJLDC8qvVsd9NaQjdpblJN9OhQ4+hNh/9Z65h2tdBAy6i3Ynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sK+RkKemLKkxufSXDXGSxYz4dSyelA51uCZDJnFomm4=;
 b=0NM2LRLpqaGPX9NUGHrFSeTnGkUNOSd7GbzZxoz1Df/w2FdYqZ89BePF+B3NSHqYd0HjkNKAbunhLtIl+xXDN2ip4lNLA94FEe6j/97gHNwEQEHNkR468PkbEamUwxdy/6qYZ7daXh12pV+trG5meGosC0tZBS+qPCBvT7cO4B0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1749.namprd12.prod.outlook.com (10.175.60.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Mon, 3 Feb 2020 21:49:33 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 21:49:33 +0000
Subject: Re: [PATCH v3 07/18] machine: Add a new function init_apicid_fn in
 MachineClass
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541986210.46157.5082551407581177819.stgit@naples-babu.amd.com>
 <20200128172919.4ecb5896@redhat.com>
 <e5271e1c-55bc-e3d2-eb4c-2329eef07c9f@amd.com>
 <20200129101458.6a108431@redhat.com>
 <b75928ec-c062-7edf-bc24-8dc0ccd7439b@amd.com>
 <20200203161758.3eb85046@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <192836b5-bd1c-0ad5-b650-e33c6e3bc84d@amd.com>
Date: Mon, 3 Feb 2020 15:49:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200203161758.3eb85046@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR12CA0013.namprd12.prod.outlook.com (2603:10b6:4:1::23)
 To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR12CA0013.namprd12.prod.outlook.com (2603:10b6:4:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29 via Frontend Transport; Mon, 3 Feb 2020 21:49:32 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ff676ae-d92d-4b4a-a088-08d7a8f2f440
X-MS-TrafficTypeDiagnostic: CY4PR12MB1749:
X-Microsoft-Antispam-PRVS: <CY4PR12MB17490574199B5AF9A2040BBE95000@CY4PR12MB1749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(16526019)(53546011)(186003)(6486002)(44832011)(2616005)(4326008)(36756003)(66476007)(31696002)(5660300002)(66556008)(86362001)(956004)(26005)(66946007)(45080400002)(6916009)(966005)(31686004)(16576012)(8936002)(316002)(8676002)(81166006)(2906002)(478600001)(81156014)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1749;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w9bnAaEUEkbQRChAcEE0vFEWJp7LYHVJPxbFgZLq8Qs51vniMmQVwFx8+DEOHSGj24SsufezFCHCNfM0rV1biClkeoM6OenBGT7U7wwX27KemMH2AfxsFU4M557oPmJ7ZlDpsOR+nL6hMamC9KEiUNZOmJ5AdT2vjzan40N54+pWHrNpFkR4A8KZOt24SQZi2M85gvvvwqZqiqSiViDPSCZ6svZR5xoK2syvJViZQB0A9wca5XAX8aucypLeRhM3/4L/LXsaHThUdWhgCLsgJ8A+fvANpyH0wwSy/90w1CBSnByrvAo+bb/dcscPgstVUa+wirondhZ2DifBXMQU33uiw7R36WRoO85Q8ao+mzK8QfWJIXfQeODusMh5nm3hc7NL9EoZEkUo5xvYg32kbOF91me/F6ScDreghdta18Wxde+NTzQKXTDsEbpprgamNbxhLLPSDUuziMVMRI4O3GDkzpx8a+FM0SIanWHpr5ePWGSQdIBHPmb/MyhiJ/HbJWjcXl7w5OnKGD9s3hlBOA==
X-MS-Exchange-AntiSpam-MessageData: rFA+otNR0Cf710RjITUz0VYdGZlt2ZjhgJqiQA/dAFzqEqoxFtmY2GGrFx61oiFztirdG+bX57Qrg1ZoXyI9QR3EfhUHKvPaGvmEFLmgdMIbY1YJKLj1CAWtucgmOpoYlADsZdO3vJTxmRM+Nqs8Tw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff676ae-d92d-4b4a-a088-08d7a8f2f440
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 21:49:33.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54Zi3GsDDBY1DdFUqRnW+5EIn4ybyTWzbhmqp6epr8hLRtBFDUGTjMSadkjjXEmu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1749
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.61
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
 armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/3/20 9:17 AM, Igor Mammedov wrote:
> On Wed, 29 Jan 2020 10:17:11 -0600
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> On 1/29/20 3:14 AM, Igor Mammedov wrote:
>>> On Tue, 28 Jan 2020 13:45:31 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>   
>>>> On 1/28/20 10:29 AM, Igor Mammedov wrote:  
>>>>> On Tue, 03 Dec 2019 18:37:42 -0600
>>>>> Babu Moger <babu.moger@amd.com> wrote:
>>>>>     
>>>>>> Add a new function init_apicid_fn in MachineClass to initialize the mode
>>>>>> specific handlers to decode the apic ids.
>>>>>>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> ---
>>>>>>  include/hw/boards.h |    1 +
>>>>>>  vl.c                |    3 +++
>>>>>>  2 files changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>>>> index d4fab218e6..ce5aa365cb 100644
>>>>>> --- a/include/hw/boards.h
>>>>>> +++ b/include/hw/boards.h
>>>>>> @@ -238,6 +238,7 @@ struct MachineClass {
>>>>>>                                                           unsigned cpu_index);
>>>>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>>>>>>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>>>>>> +    void (*init_apicid_fn)(MachineState *ms);    
>>>>> it's x86 specific, so why it wasn put into PCMachineClass?    
>>>>
>>>> Yes. It is x86 specific for now. I tried to make it generic function so
>>>> other OSes can use it if required(like we have done in
>>>> possible_cpu_arch_ids). It initializes functions required to build the
>>>> apicid for each CPUs. We need these functions much early in the
>>>> initialization. It should be initialized before parse_numa_opts or
>>>> machine_run_board_init(in v1.c) which are called from generic context. We
>>>> cannot use PCMachineClass at this time.  
>>>
>>> could you point to specific patches in this series that require
>>> apic ids being initialized before parse_numa_opts and elaborate why?
>>>
>>> we already have possible_cpu_arch_ids() which could be called very
>>> early and calculates APIC IDs in x86 case, so why not reuse it?  
>>
>>
>> The current code(before this series) parses the numa information and then
>> sequentially builds the apicid. Both are done together.
>>
>> But this series separates the numa parsing and apicid generation. Numa
>> parsing is done first and after that the apicid is generated. Reason is we
>> need to know the number of numa nodes in advance to decode the apicid.
>>
>> Look at this patch.
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fqemu-devel%2F157541988471.46157.6587693720990965800.stgit%40naples-babu.amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C0a643dd978f149acf9d108d7a8bc487a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637163398941923379&amp;sdata=sP2TnNaqNXRGEeQNhJMna3wyeBqN0XbNKqgsCTVDaOQ%3D&amp;reserved=0
>>
>> static inline apic_id_t apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>> +                                                  const X86CPUTopoIDs
>> *topo_ids)
>> +{
>> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
>> +           (topo_ids->llc_id << apicid_llc_offset_epyc(topo_info)) |
>> +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
>> +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
>> +           topo_ids->smt_id;
>> +}
>>
>>
>> The function apicid_from_topo_ids_epyc builds the apicid. New decode adds
>> llc_id(which is numa id here) to the current decoding. Other fields are
>> mostly remains same.
> 
> If llc_id is the same as numa id, why not reuse CpuInstanceProperties::node-id
> instead of llc_id you are adding in previous patch 6/18?
> 
I tried to use that earlier. But dropped the idea as it required some
changes. Don't remember exactly now. I am going to investigate again if we
can use the node_id for our purpose here. Will let you know if I have any
issues.

