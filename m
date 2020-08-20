Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4C0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C5420758
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yFvW7iFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C5420758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mgB-0004BE-LS
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k8mQC-0003ob-Nj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:24:08 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com
 ([40.107.93.72]:1043 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k8mQ9-0008RZ-Su
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWwYrFb9AVq86H+/UwLbIJeFmw3EjQ5UzgK4cEmVavriXLzqdPsjjXlDC3IejCY8ek2MsB/eYABU9W8sZkYllL8X1RsySET6uRraqYsMGS1yzotK5Mi4SF+T452Mh6bNitfVo6tK5oEdR1/B/3PlJfYUS+RAh7stU2ac9+IvkxPJA7BQEMTQw+g8wbxZh9rIRzg81Ou3XW8/M+Unx9buHnvhXE/ZA0VGFDRMbEJRZ0dic0Ta+KD3VT33qiNMQxiVXdQJrQN4+iWWT8m7Y1ExQZJCT7e4FTDzDVvzPb9+/nbfh+gK/dZ6XedFdsY5nUII/6gpeZhHJJB2i+suQ6GWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqvZ/KV5nRIeNeRt1yJ1LiTZqveXdhsRhfX+UaqtMbk=;
 b=TfAB82fDAjeqSszyyCUt9yg8sMHeaqxs33XikcsRZb4v7Li1RSewwRtGBD8JFlFQDWtORIECA1T/KfKJB2wCh9/tX0RFpD51Ca2LFA+kaPaoW2hZ0PDPZaSKLofTfAbj2shCwjtBop9AMyY6xyKKiJ86XMlZy6xQfX634BFC7p9uWMyt0bdBlBAtVdIjipHzLY+G4GM+yUQ7xm6MjYcnhy9fKKTsGI3TJKpB7PMSCMr0mW3eVNS5AFIVcLHxndfWyLYZqXuzn8sciCrGWlbaoQkXTTDJSjauEVO9NPpg/aXb+tmqXZ5t8Nkv9UKNfwnMe/qGg5Hjf6LROf/tMKBEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqvZ/KV5nRIeNeRt1yJ1LiTZqveXdhsRhfX+UaqtMbk=;
 b=yFvW7iFAa7UpgG4hB0x3ZVdOtFEnE2E6yaXhA0KFuAq0a+nAebxrM7vshZ+HC/FmeXvGvJs0Pd8eXrqXAuHAM1uXxac77Molw0GCs/jJbXchrkzbIyzPHMUxt39tHLFYngGi+FKZz4flWgLofzbp/WZti8UraPV6oay+qL31HNc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 20 Aug
 2020 15:24:03 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 15:24:03 +0000
Subject: Re: [PATCH v4 3/3] hw/i386: Remove node_id, nr_nodes and
 nodes_per_pkg from topology
To: Igor Mammedov <imammedo@redhat.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
 <159744118012.39197.535122421806420639.stgit@naples-babu.amd.com>
 <20200819141852.22743dff@redhat.com>
 <2709427a-33e5-c6ad-7ebe-8af889f39604@amd.com>
 <20200820145757.2aa8752d@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <c0bcc1a6-1d84-a6e7-e468-d5b437c1b254@amd.com>
Date: Thu, 20 Aug 2020 10:24:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200820145757.2aa8752d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0005.namprd07.prod.outlook.com
 (2603:10b6:803:28::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0701CA0005.namprd07.prod.outlook.com (2603:10b6:803:28::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 15:24:02 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 526c9739-32ab-4569-8b59-08d8451d11e1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-Microsoft-Antispam-PRVS: <SA0PR12MB452881BA0078DDBC6E17FE0B955A0@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0uVQoamAn9TDEi4P+7IsLykpf9zvfQ37Pa/Le0uznev1F6DJJNk0K7fQhxHVbCQMtf0CzeDvP/JOtcOsYiA169a65g8MLqXqwRJzErCYTRJ1ta044BPVucsSS6PD1LoODYKOL5LV2cRU/zwRD8heFd9A8ECZPsCNuKrryoK7pmuQGdnfIV3L69zSSj8J9EphBKtGKIFBkpgPtIyWM0ZYBsgPGZkpLnTni82V9OcJNRodSYuTWR9Nqu4lrVcaSZIdZEysRJCeYlNrJ9djeNM5FWnD1lUg16gfrH3htwx79oVECJJGm+3hIfaEi7Rplgriu0v50nbpQlaMrv78SMNVXLAUKjN5SJWe0U9aGcOxCqoPBMws28U1eYSsVqCBkD9PvWeSH4cTKROU70Lz8sjFh7+MvX82o8tS/B11+svM4Gb0HwgfNdiw/N4pMyIbZxPmArpRrFX44bOc7YuOFRvn6uV3CYzZF7BGjMj0GZddV1vkreoUaUE569ZlK0Scxnm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(8676002)(83380400001)(6916009)(26005)(53546011)(45080400002)(6486002)(31696002)(8936002)(36756003)(86362001)(956004)(66946007)(66556008)(66476007)(186003)(44832011)(2616005)(2906002)(478600001)(110011004)(966005)(52116002)(30864003)(5660300002)(4326008)(16576012)(316002)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ybuHBmMvgvx7+rfWq90vkiMJlRPZhVcjD+qWOHur2T7chdfSE5glnHuiiuZ6f1HnASo315UoX1j97PiXkGsjKgVx1K8n+AngbUokblIpqQ/MHTy+ZVyQJx5eH31r/cUdH6C/1E4VWRag8ylw0ZWXckFqadpcWfBB4OA0a+mnmCJ/RgIZDErqREBpgxrodnBKSiFJ/HrFSY2b3B5T8PCIbhFS6Lt3PPonogkOR/7/w2c6ymdKDfTYDUqAltX0NbCMkRFSkXRnRPlh0VcnTka7xC8tiCjU10mPxqN3KVsWvGBxKrX97Yti/r76e82GXwDHtw7kge+iy3eJP19Bmf0skvkFbslcGW+Eavrb//15RFZv1C+kri3inz8U4JDLK1J3gcrCIEiWz21t0TAggWdeRFNa7ZAMFNzF8jcsOj7/m35HyEWX5LWwy/esrV7qtQBpweMUaLRYWPAoU/K4VjLBiPtn/lDgvcOa6lFW6/7W8NLarsdP4FBBt4o9MGOyp7uX0o2geNqOpqF53BLHaNPbwmn9nYa9fbReVXQCTY1MLmeSiEpjMANN+reRkh3QxphAhe1Lq+dfWKZ6juqJ50tI47MgERhWAQu6UyrvMs+xq0cHK+2SgmZz/l1g5etlaXw8auwJhJnDlk5gaAxO8T4D3w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526c9739-32ab-4569-8b59-08d8451d11e1
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 15:24:03.2815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inHKGj6HAo3Lvnc6+dse4TFGPGyzdYICIydj0QXihDbuEP7lRSTG2vPhLMaaBWDf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
Received-SPF: none client-ip=40.107.93.72; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 11:24:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/20/20 7:57 AM, Igor Mammedov wrote:
> On Wed, 19 Aug 2020 17:42:58 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
>> On 8/19/20 7:18 AM, Igor Mammedov wrote:
>>> On Fri, 14 Aug 2020 16:39:40 -0500
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>   
>>>> Remove node_id, nr_nodes and nodes_per_pkg from topology. Use
>>>> die_id, nr_dies and dies_per_pkg which is already available.
>>>> Removes the confusion over two variables.
>>>>
>>>> With node_id removed in topology the uninitialized memory issue
>>>> with -device and CPU hotplug will be fixed.
>>>>
>>>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1828750&amp;data=02%7C01%7Cbabu.moger%40amd.com%7Cf7ad03f0c04d44dd104c08d84508b0b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637335250919794679&amp;sdata=JT8rq3Ag29WMgD8p2v2tm%2Fmdo8nBnLHb8V7QUbCHCLs%3D&amp;reserved=0
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>>  hw/i386/pc.c               |    1 -
>>>>  hw/i386/x86.c              |    1 -
>>>>  include/hw/i386/topology.h |   40 +++++++++-------------------------------
>>>>  target/i386/cpu.c          |   11 +++--------
>>>>  target/i386/cpu.h          |    1 -
>>>>  5 files changed, 12 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index 47c5ca3e34..0ae5cb3af4 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -1498,7 +1498,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>>>      init_topo_info(&topo_info, x86ms);
>>>>  
>>>>      env->nr_dies = x86ms->smp_dies;
>>>> -    env->nr_nodes = topo_info.nodes_per_pkg;
>>>>      env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
>>>>  
>>>>      /*
>>>> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
>>>> index e90c42d2fc..4efa1f8b87 100644
>>>> --- a/hw/i386/x86.c
>>>> +++ b/hw/i386/x86.c
>>>> @@ -62,7 +62,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>>>>  {
>>>>      MachineState *ms = MACHINE(x86ms);
>>>>  
>>>> -    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
>>>>      topo_info->dies_per_pkg = x86ms->smp_dies;
>>>>      topo_info->cores_per_die = ms->smp.cores;
>>>>      topo_info->threads_per_core = ms->smp.threads;
>>>> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
>>>> index 07239f95f4..05ddde7ba0 100644
>>>> --- a/include/hw/i386/topology.h
>>>> +++ b/include/hw/i386/topology.h
>>>> @@ -47,14 +47,12 @@ typedef uint32_t apic_id_t;
>>>>  
>>>>  typedef struct X86CPUTopoIDs {
>>>>      unsigned pkg_id;
>>>> -    unsigned node_id;
>>>>      unsigned die_id;
>>>>      unsigned core_id;
>>>>      unsigned smt_id;
>>>>  } X86CPUTopoIDs;
>>>>  
>>>>  typedef struct X86CPUTopoInfo {
>>>> -    unsigned nodes_per_pkg;
>>>>      unsigned dies_per_pkg;
>>>>      unsigned cores_per_die;
>>>>      unsigned threads_per_core;
>>>> @@ -89,11 +87,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
>>>>      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
>>>>  }
>>>>  
>>>> -/* Bit width of the node_id field per socket */
>>>> -static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
>>>> -{
>>>> -    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
>>>> -}
>>>>  /* Bit offset of the Core_ID field
>>>>   */
>>>>  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
>>>> @@ -114,30 +107,23 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>>>>      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>>>>  }
>>>>  
>>>> -#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
>>>> +#define EPYC_DIE_OFFSET 3 /* Minimum die_id offset if numa configured */  
>>>                                                       ^^
>>>
>>> from EPYC's pov NUMA is always configured, there no 'if'
>>>
>>> but I have a question, is it possible to drop EPYC_DIE_OFFSET
>>> and reuse apicid_die_offset(), will it break something?  
>>
>> Yes. I am also thinking about it. We can go back to existing
>> apicid_die_width().
> 
> Given we are using die_id now, we probably can get rid of all
> topo hooks to generate apicid.

Sure. Will start working on it.  thanks

> 
>> Looking back again, I think all these code changes related to node_id is
>> causing more issues than fixes. We have added all these code to handle
>> some non- SPECed configurations like
>>  https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=02%7C01%7Cbabu.moger%40amd.com%7Cf7ad03f0c04d44dd104c08d84508b0b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637335250919794679&amp;sdata=pOGISuQdHxFm5dEjybkGuDHfPCO1QqwE%2B%2FHR0fOAqnQ%3D&amp;reserved=0.
>>
>> Going forward it might create even more issues. Now, I think we should go
>> back and remove all these changes and just use the default decoding. Most
>> of the SPECed configuration would work just fine. With some non-SPECed
>> user inputs, it will create some sub-optimal configuration. If we can live
>> with that we will be just fine. I did not anticipate all these problems
>> when I originally started this work. Sorry, my bad.
> 
> Topology code is complex and sometimes it's easier to add a new thing,
> it's just that not every time it turns out as expected.
> We overlooked posiblilty to reuse die-id, which has lead to more
> complex and fragile outcome.
> 
> But it's fine, as long as it gets fixed in the end.

Sure. Thanks.

> 
> 
> 
>>> The reason for question is that, we (deviating from spec)
>>> do allow for unbound core/threads number so die_id, already could
>>> be shifted beyound ApicId[5:4], likewise we do allow for unbound
>>> sockets so ApicId[6] is also out of spec.
>>> If we are fine with ApicId being encoded in these cases out of
>>> spec, then why should we insist on DIE_OFFSET minumum at all?
>>> Why not just allow existing apicid_die_width() to encode die_id?
>>>
>>> In this case it will produce SPECed ApicId if user has provided
>>> -smp that matches currently released EPYC's and in all other cases
>>> it will be out of spec ApicId like when we set sockets/cores/trheads
>>> to out of spec values.
>>>     
>>>>  /*
>>>> - * Bit offset of the node_id field
>>>> - *
>>>> - * Make sure nodes_per_pkg >  0 if numa configured else zero.
>>>> + * Bit offset of the die_id field
>>>>   */
>>>> -static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
>>>> +static inline unsigned apicid_die_offset_epyc(X86CPUTopoInfo *topo_info)
>>>>  {
>>>> -    unsigned offset = apicid_die_offset(topo_info) +
>>>> -                      apicid_die_width(topo_info);
>>>> +    unsigned offset = apicid_core_offset(topo_info) +
>>>> +                      apicid_core_width(topo_info);
>>>>  
>>>> -    if (topo_info->nodes_per_pkg) {
>>>> -        return MAX(NODE_ID_OFFSET, offset);
>>>> -    } else {
>>>> -        return offset;
>>>> -    }
>>>> +    return MAX(EPYC_DIE_OFFSET, offset);
>>>>  }
>>>>  
>>>>  /* Bit offset of the Pkg_ID (socket ID) field */
>>>>  static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
>>>>  {
>>>> -    return apicid_node_offset_epyc(topo_info) +
>>>> -           apicid_node_width_epyc(topo_info);
>>>> +    return apicid_die_offset_epyc(topo_info) + apicid_die_width(topo_info);
>>>>  }
>>>>  
>>>>  /*
>>>> @@ -150,8 +136,7 @@ x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>>>>                                const X86CPUTopoIDs *topo_ids)
>>>>  {
>>>>      return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
>>>> -           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
>>>> -           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
>>>> +           (topo_ids->die_id  << apicid_die_offset_epyc(topo_info)) |
>>>>             (topo_ids->core_id << apicid_core_offset(topo_info)) |
>>>>             topo_ids->smt_id;
>>>>  }
>>>> @@ -160,15 +145,11 @@ static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
>>>>                                                unsigned cpu_index,
>>>>                                                X86CPUTopoIDs *topo_ids)
>>>>  {
>>>> -    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
>>>>      unsigned nr_dies = topo_info->dies_per_pkg;
>>>>      unsigned nr_cores = topo_info->cores_per_die;
>>>>      unsigned nr_threads = topo_info->threads_per_core;
>>>> -    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
>>>> -                                            nr_nodes);
>>>>  
>>>>      topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
>>>> -    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
>>>>      topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
>>>>      topo_ids->core_id = cpu_index / nr_threads % nr_cores;
>>>>      topo_ids->smt_id = cpu_index % nr_threads;
>>>> @@ -188,11 +169,8 @@ static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
>>>>              (apicid >> apicid_core_offset(topo_info)) &
>>>>              ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
>>>>      topo_ids->die_id =
>>>> -            (apicid >> apicid_die_offset(topo_info)) &
>>>> +            (apicid >> apicid_die_offset_epyc(topo_info)) &
>>>>              ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
>>>> -    topo_ids->node_id =
>>>> -            (apicid >> apicid_node_offset_epyc(topo_info)) &
>>>> -            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
>>>>      topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
>>>>  }
>>>>  
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index c892432cae..ba0a24f6b8 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -345,7 +345,6 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>>>                                         uint32_t *ecx, uint32_t *edx)
>>>>  {
>>>>      uint32_t l3_cores;
>>>> -    unsigned nodes = MAX(topo_info->nodes_per_pkg, 1);
>>>>  
>>>>      assert(cache->size == cache->line_size * cache->associativity *
>>>>                            cache->partitions * cache->sets);
>>>> @@ -355,10 +354,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>>>>  
>>>>      /* L3 is shared among multiple cores */
>>>>      if (cache->level == 3) {
>>>> -        l3_cores = DIV_ROUND_UP((topo_info->dies_per_pkg *
>>>> -                                 topo_info->cores_per_die *
>>>> +        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
>>>>                                   topo_info->threads_per_core),
>>>> -                                 nodes);
>>>> +                                 topo_info->dies_per_pkg);
>>>>          *eax |= (l3_cores - 1) << 14;
>>>>      } else {
>>>>          *eax |= ((topo_info->threads_per_core - 1) << 14);
>>>> @@ -387,7 +385,6 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>>>                                         uint32_t *ecx, uint32_t *edx)
>>>>  {
>>>>      X86CPUTopoIDs topo_ids = {0};
>>>> -    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
>>>>  
>>>>      x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
>>>>  
>>>> @@ -433,7 +430,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
>>>>       * NodeId is combination of node and socket_id which is already decoded
>>>>       * in apic_id. Just use it by shifting.
>>>>       */
>>>> -    *ecx = ((nodes - 1) << 8) | cpu->node_id;
>>>> +    *ecx = ((topo_info->dies_per_pkg - 1) << 8) | cpu->node_id;
>>>>      *edx = 0;
>>>>  }
>>>>  
>>>> @@ -5484,7 +5481,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>>      uint32_t signature[3];
>>>>      X86CPUTopoInfo topo_info;
>>>>  
>>>> -    topo_info.nodes_per_pkg = env->nr_nodes;
>>>>      topo_info.dies_per_pkg = env->nr_dies;
>>>>      topo_info.cores_per_die = cs->nr_cores;
>>>>      topo_info.threads_per_core = cs->nr_threads;
>>>> @@ -6944,7 +6940,6 @@ static void x86_cpu_initfn(Object *obj)
>>>>      FeatureWord w;
>>>>  
>>>>      env->nr_dies = 1;
>>>> -    env->nr_nodes = 1;
>>>>      cpu_set_cpustate_pointers(cpu);
>>>>  
>>>>      object_property_add(obj, "family", "int",
>>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>>> index e1a5c174dc..4c89bee8d1 100644
>>>> --- a/target/i386/cpu.h
>>>> +++ b/target/i386/cpu.h
>>>> @@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
>>>>      TPRAccess tpr_access_type;
>>>>  
>>>>      unsigned nr_dies;
>>>> -    unsigned nr_nodes;
>>>>      unsigned pkg_offset;
>>>>  } CPUX86State;
>>>>  
>>>>
>>>>  
>>>   
>>
> 

