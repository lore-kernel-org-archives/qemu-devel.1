Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25288C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 19:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEE520674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 19:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SxgrEIay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEE520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3a7-0001J6-2s
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 14:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iz3ZK-0000re-GJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 14:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iz3ZI-0001QQ-5N
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 14:09:06 -0500
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com
 ([40.107.93.56]:27489 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iz3ZH-0001Ik-R5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 14:09:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K42MZdI/qIeu8Ew5JIrGnCXIi1+JCIGE2pAj9ojRulgLrXeqVV/V+kxCBBRYMVo1jciOWM6gOyl6TdMMBxAO+CXwPAwsw3kKBtamgc3CCgtewn/yiJ4llMDyCOsbU++RYRyB7JzLbTExTMuT8Ep0RoDVHP9Gn4Im1CvTsdfCgazZqc2AwuMapae7en+Wl4ej1cphb5Whq1gHU8ohH8qr2qM8d8DJiXxB+sFRedrQgfXIOs6QKlpWURV1qHhJ1v/lW5XmFUt/BjWOXUwjOh7IggORHqvLTzUlaZjivvEguuNrboXaVEd24iCto1dY+PbQW6SQdCdiQNZBFjNNxNlHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZspCP8A1flKHyRXQ+AVcMmt6yvNgXbFM89AK35tHKf8=;
 b=DCpg5YHTtMX7tCODNSVtogT/d6oFzyJmHt0HciIkFGCyTVxbM4M5qshv5xCu2NB5Jya6Xya1bnxYnBYsqS0nTbeZ23hoT3sxhK74dNnyRKfvEzMGWt/yQFgl1KVPwFLSgLcTTZB2iPpQ9Z9Ft034FFKV70EoF3u1uWFwRQfDrX8mwUp7Cdhs5mdRNuI7TXgfnvKs14OTGjIn8OfNn2bah2NG5F4Ygn5jl/ewvoGHCVWdDPJr8tseecXmMjsE7t9VQYq896btmg9sEw8O6JBnDzYiVANJRQjVE/DZn99FG38zfna8zIsLSKFD0BsJsnbhx6KMB85YaZ3jmYFv8OIWqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZspCP8A1flKHyRXQ+AVcMmt6yvNgXbFM89AK35tHKf8=;
 b=SxgrEIayYG2bcfsn5cIj/lggT6knhF8js6/7JIlq9s2N+dsEIOyJQrokL6xjaDSL0snv/53ZSX+HGIqt6R9BDF1rdimItk9Wrufk3cYDcuZ0FdrGQS70abOi/NUQ9l66tIN5BNNckyhrIqaL0U6+uIehe4hu23ZimAfQ+Mv/1x0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1288.namprd12.prod.outlook.com (10.168.167.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Tue, 4 Feb 2020 19:09:00 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 19:09:00 +0000
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
To: Igor Mammedov <imammedo@redhat.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <20200203155921.658d7765@redhat.com>
 <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
 <20200204090230.28f31a87@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <fec6193d-09f1-5609-28fb-d10122053610@amd.com>
Date: Tue, 4 Feb 2020 13:08:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200204090230.28f31a87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM5PR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:4:ae::35) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from [10.236.30.87] (165.204.77.1) by
 DM5PR07CA0106.namprd07.prod.outlook.com (2603:10b6:4:ae::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32 via Frontend Transport; Tue, 4 Feb 2020 19:08:59 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 745cd424-cc20-4d4c-d964-08d7a9a5b136
X-MS-TrafficTypeDiagnostic: CY4PR12MB1288:
X-Microsoft-Antispam-PRVS: <CY4PR12MB128895D283A872E2D7BE83BF95030@CY4PR12MB1288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(2906002)(36756003)(45080400002)(186003)(2616005)(44832011)(956004)(53546011)(52116002)(966005)(4326008)(66476007)(16576012)(316002)(66946007)(8676002)(16526019)(66556008)(26005)(5660300002)(6486002)(8936002)(31686004)(30864003)(86362001)(31696002)(81166006)(81156014)(478600001)(6916009)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1288;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gt4ZM7rul3UDv0Bn18wyd79ifqDlLRFHobiUobsRnRB2CwWJnEAWm9T9astefnMiyEIYSo81T5x1osa2q79efRot+rL/HDux1dIOduaBO/flAAvz7ebSv/tnrc21/m5dXp+1QnbBWyIGReuo4MIs8SczW5FQlxt3T4oNSZVgKUKp0rPI0QkdmPq+Ncv96Rs43OB0/O6r6EqCFKCUD03V4zObOAGEJz57Yl6POcbfscZsw8Bj75EsifQqRHMC18dzCAy18uFX2JPhAB3jbrvy8WacWrYhWI52h1AbXBRHmNJBnMC/Z6ekzk8DXlq5a0Z85dCVci0bMzuMBzKoAeYWO/SBV/p8lknU649QK+tlDFw2yXnYkudCer/t3+RqacuAC31y9KPEfW/kDjYMgacU8Q4YaGdHWRsjNOtZ7eKwvdS0Ci7qNnNfTstdl417DnhbBwu2TaWsXZuegm1Rz0p0WSOMNiDJNBNFokeXAy5ffHld0Wbt6ZQDnmSt0zQY4zI717D/ao0G29B02uXkKCh1OeCxeRs/Q5kGQ2arIX502nJjIPnbWA78uW5hYQA01NCU
X-MS-Exchange-AntiSpam-MessageData: WsN6s9j25FD875xrQII3KLXqnFUEVN0cJC5sLjFiByvo4ihKzcH9w/8ftyN7vrpM6z6liw+kQEumjcKAmNzwwEpS43LudI3UEDA6wryxeYLuJgbOoBeBn8EJQ3ZmzC4G3am3+2DIa0uDWItRlm1WAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745cd424-cc20-4d4c-d964-08d7a9a5b136
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 19:09:00.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvObSVrColkMjHMmmrbCFbVcfP8rzW2Ft5DmQsnPvYwcH1+pUBxhoq57t/TkQGNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1288
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.56
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



On 2/4/20 2:02 AM, Igor Mammedov wrote:
> On Mon, 3 Feb 2020 13:31:29 -0600
> Babu Moger <babu.moger@amd.com> wrote:
>=20
>> On 2/3/20 8:59 AM, Igor Mammedov wrote:
>>> On Tue, 03 Dec 2019 18:36:54 -0600
>>> Babu Moger <babu.moger@amd.com> wrote:
>>>  =20
>>>> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu=
gzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu.m=
oger%40amd.com%7Cbbd1693802184161c8c308d7a9489ee9%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637164001686545394&amp;sdata=3DUtYAoTk4RfZZ1VfaP%2FhcYr=
CSNTcubEB7cB%2BoYlRLfhc%3D&amp;reserved=3D0
>>>>
>>>> Currently, the APIC ID is decoded based on the sequence
>>>> sockets->dies->cores->threads. This works for most standard AMD and ot=
her
>>>> vendors' configurations, but this decoding sequence does not follow th=
at of
>>>> AMD's APIC ID enumeration strictly. In some cases this can cause CPU t=
opology
>>>> inconsistency.  When booting a guest VM, the kernel tries to validate =
the
>>>> topology, and finds it inconsistent with the enumeration of EPYC cpu m=
odels.
>>>>
>>>> To fix the problem we need to build the topology as per the Processor
>>>> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
>>>> Processors. It is available at https://nam11.safelinks.protection.outl=
ook.com/?url=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F5557=
0-B1_PUB.zip&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7Cbbd1693802184161c8=
c308d7a9489ee9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637164001686555=
390&amp;sdata=3DoHONRiXtpstKqwrxyzqR20bYDDr3zvmwq91a%2Br6iDqc%3D&amp;reserv=
ed=3D0
>>>>
>>>> Here is the text from the PPR.
>>>> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdS=
ize], the
>>>> number of least significant bits in the Initial APIC ID that indicate =
core ID
>>>> within a processor, in constructing per-core CPUID masks.
>>>> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of =
cores
>>>> (MNC) that the processor could theoretically support, not the actual n=
umber of
>>>> cores that are actually implemented or enabled on the processor, as in=
dicated
>>>> by Core::X86::Cpuid::SizeId[NC].
>>>> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
>>>> =E2=80=A2 ApicId[6] =3D Socket ID.
>>>> =E2=80=A2 ApicId[5:4] =3D Node ID.
>>>> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
>>>> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0=
,LogicalCoreID[1:0]} =20
>>>
>>>
>>> After checking out all patches and some pondering, used here approach
>>> looks to me too intrusive for the task at hand especially where it
>>> comes to generic code.
>>>
>>> (Ignore till =3D=3D=3D=3D to see suggestion how to simplify without rea=
ding
>>> reasoning behind it first)
>>>
>>> Lets look for a way to simplify it a little bit.
>>>
>>> So problem we are trying to solve,
>>>  1: calculate APIC IDs based on cpu type (to e more specific: for EPYC =
based CPUs)
>>>  2: it depends on knowing total number of numa nodes.
>>>
>>> Externally workflow looks like following:
>>>   1. user provides -smp x,sockets,cores,...,maxcpus
>>>       that's used by possible_cpu_arch_ids() singleton to build list of
>>>       possible CPUs (which is available to user via command 'hotpluggab=
le-cpus')
>>>
>>>       Hook could be called very early and possible_cpus data might be
>>>       not complete. It builds a list of possible CPUs which user could
>>>       modify later.
>>>
>>>   2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node,node_=
id=3Dx,cpus=3D"
>>>       options to assign cpus to nodes, which is one way or another call=
ing
>>>       machine_set_cpu_numa_node(). The later updates 'possible_cpus' li=
st
>>>       with node information. It happens early when total number of node=
s
>>>       is not available.
>>>
>>>   2.2 user does not provide explicit node mappings for CPUs.
>>>       QEMU steps in and assigns possible cpus to nodes in machine_numa_=
finish_cpu_init()
>>>       (using the same machine_set_cpu_numa_node()) right before calling=
 boards
>>>       specific machine init(). At that time total number of nodes is kn=
own.
>>>
>>> In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have to be=
 defined before
>>> boards init() is run.

In case of 2.1, we need to have the arch_id already generated. This is
done inside possible_cpu_arch_ids. The arch_id is used by
machine_set_cpu_numa_node to assign the cpus to correct numa node.

If we want to move the arch_id generation into board init(), then we need
to save the cpu indexes belonging to each node somewhere.

>>>
>>> In 2.2 case it calls get_default_cpu_node_id() -> x86_get_default_cpu_n=
ode_id()
>>> which uses arch_id calculate numa node.
>>> But then question is: does it have to use APIC id or could it infer 'pk=
g_id',
>>> it's after, from ms->possible_cpus->cpus[i].props data? =20
>>
>> Not sure if I got the question right. In this case because the numa
>> information is not provided all the cpus are assigned to only one node.
>> The apic id is used here to get the correct pkg_id.
>=20
> apicid was composed from socket/core/thread[/die] tuple which cpus[i].pro=
ps is.
>=20
> Question is if we can compose only pkg_id based on the same data without
> converting it to apicid and then "reverse engineering" it back
> original data?

Yes. It is possible.

>=20
> Or more direct question: is socket-id the same as pkg_id?

Yes. Socket_id and pkg_id is same.

>=20
>=20
>>
>>>  =20
>>> With that out of the way APIC ID will be used only during board's init(=
),
>>> so board could update possible_cpus with valid APIC IDs at the start of
>>> x86_cpus_init().
>>>
>>> =3D=3D=3D=3D
>>> in nutshell it would be much easier to do following:
>>>
>>>  1. make x86_get_default_cpu_node_id() APIC ID in-depended or
>>>     if impossible as alternative recompute APIC IDs there if cpu
>>>     type is EPYC based (since number of nodes is already known)
>>>  2. recompute APIC IDs in x86_cpus_init() if cpu type is EPYC based
>>>
>>> this way one doesn't need to touch generic numa code, introduce
>>> x86 specific init_apicid_fn() hook into generic code and keep
>>> x86/EPYC nuances contained within x86 code only. =20
>>
>> I was kind of already working in the similar direction in v4.
>> 1. We already have split the numa initialization in patch #12(Split the
>> numa initialization). This way we know exactly how many numa nodes are
>> there before hand.
>=20
> I suggest to drop that patch, It's the one that touches generic numa
> code and adding more legacy based extensions like cpu_indexes.
> Which I'd like to get rid of to begin with, so only -numa cpu is left.
>=20
> I think it's not necessary to touch numa code at all for apicid generatio=
n
> purpose, as I tried to explain above. We should be able to keep
> this x86 only business.

