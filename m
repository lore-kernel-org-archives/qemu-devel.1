Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938D5C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4682177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+d7hIgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4682177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnQc-0005hv-5i
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:05:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnOV-00044q-CG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnOT-0003zL-1c
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:03:47 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnOS-0003xC-5R
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:03:44 -0400
Received: by mail-lf1-x142.google.com with SMTP id h13so2219417lfc.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=v6D+T4euMpN62Rftn4M7kHWyMMDA8fn9qj/P03x2Gn4=;
	b=C+d7hIgyr+MoCAzPtpumteJbrkwcM/rxtHkud0WpgorbQg0zbm2q6bt6XbVgpyzviK
	fbwyHAIGXc4OsCAKp1uiOCeB8JeQLYNYTz61ZTP7ZEUvF+lb4hzTPJXXkM+JKNLo50dY
	IHFR5C9vud2uanPeETuWmpWAy32SHvZtNU60EabZdLhvzpw9zcIqvpICzIMuEd/uw3rw
	91TrxCtk7mCsGBU5PtZYKi1Ou1TwUIJ1cdDXsgFSNR+24zjI22WBuR1a57jCahWecxDM
	bT5LM9ek/Hu6ClK/ZT1eoxeiCtXb48VklMBfs8LGX17Y0brxsioVUbXDyb0sYOW2Fis4
	VCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=v6D+T4euMpN62Rftn4M7kHWyMMDA8fn9qj/P03x2Gn4=;
	b=MVuKTLVzbakRDnoP087NziPxwk8rI7yD/y80XvlW4a0Cf1mO0Sgk1Fgp7zNBTEx9aF
	J+iDwTBNNsKByedKvXYduTQioPStM6/vwmk5yDIc5ywvzlerj8mFQsulR/vXqZidZiv2
	BUVZvDCDe6z7TVWRC2NEKhU03C+fxQyRO5EfEhDb1RhbwVHqwVtuGYH6dQ2naTbn2dXk
	V3SqrwP0CTMoHwKcBAGpyli8EMeE7RDDwAJW/ypqde2Wpomw1H6xtnVTpVkoqVRaMpeg
	WpDinjgp2KB3lPSb3nf+xtaAd8HaqoXohE1Dp86POiPZgXstI+PNwaF1Z+DOgY9zUagU
	nWLg==
X-Gm-Message-State: APjAAAWRo3R0aUJgFBEkfkY2zX1c3paq0JMH3g6mwheC0b4GwUcP6CVg
	guld6A5IJOwWrkJPN5cWYfQMqX8f72uoVPpacXRY6lNq
X-Google-Smtp-Source: APXvYqxOd8gisiPYw6jdTXoS/eMo8NNwIHimSqOqNStsZ7Z/5j0g9FoSrYIfqEsgVZhrcaJRhktF3oJDBu5GV1ltypE=
X-Received: by 2002:a19:a40f:: with SMTP id q15mr3005372lfc.121.1557425021142; 
	Thu, 09 May 2019 11:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-11-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-11-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:01:32 -0700
