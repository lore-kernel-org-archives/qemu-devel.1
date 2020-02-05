Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A73C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B90420659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ebVfc1SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B90420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNGr-0005ux-KQ
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1izNFn-0005Kr-MB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1izNFl-00066J-2Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:10:15 -0500
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com
 ([40.107.236.50]:64608 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1izNFk-00060U-Ls
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:10:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfp5ppZsvpQpz4Xf5rlBRHZM5Baxb9SfigvlVbcu1TzawC3VMMZWumxG8pciCkiYBORQmm/mxqhy7tY5Nl6BPHX7oCHQzZXFdsRq6AyVPB7e6pWLOsX2l/IxBgbAEr6sd8KDc1P9zVwRzTmJjt6kri3vD6Ix8dex4VUNk3aF11tQX3dpDIPO1D+OIdb9UYcrW5Y0mMpPjRZeyyc2YG2DrVBXPtmUzrReE2FucAauTo91zVsYGdxITO7PZwIkHja2OMHAYxvHRDdlObaiVphr3R8ip1VlUijqE0u46Ly5b9pc1KPWgBKzR04h9r+eUBtxBYK4KLV6QxZuFKnp/hXE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvrkGhbHUZ2MmgdE5lUIXTisGEpqUrsH+9IlU0L7R3U=;
 b=TNPl+oJvuvtYkH1XcZkUN7Y6xbrXlwXTKaFkLc/5AC8k6mNQJlmyYyJSouFIGNu0h9nHcacqYtOz5UHqzpHBnYfnJxAEWHxGErGVtKGAx11RFyCLvJ1gSF4qQZEsvZb8QwXMijRcWd6n7PdUfIg1V8D+STDh/LhYDHsdOQ5DPxfjiewpTOeG1ZEgcmoUc69UOE9Pnvz91zMl1xiD13j5gZI9u6wFfMXuVUH2/Zirm6x/EGlEoTOSg6npJJRUtPMqv/grBRzS9A1X6X8b4hhFSpoxje4qAnshc0386V6gNSAJde9gd+4RoHBfxZlvfVinzpvajxnUeGsJXGU0//fM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvrkGhbHUZ2MmgdE5lUIXTisGEpqUrsH+9IlU0L7R3U=;
 b=ebVfc1SS5iT2+t4B1k2qmGOMKTKBSFY4L6CNcXxVwRwTaIPcHAGZ7N8aJrKYmiV9ygK1YD767tLgNQsZ6zYb9oCTL3YMj7uO3gW/aPw0//y7f9GMjt8mnOCVufWcGJLl5cM0brCoECYAM1qKB+r2V6co83puwa+41pAmK24dCbw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1607.namprd12.prod.outlook.com (10.172.69.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.34; Wed, 5 Feb 2020 16:10:09 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 16:10:08 +0000
From: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <20200203155921.658d7765@redhat.com>
 <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
 <20200204090230.28f31a87@redhat.com>
 <fec6193d-09f1-5609-28fb-d10122053610@amd.com>
 <20200205103838.424b40a9@redhat.com>
Message-ID: <3b7e02cb-4da0-d5f0-6cd0-c9b8045bbe17@amd.com>
Date: Wed, 5 Feb 2020 10:10:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200205103838.424b40a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:3:23::22) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR13CA0012.namprd13.prod.outlook.com (2603:10b6:3:23::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.11 via Frontend Transport; Wed, 5 Feb 2020 16:10:07 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44469ea1-0fd1-408a-7e7f-08d7aa55deda
X-MS-TrafficTypeDiagnostic: CY4PR12MB1607:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1607A274B31357E392A7662B95020@CY4PR12MB1607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(189003)(966005)(5660300002)(16576012)(4326008)(186003)(52116002)(44832011)(316002)(53546011)(66476007)(86362001)(16526019)(66556008)(31686004)(478600001)(81156014)(6916009)(45080400002)(81166006)(36756003)(31696002)(8936002)(30864003)(26005)(8676002)(2906002)(2616005)(956004)(6486002)(66946007)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1607;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qp2hYfs5ESc620jena8+BYo3KFVHmkywZjWfwCvYigYn1sqncYwY+rC1IMypZWLc/yqeJNDZIgG+YdZGyxKfz2pvVKFgqo1jB3UNsxQ8vHeOjFef9+O62P0OmdGlYbPBItgUrlld+L1RGDDfkol43rqtU/dA5a+YptNK5MI3F/J+tZUKz8S8SxyR+9W2cLPdTODcaI7PuHyZyMS1d/wG3t1DSIasSVePFEFdO+1ozDAdRwfR3UsPSgNNNCWSFFLkqk+ngv9ypP9lkieSzzfxZBFmP6sJLMfSgJmUCVq9KTb++eAiOzi5FTTHFinX15uUuiBQc2736ngKxiAMcvajcrRRqjGQ0Nwjzr11RbFz6PblBRMVeYxu8q4aGrdIfShnIXe+bKR2coMBMEOHYWCn0RrjRAp4cL7uz0b2MKjEf+JYNjPGaQ8jXrcoA0ubq0PzM3fGBPOjrqYAvFhZzv4F0hSmijTfTF+jPi4KUdzt4FnpXTVQfISt4x+aSVGSuESvNNpqGhgcVIRln4wMxtdBXp4Y0Z3tsy8pOUeTKNNS3qgXRp9B0SCq5+1MT1oI3KR8
X-MS-Exchange-AntiSpam-MessageData: KXdidFzj65DpFV3oJ93wffsj1GBOYjgP23FiW24sIXpFMS6hitRw1y1bxydj7oqmSfS5SAMKymiZVssuonxjtoMmtm56nTEWbWIDyllutSoJEa3n/dFfuYnPC9hcKzrtDjkb0NJmt1vg2hVv8M4q7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44469ea1-0fd1-408a-7e7f-08d7aa55deda
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 16:10:08.6406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lcqDiR5s0UiDttI7BRpnP3JruJ7JbIY0SZlJoSbEHdHyItoWCABKXqwC3MAwfrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.50
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/5/20 3:38 AM, Igor Mammedov wrote:
> On Tue, 4 Feb 2020 13:08:58 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> On 2/4/20 2:02 AM, Igor Mammedov wrote:
>>> On Mon, 3 Feb 2020 13:31:29 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>  =20
>>>> On 2/3/20 8:59 AM, Igor Mammedov wrote: =20
>>>>> On Tue, 03 Dec 2019 18:36:54 -0600
>>>>> Babu Moger <babu.moger@amd.com> wrote:
>>>>>    =20
>>>>>> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
bugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu=
.moger%40amd.com%7Cdbfd059a060a4851aad908d7aa1f3532%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637164923333568238&amp;sdata=3DP0I547X5r0s9emWu3ptIcm=
1U%2FhCMZmnMQOQ0IgLPzzQ%3D&amp;reserved=3D0
>>>>>>
>>>>>> Currently, the APIC ID is decoded based on the sequence
>>>>>> sockets->dies->cores->threads. This works for most standard AMD and =
other
>>>>>> vendors' configurations, but this decoding sequence does not follow =
that of
>>>>>> AMD's APIC ID enumeration strictly. In some cases this can cause CPU=
 topology
>>>>>> inconsistency.  When booting a guest VM, the kernel tries to validat=
e the
>>>>>> topology, and finds it inconsistent with the enumeration of EPYC cpu=
 models.
>>>>>>
>>>>>> To fix the problem we need to build the topology as per the Processo=
r
>>>>>> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B=
1
>>>>>> Processors. It is available at https://nam11.safelinks.protection.ou=
tlook.com/?url=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F55=
570-B1_PUB.zip&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7Cdbfd059a060a4851=
aad908d7aa1f3532%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371649233335=
68238&amp;sdata=3DAO6m%2FEI17iLoAa3gNnRSJKJAdvBRKh0Dmbr7bCVA0us%3D&amp;rese=
rved=3D0
>>>>>>
>>>>>> Here is the text from the PPR.
>>>>>> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicI=
dSize], the
>>>>>> number of least significant bits in the Initial APIC ID that indicat=
e core ID
>>>>>> within a processor, in constructing per-core CPUID masks.
>>>>>> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number o=
f cores
>>>>>> (MNC) that the processor could theoretically support, not the actual=
 number of
