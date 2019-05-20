Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B9DC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:21:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81887214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2Vsmyws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81887214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShIh-0001Xn-Kc
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:21:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShFU-0007vi-H3
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hShFR-0007Do-2J
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:18:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hShFQ-0007DK-Rk
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:18:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id w8so14361445wrl.6
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=hTOA/AJ+cnqEXw5KfnctqGUuQgzQPrNruStOu/z+Jkc=;
	b=p2VsmywsgKOgPcHvBC8P0ZSkZebcY4y+YophOAgv8Bsbja7kOY3m/BSRRm8sIDqTKn
	rUw7uaAKNd3komUWJTf/0jtmIDuhYaywXDuKymG3SBWAawDlOeSb4AmwGv+rPY7QpZYH
	RS4hRlsHGthFc7RwOttcdFX+CrvJe2x2yMxf3DH7zYvjjez8fyc4fgJ/LUXNSCDF78Do
	XXbJriIMbyqAi9alkEODB/8gKET0bjrFi73+9bX4j9DOBJQona2eDNoVXbKJZINwqmFR
	T9ohj2VbiBVVYXpnZtBtZMm/wAIW2PXCC10rzfQtj1aLM9bOQrN/B0ZNwK8tMwGOV6RN
	gbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=hTOA/AJ+cnqEXw5KfnctqGUuQgzQPrNruStOu/z+Jkc=;
	b=dfvmnc3v6KcHJKOhQ/875szQ5g54yRjm1v97qNfWmbmXNSVhGbuGI0Tv7d/eFEn5/A
	iNurOAF5mYbARtu9xnq04uQqeObdsTEHK8Acj/fH9/vEj3ZZissxzD9IzidtErCdLYZL
	eU7rdKMSecW7GwXrmxzlAm1FE07cix/nVnnDEtQvOivdWv13zK//6o+rRysKE5BK2mGP
	UW+liI+RI5EeDKhw9THbfOFkPYbo4wSzBGSuct8nr1fUAyvLPN/vX6gXljzICCkJyiPC
	xrVsg4Sxvc/l0GroSQLLBfFPe28nkSGT7O/1XwnLer22Qi7teGhEiF04ad40iYOLgZHG
	+nRA==
X-Gm-Message-State: APjAAAXYwbZPlTK6RaqitnpZGXPez/qcAcBLrtK/Mwdj1Fe/ju34v8zQ
	FCnj1oVjVYMCBlzsEu8kKLGcQQ==
