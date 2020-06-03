Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD8920679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CbSgS0cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD8920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVUh-0007FJ-QW
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgVTi-00067x-N2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:38:54 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com
 ([40.107.244.54]:55392 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jgVTg-0003l8-Sr
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:38:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3g6zFoLaeQHz/v1x/H9o9pO/p379cs65ju1V3Rkx3qxFjfxoRK4bmtwpro4CVMljib3gzukf8m4f7DmG2OuJJokXRjif/eHFjc/hzK8YsKm9biboRCdme/FZNoJsFKsFg06MEOF4DyPTi95p84Pornn3l/VtTKPMLj19BRZph1gOGc6Z228tKu7CrZkzD56DGg3r1ijWmf+Pu/JRBzsHSShTIpMxW7ZnCIoWmsrjF0lJ7hOAnb8FcTz5sYYmbPdU+NNeOZXmzZPmlkz1NQQhKpwnrmV+hnE/i7SsdSWzIRfzOjxip/EhKm5BOSOocBgfSALQY90rAI82Qx2EnGZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y84LzWYrdFTmxjCgdYVyaY66DX5/+VyqZedtpfIvQSY=;
 b=JZeeeAcJMzpkXpq3ak3JM6CSnKCvzFNXiaG+LLrl9d8/1e59wf+WXU5HrCKsOx0IKnJ6WLqCC1GGOO+pQyjEw93dUfCxhuL2W1WTf2Qj7Ygxz767IJNxcTCWt+RpZTULEcBbMsKgJGR5TWbR+FNYYtzGAaNL1z69K346ogNC+44zWc0w3M57vDg8WppqQlX3M4V/BVNwPAjFLgAU9PMJQcnrGiqgOXpHkVSYGYs3L1mqA90m/u80KMUcbApBv6PToubDZcedW5msBU5dCsFSAEIcamkK7BH7fqDY/M9iQ8KwSd3fZ+bCBkRamQqFQ0vtDiTpQl5bHXRpBQiY4specA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y84LzWYrdFTmxjCgdYVyaY66DX5/+VyqZedtpfIvQSY=;
 b=CbSgS0cgLKp7Zswv6AfT9moRaYmi4iy26hu2lwzD/Bg7OClwv4FANg8zjR/KcrLw1QDdLZnyixpdAXmRkCu/U2s7qCDXh2miIqECvsg4t+Y6oMnYiYZL6ibTYUl/M+GrN2tazRMYlFAS8e5SQWLMJx8OfO+PlbuJzGVwWHnASpA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 15:38:48 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 15:38:48 +0000
Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding functions
To: Eduardo Habkost <ehabkost@redhat.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396721426.58170.2930696192478912976.stgit@naples-babu.amd.com>
 <20200602171838.GG577771@habkost.net>
 <e68f8536-40fe-3c35-7d66-04f20fcabb8e@amd.com>
 <20200602230105.GI577771@habkost.net>
 <cc7e970a-0f03-7778-d7f9-76d528c3e260@amd.com>
 <20200603153119.GA2366737@habkost.net>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <31504224-7127-8154-1d62-ef15a8cb8b39@amd.com>
Date: Wed, 3 Jun 2020 10:38:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200603153119.GA2366737@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:3:c0::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM5PR16CA0006.namprd16.prod.outlook.com (2603:10b6:3:c0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 15:38:47 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e3a1e43-6b4d-4602-5b9d-08d807d4352d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2382A95A62DE01A425A4443995880@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+srwGszs0osDJPjlEmQKf0R/6y6VuD0xYnaTsEgfMSmWvwW1Ip6byymW4K9bureAKn6Je2f4qopJwBf7ZCJ7ZnTDJhqcny8qOJXt8h3LL9KD8qtLmij2lf97uLkZuKwtKi63h1ytUVAa5L7JNf09Spr/7tcvwvtbWjsgV8fHomIZc0XNucmJxA4fhL2b3JuLUqpYsI2Ldw9Fo6RBPREDn4LS+vMpOY85mAlkeTYgvlA0cJIQtInPpMOG9J0mFwqs3p6ge/g3LCJFSi2b48i4o5IMKVE3IfpkDjhBJcz7RGt6OD3mLsN5fphBJuhn2zLdiav018uSaevIZGL4XXWqutOvmuGlOAaxndlb62nea1uWSEaZtAXM+yan75wq35rbApVdSjMveDUPnumfvnnJuxcI9ejYtVfHsZcAhzHTngctBGMWFK/iC7d2YbNWUsoYKxjrazzTfCqrO8lDCM33w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(36756003)(316002)(44832011)(86362001)(83380400001)(8676002)(956004)(66556008)(26005)(66476007)(31686004)(66946007)(31696002)(53546011)(8936002)(83080400001)(2616005)(16526019)(2906002)(186003)(478600001)(54906003)(6916009)(52116002)(6486002)(45080400002)(5660300002)(4326008)(966005)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ceXqrP3z6VH7lm4/IIsHpv4284uygzgaARNsrcqYL4tuVM1pqq+O2lKIk5e+DWWf2wE7hYoDcXy0SbQfHX4ygTNGRAWCyhngwnDYoY5kMPb0Jwn41hPyJeMQjuzIN+2xdOxMApQB6k/kPGBgRlcJaqSu5S4HOSJi/8R3+X6s+QTCaP7eHMws66gjULKIFAIRUf5txlKc50t3bQzOj1iu23Dz7goBK9D1XSiCeOyybRRWGsGGH4eBSXc3byey90oY2mUOx+rUuX1nwb3EENHoom+9QBtUTZVLxwGmo5/WijJ/qu1dknDg8XywjUQFRQ1VslyLQo8nveY0HKt3ZFpGi7xXV7P5XxfkBXD52P51x7o+IFHd+/zEWXgQ9w9sNTysDNQupcox6OHOhLKzK716COb48i0wATuMfnX5+A12/K3Pfs6E+yyTlEYTsJCAZNquOL2Pn2vjpwcK94CM0hYl0yB5Hfjxhydnhma6bz6uqe0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3a1e43-6b4d-4602-5b9d-08d807d4352d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 15:38:48.1340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMRa9NPaIStfLPhBAOZT+N5zbHBA1oQODLLlA2tS1QN8r1Zvu5HTEm9RL1dsHlv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
Received-SPF: none client-ip=40.107.244.54; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 11:38:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/3/20 10:31 AM, Eduardo Habkost wrote:
> On Wed, Jun 03, 2020 at 10:22:10AM -0500, Babu Moger wrote:
>>
>>
>>> -----Original Message-----
>>> From: Eduardo Habkost <ehabkost@redhat.com>
>>> Sent: Tuesday, June 2, 2020 6:01 PM
>>> To: Moger, Babu <Babu.Moger@amd.com>
>>> Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
>>> mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
>>> Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding
>>> functions
>>>
>>> On Tue, Jun 02, 2020 at 04:59:19PM -0500, Babu Moger wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Sent: Tuesday, June 2, 2020 12:19 PM
>>>>> To: Moger, Babu <Babu.Moger@amd.com>
>>>>> Cc: marcel.apfelbaum@gmail.com; pbonzini@redhat.com; rth@twiddle.net;
>>>>> mst@redhat.com; imammedo@redhat.com; qemu-devel@nongnu.org
>>>>> Subject: Re: [PATCH v7 07/13] hw/386: Add EPYC mode topology decoding
>>>>> functions
>>>>>
>>>>> Hi,
>>>>>
>>>>> It looks like this series breaks -device and CPU hotplug:
>>>>>
>>>>> On Wed, Mar 11, 2020 at 05:53:34PM -0500, Babu Moger wrote:
>>>>>> These functions add support for building EPYC mode topology given the
>>> smp
>>>>>> details like numa nodes, cores, threads and sockets.
>>>>>>
>>>>>> The new apic id decoding is mostly similar to current apic id decoding
>>>>>> except that it adds a new field node_id when numa configured. Removes
>>> all
>>>>>> the hardcoded values. Subsequent patches will use these functions to build
>>>>>> the topology.
>>>>>>
>>>>>> Following functions are added.
>>>>>> apicid_llc_width_epyc
>>>>>> apicid_llc_offset_epyc
>>>>>> apicid_pkg_offset_epyc
>>>>>> apicid_from_topo_ids_epyc
>>>>>> x86_topo_ids_from_idx_epyc
>>>>>> x86_topo_ids_from_apicid_epyc
>>>>>> x86_apicid_from_cpu_idx_epyc
>>>>>>
>>>>>> The topology details are available in Processor Programming Reference
>>> (PPR)
>>>>>> for AMD Family 17h Model 01h, Revision B1 Processors. The revision
>>> guides
>>>>> are
>>>>>> available from the bugzilla Link below.
>>>>>> Link:
>>>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.
>>>>>
>>> kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=02%7C01%7Cbabu.m
>>>>>
>>> oger%40amd.com%7C3487f40d37df4d59097d08d807190248%7C3dd8961fe488
>>>>>
>>> 4e608e11a82d994e183d%7C0%7C0%7C637267151289763739&amp;sdata=wE0
>>>>> ukXIVh0l5eNQWsv6VDE9UZEVJmisofaW192gcZAI%3D&amp;reserved=0
>>>>>>
>>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>>>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>> ---
>>>>> [...]
>>>>>>  typedef struct X86CPUTopoIDs {
>>>>>>      unsigned pkg_id;
>>>>>> +    unsigned node_id;
>>>>>
>>>>> You have added a new field here.
>>>>>
>>>>>>      unsigned die_id;
>>>>>>      unsigned core_id;
>>>>>>      unsigned smt_id;
>>>>> [...]
>>>>>> +static inline apic_id_t
>>>>>> +x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
>>>>>> +                              const X86CPUTopoIDs *topo_ids)
>>>>>> +{
>>>>>> +    return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
>>>>>> +           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
>>>>>
>>>>> You are using the new field here.
>>>>>
>>>>>> +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
>>>>>> +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
>>>>>> +           topo_ids->smt_id;
>>>>>> +}
>>>>>
>>>>> But you are not initializing node_id in one caller of apicid_from_topo_ids():
>>>>>
>>>>> static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>>>>                             DeviceState *dev, Error **errp)
>>>>> {
>>>>>     [...]
>>>>>     X86CPUTopoIDs topo_ids;
>>>>>     [...]
>>>>>     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
>>>>>         [...]
>>>>>         topo_ids.pkg_id = cpu->socket_id;
>>>>>         topo_ids.die_id = cpu->die_id;
>>>>>         topo_ids.core_id = cpu->core_id;
>>>>>         topo_ids.smt_id = cpu->thread_id;
>>>>>         cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
>>>>>     }
>>>>>     [...]
>>>>> }
>>>>>
>>>>> Result: -device is broken when using -cpu EPYC:
>>>>>
>>>>>   $ qemu-system-x86_64 -machine q35,accel=kvm -smp
>>>>> 1,maxcpus=2,cores=1,threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
>>>>> cpu,core-id=0,socket-id=1,thread-id=0
>>>
>>> [1]
>>>
>>>>>   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-
>>> id=1,thread-
>>>>> id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0] with APIC ID
>>> 21855,
>>>>> valid index range 0:1
>>>>>
>>>>> This happens because APIC ID is calculated using uninitialized
>>>>> memory.
>>>> This patch should initialize the node_id. But I am not sure how to
>>>> reproduce the bug. Can you please send me the full command line to
>>>> reproduce the problem. Also test different options.
>>>
>>> The full command line is above[1].
>>
>> I just picked up the latest tree from
>> git clone https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.qemu.org%2Fgit%2Fqemu.git&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C7752c36b7ad24df4039d08d807d334fa%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637267951007572953&amp;sdata=69rG4w79FnLs9bhNmroxsRckzmy%2BGuH1dMjyP8PPRUo%3D&amp;reserved=0 qemu
>> Not seeing the problem.
>>
>> ./x86_64-softmmu/qemu-system-x86_64 -machine q35,accel=kvm -smp
>> 1,maxcpus=2,cores=1,threads=1,sockets=2 -cpu EPYC -device
>> EPYC-x86_64-cpu,core-id=0,socket-id=1,thread-id=0
>> VNC server running on ::1:5900
>>
>> It appears to run ok.

