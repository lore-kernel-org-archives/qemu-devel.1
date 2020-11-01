Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 06:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9252087E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 06:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9252087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZ7IG-0003zz-34
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 01:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZ7GU-0003Ac-Hx
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 01:54:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kZ7GS-0005Mx-52
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 01:54:58 -0500
Received: by mail-il1-f196.google.com with SMTP id f16so10211092ilr.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 23:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9bdG26+qFY2TwxJRZj0kPoRQ1Sg9KRO0O7Dw6TPQRiU=;
 b=hjyHBQWg6I7NzmTV6gFFWj+9jRw8hVqeIkPMXNOuThwqQPH/19ooxZmk5hVtbGFCI0
 Yq1UCNRuqFowvoLyHHu2erGsNPwdzkZWVoR2RA8VhBRTHox/MKsV9zmlpTCQc2gR0mng
 36JMes8C80jxGZ8kKEFBMGMkgtQl49f8qYBkjXfXRTObZou0uzLxBPlXHozSwYwxTdiG
 r8Oiqhjog0SPIBNpgT+3XfHfT4q7kEVPe7+CSIDY71UOYAeQ9FxvMbmP+Yt9ETdNScqT
 Hk5TaZY85Rz8U1pg0ZRamRc9F3MddS0vXP8iStsjsrAsStJFVEqAT266DMd6WVL4LsTA
 IOvg==
X-Gm-Message-State: AOAM530nRpnGbUmNR3KNOPdRAS9xJH/WHF5z83iml7RC56H87QVemjKF
 cnJvgYx48QrhHjcn+L3TjSJoAqdz0aE=
X-Google-Smtp-Source: ABdhPJxM9b5FJRkAiajMSXbUOznUlcaXjoB5V+83v5SvUtb7/GOc6/UpaOKbrD1Xq8dNCJdOBjJBcg==
X-Received: by 2002:a92:5e5c:: with SMTP id s89mr6578378ilb.179.1604213694349; 
 Sat, 31 Oct 2020 23:54:54 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com.
 [209.85.166.45])
 by smtp.gmail.com with ESMTPSA id s85sm9508733ilk.41.2020.10.31.23.54.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2020 23:54:54 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id u21so1187213iol.12
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 23:54:54 -0700 (PDT)
X-Received: by 2002:a6b:6610:: with SMTP id a16mr2229992ioc.193.1604213693720; 
 Sat, 31 Oct 2020 23:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <20201030004921.721096-2-richard.henderson@linaro.org>
In-Reply-To: <20201030004921.721096-2-richard.henderson@linaro.org>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 31 Oct 2020 23:54:42 -0700
X-Gmail-Original-Message-ID: <CA+E+eSCn=NjEWrGngmgQtk+robNxL01Ksu7T6nBUNXEg90yvsQ@mail.gmail.com>
Message-ID: <CA+E+eSCn=NjEWrGngmgQtk+robNxL01Ksu7T6nBUNXEg90yvsQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] tcg: Enhance flush_icache_range with separate
 data pointer
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.196; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 01:54:54
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

s->code_ptr and s->code_buf are 4 byte pointers on aarch64 so the
cache flush is off by a factor of 4

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 44b923f5fe..2c4b66965b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4325,7 +4325,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)

     /* flush instruction cache */
     flush_idcache_range((uintptr_t)tcg_mirror_rw_to_rx(s->code_buf),
-                        (uintptr_t)s->code_buf, s->code_ptr - s->code_buf);
+                        (uintptr_t)s->code_buf,
+                        (uintptr_t)s->code_ptr - (uintptr_t)s->code_buf);

     return tcg_current_code_size(s);
 }

With this and the other changes, split JIT works fine on iOS.

-j