Message-ID: <CAKmqyKNTN1i2hL3EZZ6XcfHMSWjf4GpQg6fNOffubworn=6uiA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v3 10/39] target/cris: Reindent mmu.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:13 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fix all of the coding style errors in this file at once.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/cris/mmu.c | 479 +++++++++++++++++++++++-----------------------
>  1 file changed, 237 insertions(+), 242 deletions(-)
>
> diff --git a/target/cris/mmu.c b/target/cris/mmu.c
> index b8db908823..9cb73bbfec 100644
> --- a/target/cris/mmu.c
> +++ b/target/cris/mmu.c
> @@ -33,96 +33,99 @@
>
>  void cris_mmu_init(CPUCRISState *env)
>  {
> -       env->mmu_rand_lfsr = 0xcccc;
> +    env->mmu_rand_lfsr = 0xcccc;
>  }
>
>  #define SR_POLYNOM 0x8805
>  static inline unsigned int compute_polynom(unsigned int sr)
>  {
> -       unsigned int i;
> -       unsigned int f;
> +    unsigned int i;
> +    unsigned int f;
>
> -       f = 0;
> -       for (i = 0; i < 16; i++)
> -               f += ((SR_POLYNOM >> i) & 1) & ((sr >> i) & 1);
> +    f = 0;
> +    for (i = 0; i < 16; i++) {
> +        f += ((SR_POLYNOM >> i) & 1) & ((sr >> i) & 1);
> +    }
>
> -       return f;
> +    return f;
>  }
>
>  static void cris_mmu_update_rand_lfsr(CPUCRISState *env)
>  {
> -       unsigned int f;
> +    unsigned int f;
>
> -       /* Update lfsr at every fault.  */
> -       f = compute_polynom(env->mmu_rand_lfsr);
> -       env->mmu_rand_lfsr >>= 1;
> -       env->mmu_rand_lfsr |= (f << 15);
> -       env->mmu_rand_lfsr &= 0xffff;
> +    /* Update lfsr at every fault.  */
> +    f = compute_polynom(env->mmu_rand_lfsr);
> +    env->mmu_rand_lfsr >>= 1;
> +    env->mmu_rand_lfsr |= (f << 15);
> +    env->mmu_rand_lfsr &= 0xffff;
>  }
>
>  static inline int cris_mmu_enabled(uint32_t rw_gc_cfg)
>  {
> -       return (rw_gc_cfg & 12) != 0;
> +    return (rw_gc_cfg & 12) != 0;
>  }
>
>  static inline int cris_mmu_segmented_addr(int seg, uint32_t rw_mm_cfg)
>  {
> -       return (1 << seg) & rw_mm_cfg;
> +    return (1 << seg) & rw_mm_cfg;
>  }
>
>  static uint32_t cris_mmu_translate_seg(CPUCRISState *env, int seg)
>  {
> -       uint32_t base;
> -       int i;
> +    uint32_t base;
> +    int i;
>
> -       if (seg < 8)
> -               base = env->sregs[SFR_RW_MM_KBASE_LO];
> -       else
> -               base = env->sregs[SFR_RW_MM_KBASE_HI];
> +    if (seg < 8) {
> +        base = env->sregs[SFR_RW_MM_KBASE_LO];
> +    } else {
> +        base = env->sregs[SFR_RW_MM_KBASE_HI];
> +    }
>
> -       i = seg & 7;
> -       base >>= i * 4;
> -       base &= 15;
> +    i = seg & 7;
> +    base >>= i * 4;
> +    base &= 15;
>
> -       base <<= 28;
> -       return base;
> +    base <<= 28;
> +    return base;
>  }
> -/* Used by the tlb decoder.  */
> -#define EXTRACT_FIELD(src, start, end) \
> -           (((src) >> start) & ((1 << (end - start + 1)) - 1))
>
> -static inline void set_field(uint32_t *dst, unsigned int val,
> +/* Used by the tlb decoder.  */
> +#define EXTRACT_FIELD(src, start, end)                  \
> +    (((src) >> start) & ((1 << (end - start + 1)) - 1))
> +
> +static inline void set_field(uint32_t *dst, unsigned int val,
>                              unsigned int offset, unsigned int width)
>  {
> -       uint32_t mask;
> +    uint32_t mask;
>
> -       mask = (1 << width) - 1;
> -       mask <<= offset;
> -       val <<= offset;
> +    mask = (1 << width) - 1;
> +    mask <<= offset;
> +    val <<= offset;
>
> -       val &= mask;
> -       *dst &= ~(mask);
> -       *dst |= val;
> +    val &= mask;
> +    *dst &= ~(mask);
> +    *dst |= val;
>  }
>
>  #ifdef DEBUG
>  static void dump_tlb(CPUCRISState *env, int mmu)
>  {
> -       int set;
> -       int idx;
> -       uint32_t hi, lo, tlb_vpn, tlb_pfn;
> +    int set;
> +    int idx;
> +    uint32_t hi, lo, tlb_vpn, tlb_pfn;
>
> -       for (set = 0; set < 4; set++) {
> -               for (idx = 0; idx < 16; idx++) {
> -                       lo = env->tlbsets[mmu][set][idx].lo;
> -                       hi = env->tlbsets[mmu][set][idx].hi;
> -                       tlb_vpn = EXTRACT_FIELD(hi, 13, 31);
> -                       tlb_pfn = EXTRACT_FIELD(lo, 13, 31);
> +    for (set = 0; set < 4; set++) {
> +        for (idx = 0; idx < 16; idx++) {
> +            lo = env->tlbsets[mmu][set][idx].lo;
> +            hi = env->tlbsets[mmu][set][idx].hi;
> +            tlb_vpn = EXTRACT_FIELD(hi, 13, 31);
> +            tlb_pfn = EXTRACT_FIELD(lo, 13, 31);
>
> -                       printf ("TLB: [%d][%d] hi=%x lo=%x v=%x p=%x\n",
> -                                       set, idx, hi, lo, tlb_vpn, tlb_pfn);
> -               }
> -       }
> +            printf("TLB: [%d][%d] hi=%x lo=%x v=%x p=%x\n",
> +                   set, idx, hi, lo, tlb_vpn, tlb_pfn);
> +        }
> +    }
>  }
>  #endif
>
> @@ -131,232 +134,224 @@ static int cris_mmu_translate_page(struct cris_mmu_result *res,
>                                    CPUCRISState *env, uint32_t vaddr,
>                                    int rw, int usermode, int debug)
>  {
> -       unsigned int vpage;
> -       unsigned int idx;
> -       uint32_t pid, lo, hi;
> -       uint32_t tlb_vpn, tlb_pfn = 0;
> -       int tlb_pid, tlb_g, tlb_v, tlb_k, tlb_w, tlb_x;
> -       int cfg_v, cfg_k, cfg_w, cfg_x;
> -       int set, match = 0;
> -       uint32_t r_cause;
> -       uint32_t r_cfg;
> -       int rwcause;
> -       int mmu = 1; /* Data mmu is default.  */
> -       int vect_base;
> +    unsigned int vpage;
> +    unsigned int idx;
> +    uint32_t pid, lo, hi;
> +    uint32_t tlb_vpn, tlb_pfn = 0;
> +    int tlb_pid, tlb_g, tlb_v, tlb_k, tlb_w, tlb_x;
> +    int cfg_v, cfg_k, cfg_w, cfg_x;
> +    int set, match = 0;
> +    uint32_t r_cause;
> +    uint32_t r_cfg;
> +    int rwcause;
> +    int mmu = 1; /* Data mmu is default.  */
> +    int vect_base;
>
> -       r_cause = env->sregs[SFR_R_MM_CAUSE];
> -       r_cfg = env->sregs[SFR_RW_MM_CFG];
> -       pid = env->pregs[PR_PID] & 0xff;
> +    r_cause = env->sregs[SFR_R_MM_CAUSE];
> +    r_cfg = env->sregs[SFR_RW_MM_CFG];
> +    pid = env->pregs[PR_PID] & 0xff;
>
> -       switch (rw) {
> -               case 2: rwcause = CRIS_MMU_ERR_EXEC; mmu = 0; break;
> -               case 1: rwcause = CRIS_MMU_ERR_WRITE; break;
> -               default:
> -               case 0: rwcause = CRIS_MMU_ERR_READ; break;
> -       }
> +    switch (rw) {
> +    case 2:
> +        rwcause = CRIS_MMU_ERR_EXEC;
> +        mmu = 0;
> +        break;
> +    case 1:
> +        rwcause = CRIS_MMU_ERR_WRITE;
> +        break;
> +    default:
> +    case 0:
> +        rwcause = CRIS_MMU_ERR_READ;
> +        break;
> +    }
>
> -       /* I exception vectors 4 - 7, D 8 - 11.  */
> -       vect_base = (mmu + 1) * 4;
> +    /* I exception vectors 4 - 7, D 8 - 11.  */
> +    vect_base = (mmu + 1) * 4;
>
> -       vpage = vaddr >> 13;
> +    vpage = vaddr >> 13;
>
> -       /* We know the index which to check on each set.
> -          Scan both I and D.  */
> -#if 0
> -       for (set = 0; set < 4; set++) {
> -               for (idx = 0; idx < 16; idx++) {
> -                       lo = env->tlbsets[mmu][set][idx].lo;
> -                       hi = env->tlbsets[mmu][set][idx].hi;
> -                       tlb_vpn = EXTRACT_FIELD(hi, 13, 31);
> -                       tlb_pfn = EXTRACT_FIELD(lo, 13, 31);
> +    /*
> +     * We know the index which to check on each set.
> +     * Scan both I and D.
> +     */
> +    idx = vpage & 15;
> +    for (set = 0; set < 4; set++) {
> +        lo = env->tlbsets[mmu][set][idx].lo;
> +        hi = env->tlbsets[mmu][set][idx].hi;
>
> -                       printf ("TLB: [%d][%d] hi=%x lo=%x v=%x p=%x\n",
> -                                       set, idx, hi, lo, tlb_vpn, tlb_pfn);
> -               }
> -       }
> -#endif
> +        tlb_vpn = hi >> 13;
> +        tlb_pid = EXTRACT_FIELD(hi, 0, 7);
> +        tlb_g  = EXTRACT_FIELD(lo, 4, 4);
>
> -       idx = vpage & 15;
> -       for (set = 0; set < 4; set++)
> -       {
> -               lo = env->tlbsets[mmu][set][idx].lo;
> -               hi = env->tlbsets[mmu][set][idx].hi;
> +        D_LOG("TLB[%d][%d][%d] v=%x vpage=%x lo=%x hi=%x\n",
> +              mmu, set, idx, tlb_vpn, vpage, lo, hi);
> +        if ((tlb_g || (tlb_pid == pid)) && tlb_vpn == vpage) {
> +            match = 1;
> +            break;
> +        }
> +    }
>
> -               tlb_vpn = hi >> 13;
> -               tlb_pid = EXTRACT_FIELD(hi, 0, 7);
> -               tlb_g  = EXTRACT_FIELD(lo, 4, 4);
> +    res->bf_vec = vect_base;
> +    if (match) {
> +        cfg_w  = EXTRACT_FIELD(r_cfg, 19, 19);
> +        cfg_k  = EXTRACT_FIELD(r_cfg, 18, 18);
> +        cfg_x  = EXTRACT_FIELD(r_cfg, 17, 17);
> +        cfg_v  = EXTRACT_FIELD(r_cfg, 16, 16);
>
> -               D_LOG("TLB[%d][%d][%d] v=%x vpage=%x lo=%x hi=%x\n",
> -                        mmu, set, idx, tlb_vpn, vpage, lo, hi);
> -               if ((tlb_g || (tlb_pid == pid))
> -                   && tlb_vpn == vpage) {
> -                       match = 1;
> -                       break;
> -               }
> -       }
> +        tlb_pfn = EXTRACT_FIELD(lo, 13, 31);
> +        tlb_v = EXTRACT_FIELD(lo, 3, 3);
> +        tlb_k = EXTRACT_FIELD(lo, 2, 2);
> +        tlb_w = EXTRACT_FIELD(lo, 1, 1);
> +        tlb_x = EXTRACT_FIELD(lo, 0, 0);
>
> -       res->bf_vec = vect_base;
> -       if (match) {
> -               cfg_w  = EXTRACT_FIELD(r_cfg, 19, 19);
> -               cfg_k  = EXTRACT_FIELD(r_cfg, 18, 18);
> -               cfg_x  = EXTRACT_FIELD(r_cfg, 17, 17);
> -               cfg_v  = EXTRACT_FIELD(r_cfg, 16, 16);
> +        /*
> +         * set_exception_vector(0x04, i_mmu_refill);
> +         * set_exception_vector(0x05, i_mmu_invalid);
> +         * set_exception_vector(0x06, i_mmu_access);
> +         * set_exception_vector(0x07, i_mmu_execute);
> +         * set_exception_vector(0x08, d_mmu_refill);
> +         * set_exception_vector(0x09, d_mmu_invalid);
> +         * set_exception_vector(0x0a, d_mmu_access);
> +         * set_exception_vector(0x0b, d_mmu_write);
> +         */
> +        if (cfg_k && tlb_k && usermode) {
> +            D(printf("tlb: kernel protected %x lo=%x pc=%x\n",
> +                     vaddr, lo, env->pc));
> +            match = 0;
> +            res->bf_vec = vect_base + 2;
> +        } else if (rw == 1 && cfg_w && !tlb_w) {
> +            D(printf("tlb: write protected %x lo=%x pc=%x\n",
> +                     vaddr, lo, env->pc));
> +            match = 0;
> +            /* write accesses never go through the I mmu.  */
> +            res->bf_vec = vect_base + 3;
> +        } else if (rw == 2 && cfg_x && !tlb_x) {
> +            D(printf("tlb: exec protected %x lo=%x pc=%x\n",
> +                     vaddr, lo, env->pc));
> +            match = 0;
> +            res->bf_vec = vect_base + 3;
> +        } else if (cfg_v && !tlb_v) {
> +            D(printf("tlb: invalid %x\n", vaddr));
> +            match = 0;
> +            res->bf_vec = vect_base + 1;
> +        }
>
> -               tlb_pfn = EXTRACT_FIELD(lo, 13, 31);
> -               tlb_v = EXTRACT_FIELD(lo, 3, 3);
> -               tlb_k = EXTRACT_FIELD(lo, 2, 2);
> -               tlb_w = EXTRACT_FIELD(lo, 1, 1);
> -               tlb_x = EXTRACT_FIELD(lo, 0, 0);
> +        res->prot = 0;
> +        if (match) {
> +            res->prot |= PAGE_READ;
> +            if (tlb_w) {
> +                res->prot |= PAGE_WRITE;
> +            }
> +            if (mmu == 0 && (cfg_x || tlb_x)) {
> +                res->prot |= PAGE_EXEC;
> +            }
> +        } else {
> +            D(dump_tlb(env, mmu));
> +        }
> +    } else {
> +        /* If refill, provide a randomized set.  */
> +        set = env->mmu_rand_lfsr & 3;
> +    }
>
> -               /*
> -               set_exception_vector(0x04, i_mmu_refill);
> -               set_exception_vector(0x05, i_mmu_invalid);
> -               set_exception_vector(0x06, i_mmu_access);
> -               set_exception_vector(0x07, i_mmu_execute);
> -               set_exception_vector(0x08, d_mmu_refill);
> -               set_exception_vector(0x09, d_mmu_invalid);
> -               set_exception_vector(0x0a, d_mmu_access);
> -               set_exception_vector(0x0b, d_mmu_write);
> -               */
> -               if (cfg_k && tlb_k && usermode) {
> -                       D(printf ("tlb: kernel protected %x lo=%x pc=%x\n",
> -                                 vaddr, lo, env->pc));
> -                       match = 0;
> -                       res->bf_vec = vect_base + 2;
> -               } else if (rw == 1 && cfg_w && !tlb_w) {
> -                       D(printf ("tlb: write protected %x lo=%x pc=%x\n",
> -                                 vaddr, lo, env->pc));
> -                       match = 0;
> -                       /* write accesses never go through the I mmu.  */
> -                       res->bf_vec = vect_base + 3;
> -               } else if (rw == 2 && cfg_x && !tlb_x) {
> -                       D(printf ("tlb: exec protected %x lo=%x pc=%x\n",
> -                                vaddr, lo, env->pc));
> -                       match = 0;
> -                       res->bf_vec = vect_base + 3;
> -               } else if (cfg_v && !tlb_v) {
> -                       D(printf ("tlb: invalid %x\n", vaddr));
> -                       match = 0;
> -                       res->bf_vec = vect_base + 1;
> -               }
> +    if (!match && !debug) {
> +        cris_mmu_update_rand_lfsr(env);
>
> -               res->prot = 0;
> -               if (match) {
> -                       res->prot |= PAGE_READ;
> -                       if (tlb_w)
> -                               res->prot |= PAGE_WRITE;
> -                       if (mmu == 0 && (cfg_x || tlb_x))
> -                               res->prot |= PAGE_EXEC;
> -               }
> -               else
> -                       D(dump_tlb(env, mmu));
> -       } else {
> -               /* If refill, provide a randomized set.  */
> -               set = env->mmu_rand_lfsr & 3;
> -       }
> +        /* Compute index.  */
> +        idx = vpage & 15;
>
> -       if (!match && !debug) {
> -               cris_mmu_update_rand_lfsr(env);
> +        /* Update RW_MM_TLB_SEL.  */
> +        env->sregs[SFR_RW_MM_TLB_SEL] = 0;
> +        set_field(&env->sregs[SFR_RW_MM_TLB_SEL], idx, 0, 4);
> +        set_field(&env->sregs[SFR_RW_MM_TLB_SEL], set, 4, 2);
>
> -               /* Compute index.  */
> -               idx = vpage & 15;
> +        /* Update RW_MM_CAUSE.  */
> +        set_field(&r_cause, rwcause, 8, 2);
> +        set_field(&r_cause, vpage, 13, 19);
> +        set_field(&r_cause, pid, 0, 8);
> +        env->sregs[SFR_R_MM_CAUSE] = r_cause;
> +        D(printf("refill vaddr=%x pc=%x\n", vaddr, env->pc));
> +    }
>
> -               /* Update RW_MM_TLB_SEL.  */
> -               env->sregs[SFR_RW_MM_TLB_SEL] = 0;
> -               set_field(&env->sregs[SFR_RW_MM_TLB_SEL], idx, 0, 4);
> -               set_field(&env->sregs[SFR_RW_MM_TLB_SEL], set, 4, 2);
> +    D(printf("%s rw=%d mtch=%d pc=%x va=%x vpn=%x tlbvpn=%x pfn=%x pid=%x"
> +             " %x cause=%x sel=%x sp=%x %x %x\n",
> +             __func__, rw, match, env->pc,
> +             vaddr, vpage,
> +             tlb_vpn, tlb_pfn, tlb_pid,
> +             pid,
> +             r_cause,
> +             env->sregs[SFR_RW_MM_TLB_SEL],
> +             env->regs[R_SP], env->pregs[PR_USP], env->ksp));
>
> -               /* Update RW_MM_CAUSE.  */
> -               set_field(&r_cause, rwcause, 8, 2);
> -               set_field(&r_cause, vpage, 13, 19);
> -               set_field(&r_cause, pid, 0, 8);
> -               env->sregs[SFR_R_MM_CAUSE] = r_cause;
> -               D(printf("refill vaddr=%x pc=%x\n", vaddr, env->pc));
> -       }
> -
> -       D(printf ("%s rw=%d mtch=%d pc=%x va=%x vpn=%x tlbvpn=%x pfn=%x pid=%x"
> -                 " %x cause=%x sel=%x sp=%x %x %x\n",
> -                 __func__, rw, match, env->pc,
> -                 vaddr, vpage,
> -                 tlb_vpn, tlb_pfn, tlb_pid,
> -                 pid,
> -                 r_cause,
> -                 env->sregs[SFR_RW_MM_TLB_SEL],
> -                 env->regs[R_SP], env->pregs[PR_USP], env->ksp));
> -
> -       res->phy = tlb_pfn << TARGET_PAGE_BITS;
> -       return !match;
> +    res->phy = tlb_pfn << TARGET_PAGE_BITS;
> +    return !match;
>  }
>
>  void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid)
>  {
>      CRISCPU *cpu = cris_env_get_cpu(env);
> -       target_ulong vaddr;
> -       unsigned int idx;
> -       uint32_t lo, hi;
> -       uint32_t tlb_vpn;
> -       int tlb_pid, tlb_g, tlb_v;
> -       unsigned int set;
> -       unsigned int mmu;
> +    target_ulong vaddr;
> +    unsigned int idx;
> +    uint32_t lo, hi;
> +    uint32_t tlb_vpn;
> +    int tlb_pid, tlb_g, tlb_v;
> +    unsigned int set;
> +    unsigned int mmu;
>
> -       pid &= 0xff;
> -       for (mmu = 0; mmu < 2; mmu++) {
> -               for (set = 0; set < 4; set++)
> -               {
> -                       for (idx = 0; idx < 16; idx++) {
> -                               lo = env->tlbsets[mmu][set][idx].lo;
> -                               hi = env->tlbsets[mmu][set][idx].hi;
> -
> -                               tlb_vpn = EXTRACT_FIELD(hi, 13, 31);
> -                               tlb_pid = EXTRACT_FIELD(hi, 0, 7);
> -                               tlb_g  = EXTRACT_FIELD(lo, 4, 4);
> -                               tlb_v = EXTRACT_FIELD(lo, 3, 3);
> +    pid &= 0xff;
> +    for (mmu = 0; mmu < 2; mmu++) {
> +        for (set = 0; set < 4; set++) {
> +            for (idx = 0; idx < 16; idx++) {
> +                lo = env->tlbsets[mmu][set][idx].lo;
> +                hi = env->tlbsets[mmu][set][idx].hi;
>
> -                               if (tlb_v && !tlb_g && (tlb_pid == pid)) {
> -                                       vaddr = tlb_vpn << TARGET_PAGE_BITS;
> -                                       D_LOG("flush pid=%x vaddr=%x\n",
> -                                                 pid, vaddr);
> +                tlb_vpn = EXTRACT_FIELD(hi, 13, 31);
> +                tlb_pid = EXTRACT_FIELD(hi, 0, 7);
> +                tlb_g  = EXTRACT_FIELD(lo, 4, 4);
> +                tlb_v = EXTRACT_FIELD(lo, 3, 3);
> +
> +                if (tlb_v && !tlb_g && (tlb_pid == pid)) {
> +                    vaddr = tlb_vpn << TARGET_PAGE_BITS;
> +                    D_LOG("flush pid=%x vaddr=%x\n", pid, vaddr);
>                      tlb_flush_page(CPU(cpu), vaddr);
> -                               }
> -                       }
> -               }
> -       }
> +                }
> +            }
> +        }
> +    }
>  }
>
>  int cris_mmu_translate(struct cris_mmu_result *res,
>                        CPUCRISState *env, uint32_t vaddr,
>                        int rw, int mmu_idx, int debug)
>  {
> -       int seg;
> -       int miss = 0;
> -       int is_user = mmu_idx == MMU_USER_IDX;
> -       uint32_t old_srs;
> +    int seg;
> +    int miss = 0;
> +    int is_user = mmu_idx == MMU_USER_IDX;
> +    uint32_t old_srs;
>
> -       old_srs= env->pregs[PR_SRS];
> +    old_srs = env->pregs[PR_SRS];
>
> -       /* rw == 2 means exec, map the access to the insn mmu.  */
> -       env->pregs[PR_SRS] = rw == 2 ? 1 : 2;
> +    /* rw == 2 means exec, map the access to the insn mmu.  */
> +    env->pregs[PR_SRS] = rw == 2 ? 1 : 2;
>
> -       if (!cris_mmu_enabled(env->sregs[SFR_RW_GC_CFG])) {
> -               res->phy = vaddr;
> -               res->prot = PAGE_BITS;
> -               goto done;
> -       }
> +    if (!cris_mmu_enabled(env->sregs[SFR_RW_GC_CFG])) {
> +        res->phy = vaddr;
> +        res->prot = PAGE_BITS;
> +        goto done;
> +    }
>
> -       seg = vaddr >> 28;
> -       if (!is_user && cris_mmu_segmented_addr(seg, env->sregs[SFR_RW_MM_CFG]))
> -       {
> -               uint32_t base;
> +    seg = vaddr >> 28;
> +    if (!is_user && cris_mmu_segmented_addr(seg, env->sregs[SFR_RW_MM_CFG])) {
> +        uint32_t base;
>
> -               miss = 0;
> -               base = cris_mmu_translate_seg(env, seg);
> -                res->phy = base | (0x0fffffff & vaddr);
> -               res->prot = PAGE_BITS;
> -       } else {
> -               miss = cris_mmu_translate_page(res, env, vaddr, rw,
> -                                              is_user, debug);
> -       }
> -  done:
> -       env->pregs[PR_SRS] = old_srs;
> -       return miss;
> +        miss = 0;
> +        base = cris_mmu_translate_seg(env, seg);
> +        res->phy = base | (0x0fffffff & vaddr);
> +        res->prot = PAGE_BITS;
> +    } else {
> +        miss = cris_mmu_translate_page(res, env, vaddr, rw,
> +                                       is_user, debug);
> +    }
> + done:
> +    env->pregs[PR_SRS] = old_srs;
> +    return miss;
>  }
> --
> 2.17.1
>
>

