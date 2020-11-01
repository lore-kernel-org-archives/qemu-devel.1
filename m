Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D980C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 01:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACCC22226
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 01:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACCC22226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZ290-0004J4-Gk
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 21:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZ27f-0003oz-51
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 21:25:31 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZ27c-0000pu-Vr
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 21:25:30 -0400
Received: by mail-il1-f194.google.com with SMTP id g7so9838742ilr.12
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 18:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LEOPn67GXFUnhT4X+04SGrMSRT2E60UkEtg2xXPe+bY=;
 b=ZcmV/zcvfZ0+loDYdZqSvaGvY8Jv3gpLzNcHcQ7+z45ovBOWY4M6+qE9tQTz4hhJV0
 S7a4cV1vuudnqLFJNRHac+ycRKhOs5YRtE5wWmpoSv4PMhE21AMuSQyIPfptVK4X5vRB
 /OmFucXZbehJ9x/0bYeF4wjx+Kbr5fXNmhhQ5IGJ7lG87nY5f3xmSF1xPGKAfjL+rrNw
 k0n8j8OeF96KvruxEZihfzeXi1JI0Jo/rhfYyY0QIH5npDJ3jRG4gc1kagfuLp3PLwOs
 R6Memh0xMp6yByBUB8Y6G7kRJNdTWvl4pQl6O0ds6mEaMpLVBuskXFkaXZCebCCnmt1j
 gBGA==
X-Gm-Message-State: AOAM531+lXBHYJzSUDzDMgva3oAbEZ3u2VEdY48Dw7Qta58USa5ASWZ0
 SEkWSXw0GPr4OujBF7B4jlkKPmv+eY0=
X-Google-Smtp-Source: ABdhPJyKL2eRKxX5uVxRvDk5wEKobsSjVAtW0+cCfWzBIKOD6yevnqEpUaRUy0qfsS35Od1rDUfOZg==
X-Received: by 2002:a92:414e:: with SMTP id o75mr6411312ila.30.1604193927209; 
 Sat, 31 Oct 2020 18:25:27 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com.
 [209.85.166.178])
 by smtp.gmail.com with ESMTPSA id o124sm8047767ila.62.2020.10.31.18.25.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2020 18:25:26 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id v18so9888945ilg.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 18:25:26 -0700 (PDT)
X-Received: by 2002:a92:ac0e:: with SMTP id r14mr6887626ilh.197.1604193926058; 
 Sat, 31 Oct 2020 18:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <20201030004921.721096-19-richard.henderson@linaro.org>
In-Reply-To: <20201030004921.721096-19-richard.henderson@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 31 Oct 2020 18:25:15 -0700
X-Gmail-Original-Message-ID: <CA+E+eSB64cm8GPsuEYNQJLkF2gPiF2oueYPOOTtxpYy7hWzTRg@mail.gmail.com>
Message-ID: <CA+E+eSB64cm8GPsuEYNQJLkF2gPiF2oueYPOOTtxpYy7hWzTRg@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] tcg/aarch64: Implement flush_idcache_range
 manually
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.194; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 21:25:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately this crashes on iOS/Apple Silicon macOS.

(lldb) bt
* thread #19, stop reason = EXC_BAD_INSTRUCTION (code=1, subcode=0xd53b002a)
  * frame #0: 0x00000001169501e0
libqemu-x86_64-softmmu.utm.dylib`tcg_prologue_init + 760
...
(lldb) x/i 0x00000001169501e0
->  0x1169501e0: 0xd53b002a   mrs    x10, CTR_EL0

I was able to fix it by adding

#ifdef CONFIG_DARWIN
extern void sys_icache_invalidate(void *start, size_t len);
extern void sys_dcache_flush(void *start, size_t len);

void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
{
    sys_dcache_flush((void *)rw, len);
    sys_icache_invalidate((void *)rx, len);
}
#else
...
#endif

Another thing, for x86 (and maybe other archs), the icache is cache
coherent but does it apply if we are aliasing the memory address? I
think in that case, it's like we're doing a DMA right and still need
to do flushing+invalidating?

-j

On Thu, Oct 29, 2020 at 5:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Copy the single pointer implementation from libgcc and modify it to
> support the double pointer interface we require.  This halves the
> number of cache operations required when split-rwx is enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.h     | 11 +-------
>  tcg/aarch64/tcg-target.c.inc | 53 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 10 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index fa64058d43..e62d38ba55 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -148,16 +148,7 @@ typedef enum {
>  #define TCG_TARGET_DEFAULT_MO (0)
>  #define TCG_TARGET_HAS_MEMORY_BSWAP     1
>
> -/* Flush the dcache at RW, and the icache at RX, as necessary. */
> -static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
> -{
> -    /* TODO: Copy this from gcc to avoid 4 loops instead of 2. */
> -    if (rw != rx) {
> -        __builtin___clear_cache((char *)rw, (char *)(rw + len));
> -    }
> -    __builtin___clear_cache((char *)rx, (char *)(rx + len));
> -}
> -
> +void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
>  void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
>
>  #ifdef CONFIG_SOFTMMU
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index bd888bc66d..5e8f3faad2 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -2968,3 +2968,56 @@ void tcg_register_jit(const void *buf, size_t buf_size)
>  {
>      tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
>  }
> +
> +/*
> + * Flush the dcache at RW, and the icache at RX, as necessary.
> + * This is a copy of gcc's __aarch64_sync_cache_range, modified
> + * to fit this three-operand interface.
> + */
> +void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
> +{
> +    const unsigned CTR_IDC = 1u << 28;
> +    const unsigned CTR_DIC = 1u << 29;
> +    static unsigned int cache_info;
> +    uintptr_t icache_lsize, dcache_lsize, p;
> +
> +    if (!cache_info) {
> +        /*
> +         * CTR_EL0 [3:0] contains log2 of icache line size in words.
> +         * CTR_EL0 [19:16] contains log2 of dcache line size in words.
> +         */
> +        asm volatile("mrs\t%0, ctr_el0" : "=r"(cache_info));
> +    }
> +
> +    icache_lsize = 4 << extract32(cache_info, 0, 4);
> +    dcache_lsize = 4 << extract32(cache_info, 16, 4);
> +
> +    /*
> +     * If CTR_EL0.IDC is enabled, Data cache clean to the Point of Unification
> +     * is not required for instruction to data coherence.
> +     */
> +    if (!(cache_info & CTR_IDC)) {
> +        /*
> +         * Loop over the address range, clearing one cache line at once.
> +         * Data cache must be flushed to unification first to make sure
> +         * the instruction cache fetches the updated data.
> +         */
> +        for (p = rw & -dcache_lsize; p < rw + len; p += dcache_lsize) {
> +            asm volatile("dc\tcvau, %0" : : "r" (p) : "memory");
> +        }
> +        asm volatile("dsb\tish" : : : "memory");
> +    }
> +
> +    /*
> +     * If CTR_EL0.DIC is enabled, Instruction cache cleaning to the Point
> +     * of Unification is not required for instruction to data coherence.
> +     */
> +    if (!(cache_info & CTR_DIC)) {
> +        for (p = rx & -icache_lsize; p < rx + len; p += icache_lsize) {
> +            asm volatile("ic\tivau, %0" : : "r"(p) : "memory");
> +        }
> +        asm volatile ("dsb\tish" : : : "memory");
> +    }
> +
> +    asm volatile("isb" : : : "memory");
> +}
> --
> 2.25.1
>

