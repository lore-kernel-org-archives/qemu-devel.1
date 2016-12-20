Received: from eggs.gnu.org ([2001:4830:134:3::10]:46008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJRmM-0003TJ-1j
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cJRm9-0002ZD-Ui
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:16:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cJRm9-0002XP-D8
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:16:45 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Dec 2016 22:16:38 +0100
Message-Id: <1482268598-27422-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1482268598-27422-1-git-send-email-thuth@redhat.com>
References: <1482268598-27422-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] Move target-* CPU file into a target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

We've currently got 18 architectures in QEMU, and thus 18 target-xxx
folders in the root folder of the QEMU source tree. More architectures
(e.g. RISC-V, AVR) are likely to be included soon, too, so the main
folder of the QEMU sources slowly gets quite overcrowded with the
target-xxx folders.
To disburden the main folder a little bit, let's move the target-xxx
folders into a dedicated target/ folder, so that target-xxx/ simply
becomes target/xxx/ instead.

Acked-by: Laurent Vivier <laurent@vivier.eu> [m68k part]
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de> [tricore part]
Acked-by: Michael Walle <michael@walle.cc> [lm32 part]
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com> [s390x part]
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com> [s390x part]
Acked-by: Eduardo Habkost <ehabkost@redhat.com> [i386 part]
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com> [sparc part]
Acked-by: Richard Henderson <rth@twiddle.net> [alpha part]
Acked-by: Max Filippov <jcmvbkbc@gmail.com> [xtensa part]
Reviewed-by: David Gibson <david@gibson.dropbear.id.au> [ppc part]
Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com> [cris&microblaze part]
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn> [unicore32 part]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                        | 48 +++++++++++-----------
 Makefile.objs                                      | 10 ++---
 Makefile.target                                    |  4 +-
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
 scripts/analyze-inclusions                         |  8 ++--
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
 {target-arm => target/arm}/internals.h             |  2 +-
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
 {target-lm32 => target/lm32}/lm32-semi.c           |  2 +-
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
 369 files changed, 78 insertions(+), 80 deletions(-)
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
 rename {target-arm => target/arm}/internals.h (99%)
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
 rename {target-lm32 => target/lm32}/lm32-semi.c (99%)
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

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a60579..585cd5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -106,7 +106,7 @@ F: include/fpu/
 Alpha
 M: Richard Henderson <rth@twiddle.net>
 S: Maintained
-F: target-alpha/
+F: target/alpha/
 F: hw/alpha/
 F: tests/tcg/alpha/
 F: disas/alpha.c
@@ -115,7 +115,7 @@ ARM
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-F: target-arm/
+F: target/arm/
 F: hw/arm/
 F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
@@ -126,7 +126,7 @@ F: disas/libvixl/
 CRIS
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-F: target-cris/
+F: target/cris/
 F: hw/cris/
 F: include/hw/cris/
 F: tests/tcg/cris/
@@ -135,7 +135,7 @@ F: disas/cris.c
 LM32
 M: Michael Walle <michael@walle.cc>
 S: Maintained
-F: target-lm32/
+F: target/lm32/
 F: disas/lm32.c
 F: hw/lm32/
 F: hw/*/lm32_*
@@ -147,13 +147,13 @@ F: tests/tcg/lm32/
 M68K
 M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
-F: target-m68k/
+F: target/m68k/
 F: disas/m68k.c
 
 MicroBlaze
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-F: target-microblaze/
+F: target/microblaze/
 F: hw/microblaze/
 F: disas/microblaze.c
 
@@ -161,7 +161,7 @@ MIPS
 M: Aurelien Jarno <aurelien@aurel32.net>
 M: Yongbok Kim <yongbok.kim@imgtec.com>
 S: Maintained
-F: target-mips/
+F: target/mips/
 F: hw/mips/
 F: hw/misc/mips_*
 F: hw/intc/mips_gic.c
@@ -176,7 +176,7 @@ F: disas/mips.c
 Moxie
 M: Anthony Green <green@moxielogic.com>
 S: Maintained
-F: target-moxie/
+F: target/moxie/
 F: disas/moxie.c
 F: hw/moxie/
 F: default-configs/moxie-softmmu.mak
@@ -184,7 +184,7 @@ F: default-configs/moxie-softmmu.mak
 OpenRISC
 M: Jia Liu <proljc@gmail.com>
 S: Maintained
-F: target-openrisc/
+F: target/openrisc/
 F: hw/openrisc/
 F: tests/tcg/openrisc/
 
@@ -193,7 +193,7 @@ M: David Gibson <david@gibson.dropbear.id.au>
 M: Alexander Graf <agraf@suse.de>
 L: qemu-ppc@nongnu.org
 S: Maintained
-F: target-ppc/
+F: target/ppc/
 F: hw/ppc/
 F: include/hw/ppc/
 F: disas/ppc.c
@@ -202,14 +202,14 @@ S390
 M: Richard Henderson <rth@twiddle.net>
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
-F: target-s390x/
+F: target/s390x/
 F: hw/s390x/
 F: disas/s390.c
 
 SH4
 M: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
-F: target-sh4/
+F: target/sh4/
 F: hw/sh4/
 F: disas/sh4.c
 F: include/hw/sh4/
@@ -218,7 +218,7 @@ SPARC
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 M: Artyom Tarasenko <atar4qemu@gmail.com>
 S: Maintained
-F: target-sparc/
+F: target/sparc/
 F: hw/sparc/
 F: hw/sparc64/
 F: disas/sparc.c
@@ -226,7 +226,7 @@ F: disas/sparc.c
 UniCore32
 M: Guan Xuetao <gxt@mprc.pku.edu.cn>
 S: Maintained
-F: target-unicore32/
+F: target/unicore32/
 F: hw/unicore32/
 F: include/hw/unicore32/
 
@@ -235,7 +235,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Richard Henderson <rth@twiddle.net>
 M: Eduardo Habkost <ehabkost@redhat.com>
 S: Maintained
-F: target-i386/
+F: target/i386/
 F: hw/i386/
 F: disas/i386.c
 
@@ -243,14 +243,14 @@ Xtensa
 M: Max Filippov <jcmvbkbc@gmail.com>
 W: http://wiki.osll.spb.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
-F: target-xtensa/
+F: target/xtensa/
 F: hw/xtensa/
 F: tests/tcg/xtensa/
 
 TriCore
 M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
 S: Maintained
-F: target-tricore/
+F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
 
@@ -269,26 +269,26 @@ ARM
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
-F: target-arm/kvm.c
+F: target/arm/kvm.c
 
 MIPS
 M: James Hogan <james.hogan@imgtec.com>
 S: Maintained
-F: target-mips/kvm.c
+F: target/mips/kvm.c
 
 PPC
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
-F: target-ppc/kvm.c
+F: target/ppc/kvm.c
 
 S390
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Cornelia Huck <cornelia.huck@de.ibm.com>
 M: Alexander Graf <agraf@suse.de>
 S: Maintained
-F: target-s390x/kvm.c
-F: target-s390x/ioinst.[ch]
-F: target-s390x/machine.c
+F: target/s390x/kvm.c
+F: target/s390x/ioinst.[ch]
+F: target/s390x/machine.c
 F: hw/intc/s390_flic.c
 F: hw/intc/s390_flic_kvm.c
 F: include/hw/s390x/s390_flic.h
@@ -301,7 +301,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 M: Marcelo Tosatti <mtosatti@redhat.com>
 L: kvm@vger.kernel.org
 S: Supported
-F: target-i386/kvm.c
+F: target/i386/kvm.c
 
 Guest CPU Cores (Xen):
 ----------------------
diff --git a/Makefile.objs b/Makefile.objs
index 06f74b8..e59b979 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -155,11 +155,11 @@ trace-events-y += hw/alpha/trace-events
 trace-events-y += ui/trace-events
 trace-events-y += audio/trace-events
 trace-events-y += net/trace-events
-trace-events-y += target-arm/trace-events
-trace-events-y += target-i386/trace-events
-trace-events-y += target-sparc/trace-events
-trace-events-y += target-s390x/trace-events
-trace-events-y += target-ppc/trace-events
+trace-events-y += target/arm/trace-events
+trace-events-y += target/i386/trace-events
+trace-events-y += target/sparc/trace-events
+trace-events-y += target/s390x/trace-events
+trace-events-y += target/ppc/trace-events
 trace-events-y += qom/trace-events
 trace-events-y += linux-user/trace-events
 trace-events-y += qapi/trace-events
diff --git a/Makefile.target b/Makefile.target
index 7a5080e..6689e31 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -11,7 +11,7 @@ $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
 ifdef CONFIG_LINUX
 QEMU_CFLAGS += -I../linux-headers
 endif
-QEMU_CFLAGS += -I.. -I$(SRC_PATH)/target-$(TARGET_BASE_ARCH) -DNEED_CPU_H
+QEMU_CFLAGS += -I.. -I$(SRC_PATH)/target/$(TARGET_BASE_ARCH) -DNEED_CPU_H
 
 QEMU_CFLAGS+=-I$(SRC_PATH)/include
 
@@ -92,7 +92,7 @@ obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
-obj-y += target-$(TARGET_BASE_ARCH)/
+obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
diff --git a/disas/cris.c b/disas/cris.c
index 7f35bc0..08161d1 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -21,9 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "disas/bfd.h"
-//#include "sysdep.h"
-#include "target-cris/opcode-cris.h"
-//#include "libiberty.h"
+#include "target/cris/opcode-cris.h"
 
 #define CONST_STRNEQ(STR1,STR2) (strncmp ((STR1), (STR2), sizeof (STR2) - 1) == 0)
 
diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index ed911f2..b6d8369 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -3,7 +3,7 @@
 #ifndef HW_ALPHA_SYS_H
 #define HW_ALPHA_SYS_H
 
-#include "target-alpha/cpu-qom.h"
+#include "target/alpha/cpu-qom.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ide.h"
diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
index 1470eac..e98840b 100644
--- a/hw/arm/strongarm.h
+++ b/hw/arm/strongarm.h
@@ -2,7 +2,7 @@
 #define STRONGARM_H
 
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "target/arm/cpu-qom.h"
 
 #define SA_CS0          0x00000000
 #define SA_CS1          0x08000000
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index d4160df..7102686 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -33,7 +33,7 @@
 #include "qemu/bitmap.h"
 #include "trace.h"
 #include "qom/cpu.h"
-#include "target-arm/cpu.h"
+#include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9708cdc..42ecf61 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -29,7 +29,7 @@
 #include "hw/pci/pci.h"
 #include "qom/cpu.h"
 #include "hw/i386/pc.h"
-#include "target-i386/cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/timer/hpet.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 01cbaa8..df5180b 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -15,7 +15,7 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/pci/msi.h"
 #include "sysemu/kvm.h"
-#include "target-i386/kvm_i386.h"
+#include "target/i386/kvm_i386.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
                                     int reg_id, uint32_t val)
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index fd9208f..ea7ea0b 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -30,7 +30,7 @@
 #include "hw/i386/ioapic_internal.h"
 #include "include/hw/pci/msi.h"
 #include "sysemu/kvm.h"
-#include "target-i386/cpu.h"
+#include "target/i386/cpu.h"
 #include "hw/i386/apic-msidef.h"
 #include "hw/i386/x86-iommu.h"
 
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 6cae9e9..dbd7cdd 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -17,7 +17,7 @@
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
 #include "sysemu/kvm.h"
-#include "target-i386/hyperv.h"
+#include "target/i386/hyperv.h"
 #include "kvm_i386.h"
 
 #define HV_TEST_DEV_MAX_SINT_ROUTES 64
diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
index e67d60d..38a7234 100644
--- a/hw/ppc/fdt.c
+++ b/hw/ppc/fdt.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 
 #include "hw/ppc/fdt.h"
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9df7b25..83597fe 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -22,7 +22,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "hw/hw.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 76ce854..d79d530 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -20,7 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_core.h"
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 0e2117f..78db524 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 8da2718..b82af4f 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -21,7 +21,7 @@
 #include "hw/hw.h"
 #include "qemu/log.h"
 #include "sysemu/kvm.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/sysbus.h"
 
 #include "hw/ppc/fdt.h"
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index e0c14f6..c18632b 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -8,14 +8,14 @@
  */
 #include "hw/cpu/core.h"
 #include "hw/ppc/spapr_cpu_core.h"
