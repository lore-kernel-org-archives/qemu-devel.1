Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CBCC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580752371F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 07:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ATJGQfvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580752371F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLics-0002S8-3p
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 03:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kLibT-0001RO-Pe
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:57:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kLibP-00073S-QO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:57:15 -0400
Received: by mail-ot1-x342.google.com with SMTP id 95so1449948ota.13
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WHPS/k8qKUDjaJIS9f8Pmn7sbACtGaa2rqZqCjdT0qM=;
 b=ATJGQfvtzo83KTBVPMWDjuGIZLj2Ha7tMj0cIUJ8MEqVwYMYtYsJDH9Xf8GHslXFJu
 BHQo6QQa9WL3QoWL3PiZB1tgmB9yWsJKZVcXYjK84vioNGsOK2jcL+7f3lC6naKm+hWL
 MPRy3b7URIek4m3QLclCNmQoz0wzTbdPt3N7c3gf2Fclz2DlrsP9zpOJiaTxX96hvzJf
 QvpS5geQ/lPH8CX2ueoHQlUzB2hwMG0p2rXA1ht0bmVrQTbPVTnzjf8JxT4SDjAuoJ74
 Jh3r2y8SQEBPPnf+U45WRDFN/rlMgHqQxbwCYXNumeCHLHl6SUFTUFG2sEwDItZ3bHXt
 yqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WHPS/k8qKUDjaJIS9f8Pmn7sbACtGaa2rqZqCjdT0qM=;
 b=ud/V39Q+DU52VK331UOtU8tzyGc6vPiDb3G7khqdszyxty/DZILk+FzrfWCtGdBNbj
 KhVYVMc3eZp0nTpTAvbF8chjIKc+FnytCV/kCiV6zhsqcHsY9ZE3bov4GVEtNarYGgwr
 rqAjKbDj8XpaM6IxFrAuZi+gPumt/f+UOPvv984lkm24ewoiYgz0OkoEmHddeleBIZhZ
 6k350ajGD/Pc7+HZswc7dZs7Pr0mPnyJj535ps5njkopaECYPZ2k4+NWnVYKMRpVc4WR
 r7JD4eYOdTrSgkllVDuX1wSKCgHT/gN52ieqXx74SsticSgT6XCmOZyBjSCM+FQX0zjW
 W/Og==
X-Gm-Message-State: AOAM5302c5A0BKNXAisyGRqMhH58UB+o3OdjdDAEU5xo+tSYC5O0Ooie
 NYiiAXSlSEVDIhsfzkupUrgteYoqcvBcsMxsyBJd0w==
X-Google-Smtp-Source: ABdhPJwytyU2gL3sWYo3c64NwtkqFBuvjCGOqiq+cgjK17RqLyfITAyxU0s2T80UKONtNxBqPvBjuTY+fKIUofH5f3Y=
X-Received: by 2002:a05:6830:454:: with SMTP id
 d20mr2167278otc.139.1601020629328; 
 Fri, 25 Sep 2020 00:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200831222945.875453-1-richard.henderson@linaro.org>
 <20200831222945.875453-2-richard.henderson@linaro.org>
