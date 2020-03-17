Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1834C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C87206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4gu9+5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C87206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELvX-0002XU-MH
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jELuf-0001iP-Tu
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jELub-0004cx-Rk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:46:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51979)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jELub-0004Zl-Ly
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584488776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTd7AvRls55xk9M4wyMkiHNSNPTiOeSfPEoFDuzJrx0=;
 b=c4gu9+5F9FJ/6yLOvo2onWDDFc+ALoDkBsmk6l56vyFcqht36p9CtpIHkcUGMPZ8ZXz7fC
 hGc60EiAXbWVpE4iVfPTmxupMYhmmAXrnuJdqX3nD4WM63gC4YND+h29pr3puMGaJ+vsgV
 zhSDdYGxsZB8gmDQmHSc1xUG349QPNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-_mAaFdGWNMCEBafoieAaDg-1; Tue, 17 Mar 2020 19:46:15 -0400
X-MC-Unique: _mAaFdGWNMCEBafoieAaDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC379477;
 Tue, 17 Mar 2020 23:46:13 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A64D1001B3F;
 Tue, 17 Mar 2020 23:46:10 +0000 (UTC)
Date: Tue, 17 Mar 2020 19:46:08 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 00/13] APIC ID fixes for AMD EPYC CPU model
Message-ID: <20200317234608.GI1817047@habkost.net>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <5a90d4e6-5f7f-5a8d-6895-3b5f9890b58b@amd.com>
 <20200317232201.GH1817047@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200317232201.GH1817047@habkost.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Tue, Mar 17, 2020 at 07:22:06PM -0400, Eduardo Habkost wrote:
> On Thu, Mar 12, 2020 at 11:28:47AM -0500, Babu Moger wrote:
> > Eduardo, Can you please queue the series if there are no concerns.
> > Thanks
>=20
> I had queued it for today's pull request, but it looks like it
> breaks "make check".  See https://travis-ci.org/github/ehabkost/qemu/jobs=
/663529282
>=20
>   PASS 4 bios-tables-test /x86_64/acpi/piix4/ipmi
>   Could not access KVM kernel module: No such file or directory
>   qemu-system-x86_64: -accel kvm: failed to initialize kvm: No such file =
or directory
>   qemu-system-x86_64: falling back to tcg
>   qemu-system-x86_64: Invalid CPU [socket: 0, die: 0, core: 1, thread: 0]=
 with APIC ID 1, valid index range 0:5
>   Broken pipe
>   /home/travis/build/ehabkost/qemu/tests/qtest/libqtest.c:166: kill_qemu(=
) tried to terminate QEMU process but encountered exit status 1 (expected 0=
)
>   Aborted (core dumped)
>   ERROR - too few tests run (expected 17, got 4)
>   /home/travis/build/ehabkost/qemu/tests/Makefile.include:633: recipe for=
 target 'check-qtest-x86_64' failed
>   make: *** [check-qtest-x86_64] Error 1

Failure is at the /x86_64/acpi/piix4/cpuhp test case:

  $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3D=
qemu-img tests/qtest/bios-tables-test -m=3Dquick --verbose --debug-log
  [...]
  {*LOG(start):{/x86_64/acpi/piix4/cpuhp}:LOG*}
  # starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qtest unix:/tmp/=
qtest-2052313.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-2=
052313.qmp,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -ma=
chine pc,kernel-irqchip=3Doff -accel kvm -accel tcg -net none -display none=
 -smp 2,cores=3D3,sockets=3D2,maxcpus=3D6 -object memory-backend-ram,id=3Dr=
am0,size=3D64M -object memory-backend-ram,id=3Dram1,size=3D64M -numa node,m=
emdev=3Dram0 -numa node,memdev=3Dram1 -numa dist,src=3D0,dst=3D1,val=3D21 -=
drive id=3Dhd0,if=3Dnone,file=3Dtests/acpi-test-disk-PVjFru,format=3Draw -d=
evice ide-hd,drive=3Dhd0  -accel qtest
  {*LOG(message):{starting QEMU: exec x86_64-softmmu/qemu-system-x86_64 -qt=
est unix:/tmp/qtest-2052313.sock -qtest-log /dev/null -chardev socket,path=
=3D/tmp/qtest-2052313.qmp,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -d=
isplay none -machine pc,kernel-irqchip=3Doff -accel kvm -accel tcg -net non=
e -display none -smp 2,cores=3D3,sockets=3D2,maxcpus=3D6 -object memory-bac=
kend-ram,id=3Dram0,size=3D64M -object memory-backend-ram,id=3Dram1,size=3D6=
4M -numa node,memdev=3Dram0 -numa node,memdev=3Dram1 -numa dist,src=3D0,dst=
=3D1,val=3D21 -drive id=3Dhd0,if=3Dnone,file=3Dtests/acpi-test-disk-PVjFru,=
format=3Draw -device ide-hd,drive=3Dhd0  -accel qtest}:LOG*}
  qemu-system-x86_64: Invalid CPU [socket: 0, die: 0, core: 1, thread: 0] w=
