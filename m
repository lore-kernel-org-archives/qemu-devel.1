Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC1C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E54E20656
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKIBhgtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E54E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHHv-0000An-0X
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyHFz-00070S-7P
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hyHFv-00008L-8H
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:01:39 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hyHFv-00007i-38
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:01:35 -0400
Received: by mail-ot1-x342.google.com with SMTP id e12so6451451otp.10
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=YGsvfCjzbJxPrhZMIVpEtAlRXOnZ4RxeD9tcTlBNJkY=;
 b=bKIBhgtQUx71IJ+eOxaxQlCfCawqybrRPIcFGfmYZK7utbxV6Qd3ph+0tmdx+D7oOh
 XYqc/Hm6lDKTdqXh/I5c9g2Eoy7SHeaaUMWSKqlgO9ylX4ET3H/DZK1eCDvOsc5GjvrE
 67vnSMZByi6trTLLo6TGXT0UPxFm7OzueMqbJDV1Xmghz/IPUugUnKxn5yNSy917wRew
 GaHB5rUdM47v8iyFTfYGmM9vqER+U4y0Bg13auDW3T4nU98BHXBkUEBaw4PJ+d3W5MGu
 /awGoyzUATg0+OiIpBiWmaGYfwJfwSk9h7TUAn2ew+EzMvdFTmeD+aQ0kb/AryGy1rvs
 91xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=YGsvfCjzbJxPrhZMIVpEtAlRXOnZ4RxeD9tcTlBNJkY=;
 b=H19MjDCxtsSDwJMS4j1t3GDrvtlmlS+d8XZuFSMyjyOu81WOr1t/Gx4dvVXL10GdbJ
 Ktw6TFCruWVo3ZY4Q8jmGYPCua+7K+yjjL2LQzfLGXseVZvPLQ4RuE1/s27a80mooNEg
 LNc1bQhveJ1RuPJPz8rm3ZFHNipClWXG7DOlM3E2s4Pa0CUqzCvVA0LDKMz9+eY/Fia6
 0/vycSpDq2QjwVDY1Z9JJ0dTIRCMvqv0kimIBGFGGDbHEXrlXjn0wt3OvjEnb9XjKBxl
 5zwWi1U+N2Ju0mgj0CSFopN0ZmmRON4MXUjsDJEbqOaA+7fNdzOUXtwIowKVk5dV4jP4
 Ry2Q==
X-Gm-Message-State: APjAAAXRSFCtrXYRbvoGRWiw6/CkC4MFuWWqCPaSeOtHsYQckULbKoFe
 rQHLxoViceRmvj901aNPGZd4l3QBp/8cJSD9jR8=
X-Google-Smtp-Source: APXvYqxj6iGQr3Z+I9iRGO98Ga6kP6n1IUQ+vGvPyOYvxVnFjCM00VsLo+tV3C1Y/tbMsxQQdNtnKLIgzw3aIZEwNTY=
X-Received: by 2002:a9d:851:: with SMTP id 75mr4046027oty.341.1565881294175;
 Thu, 15 Aug 2019 08:01:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 08:01:33
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Thu, 15 Aug 2019 08:01:33
 -0700 (PDT)
In-Reply-To: <20190815020928.9679-16-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-16-jan.bobek@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 15 Aug 2019 17:01:33 +0200
Message-ID: <CAL1e-=jNu8w-9wgkz5Ug-uZKWreEY=6EqD_cYN_KY_qXfn2TPQ@mail.gmail.com>
To: Jan Bobek <jan.bobek@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC PATCH v3 15/46] target/i386: introduce
 function ck_cpuid
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.08.2019. 04.23, "Jan Bobek" <jan.bobek@gmail.com> =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Introduce a helper function to take care of instruction CPUID checks.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---

Jan, what is the origin of "CK"? If it is a QEMU internal thing, perhaps
use "CHECK".

The function should be called check_cpuid(), imho. I know, Richard would
like c_ci(), or simpler cc(), better.

Aleksandar

>  target/i386/translate.c | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 6296a02991..0cffa2226b 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -4500,6 +4500,54 @@ static void gen_sse(CPUX86State *env, DisasContext
*s, int b)
>  #define tcg_gen_gvec_cmpgt(vece, dofs, aofs, bofs, oprsz, maxsz)        =
\
>      tcg_gen_gvec_cmp(TCG_COND_GT, vece, dofs, aofs, bofs, oprsz, maxsz)
>
> +typedef enum {
> +    CK_CPUID_MMX =3D 1,
> +    CK_CPUID_3DNOW,
> +    CK_CPUID_SSE,
> +    CK_CPUID_SSE2,
> +    CK_CPUID_CLFLUSH,
> +    CK_CPUID_SSE3,
> +    CK_CPUID_SSSE3,
> +    CK_CPUID_SSE4_1,
> +    CK_CPUID_SSE4_2,
> +    CK_CPUID_SSE4A,
> +    CK_CPUID_AVX,
> +    CK_CPUID_AVX2,
> +} CkCpuidFeat;
> +
> +static int ck_cpuid(CPUX86State *env, DisasContext *s, CkCpuidFeat feat)
> +{
> +    switch (feat) {
> +    case CK_CPUID_MMX:
> +        return !(s->cpuid_features & CPUID_MMX)
> +            || !(s->cpuid_ext2_features & CPUID_EXT2_MMX);
> +    case CK_CPUID_3DNOW:
> +        return !(s->cpuid_ext2_features & CPUID_EXT2_3DNOW);
> +    case CK_CPUID_SSE:
> +        return !(s->cpuid_features & CPUID_SSE);
> +    case CK_CPUID_SSE2:
> +        return !(s->cpuid_features & CPUID_SSE2);
> +    case CK_CPUID_CLFLUSH:
> +        return !(s->cpuid_features & CPUID_CLFLUSH);
> +    case CK_CPUID_SSE3:
> +        return !(s->cpuid_ext_features & CPUID_EXT_SSE3);
> +    case CK_CPUID_SSSE3:
> +        return !(s->cpuid_ext_features & CPUID_EXT_SSSE3);
> +    case CK_CPUID_SSE4_1:
> +        return !(s->cpuid_ext_features & CPUID_EXT_SSE41);
> +    case CK_CPUID_SSE4_2:
> +        return !(s->cpuid_ext_features & CPUID_EXT_SSE42);
> +    case CK_CPUID_SSE4A:
> +        return !(s->cpuid_ext3_features & CPUID_EXT3_SSE4A);
> +    case CK_CPUID_AVX:
> +        return !(s->cpuid_ext_features & CPUID_EXT_AVX);
> +    case CK_CPUID_AVX2:
> +        return !(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
>  {
>      enum {
> --
> 2.20.1
>
>
