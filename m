Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99313C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C557C248AF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C557C248AF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLmU-0005QZ-Hv
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSLlO-0004bm-9L; Tue, 13 Oct 2020 10:58:54 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:23839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSLlI-0005ld-VC; Tue, 13 Oct 2020 10:58:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 78DE57475FF;
 Tue, 13 Oct 2020 16:58:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 37AA87475FE; Tue, 13 Oct 2020 16:58:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 35B787475FA;
 Tue, 13 Oct 2020 16:58:44 +0200 (CEST)
Date: Tue, 13 Oct 2020 16:58:44 +0200 (CEST)
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
In-Reply-To: <20201012232939.48481-8-j@getutm.app>
Message-ID: <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 10:41:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 "open list:S390 TCG target" <qemu-s390x@nongnu.org>,
 "open list:AArch64 TCG target" <qemu-arm@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Mon, 12 Oct 2020, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>
>
> On iOS, we cannot allocate RWX pages without special entitlements. As a
> workaround, we can a RX region and then mirror map it to a separate RX

Missing a verb here: "we can a RX region"

> region. Then we can write to one region and execute from the other one.
>
> To better keep track of pointers to RW/RX memory, we mark any tcg_insn_unit
> pointers as `const` if they will never be written to. We also define a new
> macro `TCG_CODE_PTR_RW` that returns a pointer to RW memory. Only the
> difference between the two regions is stored in the TCG context.

Maybe it's easier to review if constification is split off as separate 
patch before other changes.

> To ensure cache coherency, we flush the data cache in the RW mapping and
> then invalidate the instruction cache in the RX mapping (where applicable).
> Because data cache flush is OS defined on some architectures, we do not
> provide implementations for non iOS platforms (ARM/x86).
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
> accel/tcg/cpu-exec.c         |  7 +++-
> accel/tcg/translate-all.c    | 78 ++++++++++++++++++++++++++++++++++--
> configure                    |  1 +
> docs/devel/ios.rst           | 40 ++++++++++++++++++
> include/exec/exec-all.h      |  8 ++++
> include/tcg/tcg.h            | 18 +++++++--
> tcg/aarch64/tcg-target.c.inc | 48 +++++++++++++---------
> tcg/aarch64/tcg-target.h     | 13 +++++-
> tcg/arm/tcg-target.c.inc     | 33 ++++++++-------
> tcg/arm/tcg-target.h         |  9 ++++-
> tcg/i386/tcg-target.c.inc    | 28 ++++++-------
> tcg/i386/tcg-target.h        | 24 ++++++++++-
> tcg/mips/tcg-target.c.inc    | 64 +++++++++++++++++------------
> tcg/mips/tcg-target.h        |  8 +++-
> tcg/ppc/tcg-target.c.inc     | 55 ++++++++++++++++---------
> tcg/ppc/tcg-target.h         |  8 +++-
> tcg/riscv/tcg-target.c.inc   | 51 +++++++++++++----------
> tcg/riscv/tcg-target.h       |  9 ++++-
> tcg/s390/tcg-target.c.inc    | 25 ++++++------
> tcg/s390/tcg-target.h        | 13 +++++-
> tcg/sparc/tcg-target.c.inc   | 33 +++++++++------
> tcg/sparc/tcg-target.h       |  8 +++-
> tcg/tcg-ldst.c.inc           |  2 +-
> tcg/tcg-pool.c.inc           |  9 +++--
> tcg/tcg.c                    | 60 +++++++++++++++++----------
> tcg/tci/tcg-target.c.inc     |  8 ++--
> tcg/tci/tcg-target.h         |  9 ++++-
> 27 files changed, 481 insertions(+), 188 deletions(-)
> create mode 100644 docs/devel/ios.rst
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 58aea605d8..821aefdea2 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -354,7 +354,12 @@ void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr)
>     if (TCG_TARGET_HAS_direct_jump) {
>         uintptr_t offset = tb->jmp_target_arg[n];
>         uintptr_t tc_ptr = (uintptr_t)tb->tc.ptr;
> -        tb_target_set_jmp_target(tc_ptr, tc_ptr + offset, addr);
> +#if defined(CONFIG_IOS_JIT)
> +        uintptr_t wr_addr = tc_ptr + offset + tb->code_rw_mirror_diff;
> +#else
> +        uintptr_t wr_addr = tc_ptr + offset;
> +#endif
> +        tb_target_set_jmp_target(tc_ptr, tc_ptr + offset, addr, wr_addr);
>     } else {
>         tb->jmp_target_arg[n] = addr;
>     }
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index d76097296d..76d8dc3d7b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -60,6 +60,22 @@
> #include "sysemu/cpu-timers.h"
> #include "sysemu/tcg.h"
>
> +#if defined(CONFIG_IOS_JIT)
> +#include <mach/mach.h>
> +extern kern_return_t mach_vm_remap(vm_map_t target_task,
> +                                   mach_vm_address_t *target_address,
> +                                   mach_vm_size_t size,
> +                                   mach_vm_offset_t mask,
> +                                   int flags,
> +                                   vm_map_t src_task,
> +                                   mach_vm_address_t src_address,
> +                                   boolean_t copy,
> +                                   vm_prot_t *cur_protection,
> +                                   vm_prot_t *max_protection,
> +                                   vm_inherit_t inheritance
> +                                  );
> +#endif
> +
> /* #define DEBUG_TB_INVALIDATE */
> /* #define DEBUG_TB_FLUSH */
> /* make various TB consistency checks */
> @@ -302,10 +318,13 @@ static target_long decode_sleb128(uint8_t **pp)
>
> static int encode_search(TranslationBlock *tb, uint8_t *block)
> {
> -    uint8_t *highwater = tcg_ctx->code_gen_highwater;
> -    uint8_t *p = block;
> +    uint8_t *highwater;
> +    uint8_t *p;
>     int i, j, n;
>
> +    highwater = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx,
> +                                           tcg_ctx->code_gen_highwater);
> +    p = (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx, block);

Why do you need explicit casts here? Can this be avoided by using 
appropriate type or within the macro (I haven't checked this at all just 
dislike casts as they can hide problems otherwise caught by the compiler).

Regards,
BALATON Zoltan