ith APIC ID 1, valid index range 0:5
  Broken pipe


>=20
>=20
> >=20
> > On 3/11/20 5:52 PM, Babu Moger wrote:
> > > This series fixes APIC ID encoding problem reported on AMD EPYC cpu m=
odels.
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166
> > >=20
> > > Currently, the APIC ID is decoded based on the sequence
> > > sockets->dies->cores->threads. This works for most standard AMD and o=
ther
> > > vendors' configurations, but this decoding sequence does not follow t=
hat of
> > > AMD's APIC ID enumeration strictly. In some cases this can cause CPU =
topology
> > > inconsistency.  When booting a guest VM, the kernel tries to validate=
 the
> > > topology, and finds it inconsistent with the enumeration of EPYC cpu =
models.
> > >=20
> > > To fix the problem we need to build the topology as per the Processor
> > > Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> > > Processors. The documentation is available from the bugzilla Link bel=
ow.
> > >=20
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> > >=20
> > > Here is the text from the PPR.
> > > Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicId=
Size], the
> > > number of least significant bits in the Initial APIC ID that indicate=
 core ID
> > > within a processor, in constructing per-core CPUID masks.
> > > Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of=
 cores
> > > (MNC) that the processor could theoretically support, not the actual =
number of
> > > cores that are actually implemented or enabled on the processor, as i=
ndicated
> > > by Core::X86::Cpuid::SizeId[NC].
> > > Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> > > =E2=80=A2 ApicId[6] =3D Socket ID.
> > > =E2=80=A2 ApicId[5:4] =3D Node ID.
> > > =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> > > =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b=
0,LogicalCoreID[1:0]}
> > >=20
> > > v7:
> > >  Generated the patches on top of git://github.com/ehabkost/qemu.git (=
x86-next).
> > >  Changes from v6.
> > >  1. Added new function x86_set_epyc_topo_handlers to override the api=
c id
> > >     encoding handlers.
> > >  2. Separated the code to set use_epyc_apic_id_encoding and added as =
a new patch
> > >     as it looked more logical.
> > >  3. Fixed minor typos.
> > >=20
> > > v6:
> > >  https://lore.kernel.org/qemu-devel/158389385028.22020.76082446273031=
32902.stgit@naples-babu.amd.com/
> > >  Generated the patches on top of git://github.com/ehabkost/qemu.git (=
x86-next).
> > >  Changes from v5.
> > >  1. Eduardo has already queued couple of patches, submitting the rest=
 here.
