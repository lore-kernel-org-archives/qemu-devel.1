Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EF32074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VX6XotsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EF32074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6g2d-0007TV-6u
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k6g1z-000746-K6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:10:27 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k6g1w-00010x-UO
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:10:27 -0400
Received: by mail-ej1-x644.google.com with SMTP id kq25so11186763ejb.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y0IiI+xcF7eYRGkocL5IERNpEZ2gqc2ZXFTeekRmT34=;
 b=VX6XotsAXQjrHgimVGfxrGTRcmWVJQuxXf8s9SHkejnE1gfM02rHVc6Pt1n14FTyTx
 qA4PZxKKiSc3qkilfjl/vLmSRu5h62HF8SOqR+hqqEOH3NGBdz95hu7684D7/FjnbOQf
 Pyiisoe0735dVd5Loc8NUoR9fSunLpJDwaSJ3gb9qWAoT+QYQOUVex60a4EWfUhrerXg
 t+TAKIPeGrUKbMhkbmZkvOV0uRZ2ANKZM/XaSWmBNDYUXDooVAznrzppDsTE8P+4EqQF
 rj8W8kHIoeUTpO3uIf1lCYzFYq71egT5EWV6zhIQz/GkkxT3Iy0GSa39q3pqyNmW4Jkr
 BOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y0IiI+xcF7eYRGkocL5IERNpEZ2gqc2ZXFTeekRmT34=;
 b=iVFimbhMpSNot0zbKWytb4kUGnIM6fmbyJYsUw3dEAHW7P+QN57vjYUCHk+ZE+xr/P
 l92dcluWnu84n1jFVcktYMt7kDJBAFDtz+9wwlGrSqmpejtfmIlO1V6D9WHNECq5Mh+9
 EWPBXDl+ZLlJOgEBhOoMC3PeiN4TsXDlbJeuv89os1xkg8ZRPb8bz9/9J2G7QgbWs1mC
 X04XzPFIoy3kr2ORVf93SubH2THP2d2hfWQa+s71VQr/oeYbBbTYMesKjVKcbPs7wWVA
 DSspVX/sl7+gAA0D0CP76I2GM/n1WBk2pzDPRMX15R8WrOXe1d3se2Jgl/RVFNufgQPJ
 YYvw==
X-Gm-Message-State: AOAM531NNpW02bNKJEG+zsbxa//SjQ84D23UXVskhSePpG7BA3XNSktk
 sW1ur1SXBKkFVvt5NhQ9M9xe4JLZznw520hy2v/8Ig==
X-Google-Smtp-Source: ABdhPJzUWNW2neZLe5NZOvR88+8ZPW1bAGpszk7Du/P/ETeug7m4b9fCRoimbrI0bkCTNvVg4sWD+Jx+1dlGkCiOoPo=
X-Received: by 2002:a17:906:2356:: with SMTP id
 m22mr3974931eja.124.1597435821621; 
 Fri, 14 Aug 2020 13:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200813204024.3077275-1-richard.henderson@linaro.org>
 <20200813204024.3077275-2-richard.henderson@linaro.org>
In-Reply-To: <20200813204024.3077275-2-richard.henderson@linaro.org>
From: Shu-Chun Weng <scw@google.com>
Date: Fri, 14 Aug 2020 13:10:10 -0700
Message-ID: <CAF3nBxiLMb=K8j1Vf4F=K-WudHpZDos9YYah7DUpJ_OYCDUK1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] cputlb: Make store_helper less fragile to compiler
 optimizations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000bafcfc05acdc0296"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=scw@google.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bafcfc05acdc0296
Content-Type: multipart/alternative; boundary="000000000000b3771e05acdc0248"

--000000000000b3771e05acdc0248
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can confirm this fixed the build in our configuration. Thank you.

Shu-Chun

