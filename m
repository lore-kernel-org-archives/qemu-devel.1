Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2E9C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264EF2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEtGtgs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264EF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHAh-0001Oy-Bb
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1izH96-0008E9-OB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1izH92-00073i-SE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:38:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1izH92-0006v1-MV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580895531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mpjPmHPBUn9rPKM0uc3lVu2psMByPl0ZA5YJDwqZjQ=;
 b=NEtGtgs7IRrENI7hbJCUE1F1kz0J8uREYgZd+GocRPBwTy9a6CvlfW8Do41gniBKdjIw8p
 TSPczxjWIUhfAsapeH0QylvV5SH3hKPsAOHz+C+vpAc8WnGmJ+hVWcaISm5t1xq9M58ptn
 6M6PUTw41UZBseLC+RebZdLHNOILYqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-eQWWhWx7OVCw2Sc7u6GwKQ-1; Wed, 05 Feb 2020 04:38:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0215086A079;
 Wed,  5 Feb 2020 09:38:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7013D87B1B;
 Wed,  5 Feb 2020 09:38:40 +0000 (UTC)
Date: Wed, 5 Feb 2020 10:38:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
Message-ID: <20200205103838.424b40a9@redhat.com>
In-Reply-To: <fec6193d-09f1-5609-28fb-d10122053610@amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <20200203155921.658d7765@redhat.com>
 <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
 <20200204090230.28f31a87@redhat.com>
 <fec6193d-09f1-5609-28fb-d10122053610@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: eQWWhWx7OVCw2Sc7u6GwKQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Tue, 4 Feb 2020 13:08:58 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 2/4/20 2:02 AM, Igor Mammedov wrote:
> > On Mon, 3 Feb 2020 13:31:29 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >  =20
> >> On 2/3/20 8:59 AM, Igor Mammedov wrote: =20
> >>> On Tue, 03 Dec 2019 18:36:54 -0600
> >>> Babu Moger <babu.moger@amd.com> wrote:
> >>>    =20
> >>>> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
> >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
bugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu=
.moger%40amd.com%7Cbbd1693802184161c8c308d7a9489ee9%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637164001686545394&amp;sdata=3DUtYAoTk4RfZZ1VfaP%2Fhc=
YrCSNTcubEB7cB%2BoYlRLfhc%3D&amp;reserved=3D0
> >>>>
> >>>> Currently, the APIC ID is decoded based on the sequence
> >>>> sockets->dies->cores->threads. This works for most standard AMD and =
other
> >>>> vendors' configurations, but this decoding sequence does not follow =
that of
> >>>> AMD's APIC ID enumeration strictly. In some cases this can cause CPU=
 topology
> >>>> inconsistency.  When booting a guest VM, the kernel tries to validat=
e the
> >>>> topology, and finds it inconsistent with the enumeration of EPYC cpu=
 models.
> >>>>
> >>>> To fix the problem we need to build the topology as per the Processo=
r
> >>>> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B=
1
> >>>> Processors. It is available at https://nam11.safelinks.protection.ou=
tlook.com/?url=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F55=
570-B1_PUB.zip&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7Cbbd1693802184161=
c8c308d7a9489ee9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371640016865=
55390&amp;sdata=3DoHONRiXtpstKqwrxyzqR20bYDDr3zvmwq91a%2Br6iDqc%3D&amp;rese=
rved=3D0
> >>>>
> >>>> Here is the text from the PPR.
> >>>> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicI=
dSize], the
> >>>> number of least significant bits in the Initial APIC ID that indicat=
e core ID
> >>>> within a processor, in constructing per-core CPUID masks.
> >>>> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number o=
f cores
> >>>> (MNC) that the processor could theoretically support, not the actual=
 number of
