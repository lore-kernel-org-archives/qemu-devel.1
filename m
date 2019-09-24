Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11EC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 18:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9A420872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 18:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fI28CWZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9A420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCpXJ-0002h4-8K
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 14:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCpVF-0000JR-5T
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 14:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCpVC-0006Qa-HS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 14:25:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCpVC-0006Pq-74
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 14:25:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so3034658wrx.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nkYMbIY6QSXDLeoK2INc0rL8MgzoBlfIHO3nRDf0qkE=;
 b=fI28CWZi4VZnsmPGkQoqs1bwJynD9reiHcyZBw/qOep8JjhYKAhoREc4ANNWBDaPNy
 cxpxheAis+YD7wGGwZ2IW+gHldBszekfs7XgTYAq32gHLyeIN9AJiIv68qEnZ9QsG/ch
 rTUhsXQoZIqvva+ZElVS3CMRtyzJJwcG4TB3/FtA7ZLEoFiEksrC242NtqCjCEZvSwFA
 cT99AHfsrwsQWbCE/sN0CVlFyvbg1lpVEsbEJQOdRKoe9378pDNi9J3qmG2DDISBA7Lb
 Sk77S8Sl4piTTgRq1yizS/K+LLIHgu5pExAgfmOS1LleR2ykVgmmRkFcBTsNe2ZgiYpV
 BIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nkYMbIY6QSXDLeoK2INc0rL8MgzoBlfIHO3nRDf0qkE=;
 b=V6CYIkNU6Nt8W2oQ477sfaYSOP0R5ewhOHYjA74ypw2bVKfafU+eIZjLH4SHiRPXZb
 TJlGatrTLyoz/eDy3Z7lwwfnYGcjBl7DVGb1a07If2dNzTVKPhFF3KddEg7G6Ip3TxFs
 KkeGi7JFF3gJ8R27r700/NJNZGi8ex/uVoZo1jnpvcisa6zArjtmGiUHHZw4TF7awcU0
 gZa/j+eXyAs3lUslbzwoVNuCyXEODKIht/3VWZ22uVxWMmGuEFoxElrOBDeanJmP6jZt
 F6iI1XtefjMtKYw3zQ7ZXcsBpLT222oOZ8Uc0U/erHR+cLUreOLz87yJFeQGxYbdcBmS
 +AAg==
X-Gm-Message-State: APjAAAUww0fkEQ7RsOLa60WcBGg9kcG310MsS994QgXA/UJna5yOLdN0
 RTFrR3MCgTX+JIzVP+Vo+ChU9Q==
X-Google-Smtp-Source: APXvYqxjPt2JC2YfUozMEequLO6Ww9cVjZnaL3DEWDkdrODFpfGzVapMtI7VpJ4zBUUP+Tg+06fPfQ==
X-Received: by 2002:a05:6000:1c4:: with SMTP id
 t4mr3812370wrx.183.1569349528338; 
 Tue, 24 Sep 2019 11:25:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t14sm1531397wrs.6.2019.09.24.11.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 11:25:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8F031FF87;
 Tue, 24 Sep 2019 19:25:26 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-7-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 06/16] cputlb: Introduce TLB_BSWAP