>>>>>> cores that are actually implemented or enabled on the processor, as =
indicated
>>>>>> by Core::X86::Cpuid::SizeId[NC].
>>>>>> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
>>>>>> =E2=80=A2 ApicId[6] =3D Socket ID.
>>>>>> =E2=80=A2 ApicId[5:4] =3D Node ID.
>>>>>> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
>>>>>> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'=
b0,LogicalCoreID[1:0]}   =20
>>>>>
>>>>>
>>>>> After checking out all patches and some pondering, used here approach
>>>>> looks to me too intrusive for the task at hand especially where it
>>>>> comes to generic code.
>>>>>
>>>>> (Ignore till =3D=3D=3D=3D to see suggestion how to simplify without r=
eading
>>>>> reasoning behind it first)
>>>>>
>>>>> Lets look for a way to simplify it a little bit.
>>>>>
>>>>> So problem we are trying to solve,
>>>>>  1: calculate APIC IDs based on cpu type (to e more specific: for EPY=
C based CPUs)
>>>>>  2: it depends on knowing total number of numa nodes.
>>>>>
>>>>> Externally workflow looks like following:
>>>>>   1. user provides -smp x,sockets,cores,...,maxcpus
>>>>>       that's used by possible_cpu_arch_ids() singleton to build list =
of
>>>>>       possible CPUs (which is available to user via command 'hotplugg=
able-cpus')
>>>>>
>>>>>       Hook could be called very early and possible_cpus data might be
>>>>>       not complete. It builds a list of possible CPUs which user coul=
d
>>>>>       modify later.
>>>>>
>>>>>   2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node,nod=
e_id=3Dx,cpus=3D"
>>>>>       options to assign cpus to nodes, which is one way or another ca=
lling
>>>>>       machine_set_cpu_numa_node(). The later updates 'possible_cpus' =
list
>>>>>       with node information. It happens early when total number of no=
des
>>>>>       is not available.
>>>>>
>>>>>   2.2 user does not provide explicit node mappings for CPUs.
>>>>>       QEMU steps in and assigns possible cpus to nodes in machine_num=
a_finish_cpu_init()
>>>>>       (using the same machine_set_cpu_numa_node()) right before calli=
ng boards
>>>>>       specific machine init(). At that time total number of nodes is =
known.
>>>>>
>>>>> In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have to =
be defined before
>>>>> boards init() is run. =20
>>
>> In case of 2.1, we need to have the arch_id already generated. This is
>> done inside possible_cpu_arch_ids. The arch_id is used by
>> machine_set_cpu_numa_node to assign the cpus to correct numa node.
>=20
> I might have missed something but I don't see arch_id itself being used i=
n
> machine_set_cpu_numa_node(). It only uses props part of possible_cpus

Before calling machine_set_cpu_numa_node, we call
cpu_index_to_instance_props -> x86_cpu_index_to_props->
possible_cpu_arch_ids->x86_possible_cpu_arch_ids.

This sequence sets up the arch_id(in x86_cpu_apic_id_from_index) for all
the available cpus. Based on the arch_id, it also sets up the props.
And these props values are used to assign the nodes in
machine_set_cpu_numa_node.

At this point we are still parsing the numa nodes and so we don't know the
total number of numa nodes. Without that information, the arch_id
generated here will not be correct for EPYC models.

This is the reason for changing the generic numa code(patch #12-Split the
numa initialization).

>=20
> =20
>> If we want to move the arch_id generation into board init(), then we nee=
d
>> to save the cpu indexes belonging to each node somewhere.
>=20
> when cpus are assigned explicitly, decision what cpus go to what nodes is
> up to user and user configured mapping is stored in MachineState::possibl=
e_cpus
> which is accessed by via possible_cpu_arch_ids() callback.
> Hence I don see any reason to touch cpu indexes.

Please see my reasoning above.

>=20
>>
>>>>>
>>>>> In 2.2 case it calls get_default_cpu_node_id() -> x86_get_default_cpu=
_node_id()
>>>>> which uses arch_id calculate numa node.
>>>>> But then question is: does it have to use APIC id or could it infer '=
pkg_id',
>>>>> it's after, from ms->possible_cpus->cpus[i].props data?   =20
>>>>
>>>> Not sure if I got the question right. In this case because the numa
>>>> information is not provided all the cpus are assigned to only one node=
.
>>>> The apic id is used here to get the correct pkg_id. =20
>>>
>>> apicid was composed from socket/core/thread[/die] tuple which cpus[i].p=
rops is.
>>>
>>> Question is if we can compose only pkg_id based on the same data withou=
t
>>> converting it to apicid and then "reverse engineering" it back
>>> original data? =20
>>
>> Yes. It is possible.
>>
>>>
>>> Or more direct question: is socket-id the same as pkg_id? =20
>>
>> Yes. Socket_id and pkg_id is same.
>>
>>>
>>>  =20
>>>> =20
>>>>>  =20
>>>>> With that out of the way APIC ID will be used only during board's ini=
t(),
>>>>> so board could update possible_cpus with valid APIC IDs at the start =
of
>>>>> x86_cpus_init().
>>>>>
>>>>> =3D=3D=3D=3D
>>>>> in nutshell it would be much easier to do following:
>>>>>
>>>>>  1. make x86_get_default_cpu_node_id() APIC ID in-depended or
>>>>>     if impossible as alternative recompute APIC IDs there if cpu
>>>>>     type is EPYC based (since number of nodes is already known)
>>>>>  2. recompute APIC IDs in x86_cpus_init() if cpu type is EPYC based
>>>>>
>>>>> this way one doesn't need to touch generic numa code, introduce
>>>>> x86 specific init_apicid_fn() hook into generic code and keep
>>>>> x86/EPYC nuances contained within x86 code only.   =20
>>>>
>>>> I was kind of already working in the similar direction in v4.
>>>> 1. We already have split the numa initialization in patch #12(Split th=
e
>>>> numa initialization). This way we know exactly how many numa nodes are
>>>> there before hand. =20
>>>
>>> I suggest to drop that patch, It's the one that touches generic numa
>>> code and adding more legacy based extensions like cpu_indexes.
>>> Which I'd like to get rid of to begin with, so only -numa cpu is left.
>>>
>>> I think it's not necessary to touch numa code at all for apicid generat=
ion
>>> purpose, as I tried to explain above. We should be able to keep
>>> this x86 only business. =20
>>
>> This is going to be difficult without touching the generic numa code.pat=
ch #12(Split the
>>>> numa initialization)
>=20
> Looking at current code I don't see why one would touch numa code.
> Care to explain in more details why you'd have to touch it?

