Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA42AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957FB206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVlJYYgj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957FB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYVb-0001hW-U5
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyYUj-0001AQ-Ic
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:30:33 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:37490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jyYUh-0004fv-8L
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:30:33 -0400
Received: by mail-oo1-xc41.google.com with SMTP id t6so1017770ooh.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=usNLGLLJdMUkG4pKHulmV548Xs360DMvOiEcFY31alI=;
 b=nVlJYYgjYfErH6mP65+cIlf1RFLs/LfcEZvr98ChMdo6enm1Ut/4pZ7yaH4mCBmP/V
 PVpf5FH1/1kt7s2S65vLKQkkDt93ASiR5Qglubqd1HFdaRONjqP+rb+58LXS1ftl9GaO
 5g+mBxSqmYZvj8EaR1bdyFGnKwpZ+Bv5TxDn61KholrZgYhx2XL7+NxVnKmzCzAkOXlp
 2n/pR3Ge0k4C/JkqSi1kfMinf3i+hCVPoMJgogzu6cbCObQxR4s1ZKo015m3s2hknQDk
 CDPCLRJrI2HtXDgfWcYsZDHtramETCH8dq/MYmMTTjT3n2BNtc7duhZiv1OyF0J0Fxj1
 sEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=usNLGLLJdMUkG4pKHulmV548Xs360DMvOiEcFY31alI=;
 b=WgdeHsgR2JddkXCm7rjvacvB1DkCSavShxYdHPZjf11wtcsDJRCi9qb941AVxoYRaK
 KNSm+O7JQwGTUXqXrg4IDNZ+ALbCJ/9ihRjShc2scBBB5Z8r7eISkZw2YEmE4Y/JgCHx
 1JXGWN0UHztjEbGMS4492xG43w/9HKIgIvTaIYcL5DCvPCgwHdHwcCL/r5Y+hg01Fq03
 5aiJ8jV/8CXhjyIoogab/WKaXgSZ1B00CKRMK8u95q3dVX7sp9ma2j27TzR33Srwi8dI
 gacH7SApn5jvdvSv+GuF47gHSVjXXZ6iojOgFaylBN+xuknqLl2eoctNwg3O62dBKpmv
 Z9Lw==
X-Gm-Message-State: AOAM531y6ROYtsUfpVff6l7xuo9WFaSmdSWWLV7HD6AxgaSdLv40n53z
 1bfhAkavFE7Cn34ZuZ2XQjzm221FOGCauKYH7hnPFCEaiAs=
X-Google-Smtp-Source: ABdhPJyeeNOcRXfXpNu7I+klXqZ2UTwetSrmE3qOjnHys1jIXjVoW3IOjrg2urNBQFv59DrXsh1bECV6KmEfbdA4L8c=
X-Received: by 2002:a4a:8257:: with SMTP id t23mr2461286oog.60.1595500229961; 
 Thu, 23 Jul 2020 03:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200722204054.1400555-1-sw@weilnetz.de>
In-Reply-To: <20200722204054.1400555-1-sw@weilnetz.de>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 23 Jul 2020 18:29:54 +0800
Message-ID: <CAKXe6S+75_=hekhr-6EqiAjB2iY6D_g4-HTQzmjp8mb6rbreWQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1] sd/milkymist-memcard: Fix format string
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Michael Walle <michael@walle.cc>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Weil <sw@weilnetz.de> =E4=BA=8E2020=E5=B9=B47=E6=9C=8823=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/sd/milkymist-memcard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index afdb8aa0c0..11f61294fc 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -281,7 +281,7 @@ static void milkymist_memcard_realize(DeviceState *de=
v, Error **errp)
>      carddev =3D qdev_new(TYPE_SD_CARD);
>      qdev_prop_set_drive(carddev, "drive", blk);
>      if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
> -        error_propagate_prepend(errp, err, "failed to init SD card: %s")=
;
> +        error_propagate_prepend(errp, err, "failed to init SD card");
>          return;
>      }
>      s->enabled =3D blk && blk_is_inserted(blk);
> --
> 2.27.0
>
>