[2]

>>
>>>
>>>
>>>>
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index 2128f3d6fe..047b4b9391 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -1539,6 +1539,9 @@ static void pc_cpu_pre_plug(HotplugHandler
>>> *hotplug_dev,
>>>>      if (cpu->apic_id == UNASSIGNED_APIC_ID) {
>>>>          int max_socket = (ms->smp.max_cpus - 1) /
>>>>                                  smp_threads / smp_cores / x86ms->smp_dies;
>>>
>>> So, here's the input you are using to calculate topo_ids.node_id:
>>>
>>>> +        unsigned nr_nodes = MAX(topo_info.nodes_per_pkg, 1);
>>>
>>> When is topo_info.nodes_per_pkg allowed to be 0?
>>
>> It will be zero if numa is not configured. Node_id will be zero for all
>> the cores.
>>
>>>
>>>> +        unsigned cores_per_node = DIV_ROUND_UP((x86ms->smp_dies *
>>> smp_cores *
>>>> +                                                smp_threads), nr_nodes);
>>>
>>> x86ms->smp_dies should be available at topo_info.dies_per_pkg,
>>> smp_cores should available at topo_info.cores_per_die,
>>> smp_threads should be available at topo_info.threads_per_core,
>>> nr_nodes should be available at topo_info.nodes_per_pkg.
>>>
>>>>
>>>>          /*
>>>>           * die-id was optional in QEMU 4.0 and older, so keep it optional
>>>> @@ -1585,6 +1588,7 @@ static void pc_cpu_pre_plug(HotplugHandler
>>> *hotplug_dev,
>>>>          topo_ids.die_id = cpu->die_id;
>>>>          topo_ids.core_id = cpu->core_id;
>>>>          topo_ids.smt_id = cpu->thread_id;
>>>> +        topo_ids.node_id = (cpu->core_id / cores_per_node) % nr_nodes;
>>>
>>> apicid_from_topo_ids() have access to topo_info and topo_ids, If
>>> all the information you need to calculate node_id is already
>>> available inside topo_info + topo_ids, we could be calculating it
>>> inside apicid_from_topo_ids().  Why don't we do it?
>>>
>>> Also, is topo_ids.core_id really allowed to be larger than
>>> cores_per_node when calling apicid_from_topo_ids()?
>>
>> Yes. It is. If we have two numa nodes and 8 cores. Then cores_per_node is
>> 4. Nr_nodes =2. Yes. Core_id can be larger than cores_per_node.
> 
> I assumed core_id identified the core inside a die, and the range
> would be [0, cores_per_die).  This seems to be what
> apicid_from_topo_ids_epyc() expects.
> 
> We need clearer documentation on the semantics of each *_id
> field, to avoid confusion.

Ok. Sure. I will add that. Can you please clarify on how to repro the
issue. Marked the question at [2].

> 
>>
>>>
>>>>          cpu->apic_id =
>>>>          x86ms->apicid_from_topo_ids(&topo_info,
>>>>          &topo_ids); }
>>>>
>>>
>>> -- Eduardo
>>
> 

