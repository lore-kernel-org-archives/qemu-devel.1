Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32770C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F067E206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6106WMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F067E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU0j-0005mx-8t
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTzw-0004Lv-K2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:29:40 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:34906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTzv-0000Ld-35
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:29:40 -0400
Received: by mail-il1-x143.google.com with SMTP id t18so13501477ilh.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 09:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FkOrzPJRfCEkl/rxaCiZ45H0g+MGuLDY7Pi17f7zR30=;
 b=A6106WMltit+3BoFkLaXAsvhrfQAuV9U/+xoUenQYCWAJoVHQ99X/fwZFtDOUYgccM
 htKc7QFhYrWHM+c+4aHBrkaXZFW8zR9vh+p+E6h8eu2tYb8Zq7+bR1KO+SyMWJM4h146
 nvRPp1W7HQQFKT6xyxkcNGXNjgy0I+Mj1xLx3Mom9OBz63H1zlwkOJb9f8swVDpdSPh2
 3Vyo4pAq+okPeYsjPC4Cz4LjHalXr7jw+kxAfHEUjm4FpwzpjyrpF3qWX3RKGhdegm8O
 pglt36svVBOEaw293GXEQBU3QPLqWvqIb/daDGh0OxlsLEX5tv6L8H0FpGYaSNLWCHgs
 /AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FkOrzPJRfCEkl/rxaCiZ45H0g+MGuLDY7Pi17f7zR30=;
 b=TLPtz72ogsy6vpSZ1YQB+gpl66J+ChSQQuAPlsbxZos3ovvCai8wu4QTvhGbODMsjU
 CTXVXXcJXUF/1ErnzxxcRrkfgBGMfu7pWAtW2HgUngkTRjB9s7Hg158bUievB6aNRZ21
 ukFVsl2V1nXBCMANTsXlp/qiyD+c4vnaS3vfG4lxiMo3QDtr7jXa6ygfXMM2ARFFhZe+
 Vys/wEqBHVkm/0BaGJ5JkdPZopXZWrQGHL4/UGb+PNhcVk+wsAQwjzUihiiqrRzlPckk
 JV2QMtqtIuSfthwPtEIeKhlDne/zI9uddVrvnMn4lFg2iIoKaGpl24j7B+XF2y9yuLFC
 reSA==
X-Gm-Message-State: AOAM532gT0w2fh7o8cN/zxUrFhlmuV2zT90F4JuEZFhrpdZXeQiTg7W/
 uC2Jy/n947Ndmg3bHHfmlBgFZiZc+AIntzH6iIycdVre
X-Google-Smtp-Source: ABdhPJziXjidVi/5sH1BIP6BcoG3L/phziEOJYmnTMlZgOiqy6YTNcF+1NGriSgPWxVtVEX3XPS4R89ShukZes4/J70=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr31615207ilj.131.1594052977979; 
 Mon, 06 Jul 2020 09:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200705211016.15241-1-f4bug@amsat.org>
 <20200705211016.15241-4-f4bug@amsat.org>
In-Reply-To: <20200705211016.15241-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:19:51 -0700
Message-ID: <CAKmqyKMrUYJ6sSP8SMj+HXaSHdkvB3oxGQS8kxhyq7YPHmscLw@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/sd/milkymist: Create the SDBus at init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
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
> We don't need to wait until realize() to create the SDBus,
> create it in init() directly.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/milkymist-memcard.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index afdb8aa0c0..fb02309f07 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -261,6 +261,9 @@ static void milkymist_memcard_init(Object *obj)
>      memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops,=
 s,
>              "milkymist-memcard", R_MAX * 4);
>      sysbus_init_mmio(dev, &s->regs_region);
> +
> +    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
> +                        DEVICE(obj), "sd-bus");
>  }
>
>  static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
> @@ -271,9 +274,6 @@ static void milkymist_memcard_realize(DeviceState *de=
v, Error **errp)
>      DriveInfo *dinfo;
>      Error *err =3D NULL;
>
> -    qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
> -                        dev, "sd-bus");
> -
>      /* Create and plug in the sd card */
>      /* FIXME use a qdev drive property instead of drive_get_next() */
>      dinfo =3D drive_get_next(IF_SD);
> --
> 2.21.3
>
>

