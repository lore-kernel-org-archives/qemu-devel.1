Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA131C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B51206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUiK3sXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B51206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsj3V-0001V0-SQ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsj2e-0000z2-03
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:33:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsj2c-00014u-8T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:33:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so44152455wrj.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SY8SDGo9kjl+BbuqifqoYxHSuiwcQteMkwUub+D3tLE=;
 b=sUiK3sXShVlLcxROGIr5n+HyWc72AtJE3FvllSDhkTOOx1zGxY25Rsj4cCnXcSxuBG
 8PfIRAE3PnIEkTqJlrOus04SIQjKvp4/34Q75bJDx5YfYZellGt1iQN+vnV7I0s/Of+X
 WFsnjT6fEBIKZCKU59sP4Q6k90gSTQcFATVFrkvZDR98OgZATadsrbc5AsxAv3CQTYy9
 iRZygOTYJaptJN0vQTkVXmtaCNBzT/n7pg7hkv0N03t0QhD2+J6tjOjo9ngNjr9rq2F5
 Qs9n5RPzWxXp3qv5+ho79rc1WgSyjI9Dd5UvJ95y9iixrE7hN2/erCqoV1ENy3BCHikc
 wTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SY8SDGo9kjl+BbuqifqoYxHSuiwcQteMkwUub+D3tLE=;
 b=A5nnULs2zMyWz7AfqypfKpw2hwXor5MCgxNnG6+7WzD40E/rUYAflw4OnVkH4ZdPea
 MPtAZiCZoyK1K6Jq3vU4kuxAVa5SpCSRS3zJVllImklBGGhXirxWh7qi4+4JlvVCwIXd
 EsOdHAEskZecgLjIGJubQyqzPhtJdn80lVP4M1L5k5/LyYLHYue0mJNCDBr79/qpLlj2
 TVi/poSS4UvTjikxEUqsgehhKpYUp5dBSrbhxHbVr5BTR2nxntyBafFXf1dkiNKFxJ/G
 OYVqcsNlJPzhWxosSCsOBRBjRrNp9lh8ZtuZuHKiF8j2hEcvoXqJESzqpfNqL4t13b8s
 ecog==
X-Gm-Message-State: AOAM532sVprmZWqV/mah5IFbkk/NiqVPabsqy1uYGhlIMbSPNUCbOXk8
 SJ1vpRKeH6fXMoYrQ/XGBhJ1mA==
X-Google-Smtp-Source: ABdhPJwvGWGmf+d7OoRImPD9OrnULS+xHje1wqt35wBF0CYEx6kKjqmcPjdfLt+LeVcu2kOBfD1/nA==
X-Received: by 2002:a05:6000:ca:: with SMTP id
 q10mr54293211wrx.135.1594110804470; 
 Tue, 07 Jul 2020 01:33:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d81sm2946435wmc.0.2020.07.07.01.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 01:33:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7097F1FF7E;
 Tue,  7 Jul 2020 09:33:22 +0100 (BST)
References: <20200707064646.7603-1-f4bug@amsat.org>
 <20200707064646.7603-3-f4bug@amsat.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/3] target/avr: Fix $PC displayed address
In-reply-to: <20200707064646.7603-3-f4bug@amsat.org>
Date: Tue, 07 Jul 2020 09:33:22 +0100
Message-ID: <87a70bpvvx.fsf@linaro.org>
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

> $PC is 16-bit wide. Other registers display addresses on a byte
> granularity.
> To have a coherent ouput, display $PC using byte granularity too.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/avr/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 50fb1c378b..9be464991f 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -151,7 +151,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f,=
 int flags)
>      int i;
>=20=20
>      qemu_fprintf(f, "\n");
> -    qemu_fprintf(f, "PC:    %06x\n", env->pc_w);
> +    qemu_fprintf(f, "PC:    %06x\n", env->pc_w * 2);

OK this was confusing until I grepped around the code and found the
comment in set pc:

    cpu->env.pc_w =3D value / 2; /* internally PC points to words */

so it makes sense I guess but I didn't pick it up from the name. Maybe
worth adding the comment in CPUAVRstate?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      qemu_fprintf(f, "SP:      %04x\n", env->sp);
>      qemu_fprintf(f, "rampD:     %02x\n", env->rampD >> 16);
>      qemu_fprintf(f, "rampX:     %02x\n", env->rampX >> 16);


--=20
Alex Benn=C3=A9e

