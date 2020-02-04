Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBECC3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC302166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5oh/mWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC302166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytBr-0004ys-VS
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iytAZ-00038a-5k
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iytAU-000334-WB
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27197
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iytAU-0002t6-HR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580803365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXx8UKpj/SpuWTznhwgDeXmg35KIHiBXG/MqDpmozBo=;
 b=U5oh/mWxgStUPATKvc3B+d7s0kqUHQ3JvZWoSDZQgzjwbbCFRL4jTmDmnCPatOfBnstC/S
 ugOQrZth/H18dba2MYj97WNo8GiRJxCMYUYtLxILHt+QyDJWvYkZzG5djORjuRm0RG/kq9
 iI8z6REcBE5NEH8TjSbuJd56AKk1OGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-01Dyf3NDO9OTxrcORc1J9g-1; Tue, 04 Feb 2020 03:02:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE928800D54;
 Tue,  4 Feb 2020 08:02:36 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7378E8068E;
 Tue,  4 Feb 2020 08:02:32 +0000 (UTC)
Date: Tue, 4 Feb 2020 09:02:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
Message-ID: <20200204090230.28f31a87@redhat.com>
In-Reply-To: <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <20200203155921.658d7765@redhat.com>
 <b493a4f4-48de-79a7-00d5-119fbe789879@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 01Dyf3NDO9OTxrcORc1J9g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Mon, 3 Feb 2020 13:31:29 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 2/3/20 8:59 AM, Igor Mammedov wrote:
