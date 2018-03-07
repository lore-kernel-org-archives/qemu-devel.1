Received: from eggs.gnu.org ([2001:4830:134:3::10]:47879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etMeI-0007D5-JQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 19:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etMeC-0007mO-6v
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 19:09:38 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:43230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etMeB-0007lp-RM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 19:09:32 -0500
Received: by mail-oi0-x235.google.com with SMTP id a207so356204oii.10
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 16:09:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520365586-30384-1-git-send-email-mjc@sifive.com>
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 13:09:29 +1300
Message-ID: <CAHNT7NsMoYNNXyPPqWaDD4op8vtQAZGHKnjWtpTpb8xv80CaUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>, "Richard W.M. Jones" <rjones@redhat.com>

FYI - Travis completed builds for v8.2 and it's all green.

- https://travis-ci.org/riscv/riscv-qemu/builds/349981074

The Travis folks kindly bumped our build timeout limit so we can run the
full upstream Travis checks. I've manually tested Linux in all of the
relevant machines, including SMP in the RISC-V virt machine, along with
embedded binaries for the SiFive E series MCU. We test 'sifive_e' with MCU
samples from SiFive's Freedom E SDK. the Freedom U SDK has a
Linux buildroot setup for testing the 'virt' machine. There is additional
documentation on the wiki, such as links to the Fedora images that Richard
W. M. Jones et al have been working on.

- https://github.com/sifive/freedom-e-sdk/
- https://github.com/sifive/freedom-u-sdk/
- https://github.com/riscv/riscv-qemu/wiki

Hopefully, this PR gets merged...

On Wed, Mar 7, 2018 at 8:46 AM, Michael Clark <mjc@sifive.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The following changes since commit f32408f3b472a088467474ab152be3
> b6285b2d7b:
>
>   misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30
> +0000)
>
> are available in the git repository at:
>
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v8.2
>
> for you to fetch changes up to 7051b081bf6796e5e84406f6223a7c4900bf7298:
>
>   RISC-V - Remove support for adhoc non-standard X_COP local-interrupt
> (2018-03-07 08:36:03 +1300)
>
> - ----------------------------------------------------------------
> QEMU RISC-V Emulation Support (RV64GC, RV32GC)
>
> This release renames the SiFive machines to sifive_e and sifive_u
> to represent the SiFive Everywhere and SiFive Unleashed platforms.
> SiFive has configurable soft-core IP, so it is intended that these
> machines will be extended to enable a variety of SiFive IP blocks.
> The CPU definition infrastructure has been improved and there are
> now vendor CPU modules including the SiFiVe E31, E51, U34 and U54
> cores. The emulation accuracy for the E series has been improved
> by disabling the MMU for the E series. S mode has been disabled on
> cores that only support M mode and U mode. The two Spike machines
> that support two privileged ISA versions have been coalesced into
> one file. This series has Signed-off-by from the core contributors.
>
> *** Known Issues ***
>
> * Disassembler has some checkpatch warnings for the sake of code brevity
> * scripts/qemu-binfmt-conf.sh has checkpatch warnings due to line length
> * PMP (Physical Memory Protection) is as-of-yet unused and needs testing
>
> *** Changelog ***
>
> v8.2
>
> * Rebase
>
> v8.1
>
> * Fix missed case of renaming spike_v1.9 to spike_v1.9.1
>
> v8
>
> * Added linux-user/riscv/target_elf.h during rebase
> * Make resetvec configurable and clear mpp and mie on reset
> * Use SiFive E31, E51, U34 and U54 cores in SiFive machines
> * Define SiFive E31, E51, U34 and U54 cores
> * Refactor CPU core definition in preparation for vendor cores
> * Prevent S or U mode unless S or U extensions are present
> * SiFive E Series cores have no MMU
> * SiFive E Series cores have U mode
> * Make privileged ISA v1.10 implicit in CPU types
> * Remove DRAM_BASE and EXT_IO_BASE as they vary by machine
> * Correctly handle mtvec and stvec alignment with respect to RVC
> * Print more machine mode state in riscv_cpu_dump_state
> * Make riscv_isa_string use compact extension order method
> * Fix bug introduced in v6 RISCV_CPU_TYPE_NAME macro change
> * Parameterize spike v1.9.1 config string
> * Coalesce spike_v1.9.1 and spike_v1.10 machines
> * Rename sifive_e300 to sifive_e, and sifive_u500 to sifive_u
>
> v7
>
> * Make spike_v1.10 the default machine
> * Rename spike_v1.9 to spike_v1.9.1 to match privileged spec version
> * Remove empty target/riscv/trace-events file
> * Monitor ROM 32-bit reset code needs to be target endian
> * Add TARGET_TIOCGPTPEER to linux-user/riscv/termbits.h
> * Add -initrd support to the virt board
> * Fix naming in spike machine interface header
> * Update copyright notice on RISC-V Spike machines
> * Update copyright notice on RISC-V HTIF Console device
> * Change CPU Core and translator to GPLv2+
> * Change RISC-V Disassembler to GPLv2+
> * Change SiFive Test Finisher to GPLv2+
> * Change SiFive CLINT to GPLv2+
> * Change SiFive PRCI to GPLv2+
> * Change SiFive PLIC to GPLv2+
> * Change RISC-V spike machines to GPLv2+
> * Change RISC-V virt machine to GPLv2+
> * Change SiFive E300 machine to GPLv2+
> * Change SiFive U500 machine to GPLv2+
> * Change RISC-V Hart Array to GPLv2+
> * Change RISC-V HTIF device to GPLv2+
> * Change SiFiveUART device to GPLv2+
>
> v6
>
> * Drop IEEE 754-201x minimumNumber/maximumNumber for fmin/fmax
> * Remove some unnecessary commented debug statements
> * Change RISCV_CPU_TYPE_NAME to use riscv-cpu suffix
> * Define all CPU variants for linux-user
> * qemu_log calls require trailing \n
> * Replace PLIC printfs with qemu_log
> * Tear out unused HTIF code and eliminate shouting debug messages
> * Fix illegal instruction when sfence.vma is passed (rs2) arguments
> * Make updates to PTE accessed and dirty bits atomic
> * Only require atomic PTE updates on MTTCG enabled guests
> * Page fault if accessed or dirty bits can't be updated
> * Fix get_physical_address PTE reads and writes on riscv32
> * Remove erroneous comments from the PLIC
> * Default enable MTTCG
> * Make WFI less conservative
> * Unify local interrupt handling
> * Expunge HTIF interrupts
> * Always access mstatus.mip under a lock
> * Don't implement rdtime/rdtimeh in system mode (bbl emulates them)
> * Implement insreth/cycleh for rv32 and always enable user-mode counters
> * Add GDB stub support for reading and writing CSRs
> * Rename ENABLE_CHARDEV #ifdef from HTIF code
> * Replace bad HTIF ELF code with load_elf symbol callback
> * Convert chained if else fault handlers to switch statements
> * Use RISCV exception codes for linux-user page faults
>
> v5
>
> * Implement NaN-boxing for flw, set high order bits to 1
> * Use float_muladd_negate_* flags to floatXX_muladd
> * Use IEEE 754-201x minimumNumber/maximumNumber for fmin/fmax
> * Fix TARGET_NR_syscalls
> * Update linux-user/riscv/syscall_nr.h
> * Fix FENCE.I, needs to terminate translation block
> * Adjust unusual convention for interruptno >=3D 0
>
> v4
>
> * Add @riscv: since 2.12 to CpuInfoArch
> * Remove misleading little-endian comment from load_kernel
> * Rename cpu-model property to cpu-type
> * Drop some unnecessary inline function attributes
> * Don't allow GDB to set value of x0 register
> * Remove unnecessary empty property lists
> * Add Test Finisher device to implement poweroff in virt machine
> * Implement priv ISA v1.10 trap and sret/mret xPIE/xIE behavior
> * Store fflags data in fp_status
> * Purge runtime users of helper_raise_exception
> * Fix validate_csr
> * Tidy gen_jalr
> * Tidy immediate shifts
> * Add gen_exception_inst_addr_mis
> * Add gen_exception_debug
> * Add gen_exception_illegal
> * Tidy helper_fclass_*
> * Split rounding mode setting to a new function
> * Enforce MSTATUS_FS via TB flags
> * Implement acquire/release barrier semantics
> * Use atomic operations as required
> * Fix FENCE and FENCE_I
> * Remove commented code from spike machines
> * PAGE_WRITE permissions can be set on loads if page is already dirty
> * The result of format conversion on an NaN must be a quiet NaN
> * Add missing process_queued_cpu_work to riscv linux-user
> * Remove float(32|64)_classify from cpu.h
> * Removed nonsensical unions aliasing the same type
> * Use uintN_t instead of uintN_fast_t in fpu_helper.c
> * Use macros for FPU exception values in softfloat_flags_to_riscv
> * Move code to set round mode into set_fp_round_mode function
> * Convert set_fp_exceptions from a macro to an inline function
> * Convert round mode helper into an inline function
> * Make fpu_helper ieee_rm array static const
> * Include cpu_mmu_index in cpu_get_tb_cpu_state flags
> * Eliminate MPRV influence on mmu_index
> * Remove unrecoverable do_unassigned_access function
> * Only update PTE accessed and dirty bits if necessary
> * Remove unnecessary tlb_flush in set_mode as mode is in mmu_idx
> * Remove buggy support for misa writes. misa writes are optional
>   and are not implemented in any known hardware
> * Always set PTE read or execute permissions during page walk
> * Reorder helper function declarations to match order in helper.c
> * Remove redundant variable declaration in get_physical_address
> * Remove duplicated code from get_physical_address
> * Use mmu_idx instead of mem_idx in riscv_cpu_get_phys_page_debug
>
> v3
>
> * Fix indentation in PMP and HTIF debug macros
> * Fix disassembler checkpatch open brace '{' on next line errors
> * Fix trailing statements on next line in decode_inst_decompress
> * NOTE: the other checkpatch issues have been reviewed previously
>
> v2
>
> * Remove redundant NULL terminators from disassembler register arrays
> * Change disassembler register name arrays to const
> * Refine disassembler internal function names
> * Update dates in disassembler copyright message
> * Remove #ifdef CONFIG_USER_ONLY version of cpu_has_work
> * Use ULL suffix on 64-bit constants
> * Move riscv_cpu_mmu_index from cpu.h to helper.c
> * Move riscv_cpu_hw_interrupts_pending from cpu.h to helper.c
> * Remove redundant TARGET_HAS_ICE from cpu.h
> * Use qemu_irq instead of void* for irq definition in cpu.h
> * Remove duplicate typedef from struct CPURISCVState
> * Remove redundant g_strdup from cpu_register
> * Remove redundant tlb_flush from riscv_cpu_reset
> * Remove redundant mode calculation from get_physical_address
> * Remove redundant debug mode printf and dcsr comment
> * Remove redundant clearing of MSB for bare physical addresses
> * Use g_assert_not_reached for invalid mode in get_physical_address
> * Use g_assert_not_reached for unreachable checks in get_physical_address
> * Use g_assert_not_reached for unreachable type in raise_mmu_exception
> * Return exception instead of aborting for misaligned fetches
> * Move exception defines from cpu.h to cpu_bits.h
> * Remove redundant breakpoint control definitions from cpu_bits.h
> * Implement riscv_cpu_unassigned_access exception handling
> * Log and raise exceptions for unimplemented CSRs
> * Match Spike HTIF exit behavior - don=E2=80=99t print TEST-PASSED
> * Make frm,fflags,fcsr writes trap when mstatus.FS is clear
> * Use g_assert_not_reached for unreachable invalid mode
> * Make hret,uret,dret generate illegal instructions
> * Move riscv_cpu_dump_state and int/fpr regnames to cpu.c
> * Lift interrupt flag and mask into constants in cpu_bits.h
> * Change trap debugging to use qemu_log_mask LOG_TRACE
> * Change CSR debugging to use qemu_log_mask LOG_TRACE
> * Change PMP debugging to use qemu_log_mask LOG_TRACE
> * Remove commented code from pmp.c
> * Change CpuInfoRISCV qapi schema docs to Since 2.12
> * Change RV feature macro to use target_ulong cast
> * Remove riscv_feature and instead use misa extension flags
> * Make riscv_flush_icache_syscall a no-op
> * Undo checkpatch whitespace fixes in unrelated linux-user code
> * Remove redudant constants and tidy up cpu_bits.h
> * Make helper_fence_i a no-op
> * Move include "exec/cpu-all" to end of cpu.h
> * Rename set_privilege to riscv_set_mode
> * Move redundant forward declaration for cpu_riscv_translate_address
> * Remove TCGV_UNUSED from riscv_translate_init
> * Add comment to pmp.c stating the code is untested and currently unused
> * Use ctz to simplify decoding of PMP NAPOT address ranges
> * Change pmp_is_in_range to use than equal for end addresses
> * Fix off by one error in pmp_update_rule
> * Rearrange PMP_DEBUG so that formatting is compile-time checked
> * Rearrange trap debugging so that formatting is compile-time checked
> * Rearrange PLIC debugging so that formatting is compile-time checked
> * Use qemu_log/qemu_log_mask for HTIF logging and debugging
> * Move exception and interrupt names into cpu.c
> * Add Palmer Dabbelt as a RISC-V Maintainer
> * Rebase against current qemu master branch
>
> v1
>
> * initial version based on forward port from riscv-qemu repository
>
> *** Background ***
>
> "RISC-V is an open, free ISA enabling a new era of processor innovation
> through open standard collaboration. Born in academia and research,
> RISC-V ISA delivers a new level of free, extensible software and
> hardware freedom on architecture, paving the way for the next 50 years
> of computing design and innovation."
>
> The QEMU RISC-V port has been developed and maintained out-of-tree for
> several years by Sagar Karandikar and Bastian Koppelmann. The RISC-V
> Privileged specification has evolved substantially over this period but
> has recently been solidifying. The RISC-V Base ISA has been frozon for
> some time and the Privileged ISA, GCC toolchain and Linux ABI are now
> quite stable. I have recently joined Sagar and Bastian as a RISC-V QEMU
> Maintainer and hope to support upstreaming the port.
>
> There are multiple vendors taping out, preparing to ship, or shipping
> silicon that implements the RISC-V Privileged ISA Version 1.10. There
> are also several RISC-V Soft-IP cores implementing Privileged ISA
> Version 1.10 that run on FPGA such as SiFive's Freedom U500 Platform
> and the U54=E2=80=91MC RISC-V Core IP, among many more implementations fr=
om a
> variety of vendors. See https://riscv.org/ for more details.
>
> RISC-V support was upstreamed in binutils 2.28 and GCC 7.1 in the first
> half of 2016. RISC-V support is now available in LLVM top-of-tree and
> the RISC-V Linux port was accepted into Linux 4.15-rc1 late last year
> and is available in the Linux 4.15 release. GLIBC 2.27 added support
> for the RISC-V ISA running on Linux (requires at least binutils-2.30,
> gcc-7.3.0, and linux-4.15). We believe it is timely to submit the
> RISC-V QEMU port for upstream review with the goal of incorporating
> RISC-V support into the upcoming QEMU 2.12 release.
>
> The RISC-V QEMU port is still under active development, mostly with
> respect to device emulation, the addition of Hypervisor support as
> specified in the RISC-V Draft Privileged ISA Version 1.11, and Vector
> support once the first draft is finalized later this year. We believe
> now is the appropriate time for RISC-V QEMU development to be carried
> out in the main QEMU repository as the code will benefit from more
> rigorous review. The RISC-V QEMU port currently supports all the ISA
> extensions that have been finalized and frozen in the Base ISA.
>
> Blog post about recent additions to RISC-V QEMU: https://goo.gl/fJ4zgk
>
> The RISC-V QEMU wiki: https://github.com/riscv/riscv-qemu/wiki
>
> Instructions for building a busybox+dropbear root image, BBL (Berkeley
> Boot Loader) and linux kernel image for use with the RISC-V QEMU
> 'virt' machine: https://github.com/michaeljclark/busybear-linux
>
> *** Overview ***
>
> The RISC-V QEMU port implements the following specifications:
>
> * RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> * RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> * RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
>
> The RISC-V QEMU port supports the following instruction set extensions:
>
> * RV32GC with Supervisor-mode and User-mode (RV32IMAFDCSU)
> * RV64GC with Supervisor-mode and User-mode (RV64IMAFDCSU)
>
> The RISC-V QEMU port adds the following targets to QEMU:
>
> * riscv32-softmmu
> * riscv64-softmmu
> * riscv32-linux-user
> * riscv64-linux-user
>
> The RISC-V QEMU port supports the following hardware:
>
> * HTIF Console (Host Target Interface)
> * SiFive CLINT (Core Local Interruptor) for Timer interrupts and IPIs
> * SiFive PLIC (Platform Level Interrupt Controller)
> * SiFive Test (Test Finisher) for exiting simulation
> * SiFive UART, PRCI, AON, PWM, QSPI support is partially implemented
> * VirtIO MMIO (GPEX PCI support will be added in a future patch)
> * Generic 16550A UART emulation using 'hw/char/serial.c'
> * MTTCG and SMP support (PLIC and CLINT) on the 'virt' machine
>
> The RISC-V QEMU full system emulator supports 5 machines:
>
> * 'spike_v1.9.1', CLINT, PLIC, HTIF console, config-string, Priv v1.9.1
> * 'spike_v1.10', CLINT, PLIC, HTIF console, device-tree, Priv v1.10
> * 'sifive_e', CLINT, PLIC, SiFive UART, HiFive1 compat, Priv v1.10
> * 'sifive_u', CLINT, PLIC, SiFive UART, device-tree, Priv v1.10
> * 'virt', CLINT, PLIC, 16550A UART, VirtIO, device-tree, Priv v1.10
>
> This is a list of RISC-V QEMU Port Contributors:
>
> * Alex Suykov
> * Andreas Schwab
> * Antony Pavlov
> * Bastian Koppelmann
> * Bruce Hoult
> * Chih-Min Chao
> * Daire McNamara
> * Darius Rad
> * David Abdurachmanov
> * Hesham Almatary
> * Ivan Griffin
> * Jim Wilson
> * Kito Cheng
> * Michael Clark
> * Palmer Dabbelt
> * Richard Henderson
> * Sagar Karandikar
> * Shea Levy
> * Stefan O'Rear
>
> Notes:
>
> * contributor email addresses available off-list on request.
> * checkpatch has been run on all 23 patches.
> * checkpatch exceptions are noted in patches that have errors.
> * passes "make check" on full build for all targets
> * tested riscv-linux-4.6.2 on 'spike_v1.9.1' machine
> * tested riscv-linux-4.15 on 'spike_v1.10' and 'virt' machines
> * tested SiFive HiFive1 binaries in 'sifive_e' machine
> * tested RV64 on 32-bit i386
>
> This patch series includes the following patches:
>
> - ----------------------------------------------------------------
> Michael Clark (45):
>       RISC-V Maintainers
>       RISC-V ELF Machine Definition
>       RISC-V CPU Core Definition
>       RISC-V Disassembler
>       RISC-V CPU Helpers
>       RISC-V FPU Support
>       RISC-V GDB Stub
>       RISC-V TCG Code Generation
>       RISC-V Physical Memory Protection
>       RISC-V Linux User Emulation
>       Add symbol table callback interface to load_elf
>       RISC-V HTIF Console
>       RISC-V HART Array
>       SiFive RISC-V CLINT Block
>       SiFive RISC-V PLIC Block
>       RISC-V Spike Machines
>       SiFive RISC-V Test Finisher
>       RISC-V VirtIO Machine
>       SiFive RISC-V UART Device
>       SiFive RISC-V PRCI Block
>       SiFive Freedom E Series RISC-V Machine
>       SiFive Freedom U Series RISC-V Machine
>       RISC-V Build Infrastructure
>       RISC-V - Make virt create_fdt interface consistent with other board=
s
>       RISC-V - Replace hardcoded device-tree constants with enum values
>       RISC-V - Make virt board description match spike format
>       RISC-V - Use ROM base address and size constants from memory map
>       RISC-V - Remove redundant identity_translate callback from load_elf
>       RISC-V - Mark ROM read-only after copying in reset vector and confi=
g
>       RISC-V - Remove unused class definitions from machines
>       RISC-V - Make sure the emulated mask rom has space for device-tree
>       RISC-V - Include hexidecimal instruction packets in disassembly
>       RISC-V - Need to hold rcu_read_lock when accessing memory directly
>       RISC-V - Improve page table walker spec compliance and add comments
>       RISC-V - Update E order and note that add E and I are mutually
> exclusive
>       RISC-V - Make spike and virt header guards more specific
>       RISC-V - Make virt header comment consistent with source file
>       RISC-V - Use memory_region_is_ram in atomic pte update
>       RISC-V - Remove EM_RISCV ELF_MACHINE indirection from load_elf
>       RISC-V - Ingore satp writes and return 0 for reads when no-mmu
>       RISC-V - Remove braces from satp case statement with no locals
>       RISC-V - riscv-qemu port supports sv39 and sv48
>       RISC-V - vectored traps for asynchrounous interrupts are optional
>       RISC-V - Dont' trap on writes to misa,minstret[h],mcycle[h]
>       RISC-V - Remove support for adhoc non-standard X_COP local-interrup=
t
>
>  MAINTAINERS                            |   11 +
>  arch_init.c                            |    2 +
>  configure                              |   13 +
>  cpus.c                                 |    6 +
>  default-configs/riscv32-linux-user.mak |    1 +
>  default-configs/riscv32-softmmu.mak    |    4 +
>  default-configs/riscv64-linux-user.mak |    1 +
>  default-configs/riscv64-softmmu.mak    |    4 +
>  disas.c                                |    2 +
>  disas/Makefile.objs                    |    1 +
>  disas/riscv.c                          | 3049
> ++++++++++++++++++++++++++++++++
>  fpu/softfloat-specialize.h             |    7 +-
>  hw/core/loader.c                       |   18 +-
>  hw/riscv/Makefile.objs                 |   11 +
>  hw/riscv/riscv_hart.c                  |   89 +
>  hw/riscv/riscv_htif.c                  |  258 +++
>  hw/riscv/sifive_clint.c                |  251 +++
>  hw/riscv/sifive_e.c                    |  204 +++
>  hw/riscv/sifive_plic.c                 |  505 ++++++
>  hw/riscv/sifive_prci.c                 |   89 +
>  hw/riscv/sifive_test.c                 |   93 +
>  hw/riscv/sifive_u.c                    |  316 ++++
>  hw/riscv/sifive_uart.c                 |  176 ++
>  hw/riscv/spike.c                       |  361 ++++
>  hw/riscv/virt.c                        |  395 +++++
>  include/disas/bfd.h                    |    2 +
>  include/elf.h                          |    2 +
>  include/hw/elf_ops.h                   |   34 +-
>  include/hw/loader.h                    |   17 +-
>  include/hw/riscv/riscv_hart.h          |   39 +
>  include/hw/riscv/riscv_htif.h          |   61 +
>  include/hw/riscv/sifive_clint.h        |   54 +
>  include/hw/riscv/sifive_e.h            |   70 +
>  include/hw/riscv/sifive_plic.h         |   85 +
>  include/hw/riscv/sifive_prci.h         |   37 +
>  include/hw/riscv/sifive_test.h         |   42 +
>  include/hw/riscv/sifive_u.h            |   64 +
>  include/hw/riscv/sifive_uart.h         |   71 +
>  include/hw/riscv/spike.h               |   49 +
>  include/hw/riscv/virt.h                |   67 +
>  include/sysemu/arch_init.h             |    1 +
>  linux-user/elfload.c                   |   22 +
>  linux-user/main.c                      |   99 ++
>  linux-user/riscv/syscall_nr.h          |  287 +++
>  linux-user/riscv/target_cpu.h          |   18 +
>  linux-user/riscv/target_elf.h          |   14 +
>  linux-user/riscv/target_signal.h       |   23 +
>  linux-user/riscv/target_structs.h      |   46 +
>  linux-user/riscv/target_syscall.h      |   56 +
>  linux-user/riscv/termbits.h            |  222 +++
>  linux-user/signal.c                    |  203 ++-
>  linux-user/syscall.c                   |    2 +
>  linux-user/syscall_defs.h              |   13 +-
>  qapi/misc.json                         |   17 +-
>  scripts/qemu-binfmt-conf.sh            |   13 +-
>  target/riscv/Makefile.objs             |    1 +
>  target/riscv/cpu.c                     |  432 +++++
>  target/riscv/cpu.h                     |  296 ++++
>  target/riscv/cpu_bits.h                |  408 +++++
>  target/riscv/cpu_user.h                |   13 +
>  target/riscv/fpu_helper.c              |  373 ++++
>  target/riscv/gdbstub.c                 |   62 +
>  target/riscv/helper.c                  |  530 ++++++
>  target/riscv/helper.h                  |   78 +
>  target/riscv/instmap.h                 |  364 ++++
>  target/riscv/op_helper.c               |  669 +++++++
>  target/riscv/pmp.c                     |  380 ++++
>  target/riscv/pmp.h                     |   64 +
>  target/riscv/translate.c               | 1978 +++++++++++++++++++++
>  69 files changed, 13218 insertions(+), 27 deletions(-)
>  create mode 100644 default-configs/riscv32-linux-user.mak
>  create mode 100644 default-configs/riscv32-softmmu.mak
>  create mode 100644 default-configs/riscv64-linux-user.mak
>  create mode 100644 default-configs/riscv64-softmmu.mak
>  create mode 100644 disas/riscv.c
>  create mode 100644 hw/riscv/Makefile.objs
>  create mode 100644 hw/riscv/riscv_hart.c
>  create mode 100644 hw/riscv/riscv_htif.c
>  create mode 100644 hw/riscv/sifive_clint.c
>  create mode 100644 hw/riscv/sifive_e.c
>  create mode 100644 hw/riscv/sifive_plic.c
>  create mode 100644 hw/riscv/sifive_prci.c
>  create mode 100644 hw/riscv/sifive_test.c
>  create mode 100644 hw/riscv/sifive_u.c
>  create mode 100644 hw/riscv/sifive_uart.c
>  create mode 100644 hw/riscv/spike.c
>  create mode 100644 hw/riscv/virt.c
>  create mode 100644 include/hw/riscv/riscv_hart.h
>  create mode 100644 include/hw/riscv/riscv_htif.h
>  create mode 100644 include/hw/riscv/sifive_clint.h
>  create mode 100644 include/hw/riscv/sifive_e.h
>  create mode 100644 include/hw/riscv/sifive_plic.h
>  create mode 100644 include/hw/riscv/sifive_prci.h
>  create mode 100644 include/hw/riscv/sifive_test.h
>  create mode 100644 include/hw/riscv/sifive_u.h
>  create mode 100644 include/hw/riscv/sifive_uart.h
>  create mode 100644 include/hw/riscv/spike.h
>  create mode 100644 include/hw/riscv/virt.h
>  create mode 100644 linux-user/riscv/syscall_nr.h
>  create mode 100644 linux-user/riscv/target_cpu.h
>  create mode 100644 linux-user/riscv/target_elf.h
>  create mode 100644 linux-user/riscv/target_signal.h
>  create mode 100644 linux-user/riscv/target_structs.h
>  create mode 100644 linux-user/riscv/target_syscall.h
>  create mode 100644 linux-user/riscv/termbits.h
>  create mode 100644 target/riscv/Makefile.objs
>  create mode 100644 target/riscv/cpu.c
>  create mode 100644 target/riscv/cpu.h
>  create mode 100644 target/riscv/cpu_bits.h
>  create mode 100644 target/riscv/cpu_user.h
>  create mode 100644 target/riscv/fpu_helper.c
>  create mode 100644 target/riscv/gdbstub.c
>  create mode 100644 target/riscv/helper.c
>  create mode 100644 target/riscv/helper.h
>  create mode 100644 target/riscv/instmap.h
>  create mode 100644 target/riscv/op_helper.c
>  create mode 100644 target/riscv/pmp.c
>  create mode 100644 target/riscv/pmp.h
>  create mode 100644 target/riscv/translate.c
> -----BEGIN PGP SIGNATURE-----
>
> iF0EARECAB0WIQR8mZMOsXzYugc9Xvpr8dezV+8+TwUCWp7voQAKCRBr8dezV+8+
> T3oeAKCjyrpCLo7ClB7epIA7vebNScpy7wCgjGjRt783KuDB0bpivU0aOnuqL3g=3D
> =3DneBa
> -----END PGP SIGNATURE-----
>