Please see the reasoning above.
>=20
>>>> 2. Planning to remove init_apicid_fn
>>>> 3. Insert the handlers inside X86CPUDefinition. =20
>>> what handlers do you mean? =20
>>
>> Apicid generation logic can be separated into 3 types of handlers.
>> x86_apicid_from_cpu_idx: Generate apicid from cpu index.
>> x86_topo_ids_from_apicid: Generate topo ids from apic id.
>> x86_apicid_from_topo_ids: Generate apicid from topo ids.
>>
>> We should be able to generate one id from other(you can see topology.h).
>>
>> X86CPUDefinition will have the handlers specific to each model like the
>> way we have features now. The above 3 handlers will be used as default
>> handler.
>=20
> it probably shouldn't be a part of X86CPUDefinition,
> as it's machines responsibility to generate and set APIC ID.
>=20
> What you are doing with this topo functions in this version
> looks more that enough to me.

It is all the exact same topo functions. Only making these functions as
the handlers inside the X86CPUDefinition.

>=20
>> The EPYC model will have its corresponding handlers.
>>
>> x86_apicid_from_cpu_idx_epyc
>> x86_topo_ids_from_apicid_epyc
>> x86_apicid_from_topo_ids_epyc.
>=20
> CPU might use call backs, but does it have to?
> I see cpu_x86_cpuid() uses these functions to decode apic_id back to topo
> info and then compose various leaves based on it.
> Within CPU code I'd just use
>  if (i_am_epyc)
>     x86_topo_ids_from_apicid_epyc()
>  else
>     x86_topo_ids_from_apicid()
> it's easier to read and one doesn't have to go figure
> indirection chain to figure out what code is called.