X-Google-Smtp-Source: APXvYqxJEnJaTHzd3d0xMF9gFlusvihOLTZf7bxtOIstPMaabsYkcZBxOmwpX6dq+PH1DmjYJvJgLg==
X-Received: by 2002:a5d:400b:: with SMTP id n11mr44611969wrp.123.1558354711811;
	Mon, 20 May 2019 05:18:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	e2sm13149138wme.32.2019.05.20.05.18.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 05:18:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id DF4DF1FF87;
	Mon, 20 May 2019 13:18:30 +0100 (BST)
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-11-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190517224450.15566-11-jan.bobek@gmail.com>
Date: Mon, 20 May 2019 13:18:30 +0100
Message-ID: <87woilgvzd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [RISU v2 10/11] risu_reginfo_i386: replace
 xfeature constants with symbolic names
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> The original code used "magic numbers", which made it unclear in
> some places. Include a reference to the Intel manual where the
> constants' meaning is discussed.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
> index 35ff7c8..aba5ae3 100644
> --- a/risu_reginfo_i386.c
> +++ b/risu_reginfo_i386.c
> @@ -22,7 +22,25 @@
>
>  #include <asm/sigcontext.h>
>
> -static uint64_t xfeatures =3D 3;  /* SSE */
> +/*
> + * Refer to "Intel(R) 64 and IA-32 Architectures Software Developer's
> + * Manual", Volume 1, Section 13.1 "XSAVE-Supported Features and
> + * State-Component Bitmaps" for detailed discussion of these constants
> + * and their meaning.
> + */
> +enum {
> +    XFEAT_X87              =3D 1 << 0,
> +    XFEAT_SSE              =3D 1 << 1,
> +    XFEAT_AVX              =3D 1 << 2,
> +    XFEAT_AVX512_OPMASK    =3D 1 << 5,
> +    XFEAT_AVX512_ZMM_HI256 =3D 1 << 6,
> +    XFEAT_AVX512_HI16_ZMM  =3D 1 << 7,
> +    XFEAT_AVX512           =3D XFEAT_AVX512_OPMASK
> +                           | XFEAT_AVX512_ZMM_HI256
> +                           | XFEAT_AVX512_HI16_ZMM
> +};
> +
> +static uint64_t xfeatures =3D XFEAT_X87 | XFEAT_SSE;
>
>  static const struct option extra_ops[] =3D {
>      {"xfeatures", required_argument, NULL, FIRST_ARCH_OPT },
> @@ -160,34 +178,34 @@ void reginfo_init(struct reginfo *ri, ucontext_t *u=
c)
>       * Now we know that _fpstate contains XSAVE data.
>       */
>
> -    if (features & (1 << 2)) {
> +    if (features & XFEAT_AVX) {
>          /* YMM_Hi128 state */
> -        void *buf =3D xsave_feature_buf(xs, 2);
> +        void *buf =3D xsave_feature_buf(xs, XFEAT_AVX);
>          for (i =3D 0; i < nvecregs; ++i) {
>              memcpy(&ri->vregs[i].q[2], buf + 16 * i, 16);
>          }
>      }
>
> -    if (features & (1 << 5)) {
> +    if (features & XFEAT_AVX512_OPMASK) {
>          /* Opmask state */
> -        uint64_t *buf =3D xsave_feature_buf(xs, 5);
> +        uint64_t *buf =3D xsave_feature_buf(xs, XFEAT_AVX512_OPMASK);
>          for (i =3D 0; i < 8; ++i) {
>              ri->kregs[i] =3D buf[i];
>          }
>      }
>
> -    if (features & (1 << 6)) {
> +    if (features & XFEAT_AVX512_ZMM_HI256) {
>          /* ZMM_Hi256 state */
> -        void *buf =3D xsave_feature_buf(xs, 6);
> +        void *buf =3D xsave_feature_buf(xs, XFEAT_AVX512_ZMM_HI256);
>          for (i =3D 0; i < nvecregs; ++i) {
>              memcpy(&ri->vregs[i].q[4], buf + 32 * i, 32);
>          }
>      }
>
>  #ifdef __x86_64__
> -    if (features & (1 << 7)) {
> +    if (features & XFEAT_AVX512_HI16_ZMM) {
>          /* Hi16_ZMM state */
> -        void *buf =3D xsave_feature_buf(xs, 7);
> +        void *buf =3D xsave_feature_buf(xs, XFEAT_AVX512_HI16_ZMM);
>          for (i =3D 0; i < 16; ++i) {
>              memcpy(&ri->vregs[i + 16], buf + 64 * i, 64);
>          }
> @@ -243,7 +261,7 @@ static const char *const regname[NGREG] =3D {
>  static int get_nvecregs(uint64_t features)
>  {
>  #ifdef __x86_64__
> -    return features & (1 << 7) ? 32 : 16;
> +    return features & XFEAT_AVX512_HI16_ZMM ? 32 : 16;
>  #else
>      return 8;
>  #endif
> @@ -251,9 +269,9 @@ static int get_nvecregs(uint64_t features)
>
>  static int get_nvecquads(uint64_t features)
>  {
> -    if (features & (1 << 6)) {
> +    if (features & XFEAT_AVX512_ZMM_HI256) {
>          return 8;
> -    } else if (features & (1 << 2)) {
> +    } else if (features & XFEAT_AVX) {
>          return 4;
>      } else {
>          return 2;
> @@ -262,9 +280,9 @@ static int get_nvecquads(uint64_t features)
>
>  static char get_vecletter(uint64_t features)
>  {
> -    if (features & (1 << 6 | 1 << 7)) {
> +    if (features & (XFEAT_AVX512_ZMM_HI256 | XFEAT_AVX512_HI16_ZMM)) {
>          return 'z';
> -    } else if (features & (1 << 2)) {
> +    } else if (features & XFEAT_AVX) {
>          return 'y';
>      } else {
>          return 'x';
> @@ -301,7 +319,7 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
>          }
>      }
>
> -    if (features & (1 << 5)) {
> +    if (features & XFEAT_AVX512_OPMASK) {
>          for (i =3D 0; i < 8; i++) {
>              fprintf(f, "  k%-5d: %016" PRIx64 "\n", i, ri->kregs[i]);
>          }


--
Alex Benn=C3=A9e