In-Reply-To: <20200831222945.875453-2-richard.henderson@linaro.org>
From: Frank Chang <frank.chang@sifive.com>
Date: Fri, 25 Sep 2020 15:56:58 +0800
Message-ID: <CAE_xrPibx+=q632CF059GwmbcCTq2ZcONNhpeydcJBu9wKyS6g@mail.gmail.com>
Subject: Re: [PATCH 1/1] tcg: Adjust simd_desc size encoding
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e3c2b205b01ea94f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e3c2b205b01ea94f
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 1, 2020 at 6:29 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> With larger vector sizes, it turns out oprsz == maxsz, and we only
> need to represent mismatch for oprsz <= 32.  We do, however, need
> to represent larger oprsz and do so without reducing SIMD_DATA_BITS.
>
> Reduce the size of the oprsz field and increase the maxsz field.
> Steal the oprsz value of 24 to indicate equality with maxsz.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++-------------
>  tcg/tcg-op-gvec.c           | 35 ++++++++++++++++++++++++++--------
>  2 files changed, 52 insertions(+), 21 deletions(-)
>
> diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
> index 0224ac3e78..704bd86454 100644
> --- a/include/tcg/tcg-gvec-desc.h
> +++ b/include/tcg/tcg-gvec-desc.h
> @@ -20,29 +20,41 @@
>  #ifndef TCG_TCG_GVEC_DESC_H
>  #define TCG_TCG_GVEC_DESC_H
>
> -/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte
> vectors. */
> -#define SIMD_OPRSZ_SHIFT   0
> -#define SIMD_OPRSZ_BITS    5
> +/*
> + * This configuration allows MAXSZ to represent 2048 bytes, and
> + * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
> + *
> + * Encode this with:
> + *   0, 1, 3 -> 8, 16, 32
> + *   2       -> maxsz
> + *
> + * This steals the input that would otherwise map to 24 to match maxsz.
> + */
> +#define SIMD_MAXSZ_SHIFT   0
> +#define SIMD_MAXSZ_BITS    8
>
> -#define SIMD_MAXSZ_SHIFT   (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
> -#define SIMD_MAXSZ_BITS    5
> +#define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
> +#define SIMD_OPRSZ_BITS    2
>
> -#define SIMD_DATA_SHIFT    (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
> +#define SIMD_DATA_SHIFT    (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
>  #define SIMD_DATA_BITS     (32 - SIMD_DATA_SHIFT)
>
>  /* Create a descriptor from components.  */
>  uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);
>
> -/* Extract the operation size from a descriptor.  */
> -static inline intptr_t simd_oprsz(uint32_t desc)
> -{
> -    return (extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS) + 1) * 8;
> -}
> -
>  /* Extract the max vector size from a descriptor.  */
>  static inline intptr_t simd_maxsz(uint32_t desc)
>  {
> -    return (extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) + 1) * 8;
> +    return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
> +}
> +
> +/* Extract the operation size from a descriptor.  */
> +static inline intptr_t simd_oprsz(uint32_t desc)
> +{
> +    uint32_t f = extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS);
> +    intptr_t o = f * 8 + 8;
> +    intptr_t m = simd_maxsz(desc);
> +    return f == 2 ? m : o;
>  }
>
>  /* Extract the operation-specific data from a descriptor.  */
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 7ebd9e8298..ddbe06b71a 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -37,11 +37,21 @@ static const TCGOpcode vecop_list_empty[1] = { 0 };
>     of the operand offsets so that we can check them all at once.  */
>  static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
>  {
> -    uint32_t opr_align = oprsz >= 16 ? 15 : 7;
> -    uint32_t max_align = maxsz >= 16 || oprsz >= 16 ? 15 : 7;
> -    tcg_debug_assert(oprsz > 0);
> -    tcg_debug_assert(oprsz <= maxsz);
> -    tcg_debug_assert((oprsz & opr_align) == 0);
> +    uint32_t max_align;
> +
> +    switch (oprsz) {
> +    case 8:
> +    case 16:
> +    case 32:
> +        tcg_debug_assert(oprsz <= maxsz);
> +        break;
> +    default:
> +        tcg_debug_assert(oprsz == maxsz);
> +        break;
> +    }
> +    tcg_debug_assert(maxsz <= (8 << SIMD_MAXSZ_BITS));
> +
> +    max_align = maxsz >= 16 ? 15 : 7;
>      tcg_debug_assert((maxsz & max_align) == 0);
>      tcg_debug_assert((ofs & max_align) == 0);
>  }
> @@ -77,12 +87,21 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz,
> int32_t data)
>  {
>      uint32_t desc = 0;
>
> -    assert(oprsz % 8 == 0 && oprsz <= (8 << SIMD_OPRSZ_BITS));
> -    assert(maxsz % 8 == 0 && maxsz <= (8 << SIMD_MAXSZ_BITS));
> -    assert(data == sextract32(data, 0, SIMD_DATA_BITS));
> +    check_size_align(oprsz, maxsz, 0);
> +    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
>
>      oprsz = (oprsz / 8) - 1;
>      maxsz = (maxsz / 8) - 1;
> +
> +    /*
> +     * We have just asserted in check_size_align that either
> +     * oprsz is {8,16,32} or matches maxsz.  Encode the final
> +     * case with '2', as that would otherwise map to 24.
> +     */
> +    if (oprsz == maxsz) {
> +        oprsz = 2;
> +    }
> +
>      desc = deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
>      desc = deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
>      desc = deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
> --
> 2.25.1
>
>
Sorry for the late reply, I was blocked by some other stuff recently...

However, I've applied this commit and enlarged RV_VLEN_MAX up to 1024-bit
in my RVV-1.0 patchset.
It can pass our tests with VLEN settings: 128, 256, 512 and 1024.
The changes look great!!

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Tested-by: Frank Chang <frank.chang@sifive.com>

--000000000000e3c2b205b01ea94f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Sep 1, 2020 at 6:29 AM Richard He=
nderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henders=
on@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">With larger vector sizes, it turns =
out oprsz =3D=3D maxsz, and we only<br>
need to represent mismatch for oprsz &lt;=3D 32.=C2=A0 We do, however, need=
<br>
to represent larger oprsz and do so without reducing SIMD_DATA_BITS.<br>
<br>
Reduce the size of the oprsz field and increase the maxsz field.<br>
Steal the oprsz value of 24 to indicate equality with maxsz.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++------------=
-<br>
=C2=A0tcg/tcg-op-gvec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 35 ++++++=
++++++++++++++++++++--------<br>
=C2=A02 files changed, 52 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h<br>
index 0224ac3e78..704bd86454 100644<br>
--- a/include/tcg/tcg-gvec-desc.h<br>
+++ b/include/tcg/tcg-gvec-desc.h<br>
@@ -20,29 +20,41 @@<br>
=C2=A0#ifndef TCG_TCG_GVEC_DESC_H<br>
=C2=A0#define TCG_TCG_GVEC_DESC_H<br>
<br>
-/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vector=
s. */<br>
-#define SIMD_OPRSZ_SHIFT=C2=A0 =C2=A00<br>
-#define SIMD_OPRSZ_BITS=C2=A0 =C2=A0 5<br>
+/*<br>
+ * This configuration allows MAXSZ to represent 2048 bytes, and<br>
+ * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.<br>
+ *<br>
+ * Encode this with:<br>
+ *=C2=A0 =C2=A00, 1, 3 -&gt; 8, 16, 32<br>
+ *=C2=A0 =C2=A02=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt; maxsz<br>
+ *<br>
+ * This steals the input that would otherwise map to 24 to match maxsz.<br=
>
+ */<br>
+#define SIMD_MAXSZ_SHIFT=C2=A0 =C2=A00<br>
+#define SIMD_MAXSZ_BITS=C2=A0 =C2=A0 8<br>
<br>
-#define SIMD_MAXSZ_SHIFT=C2=A0 =C2=A0(SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)<=
br>
-#define SIMD_MAXSZ_BITS=C2=A0 =C2=A0 5<br>
+#define SIMD_OPRSZ_SHIFT=C2=A0 =C2=A0(SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)<=
br>
+#define SIMD_OPRSZ_BITS=C2=A0 =C2=A0 2<br>
<br>
-#define SIMD_DATA_SHIFT=C2=A0 =C2=A0 (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)<=
br>
+#define SIMD_DATA_SHIFT=C2=A0 =C2=A0 (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)<=
br>
=C2=A0#define SIMD_DATA_BITS=C2=A0 =C2=A0 =C2=A0(32 - SIMD_DATA_SHIFT)<br>
<br>
=C2=A0/* Create a descriptor from components.=C2=A0 */<br>
=C2=A0uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);<br>
<br>
-/* Extract the operation size from a descriptor.=C2=A0 */<br>
-static inline intptr_t simd_oprsz(uint32_t desc)<br>
-{<br>
-=C2=A0 =C2=A0 return (extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS) +=
 1) * 8;<br>