Eduardo already commented on this idea. Anything specific to cpu models
should be part of the X86CPUDefinition. We should not compare the specific
model here. Comparing the specific model does not scale. We are achieving
this by loading the model definition(similar to what we do in
x86_cpu_load_model).

>   =20
>>>> 4. EPYC model will have its own apid id handlers. Everything else will=
 be
>>>> initialized with a default handlers(current default handler).
>>>> 5. The function pc_possible_cpu_arch_ids will load the model definitio=
n
>>>> and initialize the PCMachineState data structure with the model specif=
ic
>>>> handlers. =20
>>> I'm not sure what do you mean here. =20
>>
>> PCMachineState will have the function pointers to the above handlers.
>> I was going to load the correct handler based on the mode type.
>=20
> Could be done like this, but considering that within machine we need
> to calculate apic_id only once, the same 'if' trick would be simpler
>=20
> x86_cpus_init() {
>=20
>   if (cpu =3D=3D epic) {
>      make_epyc_apic_ids(mc->possible_cpu_arch_ids(ms))
>   }

Once again, this does not scale. Please see my response above.

>=20
>   // go on with creating cpus ...
> }
>=20
>>>> Does that sound similar to what you are thinking. Thoughts? =20
>>> If you have something to share and can push it on github,
>>> I can look at, whether it has design issues to spare you a round trip o=
n a list.
>>> (it won't be proper review but at least I can help to pinpoint most pro=
blematic parts)
>>>  =20
>> My code for the current approach is kind of ready(yet to be tested). I c=
an
>> send it as v3.1 if you want to look. Or we can wait for our discussion t=
o
>> settle. I will post it after our discussion.
> ok, lets wait till we finish this discussion