-#include "target-ppc/cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "sysemu/cpus.h"
-#include "target-ppc/kvm_ppc.h"
+#include "target/ppc/kvm_ppc.h"
 #include "hw/ppc/ppc.h"
-#include "target-ppc/mmu-hash64.h"
+#include "target/ppc/mmu-hash64.h"
 #include "sysemu/numa.h"
 
 static void spapr_cpu_reset(void *opaque)
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 14d4007..fd00cc5 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -25,7 +25,7 @@
    Shix 2.0 board by Alexis Polti, described at
    https://web.archive.org/web/20070917001736/perso.enst.fr/~polti/realisations/shix20
 
-   More information in target-sh4/README.sh4
+   More information in target/sh4/README.sh4
 */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index aeeebfe..c175c0e 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -12,7 +12,7 @@
 #define HW_ARM_H
 
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "target/arm/cpu-qom.h"
 #include "hw/irq.h"
 #include "qemu/notify.h"
 
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 29fef8b..76bb6d4 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -27,7 +27,7 @@
 
 #include "qemu-common.h"
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "target/arm/cpu-qom.h"
 
 #define EXYNOS4210_NCPUS                    2
 
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index f026c8d..f25870b 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -20,7 +20,7 @@
 #include "exec/memory.h"
 # define hw_omap_h		"omap.h"
 #include "hw/irq.h"
-#include "target-arm/cpu-qom.h"
+#include "target/arm/cpu-qom.h"
 
 # define OMAP_EMIFS_BASE	0x00000000
 # define OMAP2_Q0_BASE		0x00000000
diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 191e068..0df1199 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -11,7 +11,7 @@
 #define PXA_H
 
 #include "exec/memory.h"
-#include "target-arm/cpu-qom.h"
+#include "target/arm/cpu-qom.h"
 
 /* Interrupt numbers */
 # define PXA2XX_PIC_SSP3	0
diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
index 0f0d228..fdae229 100644
--- a/include/hw/m68k/mcf.h
+++ b/include/hw/m68k/mcf.h
@@ -2,7 +2,7 @@
 #define HW_MCF_H
 /* Motorola ColdFire device prototypes.  */
 
-#include "target-m68k/cpu-qom.h"
+#include "target/m68k/cpu-qom.h"
 
 struct MemoryRegion;
 
diff --git a/include/hw/mips/cpudevs.h b/include/hw/mips/cpudevs.h
index 8673daa..698339b 100644
--- a/include/hw/mips/cpudevs.h
+++ b/include/hw/mips/cpudevs.h
@@ -1,7 +1,7 @@
 #ifndef HW_MIPS_CPUDEVS_H
 #define HW_MIPS_CPUDEVS_H
 
-#include "target-mips/cpu-qom.h"
+#include "target/mips/cpu-qom.h"
 
 /* Definitions for MIPS CPU internal devices.  */
 
diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
index 0cabb6a..bd5b0a8 100644
--- a/include/hw/ppc/fdt.h
+++ b/include/hw/ppc/fdt.h
@@ -11,7 +11,7 @@
 #define PPC_FDT_H
 
 #include "qemu/error-report.h"
