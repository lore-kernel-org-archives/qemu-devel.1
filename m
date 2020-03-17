Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98444C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5620520674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDMAC1po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5620520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELZ3-0007au-BQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jELXO-0004zS-1l
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jELXM-0005If-14
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:22:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37993)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jELXL-0005Gq-S5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Nb6bVpCk8EsM39r8dzR4WMqZQIqa0quSVECt+5VBEw=;
 b=WDMAC1poxIlLY6q4HVdMIHLCqw73RPclxWB0xx8lKzJIkpx0+vus2lAl4KFBtmW+EqujyY
 FQUmxeDMxP6gAiSoWs4zf6Zh8whfTt/E5ZTIC2RCCiT1ODTZQ9ZGKmoYaQqIgJSJUHs0Tw
 Y1tXAuCmZ+cyqM/+XqEIWX8Nx5eJGMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-QSIbhtrcPGC1LLnsrII1FA-1; Tue, 17 Mar 2020 19:22:07 -0400
X-MC-Unique: QSIbhtrcPGC1LLnsrII1FA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F38DB2B;
 Tue, 17 Mar 2020 23:22:05 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E463160BEE;
 Tue, 17 Mar 2020 23:22:02 +0000 (UTC)
Date: Tue, 17 Mar 2020 19:22:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 00/13] APIC ID fixes for AMD EPYC CPU model
Message-ID: <20200317232201.GH1817047@habkost.net>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <5a90d4e6-5f7f-5a8d-6895-3b5f9890b58b@amd.com>
MIME-Version: 1.0
In-Reply-To: <5a90d4e6-5f7f-5a8d-6895-3b5f9890b58b@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 11:28:47AM -0500, Babu Moger wrote:
> Eduardo, Can you please queue the series if there are no concerns.
> Thanks

I had queued it for today's pull request, but it looks like it
breaks "make check".  See https://travis-ci.org/github/ehabkost/qemu/jobs/6=
63529282

  PASS 4 bios-tables-test /x86_64/acpi/piix4/ipmi
  Could not access KVM kernel module: No such file or directory
  qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file or=
 directory
  qemu-system-x86_64: falling back to tcg
  qemu-system-x86_64: Invalid CPU [socket: 0, die: 0, core: 1, thread: 0] w=
ith APIC ID 1, valid index range 0:5
  Broken pipe
  /home/travis/build/ehabkost/qemu/tests/qtest/libqtest.c:166: kill_qemu() =
tried to terminate QEMU process but encountered exit status 1 (expected 0)
  Aborted (core dumped)
  ERROR - too few tests run (expected 17, got 4)
  /home/travis/build/ehabkost/qemu/tests/Makefile.include:633: recipe for t=
arget 'check-qtest-x86_64' failed
  make: *** [check-qtest-x86_64] Error 1


>=20
> On 3/11/20 5:52 PM, Babu Moger wrote:
> > This series fixes APIC ID encoding problem reported on AMD EPYC cpu mod=
els.
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166
> >=20
> > Currently, the APIC ID is decoded based on the sequence
> > sockets->dies->cores->threads. This works for most standard AMD and oth=
er
> > vendors' configurations, but this decoding sequence does not follow tha=
t of
> > AMD's APIC ID enumeration strictly. In some cases this can cause CPU to=
pology
> > inconsistency.  When booting a guest VM, the kernel tries to validate t=
he
> > topology, and finds it inconsistent with the enumeration of EPYC cpu mo=
dels.
> >=20
> > To fix the problem we need to build the topology as per the Processor
> > Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> > Processors. The documentation is available from the bugzilla Link below=
.
> >=20
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> >=20
> > Here is the text from the PPR.
> > Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSi=
ze], the
> > number of least significant bits in the Initial APIC ID that indicate c=
ore ID
> > within a processor, in constructing per-core CPUID masks.
> > Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of c=
ores
> > (MNC) that the processor could theoretically support, not the actual nu=
mber of
> > cores that are actually implemented or enabled on the processor, as ind=
icated
> > by Core::X86::Cpuid::SizeId[NC].
> > Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> > =E2=80=A2 ApicId[6] =3D Socket ID.
> > =E2=80=A2 ApicId[5:4] =3D Node ID.
> > =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> > =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,=
LogicalCoreID[1:0]}
> >=20
> > v7:
> >  Generated the patches on top of git://github.com/ehabkost/qemu.git (x8=
6-next).
> >  Changes from v6.
> >  1. Added new function x86_set_epyc_topo_handlers to override the apic =
id
> >     encoding handlers.
> >  2. Separated the code to set use_epyc_apic_id_encoding and added as a =
new patch
> >     as it looked more logical.
> >  3. Fixed minor typos.
> >=20
> > v6:
> >  https://lore.kernel.org/qemu-devel/158389385028.22020.7608244627303132=
902.stgit@naples-babu.amd.com/
> >  Generated the patches on top of git://github.com/ehabkost/qemu.git (x8=
6-next).
> >  Changes from v5.
> >  1. Eduardo has already queued couple of patches, submitting the rest h=
ere.
> >  2. Major change is how the EPYC mode apic id encoding handlers are loa=
ded.
> >     Added a boolean variable use_epyc_apic_id_encoding in X86CPUDefinit=
ion.=20
> >     The variable is will be used to tell if we need to use EPYC mode en=
coding.
> >  3. Eduardo reported bysectability problem with x86 unit test code.
> >     Quashed the patches in 1 and 2 to resolve it. Problem was change in=
 calling
