Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27831C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52302082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9YizmAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52302082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydEK-0006Nq-3E
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iydCO-0004oP-9v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iydCM-0006lK-HO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:59:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iydCM-0006kb-Cu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580741978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHU73WEspvzsHOoAmpOe2vlVBYcIg9Ps+cOnNPlTQaU=;
 b=F9YizmAIBWiKebU4+6PhaVRDZuX+G235Xh19Uvu8Ey3ZYwuyrt5LYuJm5MhV3JKEzxPZF8
 ngWzhVP0+/e5Gx+gb/km/huCKrDA4UupP06XXHVUxEfDqQ8wp3EQQGUQXaUn0f12fXOrQR
 Otr9jeg2X8w/h0HaXnSR6v8Nx3kVLi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-8WuUtd3sP-Gkry5Y_tuIDw-1; Mon, 03 Feb 2020 09:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 459591937FD0;
 Mon,  3 Feb 2020 14:59:27 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 016E260BE2;
 Mon,  3 Feb 2020 14:59:22 +0000 (UTC)
Date: Mon, 3 Feb 2020 15:59:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 00/18] APIC ID fixes for AMD EPYC CPU models
Message-ID: <20200203155921.658d7765@redhat.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 8WuUtd3sP-Gkry5Y_tuIDw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Tue, 03 Dec 2019 18:36:54 -0600
Babu Moger <babu.moger@amd.com> wrote:

> This series fixes APIC ID encoding problems on AMD EPYC CPUs.
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166
>=20
> Currently, the APIC ID is decoded based on the sequence
> sockets->dies->cores->threads. This works for most standard AMD and other
> vendors' configurations, but this decoding sequence does not follow that =
of
> AMD's APIC ID enumeration strictly. In some cases this can cause CPU topo=
logy
> inconsistency.  When booting a guest VM, the kernel tries to validate the
> topology, and finds it inconsistent with the enumeration of EPYC cpu mode=
ls.
>=20
> To fix the problem we need to build the topology as per the Processor
> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> Processors. It is available at https://www.amd.com/system/files/TechDocs/=
55570-B1_PUB.zip
>=20
> Here is the text from the PPR.
> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSize=
], the
> number of least significant bits in the Initial APIC ID that indicate cor=
e ID
> within a processor, in constructing per-core CPUID masks.
> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of cor=
es
> (MNC) that the processor could theoretically support, not the actual numb=
er of
> cores that are actually implemented or enabled on the processor, as indic=
ated
> by Core::X86::Cpuid::SizeId[NC].
> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> =E2=80=A2 ApicId[6] =3D Socket ID.
> =E2=80=A2 ApicId[5:4] =3D Node ID.
> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Lo=
gicalCoreID[1:0]}


After checking out all patches and some pondering, used here approach
looks to me too intrusive for the task at hand especially where it
comes to generic code.

(Ignore till =3D=3D=3D=3D to see suggestion how to simplify without reading
reasoning behind it first)

Lets look for a way to simplify it a little bit.

So problem we are trying to solve,
 1: calculate APIC IDs based on cpu type (to e more specific: for EPYC base=
d CPUs)
 2: it depends on knowing total number of numa nodes.