> > >  2. Major change is how the EPYC mode apic id encoding handlers are l=
oaded.
> > >     Added a boolean variable use_epyc_apic_id_encoding in X86CPUDefin=
ition.=20
> > >     The variable is will be used to tell if we need to use EPYC mode =
encoding.
> > >  3. Eduardo reported bysectability problem with x86 unit test code.
> > >     Quashed the patches in 1 and 2 to resolve it. Problem was change =
in calling
> > >     conventions of topology related functions.
> > >  4. Also set the use_epyc_apic_id_encoding for EPYC-Rome. This model =
is
> > >     added recently to the cpu table.
> > >=20
> > > v5:
> > >  https://lore.kernel.org/qemu-devel/158326531474.40452.11433722850425=
537745.stgit@naples-babu.amd.com/
> > >  Generated the patches on top of git://github.com/ehabkost/qemu.git (=
x86-next).
> > >  Changes from v4.
> > >  1. Re-arranged the patches 2 and 4 as suggested by Igor.
> > >  2. Kept the apicid handler functions inside X86MachineState as discu=
ssed.
> > >     These handlers are loaded from X86CPUDefinitions.
> > >  3. Removed unnecessary X86CPUstate initialization from x86_cpu_new. =
Suggested
> > >     by Igor.
> > >  4. And other minor changes related to patch format.
> > >=20
> > > v4:
> > >  https://lore.kernel.org/qemu-devel/158161767653.48948.10578064482878=
399556.stgit@naples-babu.amd.com/
> > >  Changes from v3.
> > >  1. Moved the arch_id calculation inside the function x86_cpus_init. =
With this change,
> > >     we dont need to change common numa code.(suggested by Igor)
> > >  2. Introduced the model specific handlers inside X86CPUDefinitions.
> > >     These handlers are loaded into X86MachineState during the init.
> > >  3. Removed llc_id from x86CPU.
> > >  4. Removed init_apicid_fn hanlder from MachineClass. Kept all the co=
de changes
> > >     inside the x86.
> > >  5. Added new handler function apicid_pkg_offset for pkg_offset calcu=
lation.
> > >  6. And some Other minor changes.
> > >=20
> > > v3:
> > >   https://lore.kernel.org/qemu-devel/157541968844.46157.1799491814253=
3791313.stgit@naples-babu.amd.com/=20
> > >   1. Consolidated the topology information in structure X86CPUTopoInf=
o.
> > >   2. Changed the ccx_id to llc_id as commented by upstream.
> > >   3. Generalized the apic id decoding. It is mostly similar to curren=
t apic id
> > >      except that it adds new field llc_id when numa configured. Remov=
es all the
> > >      hardcoded values.
> > >   4. Removed the earlier parse_numa split. And moved the numa node in=
itialization
> > >      inside the numa_complete_configuration. This is bit cleaner as c=
ommented by=20
> > >      Eduardo.
> > >   5. Added new function init_apicid_fn inside machine_class structure=
. This
> > >      will be used to update the apic id handler specific to cpu model=
.
> > >   6. Updated the cpuid unit tests.
> > >   7. TODO : Need to figure out how to dynamically update the handlers=
 using cpu models.
> > >      I might some guidance on that.
> > >=20
> > > v2:
> > >   https://lore.kernel.org/qemu-devel/156779689013.21957.1631551572950=
676212.stgit@localhost.localdomain/
> > >   1. Introduced the new property epyc to enable new epyc mode.
> > >   2. Separated the epyc mode and non epyc mode function.
> > >   3. Introduced function pointers in PCMachineState to handle the
> > >      differences.
> > >   4. Mildly tested different combinations to make things are working =
as expected.
> > >   5. TODO : Setting the epyc feature bit needs to be worked out. This=
 feature is
> > >      supported only on AMD EPYC models. I may need some guidance on t=
hat.
> > >=20
> > > v1:
> > >   https://lore.kernel.org/qemu-devel/20190731232032.51786-1-babu.moge=
r@amd.com/
> > > ---
> > >=20
> > > Babu Moger (13):
> > >       hw/i386: Introduce X86CPUTopoInfo to contain topology info
> > >       hw/i386: Consolidate topology functions
> > >       machine: Add SMP Sockets in CpuTopology
> > >       hw/i386: Remove unnecessary initialization in x86_cpu_new
> > >       hw/i386: Update structures to save the number of nodes per pack=
age
> > >       hw/i386: Rename apicid_from_topo_ids to x86_apicid_from_topo_id=
s
> > >       hw/386: Add EPYC mode topology decoding functions
> > >       target/i386: Cleanup and use the EPYC mode topology functions
> > >       hw/i386: Introduce apicid functions inside X86MachineState
> > >       i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition
> > >       hw/i386: Move arch_id decode inside x86_cpus_init
> > >       target/i386: Enable new apic id encoding for EPYC based cpus mo=
dels
> > >       i386: Fix pkg_id offset for EPYC cpu models
> > >=20
> > >=20
> > >  hw/core/machine.c          |    1=20
> > >  hw/i386/pc.c               |   15 ++-
> > >  hw/i386/x86.c              |   73 ++++++++++++----
> > >  include/hw/boards.h        |    2=20
> > >  include/hw/i386/topology.h |  195 ++++++++++++++++++++++++++++++----=
--------
> > >  include/hw/i386/x86.h      |   12 +++
> > >  softmmu/vl.c               |    1=20
> > >  target/i386/cpu.c          |  203 ++++++++++++++--------------------=
----------
> > >  target/i386/cpu.h          |    3 +
> > >  tests/test-x86-cpuid.c     |  116 +++++++++++++++----------
> > >  10 files changed, 358 insertions(+), 263 deletions(-)
> > >=20
> > > --
> > > Signature
> > >=20
> >=20
>=20
> --=20
> Eduardo

--=20
Eduardo