> >     conventions of topology related functions.
> >  4. Also set the use_epyc_apic_id_encoding for EPYC-Rome. This model is
> >     added recently to the cpu table.
> >=20
> > v5:
> >  https://lore.kernel.org/qemu-devel/158326531474.40452.1143372285042553=
7745.stgit@naples-babu.amd.com/
> >  Generated the patches on top of git://github.com/ehabkost/qemu.git (x8=
6-next).
> >  Changes from v4.
> >  1. Re-arranged the patches 2 and 4 as suggested by Igor.
> >  2. Kept the apicid handler functions inside X86MachineState as discuss=
ed.
> >     These handlers are loaded from X86CPUDefinitions.
> >  3. Removed unnecessary X86CPUstate initialization from x86_cpu_new. Su=
ggested
> >     by Igor.
> >  4. And other minor changes related to patch format.
> >=20
> > v4:
> >  https://lore.kernel.org/qemu-devel/158161767653.48948.1057806448287839=
9556.stgit@naples-babu.amd.com/
> >  Changes from v3.
> >  1. Moved the arch_id calculation inside the function x86_cpus_init. Wi=
th this change,
> >     we dont need to change common numa code.(suggested by Igor)
> >  2. Introduced the model specific handlers inside X86CPUDefinitions.
> >     These handlers are loaded into X86MachineState during the init.
> >  3. Removed llc_id from x86CPU.
> >  4. Removed init_apicid_fn hanlder from MachineClass. Kept all the code=
 changes
> >     inside the x86.
> >  5. Added new handler function apicid_pkg_offset for pkg_offset calcula=
tion.
> >  6. And some Other minor changes.
> >=20
> > v3:
> >   https://lore.kernel.org/qemu-devel/157541968844.46157.179949181425337=
91313.stgit@naples-babu.amd.com/=20
> >   1. Consolidated the topology information in structure X86CPUTopoInfo.
> >   2. Changed the ccx_id to llc_id as commented by upstream.
> >   3. Generalized the apic id decoding. It is mostly similar to current =
apic id
> >      except that it adds new field llc_id when numa configured. Removes=
 all the
> >      hardcoded values.
> >   4. Removed the earlier parse_numa split. And moved the numa node init=
ialization
> >      inside the numa_complete_configuration. This is bit cleaner as com=
mented by=20
> >      Eduardo.
> >   5. Added new function init_apicid_fn inside machine_class structure. =
This
> >      will be used to update the apic id handler specific to cpu model.
> >   6. Updated the cpuid unit tests.
> >   7. TODO : Need to figure out how to dynamically update the handlers u=
sing cpu models.
> >      I might some guidance on that.
> >=20
> > v2:
> >   https://lore.kernel.org/qemu-devel/156779689013.21957.163155157295067=
6212.stgit@localhost.localdomain/
> >   1. Introduced the new property epyc to enable new epyc mode.
> >   2. Separated the epyc mode and non epyc mode function.
> >   3. Introduced function pointers in PCMachineState to handle the
> >      differences.
> >   4. Mildly tested different combinations to make things are working as=
 expected.
> >   5. TODO : Setting the epyc feature bit needs to be worked out. This f=
eature is
> >      supported only on AMD EPYC models. I may need some guidance on tha=
t.
> >=20
> > v1:
> >   https://lore.kernel.org/qemu-devel/20190731232032.51786-1-babu.moger@=
amd.com/
> > ---
> >=20
> > Babu Moger (13):
> >       hw/i386: Introduce X86CPUTopoInfo to contain topology info
> >       hw/i386: Consolidate topology functions
> >       machine: Add SMP Sockets in CpuTopology
> >       hw/i386: Remove unnecessary initialization in x86_cpu_new
> >       hw/i386: Update structures to save the number of nodes per packag=
e
> >       hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_ids
> >       hw/386: Add EPYC mode topology decoding functions
> >       target/i386: Cleanup and use the EPYC mode topology functions
> >       hw/i386: Introduce apicid functions inside X86MachineState
> >       i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition
> >       hw/i386: Move arch_id decode inside x86_cpus_init
> >       target/i386: Enable new apic id encoding for EPYC based cpus mode=
ls
> >       i386: Fix pkg_id offset for EPYC cpu models
> >=20
> >=20
> >  hw/core/machine.c          |    1=20
> >  hw/i386/pc.c               |   15 ++-
> >  hw/i386/x86.c              |   73 ++++++++++++----
> >  include/hw/boards.h        |    2=20
> >  include/hw/i386/topology.h |  195 ++++++++++++++++++++++++++++++------=
------
> >  include/hw/i386/x86.h      |   12 +++
> >  softmmu/vl.c               |    1=20
> >  target/i386/cpu.c          |  203 ++++++++++++++----------------------=
--------
> >  target/i386/cpu.h          |    3 +
> >  tests/test-x86-cpuid.c     |  116 +++++++++++++++----------
> >  10 files changed, 358 insertions(+), 263 deletions(-)
> >=20
> > --
> > Signature
> >=20
>=20

--=20
Eduardo


