Received: from eggs.gnu.org ([2001:4830:134:3::10]:47649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK7w-0006jw-U2
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK7n-00031f-3b
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK7m-00030J-OL
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:03 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:30 +0100
Message-Id: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 00/20] Move target-* CPU file into a
 target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

After my RFC last week that did not move all folder yet, here's now
a patch series that moves all target-* folders into one subfolder:

We've currently got 18 architectures in QEMU, and thus 18 target-xxx
folders in the root folder of the QEMU source tree. More architectures
(e.g. RISC-V, AVR) are likely to be included soon, too, so the main
folder of the QEMU sources slowly gets quite overcrowded with the
target-xxx folders.
Thus I'd like to suggest that we move the target-xxx folders into
a dedicated target/ folder, so that target-xxx/ simply becomes
target/xxx/ instead.

The first patch prepares the build system to be able to deal with both,
target-xxx and target/xxx folders. Once that has been applied, each
target architecture can be moved individually into the target/ folder.

The final patch then removes the possibility of using the old scheme
for a CPU target - all targets now have to reside in the target/ folder.

Thomas Huth (20):
  Makefile: Allow CPU targets to reside in target/ folder, too
  tilegx: Move CPU files to target/ folder
  m68k: Move CPU files to target/ folder
  alpha: Move CPU files to target/ folder
  arm: Move CPU files to target/ folder
  ppc: Move CPU files to target/ folder
  i386: Move CPU files to target/ folder
  microblaze: Move CPU files to target/ folder
  mips: Move CPU files to target/ folder
  s390x: Move CPU files to target/ folder
  sparc: Move CPU files to target/ folder
  cris: Move CPU files to target/ folder
  lm32: Move CPU files to target/ folder
  moxie: Move CPU files to target/ folder
  openrisc: Move CPU files to target/ folder
  sh4: Move CPU files to target/ folder
  tricore: Move CPU files to target/ folder
  unicore32: Move CPU files to target/ folder
  xtensa: Move CPU files to target/ folder
  Makefile.target: Targets now have to reside in the target/ folder

 MAINTAINERS                                        | 48 +++++++++++-----------
 Makefile.objs                                      | 10 ++---
 Makefile.target                                    |  6 ++-
 disas/cris.c                                       |  4 +-
 hw/alpha/alpha_sys.h                               |  2 +-
 hw/arm/strongarm.h                                 |  2 +-
 hw/arm/virt-acpi-build.c                           |  2 +-
 hw/i386/acpi-build.c                               |  2 +-
 hw/i386/kvm/apic.c                                 |  2 +-
 hw/intc/ioapic.c                                   |  2 +-
 hw/misc/hyperv_testdev.c                           |  2 +-
 hw/ppc/fdt.c                                       |  2 +-
 hw/ppc/pnv.c                                       |  2 +-
 hw/ppc/pnv_core.c                                  |  2 +-
 hw/ppc/pnv_lpc.c                                   |  2 +-
 hw/ppc/pnv_xscom.c                                 |  2 +-
 hw/ppc/spapr_cpu_core.c                            |  6 +--
 hw/sh4/shix.c                                      |  2 +-
 include/hw/arm/arm.h                               |  2 +-
 include/hw/arm/exynos4210.h                        |  2 +-
 include/hw/arm/omap.h                              |  2 +-
 include/hw/arm/pxa.h                               |  2 +-
 include/hw/m68k/mcf.h                              |  2 +-
 include/hw/mips/cpudevs.h                          |  2 +-
 include/hw/ppc/fdt.h                               |  2 +-
 include/hw/ppc/ppc.h                               |  2 +-
 include/hw/ppc/spapr_cpu_core.h                    |  2 +-
 include/hw/sh4/sh.h                                |  2 +-
 scripts/analyze-inclusions                         |  6 +--
 {target-alpha => target/alpha}/Makefile.objs       |  0
 {target-alpha => target/alpha}/STATUS              |  0
 {target-alpha => target/alpha}/cpu-qom.h           |  0
 {target-alpha => target/alpha}/cpu.c               |  0
 {target-alpha => target/alpha}/cpu.h               |  0
 {target-alpha => target/alpha}/fpu_helper.c        |  0
 {target-alpha => target/alpha}/gdbstub.c           |  0
 {target-alpha => target/alpha}/helper.c            |  0
 {target-alpha => target/alpha}/helper.h            |  0
 {target-alpha => target/alpha}/int_helper.c        |  0
 {target-alpha => target/alpha}/machine.c           |  0
 {target-alpha => target/alpha}/mem_helper.c        |  0
 {target-alpha => target/alpha}/sys_helper.c        |  0
 {target-alpha => target/alpha}/translate.c         |  0
 {target-alpha => target/alpha}/vax_helper.c        |  0
 {target-arm => target/arm}/Makefile.objs           |  0
 {target-arm => target/arm}/arch_dump.c             |  0
 {target-arm => target/arm}/arm-powerctl.c          |  0
 {target-arm => target/arm}/arm-powerctl.h          |  0
 {target-arm => target/arm}/arm-semi.c              |  0
 {target-arm => target/arm}/arm_ldst.h              |  0
 {target-arm => target/arm}/cpu-qom.h               |  0
 {target-arm => target/arm}/cpu.c                   |  0
 {target-arm => target/arm}/cpu.h                   |  0
 {target-arm => target/arm}/cpu64.c                 |  0
 {target-arm => target/arm}/crypto_helper.c         |  0
 {target-arm => target/arm}/gdbstub.c               |  0
 {target-arm => target/arm}/gdbstub64.c             |  0
 {target-arm => target/arm}/helper-a64.c            |  0
 {target-arm => target/arm}/helper-a64.h            |  0
 {target-arm => target/arm}/helper.c                |  0
 {target-arm => target/arm}/helper.h                |  0
 {target-arm => target/arm}/internals.h             |  0
 {target-arm => target/arm}/iwmmxt_helper.c         |  0
 {target-arm => target/arm}/kvm-consts.h            |  0
 {target-arm => target/arm}/kvm-stub.c              |  0
 {target-arm => target/arm}/kvm.c                   |  0
 {target-arm => target/arm}/kvm32.c                 |  0
 {target-arm => target/arm}/kvm64.c                 |  0
 {target-arm => target/arm}/kvm_arm.h               |  0
 {target-arm => target/arm}/machine.c               |  0
 {target-arm => target/arm}/monitor.c               |  0
 {target-arm => target/arm}/neon_helper.c           |  0
 {target-arm => target/arm}/op_addsub.h             |  0
 {target-arm => target/arm}/op_helper.c             |  0
 {target-arm => target/arm}/psci.c                  |  0
 {target-arm => target/arm}/trace-events            |  2 +-
 {target-arm => target/arm}/translate-a64.c         |  0
 {target-arm => target/arm}/translate.c             |  0
 {target-arm => target/arm}/translate.h             |  0
 {target-cris => target/cris}/Makefile.objs         |  0
 {target-cris => target/cris}/cpu-qom.h             |  0
 {target-cris => target/cris}/cpu.c                 |  0
 {target-cris => target/cris}/cpu.h                 |  0
 {target-cris => target/cris}/crisv10-decode.h      |  0
 {target-cris => target/cris}/crisv32-decode.h      |  0
 {target-cris => target/cris}/gdbstub.c             |  0
 {target-cris => target/cris}/helper.c              |  0
 {target-cris => target/cris}/helper.h              |  0
 {target-cris => target/cris}/machine.c             |  0
 {target-cris => target/cris}/mmu.c                 |  0
 {target-cris => target/cris}/mmu.h                 |  0
 {target-cris => target/cris}/op_helper.c           |  0
 {target-cris => target/cris}/opcode-cris.h         |  0
 {target-cris => target/cris}/translate.c           |  0
 {target-cris => target/cris}/translate_v10.c       |  0
 {target-i386 => target/i386}/Makefile.objs         |  0
 {target-i386 => target/i386}/TODO                  |  0
 {target-i386 => target/i386}/arch_dump.c           |  0
 {target-i386 => target/i386}/arch_memory_mapping.c |  0
 {target-i386 => target/i386}/bpt_helper.c          |  0
 {target-i386 => target/i386}/cc_helper.c           |  0
 {target-i386 => target/i386}/cc_helper_template.h  |  0
 {target-i386 => target/i386}/cpu-qom.h             |  0
 {target-i386 => target/i386}/cpu.c                 |  0
 {target-i386 => target/i386}/cpu.h                 |  0
 {target-i386 => target/i386}/excp_helper.c         |  0
 {target-i386 => target/i386}/fpu_helper.c          |  0
 {target-i386 => target/i386}/gdbstub.c             |  0
 {target-i386 => target/i386}/helper.c              |  0
 {target-i386 => target/i386}/helper.h              |  0
 {target-i386 => target/i386}/hyperv.c              |  0
 {target-i386 => target/i386}/hyperv.h              |  0
 {target-i386 => target/i386}/int_helper.c          |  0
 {target-i386 => target/i386}/kvm-stub.c            |  0
 {target-i386 => target/i386}/kvm.c                 |  0
 {target-i386 => target/i386}/kvm_i386.h            |  0
 {target-i386 => target/i386}/machine.c             |  0
 {target-i386 => target/i386}/mem_helper.c          |  0
 {target-i386 => target/i386}/misc_helper.c         |  0
 {target-i386 => target/i386}/monitor.c             |  0
 {target-i386 => target/i386}/mpx_helper.c          |  0
 {target-i386 => target/i386}/ops_sse.h             |  0
 {target-i386 => target/i386}/ops_sse_header.h      |  0
 {target-i386 => target/i386}/seg_helper.c          |  0
 .../i386}/shift_helper_template.h                  |  0
 {target-i386 => target/i386}/smm_helper.c          |  0
 {target-i386 => target/i386}/svm.h                 |  0
 {target-i386 => target/i386}/svm_helper.c          |  0
 {target-i386 => target/i386}/trace-events          |  2 +-
 {target-i386 => target/i386}/translate.c           |  0
 {target-lm32 => target/lm32}/Makefile.objs         |  0
 {target-lm32 => target/lm32}/README                |  0
 {target-lm32 => target/lm32}/TODO                  |  0
 {target-lm32 => target/lm32}/cpu-qom.h             |  0
 {target-lm32 => target/lm32}/cpu.c                 |  0
 {target-lm32 => target/lm32}/cpu.h                 |  0
 {target-lm32 => target/lm32}/gdbstub.c             |  0
 {target-lm32 => target/lm32}/helper.c              |  0
 {target-lm32 => target/lm32}/helper.h              |  0
 {target-lm32 => target/lm32}/lm32-semi.c           |  0
 {target-lm32 => target/lm32}/machine.c             |  0
 {target-lm32 => target/lm32}/op_helper.c           |  0
 {target-lm32 => target/lm32}/translate.c           |  0
 {target-m68k => target/m68k}/Makefile.objs         |  0
 {target-m68k => target/m68k}/cpu-qom.h             |  0
 {target-m68k => target/m68k}/cpu.c                 |  0
 {target-m68k => target/m68k}/cpu.h                 |  0
 {target-m68k => target/m68k}/gdbstub.c             |  0
 {target-m68k => target/m68k}/helper.c              |  0
 {target-m68k => target/m68k}/helper.h              |  0
 {target-m68k => target/m68k}/m68k-semi.c           |  0
 {target-m68k => target/m68k}/op_helper.c           |  0
 {target-m68k => target/m68k}/qregs.def             |  0
 {target-m68k => target/m68k}/translate.c           |  0
 .../microblaze}/Makefile.objs                      |  0
 {target-microblaze => target/microblaze}/cpu-qom.h |  0
 {target-microblaze => target/microblaze}/cpu.c     |  0
 {target-microblaze => target/microblaze}/cpu.h     |  0
 {target-microblaze => target/microblaze}/gdbstub.c |  0
 {target-microblaze => target/microblaze}/helper.c  |  0
 {target-microblaze => target/microblaze}/helper.h  |  0
 .../microblaze}/microblaze-decode.h                |  0
 {target-microblaze => target/microblaze}/mmu.c     |  0
 {target-microblaze => target/microblaze}/mmu.h     |  0
 .../microblaze}/op_helper.c                        |  0
 .../microblaze}/translate.c                        |  0
 {target-mips => target/mips}/Makefile.objs         |  0
 {target-mips => target/mips}/TODO                  |  0
 {target-mips => target/mips}/cpu-qom.h             |  0
 {target-mips => target/mips}/cpu.c                 |  0
 {target-mips => target/mips}/cpu.h                 |  0
 {target-mips => target/mips}/dsp_helper.c          |  0
 {target-mips => target/mips}/gdbstub.c             |  0
 {target-mips => target/mips}/helper.c              |  0
 {target-mips => target/mips}/helper.h              |  0
 {target-mips => target/mips}/kvm.c                 |  0
 {target-mips => target/mips}/kvm_mips.h            |  0
 {target-mips => target/mips}/lmi_helper.c          |  0
 {target-mips => target/mips}/machine.c             |  0
 {target-mips => target/mips}/mips-defs.h           |  0
 {target-mips => target/mips}/mips-semi.c           |  0
 {target-mips => target/mips}/msa_helper.c          |  0
 {target-mips => target/mips}/op_helper.c           |  0
 {target-mips => target/mips}/translate.c           |  0
 {target-mips => target/mips}/translate_init.c      |  0
 {target-moxie => target/moxie}/Makefile.objs       |  0
 {target-moxie => target/moxie}/cpu.c               |  0
 {target-moxie => target/moxie}/cpu.h               |  0
 {target-moxie => target/moxie}/helper.c            |  0
 {target-moxie => target/moxie}/helper.h            |  0
 {target-moxie => target/moxie}/machine.c           |  0
 {target-moxie => target/moxie}/machine.h           |  0
 {target-moxie => target/moxie}/mmu.c               |  0
 {target-moxie => target/moxie}/mmu.h               |  0
 {target-moxie => target/moxie}/translate.c         |  0
 {target-openrisc => target/openrisc}/Makefile.objs |  0
 {target-openrisc => target/openrisc}/cpu.c         |  0
 {target-openrisc => target/openrisc}/cpu.h         |  0
 {target-openrisc => target/openrisc}/exception.c   |  0
 {target-openrisc => target/openrisc}/exception.h   |  0
 .../openrisc}/exception_helper.c                   |  0
 {target-openrisc => target/openrisc}/fpu_helper.c  |  0
 {target-openrisc => target/openrisc}/gdbstub.c     |  0
 {target-openrisc => target/openrisc}/helper.h      |  0
 {target-openrisc => target/openrisc}/int_helper.c  |  0
 {target-openrisc => target/openrisc}/interrupt.c   |  0
 .../openrisc}/interrupt_helper.c                   |  0
 {target-openrisc => target/openrisc}/machine.c     |  0
 {target-openrisc => target/openrisc}/mmu.c         |  0
 {target-openrisc => target/openrisc}/mmu_helper.c  |  0
 {target-openrisc => target/openrisc}/sys_helper.c  |  0
 {target-openrisc => target/openrisc}/translate.c   |  0
 {target-ppc => target/ppc}/Makefile.objs           |  0
 {target-ppc => target/ppc}/STATUS                  |  0
 {target-ppc => target/ppc}/arch_dump.c             |  0
 {target-ppc => target/ppc}/cpu-models.c            |  0
 {target-ppc => target/ppc}/cpu-models.h            |  0
 {target-ppc => target/ppc}/cpu-qom.h               |  0
 {target-ppc => target/ppc}/cpu.h                   |  0
 {target-ppc => target/ppc}/dfp_helper.c            |  0
 {target-ppc => target/ppc}/excp_helper.c           |  0
 {target-ppc => target/ppc}/fpu_helper.c            |  0
 {target-ppc => target/ppc}/gdbstub.c               |  0
 {target-ppc => target/ppc}/helper.h                |  0
 {target-ppc => target/ppc}/helper_regs.h           |  0
 {target-ppc => target/ppc}/int_helper.c            |  0
 {target-ppc => target/ppc}/internal.h              |  0
 {target-ppc => target/ppc}/kvm-stub.c              |  0
 {target-ppc => target/ppc}/kvm.c                   |  0
 {target-ppc => target/ppc}/kvm_ppc.h               |  0
 {target-ppc => target/ppc}/machine.c               |  0
 {target-ppc => target/ppc}/mem_helper.c            |  0
 {target-ppc => target/ppc}/mfrom_table.c           |  0
 {target-ppc => target/ppc}/mfrom_table_gen.c       |  0
 {target-ppc => target/ppc}/misc_helper.c           |  0
 {target-ppc => target/ppc}/mmu-hash32.c            |  0
 {target-ppc => target/ppc}/mmu-hash32.h            |  0
 {target-ppc => target/ppc}/mmu-hash64.c            |  0
 {target-ppc => target/ppc}/mmu-hash64.h            |  0
 {target-ppc => target/ppc}/mmu_helper.c            |  0
 {target-ppc => target/ppc}/monitor.c               |  0
 {target-ppc => target/ppc}/timebase_helper.c       |  0
 {target-ppc => target/ppc}/trace-events            |  2 +-
 {target-ppc => target/ppc}/translate.c             |  0
 .../ppc}/translate/dfp-impl.inc.c                  |  0
 {target-ppc => target/ppc}/translate/dfp-ops.inc.c |  0
 {target-ppc => target/ppc}/translate/fp-impl.inc.c |  0
 {target-ppc => target/ppc}/translate/fp-ops.inc.c  |  0
 .../ppc}/translate/spe-impl.inc.c                  |  0
 {target-ppc => target/ppc}/translate/spe-ops.inc.c |  0
 .../ppc}/translate/vmx-impl.inc.c                  |  0
 {target-ppc => target/ppc}/translate/vmx-ops.inc.c |  0
 .../ppc}/translate/vsx-impl.inc.c                  |  0
 {target-ppc => target/ppc}/translate/vsx-ops.inc.c |  0
 {target-ppc => target/ppc}/translate_init.c        |  0
 {target-ppc => target/ppc}/user_only_helper.c      |  0
 {target-s390x => target/s390x}/Makefile.objs       |  2 +-
 {target-s390x => target/s390x}/arch_dump.c         |  0
 {target-s390x => target/s390x}/cc_helper.c         |  0
 {target-s390x => target/s390x}/cpu-qom.h           |  0
 {target-s390x => target/s390x}/cpu.c               |  0
 {target-s390x => target/s390x}/cpu.h               |  0
 {target-s390x => target/s390x}/cpu_features.c      |  0
 {target-s390x => target/s390x}/cpu_features.h      |  0
 {target-s390x => target/s390x}/cpu_features_def.h  |  0
 {target-s390x => target/s390x}/cpu_models.c        |  0
 {target-s390x => target/s390x}/cpu_models.h        |  0
 {target-s390x => target/s390x}/fpu_helper.c        |  0
 {target-s390x => target/s390x}/gdbstub.c           |  0
 {target-s390x => target/s390x}/gen-features.c      |  0
 {target-s390x => target/s390x}/helper.c            |  0
 {target-s390x => target/s390x}/helper.h            |  0
 {target-s390x => target/s390x}/insn-data.def       |  0
 {target-s390x => target/s390x}/insn-format.def     |  0
 {target-s390x => target/s390x}/int_helper.c        |  0
 {target-s390x => target/s390x}/interrupt.c         |  0
 {target-s390x => target/s390x}/ioinst.c            |  0
 {target-s390x => target/s390x}/kvm.c               |  0
 {target-s390x => target/s390x}/machine.c           |  0
 {target-s390x => target/s390x}/mem_helper.c        |  0
 {target-s390x => target/s390x}/misc_helper.c       |  0
 {target-s390x => target/s390x}/mmu_helper.c        |  0
 {target-s390x => target/s390x}/trace-events        |  8 ++--
 {target-s390x => target/s390x}/translate.c         |  0
 {target-sh4 => target/sh4}/Makefile.objs           |  0
 {target-sh4 => target/sh4}/README.sh4              |  2 +-
 {target-sh4 => target/sh4}/cpu-qom.h               |  0
 {target-sh4 => target/sh4}/cpu.c                   |  0
 {target-sh4 => target/sh4}/cpu.h                   |  0
 {target-sh4 => target/sh4}/gdbstub.c               |  0
 {target-sh4 => target/sh4}/helper.c                |  0
 {target-sh4 => target/sh4}/helper.h                |  0
 {target-sh4 => target/sh4}/monitor.c               |  0
 {target-sh4 => target/sh4}/op_helper.c             |  0
 {target-sh4 => target/sh4}/translate.c             |  0
 {target-sparc => target/sparc}/Makefile.objs       |  0
 {target-sparc => target/sparc}/TODO                |  0
 {target-sparc => target/sparc}/asi.h               |  0
 {target-sparc => target/sparc}/cc_helper.c         |  0
 {target-sparc => target/sparc}/cpu-qom.h           |  0
 {target-sparc => target/sparc}/cpu.c               |  0
 {target-sparc => target/sparc}/cpu.h               |  0
 {target-sparc => target/sparc}/fop_helper.c        |  0
 {target-sparc => target/sparc}/gdbstub.c           |  0
 {target-sparc => target/sparc}/helper.c            |  0
 {target-sparc => target/sparc}/helper.h            |  0
 {target-sparc => target/sparc}/int32_helper.c      |  0
 {target-sparc => target/sparc}/int64_helper.c      |  0
 {target-sparc => target/sparc}/ldst_helper.c       |  0
 {target-sparc => target/sparc}/machine.c           |  0
 {target-sparc => target/sparc}/mmu_helper.c        |  0
 {target-sparc => target/sparc}/monitor.c           |  0
 {target-sparc => target/sparc}/trace-events        |  8 ++--
 {target-sparc => target/sparc}/translate.c         |  0
 {target-sparc => target/sparc}/vis_helper.c        |  0
 {target-sparc => target/sparc}/win_helper.c        |  0
 {target-tilegx => target/tilegx}/Makefile.objs     |  0
 {target-tilegx => target/tilegx}/cpu.c             |  0
 {target-tilegx => target/tilegx}/cpu.h             |  0
 {target-tilegx => target/tilegx}/helper.c          |  0
 {target-tilegx => target/tilegx}/helper.h          |  0
 {target-tilegx => target/tilegx}/opcode_tilegx.h   |  0
 {target-tilegx => target/tilegx}/simd_helper.c     |  0
 {target-tilegx => target/tilegx}/spr_def_64.h      |  0
 {target-tilegx => target/tilegx}/translate.c       |  0
 {target-tricore => target/tricore}/Makefile.objs   |  0
 {target-tricore => target/tricore}/cpu-qom.h       |  0
 {target-tricore => target/tricore}/cpu.c           |  0
 {target-tricore => target/tricore}/cpu.h           |  0
 {target-tricore => target/tricore}/csfr.def        |  0
 {target-tricore => target/tricore}/fpu_helper.c    |  0
 {target-tricore => target/tricore}/helper.c        |  0
 {target-tricore => target/tricore}/helper.h        |  0
 {target-tricore => target/tricore}/op_helper.c     |  0
 {target-tricore => target/tricore}/translate.c     |  0
 {target-tricore => target/tricore}/tricore-defs.h  |  0
 .../tricore}/tricore-opcodes.h                     |  0
 .../unicore32}/Makefile.objs                       |  0
 {target-unicore32 => target/unicore32}/cpu-qom.h   |  0
 {target-unicore32 => target/unicore32}/cpu.c       |  0
 {target-unicore32 => target/unicore32}/cpu.h       |  0
 {target-unicore32 => target/unicore32}/helper.c    |  0
 {target-unicore32 => target/unicore32}/helper.h    |  0
 {target-unicore32 => target/unicore32}/op_helper.c |  0
 {target-unicore32 => target/unicore32}/softmmu.c   |  0
 {target-unicore32 => target/unicore32}/translate.c |  0
 .../unicore32}/ucf64_helper.c                      |  0
 {target-xtensa => target/xtensa}/Makefile.objs     |  0
 {target-xtensa => target/xtensa}/core-dc232b.c     |  0
 .../xtensa}/core-dc232b/core-isa.h                 |  0
 .../xtensa}/core-dc232b/gdb-config.c               |  0
 {target-xtensa => target/xtensa}/core-dc233c.c     |  0
 .../xtensa}/core-dc233c/core-isa.h                 |  0
 .../xtensa}/core-dc233c/gdb-config.c               |  0
 {target-xtensa => target/xtensa}/core-fsf.c        |  0
 .../xtensa}/core-fsf/core-isa.h                    |  0
 {target-xtensa => target/xtensa}/cpu-qom.h         |  0
 {target-xtensa => target/xtensa}/cpu.c             |  0
 {target-xtensa => target/xtensa}/cpu.h             |  0
 {target-xtensa => target/xtensa}/gdbstub.c         |  0
 {target-xtensa => target/xtensa}/helper.c          |  0
 {target-xtensa => target/xtensa}/helper.h          |  0
 {target-xtensa => target/xtensa}/import_core.sh    |  0
 {target-xtensa => target/xtensa}/monitor.c         |  0
 {target-xtensa => target/xtensa}/op_helper.c       |  0
 {target-xtensa => target/xtensa}/overlay_tool.h    |  0
 {target-xtensa => target/xtensa}/translate.c       |  0
 {target-xtensa => target/xtensa}/xtensa-semi.c     |  0
 tests/tcg/xtensa/Makefile                          |  2 +-
 369 files changed, 77 insertions(+), 77 deletions(-)
 rename {target-alpha => target/alpha}/Makefile.objs (100%)
 rename {target-alpha => target/alpha}/STATUS (100%)
 rename {target-alpha => target/alpha}/cpu-qom.h (100%)
 rename {target-alpha => target/alpha}/cpu.c (100%)
 rename {target-alpha => target/alpha}/cpu.h (100%)
 rename {target-alpha => target/alpha}/fpu_helper.c (100%)
 rename {target-alpha => target/alpha}/gdbstub.c (100%)
 rename {target-alpha => target/alpha}/helper.c (100%)
 rename {target-alpha => target/alpha}/helper.h (100%)
 rename {target-alpha => target/alpha}/int_helper.c (100%)
 rename {target-alpha => target/alpha}/machine.c (100%)
 rename {target-alpha => target/alpha}/mem_helper.c (100%)
 rename {target-alpha => target/alpha}/sys_helper.c (100%)
 rename {target-alpha => target/alpha}/translate.c (100%)
 rename {target-alpha => target/alpha}/vax_helper.c (100%)
 rename {target-arm => target/arm}/Makefile.objs (100%)
 rename {target-arm => target/arm}/arch_dump.c (100%)
 rename {target-arm => target/arm}/arm-powerctl.c (100%)
 rename {target-arm => target/arm}/arm-powerctl.h (100%)
 rename {target-arm => target/arm}/arm-semi.c (100%)
 rename {target-arm => target/arm}/arm_ldst.h (100%)
 rename {target-arm => target/arm}/cpu-qom.h (100%)
 rename {target-arm => target/arm}/cpu.c (100%)
 rename {target-arm => target/arm}/cpu.h (100%)
 rename {target-arm => target/arm}/cpu64.c (100%)
 rename {target-arm => target/arm}/crypto_helper.c (100%)
 rename {target-arm => target/arm}/gdbstub.c (100%)
 rename {target-arm => target/arm}/gdbstub64.c (100%)
 rename {target-arm => target/arm}/helper-a64.c (100%)
 rename {target-arm => target/arm}/helper-a64.h (100%)
 rename {target-arm => target/arm}/helper.c (100%)
 rename {target-arm => target/arm}/helper.h (100%)
 rename {target-arm => target/arm}/internals.h (100%)
 rename {target-arm => target/arm}/iwmmxt_helper.c (100%)
 rename {target-arm => target/arm}/kvm-consts.h (100%)
 rename {target-arm => target/arm}/kvm-stub.c (100%)
 rename {target-arm => target/arm}/kvm.c (100%)
 rename {target-arm => target/arm}/kvm32.c (100%)
 rename {target-arm => target/arm}/kvm64.c (100%)
 rename {target-arm => target/arm}/kvm_arm.h (100%)
 rename {target-arm => target/arm}/machine.c (100%)
 rename {target-arm => target/arm}/monitor.c (100%)
 rename {target-arm => target/arm}/neon_helper.c (100%)
 rename {target-arm => target/arm}/op_addsub.h (100%)
 rename {target-arm => target/arm}/op_helper.c (100%)
 rename {target-arm => target/arm}/psci.c (100%)
 rename {target-arm => target/arm}/trace-events (96%)
 rename {target-arm => target/arm}/translate-a64.c (100%)
 rename {target-arm => target/arm}/translate.c (100%)
 rename {target-arm => target/arm}/translate.h (100%)
 rename {target-cris => target/cris}/Makefile.objs (100%)
 rename {target-cris => target/cris}/cpu-qom.h (100%)
 rename {target-cris => target/cris}/cpu.c (100%)
 rename {target-cris => target/cris}/cpu.h (100%)
 rename {target-cris => target/cris}/crisv10-decode.h (100%)
 rename {target-cris => target/cris}/crisv32-decode.h (100%)
 rename {target-cris => target/cris}/gdbstub.c (100%)
 rename {target-cris => target/cris}/helper.c (100%)
 rename {target-cris => target/cris}/helper.h (100%)
 rename {target-cris => target/cris}/machine.c (100%)
 rename {target-cris => target/cris}/mmu.c (100%)
 rename {target-cris => target/cris}/mmu.h (100%)
 rename {target-cris => target/cris}/op_helper.c (100%)
 rename {target-cris => target/cris}/opcode-cris.h (100%)
 rename {target-cris => target/cris}/translate.c (100%)
 rename {target-cris => target/cris}/translate_v10.c (100%)
 rename {target-i386 => target/i386}/Makefile.objs (100%)
 rename {target-i386 => target/i386}/TODO (100%)
 rename {target-i386 => target/i386}/arch_dump.c (100%)
 rename {target-i386 => target/i386}/arch_memory_mapping.c (100%)
 rename {target-i386 => target/i386}/bpt_helper.c (100%)
 rename {target-i386 => target/i386}/cc_helper.c (100%)
 rename {target-i386 => target/i386}/cc_helper_template.h (100%)
 rename {target-i386 => target/i386}/cpu-qom.h (100%)
 rename {target-i386 => target/i386}/cpu.c (100%)
 rename {target-i386 => target/i386}/cpu.h (100%)
 rename {target-i386 => target/i386}/excp_helper.c (100%)
 rename {target-i386 => target/i386}/fpu_helper.c (100%)
 rename {target-i386 => target/i386}/gdbstub.c (100%)
 rename {target-i386 => target/i386}/helper.c (100%)
 rename {target-i386 => target/i386}/helper.h (100%)
 rename {target-i386 => target/i386}/hyperv.c (100%)
 rename {target-i386 => target/i386}/hyperv.h (100%)
 rename {target-i386 => target/i386}/int_helper.c (100%)
 rename {target-i386 => target/i386}/kvm-stub.c (100%)
 rename {target-i386 => target/i386}/kvm.c (100%)
 rename {target-i386 => target/i386}/kvm_i386.h (100%)
 rename {target-i386 => target/i386}/machine.c (100%)
 rename {target-i386 => target/i386}/mem_helper.c (100%)
 rename {target-i386 => target/i386}/misc_helper.c (100%)
 rename {target-i386 => target/i386}/monitor.c (100%)
 rename {target-i386 => target/i386}/mpx_helper.c (100%)
 rename {target-i386 => target/i386}/ops_sse.h (100%)
 rename {target-i386 => target/i386}/ops_sse_header.h (100%)
 rename {target-i386 => target/i386}/seg_helper.c (100%)
 rename {target-i386 => target/i386}/shift_helper_template.h (100%)
 rename {target-i386 => target/i386}/smm_helper.c (100%)
 rename {target-i386 => target/i386}/svm.h (100%)
 rename {target-i386 => target/i386}/svm_helper.c (100%)
 rename {target-i386 => target/i386}/trace-events (94%)
 rename {target-i386 => target/i386}/translate.c (100%)
 rename {target-lm32 => target/lm32}/Makefile.objs (100%)
 rename {target-lm32 => target/lm32}/README (100%)
 rename {target-lm32 => target/lm32}/TODO (100%)
 rename {target-lm32 => target/lm32}/cpu-qom.h (100%)
 rename {target-lm32 => target/lm32}/cpu.c (100%)
 rename {target-lm32 => target/lm32}/cpu.h (100%)
 rename {target-lm32 => target/lm32}/gdbstub.c (100%)
 rename {target-lm32 => target/lm32}/helper.c (100%)
 rename {target-lm32 => target/lm32}/helper.h (100%)
 rename {target-lm32 => target/lm32}/lm32-semi.c (100%)
 rename {target-lm32 => target/lm32}/machine.c (100%)
 rename {target-lm32 => target/lm32}/op_helper.c (100%)
 rename {target-lm32 => target/lm32}/translate.c (100%)
 rename {target-m68k => target/m68k}/Makefile.objs (100%)
 rename {target-m68k => target/m68k}/cpu-qom.h (100%)
 rename {target-m68k => target/m68k}/cpu.c (100%)
 rename {target-m68k => target/m68k}/cpu.h (100%)
 rename {target-m68k => target/m68k}/gdbstub.c (100%)
 rename {target-m68k => target/m68k}/helper.c (100%)
 rename {target-m68k => target/m68k}/helper.h (100%)
 rename {target-m68k => target/m68k}/m68k-semi.c (100%)
 rename {target-m68k => target/m68k}/op_helper.c (100%)
 rename {target-m68k => target/m68k}/qregs.def (100%)
 rename {target-m68k => target/m68k}/translate.c (100%)
 rename {target-microblaze => target/microblaze}/Makefile.objs (100%)
 rename {target-microblaze => target/microblaze}/cpu-qom.h (100%)
 rename {target-microblaze => target/microblaze}/cpu.c (100%)
 rename {target-microblaze => target/microblaze}/cpu.h (100%)
 rename {target-microblaze => target/microblaze}/gdbstub.c (100%)
 rename {target-microblaze => target/microblaze}/helper.c (100%)
 rename {target-microblaze => target/microblaze}/helper.h (100%)
 rename {target-microblaze => target/microblaze}/microblaze-decode.h (100%)
 rename {target-microblaze => target/microblaze}/mmu.c (100%)
 rename {target-microblaze => target/microblaze}/mmu.h (100%)
 rename {target-microblaze => target/microblaze}/op_helper.c (100%)
 rename {target-microblaze => target/microblaze}/translate.c (100%)
 rename {target-mips => target/mips}/Makefile.objs (100%)
 rename {target-mips => target/mips}/TODO (100%)
 rename {target-mips => target/mips}/cpu-qom.h (100%)
 rename {target-mips => target/mips}/cpu.c (100%)
 rename {target-mips => target/mips}/cpu.h (100%)
 rename {target-mips => target/mips}/dsp_helper.c (100%)
 rename {target-mips => target/mips}/gdbstub.c (100%)
 rename {target-mips => target/mips}/helper.c (100%)
 rename {target-mips => target/mips}/helper.h (100%)
 rename {target-mips => target/mips}/kvm.c (100%)
 rename {target-mips => target/mips}/kvm_mips.h (100%)
 rename {target-mips => target/mips}/lmi_helper.c (100%)
 rename {target-mips => target/mips}/machine.c (100%)
 rename {target-mips => target/mips}/mips-defs.h (100%)
 rename {target-mips => target/mips}/mips-semi.c (100%)
 rename {target-mips => target/mips}/msa_helper.c (100%)
 rename {target-mips => target/mips}/op_helper.c (100%)
 rename {target-mips => target/mips}/translate.c (100%)
 rename {target-mips => target/mips}/translate_init.c (100%)
 rename {target-moxie => target/moxie}/Makefile.objs (100%)
 rename {target-moxie => target/moxie}/cpu.c (100%)
 rename {target-moxie => target/moxie}/cpu.h (100%)
 rename {target-moxie => target/moxie}/helper.c (100%)
 rename {target-moxie => target/moxie}/helper.h (100%)
 rename {target-moxie => target/moxie}/machine.c (100%)
 rename {target-moxie => target/moxie}/machine.h (100%)
 rename {target-moxie => target/moxie}/mmu.c (100%)
 rename {target-moxie => target/moxie}/mmu.h (100%)
 rename {target-moxie => target/moxie}/translate.c (100%)
 rename {target-openrisc => target/openrisc}/Makefile.objs (100%)
 rename {target-openrisc => target/openrisc}/cpu.c (100%)
 rename {target-openrisc => target/openrisc}/cpu.h (100%)
 rename {target-openrisc => target/openrisc}/exception.c (100%)
 rename {target-openrisc => target/openrisc}/exception.h (100%)
 rename {target-openrisc => target/openrisc}/exception_helper.c (100%)
 rename {target-openrisc => target/openrisc}/fpu_helper.c (100%)
 rename {target-openrisc => target/openrisc}/gdbstub.c (100%)
 rename {target-openrisc => target/openrisc}/helper.h (100%)
 rename {target-openrisc => target/openrisc}/int_helper.c (100%)
 rename {target-openrisc => target/openrisc}/interrupt.c (100%)
 rename {target-openrisc => target/openrisc}/interrupt_helper.c (100%)
 rename {target-openrisc => target/openrisc}/machine.c (100%)
 rename {target-openrisc => target/openrisc}/mmu.c (100%)
 rename {target-openrisc => target/openrisc}/mmu_helper.c (100%)
 rename {target-openrisc => target/openrisc}/sys_helper.c (100%)
 rename {target-openrisc => target/openrisc}/translate.c (100%)
 rename {target-ppc => target/ppc}/Makefile.objs (100%)
 rename {target-ppc => target/ppc}/STATUS (100%)
 rename {target-ppc => target/ppc}/arch_dump.c (100%)
 rename {target-ppc => target/ppc}/cpu-models.c (100%)
 rename {target-ppc => target/ppc}/cpu-models.h (100%)
 rename {target-ppc => target/ppc}/cpu-qom.h (100%)
 rename {target-ppc => target/ppc}/cpu.h (100%)
 rename {target-ppc => target/ppc}/dfp_helper.c (100%)
 rename {target-ppc => target/ppc}/excp_helper.c (100%)
 rename {target-ppc => target/ppc}/fpu_helper.c (100%)
 rename {target-ppc => target/ppc}/gdbstub.c (100%)
 rename {target-ppc => target/ppc}/helper.h (100%)
 rename {target-ppc => target/ppc}/helper_regs.h (100%)
 rename {target-ppc => target/ppc}/int_helper.c (100%)
 rename {target-ppc => target/ppc}/internal.h (100%)
 rename {target-ppc => target/ppc}/kvm-stub.c (100%)
 rename {target-ppc => target/ppc}/kvm.c (100%)
 rename {target-ppc => target/ppc}/kvm_ppc.h (100%)
 rename {target-ppc => target/ppc}/machine.c (100%)
 rename {target-ppc => target/ppc}/mem_helper.c (100%)
 rename {target-ppc => target/ppc}/mfrom_table.c (100%)
 rename {target-ppc => target/ppc}/mfrom_table_gen.c (100%)
 rename {target-ppc => target/ppc}/misc_helper.c (100%)
 rename {target-ppc => target/ppc}/mmu-hash32.c (100%)
 rename {target-ppc => target/ppc}/mmu-hash32.h (100%)
 rename {target-ppc => target/ppc}/mmu-hash64.c (100%)
 rename {target-ppc => target/ppc}/mmu-hash64.h (100%)
 rename {target-ppc => target/ppc}/mmu_helper.c (100%)
 rename {target-ppc => target/ppc}/monitor.c (100%)
 rename {target-ppc => target/ppc}/timebase_helper.c (100%)
 rename {target-ppc => target/ppc}/trace-events (92%)
 rename {target-ppc => target/ppc}/translate.c (100%)
 rename {target-ppc => target/ppc}/translate/dfp-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/dfp-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/fp-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/fp-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/spe-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/spe-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vmx-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vmx-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vsx-impl.inc.c (100%)
 rename {target-ppc => target/ppc}/translate/vsx-ops.inc.c (100%)
 rename {target-ppc => target/ppc}/translate_init.c (100%)
 rename {target-ppc => target/ppc}/user_only_helper.c (100%)
 rename {target-s390x => target/s390x}/Makefile.objs (94%)
 rename {target-s390x => target/s390x}/arch_dump.c (100%)
 rename {target-s390x => target/s390x}/cc_helper.c (100%)
 rename {target-s390x => target/s390x}/cpu-qom.h (100%)
 rename {target-s390x => target/s390x}/cpu.c (100%)
 rename {target-s390x => target/s390x}/cpu.h (100%)
 rename {target-s390x => target/s390x}/cpu_features.c (100%)
 rename {target-s390x => target/s390x}/cpu_features.h (100%)
 rename {target-s390x => target/s390x}/cpu_features_def.h (100%)
 rename {target-s390x => target/s390x}/cpu_models.c (100%)
 rename {target-s390x => target/s390x}/cpu_models.h (100%)
 rename {target-s390x => target/s390x}/fpu_helper.c (100%)
 rename {target-s390x => target/s390x}/gdbstub.c (100%)
 rename {target-s390x => target/s390x}/gen-features.c (100%)
 rename {target-s390x => target/s390x}/helper.c (100%)
 rename {target-s390x => target/s390x}/helper.h (100%)
 rename {target-s390x => target/s390x}/insn-data.def (100%)
 rename {target-s390x => target/s390x}/insn-format.def (100%)
 rename {target-s390x => target/s390x}/int_helper.c (100%)
 rename {target-s390x => target/s390x}/interrupt.c (100%)
 rename {target-s390x => target/s390x}/ioinst.c (100%)
 rename {target-s390x => target/s390x}/kvm.c (100%)
 rename {target-s390x => target/s390x}/machine.c (100%)
 rename {target-s390x => target/s390x}/mem_helper.c (100%)
 rename {target-s390x => target/s390x}/misc_helper.c (100%)
 rename {target-s390x => target/s390x}/mmu_helper.c (100%)
 rename {target-s390x => target/s390x}/trace-events (91%)
 rename {target-s390x => target/s390x}/translate.c (100%)
 rename {target-sh4 => target/sh4}/Makefile.objs (100%)
 rename {target-sh4 => target/sh4}/README.sh4 (98%)
 rename {target-sh4 => target/sh4}/cpu-qom.h (100%)
 rename {target-sh4 => target/sh4}/cpu.c (100%)
 rename {target-sh4 => target/sh4}/cpu.h (100%)
 rename {target-sh4 => target/sh4}/gdbstub.c (100%)
 rename {target-sh4 => target/sh4}/helper.c (100%)
 rename {target-sh4 => target/sh4}/helper.h (100%)
 rename {target-sh4 => target/sh4}/monitor.c (100%)
 rename {target-sh4 => target/sh4}/op_helper.c (100%)
 rename {target-sh4 => target/sh4}/translate.c (100%)
 rename {target-sparc => target/sparc}/Makefile.objs (100%)
 rename {target-sparc => target/sparc}/TODO (100%)
 rename {target-sparc => target/sparc}/asi.h (100%)
 rename {target-sparc => target/sparc}/cc_helper.c (100%)
 rename {target-sparc => target/sparc}/cpu-qom.h (100%)
 rename {target-sparc => target/sparc}/cpu.c (100%)
 rename {target-sparc => target/sparc}/cpu.h (100%)
 rename {target-sparc => target/sparc}/fop_helper.c (100%)
 rename {target-sparc => target/sparc}/gdbstub.c (100%)
 rename {target-sparc => target/sparc}/helper.c (100%)
 rename {target-sparc => target/sparc}/helper.h (100%)
 rename {target-sparc => target/sparc}/int32_helper.c (100%)
 rename {target-sparc => target/sparc}/int64_helper.c (100%)
 rename {target-sparc => target/sparc}/ldst_helper.c (100%)
 rename {target-sparc => target/sparc}/machine.c (100%)
 rename {target-sparc => target/sparc}/mmu_helper.c (100%)
 rename {target-sparc => target/sparc}/monitor.c (100%)
 rename {target-sparc => target/sparc}/trace-events (94%)
 rename {target-sparc => target/sparc}/translate.c (100%)
 rename {target-sparc => target/sparc}/vis_helper.c (100%)
 rename {target-sparc => target/sparc}/win_helper.c (100%)
 rename {target-tilegx => target/tilegx}/Makefile.objs (100%)
 rename {target-tilegx => target/tilegx}/cpu.c (100%)
 rename {target-tilegx => target/tilegx}/cpu.h (100%)
 rename {target-tilegx => target/tilegx}/helper.c (100%)
 rename {target-tilegx => target/tilegx}/helper.h (100%)
 rename {target-tilegx => target/tilegx}/opcode_tilegx.h (100%)
 rename {target-tilegx => target/tilegx}/simd_helper.c (100%)
 rename {target-tilegx => target/tilegx}/spr_def_64.h (100%)
 rename {target-tilegx => target/tilegx}/translate.c (100%)
 rename {target-tricore => target/tricore}/Makefile.objs (100%)
 rename {target-tricore => target/tricore}/cpu-qom.h (100%)
 rename {target-tricore => target/tricore}/cpu.c (100%)
 rename {target-tricore => target/tricore}/cpu.h (100%)
 rename {target-tricore => target/tricore}/csfr.def (100%)
 rename {target-tricore => target/tricore}/fpu_helper.c (100%)
 rename {target-tricore => target/tricore}/helper.c (100%)
 rename {target-tricore => target/tricore}/helper.h (100%)
 rename {target-tricore => target/tricore}/op_helper.c (100%)
 rename {target-tricore => target/tricore}/translate.c (100%)
 rename {target-tricore => target/tricore}/tricore-defs.h (100%)
 rename {target-tricore => target/tricore}/tricore-opcodes.h (100%)
 rename {target-unicore32 => target/unicore32}/Makefile.objs (100%)
 rename {target-unicore32 => target/unicore32}/cpu-qom.h (100%)
 rename {target-unicore32 => target/unicore32}/cpu.c (100%)
 rename {target-unicore32 => target/unicore32}/cpu.h (100%)
 rename {target-unicore32 => target/unicore32}/helper.c (100%)
 rename {target-unicore32 => target/unicore32}/helper.h (100%)
 rename {target-unicore32 => target/unicore32}/op_helper.c (100%)
 rename {target-unicore32 => target/unicore32}/softmmu.c (100%)
 rename {target-unicore32 => target/unicore32}/translate.c (100%)
 rename {target-unicore32 => target/unicore32}/ucf64_helper.c (100%)
 rename {target-xtensa => target/xtensa}/Makefile.objs (100%)
 rename {target-xtensa => target/xtensa}/core-dc232b.c (100%)
 rename {target-xtensa => target/xtensa}/core-dc232b/core-isa.h (100%)
 rename {target-xtensa => target/xtensa}/core-dc232b/gdb-config.c (100%)
 rename {target-xtensa => target/xtensa}/core-dc233c.c (100%)
 rename {target-xtensa => target/xtensa}/core-dc233c/core-isa.h (100%)
 rename {target-xtensa => target/xtensa}/core-dc233c/gdb-config.c (100%)
 rename {target-xtensa => target/xtensa}/core-fsf.c (100%)
 rename {target-xtensa => target/xtensa}/core-fsf/core-isa.h (100%)
 rename {target-xtensa => target/xtensa}/cpu-qom.h (100%)
 rename {target-xtensa => target/xtensa}/cpu.c (100%)
 rename {target-xtensa => target/xtensa}/cpu.h (100%)
 rename {target-xtensa => target/xtensa}/gdbstub.c (100%)
 rename {target-xtensa => target/xtensa}/helper.c (100%)
 rename {target-xtensa => target/xtensa}/helper.h (100%)
 rename {target-xtensa => target/xtensa}/import_core.sh (100%)
 rename {target-xtensa => target/xtensa}/monitor.c (100%)
 rename {target-xtensa => target/xtensa}/op_helper.c (100%)
 rename {target-xtensa => target/xtensa}/overlay_tool.h (100%)
 rename {target-xtensa => target/xtensa}/translate.c (100%)
 rename {target-xtensa => target/xtensa}/xtensa-semi.c (100%)

-- 
1.8.3.1