On Thu, Oct 29, 2020 at 5:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We are shortly going to have a split rw/rx jit buffer.  Depending
> on the host, we need to flush the dcache at the rw data pointer and
> flush the icache at the rx code pointer.
>
> For now, the two passed pointers are identical, so there is no
> effective change in behaviour.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.h     |  9 +++++++--
>  tcg/arm/tcg-target.h         |  8 ++++++--
>  tcg/i386/tcg-target.h        |  3 ++-
>  tcg/mips/tcg-target.h        |  8 ++++++--
>  tcg/ppc/tcg-target.h         |  2 +-
>  tcg/riscv/tcg-target.h       |  8 ++++++--
>  tcg/s390/tcg-target.h        |  3 ++-
>  tcg/sparc/tcg-target.h       |  8 +++++---
>  tcg/tci/tcg-target.h         |  3 ++-
>  softmmu/physmem.c            |  9 ++++++++-
>  tcg/tcg.c                    |  5 +++--
>  tcg/aarch64/tcg-target.c.inc |  2 +-
>  tcg/mips/tcg-target.c.inc    |  2 +-
>  tcg/ppc/tcg-target.c.inc     | 21 +++++++++++----------
>  tcg/sparc/tcg-target.c.inc   |  4 ++--
>  15 files changed, 63 insertions(+), 32 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 663dd0b95e..d0a6a059b7 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -148,9 +148,14 @@ typedef enum {
>  #define TCG_TARGET_DEFAULT_MO (0)
>  #define TCG_TARGET_HAS_MEMORY_BSWAP     1
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
> -    __builtin___clear_cache((char *)start, (char *)stop);
> +    /* TODO: Copy this from gcc to avoid 4 loops instead of 2. */
> +    if (rw != rx) {
> +        __builtin___clear_cache((char *)rw, (char *)(rw + len));
> +    }
> +    __builtin___clear_cache((char *)rx, (char *)(rx + len));
>  }
>
>  void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
> index 17e771374d..fa88b24e43 100644
> --- a/tcg/arm/tcg-target.h
> +++ b/tcg/arm/tcg-target.h
> @@ -134,9 +134,13 @@ enum {
>  #define TCG_TARGET_DEFAULT_MO (0)
>  #define TCG_TARGET_HAS_MEMORY_BSWAP     1
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
> -    __builtin___clear_cache((char *) start, (char *) stop);
> +    if (rw != rx) {
> +        __builtin___clear_cache((char *)rw, (char *)(rw + len));
> +    }
> +    __builtin___clear_cache((char *)rx, (char *)(rx + len));
>  }
>
>  /* not defined -- call should be eliminated at compile time */
> diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
> index abd4ac7fc0..8323e72639 100644
> --- a/tcg/i386/tcg-target.h
> +++ b/tcg/i386/tcg-target.h
> @@ -206,7 +206,8 @@ extern bool have_avx2;
>  #define TCG_TARGET_extract_i64_valid(ofs, len) \
>      (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
>  }
>
> diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
> index c6b091d849..47b1226ee9 100644
> --- a/tcg/mips/tcg-target.h
> +++ b/tcg/mips/tcg-target.h
> @@ -207,9 +207,13 @@ extern bool use_mips32r2_instructions;
>  #define TCG_TARGET_DEFAULT_MO (0)
>  #define TCG_TARGET_HAS_MEMORY_BSWAP     1
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
> -    cacheflush ((void *)start, stop-start, ICACHE);
> +    if (rx != rw) {
> +        cacheflush((void *)rw, len, DCACHE);
> +    }
> +    cacheflush((void *)rx, len, ICACHE);
>  }
>
>  void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
> diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
> index be10363956..fbb6dc1b47 100644
> --- a/tcg/ppc/tcg-target.h
> +++ b/tcg/ppc/tcg-target.h
> @@ -175,7 +175,7 @@ extern bool have_vsx;
>  #define TCG_TARGET_HAS_bitsel_vec       have_vsx
>  #define TCG_TARGET_HAS_cmpsel_vec       0
>
> -void flush_icache_range(uintptr_t start, uintptr_t stop);
> +void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
>  void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
>
>  #define TCG_TARGET_DEFAULT_MO (0)
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 032439d806..0fa6ae358e 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -159,9 +159,13 @@ typedef enum {
>  #define TCG_TARGET_HAS_mulsh_i64        1
>  #endif
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
> -    __builtin___clear_cache((char *)start, (char *)stop);
> +    if (rx != rw) {
> +        __builtin___clear_cache((char *)rw, (char *)(rw + len));
> +    }
> +    __builtin___clear_cache((char *)rx, (char *)(rx + len));
>  }
>
>  /* not defined -- call should be eliminated at compile time */
> diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
> index 63c8797bd3..c3dc2e8938 100644
> --- a/tcg/s390/tcg-target.h
> +++ b/tcg/s390/tcg-target.h
> @@ -145,7 +145,8 @@ enum {
>      TCG_AREG0 = TCG_REG_R10,
>  };
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
>  }
>
> diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
> index 633841ebf2..c27c40231e 100644
> --- a/tcg/sparc/tcg-target.h
> +++ b/tcg/sparc/tcg-target.h
> @@ -168,10 +168,12 @@ extern bool use_vis3_instructions;
>  #define TCG_TARGET_DEFAULT_MO (0)
>  #define TCG_TARGET_HAS_MEMORY_BSWAP     1
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
> -    uintptr_t p;
> -    for (p = start & -8; p < ((stop + 7) & -8); p += 8) {
> +    /* No additional data flush to the RW virtual address required. */
> +    uintptr_t p, end = (rx + len + 7) & -8;
> +    for (p = rx & -8; p < end; p += 8) {
>          __asm__ __volatile__("flush\t%0" : : "r" (p));
>      }
>  }
> diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
> index 8c1c1d265d..6460449719 100644
> --- a/tcg/tci/tcg-target.h
> +++ b/tcg/tci/tcg-target.h
> @@ -191,7 +191,8 @@ void tci_disas(uint8_t opc);
>
>  #define HAVE_TCG_QEMU_TB_EXEC
>
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>  {
>  }
>
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index a9adedb9f8..b23c1fef54 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2954,7 +2954,14 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
>                  invalidate_and_set_dirty(mr, addr1, l);
>                  break;
>              case FLUSH_CACHE:
> -                flush_icache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr + l);
> +                /*
> +                 * FIXME: This function is currently located in tcg/host/,
> +                 * but we never come here when tcg is enabled; only for
> +                 * real hardware acceleration.  This can actively fail
> +                 * when TCI is configured, since that function is a nop.
> +                 * We should move this to util/ or something.
> +                 */
> +                flush_idcache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr, l);
>                  break;
>              }
>          }
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index a8c28440e2..3bf36e0cfe 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1076,7 +1076,7 @@ void tcg_prologue_init(TCGContext *s)
>  #endif
>
>      buf1 = s->code_ptr;
> -    flush_icache_range((uintptr_t)buf0, (uintptr_t)buf1);
> +    flush_idcache_range((uintptr_t)buf0, (uintptr_t)buf0, buf1 - buf0);
>
>      /* Deduct the prologue from the buffer.  */
>      prologue_size = tcg_current_code_size(s);
> @@ -4268,7 +4268,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
>      }
>
>      /* flush instruction cache */
> -    flush_icache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_ptr);
> +    flush_idcache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_buf,
> +                        s->code_ptr - s->code_buf);
>
>      return tcg_current_code_size(s);
>  }
> diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
> index 26f71cb599..83af3108a4 100644
> --- a/tcg/aarch64/tcg-target.c.inc
> +++ b/tcg/aarch64/tcg-target.c.inc
> @@ -1363,7 +1363,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>      }
>      pair = (uint64_t)i2 << 32 | i1;
>      qatomic_set((uint64_t *)jmp_addr, pair);
> -    flush_icache_range(jmp_addr, jmp_addr + 8);
> +    flush_idcache_range(jmp_addr, jmp_addr, 8);
>  }
>
>  static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
> diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
> index 41be574e89..c255ecb444 100644
> --- a/tcg/mips/tcg-target.c.inc
> +++ b/tcg/mips/tcg-target.c.inc
> @@ -2660,7 +2660,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>                                uintptr_t addr)
>  {
>      qatomic_set((uint32_t *)jmp_addr, deposit32(OPC_J, 0, 26, addr >> 2));
> -    flush_icache_range(jmp_addr, jmp_addr + 4);
> +    flush_idcache_range(jmp_addr, jmp_addr, 4);
>  }
>
>  typedef struct {
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 18ee989f95..a848e98383 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -1753,12 +1753,12 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>          /* As per the enclosing if, this is ppc64.  Avoid the _Static_assert
>             within qatomic_set that would fail to build a ppc32 host.  */
>          qatomic_set__nocheck((uint64_t *)jmp_addr, pair);
> -        flush_icache_range(jmp_addr, jmp_addr + 8);
> +        flush_idcache_range(jmp_addr, jmp_addr, 8);
>      } else {
>          intptr_t diff = addr - jmp_addr;
>          tcg_debug_assert(in_range_b(diff));
>          qatomic_set((uint32_t *)jmp_addr, B | (diff & 0x3fffffc));
> -        flush_icache_range(jmp_addr, jmp_addr + 4);
> +        flush_idcache_range(jmp_addr, jmp_addr, 4);
>      }
>  }
>
> @@ -3864,22 +3864,23 @@ void tcg_register_jit(void *buf, size_t buf_size)
>  }
>  #endif /* __ELF__ */
>
> -void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +void flush_idcache_range(uintptr_t rx, uintptr_t rw, uintptr_t len)
>  {
> -    uintptr_t p, start1, stop1;
> +    uintptr_t p, start, stop;
>      size_t dsize = qemu_dcache_linesize;
>      size_t isize = qemu_icache_linesize;
>
> -    start1 = start & ~(dsize - 1);
> -    stop1 = (stop + dsize - 1) & ~(dsize - 1);
> -    for (p = start1; p < stop1; p += dsize) {
> +    start = rw & ~(dsize - 1);
> +    stop = (rw + len + dsize - 1) & ~(dsize - 1);
> +    for (p = start; p < stop; p += dsize) {
>          asm volatile ("dcbst 0,%0" : : "r"(p) : "memory");
>      }
>      asm volatile ("sync" : : : "memory");
>
> -    start &= start & ~(isize - 1);
> -    stop1 = (stop + isize - 1) & ~(isize - 1);
> -    for (p = start1; p < stop1; p += isize) {
> +    start = rx & ~(isize - 1);
> +    stop = (rx + len + isize - 1) & ~(isize - 1);
> +    for (p = start; p < stop; p += isize) {
>          asm volatile ("icbi 0,%0" : : "r"(p) : "memory");
>      }
>      asm volatile ("sync" : : : "memory");
> diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
> index 6775bd30fc..6e2d755f6a 100644
> --- a/tcg/sparc/tcg-target.c.inc
> +++ b/tcg/sparc/tcg-target.c.inc
> @@ -1836,7 +1836,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>      if (!USE_REG_TB) {
>          qatomic_set((uint32_t *)jmp_addr,
>                     deposit32(CALL, 0, 30, br_disp >> 2));
> -        flush_icache_range(jmp_addr, jmp_addr + 4);
> +        flush_idcache_range(jmp_addr, jmp_addr, 4);
>          return;
>      }
>
> @@ -1860,5 +1860,5 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
>      }
>
>      qatomic_set((uint64_t *)jmp_addr, deposit64(i2, 32, 32, i1));
> -    flush_icache_range(jmp_addr, jmp_addr + 8);
> +    flush_idcache_range(jmp_addr, jmp_addr, 8);
>  }
> --
> 2.25.1
>

