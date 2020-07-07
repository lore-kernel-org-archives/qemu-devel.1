Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212F0206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCNnJKBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212F0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsixT-0006Nm-FN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsiwi-0005mo-BU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:27:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsiwg-0008Qq-NN
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:27:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so1209410wmm.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=F3XnIVatTGQW60euTnelr4tE6sLzF0tRV2zF8vU13ss=;
 b=tCNnJKBCp+jeEohrmTdmYUPKiJUG+r8yat7ng8PLjXn/n4caH98U+4dkLfFz5Nj4Zt
 7kR/z7EfV0rOVaPDIPpdaefOk3r/Y0QE9opeSoa+zcqhAiwF9Zud5HMil5nyuubfd333
 V42dGsBSTRbrUTTeNrdjsmDdgMC+Ndb7Xh4pnpg62OPJC3F3QvTH1OIKeJJBxG3Qn3Tq
 Ko32n715qDlJZs+VKpN08l6LgNXF3fTKBRMLzdU3RlaughVgVEXzj2cet3tsVuMW2xih
 Mv1OST1gaHJXNXIND4iIZF+1UzImHlfARbNMNcv1DWNN+ToQqM4e3BMFYEmRX/K/WvQC
 ZHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=F3XnIVatTGQW60euTnelr4tE6sLzF0tRV2zF8vU13ss=;
 b=NnIOzjMnU8Sl8neuRVfhC2mPOG0LTSgs4iWxcjaZP5pbTtkwFTiXm6BPAmJc4mbJcN
 Pyz3/lUBShaL+y3WcCCzHWbto88yqmqWNbu8FImfPgC4oV3tOtkooEXjJifyHH4z/GO8
 Ta/Ad0UsaY9/D7WV9KZy25VnqUBlHmY/6ltErwXQlYvkQB5O6ynCXt8AQs2PHlC1Q3nm
 HJ9IkAcKvR5vW4t8mIKGOXnvZ+akSCFPJqga5jdgcbTNT/UCu5IsTgrA84KIA2FubteI
 /DUoZlmojTA1R41GJh320hxCS+hb/iDmyLVdx9ozf5EM8+UVLsGnA4VDmpPvXWDtTWeu
 yrbw==
X-Gm-Message-State: AOAM530YFBBD5yds+GcqixsC4mYHFcmixcAHj1jlSmaAJnNdoTb5TGyN
 PisE6mw60X1EURt5ezv4PsRqpw==
X-Google-Smtp-Source: ABdhPJx1C7rCZ/bHsZvshtm4QHtWpQwlrv9V8GtGFQrV6PYleJT9YXg1UNEfR3rsG1n2o/M/XWYXTg==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr3115166wmp.91.1594110436816;
 Tue, 07 Jul 2020 01:27:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y17sm27998957wrd.58.2020.07.07.01.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 01:27:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CCC7A1FF7E;
 Tue,  7 Jul 2020 09:27:14 +0100 (BST)
References: <20200707064646.7603-1-f4bug@amsat.org>
 <20200707064646.7603-2-f4bug@amsat.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/3] target/avr: Drop tlb_flush() in avr_cpu_reset()
In-reply-to: <20200707064646.7603-2-f4bug@amsat.org>
Date: Tue, 07 Jul 2020 09:27:14 +0100
Message-ID: <87d057pw65.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

> Since commit 1f5c00cfdb tlb_flush() is called from cpu_common_reset().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/avr/cpu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 4e4dd4f6aa..50fb1c378b 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -78,8 +78,6 @@ static void avr_cpu_reset(DeviceState *ds)
>      env->skip =3D 0;
>=20=20
>      memset(env->r, 0, sizeof(env->r));
> -
> -    tlb_flush(cs);
>  }
>=20=20
>  static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)


--=20
Alex Benn=C3=A9e

