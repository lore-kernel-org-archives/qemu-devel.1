Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68DFC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0664206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGe+A9Rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0664206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSc8U-0002fb-7p
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:51:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSc7a-0002BD-SH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSc7Z-0007Lw-4c
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:50:06 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hSc7V-0007KM-AV; Mon, 20 May 2019 02:50:01 -0400
Received: by mail-ot1-x343.google.com with SMTP id 66so12032941otq.0;
	Sun, 19 May 2019 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=RMFZTcj1SMhPHGN1uDyd4+muDGvsbNv2jruN7dX36t0=;
	b=IGe+A9RjsJm/jz6ME3xw7/MPD9hKb7OjX++gPwjaPMf0lOx85OEgurvGWaw1n/Pvj/
	myejYbkPMIglnw5ST+5FQXGW5QQHIOW9d+muGLY3mB/7H2NyTukroTK1UcCdeHx2XS11
	UWFwHoucC93oioo1As+bM+7VmyUxRp3sSOWPnF8IMWwsWW7mpYEfeoX8dP+4VGh+vxof
	OWRWQQGORLjHIlKcX61aCngfdxPvzXqEELpQZiPnxdfhAKvVKLMg0swmnKqgJtQqBddH
	S7SL4nNr3nN1c/YDs2UAn2CXMRqjExmRhF09oEtELel96ubEXwLOPVQTsDbGaceTFCmG
	9avg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=RMFZTcj1SMhPHGN1uDyd4+muDGvsbNv2jruN7dX36t0=;
	b=fWe/J+77Xoy8RIda3T6XMhyBybe0s30nI8e2dUsnrpDmOM+UTFxS3cRsmSWNwtBvTx
	ehOmVvZ2ab39gUHtGfyC1Paf7F14fXz9/erRTtaGqt4aPDDC9phIIbYAlP0Y9k/CUCbq
	mAvNSFjxKkzYz9LYIDXCghSJDTK34kN9cySEnU8NKLGrh8KY8LJrbca9VPIBlaHIHBLK
	CLoHt06nj04j1ciVS/Vw9AefwCsLgjzSs7IcA+YDBz84nQ0IHEJHchADYRooSWkxWU/H
	Ljh07kI+/7Ogqcuy15606biWE6a4JsdF1wIlc9hVytrnu2Z9xNSgLvGgD0BYRGdutSkZ
	4Yfw==
X-Gm-Message-State: APjAAAU09TA2fFHXlU/sX7mmbgbpiBqp+3Jgx2hIGEqQ9wcfYTi19QDC
	jwWvfXJFdDhOO8RbBpAKSdNjfInhIbPSWXAbT4g=
X-Google-Smtp-Source: APXvYqwfwJdXO6YorcFK6X7hJg9/DfWlGTKwxhub2GxkeZHWoAQ0hOZke/lwUr0MBbLwRJZi6A82KyH8zfLFn/YEQLs=
X-Received: by 2002:a05:6830:160a:: with SMTP id
	g10mr276332otr.121.1558335000447; 
	Sun, 19 May 2019 23:50:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Sun, 19 May 2019 23:49:59
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Sun, 19 May 2019 23:49:59
	-0700 (PDT)
In-Reply-To: <20190518191430.21686-2-richard.henderson@linaro.org>
References: <20190518191430.21686-1-richard.henderson@linaro.org>
	<20190518191430.21686-2-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 08:49:59 +0200
Message-ID: <CAL1e-=h02FkYaKp0r2h0ihY=g2i=JityFyt6Jjw60ZB44=QRLw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/2] target/ppc: Use vector variable shifts
 for VSL, VSR, VSRA
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 18, 2019 9:21 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> The gvec expanders take care of masking the shift amount
> against the element width.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/helper.h                 | 12 ----------
>  target/ppc/int_helper.c             | 37 -----------------------------
>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------

You changed the line

-GEN_VXFORM(vslw, 2, 6);

to be:

+GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);

and left this line unchanged (even though it deals with the same vslw
instruction):

GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \                 vrlwnm,
PPC_NONE, PPC2_ISA300)

I just want to doublecheck - is this really what you wanted to do?

Thanks,
Aleksandar