>     for (i = 0, n = tb->icount; i < n; ++i) {
>         target_ulong prev;
>
> @@ -329,7 +348,7 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
>         }
>     }
>
> -    return p - block;
> +    return p - (uint8_t *)TCG_CODE_PTR_RW(tcg_ctx, block);
> }
>
> /* The cpu state corresponding to 'searched_pc' is restored.
> @@ -1067,7 +1086,11 @@ static inline void *alloc_code_gen_buffer(void)
> #else
> static inline void *alloc_code_gen_buffer(void)
> {
> +#if defined(CONFIG_IOS_JIT)
> +    int prot = PROT_READ | PROT_EXEC;
> +#else
>     int prot = PROT_WRITE | PROT_READ | PROT_EXEC;
> +#endif
>     int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>     size_t size = tcg_ctx->code_gen_buffer_size;
>     void *buf;
> @@ -1118,6 +1141,39 @@ static inline void *alloc_code_gen_buffer(void)
> }
> #endif /* USE_STATIC_CODE_GEN_BUFFER, WIN32, POSIX */
>
> +#if defined(CONFIG_IOS_JIT)
> +static inline void *alloc_jit_rw_mirror(void *base, size_t size)
> +{
> +    kern_return_t ret;
> +    mach_vm_address_t mirror;
> +    vm_prot_t cur_prot, max_prot;
> +
> +    mirror = 0;
> +    ret = mach_vm_remap(mach_task_self(),
> +                        &mirror,
> +                        size,
> +                        0,
> +                        VM_FLAGS_ANYWHERE | VM_FLAGS_RANDOM_ADDR,
> +                        mach_task_self(),
> +                        (mach_vm_address_t)base,
> +                        false,
> +                        &cur_prot,
> +                        &max_prot,
> +                        VM_INHERIT_NONE
> +                       );
> +    if (ret != KERN_SUCCESS) {
> +        return NULL;
> +    }
> +
> +    if (mprotect((void *)mirror, size, PROT_READ | PROT_WRITE) != 0) {
> +        munmap((void *)mirror, size);
> +        return NULL;
> +    }
> +
> +    return (void *)mirror;
> +}
> +#endif /* CONFIG_IOS_JIT */
> +
> static inline void code_gen_alloc(size_t tb_size)
> {
>     tcg_ctx->code_gen_buffer_size = size_code_gen_buffer(tb_size);
> @@ -1126,6 +1182,19 @@ static inline void code_gen_alloc(size_t tb_size)
>         fprintf(stderr, "Could not allocate dynamic translator buffer\n");
>         exit(1);
>     }
> +#if defined(CONFIG_IOS_JIT)
> +    void *mirror;
> +
> +    /* For iOS JIT we need a mirror mapping for code execution */
> +    mirror = alloc_jit_rw_mirror(tcg_ctx->code_gen_buffer,
> +                                 tcg_ctx->code_gen_buffer_size
> +                                );
> +    if (mirror == NULL) {
> +        fprintf(stderr, "Could not remap code buffer mirror\n");
> +        exit(1);
> +    }
> +    tcg_ctx->code_rw_mirror_diff = mirror - tcg_ctx->code_gen_buffer;
> +#endif /* CONFIG_IOS_JIT */
> }
>
> static bool tb_cmp(const void *ap, const void *bp)
> @@ -1721,6 +1790,9 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>         cpu_loop_exit(cpu);
>     }
>
> +#if defined(CONFIG_IOS_JIT)
> +    tb->code_rw_mirror_diff = tcg_ctx->code_rw_mirror_diff;
> +#endif
>     gen_code_buf = tcg_ctx->code_gen_ptr;
>     tb->tc.ptr = gen_code_buf;
>     tb->pc = pc;
> diff --git a/configure b/configure
> index 16c66b437c..c5a6584683 100755
> --- a/configure
> +++ b/configure
> @@ -6220,6 +6220,7 @@ fi
>
> if test "$ios" = "yes" ; then
>   echo "CONFIG_IOS=y" >> $config_host_mak
> +  echo "CONFIG_IOS_JIT=y" >> $config_host_mak
> fi
>
> if test "$solaris" = "yes" ; then
> diff --git a/docs/devel/ios.rst b/docs/devel/ios.rst
> new file mode 100644
> index 0000000000..dba9fdd868
> --- /dev/null
> +++ b/docs/devel/ios.rst
> @@ -0,0 +1,40 @@
> +===========
> +iOS Support
> +===========
> +
> +To run qemu on the iOS platform, some modifications were required. Most of the
> +modifications are conditioned on the ``CONFIG_IOS`` and ``CONFIG_IOS_JIT``
> +configuration variables.
> +
> +Build support
> +-------------
> +
> +For the code to compile, certain changes in the block driver and the slirp
> +driver had to be made. There is no ``system()`` call, so code requiring it had
> +to be disabled.
> +
> +``ucontext`` support is broken on iOS. The implementation from ``libucontext``
> +is used instead.
> +
> +Because ``fork()`` is not allowed on iOS apps, the option to build qemu and the
> +utilities as shared libraries is added. Note that because qemu does not perform
> +resource cleanup in most cases (open files, allocated memory, etc), it is
> +advisable that the user implements a proxy layer for syscalls so resources can
> +be kept track by the app that uses qemu as a shared library.
> +
> +JIT support
> +-----------
> +
> +On iOS, allocating RWX pages require special entitlements not usually granted to
> +apps. However, it is possible to use `bulletproof JIT`_ with a development
> +certificate. This means that we need to allocate one chunk of memory with RX
> +permissions and then mirror map the same memory with RW permissions. We generate
> +code to the mirror mapping and execute the original mapping.
> +
> +With ``CONFIG_IOS_JIT`` defined, we store inside the TCG context the difference
> +between the two mappings. Then, we make sure that any writes to JIT memory is
> +done to the pointer + the difference (in order to get a pointer to the mirror
> +mapped space). Additionally, we make sure to flush the data cache before we
> +invalidate the instruction cache so the changes are seen in both mappings.
> +
> +.. _bulletproof JIT: https://www.blackhat.com/docs/us-16/materials/us-16-Krstic.pdf
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 66f9b4cca6..2db155a772 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -483,6 +483,14 @@ struct TranslationBlock {
>     uintptr_t jmp_list_head;
>     uintptr_t jmp_list_next[2];
>     uintptr_t jmp_dest[2];
> +
> +#if defined(CONFIG_IOS_JIT)
> +    /*
> +     * Store difference to writable mirror
> +     * We need this when patching the jump instructions
> +     */
> +    ptrdiff_t code_rw_mirror_diff;
> +#endif
> };
>
> extern bool parallel_cpus;
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 8804a8c4a2..40d1a7a85e 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -261,7 +261,7 @@ struct TCGLabel {
>     unsigned refs : 16;
>     union {
>         uintptr_t value;
> -        tcg_insn_unit *value_ptr;
> +        const tcg_insn_unit *value_ptr;
>     } u;
>     QSIMPLEQ_HEAD(, TCGRelocation) relocs;
>     QSIMPLEQ_ENTRY(TCGLabel) next;
> @@ -593,7 +593,7 @@ struct TCGContext {
>     int nb_ops;
>
>     /* goto_tb support */
> -    tcg_insn_unit *code_buf;
> +    const tcg_insn_unit *code_buf;
>     uint16_t *tb_jmp_reset_offset; /* tb->jmp_reset_offset */
>     uintptr_t *tb_jmp_insn_offset; /* tb->jmp_target_arg if direct_jump */
>     uintptr_t *tb_jmp_target_addr; /* tb->jmp_target_arg if !direct_jump */
> @@ -627,6 +627,9 @@ struct TCGContext {
>     size_t code_gen_buffer_size;
>     void *code_gen_ptr;
>     void *data_gen_ptr;
> +#if defined(CONFIG_IOS_JIT)
> +    ptrdiff_t code_rw_mirror_diff;
> +#endif
>
>     /* Threshold to flush the translated code buffer.  */
>     void *code_gen_highwater;
> @@ -677,6 +680,13 @@ struct TCGContext {
>     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
> };
>
> +#if defined(CONFIG_IOS_JIT)
> +# define TCG_CODE_PTR_RW(s, code_ptr) \
> +    (tcg_insn_unit *)((uintptr_t)(code_ptr) + (s)->code_rw_mirror_diff)
> +#else
> +# define TCG_CODE_PTR_RW(s, code_ptr) (code_ptr)
> +#endif
> +
> extern TCGContext tcg_init_ctx;
> extern __thread TCGContext *tcg_ctx;
> extern TCGv_env cpu_env;
> @@ -1099,7 +1109,7 @@ static inline TCGLabel *arg_label(TCGArg i)
>  * correct result.
>  */
>
> -static inline ptrdiff_t tcg_ptr_byte_diff(void *a, void *b)
> +static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
> {
>     return a - b;
> }
> @@ -1113,7 +1123,7 @@ static inline ptrdiff_t tcg_ptr_byte_diff(void *a, void *b)
>  * to the destination address.
>  */
>
> -static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, void *target)
> +static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
> {
>     return tcg_ptr_byte_diff(target, s->code_ptr);
> }
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 26f71cb599..9cfa2703b3 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -78,38 +78,44 @@ static const int tcg_target_call_oarg_regs[1] = {
> #define TCG_REG_GUEST_BASE TCG_REG_X28
> #endif
>
> -static inline bool reloc_pc26(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +static inline bool reloc_pc26(TCGContext *s,
> +                              tcg_insn_unit *code_ptr,
> +                              const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = target - code_ptr;
>     if (offset == sextract64(offset, 0, 26)) {
>         /* read instruction, mask away previous PC_REL26 parameter contents,
>            set the proper offset, then write back the instruction. */
> -        *code_ptr = deposit32(*code_ptr, 0, 26, offset);
> +        *TCG_CODE_PTR_RW(s, code_ptr) =
> +            deposit32(*TCG_CODE_PTR_RW(s, code_ptr), 0, 26, offset);
>         return true;
>     }
>     return false;
> }
>
> -static inline bool reloc_pc19(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +static inline bool reloc_pc19(TCGContext *s,
> +                              tcg_insn_unit *code_ptr,
> +                              const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = target - code_ptr;
>     if (offset == sextract64(offset, 0, 19)) {
> -        *code_ptr = deposit32(*code_ptr, 5, 19, offset);
> +        *TCG_CODE_PTR_RW(s, code_ptr) =
> +            deposit32(*TCG_CODE_PTR_RW(s, code_ptr), 5, 19, offset);
>         return true;
>     }
>     return false;
> }
>
> -static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static inline bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                                intptr_t value, intptr_t addend)
> {
>     tcg_debug_assert(addend == 0);
>     switch (type) {
>     case R_AARCH64_JUMP26:
>     case R_AARCH64_CALL26:
> -        return reloc_pc26(code_ptr, (tcg_insn_unit *)value);
> +        return reloc_pc26(s, code_ptr, (tcg_insn_unit *)value);
>     case R_AARCH64_CONDBR19:
> -        return reloc_pc19(code_ptr, (tcg_insn_unit *)value);
> +        return reloc_pc19(s, code_ptr, (tcg_insn_unit *)value);
>     default:
>         g_assert_not_reached();
>     }
> @@ -1306,14 +1312,14 @@ static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGReg a,
>     }
> }
>
> -static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
> +static inline void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = target - s->code_ptr;
>     tcg_debug_assert(offset == sextract64(offset, 0, 26));
>     tcg_out_insn(s, 3206, B, offset);
> }
>
> -static inline void tcg_out_goto_long(TCGContext *s, tcg_insn_unit *target)
> +static inline void tcg_out_goto_long(TCGContext *s, const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = target - s->code_ptr;
>     if (offset == sextract64(offset, 0, 26)) {
> @@ -1329,7 +1335,7 @@ static inline void tcg_out_callr(TCGContext *s, TCGReg reg)
>     tcg_out_insn(s, 3207, BLR, reg);
> }
>
> -static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
> +static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = target - s->code_ptr;
>     if (offset == sextract64(offset, 0, 26)) {
> @@ -1341,7 +1347,7 @@ static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
> }
>
> void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
> -                              uintptr_t addr)
> +                              uintptr_t addr, uintptr_t wr_addr)
> {
>     tcg_insn_unit i1, i2;
>     TCGType rt = TCG_TYPE_I64;
> @@ -1362,7 +1368,10 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>         i2 = I3401_ADDI | rt << 31 | (addr & 0xfff) << 10 | rd << 5 | rd;
>     }
>     pair = (uint64_t)i2 << 32 | i1;
> -    qatomic_set((uint64_t *)jmp_addr, pair);
> +    qatomic_set((uint64_t *)wr_addr, pair);
> +#if defined(CONFIG_IOS_JIT)
> +    flush_dcache_range(wr_addr, wr_addr + 8);
> +#endif
>     flush_icache_range(jmp_addr, jmp_addr + 8);
> }
>
> @@ -1568,7 +1577,7 @@ static void * const qemu_st_helpers[16] = {
>     [MO_BEQ]  = helper_be_stq_mmu,
> };
>
> -static inline void tcg_out_adr(TCGContext *s, TCGReg rd, void *target)
> +static inline void tcg_out_adr(TCGContext *s, TCGReg rd, const void *target)
> {
>     ptrdiff_t offset = tcg_pcrel_diff(s, target);
>     tcg_debug_assert(offset == sextract64(offset, 0, 21));
> @@ -1581,7 +1590,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     MemOp opc = get_memop(oi);
>     MemOp size = opc & MO_SIZE;
>
> -    if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
> +    if (!reloc_pc19(s, lb->label_ptr[0], s->code_ptr)) {
>         return false;
>     }
>
> @@ -1606,7 +1615,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     MemOp opc = get_memop(oi);
>     MemOp size = opc & MO_SIZE;
>
> -    if (!reloc_pc19(lb->label_ptr[0], s->code_ptr)) {
> +    if (!reloc_pc19(s, lb->label_ptr[0], s->code_ptr)) {
>         return false;
>     }
>
> @@ -1622,7 +1631,8 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>
> static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
>                                 TCGType ext, TCGReg data_reg, TCGReg addr_reg,
> -                                tcg_insn_unit *raddr, tcg_insn_unit *label_ptr)
> +                                const tcg_insn_unit *raddr,
> +                                tcg_insn_unit *label_ptr)
> {
>     TCGLabelQemuLdst *label = new_ldst_label(s);
>
> @@ -1849,7 +1859,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
> #endif /* CONFIG_SOFTMMU */
> }
>
> -static tcg_insn_unit *tb_ret_addr;
> +static const tcg_insn_unit *tb_ret_addr;
>
> static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>                        const TCGArg args[TCG_MAX_OP_ARGS],
> @@ -2916,11 +2926,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>     tcg_out_insn(s, 3207, RET, TCG_REG_LR);
> }
>
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count)
> {
>     int i;
>     for (i = 0; i < count; ++i) {
> -        p[i] = NOP;
> +        (TCG_CODE_PTR_RW(s, p))[i] = NOP;
>     }
> }
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index a2b22b4305..78c97460a1 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -150,6 +150,7 @@ typedef enum {
>
> #if defined(__APPLE__)
> void sys_icache_invalidate(void *start, size_t len);
> +void sys_dcache_flush(void *start, size_t len);
> #endif
>
> static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> @@ -163,7 +164,17 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> #endif
> }
>
> -void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> +void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#if defined(__APPLE__)
> +    sys_dcache_flush((char *)start, stop - start);
> +#else
> +#error "Missing function to flush data cache"
> +#endif
> +}
> +#endif
>
> #ifdef CONFIG_SOFTMMU
> #define TCG_TARGET_NEED_LDST_LABELS
> diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
> index 62c37a954b..d27ad851b5 100644
> --- a/tcg/arm/tcg-target.c.inc
> +++ b/tcg/arm/tcg-target.c.inc
> @@ -187,17 +187,22 @@ static const uint8_t tcg_cond_to_arm_cond[] = {
>     [TCG_COND_GTU] = COND_HI,
> };
>
> -static inline bool reloc_pc24(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +static inline bool reloc_pc24(TCGContext *s,
> +                              tcg_insn_unit *code_ptr,
> +                              const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = (tcg_ptr_byte_diff(target, code_ptr) - 8) >> 2;
>     if (offset == sextract32(offset, 0, 24)) {
> -        *code_ptr = (*code_ptr & ~0xffffff) | (offset & 0xffffff);
> +        *TCG_CODE_PTR_RW(s, code_ptr) =
> +            (*TCG_CODE_PTR_RW(s, code_ptr) & ~0xffffff) | (offset & 0xffffff);
>         return true;
>     }
>     return false;
> }
>
> -static inline bool reloc_pc13(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +static inline bool reloc_pc13(TCGContext *s,
> +                              tcg_insn_unit *code_ptr,
> +                              const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = tcg_ptr_byte_diff(target, code_ptr) - 8;
>
> @@ -209,21 +214,21 @@ static inline bool reloc_pc13(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
>         }
>         insn = deposit32(insn, 23, 1, u);
>         insn = deposit32(insn, 0, 12, offset);
> -        *code_ptr = insn;
> +        *TCG_CODE_PTR_RW(s, code_ptr) = insn;
>         return true;
>     }
>     return false;
> }
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     tcg_debug_assert(addend == 0);
>
>     if (type == R_ARM_PC24) {
> -        return reloc_pc24(code_ptr, (tcg_insn_unit *)value);
> +        return reloc_pc24(s, code_ptr, (tcg_insn_unit *)value);
>     } else if (type == R_ARM_PC13) {
> -        return reloc_pc13(code_ptr, (tcg_insn_unit *)value);
> +        return reloc_pc13(s, code_ptr, (tcg_insn_unit *)value);
>     } else {
>         g_assert_not_reached();
>     }
> @@ -1019,7 +1024,7 @@ static inline void tcg_out_st8(TCGContext *s, int cond,
>  * with the code buffer limited to 16MB we wouldn't need the long case.
>  * But we also use it for the tail-call to the qemu_ld/st helpers, which does.
>  */
> -static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
> +static void tcg_out_goto(TCGContext *s, int cond, const tcg_insn_unit *addr)
> {
>     intptr_t addri = (intptr_t)addr;
>     ptrdiff_t disp = tcg_pcrel_diff(s, addr);
> @@ -1033,7 +1038,7 @@ static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
>
> /* The call case is mostly used for helpers - so it's not unreasonable
>  * for them to be beyond branch range */
> -static void tcg_out_call(TCGContext *s, tcg_insn_unit *addr)
> +static void tcg_out_call(TCGContext *s, const tcg_insn_unit *addr)
> {
>     intptr_t addri = (intptr_t)addr;
>     ptrdiff_t disp = tcg_pcrel_diff(s, addr);
> @@ -1326,7 +1331,7 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addrlo, TCGReg addrhi,
>    helper code.  */
> static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
>                                 TCGReg datalo, TCGReg datahi, TCGReg addrlo,
> -                                TCGReg addrhi, tcg_insn_unit *raddr,
> +                                TCGReg addrhi, const tcg_insn_unit *raddr,
>                                 tcg_insn_unit *label_ptr)
> {
>     TCGLabelQemuLdst *label = new_ldst_label(s);
> @@ -1348,7 +1353,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     MemOp opc = get_memop(oi);
>     void *func;
>
> -    if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
> +    if (!reloc_pc24(s, lb->label_ptr[0], s->code_ptr)) {
>         return false;
>     }
>
> @@ -1411,7 +1416,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     TCGMemOpIdx oi = lb->oi;
>     MemOp opc = get_memop(oi);
>
> -    if (!reloc_pc24(lb->label_ptr[0], s->code_ptr)) {
> +    if (!reloc_pc24(s, lb->label_ptr[0], s->code_ptr)) {
>         return false;
>     }
>
> @@ -2255,11 +2260,11 @@ static inline void tcg_out_movi(TCGContext *s, TCGType type,
>     tcg_out_movi32(s, COND_AL, ret, arg);
> }
>
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count)
> {
>     int i;
>     for (i = 0; i < count; ++i) {
> -        p[i] = INSN_NOP;
> +        (TCG_CODE_PTR_RW(s, p))[i] = INSN_NOP;
>     }
> }
>
> diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
> index 17e771374d..d8d7e7e239 100644
> --- a/tcg/arm/tcg-target.h
> +++ b/tcg/arm/tcg-target.h
> @@ -139,8 +139,15 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>     __builtin___clear_cache((char *) start, (char *) stop);
> }
>
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#error "Unimplemented dcache flush function"
> +}
> +#endif
> +
> /* not defined -- call should be eliminated at compile time */
> -void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> +void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
>
> #ifdef CONFIG_SOFTMMU
> #define TCG_TARGET_NEED_LDST_LABELS
> diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
> index d8797ed398..e9c128d9e7 100644
> --- a/tcg/i386/tcg-target.c.inc
> +++ b/tcg/i386/tcg-target.c.inc
> @@ -165,9 +165,9 @@ static bool have_lzcnt;
> # define have_lzcnt 0
> #endif
>
> -static tcg_insn_unit *tb_ret_addr;
> +static const tcg_insn_unit *tb_ret_addr;
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     value += addend;
> @@ -179,14 +179,14 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>         }
>         /* FALLTHRU */
>     case R_386_32:
> -        tcg_patch32(code_ptr, value);
> +        tcg_patch32(s, code_ptr, value);
>         break;
>     case R_386_PC8:
>         value -= (uintptr_t)code_ptr;
>         if (value != (int8_t)value) {
>             return false;
>         }
> -        tcg_patch8(code_ptr, value);
> +        tcg_patch8(s, code_ptr, value);
>         break;
>     default:
>         tcg_abort();
> @@ -1591,7 +1591,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
>     }
> }
>
> -static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
> +static void tcg_out_branch(TCGContext *s, int call, const tcg_insn_unit *dest)
> {
>     intptr_t disp = tcg_pcrel_diff(s, dest) - 5;
>
> @@ -1610,12 +1610,12 @@ static void tcg_out_branch(TCGContext *s, int call, tcg_insn_unit *dest)
>     }
> }
>
> -static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
> +static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
> {
>     tcg_out_branch(s, 1, dest);
> }
>
> -static void tcg_out_jmp(TCGContext *s, tcg_insn_unit *dest)
> +static void tcg_out_jmp(TCGContext *s, const tcg_insn_unit *dest)
> {
>     tcg_out_branch(s, 0, dest);
> }
> @@ -1774,7 +1774,7 @@ static void add_qemu_ldst_label(TCGContext *s, bool is_ld, bool is_64,
>                                 TCGMemOpIdx oi,
>                                 TCGReg datalo, TCGReg datahi,
>                                 TCGReg addrlo, TCGReg addrhi,
> -                                tcg_insn_unit *raddr,
> +                                const tcg_insn_unit *raddr,
>                                 tcg_insn_unit **label_ptr)
> {
>     TCGLabelQemuLdst *label = new_ldst_label(s);
> @@ -1805,9 +1805,9 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
>     int rexw = (l->type == TCG_TYPE_I64 ? P_REXW : 0);
>
>     /* resolve label address */
> -    tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
> +    tcg_patch32(s, label_ptr[0], s->code_ptr - label_ptr[0] - 4);
>     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> -        tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
> +        tcg_patch32(s, label_ptr[1], s->code_ptr - label_ptr[1] - 4);
>     }
>
>     if (TCG_TARGET_REG_BITS == 32) {
> @@ -1890,9 +1890,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
>     TCGReg retaddr;
>
>     /* resolve label address */
> -    tcg_patch32(label_ptr[0], s->code_ptr - label_ptr[0] - 4);
> +    tcg_patch32(s, label_ptr[0], s->code_ptr - label_ptr[0] - 4);
>     if (TARGET_LONG_BITS > TCG_TARGET_REG_BITS) {
> -        tcg_patch32(label_ptr[1], s->code_ptr - label_ptr[1] - 4);
> +        tcg_patch32(s, label_ptr[1], s->code_ptr - label_ptr[1] - 4);
>     }
>
>     if (TCG_TARGET_REG_BITS == 32) {
> @@ -3842,9 +3842,9 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>     tcg_out_opc(s, OPC_RET, 0, 0, 0);
> }
>
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count)
> {
> -    memset(p, 0x90, count);
> +    memset(TCG_CODE_PTR_RW(s, p), 0x90, count);
> }
>
> static void tcg_target_init(TCGContext *s)
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index abd4ac7fc0..cdc440ce36 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -206,16 +206,36 @@ extern bool have_avx2;
> #define TCG_TARGET_extract_i64_valid(ofs, len) \
>     (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
>
> +#ifdef __APPLE__
> +void sys_dcache_flush(void *start, size_t len);
> +#endif
> +
> static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> {
> }
>
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#if defined(__APPLE__)
> +    sys_dcache_flush((char *)start, stop - start);
> +#else
> +#error "Missing function to flush data cache"
> +#endif
> +}
> +#endif
> +
> static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
> -                                            uintptr_t jmp_addr, uintptr_t addr)
> +                                            uintptr_t jmp_addr, uintptr_t addr,
> +                                            uintptr_t wr_addr)
> {
>     /* patch the branch destination */
> -    qatomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
> +    qatomic_set((int32_t *)wr_addr, addr - (jmp_addr + 4));
>     /* no need to flush icache explicitly */
> +#if defined(CONFIG_IOS_JIT)
> +    /* we do need to flush mirror dcache */
> +    flush_dcache_range(wr_addr, wr_addr + 4);
> +#endif
> }
>
> /* This defines the natural memory order supported by this
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 41be574e89..e798527437 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -139,12 +139,13 @@ static const TCGReg tcg_target_call_oarg_regs[2] = {
>     TCG_REG_V1
> };
>
> -static tcg_insn_unit *tb_ret_addr;
> -static tcg_insn_unit *bswap32_addr;
> -static tcg_insn_unit *bswap32u_addr;
> -static tcg_insn_unit *bswap64_addr;
> +static const tcg_insn_unit *tb_ret_addr;
> +static const tcg_insn_unit *bswap32_addr;
> +static const tcg_insn_unit *bswap32u_addr;
> +static const tcg_insn_unit *bswap64_addr;
>
> -static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static inline uint32_t reloc_pc16_val(const tcg_insn_unit *pc,
> +                                      const tcg_insn_unit *target)
> {
>     /* Let the compiler perform the right-shift as part of the arithmetic.  */
>     ptrdiff_t disp = target - (pc + 1);
> @@ -152,28 +153,35 @@ static inline uint32_t reloc_pc16_val(tcg_insn_unit *pc, tcg_insn_unit *target)
>     return disp & 0xffff;
> }
>
> -static inline void reloc_pc16(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static inline void reloc_pc16(TCGContext *s,
> +                              tcg_insn_unit *pc,
> +                              const tcg_insn_unit *target)
> {
> -    *pc = deposit32(*pc, 0, 16, reloc_pc16_val(pc, target));
> +    *TCG_CODE_PTR_RW(s, pc) =
> +        deposit32(*TCG_CODE_PTR_RW(s, pc), 0, 16, reloc_pc16_val(pc, target));
> }
>
> -static inline uint32_t reloc_26_val(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static inline uint32_t reloc_26_val(const tcg_insn_unit *pc,
> +                                    const tcg_insn_unit *target)
> {
>     tcg_debug_assert((((uintptr_t)pc ^ (uintptr_t)target) & 0xf0000000) == 0);
>     return ((uintptr_t)target >> 2) & 0x3ffffff;
> }
>
> -static inline void reloc_26(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static inline void reloc_26(TCGContext *s,
> +                            tcg_insn_unit *pc,
> +                            const tcg_insn_unit *target)
> {
> -    *pc = deposit32(*pc, 0, 26, reloc_26_val(pc, target));
> +    *TCG_CODE_PTR_RW(s, pc) =
> +        deposit32(*TCG_CODE_PTR_RW(s, pc), 0, 26, reloc_26_val(pc, target));
> }
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     tcg_debug_assert(type == R_MIPS_PC16);
>     tcg_debug_assert(addend == 0);
> -    reloc_pc16(code_ptr, (tcg_insn_unit *)value);
> +    reloc_pc16(s, code_ptr, (tcg_insn_unit *)value);
>     return true;
> }
>
> @@ -516,7 +524,7 @@ static void tcg_out_opc_sa64(TCGContext *s, MIPSInsn opc1, MIPSInsn opc2,
>  * Type jump.
>  * Returns true if the branch was in range and the insn was emitted.
>  */
> -static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, void *target)
> +static bool tcg_out_opc_jmp(TCGContext *s, MIPSInsn opc, const void *target)
> {
>     uintptr_t dest = (uintptr_t)target;
>     uintptr_t from = (uintptr_t)s->code_ptr + 4;
> @@ -631,7 +639,7 @@ static inline void tcg_out_bswap16s(TCGContext *s, TCGReg ret, TCGReg arg)
>     }
> }
>
> -static void tcg_out_bswap_subr(TCGContext *s, tcg_insn_unit *sub)
> +static void tcg_out_bswap_subr(TCGContext *s, const tcg_insn_unit *sub)
> {
>     bool ok = tcg_out_opc_jmp(s, OPC_JAL, sub);
>     tcg_debug_assert(ok);
> @@ -925,7 +933,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
>
>     tcg_out_opc_br(s, b_opc, arg1, arg2);
>     if (l->has_value) {
> -        reloc_pc16(s->code_ptr - 1, l->u.value_ptr);
> +        reloc_pc16(s, s->code_ptr - 1, l->u.value_ptr);
>     } else {
>         tcg_out_reloc(s, s->code_ptr - 1, R_MIPS_PC16, l, 0);
>     }
> @@ -1079,7 +1087,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
>     }
> }
>
> -static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
> +static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
> {
>     /* Note that the ABI requires the called function's address to be
>        loaded into T9, even if a direct branch is in range.  */
> @@ -1097,7 +1105,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
>     }
> }
>
> -static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
> +static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
> {
>     tcg_out_call_int(s, arg, false);
>     tcg_out_nop(s);
> @@ -1289,7 +1297,8 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
>                                 TCGType ext,
>                                 TCGReg datalo, TCGReg datahi,
>                                 TCGReg addrlo, TCGReg addrhi,
> -                                void *raddr, tcg_insn_unit *label_ptr[2])
> +                                const tcg_insn_unit *raddr,
> +                                tcg_insn_unit *label_ptr[2])
> {
>     TCGLabelQemuLdst *label = new_ldst_label(s);
>
> @@ -1315,9 +1324,9 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
>     int i;
>
>     /* resolve label address */
> -    reloc_pc16(l->label_ptr[0], s->code_ptr);
> +    reloc_pc16(s, l->label_ptr[0], s->code_ptr);
>     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
> -        reloc_pc16(l->label_ptr[1], s->code_ptr);
> +        reloc_pc16(s, l->label_ptr[1], s->code_ptr);
>     }
>
>     i = 1;
> @@ -1345,7 +1354,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
>     }
>
>     tcg_out_opc_br(s, OPC_BEQ, TCG_REG_ZERO, TCG_REG_ZERO);
> -    reloc_pc16(s->code_ptr - 1, l->raddr);
> +    reloc_pc16(s, s->code_ptr - 1, l->raddr);
>
>     /* delay slot */
>     if (TCG_TARGET_REG_BITS == 64 && l->type == TCG_TYPE_I32) {
> @@ -1365,9 +1374,9 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
>     int i;
>
>     /* resolve label address */
> -    reloc_pc16(l->label_ptr[0], s->code_ptr);
> +    reloc_pc16(s, l->label_ptr[0], s->code_ptr);
>     if (TCG_TARGET_REG_BITS < TARGET_LONG_BITS) {
> -        reloc_pc16(l->label_ptr[1], s->code_ptr);
> +        reloc_pc16(s, l->label_ptr[1], s->code_ptr);
>     }
>
>     i = 1;
> @@ -2430,7 +2439,7 @@ static void tcg_target_detect_isa(void)
>     sigaction(SIGILL, &sa_old, NULL);
> }
>
> -static tcg_insn_unit *align_code_ptr(TCGContext *s)
> +static const tcg_insn_unit *align_code_ptr(TCGContext *s)
> {
>     uintptr_t p = (uintptr_t)s->code_ptr;
>     if (p & 15) {
> @@ -2657,9 +2666,12 @@ static void tcg_target_init(TCGContext *s)
> }
>
> void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
> -                              uintptr_t addr)
> +                              uintptr_t addr, uintptr_t wr_addr)
> {
> -    qatomic_set((uint32_t *)jmp_addr, deposit32(OPC_J, 0, 26, addr >> 2));
> +    qatomic_set((uint32_t *)wr_addr, deposit32(OPC_J, 0, 26, addr >> 2));
> +#if defined(CONFIG_IOS_JIT)
> +    flush_dcache_range(wr_addr, wr_addr + 4);
> +#endif
>     flush_icache_range(jmp_addr, jmp_addr + 4);
> }
>
> diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
> index c6b091d849..80dcba5358 100644
> --- a/tcg/mips/tcg-target.h
> +++ b/tcg/mips/tcg-target.h
> @@ -212,7 +212,13 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>     cacheflush ((void *)start, stop-start, ICACHE);
> }
>
> -void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> +void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#error "Unimplemented dcache flush function"
> +}
> +#endif
>
> #ifdef CONFIG_SOFTMMU
> #define TCG_TARGET_NEED_LDST_LABELS
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 18ee989f95..f5a44e9852 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -62,7 +62,7 @@
> #define TCG_CT_CONST_MONE 0x2000
> #define TCG_CT_CONST_WSZ  0x4000
>
> -static tcg_insn_unit *tb_ret_addr;
> +static const tcg_insn_unit *tb_ret_addr;
>
> TCGPowerISA have_isa;
> static bool have_isel;
> @@ -184,35 +184,43 @@ static inline bool in_range_b(tcg_target_long target)
>     return target == sextract64(target, 0, 26);
> }
>
> -static uint32_t reloc_pc24_val(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static uint32_t reloc_pc24_val(const tcg_insn_unit *pc,
> +                               const tcg_insn_unit *target)
> {
>     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
>     tcg_debug_assert(in_range_b(disp));
>     return disp & 0x3fffffc;
> }
>
> -static bool reloc_pc24(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static bool reloc_pc24(TCGContext *s,
> +                       tcg_insn_unit *pc,
> +                       const tcg_insn_unit *target)
> {
>     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
>     if (in_range_b(disp)) {
> -        *pc = (*pc & ~0x3fffffc) | (disp & 0x3fffffc);
> +        *TCG_CODE_PTR_RW(s, pc) =
> +            (*TCG_CODE_PTR_RW(s, pc) & ~0x3fffffc) | (disp & 0x3fffffc);
>         return true;
>     }
>     return false;
> }
>
> -static uint16_t reloc_pc14_val(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static uint16_t reloc_pc14_val(const tcg_insn_unit *pc,
> +                               const tcg_insn_unit *target)
> {
>     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
>     tcg_debug_assert(disp == (int16_t) disp);
>     return disp & 0xfffc;
> }
>
> -static bool reloc_pc14(tcg_insn_unit *pc, tcg_insn_unit *target)
> +static bool reloc_pc14(TCGContext *s,
> +                       tcg_insn_unit *pc,
> +                       const tcg_insn_unit *target)
> {
>     ptrdiff_t disp = tcg_ptr_byte_diff(target, pc);
>     if (disp == (int16_t) disp) {
> -        *pc = (*pc & ~0xfffc) | (disp & 0xfffc);
> +        *TCG_CODE_PTR_RW(s, pc) =
> +            (*TCG_CODE_PTR_RW(s, pc) & ~0xfffc) | (disp & 0xfffc);
>         return true;
>     }
>     return false;
> @@ -670,7 +678,7 @@ static const uint32_t tcg_to_isel[] = {
>     [TCG_COND_GTU] = ISEL | BC_(7, CR_GT),
> };
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     tcg_insn_unit *target;
> @@ -682,9 +690,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>
>     switch (type) {
>     case R_PPC_REL14:
> -        return reloc_pc14(code_ptr, target);
> +        return reloc_pc14(s, code_ptr, target);
>     case R_PPC_REL24:
> -        return reloc_pc24(code_ptr, target);
> +        return reloc_pc24(s, code_ptr, target);
>     case R_PPC_ADDR16:
>         /*
>          * We are (slightly) abusing this relocation type.  In particular,
> @@ -1106,7 +1114,7 @@ static void tcg_out_xori32(TCGContext *s, TCGReg dst, TCGReg src, uint32_t c)
>     tcg_out_zori32(s, dst, src, c, XORI, XORIS);
> }
>
> -static void tcg_out_b(TCGContext *s, int mask, tcg_insn_unit *target)
> +static void tcg_out_b(TCGContext *s, int mask, const tcg_insn_unit *target)
> {
>     ptrdiff_t disp = tcg_pcrel_diff(s, target);
>     if (in_range_b(disp)) {
> @@ -1723,7 +1731,7 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
> }
>
> void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
> -                              uintptr_t addr)
> +                              uintptr_t addr, uintptr_t wr_addr)
> {
>     if (TCG_TARGET_REG_BITS == 64) {
>         tcg_insn_unit i1, i2;
> @@ -1752,17 +1760,23 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>
>         /* As per the enclosing if, this is ppc64.  Avoid the _Static_assert
>            within qatomic_set that would fail to build a ppc32 host.  */
> -        qatomic_set__nocheck((uint64_t *)jmp_addr, pair);
> +        qatomic_set__nocheck((uint64_t *)wr_addr, pair);
> +#if defined(CONFIG_IOS_JIT)
> +        flush_dcache_range(wr_addr, wr_addr + 8);
> +#endif
>         flush_icache_range(jmp_addr, jmp_addr + 8);
>     } else {
>         intptr_t diff = addr - jmp_addr;
>         tcg_debug_assert(in_range_b(diff));
> -        qatomic_set((uint32_t *)jmp_addr, B | (diff & 0x3fffffc));
> +        qatomic_set((uint32_t *)wr_addr, B | (diff & 0x3fffffc));
> +#if defined(CONFIG_IOS_JIT)
> +        flush_dcache_range(wr_addr, wr_addr + 8);
> +#endif
>         flush_icache_range(jmp_addr, jmp_addr + 4);
>     }
> }
>
> -static void tcg_out_call(TCGContext *s, tcg_insn_unit *target)
> +static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target)
> {
> #ifdef _CALL_AIX
>     /* Look through the descriptor.  If the branch is in range, and we
> @@ -1987,7 +2001,8 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, MemOp opc,
> static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
>                                 TCGReg datalo_reg, TCGReg datahi_reg,
>                                 TCGReg addrlo_reg, TCGReg addrhi_reg,
> -                                tcg_insn_unit *raddr, tcg_insn_unit *lptr)
> +                                const tcg_insn_unit *raddr,
> +                                tcg_insn_unit *lptr)
> {
>     TCGLabelQemuLdst *label = new_ldst_label(s);
>
> @@ -2007,7 +2022,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     MemOp opc = get_memop(oi);
>     TCGReg hi, lo, arg = TCG_REG_R3;
>
> -    if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
> +    if (!reloc_pc14(s, lb->label_ptr[0], s->code_ptr)) {
>         return false;
>     }
>
> @@ -2055,7 +2070,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     MemOp s_bits = opc & MO_SIZE;
>     TCGReg hi, lo, arg = TCG_REG_R3;
>
> -    if (!reloc_pc14(lb->label_ptr[0], s->code_ptr)) {
> +    if (!reloc_pc14(s, lb->label_ptr[0], s->code_ptr)) {
>         return false;
>     }
>
> @@ -2252,11 +2267,11 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
> #endif
> }
>
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count)
> {
>     int i;
>     for (i = 0; i < count; ++i) {
> -        p[i] = NOP;
> +        (TCG_CODE_PTR_RW(s, p))[i] = NOP;
>     }
> }
>
> diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
> index be10363956..23d7a337c9 100644
> --- a/tcg/ppc/tcg-target.h
> +++ b/tcg/ppc/tcg-target.h
> @@ -176,7 +176,13 @@ extern bool have_vsx;
> #define TCG_TARGET_HAS_cmpsel_vec       0
>
> void flush_icache_range(uintptr_t start, uintptr_t stop);
> -void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> +void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#error "Unimplemented dcache flush function"
> +}
> +#endif
>
> #define TCG_TARGET_DEFAULT_MO (0)
> #define TCG_TARGET_HAS_MEMORY_BSWAP     1
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index d536f3ccc1..2d96c83c4b 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -413,11 +413,11 @@ static void tcg_out_opc_jump(TCGContext *s, RISCVInsn opc,
>     tcg_out32(s, encode_uj(opc, rd, imm));
> }
>
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count)
> {
>     int i;
>     for (i = 0; i < count; ++i) {
> -        p[i] = encode_i(OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
> +        (TCG_CODE_PTR_RW(s, p))[i] = encode_i(OPC_ADDI, TCG_REG_ZERO, TCG_REG_ZERO, 0);
>     }
> }
>
> @@ -425,46 +425,52 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
>  * Relocations
>  */
>
> -static bool reloc_sbimm12(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +static bool reloc_sbimm12(TCGContext *s,
> +                          tcg_insn_unit *code_ptr,
> +                          const tcg_insn_unit *target)
> {
>     intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
>
>     if (offset == sextreg(offset, 1, 12) << 1) {
> -        code_ptr[0] |= encode_sbimm12(offset);
> +        (TCG_CODE_PTR_RW(s, code_ptr))[0] |= encode_sbimm12(offset);
>         return true;
>     }
>
>     return false;
> }
>
> -static bool reloc_jimm20(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +static bool reloc_jimm20(TCGContext *s,
> +                         tcg_insn_unit *code_ptr,
> +                         const tcg_insn_unit *target)
> {
>     intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
>
>     if (offset == sextreg(offset, 1, 20) << 1) {
> -        code_ptr[0] |= encode_ujimm20(offset);
> +        (TCG_CODE_PTR_RW(s, code_ptr))[0] |= encode_ujimm20(offset);
>         return true;
>     }
>
>     return false;
> }
>
> -static bool reloc_call(tcg_insn_unit *code_ptr, tcg_insn_unit *target)
> +static bool reloc_call(TCGContext *s,
> +                       tcg_insn_unit *code_ptr,
> +                       const tcg_insn_unit *target)
> {
>     intptr_t offset = (intptr_t)target - (intptr_t)code_ptr;
>     int32_t lo = sextreg(offset, 0, 12);
>     int32_t hi = offset - lo;
>
>     if (offset == hi + lo) {
> -        code_ptr[0] |= encode_uimm20(hi);
> -        code_ptr[1] |= encode_imm12(lo);
> +        (TCG_CODE_PTR_RW(s, code_ptr))[0] |= encode_uimm20(hi);
> +        (TCG_CODE_PTR_RW(s, code_ptr))[1] |= encode_imm12(lo);
>         return true;
>     }
>
>     return false;
> }
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     uint32_t insn = *code_ptr;
> @@ -478,7 +484,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>         diff = value - (uintptr_t)code_ptr;
>         short_jmp = diff == sextreg(diff, 0, 12);
>         if (short_jmp) {
> -            return reloc_sbimm12(code_ptr, (tcg_insn_unit *)value);
> +            return reloc_sbimm12(s, code_ptr, (tcg_insn_unit *)value);
>         } else {
>             /* Invert the condition */
>             insn = insn ^ (1 << 12);
> @@ -499,9 +505,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>         }
>         break;
>     case R_RISCV_JAL:
> -        return reloc_jimm20(code_ptr, (tcg_insn_unit *)value);
> +        return reloc_jimm20(s, code_ptr, (tcg_insn_unit *)value);
>     case R_RISCV_CALL:
> -        return reloc_call(code_ptr, (tcg_insn_unit *)value);
> +        return reloc_call(s, code_ptr, (tcg_insn_unit *)value);
>     default:
>         tcg_abort();
>     }
> @@ -557,7 +563,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
>     if (tmp == (int32_t)tmp) {
>         tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
>         tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
> -        ret = reloc_call(s->code_ptr - 2, (tcg_insn_unit *)val);
> +        ret = reloc_call(s, s->code_ptr - 2, (tcg_insn_unit *)val);
>         tcg_debug_assert(ret == true);
>         return;
>     }
> @@ -854,14 +860,14 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
>     g_assert_not_reached();
> }
>
> -static inline void tcg_out_goto(TCGContext *s, tcg_insn_unit *target)
> +static inline void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
> {
>     ptrdiff_t offset = tcg_pcrel_diff(s, target);
>     tcg_debug_assert(offset == sextreg(offset, 1, 20) << 1);
>     tcg_out_opc_jump(s, OPC_JAL, TCG_REG_ZERO, offset);
> }
>
> -static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
> +static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
> {
>     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
>     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
> @@ -875,7 +881,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
>         /* long jump: -2147483646 to 2147483648 */
>         tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
>         tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
> -        ret = reloc_call(s->code_ptr - 2, arg);\
> +        ret = reloc_call(s, s->code_ptr - 2, arg);\
>         tcg_debug_assert(ret == true);
>     } else if (TCG_TARGET_REG_BITS == 64) {
>         /* far jump: 64-bit */
> @@ -888,7 +894,7 @@ static void tcg_out_call_int(TCGContext *s, tcg_insn_unit *arg, bool tail)
>     }
> }
>
> -static void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
> +static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
> {
>     tcg_out_call_int(s, arg, false);
> }
> @@ -1022,7 +1028,8 @@ static void add_qemu_ldst_label(TCGContext *s, int is_ld, TCGMemOpIdx oi,
>                                 TCGType ext,
>                                 TCGReg datalo, TCGReg datahi,
>                                 TCGReg addrlo, TCGReg addrhi,
> -                                void *raddr, tcg_insn_unit **label_ptr)
> +                                const tcg_insn_unit *raddr,
> +                                tcg_insn_unit **label_ptr)
> {
>     TCGLabelQemuLdst *label = new_ldst_label(s);
>
> @@ -1052,7 +1059,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
>     }
>
>     /* resolve label address */
> -    if (!patch_reloc(l->label_ptr[0], R_RISCV_BRANCH,
> +    if (!patch_reloc(s, l->label_ptr[0], R_RISCV_BRANCH,
>                      (intptr_t) s->code_ptr, 0)) {
>         return false;
>     }
> @@ -1087,7 +1094,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
>     }
>
>     /* resolve label address */
> -    if (!patch_reloc(l->label_ptr[0], R_RISCV_BRANCH,
> +    if (!patch_reloc(s, l->label_ptr[0], R_RISCV_BRANCH,
>                      (intptr_t) s->code_ptr, 0)) {
>         return false;
>     }
> @@ -1274,7 +1281,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is_64)
> #endif
> }
>
> -static tcg_insn_unit *tb_ret_addr;
> +static const tcg_insn_unit *tb_ret_addr;
>
> static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>                        const TCGArg *args, const int *const_args)
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 032439d806..d42b361991 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -164,8 +164,15 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>     __builtin___clear_cache((char *)start, (char *)stop);
> }
>
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#error "Unimplemented dcache flush function"
> +}
> +#endif
> +
> /* not defined -- call should be eliminated at compile time */
> -void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> +void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
>
> #define TCG_TARGET_DEFAULT_MO (0)
>
> diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
> index c5e096449b..49a96ca15f 100644
> --- a/tcg/s390/tcg-target.c.inc
> +++ b/tcg/s390/tcg-target.c.inc
> @@ -363,10 +363,10 @@ static void * const qemu_st_helpers[16] = {
> };
> #endif
>
> -static tcg_insn_unit *tb_ret_addr;
> +static const tcg_insn_unit *tb_ret_addr;
> uint64_t s390_facilities;
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     intptr_t pcrel2;
> @@ -378,13 +378,13 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>     switch (type) {
>     case R_390_PC16DBL:
>         if (pcrel2 == (int16_t)pcrel2) {
> -            tcg_patch16(code_ptr, pcrel2);
> +            tcg_patch16(s, code_ptr, pcrel2);
>             return true;
>         }
>         break;
>     case R_390_PC32DBL:
>         if (pcrel2 == (int32_t)pcrel2) {
> -            tcg_patch32(code_ptr, pcrel2);
> +            tcg_patch32(s, code_ptr, pcrel2);
>             return true;
>         }
>         break;
> @@ -392,7 +392,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>         if (value == sextract64(value, 0, 20)) {
>             old = *(uint32_t *)code_ptr & 0xf00000ff;
>             old |= ((value & 0xfff) << 16) | ((value & 0xff000) >> 4);
> -            tcg_patch32(code_ptr, old);
> +            tcg_patch32(s, code_ptr, old);
>             return true;
>         }
>         break;
> @@ -1302,7 +1302,7 @@ static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
>     tcg_out_risbg(s, dest, src, 64 - len, 63, 64 - ofs, 1);
> }
>
> -static void tgen_gotoi(TCGContext *s, int cc, tcg_insn_unit *dest)
> +static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
> {
>     ptrdiff_t off = dest - s->code_ptr;
>     if (off == (int16_t)off) {
> @@ -1415,7 +1415,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
>     tgen_branch(s, cc, l);
> }
>
> -static void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
> +static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
> {
>     ptrdiff_t off = dest - s->code_ptr;
>     if (off == (int32_t)off) {
> @@ -1593,7 +1593,8 @@ static TCGReg tcg_out_tlb_read(TCGContext *s, TCGReg addr_reg, MemOp opc,
>
> static void add_qemu_ldst_label(TCGContext *s, bool is_ld, TCGMemOpIdx oi,
>                                 TCGReg data, TCGReg addr,
> -                                tcg_insn_unit *raddr, tcg_insn_unit *label_ptr)
> +                                const tcg_insn_unit *raddr,
> +                                tcg_insn_unit *label_ptr)
> {
>     TCGLabelQemuLdst *label = new_ldst_label(s);
>
> @@ -1612,7 +1613,7 @@ static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     TCGMemOpIdx oi = lb->oi;
>     MemOp opc = get_memop(oi);
>
> -    if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
> +    if (!patch_reloc(s, lb->label_ptr[0], R_390_PC16DBL,
>                      (intptr_t)s->code_ptr, 2)) {
>         return false;
>     }
> @@ -1637,7 +1638,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
>     TCGMemOpIdx oi = lb->oi;
>     MemOp opc = get_memop(oi);
>
> -    if (!patch_reloc(lb->label_ptr[0], R_390_PC16DBL,
> +    if (!patch_reloc(s, lb->label_ptr[0], R_390_PC16DBL,
>                      (intptr_t)s->code_ptr, 2)) {
>         return false;
>     }
> @@ -2575,9 +2576,9 @@ static void tcg_target_qemu_prologue(TCGContext *s)
>     tcg_out_insn(s, RR, BCR, S390_CC_ALWAYS, TCG_REG_R14);
> }
>
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count)
> {
> -    memset(p, 0x07, count * sizeof(tcg_insn_unit));
> +    memset(TCG_CODE_PTR_RW(s, p), 0x07, count * sizeof(tcg_insn_unit));
> }
>
> typedef struct {
> diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
> index 63c8797bd3..d67632512d 100644
> --- a/tcg/s390/tcg-target.h
> +++ b/tcg/s390/tcg-target.h
> @@ -149,13 +149,24 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> {
> }
>
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#error "Unimplemented dcache flush function"
> +}
> +#endif
> +
> static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
> -                                            uintptr_t jmp_addr, uintptr_t addr)
> +                                            uintptr_t jmp_addr, uintptr_t addr,
> +                                            uintptr_t wr_addr)
> {
>     /* patch the branch destination */
>     intptr_t disp = addr - (jmp_addr - 2);
>     qatomic_set((int32_t *)jmp_addr, disp / 2);
>     /* no need to flush icache explicitly */
> +#if defined(CONFIG_IOS_JIT)
> +    flush_dcache_range(wr_addr, wr_addr + 4);
> +#endif
> }
>
> #ifdef CONFIG_SOFTMMU
> diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
> index 6775bd30fc..af97cbdeef 100644
> --- a/tcg/sparc/tcg-target.c.inc
> +++ b/tcg/sparc/tcg-target.c.inc
> @@ -291,14 +291,14 @@ static inline int check_fit_i32(int32_t val, unsigned int bits)
> # define check_fit_ptr  check_fit_i32
> #endif
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     uint32_t insn = *code_ptr;
>     intptr_t pcrel;
>
>     value += addend;
> -    pcrel = tcg_ptr_byte_diff((tcg_insn_unit *)value, code_ptr);
> +    pcrel = tcg_ptr_byte_diff((const tcg_insn_unit *)value, code_ptr);
>
>     switch (type) {
>     case R_SPARC_WDISP16:
> @@ -840,7 +840,7 @@ static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
>     tcg_out_mov(s, TCG_TYPE_I64, rl, tmp);
> }
>
> -static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest,
> +static void tcg_out_call_nodelay(TCGContext *s, const tcg_insn_unit *dest,
>                                  bool in_prologue)
> {
>     ptrdiff_t disp = tcg_pcrel_diff(s, dest);
> @@ -855,7 +855,7 @@ static void tcg_out_call_nodelay(TCGContext *s, tcg_insn_unit *dest,
>     }
> }
>
> -static void tcg_out_call(TCGContext *s, tcg_insn_unit *dest)
> +static void tcg_out_call(TCGContext *s, const tcg_insn_unit *dest)
> {
>     tcg_out_call_nodelay(s, dest, false);
>     tcg_out_nop(s);
> @@ -868,8 +868,8 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
> }
>
> #ifdef CONFIG_SOFTMMU
> -static tcg_insn_unit *qemu_ld_trampoline[16];
> -static tcg_insn_unit *qemu_st_trampoline[16];
> +static const tcg_insn_unit *qemu_ld_trampoline[16];
> +static const tcg_insn_unit *qemu_st_trampoline[16];
>
> static void emit_extend(TCGContext *s, TCGReg r, int op)
> {
> @@ -1048,11 +1048,11 @@ static void tcg_target_qemu_prologue(TCGContext *s)
> #endif
> }
>
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count)
> {
>     int i;
>     for (i = 0; i < count; ++i) {
> -        p[i] = NOP;
> +        (TCG_CODE_PTR_RW(s, p))[i] = NOP;
>     }
> }
>
> @@ -1163,7 +1163,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
> #ifdef CONFIG_SOFTMMU
>     unsigned memi = get_mmuidx(oi);
>     TCGReg addrz, param;
> -    tcg_insn_unit *func;
> +    const tcg_insn_unit *func;
>     tcg_insn_unit *label_ptr;
>
>     addrz = tcg_out_tlb_load(s, addr, memi, memop,
> @@ -1226,7 +1226,8 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
>         }
>     }
>
> -    *label_ptr |= INSN_OFF19(tcg_ptr_byte_diff(s->code_ptr, label_ptr));
> +    *TCG_CODE_PTR_RW(s, label_ptr) |=
> +        INSN_OFF19(tcg_ptr_byte_diff(s->code_ptr, label_ptr));
> #else
>     if (SPARC64 && TARGET_LONG_BITS == 32) {
>         tcg_out_arithi(s, TCG_REG_T1, addr, 0, SHIFT_SRL);
> @@ -1822,7 +1823,7 @@ void tcg_register_jit(void *buf, size_t buf_size)
> }
>
> void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
> -                              uintptr_t addr)
> +                              uintptr_t addr, uintptr_t wr_addr)
> {
>     intptr_t tb_disp = addr - tc_ptr;
>     intptr_t br_disp = addr - jmp_addr;
> @@ -1834,8 +1835,11 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>     tcg_debug_assert(br_disp == (int32_t)br_disp);
>
>     if (!USE_REG_TB) {
> -        qatomic_set((uint32_t *)jmp_addr,
> +        qatomic_set((uint32_t *)wr_addr,
> 		    deposit32(CALL, 0, 30, br_disp >> 2));
> +#if defined(CONFIG_IOS_JIT)
> +        flush_dcache_range(wr_addr, wr_addr + 4);
> +#endif
>         flush_icache_range(jmp_addr, jmp_addr + 4);
>         return;
>     }
> @@ -1859,6 +1863,9 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>               | INSN_IMM13((tb_disp & 0x3ff) | -0x400));
>     }
>
> -    qatomic_set((uint64_t *)jmp_addr, deposit64(i2, 32, 32, i1));
> +    qatomic_set((uint64_t *)wr_addr, deposit64(i2, 32, 32, i1));
> +#if defined(CONFIG_IOS_JIT)
> +    flush_dcache_range(wr_addr, wr_addr + 8);
> +#endif
>     flush_icache_range(jmp_addr, jmp_addr + 8);
> }
> diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
> index 633841ebf2..d102e13692 100644
> --- a/tcg/sparc/tcg-target.h
> +++ b/tcg/sparc/tcg-target.h
> @@ -176,7 +176,13 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
>     }
> }
>
> -void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> +void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +#error "Unimplemented dcache flush function"
> +}
> +#endif
>
> #define TCG_TARGET_NEED_POOL_LABELS
>
> diff --git a/tcg/tcg-ldst.c.inc b/tcg/tcg-ldst.c.inc
> index 05f9b3ccd6..eaba08700e 100644
> --- a/tcg/tcg-ldst.c.inc
> +++ b/tcg/tcg-ldst.c.inc
> @@ -28,7 +28,7 @@ typedef struct TCGLabelQemuLdst {
>     TCGReg addrhi_reg;      /* reg index for high word of guest virtual addr */
>     TCGReg datalo_reg;      /* reg index for low word to be loaded or stored */
>     TCGReg datahi_reg;      /* reg index for high word to be loaded or stored */
> -    tcg_insn_unit *raddr;   /* gen code addr of the next IR of qemu_ld/st IR */
> +    const tcg_insn_unit *raddr; /* gen code addr of the next IR of qemu_ld/st */
>     tcg_insn_unit *label_ptr[2]; /* label pointers to be updated */
>     QSIMPLEQ_ENTRY(TCGLabelQemuLdst) next;
> } TCGLabelQemuLdst;
> diff --git a/tcg/tcg-pool.c.inc b/tcg/tcg-pool.c.inc
> index 82cbcc89bd..97bb90b7cc 100644
> --- a/tcg/tcg-pool.c.inc
> +++ b/tcg/tcg-pool.c.inc
> @@ -119,7 +119,7 @@ static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
> }
>
> /* To be provided by cpu/tcg-target.c.inc.  */
> -static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
> +static void tcg_out_nop_fill(TCGContext *s, tcg_insn_unit *p, int count);
>
> static int tcg_out_pool_finalize(TCGContext *s)
> {
> @@ -135,7 +135,7 @@ static int tcg_out_pool_finalize(TCGContext *s)
>        again when allocating the next TranslationBlock structure.  */
>     a = (void *)ROUND_UP((uintptr_t)s->code_ptr,
>                          sizeof(tcg_target_ulong) * p->nlong);
> -    tcg_out_nop_fill(s->code_ptr, (tcg_insn_unit *)a - s->code_ptr);
> +    tcg_out_nop_fill(s, s->code_ptr, (tcg_insn_unit *)a - s->code_ptr);
>     s->data_gen_ptr = a;
>
>     for (; p != NULL; p = p->next) {
> @@ -144,11 +144,12 @@ static int tcg_out_pool_finalize(TCGContext *s)
>             if (unlikely(a > s->code_gen_highwater)) {
>                 return -1;
>             }
> -            memcpy(a, p->data, size);
> +            memcpy(TCG_CODE_PTR_RW(s, a), p->data, size);
>             a += size;
>             l = p;
>         }
> -        if (!patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend)) {
> +        if (!patch_reloc(s, p->label, p->rtype,
> +                         (intptr_t)a - size, p->addend)) {
>             return -2;
>         }
>     }
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index a8c28440e2..ef203a34a6 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -70,7 +70,7 @@
> static void tcg_target_init(TCGContext *s);
> static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode);
> static void tcg_target_qemu_prologue(TCGContext *s);
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend);
>
> /* The CIE and FDE header definitions will be common to all hosts.  */
> @@ -148,7 +148,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
>                        intptr_t arg2);
> static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
>                         TCGReg base, intptr_t ofs);
> -static void tcg_out_call(TCGContext *s, tcg_insn_unit *target);
> +static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target);
> static int tcg_target_const_match(tcg_target_long val, TCGType type,
>                                   const TCGArgConstraint *arg_ct);
> #ifdef TCG_TARGET_NEED_LDST_LABELS
> @@ -203,13 +203,15 @@ static TCGRegSet tcg_target_call_clobber_regs;
> #if TCG_TARGET_INSN_UNIT_SIZE == 1
> static __attribute__((unused)) inline void tcg_out8(TCGContext *s, uint8_t v)
> {
> -    *s->code_ptr++ = v;
> +    *TCG_CODE_PTR_RW(s, s->code_ptr) = v;
> +    s->code_ptr++;
> }
>
> -static __attribute__((unused)) inline void tcg_patch8(tcg_insn_unit *p,
> +static __attribute__((unused)) inline void tcg_patch8(TCGContext *s,
> +                                                      tcg_insn_unit *p,
>                                                       uint8_t v)
> {
> -    *p = v;
> +    *TCG_CODE_PTR_RW(s, p) = v;
> }
> #endif
>
> @@ -217,21 +219,23 @@ static __attribute__((unused)) inline void tcg_patch8(tcg_insn_unit *p,
> static __attribute__((unused)) inline void tcg_out16(TCGContext *s, uint16_t v)
> {
>     if (TCG_TARGET_INSN_UNIT_SIZE == 2) {
> -        *s->code_ptr++ = v;
> +        *TCG_CODE_PTR_RW(s, s->code_ptr) = v;
> +        s->code_ptr++;
>     } else {
>         tcg_insn_unit *p = s->code_ptr;
> -        memcpy(p, &v, sizeof(v));
> +        memcpy(TCG_CODE_PTR_RW(s, p), &v, sizeof(v));
>         s->code_ptr = p + (2 / TCG_TARGET_INSN_UNIT_SIZE);
>     }
> }
>
> -static __attribute__((unused)) inline void tcg_patch16(tcg_insn_unit *p,
> +static __attribute__((unused)) inline void tcg_patch16(TCGContext *s,
> +                                                       tcg_insn_unit *p,
>                                                        uint16_t v)
> {
>     if (TCG_TARGET_INSN_UNIT_SIZE == 2) {
> -        *p = v;
> +        *TCG_CODE_PTR_RW(s, p) = v;
>     } else {
> -        memcpy(p, &v, sizeof(v));
> +        memcpy(TCG_CODE_PTR_RW(s, p), &v, sizeof(v));
>     }
> }
> #endif
> @@ -240,21 +244,23 @@ static __attribute__((unused)) inline void tcg_patch16(tcg_insn_unit *p,
> static __attribute__((unused)) inline void tcg_out32(TCGContext *s, uint32_t v)
> {
>     if (TCG_TARGET_INSN_UNIT_SIZE == 4) {
> -        *s->code_ptr++ = v;
> +        *TCG_CODE_PTR_RW(s, s->code_ptr) = v;
> +        s->code_ptr++;
>     } else {
>         tcg_insn_unit *p = s->code_ptr;
> -        memcpy(p, &v, sizeof(v));
> +        memcpy(TCG_CODE_PTR_RW(s, p), &v, sizeof(v));
>         s->code_ptr = p + (4 / TCG_TARGET_INSN_UNIT_SIZE);
>     }
> }
>
> -static __attribute__((unused)) inline void tcg_patch32(tcg_insn_unit *p,
> +static __attribute__((unused)) inline void tcg_patch32(TCGContext *s,
> +                                                       tcg_insn_unit *p,
>                                                        uint32_t v)
> {
>     if (TCG_TARGET_INSN_UNIT_SIZE == 4) {
>         *p = v;
>     } else {
> -        memcpy(p, &v, sizeof(v));
> +        memcpy(TCG_CODE_PTR_RW(s, p), &v, sizeof(v));
>     }
> }
> #endif
> @@ -263,21 +269,23 @@ static __attribute__((unused)) inline void tcg_patch32(tcg_insn_unit *p,
> static __attribute__((unused)) inline void tcg_out64(TCGContext *s, uint64_t v)
> {
>     if (TCG_TARGET_INSN_UNIT_SIZE == 8) {
> -        *s->code_ptr++ = v;
> +        *TCG_CODE_PTR_RW(s, s->code_ptr) = v;
> +        s->code_ptr++;
>     } else {
>         tcg_insn_unit *p = s->code_ptr;
> -        memcpy(p, &v, sizeof(v));
> +        memcpy(TCG_CODE_PTR_RW(s, p), &v, sizeof(v));
>         s->code_ptr = p + (8 / TCG_TARGET_INSN_UNIT_SIZE);
>     }
> }
>
> -static __attribute__((unused)) inline void tcg_patch64(tcg_insn_unit *p,
> +static __attribute__((unused)) inline void tcg_patch64(TCGContext *s,
> +                                                       tcg_insn_unit *p,
>                                                        uint64_t v)
> {
>     if (TCG_TARGET_INSN_UNIT_SIZE == 8) {
>         *p = v;
>     } else {
> -        memcpy(p, &v, sizeof(v));
> +        memcpy(TCG_CODE_PTR_RW(s, p), &v, sizeof(v));
>     }
> }
> #endif
> @@ -295,7 +303,7 @@ static void tcg_out_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>     QSIMPLEQ_INSERT_TAIL(&l->relocs, r, next);
> }
>
> -static void tcg_out_label(TCGContext *s, TCGLabel *l, tcg_insn_unit *ptr)
> +static void tcg_out_label(TCGContext *s, TCGLabel *l, const tcg_insn_unit *ptr)
> {
>     tcg_debug_assert(!l->has_value);
>     l->has_value = 1;
> @@ -325,7 +333,7 @@ static bool tcg_resolve_relocs(TCGContext *s)
>         uintptr_t value = l->u.value;
>
>         QSIMPLEQ_FOREACH(r, &l->relocs, next) {
> -            if (!patch_reloc(r->ptr, r->type, value, r->addend)) {
> +            if (!patch_reloc(s, r->ptr, r->type, value, r->addend)) {
>                 return false;
>             }
>         }
> @@ -1039,7 +1047,7 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
>     }
>     qatomic_set(&s->code_gen_ptr, next);
>     s->data_gen_ptr = NULL;
> -    return tb;
> +    return (TranslationBlock *)TCG_CODE_PTR_RW(s, tb);
> }
>
> void tcg_prologue_init(TCGContext *s)
> @@ -1076,6 +1084,10 @@ void tcg_prologue_init(TCGContext *s)
> #endif
>
>     buf1 = s->code_ptr;
> +#if defined(CONFIG_IOS_JIT)
> +    flush_dcache_range((uintptr_t)TCG_CODE_PTR_RW(s, buf0),
> +                       (uintptr_t)TCG_CODE_PTR_RW(s, buf1));
> +#endif
>     flush_icache_range((uintptr_t)buf0, (uintptr_t)buf1);
>
>     /* Deduct the prologue from the buffer.  */
> @@ -4267,6 +4279,12 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>         return -2;
>     }
>
> +#if defined(CONFIG_IOS_JIT)
> +    /* flush data cache on mirror */
> +    flush_dcache_range((uintptr_t)TCG_CODE_PTR_RW(s, s->code_buf),
> +                       (uintptr_t)TCG_CODE_PTR_RW(s, s->code_ptr));
> +#endif
> +
>     /* flush instruction cache */
>     flush_icache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_ptr);
>
> diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
> index 231b9b1775..133213be3a 100644
> --- a/tcg/tci/tcg-target.c.inc
> +++ b/tcg/tci/tcg-target.c.inc
> @@ -369,7 +369,7 @@ static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
> };
> #endif
>
> -static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(TCGContext *s, tcg_insn_unit *code_ptr, int type,
>                         intptr_t value, intptr_t addend)
> {
>     /* tcg_out_reloc always uses the same type, addend. */
> @@ -377,9 +377,9 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>     tcg_debug_assert(addend == 0);
>     tcg_debug_assert(value != 0);
>     if (TCG_TARGET_REG_BITS == 32) {
> -        tcg_patch32(code_ptr, value);
> +        tcg_patch32(s, code_ptr, value);
>     } else {
> -        tcg_patch64(code_ptr, value);
> +        tcg_patch64(s, code_ptr, value);
>     }
>     return true;
> }
> @@ -545,7 +545,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type,
>     old_code_ptr[1] = s->code_ptr - old_code_ptr;
> }
>
> -static inline void tcg_out_call(TCGContext *s, tcg_insn_unit *arg)
> +static inline void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg)
> {
>     uint8_t *old_code_ptr = s->code_ptr;
>     tcg_out_op_t(s, INDEX_op_call);
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 8c1c1d265d..2a258ea350 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -195,6 +195,12 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> {
> }
>
> +#if defined(CONFIG_IOS_JIT)
> +static inline void flush_dcache_range(uintptr_t start, uintptr_t stop)
> +{
> +}
> +#endif
> +
> /* We could notice __i386__ or __s390x__ and reduce the barriers depending
>    on the host.  But if you want performance, you use the normal backend.
>    We prefer consistency across hosts on this.  */
> @@ -203,7 +209,8 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> #define TCG_TARGET_HAS_MEMORY_BSWAP     1
>
> static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
> -                                            uintptr_t jmp_addr, uintptr_t addr)
> +                                            uintptr_t jmp_addr, uintptr_t addr,
> +                                            uintptr_t wr_addr)
> {
>     /* patch the branch destination */
>     qatomic_set((int32_t *)jmp_addr, addr - (jmp_addr + 4));
>