-}<br>
-<br>
=C2=A0/* Extract the max vector size from a descriptor.=C2=A0 */<br>
=C2=A0static inline intptr_t simd_maxsz(uint32_t desc)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return (extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) +=
 1) * 8;<br>
+=C2=A0 =C2=A0 return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * =
8 + 8;<br>
+}<br>
+<br>
+/* Extract the operation size from a descriptor.=C2=A0 */<br>
+static inline intptr_t simd_oprsz(uint32_t desc)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t f =3D extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_=
BITS);<br>
+=C2=A0 =C2=A0 intptr_t o =3D f * 8 + 8;<br>
+=C2=A0 =C2=A0 intptr_t m =3D simd_maxsz(desc);<br>
+=C2=A0 =C2=A0 return f =3D=3D 2 ? m : o;<br>
=C2=A0}<br>
<br>
=C2=A0/* Extract the operation-specific data from a descriptor.=C2=A0 */<br=
>
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c<br>
index 7ebd9e8298..ddbe06b71a 100644<br>
--- a/tcg/tcg-op-gvec.c<br>
+++ b/tcg/tcg-op-gvec.c<br>
@@ -37,11 +37,21 @@ static const TCGOpcode vecop_list_empty[1] =3D { 0 };<b=
r>
=C2=A0 =C2=A0 of the operand offsets so that we can check them all at once.=
=C2=A0 */<br>
=C2=A0static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t=
 ofs)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint32_t opr_align =3D oprsz &gt;=3D 16 ? 15 : 7;<br>