-#include "target-ppc/cpu-qom.h"
+#include "target/ppc/cpu-qom.h"
 
 #define _FDT(exp)                                                  \
     do {                                                           \
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 00c1fb1..4e7fe11 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -1,7 +1,7 @@
 #ifndef HW_PPC_H
 #define HW_PPC_H
 
-#include "target-ppc/cpu-qom.h"
+#include "target/ppc/cpu-qom.h"
 
 void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 283969b..50292f4 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -11,7 +11,7 @@
 
 #include "hw/qdev.h"
 #include "hw/cpu/core.h"
-#include "target-ppc/cpu-qom.h"
+#include "target/ppc/cpu-qom.h"
 
 #define TYPE_SPAPR_CPU_CORE "spapr-cpu-core"
 #define SPAPR_CPU_CORE(obj) \
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index 070312d..e59b9e7 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -3,7 +3,7 @@
 /* Definitions for SH board emulation.  */
 
 #include "hw/sh4/sh_intc.h"
-#include "target-sh4/cpu-qom.h"
+#include "target/sh4/cpu-qom.h"
 
 #define A7ADDR(x) ((x) & 0x1fffffff)
 #define P4ADDR(x) ((x) | 0xe0000000)
diff --git a/scripts/analyze-inclusions b/scripts/analyze-inclusions
index a8108d9..14806e1 100644
--- a/scripts/analyze-inclusions
+++ b/scripts/analyze-inclusions
@@ -48,7 +48,7 @@ grep_include() {
 echo Found $(find . -name "*.d" | wc -l) object files
 echo $(grep_include -F 'include/qemu-common.h') files include qemu-common.h
 echo $(grep_include -F 'hw/hw.h') files include hw/hw.h
-echo $(grep_include 'target-[a-z0-9]*/cpu\.h') files include cpu.h
+echo $(grep_include 'target/[a-z0-9]*/cpu\.h') files include cpu.h
 echo $(grep_include -F 'qapi-types.h') files include qapi-types.h
 echo $(grep_include -F 'trace/generated-tracers.h') files include generated-tracers.h
 echo $(grep_include -F 'qapi/error.h') files include qapi/error.h
@@ -95,8 +95,8 @@ analyze -include ../include/qemu/osdep.h ../include/hw/hw.h
 echo trace/generated-tracers.h:
 analyze -include ../include/qemu/osdep.h trace/generated-tracers.h
 
-echo target-i386/cpu.h:
-analyze -DNEED_CPU_H -I../target-i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../target-i386/cpu.h
+echo target/i386/cpu.h:
+analyze -DNEED_CPU_H -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../target/i386/cpu.h
 
 echo hw/hw.h + NEED_CPU_H:
-analyze -DNEED_CPU_H -I../target-i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/hw.h
+analyze -DNEED_CPU_H -I../target/i386 -Ii386-softmmu -include ../include/qemu/osdep.h ../include/hw/hw.h
diff --git a/target-alpha/Makefile.objs b/target/alpha/Makefile.objs
similarity index 100%
rename from target-alpha/Makefile.objs
rename to target/alpha/Makefile.objs
diff --git a/target-alpha/STATUS b/target/alpha/STATUS
similarity index 100%
rename from target-alpha/STATUS
rename to target/alpha/STATUS
diff --git a/target-alpha/cpu-qom.h b/target/alpha/cpu-qom.h
similarity index 100%
rename from target-alpha/cpu-qom.h
rename to target/alpha/cpu-qom.h
diff --git a/target-alpha/cpu.c b/target/alpha/cpu.c
similarity index 100%
rename from target-alpha/cpu.c
rename to target/alpha/cpu.c
diff --git a/target-alpha/cpu.h b/target/alpha/cpu.h
similarity index 100%
rename from target-alpha/cpu.h
rename to target/alpha/cpu.h
diff --git a/target-alpha/fpu_helper.c b/target/alpha/fpu_helper.c
similarity index 100%
rename from target-alpha/fpu_helper.c
rename to target/alpha/fpu_helper.c
diff --git a/target-alpha/gdbstub.c b/target/alpha/gdbstub.c
similarity index 100%
rename from target-alpha/gdbstub.c
rename to target/alpha/gdbstub.c
diff --git a/target-alpha/helper.c b/target/alpha/helper.c
similarity index 100%
rename from target-alpha/helper.c
rename to target/alpha/helper.c
diff --git a/target-alpha/helper.h b/target/alpha/helper.h
similarity index 100%
rename from target-alpha/helper.h
rename to target/alpha/helper.h
diff --git a/target-alpha/int_helper.c b/target/alpha/int_helper.c
similarity index 100%
rename from target-alpha/int_helper.c
rename to target/alpha/int_helper.c
diff --git a/target-alpha/machine.c b/target/alpha/machine.c
similarity index 100%
rename from target-alpha/machine.c
rename to target/alpha/machine.c
diff --git a/target-alpha/mem_helper.c b/target/alpha/mem_helper.c
similarity index 100%
rename from target-alpha/mem_helper.c
rename to target/alpha/mem_helper.c
diff --git a/target-alpha/sys_helper.c b/target/alpha/sys_helper.c
similarity index 100%
rename from target-alpha/sys_helper.c
rename to target/alpha/sys_helper.c
diff --git a/target-alpha/translate.c b/target/alpha/translate.c
similarity index 100%
rename from target-alpha/translate.c
rename to target/alpha/translate.c
diff --git a/target-alpha/vax_helper.c b/target/alpha/vax_helper.c
similarity index 100%
rename from target-alpha/vax_helper.c
rename to target/alpha/vax_helper.c
diff --git a/target-arm/Makefile.objs b/target/arm/Makefile.objs
similarity index 100%
rename from target-arm/Makefile.objs
rename to target/arm/Makefile.objs
diff --git a/target-arm/arch_dump.c b/target/arm/arch_dump.c
similarity index 100%
rename from target-arm/arch_dump.c
rename to target/arm/arch_dump.c
diff --git a/target-arm/arm-powerctl.c b/target/arm/arm-powerctl.c
similarity index 100%
rename from target-arm/arm-powerctl.c
rename to target/arm/arm-powerctl.c
diff --git a/target-arm/arm-powerctl.h b/target/arm/arm-powerctl.h
similarity index 100%
rename from target-arm/arm-powerctl.h
rename to target/arm/arm-powerctl.h
diff --git a/target-arm/arm-semi.c b/target/arm/arm-semi.c
similarity index 100%
rename from target-arm/arm-semi.c
rename to target/arm/arm-semi.c
diff --git a/target-arm/arm_ldst.h b/target/arm/arm_ldst.h
similarity index 100%
rename from target-arm/arm_ldst.h
rename to target/arm/arm_ldst.h
diff --git a/target-arm/cpu-qom.h b/target/arm/cpu-qom.h
similarity index 100%
rename from target-arm/cpu-qom.h
rename to target/arm/cpu-qom.h
diff --git a/target-arm/cpu.c b/target/arm/cpu.c
similarity index 100%
rename from target-arm/cpu.c
rename to target/arm/cpu.c
diff --git a/target-arm/cpu.h b/target/arm/cpu.h
similarity index 100%
rename from target-arm/cpu.h
rename to target/arm/cpu.h
diff --git a/target-arm/cpu64.c b/target/arm/cpu64.c
similarity index 100%
rename from target-arm/cpu64.c
rename to target/arm/cpu64.c
diff --git a/target-arm/crypto_helper.c b/target/arm/crypto_helper.c
similarity index 100%
rename from target-arm/crypto_helper.c
rename to target/arm/crypto_helper.c
diff --git a/target-arm/gdbstub.c b/target/arm/gdbstub.c
similarity index 100%
rename from target-arm/gdbstub.c
rename to target/arm/gdbstub.c
diff --git a/target-arm/gdbstub64.c b/target/arm/gdbstub64.c
similarity index 100%
rename from target-arm/gdbstub64.c
rename to target/arm/gdbstub64.c
diff --git a/target-arm/helper-a64.c b/target/arm/helper-a64.c
similarity index 100%
rename from target-arm/helper-a64.c
rename to target/arm/helper-a64.c
diff --git a/target-arm/helper-a64.h b/target/arm/helper-a64.h
similarity index 100%
rename from target-arm/helper-a64.h
rename to target/arm/helper-a64.h
diff --git a/target-arm/helper.c b/target/arm/helper.c
similarity index 100%
rename from target-arm/helper.c
rename to target/arm/helper.c
diff --git a/target-arm/helper.h b/target/arm/helper.h
similarity index 100%
rename from target-arm/helper.h
rename to target/arm/helper.h
diff --git a/target-arm/internals.h b/target/arm/internals.h
similarity index 99%
rename from target-arm/internals.h
rename to target/arm/internals.h
index 3edccd2..3cae5ff 100644
--- a/target-arm/internals.h
+++ b/target/arm/internals.h
@@ -18,7 +18,7 @@
  * <http://www.gnu.org/licenses/gpl-2.0.html>
  *
  * This header defines functions, types, etc which need to be shared
- * between different source files within target-arm/ but which are
+ * between different source files within target/arm/ but which are
  * private to it and not required by the rest of QEMU.
  */
 
diff --git a/target-arm/iwmmxt_helper.c b/target/arm/iwmmxt_helper.c
similarity index 100%
rename from target-arm/iwmmxt_helper.c
rename to target/arm/iwmmxt_helper.c
diff --git a/target-arm/kvm-consts.h b/target/arm/kvm-consts.h
similarity index 100%
rename from target-arm/kvm-consts.h
rename to target/arm/kvm-consts.h
diff --git a/target-arm/kvm-stub.c b/target/arm/kvm-stub.c
similarity index 100%
rename from target-arm/kvm-stub.c
rename to target/arm/kvm-stub.c
diff --git a/target-arm/kvm.c b/target/arm/kvm.c
similarity index 100%
rename from target-arm/kvm.c
rename to target/arm/kvm.c
diff --git a/target-arm/kvm32.c b/target/arm/kvm32.c
similarity index 100%
rename from target-arm/kvm32.c
rename to target/arm/kvm32.c
diff --git a/target-arm/kvm64.c b/target/arm/kvm64.c
similarity index 100%
rename from target-arm/kvm64.c
rename to target/arm/kvm64.c
diff --git a/target-arm/kvm_arm.h b/target/arm/kvm_arm.h
similarity index 100%
rename from target-arm/kvm_arm.h
rename to target/arm/kvm_arm.h
diff --git a/target-arm/machine.c b/target/arm/machine.c
similarity index 100%
rename from target-arm/machine.c
rename to target/arm/machine.c
diff --git a/target-arm/monitor.c b/target/arm/monitor.c
similarity index 100%
rename from target-arm/monitor.c
rename to target/arm/monitor.c
diff --git a/target-arm/neon_helper.c b/target/arm/neon_helper.c
similarity index 100%
rename from target-arm/neon_helper.c
rename to target/arm/neon_helper.c
diff --git a/target-arm/op_addsub.h b/target/arm/op_addsub.h
similarity index 100%
rename from target-arm/op_addsub.h
rename to target/arm/op_addsub.h
diff --git a/target-arm/op_helper.c b/target/arm/op_helper.c
similarity index 100%
rename from target-arm/op_helper.c
rename to target/arm/op_helper.c
diff --git a/target-arm/psci.c b/target/arm/psci.c
similarity index 100%
rename from target-arm/psci.c
rename to target/arm/psci.c
diff --git a/target-arm/trace-events b/target/arm/trace-events
similarity index 96%
rename from target-arm/trace-events
rename to target/arm/trace-events
index 9f726bd..e21c84f 100644
--- a/target-arm/trace-events
+++ b/target/arm/trace-events
@@ -1,6 +1,6 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-arm/helper.c
+# target/arm/helper.c
 arm_gt_recalc(int timer, int irqstate, uint64_t nexttick) "gt recalc: timer %d irqstate %d next tick %" PRIx64
 arm_gt_recalc_disabled(int timer) "gt recalc: timer %d irqstate 0 timer disabled"
 arm_gt_cval_write(int timer, uint64_t value) "gt_cval_write: timer %d value %" PRIx64
diff --git a/target-arm/translate-a64.c b/target/arm/translate-a64.c
similarity index 100%
rename from target-arm/translate-a64.c
rename to target/arm/translate-a64.c
diff --git a/target-arm/translate.c b/target/arm/translate.c
similarity index 100%
rename from target-arm/translate.c
rename to target/arm/translate.c
diff --git a/target-arm/translate.h b/target/arm/translate.h
similarity index 100%
rename from target-arm/translate.h
rename to target/arm/translate.h
diff --git a/target-cris/Makefile.objs b/target/cris/Makefile.objs
similarity index 100%
rename from target-cris/Makefile.objs
rename to target/cris/Makefile.objs
diff --git a/target-cris/cpu-qom.h b/target/cris/cpu-qom.h
similarity index 100%
rename from target-cris/cpu-qom.h
rename to target/cris/cpu-qom.h
diff --git a/target-cris/cpu.c b/target/cris/cpu.c
similarity index 100%
rename from target-cris/cpu.c
rename to target/cris/cpu.c
diff --git a/target-cris/cpu.h b/target/cris/cpu.h
similarity index 100%
rename from target-cris/cpu.h
rename to target/cris/cpu.h
diff --git a/target-cris/crisv10-decode.h b/target/cris/crisv10-decode.h
similarity index 100%
rename from target-cris/crisv10-decode.h
rename to target/cris/crisv10-decode.h
diff --git a/target-cris/crisv32-decode.h b/target/cris/crisv32-decode.h
similarity index 100%
rename from target-cris/crisv32-decode.h
rename to target/cris/crisv32-decode.h
diff --git a/target-cris/gdbstub.c b/target/cris/gdbstub.c
similarity index 100%
rename from target-cris/gdbstub.c
rename to target/cris/gdbstub.c
diff --git a/target-cris/helper.c b/target/cris/helper.c
similarity index 100%
rename from target-cris/helper.c
rename to target/cris/helper.c
diff --git a/target-cris/helper.h b/target/cris/helper.h
similarity index 100%
rename from target-cris/helper.h
rename to target/cris/helper.h
diff --git a/target-cris/machine.c b/target/cris/machine.c
similarity index 100%
rename from target-cris/machine.c
rename to target/cris/machine.c
diff --git a/target-cris/mmu.c b/target/cris/mmu.c
similarity index 100%
rename from target-cris/mmu.c
rename to target/cris/mmu.c
diff --git a/target-cris/mmu.h b/target/cris/mmu.h
similarity index 100%
rename from target-cris/mmu.h
rename to target/cris/mmu.h
diff --git a/target-cris/op_helper.c b/target/cris/op_helper.c
similarity index 100%
rename from target-cris/op_helper.c
rename to target/cris/op_helper.c
diff --git a/target-cris/opcode-cris.h b/target/cris/opcode-cris.h
similarity index 100%
rename from target-cris/opcode-cris.h
rename to target/cris/opcode-cris.h
diff --git a/target-cris/translate.c b/target/cris/translate.c
similarity index 100%
rename from target-cris/translate.c
rename to target/cris/translate.c
diff --git a/target-cris/translate_v10.c b/target/cris/translate_v10.c
similarity index 100%
rename from target-cris/translate_v10.c
rename to target/cris/translate_v10.c
diff --git a/target-i386/Makefile.objs b/target/i386/Makefile.objs
similarity index 100%
rename from target-i386/Makefile.objs
rename to target/i386/Makefile.objs
diff --git a/target-i386/TODO b/target/i386/TODO
similarity index 100%
rename from target-i386/TODO
rename to target/i386/TODO
diff --git a/target-i386/arch_dump.c b/target/i386/arch_dump.c
similarity index 100%
rename from target-i386/arch_dump.c
rename to target/i386/arch_dump.c
diff --git a/target-i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
similarity index 100%
rename from target-i386/arch_memory_mapping.c
rename to target/i386/arch_memory_mapping.c
diff --git a/target-i386/bpt_helper.c b/target/i386/bpt_helper.c
similarity index 100%
rename from target-i386/bpt_helper.c
rename to target/i386/bpt_helper.c
diff --git a/target-i386/cc_helper.c b/target/i386/cc_helper.c
similarity index 100%
rename from target-i386/cc_helper.c
rename to target/i386/cc_helper.c
diff --git a/target-i386/cc_helper_template.h b/target/i386/cc_helper_template.h
similarity index 100%
rename from target-i386/cc_helper_template.h
rename to target/i386/cc_helper_template.h
diff --git a/target-i386/cpu-qom.h b/target/i386/cpu-qom.h
similarity index 100%
rename from target-i386/cpu-qom.h
rename to target/i386/cpu-qom.h
diff --git a/target-i386/cpu.c b/target/i386/cpu.c
similarity index 100%
rename from target-i386/cpu.c
rename to target/i386/cpu.c
diff --git a/target-i386/cpu.h b/target/i386/cpu.h
similarity index 100%
rename from target-i386/cpu.h
rename to target/i386/cpu.h
diff --git a/target-i386/excp_helper.c b/target/i386/excp_helper.c
similarity index 100%
rename from target-i386/excp_helper.c
rename to target/i386/excp_helper.c
diff --git a/target-i386/fpu_helper.c b/target/i386/fpu_helper.c
similarity index 100%
rename from target-i386/fpu_helper.c
rename to target/i386/fpu_helper.c
diff --git a/target-i386/gdbstub.c b/target/i386/gdbstub.c
similarity index 100%
rename from target-i386/gdbstub.c
rename to target/i386/gdbstub.c
diff --git a/target-i386/helper.c b/target/i386/helper.c
similarity index 100%
rename from target-i386/helper.c
rename to target/i386/helper.c
diff --git a/target-i386/helper.h b/target/i386/helper.h
similarity index 100%
rename from target-i386/helper.h
rename to target/i386/helper.h
diff --git a/target-i386/hyperv.c b/target/i386/hyperv.c
similarity index 100%
rename from target-i386/hyperv.c
rename to target/i386/hyperv.c
diff --git a/target-i386/hyperv.h b/target/i386/hyperv.h
similarity index 100%
rename from target-i386/hyperv.h
rename to target/i386/hyperv.h
diff --git a/target-i386/int_helper.c b/target/i386/int_helper.c
similarity index 100%
rename from target-i386/int_helper.c
rename to target/i386/int_helper.c
diff --git a/target-i386/kvm-stub.c b/target/i386/kvm-stub.c
similarity index 100%
rename from target-i386/kvm-stub.c
rename to target/i386/kvm-stub.c
diff --git a/target-i386/kvm.c b/target/i386/kvm.c
similarity index 100%
rename from target-i386/kvm.c
rename to target/i386/kvm.c
diff --git a/target-i386/kvm_i386.h b/target/i386/kvm_i386.h
similarity index 100%
rename from target-i386/kvm_i386.h
rename to target/i386/kvm_i386.h
diff --git a/target-i386/machine.c b/target/i386/machine.c
similarity index 100%
rename from target-i386/machine.c
rename to target/i386/machine.c
diff --git a/target-i386/mem_helper.c b/target/i386/mem_helper.c
similarity index 100%
rename from target-i386/mem_helper.c
rename to target/i386/mem_helper.c
diff --git a/target-i386/misc_helper.c b/target/i386/misc_helper.c
similarity index 100%
rename from target-i386/misc_helper.c
rename to target/i386/misc_helper.c
diff --git a/target-i386/monitor.c b/target/i386/monitor.c
similarity index 100%
rename from target-i386/monitor.c
rename to target/i386/monitor.c
diff --git a/target-i386/mpx_helper.c b/target/i386/mpx_helper.c
similarity index 100%
rename from target-i386/mpx_helper.c
rename to target/i386/mpx_helper.c
diff --git a/target-i386/ops_sse.h b/target/i386/ops_sse.h
similarity index 100%
rename from target-i386/ops_sse.h
rename to target/i386/ops_sse.h
diff --git a/target-i386/ops_sse_header.h b/target/i386/ops_sse_header.h
similarity index 100%
rename from target-i386/ops_sse_header.h
rename to target/i386/ops_sse_header.h
diff --git a/target-i386/seg_helper.c b/target/i386/seg_helper.c
similarity index 100%
rename from target-i386/seg_helper.c
rename to target/i386/seg_helper.c
diff --git a/target-i386/shift_helper_template.h b/target/i386/shift_helper_template.h
similarity index 100%
rename from target-i386/shift_helper_template.h
rename to target/i386/shift_helper_template.h
diff --git a/target-i386/smm_helper.c b/target/i386/smm_helper.c
similarity index 100%
rename from target-i386/smm_helper.c
rename to target/i386/smm_helper.c
diff --git a/target-i386/svm.h b/target/i386/svm.h
similarity index 100%
rename from target-i386/svm.h
rename to target/i386/svm.h
diff --git a/target-i386/svm_helper.c b/target/i386/svm_helper.c
similarity index 100%
rename from target-i386/svm_helper.c
rename to target/i386/svm_helper.c
diff --git a/target-i386/trace-events b/target/i386/trace-events
similarity index 94%
rename from target-i386/trace-events
rename to target/i386/trace-events
index 05c5453..de6a1cf 100644
--- a/target-i386/trace-events
+++ b/target/i386/trace-events
@@ -1,6 +1,6 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-i386/kvm.c
+# target/i386/kvm.c
 kvm_x86_fixup_msi_error(uint32_t gsi) "VT-d failed to remap interrupt for GSI %" PRIu32
 kvm_x86_add_msi_route(int virq) "Adding route entry for virq %d"
 kvm_x86_remove_msi_route(int virq) "Removing route entry for virq %d"
diff --git a/target-i386/translate.c b/target/i386/translate.c
similarity index 100%
rename from target-i386/translate.c
rename to target/i386/translate.c
diff --git a/target-lm32/Makefile.objs b/target/lm32/Makefile.objs
similarity index 100%
rename from target-lm32/Makefile.objs
rename to target/lm32/Makefile.objs
diff --git a/target-lm32/README b/target/lm32/README
similarity index 100%
rename from target-lm32/README
rename to target/lm32/README
diff --git a/target-lm32/TODO b/target/lm32/TODO
similarity index 100%
rename from target-lm32/TODO
rename to target/lm32/TODO
diff --git a/target-lm32/cpu-qom.h b/target/lm32/cpu-qom.h
similarity index 100%
rename from target-lm32/cpu-qom.h
rename to target/lm32/cpu-qom.h
diff --git a/target-lm32/cpu.c b/target/lm32/cpu.c
similarity index 100%
rename from target-lm32/cpu.c
rename to target/lm32/cpu.c
diff --git a/target-lm32/cpu.h b/target/lm32/cpu.h
similarity index 100%
rename from target-lm32/cpu.h
rename to target/lm32/cpu.h
diff --git a/target-lm32/gdbstub.c b/target/lm32/gdbstub.c
similarity index 100%
rename from target-lm32/gdbstub.c
rename to target/lm32/gdbstub.c
diff --git a/target-lm32/helper.c b/target/lm32/helper.c
similarity index 100%
rename from target-lm32/helper.c
rename to target/lm32/helper.c
diff --git a/target-lm32/helper.h b/target/lm32/helper.h
similarity index 100%
rename from target-lm32/helper.h
rename to target/lm32/helper.h
diff --git a/target-lm32/lm32-semi.c b/target/lm32/lm32-semi.c
similarity index 99%
rename from target-lm32/lm32-semi.c
rename to target/lm32/lm32-semi.c
index 20f1a1c..6a11a62 100644
--- a/target-lm32/lm32-semi.c
+++ b/target/lm32/lm32-semi.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (c) 2014 Michael Walle <michael@walle.cc>
  *
- * Based on target-m68k/m68k-semi.c, which is
+ * Based on target/m68k/m68k-semi.c, which is
  *  Copyright (c) 2005-2007 CodeSourcery.
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
diff --git a/target-lm32/machine.c b/target/lm32/machine.c
similarity index 100%
rename from target-lm32/machine.c
rename to target/lm32/machine.c
diff --git a/target-lm32/op_helper.c b/target/lm32/op_helper.c
similarity index 100%
rename from target-lm32/op_helper.c
rename to target/lm32/op_helper.c
diff --git a/target-lm32/translate.c b/target/lm32/translate.c
similarity index 100%
rename from target-lm32/translate.c
rename to target/lm32/translate.c
diff --git a/target-m68k/Makefile.objs b/target/m68k/Makefile.objs
similarity index 100%
rename from target-m68k/Makefile.objs
rename to target/m68k/Makefile.objs
diff --git a/target-m68k/cpu-qom.h b/target/m68k/cpu-qom.h
similarity index 100%
rename from target-m68k/cpu-qom.h
rename to target/m68k/cpu-qom.h
diff --git a/target-m68k/cpu.c b/target/m68k/cpu.c
similarity index 100%
rename from target-m68k/cpu.c
rename to target/m68k/cpu.c
diff --git a/target-m68k/cpu.h b/target/m68k/cpu.h
similarity index 100%
rename from target-m68k/cpu.h
rename to target/m68k/cpu.h
diff --git a/target-m68k/gdbstub.c b/target/m68k/gdbstub.c
similarity index 100%
rename from target-m68k/gdbstub.c
rename to target/m68k/gdbstub.c
diff --git a/target-m68k/helper.c b/target/m68k/helper.c
similarity index 100%
rename from target-m68k/helper.c
rename to target/m68k/helper.c
diff --git a/target-m68k/helper.h b/target/m68k/helper.h
similarity index 100%
rename from target-m68k/helper.h
rename to target/m68k/helper.h
diff --git a/target-m68k/m68k-semi.c b/target/m68k/m68k-semi.c
similarity index 100%
rename from target-m68k/m68k-semi.c
rename to target/m68k/m68k-semi.c
diff --git a/target-m68k/op_helper.c b/target/m68k/op_helper.c
similarity index 100%
rename from target-m68k/op_helper.c
rename to target/m68k/op_helper.c
diff --git a/target-m68k/qregs.def b/target/m68k/qregs.def
similarity index 100%
rename from target-m68k/qregs.def
rename to target/m68k/qregs.def
diff --git a/target-m68k/translate.c b/target/m68k/translate.c
similarity index 100%
rename from target-m68k/translate.c
rename to target/m68k/translate.c
diff --git a/target-microblaze/Makefile.objs b/target/microblaze/Makefile.objs
similarity index 100%
rename from target-microblaze/Makefile.objs
rename to target/microblaze/Makefile.objs
diff --git a/target-microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
similarity index 100%
rename from target-microblaze/cpu-qom.h
rename to target/microblaze/cpu-qom.h
diff --git a/target-microblaze/cpu.c b/target/microblaze/cpu.c
similarity index 100%
rename from target-microblaze/cpu.c
rename to target/microblaze/cpu.c
diff --git a/target-microblaze/cpu.h b/target/microblaze/cpu.h
similarity index 100%
rename from target-microblaze/cpu.h
rename to target/microblaze/cpu.h
diff --git a/target-microblaze/gdbstub.c b/target/microblaze/gdbstub.c
similarity index 100%
rename from target-microblaze/gdbstub.c
rename to target/microblaze/gdbstub.c
diff --git a/target-microblaze/helper.c b/target/microblaze/helper.c
similarity index 100%
rename from target-microblaze/helper.c
rename to target/microblaze/helper.c
diff --git a/target-microblaze/helper.h b/target/microblaze/helper.h
similarity index 100%
rename from target-microblaze/helper.h
rename to target/microblaze/helper.h
diff --git a/target-microblaze/microblaze-decode.h b/target/microblaze/microblaze-decode.h
similarity index 100%
rename from target-microblaze/microblaze-decode.h
rename to target/microblaze/microblaze-decode.h
diff --git a/target-microblaze/mmu.c b/target/microblaze/mmu.c
similarity index 100%
rename from target-microblaze/mmu.c
rename to target/microblaze/mmu.c
diff --git a/target-microblaze/mmu.h b/target/microblaze/mmu.h
similarity index 100%
rename from target-microblaze/mmu.h
rename to target/microblaze/mmu.h
diff --git a/target-microblaze/op_helper.c b/target/microblaze/op_helper.c
similarity index 100%
rename from target-microblaze/op_helper.c
rename to target/microblaze/op_helper.c
diff --git a/target-microblaze/translate.c b/target/microblaze/translate.c
similarity index 100%
rename from target-microblaze/translate.c
rename to target/microblaze/translate.c
diff --git a/target-mips/Makefile.objs b/target/mips/Makefile.objs
similarity index 100%
rename from target-mips/Makefile.objs
rename to target/mips/Makefile.objs
diff --git a/target-mips/TODO b/target/mips/TODO
similarity index 100%
rename from target-mips/TODO
rename to target/mips/TODO
diff --git a/target-mips/cpu-qom.h b/target/mips/cpu-qom.h
similarity index 100%
rename from target-mips/cpu-qom.h
rename to target/mips/cpu-qom.h
diff --git a/target-mips/cpu.c b/target/mips/cpu.c
similarity index 100%
rename from target-mips/cpu.c
rename to target/mips/cpu.c
diff --git a/target-mips/cpu.h b/target/mips/cpu.h
similarity index 100%
rename from target-mips/cpu.h
rename to target/mips/cpu.h
diff --git a/target-mips/dsp_helper.c b/target/mips/dsp_helper.c
similarity index 100%
rename from target-mips/dsp_helper.c
rename to target/mips/dsp_helper.c
diff --git a/target-mips/gdbstub.c b/target/mips/gdbstub.c
similarity index 100%
rename from target-mips/gdbstub.c
rename to target/mips/gdbstub.c
diff --git a/target-mips/helper.c b/target/mips/helper.c
similarity index 100%
rename from target-mips/helper.c
rename to target/mips/helper.c
diff --git a/target-mips/helper.h b/target/mips/helper.h
similarity index 100%
rename from target-mips/helper.h
rename to target/mips/helper.h
diff --git a/target-mips/kvm.c b/target/mips/kvm.c
similarity index 100%
rename from target-mips/kvm.c
rename to target/mips/kvm.c
diff --git a/target-mips/kvm_mips.h b/target/mips/kvm_mips.h
similarity index 100%
rename from target-mips/kvm_mips.h
rename to target/mips/kvm_mips.h
diff --git a/target-mips/lmi_helper.c b/target/mips/lmi_helper.c
similarity index 100%
rename from target-mips/lmi_helper.c
rename to target/mips/lmi_helper.c
diff --git a/target-mips/machine.c b/target/mips/machine.c
similarity index 100%
rename from target-mips/machine.c
rename to target/mips/machine.c
diff --git a/target-mips/mips-defs.h b/target/mips/mips-defs.h
similarity index 100%
rename from target-mips/mips-defs.h
rename to target/mips/mips-defs.h
diff --git a/target-mips/mips-semi.c b/target/mips/mips-semi.c
similarity index 100%
rename from target-mips/mips-semi.c
rename to target/mips/mips-semi.c
diff --git a/target-mips/msa_helper.c b/target/mips/msa_helper.c
similarity index 100%
rename from target-mips/msa_helper.c
rename to target/mips/msa_helper.c
diff --git a/target-mips/op_helper.c b/target/mips/op_helper.c
similarity index 100%
rename from target-mips/op_helper.c
rename to target/mips/op_helper.c
diff --git a/target-mips/translate.c b/target/mips/translate.c
similarity index 100%
rename from target-mips/translate.c
rename to target/mips/translate.c
diff --git a/target-mips/translate_init.c b/target/mips/translate_init.c
similarity index 100%
rename from target-mips/translate_init.c
rename to target/mips/translate_init.c
diff --git a/target-moxie/Makefile.objs b/target/moxie/Makefile.objs
similarity index 100%
rename from target-moxie/Makefile.objs
rename to target/moxie/Makefile.objs
diff --git a/target-moxie/cpu.c b/target/moxie/cpu.c
similarity index 100%
rename from target-moxie/cpu.c
rename to target/moxie/cpu.c
diff --git a/target-moxie/cpu.h b/target/moxie/cpu.h
similarity index 100%
rename from target-moxie/cpu.h
rename to target/moxie/cpu.h
diff --git a/target-moxie/helper.c b/target/moxie/helper.c
similarity index 100%
rename from target-moxie/helper.c
rename to target/moxie/helper.c
diff --git a/target-moxie/helper.h b/target/moxie/helper.h
similarity index 100%
rename from target-moxie/helper.h
rename to target/moxie/helper.h
diff --git a/target-moxie/machine.c b/target/moxie/machine.c
similarity index 100%
rename from target-moxie/machine.c
rename to target/moxie/machine.c
diff --git a/target-moxie/machine.h b/target/moxie/machine.h
similarity index 100%
rename from target-moxie/machine.h
rename to target/moxie/machine.h
diff --git a/target-moxie/mmu.c b/target/moxie/mmu.c
similarity index 100%
rename from target-moxie/mmu.c
rename to target/moxie/mmu.c
diff --git a/target-moxie/mmu.h b/target/moxie/mmu.h
similarity index 100%
rename from target-moxie/mmu.h
rename to target/moxie/mmu.h
diff --git a/target-moxie/translate.c b/target/moxie/translate.c
similarity index 100%
rename from target-moxie/translate.c
rename to target/moxie/translate.c
diff --git a/target-openrisc/Makefile.objs b/target/openrisc/Makefile.objs
similarity index 100%
rename from target-openrisc/Makefile.objs
rename to target/openrisc/Makefile.objs
diff --git a/target-openrisc/cpu.c b/target/openrisc/cpu.c
similarity index 100%
rename from target-openrisc/cpu.c
rename to target/openrisc/cpu.c
diff --git a/target-openrisc/cpu.h b/target/openrisc/cpu.h
similarity index 100%
rename from target-openrisc/cpu.h
rename to target/openrisc/cpu.h
diff --git a/target-openrisc/exception.c b/target/openrisc/exception.c
similarity index 100%
rename from target-openrisc/exception.c
rename to target/openrisc/exception.c
diff --git a/target-openrisc/exception.h b/target/openrisc/exception.h
similarity index 100%
rename from target-openrisc/exception.h
rename to target/openrisc/exception.h
diff --git a/target-openrisc/exception_helper.c b/target/openrisc/exception_helper.c
similarity index 100%
rename from target-openrisc/exception_helper.c
rename to target/openrisc/exception_helper.c
diff --git a/target-openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
similarity index 100%
rename from target-openrisc/fpu_helper.c
rename to target/openrisc/fpu_helper.c
diff --git a/target-openrisc/gdbstub.c b/target/openrisc/gdbstub.c
similarity index 100%
rename from target-openrisc/gdbstub.c
rename to target/openrisc/gdbstub.c
diff --git a/target-openrisc/helper.h b/target/openrisc/helper.h
similarity index 100%
rename from target-openrisc/helper.h
rename to target/openrisc/helper.h
diff --git a/target-openrisc/int_helper.c b/target/openrisc/int_helper.c
similarity index 100%
rename from target-openrisc/int_helper.c
rename to target/openrisc/int_helper.c
diff --git a/target-openrisc/interrupt.c b/target/openrisc/interrupt.c
similarity index 100%
rename from target-openrisc/interrupt.c
rename to target/openrisc/interrupt.c
diff --git a/target-openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
similarity index 100%
rename from target-openrisc/interrupt_helper.c
rename to target/openrisc/interrupt_helper.c
diff --git a/target-openrisc/machine.c b/target/openrisc/machine.c
similarity index 100%
rename from target-openrisc/machine.c
rename to target/openrisc/machine.c
diff --git a/target-openrisc/mmu.c b/target/openrisc/mmu.c
similarity index 100%
rename from target-openrisc/mmu.c
rename to target/openrisc/mmu.c
diff --git a/target-openrisc/mmu_helper.c b/target/openrisc/mmu_helper.c
similarity index 100%
rename from target-openrisc/mmu_helper.c
rename to target/openrisc/mmu_helper.c
diff --git a/target-openrisc/sys_helper.c b/target/openrisc/sys_helper.c
similarity index 100%
rename from target-openrisc/sys_helper.c
rename to target/openrisc/sys_helper.c
diff --git a/target-openrisc/translate.c b/target/openrisc/translate.c
similarity index 100%
rename from target-openrisc/translate.c
rename to target/openrisc/translate.c
diff --git a/target-ppc/Makefile.objs b/target/ppc/Makefile.objs
similarity index 100%
rename from target-ppc/Makefile.objs
rename to target/ppc/Makefile.objs
diff --git a/target-ppc/STATUS b/target/ppc/STATUS
similarity index 100%
rename from target-ppc/STATUS
rename to target/ppc/STATUS
diff --git a/target-ppc/arch_dump.c b/target/ppc/arch_dump.c
similarity index 100%
rename from target-ppc/arch_dump.c
rename to target/ppc/arch_dump.c
diff --git a/target-ppc/cpu-models.c b/target/ppc/cpu-models.c
similarity index 100%
rename from target-ppc/cpu-models.c
rename to target/ppc/cpu-models.c
diff --git a/target-ppc/cpu-models.h b/target/ppc/cpu-models.h
similarity index 100%
rename from target-ppc/cpu-models.h
rename to target/ppc/cpu-models.h
diff --git a/target-ppc/cpu-qom.h b/target/ppc/cpu-qom.h
similarity index 100%
rename from target-ppc/cpu-qom.h
rename to target/ppc/cpu-qom.h
diff --git a/target-ppc/cpu.h b/target/ppc/cpu.h
similarity index 100%
rename from target-ppc/cpu.h
rename to target/ppc/cpu.h
diff --git a/target-ppc/dfp_helper.c b/target/ppc/dfp_helper.c
similarity index 100%
rename from target-ppc/dfp_helper.c
rename to target/ppc/dfp_helper.c
diff --git a/target-ppc/excp_helper.c b/target/ppc/excp_helper.c
similarity index 100%
rename from target-ppc/excp_helper.c
rename to target/ppc/excp_helper.c
diff --git a/target-ppc/fpu_helper.c b/target/ppc/fpu_helper.c
similarity index 100%
rename from target-ppc/fpu_helper.c
rename to target/ppc/fpu_helper.c
diff --git a/target-ppc/gdbstub.c b/target/ppc/gdbstub.c
similarity index 100%
rename from target-ppc/gdbstub.c
rename to target/ppc/gdbstub.c
diff --git a/target-ppc/helper.h b/target/ppc/helper.h
similarity index 100%
rename from target-ppc/helper.h
rename to target/ppc/helper.h
diff --git a/target-ppc/helper_regs.h b/target/ppc/helper_regs.h
similarity index 100%
rename from target-ppc/helper_regs.h
rename to target/ppc/helper_regs.h
diff --git a/target-ppc/int_helper.c b/target/ppc/int_helper.c
similarity index 100%
rename from target-ppc/int_helper.c
rename to target/ppc/int_helper.c
diff --git a/target-ppc/internal.h b/target/ppc/internal.h
similarity index 100%
rename from target-ppc/internal.h
rename to target/ppc/internal.h
diff --git a/target-ppc/kvm-stub.c b/target/ppc/kvm-stub.c
similarity index 100%
rename from target-ppc/kvm-stub.c
rename to target/ppc/kvm-stub.c
diff --git a/target-ppc/kvm.c b/target/ppc/kvm.c
similarity index 100%
rename from target-ppc/kvm.c
rename to target/ppc/kvm.c
diff --git a/target-ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
similarity index 100%
rename from target-ppc/kvm_ppc.h
rename to target/ppc/kvm_ppc.h
diff --git a/target-ppc/machine.c b/target/ppc/machine.c
similarity index 100%
rename from target-ppc/machine.c
rename to target/ppc/machine.c
diff --git a/target-ppc/mem_helper.c b/target/ppc/mem_helper.c
similarity index 100%
rename from target-ppc/mem_helper.c
rename to target/ppc/mem_helper.c
diff --git a/target-ppc/mfrom_table.c b/target/ppc/mfrom_table.c
similarity index 100%
rename from target-ppc/mfrom_table.c
rename to target/ppc/mfrom_table.c
diff --git a/target-ppc/mfrom_table_gen.c b/target/ppc/mfrom_table_gen.c
similarity index 100%
rename from target-ppc/mfrom_table_gen.c
rename to target/ppc/mfrom_table_gen.c
diff --git a/target-ppc/misc_helper.c b/target/ppc/misc_helper.c
similarity index 100%
rename from target-ppc/misc_helper.c
rename to target/ppc/misc_helper.c
diff --git a/target-ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
similarity index 100%
rename from target-ppc/mmu-hash32.c
rename to target/ppc/mmu-hash32.c
diff --git a/target-ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
similarity index 100%
rename from target-ppc/mmu-hash32.h
rename to target/ppc/mmu-hash32.h
diff --git a/target-ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
similarity index 100%
rename from target-ppc/mmu-hash64.c
rename to target/ppc/mmu-hash64.c
diff --git a/target-ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
similarity index 100%
rename from target-ppc/mmu-hash64.h
rename to target/ppc/mmu-hash64.h
diff --git a/target-ppc/mmu_helper.c b/target/ppc/mmu_helper.c
similarity index 100%
rename from target-ppc/mmu_helper.c
rename to target/ppc/mmu_helper.c
diff --git a/target-ppc/monitor.c b/target/ppc/monitor.c
similarity index 100%
rename from target-ppc/monitor.c
rename to target/ppc/monitor.c
diff --git a/target-ppc/timebase_helper.c b/target/ppc/timebase_helper.c
similarity index 100%
rename from target-ppc/timebase_helper.c
rename to target/ppc/timebase_helper.c
diff --git a/target-ppc/trace-events b/target/ppc/trace-events
similarity index 92%
rename from target-ppc/trace-events
rename to target/ppc/trace-events
index 8fcc3ce..b666156 100644
--- a/target-ppc/trace-events
+++ b/target/ppc/trace-events
@@ -1,5 +1,5 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-ppc/kvm.c
+# target/ppc/kvm.c
 kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR %d to KVM: %s"
 kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retrieve SPR %d from KVM: %s"
diff --git a/target-ppc/translate.c b/target/ppc/translate.c
similarity index 100%
rename from target-ppc/translate.c
rename to target/ppc/translate.c
diff --git a/target-ppc/translate/dfp-impl.inc.c b/target/ppc/translate/dfp-impl.inc.c
similarity index 100%
rename from target-ppc/translate/dfp-impl.inc.c
rename to target/ppc/translate/dfp-impl.inc.c
diff --git a/target-ppc/translate/dfp-ops.inc.c b/target/ppc/translate/dfp-ops.inc.c
similarity index 100%
rename from target-ppc/translate/dfp-ops.inc.c
rename to target/ppc/translate/dfp-ops.inc.c
diff --git a/target-ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
similarity index 100%
rename from target-ppc/translate/fp-impl.inc.c
rename to target/ppc/translate/fp-impl.inc.c
diff --git a/target-ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-ops.inc.c
similarity index 100%
rename from target-ppc/translate/fp-ops.inc.c
rename to target/ppc/translate/fp-ops.inc.c
diff --git a/target-ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc.c
similarity index 100%
rename from target-ppc/translate/spe-impl.inc.c
rename to target/ppc/translate/spe-impl.inc.c
diff --git a/target-ppc/translate/spe-ops.inc.c b/target/ppc/translate/spe-ops.inc.c
similarity index 100%
rename from target-ppc/translate/spe-ops.inc.c
rename to target/ppc/translate/spe-ops.inc.c
diff --git a/target-ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
similarity index 100%
rename from target-ppc/translate/vmx-impl.inc.c
rename to target/ppc/translate/vmx-impl.inc.c
diff --git a/target-ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vmx-ops.inc.c
similarity index 100%
rename from target-ppc/translate/vmx-ops.inc.c
rename to target/ppc/translate/vmx-ops.inc.c
diff --git a/target-ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
similarity index 100%
rename from target-ppc/translate/vsx-impl.inc.c
rename to target/ppc/translate/vsx-impl.inc.c
diff --git a/target-ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vsx-ops.inc.c
similarity index 100%
rename from target-ppc/translate/vsx-ops.inc.c
rename to target/ppc/translate/vsx-ops.inc.c
diff --git a/target-ppc/translate_init.c b/target/ppc/translate_init.c
similarity index 100%
rename from target-ppc/translate_init.c
rename to target/ppc/translate_init.c
diff --git a/target-ppc/user_only_helper.c b/target/ppc/user_only_helper.c
similarity index 100%
rename from target-ppc/user_only_helper.c
rename to target/ppc/user_only_helper.c
diff --git a/target-s390x/Makefile.objs b/target/s390x/Makefile.objs
similarity index 94%
rename from target-s390x/Makefile.objs
rename to target/s390x/Makefile.objs
index 6b02b17..c573633 100644
--- a/target-s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -5,7 +5,7 @@ obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
 obj-$(CONFIG_KVM) += kvm.o
 
 # build and run feature list generator
-feat-src = $(SRC_PATH)/target-$(TARGET_BASE_ARCH)/
+feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
 feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
 ifneq ($(MAKECMDGOALS),clean)
 GENERATED_HEADERS += $(feat-dst)gen-features.h
diff --git a/target-s390x/arch_dump.c b/target/s390x/arch_dump.c
similarity index 100%
rename from target-s390x/arch_dump.c
rename to target/s390x/arch_dump.c
diff --git a/target-s390x/cc_helper.c b/target/s390x/cc_helper.c
similarity index 100%
rename from target-s390x/cc_helper.c
rename to target/s390x/cc_helper.c
diff --git a/target-s390x/cpu-qom.h b/target/s390x/cpu-qom.h
similarity index 100%
rename from target-s390x/cpu-qom.h
rename to target/s390x/cpu-qom.h
diff --git a/target-s390x/cpu.c b/target/s390x/cpu.c
similarity index 100%
rename from target-s390x/cpu.c
rename to target/s390x/cpu.c
diff --git a/target-s390x/cpu.h b/target/s390x/cpu.h
similarity index 100%
rename from target-s390x/cpu.h
rename to target/s390x/cpu.h
diff --git a/target-s390x/cpu_features.c b/target/s390x/cpu_features.c
similarity index 100%
rename from target-s390x/cpu_features.c
rename to target/s390x/cpu_features.c
diff --git a/target-s390x/cpu_features.h b/target/s390x/cpu_features.h
similarity index 100%
rename from target-s390x/cpu_features.h
rename to target/s390x/cpu_features.h
diff --git a/target-s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
similarity index 100%
rename from target-s390x/cpu_features_def.h
rename to target/s390x/cpu_features_def.h
diff --git a/target-s390x/cpu_models.c b/target/s390x/cpu_models.c
similarity index 100%
rename from target-s390x/cpu_models.c
rename to target/s390x/cpu_models.c
diff --git a/target-s390x/cpu_models.h b/target/s390x/cpu_models.h
similarity index 100%
rename from target-s390x/cpu_models.h
rename to target/s390x/cpu_models.h
diff --git a/target-s390x/fpu_helper.c b/target/s390x/fpu_helper.c
similarity index 100%
rename from target-s390x/fpu_helper.c
rename to target/s390x/fpu_helper.c
diff --git a/target-s390x/gdbstub.c b/target/s390x/gdbstub.c
similarity index 100%
rename from target-s390x/gdbstub.c
rename to target/s390x/gdbstub.c
diff --git a/target-s390x/gen-features.c b/target/s390x/gen-features.c
similarity index 100%
rename from target-s390x/gen-features.c
rename to target/s390x/gen-features.c
diff --git a/target-s390x/helper.c b/target/s390x/helper.c
similarity index 100%
rename from target-s390x/helper.c
rename to target/s390x/helper.c
diff --git a/target-s390x/helper.h b/target/s390x/helper.h
similarity index 100%
rename from target-s390x/helper.h
rename to target/s390x/helper.h
diff --git a/target-s390x/insn-data.def b/target/s390x/insn-data.def
similarity index 100%
rename from target-s390x/insn-data.def
rename to target/s390x/insn-data.def
diff --git a/target-s390x/insn-format.def b/target/s390x/insn-format.def
similarity index 100%
rename from target-s390x/insn-format.def
rename to target/s390x/insn-format.def
diff --git a/target-s390x/int_helper.c b/target/s390x/int_helper.c
similarity index 100%
rename from target-s390x/int_helper.c
rename to target/s390x/int_helper.c
diff --git a/target-s390x/interrupt.c b/target/s390x/interrupt.c
similarity index 100%
rename from target-s390x/interrupt.c
rename to target/s390x/interrupt.c
diff --git a/target-s390x/ioinst.c b/target/s390x/ioinst.c
similarity index 100%
rename from target-s390x/ioinst.c
rename to target/s390x/ioinst.c
diff --git a/target-s390x/kvm.c b/target/s390x/kvm.c
similarity index 100%
rename from target-s390x/kvm.c
rename to target/s390x/kvm.c
diff --git a/target-s390x/machine.c b/target/s390x/machine.c
similarity index 100%
rename from target-s390x/machine.c
rename to target/s390x/machine.c
diff --git a/target-s390x/mem_helper.c b/target/s390x/mem_helper.c
similarity index 100%
rename from target-s390x/mem_helper.c
rename to target/s390x/mem_helper.c
diff --git a/target-s390x/misc_helper.c b/target/s390x/misc_helper.c
similarity index 100%
rename from target-s390x/misc_helper.c
rename to target/s390x/misc_helper.c
diff --git a/target-s390x/mmu_helper.c b/target/s390x/mmu_helper.c
similarity index 100%
rename from target-s390x/mmu_helper.c
rename to target/s390x/mmu_helper.c
diff --git a/target-s390x/trace-events b/target/s390x/trace-events
similarity index 91%
rename from target-s390x/trace-events
rename to target/s390x/trace-events
index df59f5f..1574033 100644
--- a/target-s390x/trace-events
+++ b/target/s390x/trace-events
@@ -1,22 +1,22 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-s390x/mmu_helper.c
+# target/s390x/mmu_helper.c
 get_skeys_nonzero(int rc) "SKEY: Call to get_skeys unexpectedly returned %d"
 set_skeys_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
 
-# target-s390x/ioinst.c
+# target/s390x/ioinst.c
 ioinst(const char *insn) "IOINST: %s"
 ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
 ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
 ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
 
-# target-s390x/kvm.c
+# target/s390x/kvm.c
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
 kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
 kvm_sigp_finished(uint8_t order, int cpu_index, int dst_index, int cc) "SIGP: Finished order %u on cpu %d -> cpu %d with cc=%d"
 
-# target-s390x/cpu.c
+# target/s390x/cpu.c
 cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
 cpu_halt(int cpu_index) "halting cpu %d"
 cpu_unhalt(int cpu_index) "unhalting cpu %d"
diff --git a/target-s390x/translate.c b/target/s390x/translate.c
similarity index 100%
rename from target-s390x/translate.c
rename to target/s390x/translate.c
diff --git a/target-sh4/Makefile.objs b/target/sh4/Makefile.objs
similarity index 100%
rename from target-sh4/Makefile.objs
rename to target/sh4/Makefile.objs
diff --git a/target-sh4/README.sh4 b/target/sh4/README.sh4
similarity index 98%
rename from target-sh4/README.sh4
rename to target/sh4/README.sh4
index ece0464..a192ca7 100644
--- a/target-sh4/README.sh4
+++ b/target/sh4/README.sh4
@@ -8,7 +8,7 @@ file describes the current state of implementation.
 Most places requiring attention and/or modification can be detected by
 looking for "XXXXX" or "abort()".
 
-The sh4 core is located in target-sh4/*, while the 7750 peripheral
+The sh4 core is located in target/sh4/*, while the 7750 peripheral
 features (IO ports for example) are located in hw/sh7750.[ch]. The
 main board description is in hw/shix.c, and the NAND flash in
 hw/tc58128.[ch].
diff --git a/target-sh4/cpu-qom.h b/target/sh4/cpu-qom.h
similarity index 100%
rename from target-sh4/cpu-qom.h
rename to target/sh4/cpu-qom.h
diff --git a/target-sh4/cpu.c b/target/sh4/cpu.c
similarity index 100%
rename from target-sh4/cpu.c
rename to target/sh4/cpu.c
diff --git a/target-sh4/cpu.h b/target/sh4/cpu.h
similarity index 100%
rename from target-sh4/cpu.h
rename to target/sh4/cpu.h
diff --git a/target-sh4/gdbstub.c b/target/sh4/gdbstub.c
similarity index 100%
rename from target-sh4/gdbstub.c
rename to target/sh4/gdbstub.c
diff --git a/target-sh4/helper.c b/target/sh4/helper.c
similarity index 100%
rename from target-sh4/helper.c
rename to target/sh4/helper.c
diff --git a/target-sh4/helper.h b/target/sh4/helper.h
similarity index 100%
rename from target-sh4/helper.h
rename to target/sh4/helper.h
diff --git a/target-sh4/monitor.c b/target/sh4/monitor.c
similarity index 100%
rename from target-sh4/monitor.c
rename to target/sh4/monitor.c
diff --git a/target-sh4/op_helper.c b/target/sh4/op_helper.c
similarity index 100%
rename from target-sh4/op_helper.c
rename to target/sh4/op_helper.c
diff --git a/target-sh4/translate.c b/target/sh4/translate.c
similarity index 100%
rename from target-sh4/translate.c
rename to target/sh4/translate.c
diff --git a/target-sparc/Makefile.objs b/target/sparc/Makefile.objs
similarity index 100%
rename from target-sparc/Makefile.objs
rename to target/sparc/Makefile.objs
diff --git a/target-sparc/TODO b/target/sparc/TODO
similarity index 100%
rename from target-sparc/TODO
rename to target/sparc/TODO
diff --git a/target-sparc/asi.h b/target/sparc/asi.h
similarity index 100%
rename from target-sparc/asi.h
rename to target/sparc/asi.h
diff --git a/target-sparc/cc_helper.c b/target/sparc/cc_helper.c
similarity index 100%
rename from target-sparc/cc_helper.c
rename to target/sparc/cc_helper.c
diff --git a/target-sparc/cpu-qom.h b/target/sparc/cpu-qom.h
similarity index 100%
rename from target-sparc/cpu-qom.h
rename to target/sparc/cpu-qom.h
diff --git a/target-sparc/cpu.c b/target/sparc/cpu.c
similarity index 100%
rename from target-sparc/cpu.c
rename to target/sparc/cpu.c
diff --git a/target-sparc/cpu.h b/target/sparc/cpu.h
similarity index 100%
rename from target-sparc/cpu.h
rename to target/sparc/cpu.h
diff --git a/target-sparc/fop_helper.c b/target/sparc/fop_helper.c
similarity index 100%
rename from target-sparc/fop_helper.c
rename to target/sparc/fop_helper.c
diff --git a/target-sparc/gdbstub.c b/target/sparc/gdbstub.c
similarity index 100%
rename from target-sparc/gdbstub.c
rename to target/sparc/gdbstub.c
diff --git a/target-sparc/helper.c b/target/sparc/helper.c
similarity index 100%
rename from target-sparc/helper.c
rename to target/sparc/helper.c
diff --git a/target-sparc/helper.h b/target/sparc/helper.h
similarity index 100%
rename from target-sparc/helper.h
rename to target/sparc/helper.h
diff --git a/target-sparc/int32_helper.c b/target/sparc/int32_helper.c
similarity index 100%
rename from target-sparc/int32_helper.c
rename to target/sparc/int32_helper.c
diff --git a/target-sparc/int64_helper.c b/target/sparc/int64_helper.c
similarity index 100%
rename from target-sparc/int64_helper.c
rename to target/sparc/int64_helper.c
diff --git a/target-sparc/ldst_helper.c b/target/sparc/ldst_helper.c
similarity index 100%
rename from target-sparc/ldst_helper.c
rename to target/sparc/ldst_helper.c
diff --git a/target-sparc/machine.c b/target/sparc/machine.c
similarity index 100%
rename from target-sparc/machine.c
rename to target/sparc/machine.c
diff --git a/target-sparc/mmu_helper.c b/target/sparc/mmu_helper.c
similarity index 100%
rename from target-sparc/mmu_helper.c
rename to target/sparc/mmu_helper.c
diff --git a/target-sparc/monitor.c b/target/sparc/monitor.c
similarity index 100%
rename from target-sparc/monitor.c
rename to target/sparc/monitor.c
diff --git a/target-sparc/trace-events b/target/sparc/trace-events
similarity index 94%
rename from target-sparc/trace-events
rename to target/sparc/trace-events
index bf52d97..8df178a 100644
--- a/target-sparc/trace-events
+++ b/target/sparc/trace-events
@@ -1,6 +1,6 @@
 # See docs/tracing.txt for syntax documentation.
 
-# target-sparc/mmu_helper.c
+# target/sparc/mmu_helper.c
 mmu_helper_dfault(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DFAULT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
 mmu_helper_dprot(uint64_t address, uint64_t context, int mmu_idx, uint32_t tl) "DPROT at %"PRIx64" context %"PRIx64" mmu_idx=%d tl=%d"
 mmu_helper_dmiss(uint64_t address, uint64_t context) "DMISS at %"PRIx64" context %"PRIx64
@@ -10,16 +10,16 @@ mmu_helper_get_phys_addr_code(uint32_t tl, int mmu_idx, uint64_t prim_context, u
 mmu_helper_get_phys_addr_data(uint32_t tl, int mmu_idx, uint64_t prim_context, uint64_t sec_context, uint64_t address) "tl=%d mmu_idx=%d primary context=%"PRIx64" secondary context=%"PRIx64" address=%"PRIx64
 mmu_helper_mmu_fault(uint64_t address, uint64_t paddr, int mmu_idx, uint32_t tl, uint64_t prim_context, uint64_t sec_context) "Translate at %"PRIx64" -> %"PRIx64", mmu_idx=%d tl=%d primary context=%"PRIx64" secondary context=%"PRIx64
 
-# target-sparc/int64_helper.c
+# target/sparc/int64_helper.c
 int_helper_set_softint(uint32_t softint) "new %08x"
 int_helper_clear_softint(uint32_t softint) "new %08x"
 int_helper_write_softint(uint32_t softint) "new %08x"
 
-# target-sparc/int32_helper.c
+# target/sparc/int32_helper.c
 int_helper_icache_freeze(void) "Instruction cache: freeze"
 int_helper_dcache_freeze(void) "Data cache: freeze"
 
-# target-sparc/win_helper.c
+# target/sparc/win_helper.c
 win_helper_gregset_error(uint32_t pstate) "ERROR in get_gregset: active pstate bits=%x"
 win_helper_switch_pstate(uint32_t pstate_regs, uint32_t new_pstate_regs) "change_pstate: switching regs old=%x new=%x"
 win_helper_no_switch_pstate(uint32_t new_pstate_regs) "change_pstate: regs new=%x (unchanged)"
diff --git a/target-sparc/translate.c b/target/sparc/translate.c
similarity index 100%
rename from target-sparc/translate.c
rename to target/sparc/translate.c
diff --git a/target-sparc/vis_helper.c b/target/sparc/vis_helper.c
similarity index 100%
rename from target-sparc/vis_helper.c
rename to target/sparc/vis_helper.c
diff --git a/target-sparc/win_helper.c b/target/sparc/win_helper.c
similarity index 100%
rename from target-sparc/win_helper.c
rename to target/sparc/win_helper.c
diff --git a/target-tilegx/Makefile.objs b/target/tilegx/Makefile.objs
similarity index 100%
rename from target-tilegx/Makefile.objs
rename to target/tilegx/Makefile.objs
diff --git a/target-tilegx/cpu.c b/target/tilegx/cpu.c
similarity index 100%
rename from target-tilegx/cpu.c
rename to target/tilegx/cpu.c
diff --git a/target-tilegx/cpu.h b/target/tilegx/cpu.h
similarity index 100%
rename from target-tilegx/cpu.h
rename to target/tilegx/cpu.h
diff --git a/target-tilegx/helper.c b/target/tilegx/helper.c
similarity index 100%
rename from target-tilegx/helper.c
rename to target/tilegx/helper.c
diff --git a/target-tilegx/helper.h b/target/tilegx/helper.h
similarity index 100%
rename from target-tilegx/helper.h
rename to target/tilegx/helper.h
diff --git a/target-tilegx/opcode_tilegx.h b/target/tilegx/opcode_tilegx.h
similarity index 100%
rename from target-tilegx/opcode_tilegx.h
rename to target/tilegx/opcode_tilegx.h
diff --git a/target-tilegx/simd_helper.c b/target/tilegx/simd_helper.c
similarity index 100%
rename from target-tilegx/simd_helper.c
rename to target/tilegx/simd_helper.c
diff --git a/target-tilegx/spr_def_64.h b/target/tilegx/spr_def_64.h
similarity index 100%
rename from target-tilegx/spr_def_64.h
rename to target/tilegx/spr_def_64.h
diff --git a/target-tilegx/translate.c b/target/tilegx/translate.c
similarity index 100%
rename from target-tilegx/translate.c
rename to target/tilegx/translate.c
diff --git a/target-tricore/Makefile.objs b/target/tricore/Makefile.objs
similarity index 100%
rename from target-tricore/Makefile.objs
rename to target/tricore/Makefile.objs
diff --git a/target-tricore/cpu-qom.h b/target/tricore/cpu-qom.h
similarity index 100%
rename from target-tricore/cpu-qom.h
rename to target/tricore/cpu-qom.h
diff --git a/target-tricore/cpu.c b/target/tricore/cpu.c
similarity index 100%
rename from target-tricore/cpu.c
rename to target/tricore/cpu.c
diff --git a/target-tricore/cpu.h b/target/tricore/cpu.h
similarity index 100%
rename from target-tricore/cpu.h
rename to target/tricore/cpu.h
diff --git a/target-tricore/csfr.def b/target/tricore/csfr.def
similarity index 100%
rename from target-tricore/csfr.def
rename to target/tricore/csfr.def
diff --git a/target-tricore/fpu_helper.c b/target/tricore/fpu_helper.c
similarity index 100%
rename from target-tricore/fpu_helper.c
rename to target/tricore/fpu_helper.c
diff --git a/target-tricore/helper.c b/target/tricore/helper.c
similarity index 100%
rename from target-tricore/helper.c
rename to target/tricore/helper.c
diff --git a/target-tricore/helper.h b/target/tricore/helper.h
similarity index 100%
rename from target-tricore/helper.h
rename to target/tricore/helper.h
diff --git a/target-tricore/op_helper.c b/target/tricore/op_helper.c
similarity index 100%
rename from target-tricore/op_helper.c
rename to target/tricore/op_helper.c
diff --git a/target-tricore/translate.c b/target/tricore/translate.c
similarity index 100%
rename from target-tricore/translate.c
rename to target/tricore/translate.c
diff --git a/target-tricore/tricore-defs.h b/target/tricore/tricore-defs.h
similarity index 100%
rename from target-tricore/tricore-defs.h
rename to target/tricore/tricore-defs.h
diff --git a/target-tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
similarity index 100%
rename from target-tricore/tricore-opcodes.h
rename to target/tricore/tricore-opcodes.h
diff --git a/target-unicore32/Makefile.objs b/target/unicore32/Makefile.objs
similarity index 100%
rename from target-unicore32/Makefile.objs
rename to target/unicore32/Makefile.objs
diff --git a/target-unicore32/cpu-qom.h b/target/unicore32/cpu-qom.h
similarity index 100%
rename from target-unicore32/cpu-qom.h
rename to target/unicore32/cpu-qom.h
diff --git a/target-unicore32/cpu.c b/target/unicore32/cpu.c
similarity index 100%
rename from target-unicore32/cpu.c
rename to target/unicore32/cpu.c
diff --git a/target-unicore32/cpu.h b/target/unicore32/cpu.h
similarity index 100%
rename from target-unicore32/cpu.h
rename to target/unicore32/cpu.h
diff --git a/target-unicore32/helper.c b/target/unicore32/helper.c
similarity index 100%
rename from target-unicore32/helper.c
rename to target/unicore32/helper.c
diff --git a/target-unicore32/helper.h b/target/unicore32/helper.h
similarity index 100%
rename from target-unicore32/helper.h
rename to target/unicore32/helper.h
diff --git a/target-unicore32/op_helper.c b/target/unicore32/op_helper.c
similarity index 100%
rename from target-unicore32/op_helper.c
rename to target/unicore32/op_helper.c
diff --git a/target-unicore32/softmmu.c b/target/unicore32/softmmu.c
similarity index 100%
rename from target-unicore32/softmmu.c
rename to target/unicore32/softmmu.c
diff --git a/target-unicore32/translate.c b/target/unicore32/translate.c
similarity index 100%
rename from target-unicore32/translate.c
rename to target/unicore32/translate.c
diff --git a/target-unicore32/ucf64_helper.c b/target/unicore32/ucf64_helper.c
similarity index 100%
rename from target-unicore32/ucf64_helper.c
rename to target/unicore32/ucf64_helper.c
diff --git a/target-xtensa/Makefile.objs b/target/xtensa/Makefile.objs
similarity index 100%
rename from target-xtensa/Makefile.objs
rename to target/xtensa/Makefile.objs
diff --git a/target-xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
similarity index 100%
rename from target-xtensa/core-dc232b.c
rename to target/xtensa/core-dc232b.c
diff --git a/target-xtensa/core-dc232b/core-isa.h b/target/xtensa/core-dc232b/core-isa.h
similarity index 100%
rename from target-xtensa/core-dc232b/core-isa.h
rename to target/xtensa/core-dc232b/core-isa.h
diff --git a/target-xtensa/core-dc232b/gdb-config.c b/target/xtensa/core-dc232b/gdb-config.c
similarity index 100%
rename from target-xtensa/core-dc232b/gdb-config.c
rename to target/xtensa/core-dc232b/gdb-config.c
diff --git a/target-xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
similarity index 100%
rename from target-xtensa/core-dc233c.c
rename to target/xtensa/core-dc233c.c
diff --git a/target-xtensa/core-dc233c/core-isa.h b/target/xtensa/core-dc233c/core-isa.h
similarity index 100%
rename from target-xtensa/core-dc233c/core-isa.h
rename to target/xtensa/core-dc233c/core-isa.h
diff --git a/target-xtensa/core-dc233c/gdb-config.c b/target/xtensa/core-dc233c/gdb-config.c
similarity index 100%
rename from target-xtensa/core-dc233c/gdb-config.c
rename to target/xtensa/core-dc233c/gdb-config.c
diff --git a/target-xtensa/core-fsf.c b/target/xtensa/core-fsf.c
similarity index 100%
rename from target-xtensa/core-fsf.c
rename to target/xtensa/core-fsf.c
diff --git a/target-xtensa/core-fsf/core-isa.h b/target/xtensa/core-fsf/core-isa.h
similarity index 100%
rename from target-xtensa/core-fsf/core-isa.h
rename to target/xtensa/core-fsf/core-isa.h
diff --git a/target-xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
similarity index 100%
rename from target-xtensa/cpu-qom.h
rename to target/xtensa/cpu-qom.h
diff --git a/target-xtensa/cpu.c b/target/xtensa/cpu.c
similarity index 100%
rename from target-xtensa/cpu.c
rename to target/xtensa/cpu.c
diff --git a/target-xtensa/cpu.h b/target/xtensa/cpu.h
similarity index 100%
rename from target-xtensa/cpu.h
rename to target/xtensa/cpu.h
diff --git a/target-xtensa/gdbstub.c b/target/xtensa/gdbstub.c
similarity index 100%
rename from target-xtensa/gdbstub.c
rename to target/xtensa/gdbstub.c
diff --git a/target-xtensa/helper.c b/target/xtensa/helper.c
similarity index 100%
rename from target-xtensa/helper.c
rename to target/xtensa/helper.c
diff --git a/target-xtensa/helper.h b/target/xtensa/helper.h
similarity index 100%
rename from target-xtensa/helper.h
rename to target/xtensa/helper.h
diff --git a/target-xtensa/import_core.sh b/target/xtensa/import_core.sh
similarity index 100%
rename from target-xtensa/import_core.sh
rename to target/xtensa/import_core.sh
diff --git a/target-xtensa/monitor.c b/target/xtensa/monitor.c
similarity index 100%
rename from target-xtensa/monitor.c
rename to target/xtensa/monitor.c
diff --git a/target-xtensa/op_helper.c b/target/xtensa/op_helper.c
similarity index 100%
rename from target-xtensa/op_helper.c
rename to target/xtensa/op_helper.c
diff --git a/target-xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
similarity index 100%
rename from target-xtensa/overlay_tool.h
rename to target/xtensa/overlay_tool.h
diff --git a/target-xtensa/translate.c b/target/xtensa/translate.c
similarity index 100%
rename from target-xtensa/translate.c
rename to target/xtensa/translate.c
diff --git a/target-xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
similarity index 100%
rename from target-xtensa/xtensa-semi.c
rename to target/xtensa/xtensa-semi.c
diff --git a/tests/tcg/xtensa/Makefile b/tests/tcg/xtensa/Makefile
index 522a63e..7f9f2d9 100644
--- a/tests/tcg/xtensa/Makefile
+++ b/tests/tcg/xtensa/Makefile
@@ -19,7 +19,7 @@ AS      = $(CROSS)gcc -x assembler-with-cpp
 LD      = $(CROSS)ld
 
 XTENSA_SRC_PATH = $(SRC_PATH)/tests/tcg/xtensa
-INCLUDE_DIRS = $(XTENSA_SRC_PATH) $(SRC_PATH)/target-xtensa/core-$(CORE)
+INCLUDE_DIRS = $(XTENSA_SRC_PATH) $(SRC_PATH)/target/xtensa/core-$(CORE)
 XTENSA_INC = $(addprefix -I,$(INCLUDE_DIRS))
 
 LDFLAGS = -Tlinker.ld
-- 
1.8.3.1
