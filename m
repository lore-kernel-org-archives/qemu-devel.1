Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C165C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EBC20702
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU+1Fgxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EBC20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU0O-0005Bm-Es
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTzU-0003mQ-43
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:29:12 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:43603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTzS-0000Ix-Hv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:29:11 -0400
Received: by mail-il1-x142.google.com with SMTP id i18so33436698ilk.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=txw3S/6j5UEIlp9BnD/o01vmpv0rgKoTKJs0lDslMEE=;
 b=EU+1FgxmK4fdLTdPSgiWteMJBLUKis7+vKn0APloEX2v5AGoVOF49GVUpl9mCfOWYM
 x7KlS2QUQnLcc+pcgK90jCOXsRwDjepbH71zQ6kaGnbHQeMMn5cp44sE2VVZQuifkv0T
 C5Ag8s8E5H+Cd+F0KnAqWCa52V22jMEOssRufv06XRjgInEaOsrZPk+hEVJadFMyZJQk
 iNNWB0Ftb8C0xNBhRTzjDApgOze9vxvn1BCWGW5pWetFy4Tu5BqOy2OtFttLv+m2URwC
 38HNuUiQYpk23uBfNWIycQIQKtHm/yVl7WW7206hDj2VflKEo9UHgFDqxpc039li22wS
 sNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=txw3S/6j5UEIlp9BnD/o01vmpv0rgKoTKJs0lDslMEE=;
 b=RZdO9KRUqao7wjzbFsARKTl0snYfGR5tX/2DHuBqVqTwFUtoQEKUSjB89PiJ66pljt
 +BeiL+DoIcZr8Sr1ygjWlbkYSkmGGW7GDLnLAX8KQfSUDWOQlMqFPJWFGiHNg4M8wRV3
 5AJkHETqjrWn8Erk628XP1qK2tDT1Ux7luQRC+tRMsVia0Js9Mjyp6wZStSfmtDq53VN
 DRc38CweZVSvGDMMSHOfo0qFK65K1oR2O8OnSEQMONC7nBp9lZoiZ4do8ue1I7OrjzYj
 tVESWVgDUfu85woVfTakCXO+ApzNa4RJIz7kyvj7ba/Y6WGfgDzwp+IzWsLXYahD3gGa
 VSfA==
X-Gm-Message-State: AOAM5325h1ZajwAJqP8V83/vdgjeHVkzznuXo9m9XCFxXaS3s8b790r5
 mnw6S20TP52P6W3ZprE2SkibYGn0DFkBOZPaXZI=
X-Google-Smtp-Source: ABdhPJxm+C3ts2EuXC3Aq44x6Vgl463r69L8+iBTLmcOa8MHgIPCPg/ORdpuXHXZJvxUowFOpkR9CJN43VxxWMBsfM4=
X-Received: by 2002:a92:bb84:: with SMTP id x4mr32062004ilk.177.1594052949425; 
 Mon, 06 Jul 2020 09:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200705211016.15241-1-f4bug@amsat.org>
 <20200705211016.15241-3-f4bug@amsat.org>
In-Reply-To: <20200705211016.15241-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:19:23 -0700
Message-ID: <CAKmqyKOcc=recN5dpsMUZRq9FkU2Kj0-AbmxGTOSpY=yxOEF-Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/lm32/milkymist: Comment to remember some IRQs
 lines are left unwired
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 2:10 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> The 'card is readonly' and 'card inserted' IRQs are not wired.
> Add a comment in case someone know where to wire them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I'm not convinced adding fixmes or todos in the code is the right
direction. It would be better to file bugs or use some other more
official tracking mechanism.

Alistair

> ---
>  hw/lm32/milkymist.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 469e3c4322..117973c967 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -87,6 +87,7 @@ static DeviceState *milkymist_memcard_create(hwaddr bas=
e)
>      dev =3D qdev_new("milkymist-memcard");
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
>
>      return dev;
>  }
> --
> 2.21.3
>
>