On Thu, Aug 13, 2020 at 1:40 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This has no functional change.
>
> The current function structure is:
>
>     inline QEMU_ALWAYSINLINE
>     store_memop() {
>         switch () {
>             ...
>         default:
>             qemu_build_not_reached();
>         }
>     }
>     inline QEMU_ALWAYSINLINE
>     store_helper() {
>         ...
>         if (span_two_pages_or_io) {
>             ...
>             helper_ret_stb_mmu();
>         }
>         store_memop();
>     }
>     helper_ret_stb_mmu() {
>         store_helper();
>     }
>
> Whereas GCC will generate an error at compile-time when an always_inline
> function is not inlined, Clang does not.  Nor does Clang prioritize the
> inlining of always_inline functions.  Both of these are arguably bugs.
>
> Both `store_memop` and `store_helper` need to be inlined and allow
> constant propogations to eliminate the `qemu_build_not_reached` call.
>
> However, if the compiler instead chooses to inline helper_ret_stb_mmu
> into store_helper, then store_helper is now self-recursive and the
> compiler is no longer able to propagate the constant in the same way.
>
> This does not produce at current QEMU head, but was reproducible
> at v4.2.0 with `clang-10 -O2 -fexperimental-new-pass-manager`.
>
> The inline recursion problem can be fixed solely by marking
> helper_ret_stb_mmu as noinline, so the compiler does not make an
> incorrect decision about which functions to inline.
>
> In addition, extract store_helper_unaligned as a noinline subroutine
> that can be shared by all of the helpers.  This saves about 6k code
> size in an optimized x86_64 build.
>
> Reported-by: Shu-Chun Weng <scw@google.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/cputlb.c | 138 ++++++++++++++++++++++++++-------------------
>  1 file changed, 79 insertions(+), 59 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 5698292749..7e603d6666 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2009,6 +2009,80 @@ store_memop(void *haddr, uint64_t val, MemOp op)
>      }
>  }
>
> +static void __attribute__((noinline))
> +store_helper_unaligned(CPUArchState *env, target_ulong addr, uint64_t va=
l,
> +                       uintptr_t retaddr, size_t size, uintptr_t mmu_idx=
,
> +                       bool big_endian)
> +{
> +    const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);
> +    uintptr_t index, index2;
> +    CPUTLBEntry *entry, *entry2;
> +    target_ulong page2, tlb_addr, tlb_addr2;
> +    TCGMemOpIdx oi;
> +    size_t size2;
> +    int i;
> +
> +    /*
> +     * Ensure the second page is in the TLB.  Note that the first page
> +     * is already guaranteed to be filled, and that the second page
> +     * cannot evict the first.
> +     */
> +    page2 =3D (addr + size) & TARGET_PAGE_MASK;
> +    size2 =3D (addr + size) & ~TARGET_PAGE_MASK;
> +    index2 =3D tlb_index(env, mmu_idx, page2);
> +    entry2 =3D tlb_entry(env, mmu_idx, page2);
> +
> +    tlb_addr2 =3D tlb_addr_write(entry2);
> +    if (!tlb_hit_page(tlb_addr2, page2)) {
> +        if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
> +            tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> +                     mmu_idx, retaddr);
> +            index2 =3D tlb_index(env, mmu_idx, page2);
> +            entry2 =3D tlb_entry(env, mmu_idx, page2);
> +        }
> +        tlb_addr2 =3D tlb_addr_write(entry2);
> +    }
> +
> +    index =3D tlb_index(env, mmu_idx, addr);
> +    entry =3D tlb_entry(env, mmu_idx, addr);
> +    tlb_addr =3D tlb_addr_write(entry);
> +
> +    /*
> +     * Handle watchpoints.  Since this may trap, all checks
> +     * must happen before any store.
> +     */
> +    if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> +        cpu_check_watchpoint(env_cpu(env), addr, size - size2,
> +                             env_tlb(env)->d[mmu_idx].iotlb[index].attrs=
,
> +                             BP_MEM_WRITE, retaddr);
> +    }
> +    if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
> +        cpu_check_watchpoint(env_cpu(env), page2, size2,
> +                             env_tlb(env)->d[mmu_idx].iotlb[index2].attr=
s,
> +                             BP_MEM_WRITE, retaddr);
> +    }
> +
> +    /*
> +     * XXX: not efficient, but simple.
> +     * This loop must go in the forward direction to avoid issues
> +     * with self-modifying code in Windows 64-bit.
> +     */
> +    oi =3D make_memop_idx(MO_UB, mmu_idx);
> +    if (big_endian) {
> +        for (i =3D 0; i < size; ++i) {
> +            /* Big-endian extract.  */
> +            uint8_t val8 =3D val >> (((size - 1) * 8) - (i * 8));
> +            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
> +        }
> +    } else {
> +        for (i =3D 0; i < size; ++i) {
> +            /* Little-endian extract.  */
> +            uint8_t val8 =3D val >> (i * 8);
> +            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
> +        }
> +    }
> +}
> +
>  static inline void QEMU_ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>               TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
> @@ -2097,64 +2171,9 @@ store_helper(CPUArchState *env, target_ulong addr,
> uint64_t val,
>      if (size > 1
>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>                       >=3D TARGET_PAGE_SIZE)) {
> -        int i;
> -        uintptr_t index2;
> -        CPUTLBEntry *entry2;
> -        target_ulong page2, tlb_addr2;
> -        size_t size2;
> -
>      do_unaligned_access:
> -        /*
> -         * Ensure the second page is in the TLB.  Note that the first pa=
ge
> -         * is already guaranteed to be filled, and that the second page
> -         * cannot evict the first.
> -         */
> -        page2 =3D (addr + size) & TARGET_PAGE_MASK;
> -        size2 =3D (addr + size) & ~TARGET_PAGE_MASK;
> -        index2 =3D tlb_index(env, mmu_idx, page2);
> -        entry2 =3D tlb_entry(env, mmu_idx, page2);
> -        tlb_addr2 =3D tlb_addr_write(entry2);
> -        if (!tlb_hit_page(tlb_addr2, page2)) {
> -            if (!victim_tlb_hit(env, mmu_idx, index2, tlb_off, page2)) {
> -                tlb_fill(env_cpu(env), page2, size2, MMU_DATA_STORE,
> -                         mmu_idx, retaddr);
> -                index2 =3D tlb_index(env, mmu_idx, page2);
> -                entry2 =3D tlb_entry(env, mmu_idx, page2);
> -            }
> -            tlb_addr2 =3D tlb_addr_write(entry2);
> -        }
> -
> -        /*
> -         * Handle watchpoints.  Since this may trap, all checks
> -         * must happen before any store.
> -         */
> -        if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
> -            cpu_check_watchpoint(env_cpu(env), addr, size - size2,
> -
>  env_tlb(env)->d[mmu_idx].iotlb[index].attrs,
> -                                 BP_MEM_WRITE, retaddr);
> -        }
> -        if (unlikely(tlb_addr2 & TLB_WATCHPOINT)) {
> -            cpu_check_watchpoint(env_cpu(env), page2, size2,
> -
>  env_tlb(env)->d[mmu_idx].iotlb[index2].attrs,
> -                                 BP_MEM_WRITE, retaddr);
> -        }
> -
> -        /*
> -         * XXX: not efficient, but simple.
> -         * This loop must go in the forward direction to avoid issues
> -         * with self-modifying code in Windows 64-bit.
> -         */
> -        for (i =3D 0; i < size; ++i) {
> -            uint8_t val8;
> -            if (memop_big_endian(op)) {
> -                /* Big-endian extract.  */
> -                val8 =3D val >> (((size - 1) * 8) - (i * 8));
> -            } else {
> -                /* Little-endian extract.  */
> -                val8 =3D val >> (i * 8);
> -            }
> -            helper_ret_stb_mmu(env, addr + i, val8, oi, retaddr);
> -        }
> +        store_helper_unaligned(env, addr, val, retaddr, size,
> +                               mmu_idx, memop_big_endian(op));
>          return;
>      }
>
> @@ -2162,8 +2181,9 @@ store_helper(CPUArchState *env, target_ulong addr,
> uint64_t val,
>      store_memop(haddr, val, op);
>  }
>
> -void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t va=
l,
> -                        TCGMemOpIdx oi, uintptr_t retaddr)
> +void __attribute__((noinline))
> +helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
> +                   TCGMemOpIdx oi, uintptr_t retaddr)
>  {
>      store_helper(env, addr, val, oi, retaddr, MO_UB);
>  }
> --
> 2.25.1
>
>