> >>>> cores that are actually implemented or enabled on the processor, as =
indicated
> >>>> by Core::X86::Cpuid::SizeId[NC].
> >>>> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> >>>> =E2=80=A2 ApicId[6] =3D Socket ID.
> >>>> =E2=80=A2 ApicId[5:4] =3D Node ID.
> >>>> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> >>>> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'=
b0,LogicalCoreID[1:0]}   =20
> >>>
> >>>
> >>> After checking out all patches and some pondering, used here approach
> >>> looks to me too intrusive for the task at hand especially where it
> >>> comes to generic code.
> >>>
> >>> (Ignore till =3D=3D=3D=3D to see suggestion how to simplify without r=
eading
> >>> reasoning behind it first)
> >>>
> >>> Lets look for a way to simplify it a little bit.
> >>>
> >>> So problem we are trying to solve,
> >>>  1: calculate APIC IDs based on cpu type (to e more specific: for EPY=
C based CPUs)
> >>>  2: it depends on knowing total number of numa nodes.
> >>>
> >>> Externally workflow looks like following:
> >>>   1. user provides -smp x,sockets,cores,...,maxcpus
> >>>       that's used by possible_cpu_arch_ids() singleton to build list =
of
> >>>       possible CPUs (which is available to user via command 'hotplugg=
able-cpus')
> >>>
> >>>       Hook could be called very early and possible_cpus data might be
> >>>       not complete. It builds a list of possible CPUs which user coul=
d
> >>>       modify later.
> >>>
> >>>   2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node,nod=
e_id=3Dx,cpus=3D"
> >>>       options to assign cpus to nodes, which is one way or another ca=
lling
> >>>       machine_set_cpu_numa_node(). The later updates 'possible_cpus' =
list
> >>>       with node information. It happens early when total number of no=
des
> >>>       is not available.
> >>>
> >>>   2.2 user does not provide explicit node mappings for CPUs.
> >>>       QEMU steps in and assigns possible cpus to nodes in machine_num=
a_finish_cpu_init()
> >>>       (using the same machine_set_cpu_numa_node()) right before calli=
ng boards
> >>>       specific machine init(). At that time total number of nodes is =
known.
> >>>
> >>> In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have to =
be defined before
> >>> boards init() is run. =20
>=20
> In case of 2.1, we need to have the arch_id already generated. This is
> done inside possible_cpu_arch_ids. The arch_id is used by
> machine_set_cpu_numa_node to assign the cpus to correct numa node.

I might have missed something but I don't see arch_id itself being used in
machine_set_cpu_numa_node(). It only uses props part of possible_cpus

=20
> If we want to move the arch_id generation into board init(), then we need
> to save the cpu indexes belonging to each node somewhere.

when cpus are assigned explicitly, decision what cpus go to what nodes is
up to user and user configured mapping is stored in MachineState::possible_=
cpus
which is accessed by via possible_cpu_arch_ids() callback.
Hence I don see any reason to touch cpu indexes.

>=20
> >>>
> >>> In 2.2 case it calls get_default_cpu_node_id() -> x86_get_default_cpu=
_node_id()
> >>> which uses arch_id calculate numa node.
> >>> But then question is: does it have to use APIC id or could it infer '=
pkg_id',
> >>> it's after, from ms->possible_cpus->cpus[i].props data?   =20
> >>
> >> Not sure if I got the question right. In this case because the numa
> >> information is not provided all the cpus are assigned to only one node=
.
> >> The apic id is used here to get the correct pkg_id. =20
> >=20
> > apicid was composed from socket/core/thread[/die] tuple which cpus[i].p=
rops is.
> >=20
> > Question is if we can compose only pkg_id based on the same data withou=
t
> > converting it to apicid and then "reverse engineering" it back
> > original data? =20
>=20
> Yes. It is possible.
>=20
> >=20
> > Or more direct question: is socket-id the same as pkg_id? =20
>=20
> Yes. Socket_id and pkg_id is same.
>=20
> >=20
> >  =20
> >> =20
> >>>  =20
> >>> With that out of the way APIC ID will be used only during board's ini=
t(),
> >>> so board could update possible_cpus with valid APIC IDs at the start =
of
> >>> x86_cpus_init().
> >>>
> >>> =3D=3D=3D=3D
> >>> in nutshell it would be much easier to do following:
> >>>
> >>>  1. make x86_get_default_cpu_node_id() APIC ID in-depended or
> >>>     if impossible as alternative recompute APIC IDs there if cpu
> >>>     type is EPYC based (since number of nodes is already known)
> >>>  2. recompute APIC IDs in x86_cpus_init() if cpu type is EPYC based
> >>>
> >>> this way one doesn't need to touch generic numa code, introduce
> >>> x86 specific init_apicid_fn() hook into generic code and keep
> >>> x86/EPYC nuances contained within x86 code only.   =20
> >>
> >> I was kind of already working in the similar direction in v4.
> >> 1. We already have split the numa initialization in patch #12(Split th=
e
> >> numa initialization). This way we know exactly how many numa nodes are
> >> there before hand. =20
> >=20
> > I suggest to drop that patch, It's the one that touches generic numa
> > code and adding more legacy based extensions like cpu_indexes.
> > Which I'd like to get rid of to begin with, so only -numa cpu is left.
> >=20
> > I think it's not necessary to touch numa code at all for apicid generat=
ion
> > purpose, as I tried to explain above. We should be able to keep
> > this x86 only business. =20
>=20
> This is going to be difficult without touching the generic numa code.

