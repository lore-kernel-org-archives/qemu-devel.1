Received: from eggs.gnu.org ([2001:4830:134:3::10]:41128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCHm-0003PQ-7w
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCHe-0003oy-LO
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:18:30 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCHe-0003ok-6C
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:18:22 -0400
Received: by mail-qk0-x241.google.com with SMTP id s9so11447154qke.12
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 19:18:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180322215833.7713-1-laurent@vivier.eu>
	<20180322215833.7713-6-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18f68fa1-3ee3-b5cc-5036-2c5155178750@amsat.org>
Date: Thu, 22 Mar 2018 23:18:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180322215833.7713-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 5/5] linux-user: cleanup main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 03/22/2018 06:58 PM, Laurent Vivier wrote:
> move all prologue specific parts to
> prologue.inc.c in arch directory
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/aarch64/prologue.inc.c    |  21 ++
>  linux-user/alpha/prologue.inc.c      |   9 +
>  linux-user/arm/prologue.inc.c        |  23 ++
>  linux-user/cris/prologue.inc.c       |  19 ++
>  linux-user/hppa/prologue.inc.c       |   8 +
>  linux-user/i386/prologue.inc.c       | 113 ++++++++++
>  linux-user/m68k/prologue.inc.c       |  26 +++
>  linux-user/main.c                    | 400 +----------------------------------
>  linux-user/microblaze/prologue.inc.c |  35 +++
>  linux-user/mips/prologue.inc.c       |  25 +++
>  linux-user/mips64/prologue.inc.c     |   1 +
>  linux-user/nios2/prologue.inc.c      |  29 +++
>  linux-user/openrisc/prologue.inc.c   |   9 +
>  linux-user/ppc/prologue.inc.c        |  16 ++
>  linux-user/riscv/prologue.inc.c      |   4 +
>  linux-user/s390x/prologue.inc.c      |   8 +
>  linux-user/sh4/prologue.inc.c        |   8 +
>  linux-user/sparc/prologue.inc.c      |  10 +
>  linux-user/sparc64/prologue.inc.c    |   1 +
>  linux-user/tilegx/prologue.inc.c     |  10 +
>  linux-user/x86_64/prologue.inc.c     |   1 +
>  linux-user/xtensa/prologue.inc.c     |   8 +
>  22 files changed, 385 insertions(+), 399 deletions(-)
>  create mode 100644 linux-user/aarch64/prologue.inc.c
>  create mode 100644 linux-user/alpha/prologue.inc.c
>  create mode 100644 linux-user/arm/prologue.inc.c
>  create mode 100644 linux-user/cris/prologue.inc.c
>  create mode 100644 linux-user/hppa/prologue.inc.c
>  create mode 100644 linux-user/i386/prologue.inc.c
>  create mode 100644 linux-user/m68k/prologue.inc.c
>  create mode 100644 linux-user/microblaze/prologue.inc.c
>  create mode 100644 linux-user/mips/prologue.inc.c
>  create mode 100644 linux-user/mips64/prologue.inc.c
>  create mode 100644 linux-user/nios2/prologue.inc.c
>  create mode 100644 linux-user/openrisc/prologue.inc.c
>  create mode 100644 linux-user/ppc/prologue.inc.c
>  create mode 100644 linux-user/riscv/prologue.inc.c
>  create mode 100644 linux-user/s390x/prologue.inc.c
>  create mode 100644 linux-user/sh4/prologue.inc.c
>  create mode 100644 linux-user/sparc/prologue.inc.c
>  create mode 100644 linux-user/sparc64/prologue.inc.c
>  create mode 100644 linux-user/tilegx/prologue.inc.c
>  create mode 100644 linux-user/x86_64/prologue.inc.c
>  create mode 100644 linux-user/xtensa/prologue.inc.c
> 
> diff --git a/linux-user/aarch64/prologue.inc.c b/linux-user/aarch64/prologue.inc.c
> new file mode 100644
> index 0000000000..5ffb50ae84
> --- /dev/null
> +++ b/linux-user/aarch64/prologue.inc.c
> @@ -0,0 +1,21 @@
> +    {
> +        int i;
> +
> +        if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
> +            fprintf(stderr,
> +                    "The selected ARM CPU does not support 64 bit mode\n");
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        for (i = 0; i < 31; i++) {
> +            env->xregs[i] = regs->regs[i];
> +        }
> +        env->pc = regs->pc;
> +        env->xregs[31] = regs->sp;
> +#ifdef TARGET_WORDS_BIGENDIAN
> +        env->cp15.sctlr_el[1] |= SCTLR_E0E;
> +        for (i = 1; i < 4; ++i) {
> +            env->cp15.sctlr_el[i] |= SCTLR_EE;
> +        }
> +#endif
> +    }
> diff --git a/linux-user/alpha/prologue.inc.c b/linux-user/alpha/prologue.inc.c
> new file mode 100644
> index 0000000000..e7a34c38cd
> --- /dev/null
> +++ b/linux-user/alpha/prologue.inc.c
> @@ -0,0 +1,9 @@
> +    {
> +        int i;
> +
> +        for(i = 0; i < 28; i++) {
> +            env->ir[i] = ((abi_ulong *)regs)[i];
> +        }
> +        env->ir[IR_SP] = regs->usp;
> +        env->pc = regs->pc;
> +    }
> diff --git a/linux-user/arm/prologue.inc.c b/linux-user/arm/prologue.inc.c
> new file mode 100644
> index 0000000000..712f34fb4d
> --- /dev/null
> +++ b/linux-user/arm/prologue.inc.c
> @@ -0,0 +1,23 @@
> +    {
> +        int i;
> +        cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
> +                   CPSRWriteByInstr);
> +        for(i = 0; i < 16; i++) {
> +            env->regs[i] = regs->uregs[i];
> +        }
> +#ifdef TARGET_WORDS_BIGENDIAN
> +        /* Enable BE8.  */
> +        if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
> +            && (info->elf_flags & EF_ARM_BE8)) {
> +            env->uncached_cpsr |= CPSR_E;
> +            env->cp15.sctlr_el[1] |= SCTLR_E0E;
> +        } else {
> +            env->cp15.sctlr_el[1] |= SCTLR_B;
> +        }
> +#endif
> +    }
> +
> +    ts->stack_base = info->start_stack;
> +    ts->heap_base = info->brk;
> +    /* This will be filled in on the first SYS_HEAPINFO call.  */
> +    ts->heap_limit = 0;
> diff --git a/linux-user/cris/prologue.inc.c b/linux-user/cris/prologue.inc.c
> new file mode 100644
> index 0000000000..9bc35d0825
> --- /dev/null
> +++ b/linux-user/cris/prologue.inc.c
> @@ -0,0 +1,19 @@
> +    {
> +	    env->regs[0] = regs->r0;
> +	    env->regs[1] = regs->r1;
> +	    env->regs[2] = regs->r2;
> +	    env->regs[3] = regs->r3;
> +	    env->regs[4] = regs->r4;
> +	    env->regs[5] = regs->r5;
> +	    env->regs[6] = regs->r6;
> +	    env->regs[7] = regs->r7;
> +	    env->regs[8] = regs->r8;
> +	    env->regs[9] = regs->r9;
> +	    env->regs[10] = regs->r10;
> +	    env->regs[11] = regs->r11;
> +	    env->regs[12] = regs->r12;
> +	    env->regs[13] = regs->r13;
> +	    env->regs[14] = info->start_stack;
> +	    env->regs[15] = regs->acr;
> +	    env->pc = regs->erp;
> +    }
> diff --git a/linux-user/hppa/prologue.inc.c b/linux-user/hppa/prologue.inc.c
> new file mode 100644
> index 0000000000..922de62eac
> --- /dev/null
> +++ b/linux-user/hppa/prologue.inc.c
> @@ -0,0 +1,8 @@
> +    {
> +        int i;
> +        for (i = 1; i < 32; i++) {
> +            env->gr[i] = regs->gr[i];
> +        }
> +        env->iaoq_f = regs->iaoq[0];
> +        env->iaoq_b = regs->iaoq[1];
> +    }
> diff --git a/linux-user/i386/prologue.inc.c b/linux-user/i386/prologue.inc.c
> new file mode 100644
> index 0000000000..3a40a0a2e8
> --- /dev/null
> +++ b/linux-user/i386/prologue.inc.c
> @@ -0,0 +1,113 @@
> +    env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
> +    env->hflags |= HF_PE_MASK | HF_CPL_MASK;
> +    if (env->features[FEAT_1_EDX] & CPUID_SSE) {
> +        env->cr[4] |= CR4_OSFXSR_MASK;
> +        env->hflags |= HF_OSFXSR_MASK;
> +    }
> +#ifndef TARGET_ABI32
> +    /* enable 64 bit mode if possible */
> +    if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> +        fprintf(stderr, "The selected x86 CPU does not support 64 bit mode\n");
> +        exit(EXIT_FAILURE);
> +    }
> +    env->cr[4] |= CR4_PAE_MASK;
> +    env->efer |= MSR_EFER_LMA | MSR_EFER_LME;
> +    env->hflags |= HF_LMA_MASK;
> +#endif
> +
> +    /* flags setup : we activate the IRQs by default as in user mode */
> +    env->eflags |= IF_MASK;
> +
> +    /* linux register setup */
> +#ifndef TARGET_ABI32
> +    env->regs[R_EAX] = regs->rax;
> +    env->regs[R_EBX] = regs->rbx;
> +    env->regs[R_ECX] = regs->rcx;
> +    env->regs[R_EDX] = regs->rdx;
> +    env->regs[R_ESI] = regs->rsi;
> +    env->regs[R_EDI] = regs->rdi;
> +    env->regs[R_EBP] = regs->rbp;
> +    env->regs[R_ESP] = regs->rsp;
> +    env->eip = regs->rip;
> +#else
> +    env->regs[R_EAX] = regs->eax;
> +    env->regs[R_EBX] = regs->ebx;
> +    env->regs[R_ECX] = regs->ecx;
> +    env->regs[R_EDX] = regs->edx;
> +    env->regs[R_ESI] = regs->esi;
> +    env->regs[R_EDI] = regs->edi;
> +    env->regs[R_EBP] = regs->ebp;
> +    env->regs[R_ESP] = regs->esp;
> +    env->eip = regs->eip;
> +#endif
> +
> +    /* linux interrupt setup */
> +#ifndef TARGET_ABI32
> +    env->idt.limit = 511;
> +#else
> +    env->idt.limit = 255;
> +#endif
> +    env->idt.base = target_mmap(0, sizeof(uint64_t) * (env->idt.limit + 1),
> +                                PROT_READ|PROT_WRITE,
> +                                MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +    idt_table = g2h(env->idt.base);
> +    set_idt(0, 0);
> +    set_idt(1, 0);
> +    set_idt(2, 0);
> +    set_idt(3, 3);
> +    set_idt(4, 3);
> +    set_idt(5, 0);
> +    set_idt(6, 0);
> +    set_idt(7, 0);
> +    set_idt(8, 0);
> +    set_idt(9, 0);
> +    set_idt(10, 0);
> +    set_idt(11, 0);
> +    set_idt(12, 0);
> +    set_idt(13, 0);
> +    set_idt(14, 0);
> +    set_idt(15, 0);
> +    set_idt(16, 0);
> +    set_idt(17, 0);
> +    set_idt(18, 0);
> +    set_idt(19, 0);
> +    set_idt(0x80, 3);
> +
> +    /* linux segment setup */
> +    {
> +        uint64_t *gdt_table;
> +        env->gdt.base = target_mmap(0, sizeof(uint64_t) * TARGET_GDT_ENTRIES,
> +                                    PROT_READ|PROT_WRITE,
> +                                    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +        env->gdt.limit = sizeof(uint64_t) * TARGET_GDT_ENTRIES - 1;
> +        gdt_table = g2h(env->gdt.base);
> +#ifdef TARGET_ABI32
> +        write_dt(&gdt_table[__USER_CS >> 3], 0, 0xfffff,
> +                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK | DESC_S_MASK |
> +                 (3 << DESC_DPL_SHIFT) | (0xa << DESC_TYPE_SHIFT));
> +#else
> +        /* 64 bit code segment */
> +        write_dt(&gdt_table[__USER_CS >> 3], 0, 0xfffff,
> +                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK | DESC_S_MASK |
> +                 DESC_L_MASK |
> +                 (3 << DESC_DPL_SHIFT) | (0xa << DESC_TYPE_SHIFT));
> +#endif
> +        write_dt(&gdt_table[__USER_DS >> 3], 0, 0xfffff,
> +                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK | DESC_S_MASK |
> +                 (3 << DESC_DPL_SHIFT) | (0x2 << DESC_TYPE_SHIFT));
> +    }
> +    cpu_x86_load_seg(env, R_CS, __USER_CS);
> +    cpu_x86_load_seg(env, R_SS, __USER_DS);
> +#ifdef TARGET_ABI32
> +    cpu_x86_load_seg(env, R_DS, __USER_DS);
> +    cpu_x86_load_seg(env, R_ES, __USER_DS);
> +    cpu_x86_load_seg(env, R_FS, __USER_DS);
> +    cpu_x86_load_seg(env, R_GS, __USER_DS);
> +    /* This hack makes Wine work... */
> +    env->segs[R_FS].selector = 0;
> +#else
> +    cpu_x86_load_seg(env, R_DS, 0);
> +    cpu_x86_load_seg(env, R_ES, 0);
> +    cpu_x86_load_seg(env, R_FS, 0);
> +    cpu_x86_load_seg(env, R_GS, 0);
> +#endif
> diff --git a/linux-user/m68k/prologue.inc.c b/linux-user/m68k/prologue.inc.c
> new file mode 100644
> index 0000000000..b9bd66cd7a
> --- /dev/null
> +++ b/linux-user/m68k/prologue.inc.c
> @@ -0,0 +1,26 @@
> +    {
> +        env->pc = regs->pc;
> +        env->dregs[0] = regs->d0;
> +        env->dregs[1] = regs->d1;
> +        env->dregs[2] = regs->d2;
> +        env->dregs[3] = regs->d3;
> +        env->dregs[4] = regs->d4;
> +        env->dregs[5] = regs->d5;
> +        env->dregs[6] = regs->d6;
> +        env->dregs[7] = regs->d7;
> +        env->aregs[0] = regs->a0;
> +        env->aregs[1] = regs->a1;
> +        env->aregs[2] = regs->a2;
> +        env->aregs[3] = regs->a3;
> +        env->aregs[4] = regs->a4;
> +        env->aregs[5] = regs->a5;
> +        env->aregs[6] = regs->a6;
> +        env->aregs[7] = regs->usp;
> +        env->sr = regs->sr;
> +        ts->sim_syscalls = 1;
> +    }
> +
> +    ts->stack_base = info->start_stack;
> +    ts->heap_base = info->brk;
> +    /* This will be filled in on the first SYS_HEAPINFO call.  */
> +    ts->heap_limit = 0;
> diff --git a/linux-user/main.c b/linux-user/main.c
> index fd71113855..c2a5813694 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -817,405 +817,7 @@ int main(int argc, char **argv, char **envp)
>      tcg_prologue_init(tcg_ctx);
>      tcg_region_init();
>  
> -#if defined(TARGET_I386)
> -    env->cr[0] = CR0_PG_MASK | CR0_WP_MASK | CR0_PE_MASK;
> -    env->hflags |= HF_PE_MASK | HF_CPL_MASK;
> -    if (env->features[FEAT_1_EDX] & CPUID_SSE) {
> -        env->cr[4] |= CR4_OSFXSR_MASK;
> -        env->hflags |= HF_OSFXSR_MASK;
> -    }
> -#ifndef TARGET_ABI32
> -    /* enable 64 bit mode if possible */
> -    if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
> -        fprintf(stderr, "The selected x86 CPU does not support 64 bit mode\n");
> -        exit(EXIT_FAILURE);
> -    }
> -    env->cr[4] |= CR4_PAE_MASK;
> -    env->efer |= MSR_EFER_LMA | MSR_EFER_LME;
> -    env->hflags |= HF_LMA_MASK;
> -#endif
> -
> -    /* flags setup : we activate the IRQs by default as in user mode */
> -    env->eflags |= IF_MASK;
> -
> -    /* linux register setup */
> -#ifndef TARGET_ABI32
> -    env->regs[R_EAX] = regs->rax;
> -    env->regs[R_EBX] = regs->rbx;
> -    env->regs[R_ECX] = regs->rcx;
> -    env->regs[R_EDX] = regs->rdx;
> -    env->regs[R_ESI] = regs->rsi;
> -    env->regs[R_EDI] = regs->rdi;
> -    env->regs[R_EBP] = regs->rbp;
> -    env->regs[R_ESP] = regs->rsp;
> -    env->eip = regs->rip;
> -#else
> -    env->regs[R_EAX] = regs->eax;
> -    env->regs[R_EBX] = regs->ebx;
> -    env->regs[R_ECX] = regs->ecx;
> -    env->regs[R_EDX] = regs->edx;
> -    env->regs[R_ESI] = regs->esi;
> -    env->regs[R_EDI] = regs->edi;
> -    env->regs[R_EBP] = regs->ebp;
> -    env->regs[R_ESP] = regs->esp;
> -    env->eip = regs->eip;
> -#endif
> -
> -    /* linux interrupt setup */
> -#ifndef TARGET_ABI32
> -    env->idt.limit = 511;
> -#else
> -    env->idt.limit = 255;
> -#endif
> -    env->idt.base = target_mmap(0, sizeof(uint64_t) * (env->idt.limit + 1),
> -                                PROT_READ|PROT_WRITE,
> -                                MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> -    idt_table = g2h(env->idt.base);
> -    set_idt(0, 0);
> -    set_idt(1, 0);
> -    set_idt(2, 0);
> -    set_idt(3, 3);
> -    set_idt(4, 3);
> -    set_idt(5, 0);
> -    set_idt(6, 0);
> -    set_idt(7, 0);
> -    set_idt(8, 0);
> -    set_idt(9, 0);
> -    set_idt(10, 0);
> -    set_idt(11, 0);
> -    set_idt(12, 0);
> -    set_idt(13, 0);
> -    set_idt(14, 0);
> -    set_idt(15, 0);
> -    set_idt(16, 0);
> -    set_idt(17, 0);
> -    set_idt(18, 0);
> -    set_idt(19, 0);
> -    set_idt(0x80, 3);
> -
> -    /* linux segment setup */
> -    {
> -        uint64_t *gdt_table;
> -        env->gdt.base = target_mmap(0, sizeof(uint64_t) * TARGET_GDT_ENTRIES,
> -                                    PROT_READ|PROT_WRITE,
> -                                    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> -        env->gdt.limit = sizeof(uint64_t) * TARGET_GDT_ENTRIES - 1;
> -        gdt_table = g2h(env->gdt.base);
> -#ifdef TARGET_ABI32
> -        write_dt(&gdt_table[__USER_CS >> 3], 0, 0xfffff,
> -                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK | DESC_S_MASK |
> -                 (3 << DESC_DPL_SHIFT) | (0xa << DESC_TYPE_SHIFT));
> -#else
> -        /* 64 bit code segment */
> -        write_dt(&gdt_table[__USER_CS >> 3], 0, 0xfffff,
> -                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK | DESC_S_MASK |
> -                 DESC_L_MASK |
> -                 (3 << DESC_DPL_SHIFT) | (0xa << DESC_TYPE_SHIFT));
> -#endif
> -        write_dt(&gdt_table[__USER_DS >> 3], 0, 0xfffff,
> -                 DESC_G_MASK | DESC_B_MASK | DESC_P_MASK | DESC_S_MASK |
> -                 (3 << DESC_DPL_SHIFT) | (0x2 << DESC_TYPE_SHIFT));
> -    }
> -    cpu_x86_load_seg(env, R_CS, __USER_CS);
> -    cpu_x86_load_seg(env, R_SS, __USER_DS);
> -#ifdef TARGET_ABI32
> -    cpu_x86_load_seg(env, R_DS, __USER_DS);
> -    cpu_x86_load_seg(env, R_ES, __USER_DS);
> -    cpu_x86_load_seg(env, R_FS, __USER_DS);
> -    cpu_x86_load_seg(env, R_GS, __USER_DS);
> -    /* This hack makes Wine work... */
> -    env->segs[R_FS].selector = 0;
> -#else
> -    cpu_x86_load_seg(env, R_DS, 0);
> -    cpu_x86_load_seg(env, R_ES, 0);
> -    cpu_x86_load_seg(env, R_FS, 0);
> -    cpu_x86_load_seg(env, R_GS, 0);
> -#endif
> -#elif defined(TARGET_AARCH64)
> -    {
> -        int i;
> -
> -        if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
> -            fprintf(stderr,
> -                    "The selected ARM CPU does not support 64 bit mode\n");
> -            exit(EXIT_FAILURE);
> -        }
> -
> -        for (i = 0; i < 31; i++) {
> -            env->xregs[i] = regs->regs[i];
> -        }
> -        env->pc = regs->pc;
> -        env->xregs[31] = regs->sp;
> -#ifdef TARGET_WORDS_BIGENDIAN
> -        env->cp15.sctlr_el[1] |= SCTLR_E0E;
> -        for (i = 1; i < 4; ++i) {
> -            env->cp15.sctlr_el[i] |= SCTLR_EE;
> -        }
> -#endif
> -    }
> -#elif defined(TARGET_ARM)
> -    {
> -        int i;
> -        cpsr_write(env, regs->uregs[16], CPSR_USER | CPSR_EXEC,
> -                   CPSRWriteByInstr);
> -        for(i = 0; i < 16; i++) {
> -            env->regs[i] = regs->uregs[i];
> -        }
> -#ifdef TARGET_WORDS_BIGENDIAN
> -        /* Enable BE8.  */
> -        if (EF_ARM_EABI_VERSION(info->elf_flags) >= EF_ARM_EABI_VER4
> -            && (info->elf_flags & EF_ARM_BE8)) {
> -            env->uncached_cpsr |= CPSR_E;
> -            env->cp15.sctlr_el[1] |= SCTLR_E0E;
> -        } else {
> -            env->cp15.sctlr_el[1] |= SCTLR_B;
> -        }
> -#endif
> -    }
> -#elif defined(TARGET_SPARC)
> -    {
> -        int i;
> -	env->pc = regs->pc;
> -	env->npc = regs->npc;
> -        env->y = regs->y;
> -        for(i = 0; i < 8; i++)
> -            env->gregs[i] = regs->u_regs[i];
> -        for(i = 0; i < 8; i++)
> -            env->regwptr[i] = regs->u_regs[i + 8];
> -    }
> -#elif defined(TARGET_PPC)
> -    {
> -        int i;
> -
> -#if defined(TARGET_PPC64)
> -        int flag = (env->insns_flags2 & PPC2_BOOKE206) ? MSR_CM : MSR_SF;
> -#if defined(TARGET_ABI32)
> -        env->msr &= ~((target_ulong)1 << flag);
> -#else
> -        env->msr |= (target_ulong)1 << flag;
> -#endif
> -#endif
> -        env->nip = regs->nip;
> -        for(i = 0; i < 32; i++) {
> -            env->gpr[i] = regs->gpr[i];
> -        }
> -    }
> -#elif defined(TARGET_M68K)
> -    {
> -        env->pc = regs->pc;
> -        env->dregs[0] = regs->d0;
> -        env->dregs[1] = regs->d1;
> -        env->dregs[2] = regs->d2;
> -        env->dregs[3] = regs->d3;
> -        env->dregs[4] = regs->d4;
> -        env->dregs[5] = regs->d5;
> -        env->dregs[6] = regs->d6;
> -        env->dregs[7] = regs->d7;
> -        env->aregs[0] = regs->a0;
> -        env->aregs[1] = regs->a1;
> -        env->aregs[2] = regs->a2;
> -        env->aregs[3] = regs->a3;
> -        env->aregs[4] = regs->a4;
> -        env->aregs[5] = regs->a5;
> -        env->aregs[6] = regs->a6;
> -        env->aregs[7] = regs->usp;
> -        env->sr = regs->sr;
> -        ts->sim_syscalls = 1;
> -    }
> -#elif defined(TARGET_MICROBLAZE)
> -    {
> -        env->regs[0] = regs->r0;
> -        env->regs[1] = regs->r1;
> -        env->regs[2] = regs->r2;
> -        env->regs[3] = regs->r3;
> -        env->regs[4] = regs->r4;
> -        env->regs[5] = regs->r5;
> -        env->regs[6] = regs->r6;
> -        env->regs[7] = regs->r7;
> -        env->regs[8] = regs->r8;
> -        env->regs[9] = regs->r9;
> -        env->regs[10] = regs->r10;
> -        env->regs[11] = regs->r11;
> -        env->regs[12] = regs->r12;
> -        env->regs[13] = regs->r13;
> -        env->regs[14] = regs->r14;
> -        env->regs[15] = regs->r15;	    
> -        env->regs[16] = regs->r16;	    
> -        env->regs[17] = regs->r17;	    
> -        env->regs[18] = regs->r18;	    
> -        env->regs[19] = regs->r19;	    
> -        env->regs[20] = regs->r20;	    
> -        env->regs[21] = regs->r21;	    
> -        env->regs[22] = regs->r22;	    
> -        env->regs[23] = regs->r23;	    
> -        env->regs[24] = regs->r24;	    
> -        env->regs[25] = regs->r25;	    
> -        env->regs[26] = regs->r26;	    
> -        env->regs[27] = regs->r27;	    
> -        env->regs[28] = regs->r28;	    
> -        env->regs[29] = regs->r29;	    
> -        env->regs[30] = regs->r30;	    
> -        env->regs[31] = regs->r31;	    
> -        env->sregs[SR_PC] = regs->pc;
> -    }
> -#elif defined(TARGET_MIPS)
> -    {
> -        int i;
> -
> -        for(i = 0; i < 32; i++) {
> -            env->active_tc.gpr[i] = regs->regs[i];
> -        }
> -        env->active_tc.PC = regs->cp0_epc & ~(target_ulong)1;
> -        if (regs->cp0_epc & 1) {
> -            env->hflags |= MIPS_HFLAG_M16;
> -        }
> -        if (((info->elf_flags & EF_MIPS_NAN2008) != 0) !=
> -            ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) != 0)) {
> -            if ((env->active_fpu.fcr31_rw_bitmask &
> -                  (1 << FCR31_NAN2008)) == 0) {
> -                fprintf(stderr, "ELF binary's NaN mode not supported by CPU\n");
> -                exit(1);
> -            }
> -            if ((info->elf_flags & EF_MIPS_NAN2008) != 0) {
> -                env->active_fpu.fcr31 |= (1 << FCR31_NAN2008);
> -            } else {
> -                env->active_fpu.fcr31 &= ~(1 << FCR31_NAN2008);
> -            }
> -            restore_snan_bit_mode(env);
> -        }
> -    }
> -#elif defined(TARGET_NIOS2)
> -    {
> -        env->regs[0] = 0;
> -        env->regs[1] = regs->r1;
> -        env->regs[2] = regs->r2;
> -        env->regs[3] = regs->r3;
> -        env->regs[4] = regs->r4;
> -        env->regs[5] = regs->r5;
> -        env->regs[6] = regs->r6;
> -        env->regs[7] = regs->r7;
> -        env->regs[8] = regs->r8;
> -        env->regs[9] = regs->r9;
> -        env->regs[10] = regs->r10;
> -        env->regs[11] = regs->r11;
> -        env->regs[12] = regs->r12;
> -        env->regs[13] = regs->r13;
> -        env->regs[14] = regs->r14;
> -        env->regs[15] = regs->r15;
> -        /* TODO: unsigned long  orig_r2; */
> -        env->regs[R_RA] = regs->ra;
> -        env->regs[R_FP] = regs->fp;
> -        env->regs[R_SP] = regs->sp;
> -        env->regs[R_GP] = regs->gp;
> -        env->regs[CR_ESTATUS] = regs->estatus;
> -        env->regs[R_EA] = regs->ea;
> -        /* TODO: unsigned long  orig_r7; */
> -
> -        /* Emulate eret when starting thread. */
> -        env->regs[R_PC] = regs->ea;
> -    }
> -#elif defined(TARGET_OPENRISC)
> -    {
> -        int i;
> -
> -        for (i = 0; i < 32; i++) {
> -            cpu_set_gpr(env, i, regs->gpr[i]);
> -        }
> -        env->pc = regs->pc;
> -        cpu_set_sr(env, regs->sr);
> -    }
> -#elif defined(TARGET_RISCV)
> -    {
> -        env->pc = regs->sepc;
> -        env->gpr[xSP] = regs->sp;
> -    }
> -#elif defined(TARGET_SH4)
> -    {
> -        int i;
> -
> -        for(i = 0; i < 16; i++) {
> -            env->gregs[i] = regs->regs[i];
> -        }
> -        env->pc = regs->pc;
> -    }
> -#elif defined(TARGET_ALPHA)
> -    {
> -        int i;
> -
> -        for(i = 0; i < 28; i++) {
> -            env->ir[i] = ((abi_ulong *)regs)[i];
> -        }
> -        env->ir[IR_SP] = regs->usp;
> -        env->pc = regs->pc;
> -    }
> -#elif defined(TARGET_CRIS)
> -    {
> -	    env->regs[0] = regs->r0;
> -	    env->regs[1] = regs->r1;
> -	    env->regs[2] = regs->r2;
> -	    env->regs[3] = regs->r3;
> -	    env->regs[4] = regs->r4;
> -	    env->regs[5] = regs->r5;
> -	    env->regs[6] = regs->r6;
> -	    env->regs[7] = regs->r7;
> -	    env->regs[8] = regs->r8;
> -	    env->regs[9] = regs->r9;
> -	    env->regs[10] = regs->r10;
> -	    env->regs[11] = regs->r11;
> -	    env->regs[12] = regs->r12;
> -	    env->regs[13] = regs->r13;
> -	    env->regs[14] = info->start_stack;
> -	    env->regs[15] = regs->acr;	    
> -	    env->pc = regs->erp;
> -    }
> -#elif defined(TARGET_S390X)
> -    {
> -            int i;
> -            for (i = 0; i < 16; i++) {
> -                env->regs[i] = regs->gprs[i];
> -            }
> -            env->psw.mask = regs->psw.mask;
> -            env->psw.addr = regs->psw.addr;
> -    }
> -#elif defined(TARGET_TILEGX)
> -    {
> -        int i;
> -        for (i = 0; i < TILEGX_R_COUNT; i++) {
> -            env->regs[i] = regs->regs[i];
> -        }
> -        for (i = 0; i < TILEGX_SPR_COUNT; i++) {
> -            env->spregs[i] = 0;
> -        }
> -        env->pc = regs->pc;
> -    }
> -#elif defined(TARGET_HPPA)
> -    {
> -        int i;
> -        for (i = 1; i < 32; i++) {
> -            env->gr[i] = regs->gr[i];
> -        }
> -        env->iaoq_f = regs->iaoq[0];
> -        env->iaoq_b = regs->iaoq[1];
> -    }
> -#elif defined(TARGET_XTENSA)
> -    {
> -        int i;
> -        for (i = 0; i < 16; ++i) {
> -            env->regs[i] = regs->areg[i];
> -        }
> -        env->sregs[WINDOW_START] = regs->windowstart;
> -        env->pc = regs->pc;
> -    }
> -#else
> -#error unsupported target CPU
> -#endif
> -
> -#if defined(TARGET_ARM) || defined(TARGET_M68K)
> -    ts->stack_base = info->start_stack;
> -    ts->heap_base = info->brk;
> -    /* This will be filled in on the first SYS_HEAPINFO call.  */
> -    ts->heap_limit = 0;
> -#endif
> +#include "prologue.inc.c"
>  
>      if (gdbstub_port) {
>          if (gdbserver_start(gdbstub_port) < 0) {
> diff --git a/linux-user/microblaze/prologue.inc.c b/linux-user/microblaze/prologue.inc.c
> new file mode 100644
> index 0000000000..a7248cb788
> --- /dev/null
> +++ b/linux-user/microblaze/prologue.inc.c
> @@ -0,0 +1,35 @@
> +    {
> +        env->regs[0] = regs->r0;
> +        env->regs[1] = regs->r1;
> +        env->regs[2] = regs->r2;
> +        env->regs[3] = regs->r3;
> +        env->regs[4] = regs->r4;
> +        env->regs[5] = regs->r5;
> +        env->regs[6] = regs->r6;
> +        env->regs[7] = regs->r7;
> +        env->regs[8] = regs->r8;
> +        env->regs[9] = regs->r9;
> +        env->regs[10] = regs->r10;
> +        env->regs[11] = regs->r11;
> +        env->regs[12] = regs->r12;
> +        env->regs[13] = regs->r13;
> +        env->regs[14] = regs->r14;
> +        env->regs[15] = regs->r15;
> +        env->regs[16] = regs->r16;
> +        env->regs[17] = regs->r17;
> +        env->regs[18] = regs->r18;
> +        env->regs[19] = regs->r19;
> +        env->regs[20] = regs->r20;
> +        env->regs[21] = regs->r21;
> +        env->regs[22] = regs->r22;
> +        env->regs[23] = regs->r23;
> +        env->regs[24] = regs->r24;
> +        env->regs[25] = regs->r25;
> +        env->regs[26] = regs->r26;
> +        env->regs[27] = regs->r27;
> +        env->regs[28] = regs->r28;
> +        env->regs[29] = regs->r29;
> +        env->regs[30] = regs->r30;
> +        env->regs[31] = regs->r31;
> +        env->sregs[SR_PC] = regs->pc;
> +    }
> diff --git a/linux-user/mips/prologue.inc.c b/linux-user/mips/prologue.inc.c
> new file mode 100644
> index 0000000000..bd7f2b3c0e
> --- /dev/null
> +++ b/linux-user/mips/prologue.inc.c
> @@ -0,0 +1,25 @@
> +    {
> +        int i;
> +
> +        for(i = 0; i < 32; i++) {
> +            env->active_tc.gpr[i] = regs->regs[i];
> +        }
> +        env->active_tc.PC = regs->cp0_epc & ~(target_ulong)1;
> +        if (regs->cp0_epc & 1) {
> +            env->hflags |= MIPS_HFLAG_M16;
> +        }
> +        if (((info->elf_flags & EF_MIPS_NAN2008) != 0) !=
> +            ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) != 0)) {
> +            if ((env->active_fpu.fcr31_rw_bitmask &
> +                  (1 << FCR31_NAN2008)) == 0) {
> +                fprintf(stderr, "ELF binary's NaN mode not supported by CPU\n");
> +                exit(1);
> +            }
> +            if ((info->elf_flags & EF_MIPS_NAN2008) != 0) {
> +                env->active_fpu.fcr31 |= (1 << FCR31_NAN2008);
> +            } else {
> +                env->active_fpu.fcr31 &= ~(1 << FCR31_NAN2008);
> +            }
> +            restore_snan_bit_mode(env);
> +        }
> +    }
> diff --git a/linux-user/mips64/prologue.inc.c b/linux-user/mips64/prologue.inc.c
> new file mode 100644
> index 0000000000..d74fa9e773
> --- /dev/null
> +++ b/linux-user/mips64/prologue.inc.c
> @@ -0,0 +1 @@
> +#include "../mips/prologue.inc.c"
> diff --git a/linux-user/nios2/prologue.inc.c b/linux-user/nios2/prologue.inc.c
> new file mode 100644
> index 0000000000..d05b4ecba6
> --- /dev/null
> +++ b/linux-user/nios2/prologue.inc.c
> @@ -0,0 +1,29 @@
> +    {
> +        env->regs[0] = 0;
> +        env->regs[1] = regs->r1;
> +        env->regs[2] = regs->r2;
> +        env->regs[3] = regs->r3;
> +        env->regs[4] = regs->r4;
> +        env->regs[5] = regs->r5;
> +        env->regs[6] = regs->r6;
> +        env->regs[7] = regs->r7;
> +        env->regs[8] = regs->r8;
> +        env->regs[9] = regs->r9;
> +        env->regs[10] = regs->r10;
> +        env->regs[11] = regs->r11;
> +        env->regs[12] = regs->r12;
> +        env->regs[13] = regs->r13;
> +        env->regs[14] = regs->r14;
> +        env->regs[15] = regs->r15;
> +        /* TODO: unsigned long  orig_r2; */
> +        env->regs[R_RA] = regs->ra;
> +        env->regs[R_FP] = regs->fp;
> +        env->regs[R_SP] = regs->sp;
> +        env->regs[R_GP] = regs->gp;
> +        env->regs[CR_ESTATUS] = regs->estatus;
> +        env->regs[R_EA] = regs->ea;
> +        /* TODO: unsigned long  orig_r7; */
> +
> +        /* Emulate eret when starting thread. */
> +        env->regs[R_PC] = regs->ea;
> +    }
> diff --git a/linux-user/openrisc/prologue.inc.c b/linux-user/openrisc/prologue.inc.c
> new file mode 100644
> index 0000000000..a09fde3352
> --- /dev/null
> +++ b/linux-user/openrisc/prologue.inc.c
> @@ -0,0 +1,9 @@
> +    {
> +        int i;
> +
> +        for (i = 0; i < 32; i++) {
> +            cpu_set_gpr(env, i, regs->gpr[i]);
> +        }
> +        env->pc = regs->pc;
> +        cpu_set_sr(env, regs->sr);
> +    }
> diff --git a/linux-user/ppc/prologue.inc.c b/linux-user/ppc/prologue.inc.c
> new file mode 100644
> index 0000000000..92ed1c1b11
> --- /dev/null
> +++ b/linux-user/ppc/prologue.inc.c
> @@ -0,0 +1,16 @@
> +    {
> +        int i;
> +
> +#if defined(TARGET_PPC64)
> +        int flag = (env->insns_flags2 & PPC2_BOOKE206) ? MSR_CM : MSR_SF;
> +#if defined(TARGET_ABI32)
> +        env->msr &= ~((target_ulong)1 << flag);
> +#else
> +        env->msr |= (target_ulong)1 << flag;
> +#endif
> +#endif
> +        env->nip = regs->nip;
> +        for(i = 0; i < 32; i++) {
> +            env->gpr[i] = regs->gpr[i];
> +        }
> +    }
> diff --git a/linux-user/riscv/prologue.inc.c b/linux-user/riscv/prologue.inc.c
> new file mode 100644
> index 0000000000..eaaf0d5016
> --- /dev/null
> +++ b/linux-user/riscv/prologue.inc.c
> @@ -0,0 +1,4 @@
> +    {
> +        env->pc = regs->sepc;
> +        env->gpr[xSP] = regs->sp;
> +    }
> diff --git a/linux-user/s390x/prologue.inc.c b/linux-user/s390x/prologue.inc.c
> new file mode 100644
> index 0000000000..b036127022
> --- /dev/null
> +++ b/linux-user/s390x/prologue.inc.c
> @@ -0,0 +1,8 @@
> +    {
> +            int i;
> +            for (i = 0; i < 16; i++) {
> +                env->regs[i] = regs->gprs[i];
> +            }
> +            env->psw.mask = regs->psw.mask;
> +            env->psw.addr = regs->psw.addr;
> +    }
> diff --git a/linux-user/sh4/prologue.inc.c b/linux-user/sh4/prologue.inc.c
> new file mode 100644
> index 0000000000..ae1d8270ef
> --- /dev/null
> +++ b/linux-user/sh4/prologue.inc.c
> @@ -0,0 +1,8 @@
> +    {
> +        int i;
> +
> +        for(i = 0; i < 16; i++) {
> +            env->gregs[i] = regs->regs[i];
> +        }
> +        env->pc = regs->pc;
> +    }
> diff --git a/linux-user/sparc/prologue.inc.c b/linux-user/sparc/prologue.inc.c
> new file mode 100644
> index 0000000000..3bfea0a553
> --- /dev/null
> +++ b/linux-user/sparc/prologue.inc.c
> @@ -0,0 +1,10 @@
> +    {
> +        int i;
> +	env->pc = regs->pc;
> +	env->npc = regs->npc;
> +        env->y = regs->y;
> +        for(i = 0; i < 8; i++)
> +            env->gregs[i] = regs->u_regs[i];
> +        for(i = 0; i < 8; i++)
> +            env->regwptr[i] = regs->u_regs[i + 8];
> +    }
> diff --git a/linux-user/sparc64/prologue.inc.c b/linux-user/sparc64/prologue.inc.c
> new file mode 100644
> index 0000000000..e1b5fea628
> --- /dev/null
> +++ b/linux-user/sparc64/prologue.inc.c
> @@ -0,0 +1 @@
> +#include "../sparc/prologue.inc.c"
> diff --git a/linux-user/tilegx/prologue.inc.c b/linux-user/tilegx/prologue.inc.c
> new file mode 100644
> index 0000000000..9ea7429760
> --- /dev/null
> +++ b/linux-user/tilegx/prologue.inc.c
> @@ -0,0 +1,10 @@
> +    {
> +        int i;
> +        for (i = 0; i < TILEGX_R_COUNT; i++) {
> +            env->regs[i] = regs->regs[i];
> +        }
> +        for (i = 0; i < TILEGX_SPR_COUNT; i++) {
> +            env->spregs[i] = 0;
> +        }
> +        env->pc = regs->pc;
> +    }
> diff --git a/linux-user/x86_64/prologue.inc.c b/linux-user/x86_64/prologue.inc.c
> new file mode 100644
> index 0000000000..ecfe04e909
> --- /dev/null
> +++ b/linux-user/x86_64/prologue.inc.c
> @@ -0,0 +1 @@
> +#include "../i386/prologue.inc.c"
> diff --git a/linux-user/xtensa/prologue.inc.c b/linux-user/xtensa/prologue.inc.c
> new file mode 100644
> index 0000000000..0c97de8244
> --- /dev/null
> +++ b/linux-user/xtensa/prologue.inc.c
> @@ -0,0 +1,8 @@
> +    {
> +        int i;
> +        for (i = 0; i < 16; ++i) {
> +            env->regs[i] = regs->areg[i];
> +        }
> +        env->sregs[WINDOW_START] = regs->windowstart;
> +        env->pc = regs->pc;
> +    }
> 
