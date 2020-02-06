Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669CC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F2821927
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MV+cjUWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F2821927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izj9Y-00039W-Vp
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1izj8e-0002f1-6V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1izj8c-0001kJ-BH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:32:20 -0500
Received: from mail-eopbgr680083.outbound.protection.outlook.com
 ([40.107.68.83]:14205 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1izj8c-0001at-4E
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:32:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLsg/hx2+gQoD4ifAB2ZLQ6Cq3kzfhotd+Y+xl7ELR1o5pmSh0kS8c79k/nxX3zE/MbSRX1ArIYQ27wEeZpd2GI7Uz2I2PEPR5zjy9JCTZ3inULYRYewhbo8WzlTuFh8sFuWTOpl0q3rGzWctZ74ihCgnDC+uhF61yoxQtlz4ntRODSsEbfq2+3h3crhlxyXiSfPS+EA+B3Qasovpf4Q62tkNalssoovxtw1NFvhhGCGHk9XYOV6tomvgXkOaZ1mS+iYdo1cN6wiRMdpNrcAluiWWkScX0zYh5S67IR2RV8VrP3oFmRwajARvb8g4bvhhHOSA6epv9up2oBiAJSa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKTJaBHEpM0mnIiBWRFuZln8xXOJLrfFCJi34Qhm3y0=;
 b=chFYwxL/QJ5PQgMSymCsGpTvuYTQ9avaqqNhYrYBpFjbz60kCJ7zCZ9UD1IXo9csAnvcH28axz2k5IQ9bXI//OksRYtfSAmXn7tx++T4h+E9njYyur2arrMC+a5OaZT1mQfJGcM5jzB/0BKJOkYeXR00wFQfsaWDRpDKG9ADAst/5G2nmIQHBTM3PPxAhtl/Omf9gARsVwgytDpNJLnsDU+t3Yt1rMiL1D27Md4+esMKO5yb7SXhrdYvsLVhbHYqF1+JRYRofLGcO5QtFQmiYE4bPD3w/9tqMYtXxSag+nsUrHfy8dObapgbVZripw7nURThT7at6L6Wt1y4i3mpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKTJaBHEpM0mnIiBWRFuZln8xXOJLrfFCJi34Qhm3y0=;
 b=MV+cjUWaewqzJKCg5gExOfi5jB2xRQ2O9YmYiTHYMFRQYZopOp0rCEvqpPrAb51WAbkZFMj2xoogHroZazJtY2xBPEfAjLZuuHQuUSsrGwIMvF2rkJmkXNjDrtQu4W0kr9Nop9ycVxfwTuzE+5wyBCCIkrlvFcjAEPLwyIe2xj4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1350.namprd12.prod.outlook.com (10.168.169.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 15:32:14 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 15:32:14 +0000
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <20200203155921.658d7765@redhat.com>
 <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
 <20200204090230.28f31a87@redhat.com>
 <fec6193d-09f1-5609-28fb-d10122053610@amd.com>
 <20200205103838.424b40a9@redhat.com>
 <3b7e02cb-4da0-d5f0-6cd0-c9b8045bbe17@amd.com>
 <20200205175619.51be0cc8@redhat.com>
 <8b97f174-dd7e-cec0-daf7-29104d663aa6@amd.com>
 <20200206140839.378ea544@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <63d0f63c-bd84-5e42-0a30-531a54fb8af3@amd.com>
Date: Thu, 6 Feb 2020 09:32:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200206140839.378ea544@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:5:74::42) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM6PR07CA0065.namprd07.prod.outlook.com (2603:10b6:5:74::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 15:32:13 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2274ea3c-6ec9-41b7-d701-08d7ab19bdcb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1350:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13506A4E593E4C04B1A5A876951D0@CY4PR12MB1350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(16576012)(316002)(5660300002)(4326008)(53546011)(966005)(36756003)(66946007)(31696002)(66556008)(66476007)(86362001)(478600001)(26005)(45080400002)(52116002)(44832011)(31686004)(16526019)(186003)(2906002)(6916009)(956004)(2616005)(81166006)(8676002)(81156014)(8936002)(6486002)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1350;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlcEG+/gfK0VOZIpiX9beBn66BAkqAVsgEXsgnD6tFqDEc29FDuhKrm6zfH2moqluBwaPwKrKYlVy063zr7aMg2u/d2plTQlXUH1RAG8ywyHNbaAUbdLOAVXQEGGoWAJJgaNmWJ0H8wdeDu4sztweS3WvGhROfFfmO/PjJfhQUOqv5qY7Tamm8RRimLdcNiSNzT0AxBj7leuPBNkAnrCLnlMq76bPm7W2IFTsc2ssmCupUZyEsjftQ0JCw8D9cpO6qUpgEJZPOso/+Xgq3rkGlhbJoxFqPIBGDx3Or1zUKAZAicyY+ZJXXRezfhxFIjnEN1zrwO+TyZKensPVowlwZllM5D+aUEwgULyrh9yDzGtDxl1KlvxmVHOy038VapLlaynXFNF+leRXKNtQIW/ab4o+PrRGIApVcxu6SKHsgHoTnUL9EbDgJhjAyfE3oKZvCzYhHjptflkhWpctvFoUFdOokt1agsArnUcyTZnjUWBs3zm2ErCkDF3nxHlIc9V6ayUK3L3H2VecAR2S+6OOOgn9azthnGNC21bwukzy7/hu44gznDAQXTe23L6lQQY
X-MS-Exchange-AntiSpam-MessageData: s00gha95KNSKwvOx0bUdLBcBdntGvOe0Q2+MFWhnVp9r7X3cdusNpLXl7GL8S7oU5dPg4ULFX31LXbWZgYdXRXOh1CmHCA9U4OvKepk1rFtVOEZZikdMksxcVDH5+ePfTePqO4aBOUAdtd200Kjvbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2274ea3c-6ec9-41b7-d701-08d7ab19bdcb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 15:32:14.6487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ict+KcL8dlMnrsqTU3nVJqz8d+al2p5XaDA228PuxO+fRScUkRLsHrevxnZcFfXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1350
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.83
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



On 2/6/20 7:08 AM, Igor Mammedov wrote:
> On Wed, 5 Feb 2020 13:07:31 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> On 2/5/20 10:56 AM, Igor Mammedov wrote:
>>> On Wed, 5 Feb 2020 10:10:06 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>  =20
>>>> On 2/5/20 3:38 AM, Igor Mammedov wrote: =20
>>>>> On Tue, 4 Feb 2020 13:08:58 -0600
>>>>> Babu Moger <babu.moger@amd.com> wrote:
>>>>>    =20
>>>>>> On 2/4/20 2:02 AM, Igor Mammedov wrote:   =20
>>>>>>> On Mon, 3 Feb 2020 13:31:29 -0600
>>>>>>> Babu Moger <babu.moger@amd.com> wrote:
>>>>>>>      =20
>>>>>>>> On 2/3/20 8:59 AM, Igor Mammedov wrote:     =20
>>>>>>>>> On Tue, 03 Dec 2019 18:36:54 -0600
>>>>>>>>> Babu Moger <babu.moger@amd.com> wrote:
>>>>>>>>>        =20
>>>>>>>>>> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
>>>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7C=
babu.moger%40amd.com%7C76bf8434899b41de094f08d7ab05bdf3%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637165913481441118&amp;sdata=3D34fZQpUjScKbbc35c7=
ot433HA1Rz03YG6aP1ucyGUsQ%3D&amp;reserved=3D0
>>>>>>>>>>
>>>>>>>>>> Currently, the APIC ID is decoded based on the sequence
>>>>>>>>>> sockets->dies->cores->threads. This works for most standard AMD =
and other
>>>>>>>>>> vendors' configurations, but this decoding sequence does not fol=
low that of
>>>>>>>>>> AMD's APIC ID enumeration strictly. In some cases this can cause=
 CPU topology
>>>>>>>>>> inconsistency.  When booting a guest VM, the kernel tries to val=
idate the
>>>>>>>>>> topology, and finds it inconsistent with the enumeration of EPYC=
 cpu models.
>>>>>>>>>>
>>>>>>>>>> To fix the problem we need to build the topology as per the Proc=
essor
>>>>>>>>>> Programming Reference (PPR) for AMD Family 17h Model 01h, Revisi=
on B1
>>>>>>>>>> Processors. It is available at https://nam11.safelinks.protectio=
n.outlook.com/?url=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%=
2F55570-B1_PUB.zip&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C76bf8434899b=
41de094f08d7ab05bdf3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637165913=
481451075&amp;sdata=3D4YXG%2BrCP5UUXcCQX4Ly8B%2FXdlvZoFrPCgonjy0IwG0U%3D&am=
p;reserved=3D0
>>>>>>>>>>
>>>>>>>>>> Here is the text from the PPR.
>>>>>>>>>> Operating systems are expected to use Core::X86::Cpuid::SizeId[A=
picIdSize], the
>>>>>>>>>> number of least significant bits in the Initial APIC ID that ind=
icate core ID
>>>>>>>>>> within a processor, in constructing per-core CPUID masks.
>>>>>>>>>> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum numb=
er of cores
>>>>>>>>>> (MNC) that the processor could theoretically support, not the ac=
tual number of
>>>>>>>>>> cores that are actually implemented or enabled on the processor,=
 as indicated
>>>>>>>>>> by Core::X86::Cpuid::SizeId[NC].
>>>>>>>>>> Each Core::X86::Apic::ApicId[ApicId] register is preset as follo=
ws:
>>>>>>>>>> =E2=80=A2 ApicId[6] =3D Socket ID.
>>>>>>>>>> =E2=80=A2 ApicId[5:4] =3D Node ID.
>>>>>>>>>> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
>>>>>>>>>> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} :=
 {1'b0,LogicalCoreID[1:0]}       =20
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> After checking out all patches and some pondering, used here appr=
oach
>>>>>>>>> looks to me too intrusive for the task at hand especially where i=
t
>>>>>>>>> comes to generic code.
>>>>>>>>>
>>>>>>>>> (Ignore till =3D=3D=3D=3D to see suggestion how to simplify witho=
ut reading
>>>>>>>>> reasoning behind it first)
>>>>>>>>>
>>>>>>>>> Lets look for a way to simplify it a little bit.
>>>>>>>>>
>>>>>>>>> So problem we are trying to solve,
>>>>>>>>>  1: calculate APIC IDs based on cpu type (to e more specific: for=
 EPYC based CPUs)
>>>>>>>>>  2: it depends on knowing total number of numa nodes.
>>>>>>>>>
>>>>>>>>> Externally workflow looks like following:
>>>>>>>>>   1. user provides -smp x,sockets,cores,...,maxcpus
>>>>>>>>>       that's used by possible_cpu_arch_ids() singleton to build l=
ist of
>>>>>>>>>       possible CPUs (which is available to user via command 'hotp=
luggable-cpus')
>>>>>>>>>
>>>>>>>>>       Hook could be called very early and possible_cpus data migh=
t be
>>>>>>>>>       not complete. It builds a list of possible CPUs which user =
could
>>>>>>>>>       modify later.
>>>>>>>>>
>>>>>>>>>   2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node=
,node_id=3Dx,cpus=3D"
>>>>>>>>>       options to assign cpus to nodes, which is one way or anothe=
r calling
>>>>>>>>>       machine_set_cpu_numa_node(). The later updates 'possible_cp=
us' list
>>>>>>>>>       with node information. It happens early when total number o=
f nodes
>>>>>>>>>       is not available.
>>>>>>>>>
>>>>>>>>>   2.2 user does not provide explicit node mappings for CPUs.
>>>>>>>>>       QEMU steps in and assigns possible cpus to nodes in machine=
_numa_finish_cpu_init()
>>>>>>>>>       (using the same machine_set_cpu_numa_node()) right before c=
alling boards
>>>>>>>>>       specific machine init(). At that time total number of nodes=
 is known.
>>>>>>>>>
>>>>>>>>> In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have=
 to be defined before
>>>>>>>>> boards init() is run.     =20
>>>>>>
>>>>>> In case of 2.1, we need to have the arch_id already generated. This =
is
>>>>>> done inside possible_cpu_arch_ids. The arch_id is used by
>>>>>> machine_set_cpu_numa_node to assign the cpus to correct numa node.  =
 =20
>>>>>
>>>>> I might have missed something but I don't see arch_id itself being us=
ed in
>>>>> machine_set_cpu_numa_node(). It only uses props part of possible_cpus=
   =20
>>>>
>>>> Before calling machine_set_cpu_numa_node, we call
>>>> cpu_index_to_instance_props -> x86_cpu_index_to_props->
>>>> possible_cpu_arch_ids->x86_possible_cpu_arch_ids.
>>>>
>>>> This sequence sets up the arch_id(in x86_cpu_apic_id_from_index) for a=
ll
>>>> the available cpus. Based on the arch_id, it also sets up the props. =
=20
>>>
>>>
>>> x86_possible_cpu_arch_ids()
>>>    arch_id =3D x86_cpu_apic_id_from_index(x86ms, i)
>>>    x86_topo_ids_from_apicid(arch_id, x86ms->smp_dies, ms->smp.cores,  m=
s->smp.threads, &topo);
>>>    // assign socket/die/core/thread from topo
>>>
>>> so currently it uses indirect way to convert index in possible_cpus->cp=
us[]
>>> to socket/die/core/thread ids.
>>> But essentially it take '-smp' options and [0..max_cpus) number as orig=
inal data
>>> converts it into intermediate apic_id and then reverse engineer it back=
 to
>>> topo info.
>>>
>>> Why not use x86_topo_ids_from_idx() directly to get rid of 'props' depe=
ndency on apic_id? =20
>>
>> It might work. But this feels like a work-around and delaying the proble=
m
>> for later. Just re-arranging the numa code little bit we can address thi=
s.
>=20
> The idea behind possible_cpus is to allow users query topo information
> board generates (based on -smp) at configuration time (or late) so users
> could know what -numa cpu,topo_options [and -device foo-cpu,topo_options]
> to use, initializing apic_id on the first access is secondary and I did
> it only because I could do it without additional data.
>=20
> But main purpose of possible_cpus is to keep topology information.
> That includes numa node mapping, which should be stored in possible_cpus
> along with the rest of cpu topology.
>=20
> Looking [12/18] numa patch, it makes -numa node,cpus legacy option
> to reintroduce data duplication, by storing mapping elsewhere and
> then putting that mapping into possible_cpus at numa complete time
> (that's what I dislike and don't see a valid reason to do so).
>=20
> That also won't work if user queries hotpluggable-cpus before that time
> and it also doesn't work if user uses preferable -numa cpu,topo_options
> as both would initialize possible_cpus on the first access.
>=20
> So if you need do some board specific post-processing done on topo
> information when it's complete and recalculate apic_id do it at board
> init time like was suggested before (x86_cpu_new() looks like a good
> place to do it).

Ok. Sure. Will start working on it. Thanks