--000000000000b3771e05acdc0248
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Can confirm this fixed the build in our c=
onfiguration. Thank you.<div><br></div><div>Shu-Chun</div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2=
020 at 1:40 PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">This has no functional change.<br>
<br>
The current function structure is:<br>
<br>
=C2=A0 =C2=A0 inline QEMU_ALWAYSINLINE<br>
=C2=A0 =C2=A0 store_memop() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch () {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_build_not_reached();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 inline QEMU_ALWAYSINLINE<br>
=C2=A0 =C2=A0 store_helper() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (span_two_pages_or_io) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_ret_stb_mmu();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 store_memop();<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 helper_ret_stb_mmu() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 store_helper();<br>
=C2=A0 =C2=A0 }<br>
<br>
Whereas GCC will generate an error at compile-time when an always_inline<br=
>
function is not inlined, Clang does not.=C2=A0 Nor does Clang prioritize th=
e<br>
inlining of always_inline functions.=C2=A0 Both of these are arguably bugs.=
<br>
<br>
Both `store_memop` and `store_helper` need to be inlined and allow<br>
constant propogations to eliminate the `qemu_build_not_reached` call.<br>
<br>
However, if the compiler instead chooses to inline helper_ret_stb_mmu<br>
into store_helper, then store_helper is now self-recursive and the<br>
compiler is no longer able to propagate the constant in the same way.<br>
<br>
This does not produce at current QEMU head, but was reproducible<br>
at v4.2.0 with `clang-10 -O2 -fexperimental-new-pass-manager`.<br>
<br>
The inline recursion problem can be fixed solely by marking<br>
helper_ret_stb_mmu as noinline, so the compiler does not make an<br>
incorrect decision about which functions to inline.<br>
<br>
In addition, extract store_helper_unaligned as a noinline subroutine<br>
that can be shared by all of the helpers.=C2=A0 This saves about 6k code<br=
>
size in an optimized x86_64 build.<br>
<br>
Reported-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" target=3D"=
_blank" class=3D"cremed">scw@google.com</a>&gt;<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank" class=3D"cremed">alex.bennee@linaro.org</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank" class=3D"cremed">richard.henderson@linaro.org</=
a>&gt;<br>
---<br>
=C2=A0accel/tcg/cputlb.c | 138 ++++++++++++++++++++++++++------------------=
-<br>
=C2=A01 file changed, 79 insertions(+), 59 deletions(-)<br>
<br>
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c<br>
index 5698292749..7e603d6666 100644<br>
--- a/accel/tcg/cputlb.c<br>
+++ b/accel/tcg/cputlb.c<br>
@@ -2009,6 +2009,80 @@ store_memop(void *haddr, uint64_t val, MemOp op)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void __attribute__((noinline))<br>
+store_helper_unaligned(CPUArchState *env, target_ulong addr, uint64_t val,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uintptr_t retaddr, size_t size, uintptr_t mmu_idx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bool big_endian)<br>
+{<br>
+=C2=A0 =C2=A0 const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);<=
br>
+=C2=A0 =C2=A0 uintptr_t index, index2;<br>
+=C2=A0 =C2=A0 CPUTLBEntry *entry, *entry2;<br>
+=C2=A0 =C2=A0 target_ulong page2, tlb_addr, tlb_addr2;<br>
+=C2=A0 =C2=A0 TCGMemOpIdx oi;<br>
+=C2=A0 =C2=A0 size_t size2;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Ensure the second page is in the TLB.=C2=A0 Note tha=
t the first page<br>
+=C2=A0 =C2=A0 =C2=A0* is already guaranteed to be filled, and that the sec=
ond page<br>
+=C2=A0 =C2=A0 =C2=A0* cannot evict the first.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 page2 =3D (addr + size) &amp; TARGET_PAGE_MASK;<br>
+=C2=A0 =C2=A0 size2 =3D (addr + size) &amp; ~TARGET_PAGE_MASK;<br>
+=C2=A0 =C2=A0 index2 =3D tlb_index(env, mmu_idx, page2);<br>
+=C2=A0 =C2=A0 entry2 =3D tlb_entry(env, mmu_idx, page2);<br>
+<br>
+=C2=A0 =C2=A0 tlb_addr2 =3D tlb_addr_write(entry2);<br>
+=C2=A0 =C2=A0 if (!tlb_hit_page(tlb_addr2, page2)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!victim_tlb_hit(env, mmu_idx, index2, tlb_=
off, page2)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_fill(env_cpu(env), page2, si=
ze2, MMU_DATA_STORE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mmu_idx, retaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index2 =3D tlb_index(env, mmu_id=
x, page2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry2 =3D tlb_entry(env, mmu_id=
x, page2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_addr2 =3D tlb_addr_write(entry2);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 index =3D tlb_index(env, mmu_idx, addr);<br>
+=C2=A0 =C2=A0 entry =3D tlb_entry(env, mmu_idx, addr);<br>
+=C2=A0 =C2=A0 tlb_addr =3D tlb_addr_write(entry);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Handle watchpoints.=C2=A0 Since this may trap, all c=
hecks<br>
+=C2=A0 =C2=A0 =C2=A0* must happen before any store.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (unlikely(tlb_addr &amp; TLB_WATCHPOINT)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_check_watchpoint(env_cpu(env), addr, size =
- size2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_tlb(env)-&gt;d[mmu_idx].iotlb[index].att=
rs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BP_MEM_WRITE, retaddr);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (unlikely(tlb_addr2 &amp; TLB_WATCHPOINT)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_check_watchpoint(env_cpu(env), page2, size=
2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_tlb(env)-&gt;d[mmu_idx].iotlb[index2].at=
trs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BP_MEM_WRITE, retaddr);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* XXX: not efficient, but simple.<br>
+=C2=A0 =C2=A0 =C2=A0* This loop must go in the forward direction to avoid =
issues<br>
+=C2=A0 =C2=A0 =C2=A0* with self-modifying code in Windows 64-bit.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 oi =3D make_memop_idx(MO_UB, mmu_idx);<br>
+=C2=A0 =C2=A0 if (big_endian) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; size; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Big-endian extract.=C2=A0 */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t val8 =3D val &gt;&gt; ((=
(size - 1) * 8) - (i * 8));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + i=
, val8, oi, retaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; size; ++i) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Little-endian extract.=C2=A0 =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t val8 =3D val &gt;&gt; (i=
 * 8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + i=
, val8, oi, retaddr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0static inline void QEMU_ALWAYS_INLINE<br>
=C2=A0store_helper(CPUArchState *env, target_ulong addr, uint64_t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGMemOpIdx oi, uintptr_t =
retaddr, MemOp op)<br>
@@ -2097,64 +2171,9 @@ store_helper(CPUArchState *env, target_ulong addr, u=
int64_t val,<br>
=C2=A0 =C2=A0 =C2=A0if (size &gt; 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;&amp; unlikely((addr &amp; ~TARGET_P=
AGE_MASK) + size - 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &gt;=3D TARGET_PAGE_SIZE)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t index2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 CPUTLBEntry *entry2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong page2, tlb_addr2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size2;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0do_unaligned_access:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Ensure the second page is in the TLB.=
=C2=A0 Note that the first page<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* is already guaranteed to be filled, an=
d that the second page<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* cannot evict the first.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 page2 =3D (addr + size) &amp; TARGET_PAGE_MASK=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 size2 =3D (addr + size) &amp; ~TARGET_PAGE_MAS=
K;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 index2 =3D tlb_index(env, mmu_idx, page2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 entry2 =3D tlb_entry(env, mmu_idx, page2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_addr2 =3D tlb_addr_write(entry2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tlb_hit_page(tlb_addr2, page2)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!victim_tlb_hit(env, mmu_idx=
, index2, tlb_off, page2)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_fill(env_cpu(e=
nv), page2, size2, MMU_DATA_STORE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mmu_idx, retaddr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index2 =3D tlb_ind=
ex(env, mmu_idx, page2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entry2 =3D tlb_ent=
ry(env, mmu_idx, page2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tlb_addr2 =3D tlb_addr_write(ent=
ry2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Handle watchpoints.=C2=A0 Since this m=
ay trap, all checks<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* must happen before any store.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(tlb_addr &amp; TLB_WATCHPOINT)) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_check_watchpoint(env_cpu(env=
), addr, size - size2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_tlb(env)-&gt;d[mmu_idx].io=
tlb[index].attrs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BP_MEM_WRITE, retaddr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(tlb_addr2 &amp; TLB_WATCHPOINT)) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_check_watchpoint(env_cpu(env=
), page2, size2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env_tlb(env)-&gt;d[mmu_idx].io=
tlb[index2].attrs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BP_MEM_WRITE, retaddr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* XXX: not efficient, but simple.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* This loop must go in the forward direc=
tion to avoid issues<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* with self-modifying code in Windows 64=
-bit.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; size; ++i) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t val8;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memop_big_endian(op)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Big-endian extr=
act.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val8 =3D val &gt;&=
gt; (((size - 1) * 8) - (i * 8));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Little-endian e=
xtract.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val8 =3D val &gt;&=
gt; (i * 8);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 helper_ret_stb_mmu(env, addr + i=
, val8, oi, retaddr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 store_helper_unaligned(env, addr, val, retaddr=
, size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmu_idx, memop_big_endian(op));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2162,8 +2181,9 @@ store_helper(CPUArchState *env, target_ulong addr, ui=
nt64_t val,<br>
=C2=A0 =C2=A0 =C2=A0store_memop(haddr, val, op);<br>
=C2=A0}<br>
<br>
-void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 TCGMemOpIdx oi, uintptr_t retaddr)<br>
+void __attribute__((noinline))<br>
+helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGMe=
mOpIdx oi, uintptr_t retaddr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0store_helper(env, addr, val, oi, retaddr, MO_UB);<br>
=C2=A0}<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div></div>

--000000000000b3771e05acdc0248--

--000000000000bafcfc05acdc0296
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQB0zgx4rAhCKzIVBMrEn4R/8FrisDQWZwJvA4VLbgtBPI1kP/Ys+cw3oYecxHED
MAHXOYclqmcaKudfjsLKZ/jrpdjZMAHDazo86g4BREWWiAxAtnMPhKrL4Ciqs0Yx/fj4VJlJRgES
1wscHQQNh2BgbqP15O5D2CtZVsLIuc9pSY3DZNYUrMQy55hszPnhgeghImVgNLtzUkF8oLKlnrWs
blvMc7fi7e42/rSnhbE6WUWGHvXcQ3+qIptP079GF+p1ZnEVmXIrQeoP1Rh0wS2ThPBorHqMY8OB
+c1AbPa2A/qY7QkFA6Oq7I8gUPNRO1NyuEElN4LJy+SCH0kWzLawMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhAB2NRaeBKJjaSQ9CGctwQsMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCD+8Le94CgbldYo2rYaHIVkVEnmlOInuelcrjjSEerCtDAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MTQyMDEwMjJaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAT8bT
RAlFZLA6BqoG9KgYElp3jvT2MJ5N6/sQjtgkTuy54SnMhBJ8rauEmm8qxxfgSRCelOXR1daJxMi4
AzZJybHyFDBER4RQfvj8xdjt87YIaaulLvAqN+BvRV/i4iGNp7YIX0fUKm/kfQ27M4yxrOqruXJ+
wU3ngQhbRSDgvLLSe00lDuTVdBO1toa26IRp1/RgHyXC1z2EG7LG/A2xF88mI27bzNmazBA32+Ws
aFbedOpKfL0ncs5KNTtnm1IchfpRCfVqV+aX8r9h2IZSsaMpuMpiyV21sN8Xq5jap6wIsMzESACQ
oXph8IrA9r7BQJQwiF3Yp7i3AdCEiHxuhQ==
--000000000000bafcfc05acdc0296--