This is going to be difficult without touching the generic numa code.

>=20
>> 2. Planning to remove init_apicid_fn
>> 3. Insert the handlers inside X86CPUDefinition.
> what handlers do you mean?

Apicid generation logic can be separated into 3 types of handlers.
x86_apicid_from_cpu_idx: Generate apicid from cpu index.
x86_topo_ids_from_apicid: Generate topo ids from apic id.
x86_apicid_from_topo_ids: Generate apicid from topo ids.

We should be able to generate one id from other(you can see topology.h).

X86CPUDefinition will have the handlers specific to each model like the
way we have features now. The above 3 handlers will be used as default
handler.


The EPYC model will have its corresponding handlers.

x86_apicid_from_cpu_idx_epyc
x86_topo_ids_from_apicid_epyc
x86_apicid_from_topo_ids_epyc.

>=20
>> 4. EPYC model will have its own apid id handlers. Everything else will b=
e
>> initialized with a default handlers(current default handler).
>> 5. The function pc_possible_cpu_arch_ids will load the model definition
>> and initialize the PCMachineState data structure with the model specific
>> handlers.
> I'm not sure what do you mean here.

PCMachineState will have the function pointers to the above handlers.
I was going to load the correct handler based on the mode type.

> =20
>> Does that sound similar to what you are thinking. Thoughts?
> If you have something to share and can push it on github,
> I can look at, whether it has design issues to spare you a round trip on =
a list.
> (it won't be proper review but at least I can help to pinpoint most probl=
ematic parts)
>=20
My code for the current approach is kind of ready(yet to be tested). I can
send it as v3.1 if you want to look. Or we can wait for our discussion to
settle. I will post it after our discussion.