I can post my draft patch to give you more idea about what i am talking
about now. Let me know.

>=20
>> There is one more problem we need to address. I was going to address lat=
er
>> in v4 or v5.
>>
>> This works
>> -numa node,nodeid=3D0,cpus=3D0-3 -numa node,nodeid=3D1,cpus=3D4-7
>>
>> This does not work
>> -numa node,nodeid=3D0,cpus=3D0-5 -numa node,nodeid=3D1,cpus=3D6-7
> Is it supposed to work (i.e. can real hardware do such topology)?

Hardware does not support this configuration. That is why I did not think
it is serious enough to fix this problem right now.

>=20
>> This requires the generic code to pass the node information to the x86
>> code which requires some handler changes. I was thinking my code will
>> simplify the changes to address this issue.
>=20
> without more information, it's hard to comment on issue and whether
> extra complexity of callbacks is justificated.=20
>=20
> There could be 2 ways here, add fixes to this series so we could see the =
reason
> or make this series simple to solve apic_id problem only and then on top =
of
> it send the second series that solves another issue.
>=20
> Considering that this series is already big/complicated enough,
> personally I'd go for 2nd option. As it's easier to describe what patches=
 are
> doing and easier to review =3D> should result in faster reaching consensu=
s and merging.
> [...]
>=20