>  3 files changed, 12 insertions(+), 61 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 638a6e99c4..02b67a333e 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -180,18 +180,6 @@ DEF_HELPER_3(vmuloub, void, avr, avr, avr)
>  DEF_HELPER_3(vmulouh, void, avr, avr, avr)
>  DEF_HELPER_3(vmulouw, void, avr, avr, avr)
>  DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
> -DEF_HELPER_3(vsrab, void, avr, avr, avr)
> -DEF_HELPER_3(vsrah, void, avr, avr, avr)
> -DEF_HELPER_3(vsraw, void, avr, avr, avr)
> -DEF_HELPER_3(vsrad, void, avr, avr, avr)
> -DEF_HELPER_3(vsrb, void, avr, avr, avr)
> -DEF_HELPER_3(vsrh, void, avr, avr, avr)
> -DEF_HELPER_3(vsrw, void, avr, avr, avr)
> -DEF_HELPER_3(vsrd, void, avr, avr, avr)
> -DEF_HELPER_3(vslb, void, avr, avr, avr)
> -DEF_HELPER_3(vslh, void, avr, avr, avr)
> -DEF_HELPER_3(vslw, void, avr, avr, avr)
> -DEF_HELPER_3(vsld, void, avr, avr, avr)
>  DEF_HELPER_3(vslo, void, avr, avr, avr)
>  DEF_HELPER_3(vsro, void, avr, avr, avr)
>  DEF_HELPER_3(vsrv, void, avr, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index f6a088ac08..40a7035df0 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1776,23 +1776,6 @@ VSHIFT(l, 1)
>  VSHIFT(r, 0)
>  #undef VSHIFT
>
> -#define VSL(suffix, element, mask)                                      \
> -    void helper_vsl##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
> -    {                                                                   \
> -        int i;                                                          \
> -                                                                        \
> -        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> -            unsigned int shift = b->element[i] & mask;                  \
> -                                                                        \
> -            r->element[i] = a->element[i] << shift;                     \
> -        }                                                               \
> -    }
> -VSL(b, u8, 0x7)
> -VSL(h, u16, 0x0F)
> -VSL(w, u32, 0x1F)
> -VSL(d, u64, 0x3F)
> -#undef VSL
> -
>  void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>  {
>      int i;
> @@ -1965,26 +1948,6 @@ VNEG(vnegw, s32)
>  VNEG(vnegd, s64)
>  #undef VNEG
>
> -#define VSR(suffix, element, mask)                                      \
> -    void helper_vsr##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
> -    {                                                                   \
> -        int i;                                                          \
> -                                                                        \
> -        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> -            unsigned int shift = b->element[i] & mask;                  \
> -            r->element[i] = a->element[i] >> shift;                     \
> -        }                                                               \
> -    }
> -VSR(ab, s8, 0x7)
> -VSR(ah, s16, 0xF)
> -VSR(aw, s32, 0x1F)
> -VSR(ad, s64, 0x3F)
> -VSR(b, u8, 0x7)
> -VSR(h, u16, 0xF)
> -VSR(w, u32, 0x1F)
> -VSR(d, u64, 0x3F)
> -#undef VSR
> -
>  void helper_vsro(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
>  {
>      int sh = (b->VsrB(0xf) >> 3) & 0xf;
> diff --git a/target/ppc/translate/vmx-impl.inc.c
b/target/ppc/translate/vmx-impl.inc.c
> index 6861f4c5b9..663275b729 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -530,21 +530,21 @@ GEN_VXFORM(vmuleuw, 4, 10);
>  GEN_VXFORM(vmulesb, 4, 12);
>  GEN_VXFORM(vmulesh, 4, 13);
>  GEN_VXFORM(vmulesw, 4, 14);
> -GEN_VXFORM(vslb, 2, 4);
> -GEN_VXFORM(vslh, 2, 5);
> -GEN_VXFORM(vslw, 2, 6);
> +GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
> +GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
> +GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
>  GEN_VXFORM(vrlwnm, 2, 6);
>  GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \
>                  vrlwnm, PPC_NONE, PPC2_ISA300)
> -GEN_VXFORM(vsld, 2, 23);
> -GEN_VXFORM(vsrb, 2, 8);
> -GEN_VXFORM(vsrh, 2, 9);
> -GEN_VXFORM(vsrw, 2, 10);
> -GEN_VXFORM(vsrd, 2, 27);
> -GEN_VXFORM(vsrab, 2, 12);
> -GEN_VXFORM(vsrah, 2, 13);
> -GEN_VXFORM(vsraw, 2, 14);
> -GEN_VXFORM(vsrad, 2, 15);
> +GEN_VXFORM_V(vsld, MO_64, tcg_gen_gvec_shlv, 2, 23);
> +GEN_VXFORM_V(vsrb, MO_8, tcg_gen_gvec_shrv, 2, 8);
> +GEN_VXFORM_V(vsrh, MO_16, tcg_gen_gvec_shrv, 2, 9);
> +GEN_VXFORM_V(vsrw, MO_32, tcg_gen_gvec_shrv, 2, 10);
> +GEN_VXFORM_V(vsrd, MO_64, tcg_gen_gvec_shrv, 2, 27);
> +GEN_VXFORM_V(vsrab, MO_8, tcg_gen_gvec_sarv, 2, 12);
> +GEN_VXFORM_V(vsrah, MO_16, tcg_gen_gvec_sarv, 2, 13);
> +GEN_VXFORM_V(vsraw, MO_32, tcg_gen_gvec_sarv, 2, 14);
> +GEN_VXFORM_V(vsrad, MO_64, tcg_gen_gvec_sarv, 2, 15);
>  GEN_VXFORM(vsrv, 2, 28);
>  GEN_VXFORM(vslv, 2, 29);
>  GEN_VXFORM(vslo, 6, 16);
> --
> 2.17.1
>
>
