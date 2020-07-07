Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF34C206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nb4i4JTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjQ9-0003y3-7a
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsjPU-0003LY-Sm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:57:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsjPS-0005PP-Cu
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:57:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so33012592wrl.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RXVCUkWvn1+N5xgN7wC/VuVXRkzCeSnAFFbaRoPGAsU=;
 b=nb4i4JTDSlyINN23PwmOlvh6JmAVD+n3hi3FgFOdou/eA0EnA9o0bhJTS2/l3UwPib
 H9fAcqGaUCQcIKygN//Gq3WMvaSr57STuk9rkWvw4FlxGBQH42D68G+OP4I4TKKMNLBJ
 hXbTEPGjspvAiFIUxn2I0DRnrovBjFKBqYodEkPmwi3CS+mr2I0E2nQyd2k6YGMXPCta
 he3BI7y3lwy59pVVqmSRifQ/RGwik4k/W4q+SS3WSEF++4fR34V5ApTYVBwabQVKgzqF
 FmwK6LAgEwCWVv3YyVWnhl7rLrV3znOjETYq6ki7V6605iCmMF2pWdIJa3aWlVVK1BVE
 /m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RXVCUkWvn1+N5xgN7wC/VuVXRkzCeSnAFFbaRoPGAsU=;
 b=mGdn+XpyktR58/Tuqc1HNbTuoVkgQ1T9hSAJwT57FNQQCcSw2T40kGzaFCeIPFA5A0
 8zdgOmu+PedgDSwgNGWYp/NuXeKeeJiu0RsYROjt7xEYYyi0HK26Dpl8/uQ/ZivOmzQB
 M/uIYV4swPn82240NGC05SvjNY97Ry+FWyoorRzsg24f96L3BGEF2ofNLPKPG3BSselF
 y2prVOKaAHXVnWggUJaaimtJXdrOhMfA5YPwwbYlAzsrlsmHBDautCso+Ty8yeK8VxRs
 nIwGEdTTNNGHVh0RxgWzIUg8OOvLtRZMryq60oe/pS46R5yAGLjvTvLA7oLSUZvBaEY4
 HaBg==
X-Gm-Message-State: AOAM531Ma1UbgolXii5aQiEUwOXnmx0WaepZDun37XKl2XK9K5ZqHGb9
 HTLaiNT2IhYG/8UIBsOhmV/ThA==
X-Google-Smtp-Source: ABdhPJyoiKGv/WmyDBXUkB0kA1oyRBCgE7L94ExHwuZ4XKCOqGK+Fih/ED0rEbBEu2CSwWVOIiYDIA==
X-Received: by 2002:a5d:6386:: with SMTP id p6mr40741327wru.417.1594112220191; 
 Tue, 07 Jul 2020 01:57:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm144912wml.29.2020.07.07.01.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 01:56:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EA451FF7E;
 Tue,  7 Jul 2020 09:56:58 +0100 (BST)
References: <20200707064646.7603-1-f4bug@amsat.org>
 <20200707064646.7603-4-f4bug@amsat.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 3/3] target/avr: Fix SBRC/SBRS instructions
In-reply-to: <20200707064646.7603-4-f4bug@amsat.org>
Date: Tue, 07 Jul 2020 09:56:58 +0100
Message-ID: <877dvfpusl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> SBRC/SBRS instructions seem to be inverted.

I'm having trouble following exactly how the skip logic is meant to
work. Intuitively I would expect a skip if clear to be TCG_COND_EQ
because that is true if bit & mask is compared to 0 but it's not clear
that what happens.

It would be easier if we actually had some instruction tests. I see
gcc-avr is a thing.

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/avr/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index fe03e676df..2f77fe3ba7 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -1385,7 +1385,7 @@ static bool trans_SBRC(DisasContext *ctx, arg_SBRC =
*a)
>  {
>      TCGv Rr =3D cpu_r[a->rr];
>=20=20
> -    ctx->skip_cond =3D TCG_COND_EQ;
> +    ctx->skip_cond =3D TCG_COND_NE;
>      ctx->skip_var0 =3D tcg_temp_new();
>      ctx->free_skip_var0 =3D true;
>=20=20
> @@ -1401,7 +1401,7 @@ static bool trans_SBRS(DisasContext *ctx, arg_SBRS =
*a)
>  {
>      TCGv Rr =3D cpu_r[a->rr];
>=20=20
> -    ctx->skip_cond =3D TCG_COND_NE;
> +    ctx->skip_cond =3D TCG_COND_EQ;
>      ctx->skip_var0 =3D tcg_temp_new();
>      ctx->free_skip_var0 =3D true;


--=20
Alex Benn=C3=A9e