> > On Tue, 03 Dec 2019 18:36:54 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >  =20
> >> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu=
gzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1728166&amp;data=3D02%7C01%7Cbabu.m=
oger%40amd.com%7C50685202e372472d7b2c08d7a8b9afa6%7C3dd8961fe4884e608e11a82=
d994e183d%7C0%7C0%7C637163387802886193&amp;sdata=3DN%2FaBBZ8G3D1gCNvabVQ%2F=
raHvINazcVeEc9FWdxQAWmg%3D&amp;reserved=3D0
> >>
> >> Currently, the APIC ID is decoded based on the sequence
> >> sockets->dies->cores->threads. This works for most standard AMD and ot=
her
> >> vendors' configurations, but this decoding sequence does not follow th=
at of
> >> AMD's APIC ID enumeration strictly. In some cases this can cause CPU t=
opology
> >> inconsistency.  When booting a guest VM, the kernel tries to validate =
the
> >> topology, and finds it inconsistent with the enumeration of EPYC cpu m=
odels.
> >>
> >> To fix the problem we need to build the topology as per the Processor
> >> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> >> Processors. It is available at https://nam11.safelinks.protection.outl=
ook.com/?url=3Dhttps%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F5557=
0-B1_PUB.zip&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C50685202e372472d7b=
2c08d7a8b9afa6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637163387802886=
193&amp;sdata=3DMcjyMS3A3x5Jr57VxJmHDyh5jumdybzW%2FwLtE4FAKHQ%3D&amp;reserv=
ed=3D0
> >>
> >> Here is the text from the PPR.
> >> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdS=
ize], the
> >> number of least significant bits in the Initial APIC ID that indicate =
core ID
> >> within a processor, in constructing per-core CPUID masks.
> >> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of =
cores
> >> (MNC) that the processor could theoretically support, not the actual n=
umber of
> >> cores that are actually implemented or enabled on the processor, as in=
dicated
> >> by Core::X86::Cpuid::SizeId[NC].
> >> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> >> =E2=80=A2 ApicId[6] =3D Socket ID.
> >> =E2=80=A2 ApicId[5:4] =3D Node ID.
> >> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> >> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0=
,LogicalCoreID[1:0]} =20
> >=20
> >=20
> > After checking out all patches and some pondering, used here approach
> > looks to me too intrusive for the task at hand especially where it
> > comes to generic code.
> >=20
> > (Ignore till =3D=3D=3D=3D to see suggestion how to simplify without rea=
ding
> > reasoning behind it first)
> >=20
> > Lets look for a way to simplify it a little bit.
> >=20
> > So problem we are trying to solve,
> >  1: calculate APIC IDs based on cpu type (to e more specific: for EPYC =
based CPUs)
> >  2: it depends on knowing total number of numa nodes.
> >=20
> > Externally workflow looks like following:
> >   1. user provides -smp x,sockets,cores,...,maxcpus
> >       that's used by possible_cpu_arch_ids() singleton to build list of
> >       possible CPUs (which is available to user via command 'hotpluggab=
le-cpus')
> >=20
> >       Hook could be called very early and possible_cpus data might be
> >       not complete. It builds a list of possible CPUs which user could
> >       modify later.
> >=20
> >   2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node,node_=
id=3Dx,cpus=3D"
> >       options to assign cpus to nodes, which is one way or another call=
ing
> >       machine_set_cpu_numa_node(). The later updates 'possible_cpus' li=
st
> >       with node information. It happens early when total number of node=
s
> >       is not available.
> >=20
> >   2.2 user does not provide explicit node mappings for CPUs.
> >       QEMU steps in and assigns possible cpus to nodes in machine_numa_=
finish_cpu_init()
> >       (using the same machine_set_cpu_numa_node()) right before calling=
 boards
> >       specific machine init(). At that time total number of nodes is kn=
own.
> >=20
> > In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have to be=
 defined before
> > boards init() is run.
> >=20
> > In 2.2 case it calls get_default_cpu_node_id() -> x86_get_default_cpu_n=
ode_id()
> > which uses arch_id calculate numa node.
> > But then question is: does it have to use APIC id or could it infer 'pk=
g_id',
> > it's after, from ms->possible_cpus->cpus[i].props data? =20
>=20
> Not sure if I got the question right. In this case because the numa
> information is not provided all the cpus are assigned to only one node.
> The apic id is used here to get the correct pkg_id.

apicid was composed from socket/core/thread[/die] tuple which cpus[i].props=
 is.

Question is if we can compose only pkg_id based on the same data without
converting it to apicid and then "reverse engineering" it back
original data?

Or more direct question: is socket-id the same as pkg_id?


>=20
> >  =20
> > With that out of the way APIC ID will be used only during board's init(=
),
> > so board could update possible_cpus with valid APIC IDs at the start of
> > x86_cpus_init().
> >=20
> > =3D=3D=3D=3D
> > in nutshell it would be much easier to do following:
> >=20
> >  1. make x86_get_default_cpu_node_id() APIC ID in-depended or
> >     if impossible as alternative recompute APIC IDs there if cpu
> >     type is EPYC based (since number of nodes is already known)
> >  2. recompute APIC IDs in x86_cpus_init() if cpu type is EPYC based
> >=20
> > this way one doesn't need to touch generic numa code, introduce
> > x86 specific init_apicid_fn() hook into generic code and keep
> > x86/EPYC nuances contained within x86 code only. =20
>=20
> I was kind of already working in the similar direction in v4.
> 1. We already have split the numa initialization in patch #12(Split the
> numa initialization). This way we know exactly how many numa nodes are
> there before hand.

I suggest to drop that patch, It's the one that touches generic numa
code and adding more legacy based extensions like cpu_indexes.
Which I'd like to get rid of to begin with, so only -numa cpu is left.

I think it's not necessary to touch numa code at all for apicid generation
purpose, as I tried to explain above. We should be able to keep
this x86 only business.

> 2. Planning to remove init_apicid_fn
> 3. Insert the handlers inside X86CPUDefinition.
what handlers do you mean?

> 4. EPYC model will have its own apid id handlers. Everything else will be
> initialized with a default handlers(current default handler).
> 5. The function pc_possible_cpu_arch_ids will load the model definition
> and initialize the PCMachineState data structure with the model specific
> handlers.
I'm not sure what do you mean here.
=20
> Does that sound similar to what you are thinking. Thoughts?
If you have something to share and can push it on github,
I can look at, whether it has design issues to spare you a round trip on a =
list.
(it won't be proper review but at least I can help to pinpoint most problem=
atic parts)

>=20
> >  =20
> >> v3:
> >>   1. Consolidated the topology information in structure X86CPUTopoInfo=
.
> >>   2. Changed the ccx_id to llc_id as commented by upstream.
> >>   3. Generalized the apic id decoding. It is mostly similar to current=
 apic id
