Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A092C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 01:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8ED2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 01:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8ED2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgg9a-0001y8-CG
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 21:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49708)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgg7d-0008Qb-VO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgg7c-0007CB-0z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgg7a-000733-Dr
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:56:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E833A308FB82;
 Fri, 28 Jun 2019 01:56:11 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D42C5D71C;
 Fri, 28 Jun 2019 01:56:08 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 27 Jun 2019 22:55:37 -0300
Message-Id: <20190628015606.32107-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 28 Jun 2019 01:56:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/29] Machine next patches
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeac=
de:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-=
2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 99e5945a1e7369737c2ad65dfafc86cb63df9e7a:

  vl.c: Add -smp, dies=3D* command line support and update doc (2019-06-2=
6 14:38:13 -0300)

----------------------------------------------------------------
Machine and x86 queue, 2019-06-27

* CPU die topology support (Like Xu)
* Deprecation of features (Igor Mammedov):
  * 'mem' parameter of '-numa node' option
  * implict memory distribution between NUMA nodes
  * deprecate -mem-path fallback to anonymous RAM
* Other i386 fixes

----------------------------------------------------------------

Queue for Machine Core patches


Alex Benn=C3=A9e (1):
  target/i386: fix feature check in hyperv-stub.c

Eduardo Habkost (4):
  hppa: Delete unused hppa_cpu_list() function
  i386: Don't print warning if phys-bits was set automatically
  i386: Fix signedness of hyperv_spinlock_attempts
  i386: Remove unused host_cpudef variable

Igor Mammedov (5):
  pc: fix possible NULL pointer dereference in
    pc_machine_get_device_memory_region_size()
  machine: show if CLI option '-numa node,mem' is supported in QAPI
    schema
  numa: deprecate 'mem' parameter of '-numa node' option
  numa: deprecate implict memory distribution between nodes
  deprecate -mem-path fallback to anonymous RAM

Like Xu (17):
  hw/boards: Add struct CpuTopology to MachineState
  machine: Refactor smp-related call chains to pass MachineState
  general: Replace global smp variables with smp machine properties
  hw/ppc: Replace global smp variables with machine smp properties
  hw/riscv: Replace global smp variables with machine smp properties
  hw/s390x: Replace global smp variables with machine smp properties
  hw/i386: Replace global smp variables with machine smp properties
  hw/arm: Replace global smp variables with machine smp properties
  hw: Replace global smp variables with MachineState for all remaining
    archs
  vl.c: Replace smp global variables with smp machine properties
  i386: Add die-level cpu topology to x86CPU on PCMachine
  hw/i386: Adjust nr_dies with configured smp_dies for PCMachine
  i386/cpu: Consolidate die-id validity in smp context
  i386: Update new x86_apicid parsing rules with die_offset support
  target/i386: Add CPUID.1F generation support for multi-dies PCMachine
  machine: Refactor smp_parse() in vl.c as MachineClass::smp_parse()
  vl.c: Add -smp, dies=3D* command line support and update doc

Roman Kagan (1):
  i386: make 'hv-spinlocks' a regular uint32 property

Wei Yang (1):
  x86/cpu: use FeatureWordArray to define filtered_features

 qapi/misc.json               |  11 ++-
 include/hw/boards.h          |  27 +++++-
 include/hw/firmware/smbios.h |   5 +-
 include/hw/i386/pc.h         |   5 +-
 include/hw/i386/topology.h   |  76 +++++++++++----
 target/hppa/cpu.h            |   2 -
 target/i386/cpu.h            |   8 +-
 accel/kvm/kvm-all.c          |   4 +-
 backends/hostmem.c           |   6 +-
 cpus.c                       |   6 +-
 exec.c                       |   3 +-
 gdbstub.c                    |   4 +
 hw/alpha/dp264.c             |   1 +
 hw/arm/fsl-imx6.c            |   6 +-
 hw/arm/fsl-imx6ul.c          |   6 +-
 hw/arm/fsl-imx7.c            |   7 +-
 hw/arm/highbank.c            |   1 +
 hw/arm/mcimx6ul-evk.c        |   2 +-
 hw/arm/mcimx7d-sabre.c       |   2 +-
 hw/arm/raspi.c               |   4 +-
 hw/arm/realview.c            |   1 +
 hw/arm/sabrelite.c           |   2 +-
 hw/arm/vexpress.c            |  16 +--
 hw/arm/virt.c                |  11 ++-
 hw/arm/xlnx-zynqmp.c         |  16 +--
 hw/core/machine.c            |  88 +++++++++++++++++
 hw/cpu/core.c                |   4 +-
 hw/hppa/machine.c            |   4 +-
 hw/i386/acpi-build.c         |  13 ++-
 hw/i386/kvmvapic.c           |   7 +-
 hw/i386/pc.c                 | 183 +++++++++++++++++++++++++++++------
 hw/i386/xen/xen-hvm.c        |   4 +
 hw/mips/boston.c             |   2 +-
 hw/mips/mips_malta.c         |  24 ++---
 hw/openrisc/openrisc_sim.c   |   1 +
 hw/ppc/e500.c                |   3 +
 hw/ppc/mac_newworld.c        |   3 +-
 hw/ppc/mac_oldworld.c        |   3 +-
 hw/ppc/pnv.c                 |   9 +-
 hw/ppc/prep.c                |   4 +-
 hw/ppc/spapr.c               |  38 ++++++--
 hw/ppc/spapr_rtas.c          |   4 +-
 hw/riscv/sifive_e.c          |   6 +-
 hw/riscv/sifive_plic.c       |   3 +
 hw/riscv/sifive_u.c          |   6 +-
 hw/riscv/spike.c             |   3 +
 hw/riscv/virt.c              |   1 +
 hw/s390x/s390-virtio-ccw.c   |   9 +-
 hw/s390x/sclp.c              |   2 +-
 hw/smbios/smbios.c           |  26 ++---
 hw/sparc/sun4m.c             |   2 +
 hw/sparc64/sun4u.c           |   4 +-
 hw/xtensa/sim.c              |   2 +-
 hw/xtensa/xtfpga.c           |   1 +
 migration/postcopy-ram.c     |   8 +-
 monitor/hmp-cmds.c           |   3 +
 monitor/qmp-cmds.c           |   2 +-
 numa.c                       |  12 ++-
 target/arm/cpu.c             |   8 +-
 target/hppa/cpu.c            |  17 ----
 target/i386/cpu.c            | 130 +++++++++++++------------
 target/i386/hyperv-stub.c    |   2 +-
 target/i386/kvm.c            |  12 +++
 target/openrisc/sys_helper.c |   6 +-
 target/s390x/cpu.c           |   3 +
 target/s390x/excp_helper.c   |   5 +
 tcg/tcg.c                    |  13 ++-
 tests/test-x86-cpuid.c       |  84 ++++++++--------
 vl.c                         |  97 ++++---------------
 qemu-deprecated.texi         |  33 +++++++
 qemu-options.hx              |  17 ++--
 71 files changed, 773 insertions(+), 370 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140