-=C2=A0 =C2=A0 uint32_t max_align =3D maxsz &gt;=3D 16 || oprsz &gt;=3D 16 =
? 15 : 7;<br>
-=C2=A0 =C2=A0 tcg_debug_assert(oprsz &gt; 0);<br>
-=C2=A0 =C2=A0 tcg_debug_assert(oprsz &lt;=3D maxsz);<br>
-=C2=A0 =C2=A0 tcg_debug_assert((oprsz &amp; opr_align) =3D=3D 0);<br>
+=C2=A0 =C2=A0 uint32_t max_align;<br>
+<br>
+=C2=A0 =C2=A0 switch (oprsz) {<br>
+=C2=A0 =C2=A0 case 8:<br>
+=C2=A0 =C2=A0 case 16:<br>
+=C2=A0 =C2=A0 case 32:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_debug_assert(oprsz &lt;=3D maxsz);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_debug_assert(oprsz =3D=3D maxsz);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 tcg_debug_assert(maxsz &lt;=3D (8 &lt;&lt; SIMD_MAXSZ_BITS))=
;<br>
+<br>
+=C2=A0 =C2=A0 max_align =3D maxsz &gt;=3D 16 ? 15 : 7;<br>
=C2=A0 =C2=A0 =C2=A0tcg_debug_assert((maxsz &amp; max_align) =3D=3D 0);<br>
=C2=A0 =C2=A0 =C2=A0tcg_debug_assert((ofs &amp; max_align) =3D=3D 0);<br>
=C2=A0}<br>
@@ -77,12 +87,21 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int3=
2_t data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t desc =3D 0;<br>
<br>
-=C2=A0 =C2=A0 assert(oprsz % 8 =3D=3D 0 &amp;&amp; oprsz &lt;=3D (8 &lt;&l=
t; SIMD_OPRSZ_BITS));<br>
-=C2=A0 =C2=A0 assert(maxsz % 8 =3D=3D 0 &amp;&amp; maxsz &lt;=3D (8 &lt;&l=
t; SIMD_MAXSZ_BITS));<br>
-=C2=A0 =C2=A0 assert(data =3D=3D sextract32(data, 0, SIMD_DATA_BITS));<br>
+=C2=A0 =C2=A0 check_size_align(oprsz, maxsz, 0);<br>
+=C2=A0 =C2=A0 tcg_debug_assert(data =3D=3D sextract32(data, 0, SIMD_DATA_B=
ITS));<br>
<br>
=C2=A0 =C2=A0 =C2=A0oprsz =3D (oprsz / 8) - 1;<br>
=C2=A0 =C2=A0 =C2=A0maxsz =3D (maxsz / 8) - 1;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We have just asserted in check_size_align that eithe=
r<br>
+=C2=A0 =C2=A0 =C2=A0* oprsz is {8,16,32} or matches maxsz.=C2=A0 Encode th=
e final<br>
+=C2=A0 =C2=A0 =C2=A0* case with &#39;2&#39;, as that would otherwise map t=
o 24.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (oprsz =3D=3D maxsz) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 oprsz =3D 2;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0desc =3D deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_B=
ITS, oprsz);<br>
=C2=A0 =C2=A0 =C2=A0desc =3D deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_B=
ITS, maxsz);<br>
=C2=A0 =C2=A0 =C2=A0desc =3D deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BIT=
S, data);<br>
-- <br>
2.25.1<br>
<br></blockquote><div><br></div><div>Sorry for the late reply, I was blocke=
d by some other stuff recently...</div><div><br></div><div>However, I&#39;v=
e applied this commit and enlarged=C2=A0RV_VLEN_MAX up to 1024-bit in my RV=
V-1.0 patchset.</div><div>It can pass our tests with VLEN settings: 128, 25=
6, 512 and 1024.</div><div>The changes look great!!</div><div><br></div><di=
v><span style=3D"font-family:sans-serif;font-size:13.696px">Reviewed-by: Fr=
ank Chang &lt;fr</span><a href=3D"mailto:ank.chang@sifive.com">ank.chang@si=
five.com</a><span style=3D"font-family:sans-serif;font-size:13.696px">&gt;<=
/span><br></div><div><span style=3D"font-family:sans-serif;font-size:13.696=
px">Tested-by:=C2=A0</span><span style=3D"font-family:sans-serif;font-size:=
13.696px">Frank Chang &lt;fr</span><a href=3D"mailto:ank.chang@sifive.com">=
ank.chang@sifive.com</a><span style=3D"font-family:sans-serif;font-size:13.=
696px">&gt;</span></div></div></div>

--000000000000e3c2b205b01ea94f--