> >>      except that it adds new field llc_id when numa configured. Remove=
s all the
> >>      hardcoded values.
> >>   4. Removed the earlier parse_numa split. And moved the numa node ini=
tialization
> >>      inside the numa_complete_configuration. This is bit cleaner as co=
mmented by=20
> >>      Eduardo.
> >>   5. Added new function init_apicid_fn inside machine_class structure.=
 This
> >>      will be used to update the apic id handler specific to cpu model.
> >>   6. Updated the cpuid unit tests.
> >>   7. TODO : Need to figure out how to dynamically update the handlers =
using cpu models.
> >>      I might some guidance on that.
> >>
> >> v2:
> >>   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
lore.kernel.org%2Fqemu-devel%2F156779689013.21957.1631551572950676212.stgit=
%40localhost.localdomain%2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C506=
85202e372472d7b2c08d7a8b9afa6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637163387802886193&amp;sdata=3Dls1cxA1yh0P05zYsAf3sLXDM11DFHtxZvfWWaar7Mgg%=
3D&amp;reserved=3D0
> >>   1. Introduced the new property epyc to enable new epyc mode.
> >>   2. Separated the epyc mode and non epyc mode function.
> >>   3. Introduced function pointers in PCMachineState to handle the
> >>      differences.
> >>   4. Mildly tested different combinations to make things are working a=
s expected.
> >>   5. TODO : Setting the epyc feature bit needs to be worked out. This =
feature is
> >>      supported only on AMD EPYC models. I may need some guidance on th=
at.
> >>
> >> v1:
> >>   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
lore.kernel.org%2Fqemu-devel%2F20190731232032.51786-1-babu.moger%40amd.com%=
2F&amp;data=3D02%7C01%7Cbabu.moger%40amd.com%7C50685202e372472d7b2c08d7a8b9=
afa6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637163387802886193&amp;sd=
ata=3DnT4T9RIL4EeSvB%2Ff9%2BjbU7lldopjglQ2X6uYx13WMPE%3D&amp;reserved=3D0
> >>
> >> ---
> >>
> >> Babu Moger (18):
> >>       hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
> >>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
> >>       hw/i386: Consolidate topology functions
> >>       hw/i386: Introduce initialize_topo_info to initialize X86CPUTopo=
Info
> >>       machine: Add SMP Sockets in CpuTopology
> >>       hw/core: Add core complex id in X86CPU topology
> >>       machine: Add a new function init_apicid_fn in MachineClass
> >>       hw/i386: Update structures for nodes_per_pkg
> >>       i386: Add CPUX86Family type in CPUX86State
> >>       hw/386: Add EPYC mode topology decoding functions
> >>       i386: Cleanup and use the EPYC mode topology functions
> >>       numa: Split the numa initialization
> >>       hw/i386: Introduce apicid_from_cpu_idx in PCMachineState
> >>       hw/i386: Introduce topo_ids_from_apicid handler PCMachineState
> >>       hw/i386: Introduce apic_id_from_topo_ids handler in PCMachineSta=
te
> >>       hw/i386: Introduce EPYC mode function handlers
> >>       i386: Fix pkg_id offset for epyc mode
> >>       tests: Update the Unit tests
> >>
> >>
> >>  hw/core/machine-hmp-cmds.c |    3 +
> >>  hw/core/machine.c          |   14 +++
> >>  hw/core/numa.c             |   62 +++++++++----
> >>  hw/i386/pc.c               |  132 +++++++++++++++++++---------
> >>  include/hw/boards.h        |    3 +
> >>  include/hw/i386/pc.h       |    9 ++
> >>  include/hw/i386/topology.h |  209 +++++++++++++++++++++++++++++++----=
---------
> >>  include/sysemu/numa.h      |    5 +
> >>  qapi/machine.json          |    7 +
> >>  target/i386/cpu.c          |  196 ++++++++++++-----------------------=
------
> >>  target/i386/cpu.h          |    9 ++
> >>  tests/test-x86-cpuid.c     |  115 ++++++++++++++----------
> >>  vl.c                       |    4 +
> >>  13 files changed, 455 insertions(+), 313 deletions(-)
> >>
> >> --
> >> =20
> >  =20
>=20


