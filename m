Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B779EC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B012078B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B012078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCt7K-0007tf-Li
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 19:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCt6k-0007SG-GE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:21:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCt6i-0006rL-OC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 19:21:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id ay8so7048803edb.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 16:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UWLyMkxPSi6pThKRB6TYhg+mSKjB4IEepc5JIpIwtg8=;
 b=I9yXTpiNRdG/gorTx95975IjcK4y3DzAoI7elSTqfkrrtzIV/DikcRQapHiqNey+ce
 tWuIl3UxJQHNGa23UfkQNQX7Jnjz7g1T0nlc1t2RIf2gm2hBM5Vzq5sPT9AFflcNZWcC
 nEXn0xSDeSQXVjr8DbYf4Zhxu1F45gb+k5+3NrW9pp8UohLEYjjCZAiJ0g6XBZxNBW1o
 NZUjwOx31IE4ykVWXB5P64KiLSw+oKtZ8NrSX3cNrmpCsYTscVhqNC8e2+DxCjFlsVEH
 XLphx+VkpE8WlNVaxxSjqX67CyZxXBCGFFBFu9XTmSXzdIkh1JVisShnv+52d/zC0BQX
 zo/A==
X-Gm-Message-State: AOAM530VwmuYWYzlklUXl+HI3NwY9HGuGRrF84FpztRdvIM8PLjqvpgr
 dezcM+ZCa3J7BplK0R3pX1jD7j8ZmpId7A2Tfk0=
X-Google-Smtp-Source: ABdhPJzrB9OXGlTit2nS/2E/ys0SINkWCyeyE1oe4qaQNUrSJLuKL726KyiD8gCdZk20SSOFs//J5pkpMOJq6NKlhyY=
X-Received: by 2002:a05:6402:114d:: with SMTP id
 g13mr3157995edw.157.1598916059177; 
 Mon, 31 Aug 2020 16:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200831222945.875453-1-richard.henderson@linaro.org>
 <20200831222945.875453-2-richard.henderson@linaro.org>
In-Reply-To: <20200831222945.875453-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 1 Sep 2020 01:20:45 +0200
Message-ID: <CAAdtpL5ZYuHiUTKRC9UpJduA-yYufH0trGUTZ1OvL_Nt1GCbWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tcg: Adjust simd_desc size encoding
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bba97c05ae34a70d"
Received-SPF: pass client-ip=209.85.208.66;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 19:20:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: frank.chang@sifive.com, alex.bennee@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bba97c05ae34a70d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 1 sept. 2020 00:31, Richard Henderson <richard.henderson@linaro.org=
>
a =C3=A9crit :

> With larger vector sizes, it turns out oprsz =3D=3D maxsz, and we only
> need to represent mismatch for oprsz <=3D 32.  We do, however, need
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
>

Nice trick :)

+ */
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
> +    uint32_t f =3D extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS);
> +    intptr_t o =3D f * 8 + 8;
> +    intptr_t m =3D simd_maxsz(desc);
> +    return f =3D=3D 2 ? m : o;
>  }
>
>  /* Extract the operation-specific data from a descriptor.  */
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index 7ebd9e8298..ddbe06b71a 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -37,11 +37,21 @@ static const TCGOpcode vecop_list_empty[1] =3D { 0 };
>     of the operand offsets so that we can check them all at once.  */
>  static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t of=
s)
>  {
> -    uint32_t opr_align =3D oprsz >=3D 16 ? 15 : 7;
> -    uint32_t max_align =3D maxsz >=3D 16 || oprsz >=3D 16 ? 15 : 7;
> -    tcg_debug_assert(oprsz > 0);
> -    tcg_debug_assert(oprsz <=3D maxsz);
> -    tcg_debug_assert((oprsz & opr_align) =3D=3D 0);
> +    uint32_t max_align;
> +
> +    switch (oprsz) {
> +    case 8:
> +    case 16:
> +    case 32:
> +        tcg_debug_assert(oprsz <=3D maxsz);
> +        break;
> +    default:
> +        tcg_debug_assert(oprsz =3D=3D maxsz);
> +        break;
> +    }
> +    tcg_debug_assert(maxsz <=3D (8 << SIMD_MAXSZ_BITS));
> +
> +    max_align =3D maxsz >=3D 16 ? 15 : 7;
>      tcg_debug_assert((maxsz & max_align) =3D=3D 0);
>      tcg_debug_assert((ofs & max_align) =3D=3D 0);
>  }
> @@ -77,12 +87,21 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz,
> int32_t data)
>  {
>      uint32_t desc =3D 0;
>
> -    assert(oprsz % 8 =3D=3D 0 && oprsz <=3D (8 << SIMD_OPRSZ_BITS));
> -    assert(maxsz % 8 =3D=3D 0 && maxsz <=3D (8 << SIMD_MAXSZ_BITS));
> -    assert(data =3D=3D sextract32(data, 0, SIMD_DATA_BITS));
> +    check_size_align(oprsz, maxsz, 0);
> +    tcg_debug_assert(data =3D=3D sextract32(data, 0, SIMD_DATA_BITS));
>
>      oprsz =3D (oprsz / 8) - 1;
>      maxsz =3D (maxsz / 8) - 1;
> +
> +    /*
> +     * We have just asserted in check_size_align that either
> +     * oprsz is {8,16,32} or matches maxsz.  Encode the final
> +     * case with '2', as that would otherwise map to 24.
> +     */
> +    if (oprsz =3D=3D maxsz) {
> +        oprsz =3D 2;
> +    }
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

+
>      desc =3D deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
>      desc =3D deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
>      desc =3D deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
> --
> 2.25.1
>
>
>

--000000000000bba97c05ae34a70d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le mar. 1 sept. 2020 00:31, Richard Henderson &lt;<a href=
=3D"mailto:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferre=
r">richard.henderson@linaro.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">With larger vector sizes, it turns out oprsz =3D=
=3D maxsz, and we only<br>
need to represent mismatch for oprsz &lt;=3D 32.=C2=A0 We do, however, need=
<br>
to represent larger oprsz and do so without reducing SIMD_DATA_BITS.<br>
<br>
Reduce the size of the oprsz field and increase the maxsz field.<br>
Steal the oprsz value of 24 to indicate equality with maxsz.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" rel=3D"noreferrer noreferrer" target=3D"_blank">richard.henderson=
@linaro.org</a>&gt;<br>
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
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Nic=
e trick :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
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
+=C2=A0 =C2=A0 }<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><span style=3D"font-family:sans-serif;font-size:13.696px">R=
eviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@=
amsat.org" style=3D"text-decoration:none;color:rgb(66,133,244);font-family:=
sans-serif;font-size:13.696px">f4bug@amsat.org</a><span style=3D"font-famil=
y:sans-serif;font-size:13.696px">&gt;</span><br></div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0desc =3D deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_B=
ITS, oprsz);<br>
=C2=A0 =C2=A0 =C2=A0desc =3D deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_B=
ITS, maxsz);<br>
=C2=A0 =C2=A0 =C2=A0desc =3D deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BIT=
S, data);<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000bba97c05ae34a70d--