Externally workflow looks like following:
  1. user provides -smp x,sockets,cores,...,maxcpus
      that's used by possible_cpu_arch_ids() singleton to build list of
      possible CPUs (which is available to user via command 'hotpluggable-c=
pus')

      Hook could be called very early and possible_cpus data might be
      not complete. It builds a list of possible CPUs which user could
      modify later.

  2.1 user uses "-numa cpu,node-id=3Dx,..." or legacy "-numa node,node_id=
=3Dx,cpus=3D"
      options to assign cpus to nodes, which is one way or another calling
      machine_set_cpu_numa_node(). The later updates 'possible_cpus' list
      with node information. It happens early when total number of nodes
      is not available.

  2.2 user does not provide explicit node mappings for CPUs.
      QEMU steps in and assigns possible cpus to nodes in machine_numa_fini=
sh_cpu_init()
      (using the same machine_set_cpu_numa_node()) right before calling boa=
rds
      specific machine init(). At that time total number of nodes is known.

In 1 -- 2.1 cases, 'arch_id' in 'possible_cpus' list doesn't have to be def=
ined before
boards init() is run.

In 2.2 case it calls get_default_cpu_node_id() -> x86_get_default_cpu_node_=
id()
which uses arch_id calculate numa node.
But then question is: does it have to use APIC id or could it infer 'pkg_id=
',
it's after, from ms->possible_cpus->cpus[i].props data?
 =20
With that out of the way APIC ID will be used only during board's init(),
so board could update possible_cpus with valid APIC IDs at the start of
x86_cpus_init().

=3D=3D=3D=3D
in nutshell it would be much easier to do following:

 1. make x86_get_default_cpu_node_id() APIC ID in-depended or
    if impossible as alternative recompute APIC IDs there if cpu
    type is EPYC based (since number of nodes is already known)
 2. recompute APIC IDs in x86_cpus_init() if cpu type is EPYC based

this way one doesn't need to touch generic numa code, introduce
x86 specific init_apicid_fn() hook into generic code and keep
x86/EPYC nuances contained within x86 code only.

> v3:
>   1. Consolidated the topology information in structure X86CPUTopoInfo.
>   2. Changed the ccx_id to llc_id as commented by upstream.
>   3. Generalized the apic id decoding. It is mostly similar to current ap=
ic id
>      except that it adds new field llc_id when numa configured. Removes a=
ll the
>      hardcoded values.
>   4. Removed the earlier parse_numa split. And moved the numa node initia=
lization
>      inside the numa_complete_configuration. This is bit cleaner as comme=
nted by=20
>      Eduardo.
>   5. Added new function init_apicid_fn inside machine_class structure. Th=
is
>      will be used to update the apic id handler specific to cpu model.
>   6. Updated the cpuid unit tests.
>   7. TODO : Need to figure out how to dynamically update the handlers usi=
ng cpu models.
>      I might some guidance on that.
>=20
> v2:
>   https://lore.kernel.org/qemu-devel/156779689013.21957.16315515729506762=
12.stgit@localhost.localdomain/
>   1. Introduced the new property epyc to enable new epyc mode.
>   2. Separated the epyc mode and non epyc mode function.
>   3. Introduced function pointers in PCMachineState to handle the
>      differences.
>   4. Mildly tested different combinations to make things are working as e=
xpected.
>   5. TODO : Setting the epyc feature bit needs to be worked out. This fea=
ture is
>      supported only on AMD EPYC models. I may need some guidance on that.
>=20
> v1:
>   https://lore.kernel.org/qemu-devel/20190731232032.51786-1-babu.moger@am=
d.com/
>=20
> ---
>=20
> Babu Moger (18):
>       hw/i386: Rename X86CPUTopoInfo structure to X86CPUTopoIDs
>       hw/i386: Introduce X86CPUTopoInfo to contain topology info
>       hw/i386: Consolidate topology functions
>       hw/i386: Introduce initialize_topo_info to initialize X86CPUTopoInf=
o
>       machine: Add SMP Sockets in CpuTopology
>       hw/core: Add core complex id in X86CPU topology
>       machine: Add a new function init_apicid_fn in MachineClass
>       hw/i386: Update structures for nodes_per_pkg
>       i386: Add CPUX86Family type in CPUX86State
>       hw/386: Add EPYC mode topology decoding functions
>       i386: Cleanup and use the EPYC mode topology functions
>       numa: Split the numa initialization
>       hw/i386: Introduce apicid_from_cpu_idx in PCMachineState
>       hw/i386: Introduce topo_ids_from_apicid handler PCMachineState
>       hw/i386: Introduce apic_id_from_topo_ids handler in PCMachineState
>       hw/i386: Introduce EPYC mode function handlers
>       i386: Fix pkg_id offset for epyc mode
>       tests: Update the Unit tests
>=20
>=20
>  hw/core/machine-hmp-cmds.c |    3 +
>  hw/core/machine.c          |   14 +++
>  hw/core/numa.c             |   62 +++++++++----
>  hw/i386/pc.c               |  132 +++++++++++++++++++---------
>  include/hw/boards.h        |    3 +
>  include/hw/i386/pc.h       |    9 ++
>  include/hw/i386/topology.h |  209 +++++++++++++++++++++++++++++++-------=
------
>  include/sysemu/numa.h      |    5 +
>  qapi/machine.json          |    7 +
>  target/i386/cpu.c          |  196 ++++++++++++--------------------------=
---
>  target/i386/cpu.h          |    9 ++
>  tests/test-x86-cpuid.c     |  115 ++++++++++++++----------
>  vl.c                       |    4 +
>  13 files changed, 455 insertions(+), 313 deletions(-)
>=20
> --
>=20