There is one more problem we need to address. I was going to address later
in v4 or v5.

This works
-numa node,nodeid=3D0,cpus=3D0-3 -numa node,nodeid=3D1,cpus=3D4-7

This does not work
-numa node,nodeid=3D0,cpus=3D0-5 -numa node,nodeid=3D1,cpus=3D6-7

This requires the generic code to pass the node information to the x86
code which requires some handler changes. I was thinking my code will
simplify the changes to address this issue.

>>
>>>  =20
>>>> v3:
>>>>   1. Consolidated the topology information in structure X86CPUTopoInfo=
.
>>>>   2. Changed the ccx_id to llc_id as commented by upstream.
>>>>   3. Generalized the apic id decoding. It is mostly similar to current=
 apic id
>>>>      except that it adds new field llc_id when numa configured. Remove=
s all the
>>>>      hardcoded values.
>>>>   4. Removed the earlier parse_numa split. And moved the numa node ini=
tialization
>>>>      inside the numa_complete_configuration. This is bit cleaner as co=
mmented by=20
>>>>      Eduardo.
>>>>   5. Added new function init_apicid_fn inside machine_class structure.=
 This
>>>>      will be used to update the apic id handler specific to cpu model.
>>>>   6. Updated the cpuid unit tests.
>>>>   7. TODO : Need to figure out how to dynamically update the handlers =
using cpu models.
>>>>      I might some guidance on that.
>>>>
>>>> v2:
>>>>   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
lore.kernel.org%2Fqemu-devel%2F156779689013.21957.1631551572950676212.stgit=
%40localhost.localdomain%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7Cbbd=
1693802184161c8c308d7a9489ee9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637164001686555390&amp;sdata=3DphJxrK4AExmcfBfxcN8Ngtnuwv1vLR%2BW4PnqjUSPQf=
I%3D&amp;reserved=3D0
>>>>   1. Introduced the new property epyc to enable new epyc mode.
>>>>   2. Separated the epyc mode and non epyc mode function.
>>>>   3. Introduced function pointers in PCMachineState to handle the
>>>>      differences.
>>>>   4. Mildly tested different combinations to make things are working a=
s expected.
>>>>   5. TODO : Setting the epyc feature bit needs to be worked out. This =
feature is
>>>>      supported only on AMD EPYC models. I may need some guidance on th=
at.
>>>>
>>>> v1:
>>>>   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
lore.kernel.org%2Fqemu-devel%2F20190731232032.51786-1-babu.moger%40amd.com%=
2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7Cbbd1693802184161c8c308d7a948=
9ee9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637164001686555390&amp;sd=
ata=3DP1Ghnsypj8uSuGiv9XW38nytrHXAIeOGumsbbAEUjCU%3D&amp;reserved=3D0
>>>>
>>>> ---
>>>>
>>>> Babu Moger (18):
>>>>       hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
>>>>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
>>>>       hw/i386: Consolidate topology functions
>>>>       hw/i386: Introduce initialize_topo_info to initialize X86CPUTopo=
Info
>>>>       machine: Add SMP Sockets in CpuTopology
>>>>       hw/core: Add core complex id in X86CPU topology
>>>>       machine: Add a new function init_apicid_fn in MachineClass
>>>>       hw/i386: Update structures for nodes_per_pkg
>>>>       i386: Add CPUX86Family type in CPUX86State
>>>>       hw/386: Add EPYC mode topology decoding functions
>>>>       i386: Cleanup and use the EPYC mode topology functions
>>>>       numa: Split the numa initialization
>>>>       hw/i386: Introduce apicid_from_cpu_idx in PCMachineState
>>>>       hw/i386: Introduce topo_ids_from_apicid handler PCMachineState
>>>>       hw/i386: Introduce apic_id_from_topo_ids handler in PCMachineSta=
te
>>>>       hw/i386: Introduce EPYC mode function handlers
>>>>       i386: Fix pkg_id offset for epyc mode
>>>>       tests: Update the Unit tests
>>>>
>>>>
>>>>  hw/core/machine-hmp-cmds.c |    3 +
>>>>  hw/core/machine.c          |   14 +++
>>>>  hw/core/numa.c             |   62 +++++++++----
>>>>  hw/i386/pc.c               |  132 +++++++++++++++++++---------
>>>>  include/hw/boards.h        |    3 +
>>>>  include/hw/i386/pc.h       |    9 ++
>>>>  include/hw/i386/topology.h |  209 +++++++++++++++++++++++++++++++----=
---------
>>>>  include/sysemu/numa.h      |    5 +
>>>>  qapi/machine.json          |    7 +
>>>>  target/i386/cpu.c          |  196 ++++++++++++-----------------------=
------
>>>>  target/i386/cpu.h          |    9 ++
>>>>  tests/test-x86-cpuid.c     |  115 ++++++++++++++----------
>>>>  vl.c                       |    4 +
>>>>  13 files changed, 455 insertions(+), 313 deletions(-)
>>>>
>>>> --
>>>> =20
>>>  =20
>>
>=20

