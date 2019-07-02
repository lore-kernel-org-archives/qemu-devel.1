Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2725CC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34C02082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiL5l-0001UH-2q
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp5-0007HY-21
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKp3-0005aY-6o
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:35:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKp1-0005Nn-6c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:35:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 982F83092650;
 Tue,  2 Jul 2019 15:35:37 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23C0A1001B0E;
 Tue,  2 Jul 2019 15:35:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:34:53 -0300
Message-Id: <20190702153535.9851-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 02 Jul 2019 15:35:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 00/42] Machine and x86 queue, 2019-07-02
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes v2 -> v3:
* Fix "make check" warnings (Igor Mammedov)
* Fix conflicts of "hw/arm: Replace global smp variables with
  machine smp properties" with recent arm changes (Eduardo Habkost)
* x86 versioned CPU models (Eduardo Habkost)
* SnowRidge CPU model (Paul Lai)
* Add deprecation information to query-machines (Eduardo Habkost)

Changes v1 -> v2:
* Fix s390x build failure

The following changes since commit c4e42a9c2b714de5cddabffe46c7789fcff49c=
30:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90701' into staging (2019-07-02 12:58:32 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 400e13541b2752900ad8ec9eb3deadc4df86a3b3:

  tests: use -numa memdev option in tests instead of legacy 'mem' option =
(2019-07-02 12:01:13 -0300)

----------------------------------------------------------------
Machine and x86 queue, 2019-07-02

* CPU die topology support (Like Xu)
* Deprecation of features (Igor Mammedov):
  * 'mem' parameter of '-numa node' option
  * implict memory distribution between NUMA nodes
  * deprecate -mem-path fallback to anonymous RAM
* x86 versioned CPU models (Eduardo Habkost)
* SnowRidge CPU model (Paul Lai)
* Add deprecation information to query-machines (Eduardo Habkost)
* Other i386 fixes

----------------------------------------------------------------

Queue for Machine Core patches


Alex Benn=C3=A9e (1):
  target/i386: fix feature check in hyperv-stub.c

Eduardo Habkost (14):
  hppa: Delete unused hppa_cpu_list() function
  i386: Don't print warning if phys-bits was set automatically
  i386: Fix signedness of hyperv_spinlock_attempts
  i386: Remove unused host_cpudef variable
  qmp: Add deprecation information to query-machines
  qmp: Add "alias-of" field to query-cpu-definitions
  i386: Add x-force-features option for testing
  i386: Get model-id from CPU object on "-cpu help"
  i386: Register versioned CPU models
  i386: Define -IBRS, -noTSX, -IBRS versions of CPU models
  i386: Replace -noTSX, -IBRS, -IBPB CPU models with aliases
  i386: Make unversioned CPU models be aliases
  docs: Deprecate CPU model runnability guarantees
  i386: Add Cascadelake-Server-v2 CPU model

Igor Mammedov (7):
  pc: fix possible NULL pointer dereference in
    pc_machine_get_device_memory_region_size()
  machine: show if CLI option '-numa node,mem' is supported in QAPI
    schema
  numa: deprecate 'mem' parameter of '-numa node' option
  numa: deprecate implict memory distribution between nodes
  deprecate -mem-path fallback to anonymous RAM
  numa: allow memory-less nodes when using memdev as backend
  tests: use -numa memdev option in tests instead of legacy 'mem' option

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

Paul Lai (1):
  i386: Introduce SnowRidge CPU model

Roman Kagan (1):
  i386: make 'hv-spinlocks' a regular uint32 property