In-reply-to: <20190923230004.9231-7-richard.henderson@linaro.org>
Date: Tue, 24 Sep 2019 19:25:26 +0100
Message-ID: <87zhita6w9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Handle bswap on ram directly in load/store_helper.  This fixes a
> bug with the previous implementation in that one cannot use the
> I/O path for RAM.
>
> Fixes: a26fc6f5152b47f1
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h |  4 ++-
>  accel/tcg/cputlb.c     | 62 ++++++++++++++++++++++--------------------
>  2 files changed, 36 insertions(+), 30 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index e0c8dc540c..d148bded35 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -335,12 +335,14 @@ CPUArchState *cpu_copy(CPUArchState *env);
>  #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
>  /* Set if TLB entry contains a watchpoint.  */
>  #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
> +/* Set if TLB entry requires byte swap.  */
> +#define TLB_BSWAP           (1 << (TARGET_PAGE_BITS_MIN - 5))
>
>  /* Use this mask to check interception with an alignment mask
>   * in a TCG backend.
>   */
>  #define TLB_FLAGS_MASK \
> -    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT)
> +    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT | TLB_B=
SWAP)
>
>  /**
>   * tlb_hit_page: return true if page aligned @addr is a hit against the
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 430ba4a69d..f634edb4f4 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -737,8 +737,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>          address |=3D TLB_INVALID_MASK;
>      }
>      if (attrs.byte_swap) {
> -        /* Force the access through the I/O slow path.  */
> -        address |=3D TLB_MMIO;
> +        address |=3D TLB_BSWAP;
>      }
>      if (!memory_region_is_ram(section->mr) &&
>          !memory_region_is_romd(section->mr)) {
> @@ -901,10 +900,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLB=
Entry *iotlbentry,
>      bool locked =3D false;
>      MemTxResult r;
>
> -    if (iotlbentry->attrs.byte_swap) {
> -        op ^=3D MO_BSWAP;
> -    }
> -
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attr=
s);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> @@ -947,10 +942,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEnt=
ry *iotlbentry,
>      bool locked =3D false;
>      MemTxResult r;
>
> -    if (iotlbentry->attrs.byte_swap) {
> -        op ^=3D MO_BSWAP;
> -    }
> -
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attr=
s);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> @@ -1133,8 +1124,8 @@ void *probe_access(CPUArchState *env, target_ulong =
addr, int size,
>                               wp_access, retaddr);
>      }
>
> -    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
> -        /* I/O access */
> +    /* Reject I/O access, or other required slow-path.  */
> +    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP)) {
>          return NULL;
>      }
>
> @@ -1344,6 +1335,7 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,
>      /* Handle anything that isn't just a straight memory access.  */
>      if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
>          CPUIOTLBEntry *iotlbentry;
> +        bool need_swap;
>
>          /* For anything that is unaligned, recurse through full_load.  */
>          if ((addr & (size - 1)) !=3D 0) {
> @@ -1357,17 +1349,22 @@ load_helper(CPUArchState *env, target_ulong addr,=
 TCGMemOpIdx oi,
>              /* On watchpoint hit, this will longjmp out.  */
>              cpu_check_watchpoint(env_cpu(env), addr, size,
>                                   iotlbentry->attrs, BP_MEM_READ, retaddr=
);
> -
> -            /* The backing page may or may not require I/O.  */
> -            tlb_addr &=3D ~TLB_WATCHPOINT;
> -            if ((tlb_addr & ~TARGET_PAGE_MASK) =3D=3D 0) {
> -                goto do_aligned_access;
> -            }
>          }
>
           /* We don't apply MO_BSWAP to op here because we want to
            * ensure the compiler can always unfold and dead-code away
            * the final load_memop in the fast path. If you try the
            * you will find the assert will get you ;-)
            */

?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +        need_swap =3D size > 1 && (tlb_addr & TLB_BSWAP);
> +
>          /* Handle I/O access.  */
> -        return io_readx(env, iotlbentry, mmu_idx, addr,
> -                        retaddr, access_type, op);
> +        if (likely(tlb_addr & TLB_MMIO)) {
> +            return io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
> +                            access_type, op ^ (need_swap * MO_BSWAP));
> +        }
> +
> +        haddr =3D (void *)((uintptr_t)addr + entry->addend);
> +
> +        if (unlikely(need_swap)) {
> +            return load_memop(haddr, op ^ MO_BSWAP);
> +        }
> +        return load_memop(haddr, op);
>      }
>
>      /* Handle slow unaligned access (it spans two pages or IO).  */
> @@ -1394,7 +1391,6 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,
>          return res & MAKE_64BIT_MASK(0, size * 8);
>      }
>
> - do_aligned_access:
>      haddr =3D (void *)((uintptr_t)addr + entry->addend);
>      return load_memop(haddr, op);
>  }
> @@ -1592,6 +1588,7 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
>      /* Handle anything that isn't just a straight memory access.  */
>      if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
>          CPUIOTLBEntry *iotlbentry;
> +        bool need_swap;
>
>          /* For anything that is unaligned, recurse through byte stores. =
 */
>          if ((addr & (size - 1)) !=3D 0) {
> @@ -1605,16 +1602,24 @@ store_helper(CPUArchState *env, target_ulong addr=
, uint64_t val,
>              /* On watchpoint hit, this will longjmp out.  */
>              cpu_check_watchpoint(env_cpu(env), addr, size,
>                                   iotlbentry->attrs, BP_MEM_WRITE, retadd=
r);
> -
> -            /* The backing page may or may not require I/O.  */
> -            tlb_addr &=3D ~TLB_WATCHPOINT;
> -            if ((tlb_addr & ~TARGET_PAGE_MASK) =3D=3D 0) {
> -                goto do_aligned_access;
> -            }
>          }
>
> +        need_swap =3D size > 1 && (tlb_addr & TLB_BSWAP);
> +
>          /* Handle I/O access.  */
> -        io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, op);
> +        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
> +            io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
> +                      op ^ (need_swap * MO_BSWAP));
> +            return;
> +        }
> +
> +        haddr =3D (void *)((uintptr_t)addr + entry->addend);
> +
> +        if (unlikely(need_swap)) {
> +            store_memop(haddr, val, op ^ MO_BSWAP);
> +        } else {
> +            store_memop(haddr, val, op);
> +        }
>          return;
>      }
>
> @@ -1683,7 +1688,6 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
>          return;
>      }
>
> - do_aligned_access:
>      haddr =3D (void *)((uintptr_t)addr + entry->addend);
>      store_memop(haddr, val, op);
>  }


--
Alex Benn=C3=A9e