Looking at current code I don't see why one would touch numa code.
Care to explain in more details why you'd have to touch it?

> >> 2. Planning to remove init_apicid_fn
> >> 3. Insert the handlers inside X86CPUDefinition. =20
> > what handlers do you mean? =20
>=20
> Apicid generation logic can be separated into 3 types of handlers.
> x86_apicid_from_cpu_idx: Generate apicid from cpu index.
> x86_topo_ids_from_apicid: Generate topo ids from apic id.
> x86_apicid_from_topo_ids: Generate apicid from topo ids.
>=20
> We should be able to generate one id from other(you can see topology.h).
>=20
> X86CPUDefinition will have the handlers specific to each model like the
> way we have features now. The above 3 handlers will be used as default
> handler.

it probably shouldn't be a part of X86CPUDefinition,
as it's machines responsibility to generate and set APIC ID.

What you are doing with this topo functions in this version
looks more that enough to me.

> The EPYC model will have its corresponding handlers.
>=20
> x86_apicid_from_cpu_idx_epyc
> x86_topo_ids_from_apicid_epyc
> x86_apicid_from_topo_ids_epyc.

CPU might use call backs, but does it have to?
I see cpu_x86_cpuid() uses these functions to decode apic_id back to topo
info and then compose various leaves based on it.
Within CPU code I'd just use
 if (i_am_epyc)
    x86_topo_ids_from_apicid_epyc()
 else
    x86_topo_ids_from_apicid()
it's easier to read and one doesn't have to go figure
indirection chain to figure out what code is called.
  =20
> >> 4. EPYC model will have its own apid id handlers. Everything else will=
 be
> >> initialized with a default handlers(current default handler).
> >> 5. The function pc_possible_cpu_arch_ids will load the model definitio=
n
> >> and initialize the PCMachineState data structure with the model specif=
ic
> >> handlers. =20
> > I'm not sure what do you mean here. =20
>=20
> PCMachineState will have the function pointers to the above handlers.
> I was going to load the correct handler based on the mode type.

Could be done like this, but considering that within machine we need
to calculate apic_id only once, the same 'if' trick would be simpler

x86_cpus_init() {

  if (cpu =3D=3D epic) {
     make_epyc_apic_ids(mc->possible_cpu_arch_ids(ms))
  }

  // go on with creating cpus ...
}

> >> Does that sound similar to what you are thinking. Thoughts? =20
> > If you have something to share and can push it on github,
> > I can look at, whether it has design issues to spare you a round trip o=
n a list.
> > (it won't be proper review but at least I can help to pinpoint most pro=
blematic parts)
> >  =20
> My code for the current approach is kind of ready(yet to be tested). I ca=
n
> send it as v3.1 if you want to look. Or we can wait for our discussion to
> settle. I will post it after our discussion.
ok, lets wait till we finish this discussion

> There is one more problem we need to address. I was going to address late=
r
> in v4 or v5.
>=20
> This works
> -numa node,nodeid=3D0,cpus=3D0-3 -numa node,nodeid=3D1,cpus=3D4-7
>=20
> This does not work
> -numa node,nodeid=3D0,cpus=3D0-5 -numa node,nodeid=3D1,cpus=3D6-7
Is it supposed to work (i.e. can real hardware do such topology)?

> This requires the generic code to pass the node information to the x86
> code which requires some handler changes. I was thinking my code will
> simplify the changes to address this issue.

without more information, it's hard to comment on issue and whether
extra complexity of callbacks is justificated.=20

There could be 2 ways here, add fixes to this series so we could see the re=
ason
or make this series simple to solve apic_id problem only and then on top of
it send the second series that solves another issue.

Considering that this series is already big/complicated enough,
personally I'd go for 2nd option. As it's easier to describe what patches a=
re
doing and easier to review =3D> should result in faster reaching consensus =
and merging.
[...]