Wei Yang (1):
  x86/cpu: use FeatureWordArray to define filtered_features

 qapi/misc.json                             |   16 +-
 qapi/target.json                           |    9 +-
 include/hw/boards.h                        |   27 +-
 include/hw/firmware/smbios.h               |    5 +-
 include/hw/i386/pc.h                       |    8 +-
 include/hw/i386/topology.h                 |   76 +-
 target/hppa/cpu.h                          |    2 -
 target/i386/cpu-qom.h                      |   10 +-
 target/i386/cpu.h                          |   36 +-
 accel/kvm/kvm-all.c                        |    4 +-
 backends/hostmem.c                         |    6 +-
 cpus.c                                     |    6 +-
 exec.c                                     |    3 +-
 gdbstub.c                                  |    4 +
 hw/alpha/dp264.c                           |    1 +
 hw/arm/aspeed.c                            |    2 +-
 hw/arm/fsl-imx6.c                          |    6 +-
 hw/arm/fsl-imx6ul.c                        |    6 +-
 hw/arm/fsl-imx7.c                          |    7 +-
 hw/arm/highbank.c                          |    1 +
 hw/arm/mcimx6ul-evk.c                      |    2 +-
 hw/arm/mcimx7d-sabre.c                     |    2 +-
 hw/arm/raspi.c                             |    4 +-
 hw/arm/realview.c                          |    1 +
 hw/arm/sabrelite.c                         |    2 +-
 hw/arm/sbsa-ref.c                          |    4 +
 hw/arm/vexpress.c                          |   16 +-
 hw/arm/virt.c                              |   11 +-
 hw/arm/xlnx-zynqmp.c                       |   16 +-
 hw/core/machine.c                          |   88 ++
 hw/cpu/core.c                              |    4 +-
 hw/hppa/machine.c                          |    4 +-
 hw/i386/acpi-build.c                       |   13 +-
 hw/i386/kvmvapic.c                         |    7 +-
 hw/i386/pc.c                               |  186 +++-
 hw/i386/pc_piix.c                          |    4 +
 hw/i386/pc_q35.c                           |    4 +
 hw/i386/xen/xen-hvm.c                      |    4 +
 hw/mips/boston.c                           |    2 +-
 hw/mips/mips_malta.c                       |   24 +-
 hw/openrisc/openrisc_sim.c                 |    1 +
 hw/ppc/e500.c                              |    3 +
 hw/ppc/mac_newworld.c                      |    3 +-
 hw/ppc/mac_oldworld.c                      |    3 +-
 hw/ppc/pnv.c                               |    9 +-
 hw/ppc/prep.c                              |    4 +-
 hw/ppc/spapr.c                             |   38 +-
 hw/ppc/spapr_rtas.c                        |    4 +-
 hw/riscv/sifive_e.c                        |    6 +-
 hw/riscv/sifive_plic.c                     |    3 +
 hw/riscv/sifive_u.c                        |    6 +-
 hw/riscv/spike.c                           |    3 +
 hw/riscv/virt.c                            |    1 +
 hw/s390x/s390-virtio-ccw.c                 |    9 +-
 hw/s390x/sclp.c                            |    2 +-
 hw/smbios/smbios.c                         |   26 +-
 hw/sparc/sun4m.c                           |    2 +
 hw/sparc64/sun4u.c                         |    4 +-
 hw/xtensa/sim.c                            |    2 +-
 hw/xtensa/xtfpga.c                         |    1 +
 migration/postcopy-ram.c                   |    8 +-
 monitor/hmp-cmds.c                         |    3 +
 monitor/qmp-cmds.c                         |    2 +-
 numa.c                                     |   31 +-
 target/arm/cpu.c                           |    8 +-
 target/hppa/cpu.c                          |   17 -
 target/i386/cpu.c                          | 1171 ++++++++++----------
 target/i386/hyperv-stub.c                  |    2 +-
 target/i386/kvm.c                          |   12 +
 target/openrisc/sys_helper.c               |    6 +-
 target/s390x/cpu.c                         |    3 +
 target/s390x/excp_helper.c                 |    5 +
 target/s390x/kvm.c                         |   10 +-
 tcg/tcg.c                                  |   13 +-
 tests/bios-tables-test.c                   |   40 +-
 tests/numa-test.c                          |   43 +-
 tests/test-x86-cpuid.c                     |   84 +-
 vl.c                                       |   98 +-
 qemu-deprecated.texi                       |   52 +
 qemu-options.hx                            |   17 +-
 tests/acceptance/x86_cpu_model_versions.py |  304 +++++
 81 files changed, 1729 insertions(+), 963 deletions(-)
 create mode 100644 tests/acceptance/x86_cpu_model_versions.py

--=20
2.18.0.rc1.1.g3f1ff2140


