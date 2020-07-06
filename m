Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C5FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F12A20702
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI6UW1gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F12A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsU30-0008Av-De
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU1w-0007Ed-0u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:31:44 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsU1u-0000wb-A9
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:31:43 -0400
Received: by mail-io1-xd43.google.com with SMTP id i4so39943314iov.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=snNJeTF3aNNQfDgoZci8OJFgmXxVfy5o8eCq0InE4hs=;
 b=RI6UW1gcbRxd6/mz1iKsyJESjzVu1j/4bMiybJoNSHBWqtqCcB6CWbfM7okfBX27Mc
 OXbQH5TbE7Q5doUPLJqD/mIP1i4RnAZl5rKx6zdn7PJZHE65gCscDKMZePC9Lq/Dkcl+
 7Hr8Utv/kzdG8/pDZr90S8SJ+YXeHysVH1EYLW17YMSWOnuwfQPn5aaVS4sXFWy3z1qa
 klW8RtHYuJ4w+Qr/z5RfdgLb/2RgrAEoPuYevLXUtVmP1EwhWduRxdsVV0MrcZIsN9ud
 QFRIh40lk1BTCGdH+3pPsqJxG8PN8C/yn3n+3mIPHBVSt/nedpMwyl0EgUrT7LNTWVDH
 NyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=snNJeTF3aNNQfDgoZci8OJFgmXxVfy5o8eCq0InE4hs=;
 b=Mizftb7keE6uS8bi5rWc+6LY/Y9rgk7XxDYM1kU/tx1J1uEhhveeZiJFYicCC9UD2F
 kY9hQmW1FDt2Zrwrs98LPDbERcuxO9RZQxqxwapbyNn3n5uXUUkEhMmO6R5FR9eVhewv
 wZBoxyyCTiC4Br4+e2YMyqM0ltwXcQGh3H2o+jUD8DrZIRGUdeABN++1N+Nr/rYG/aWQ
 bS1H2d67pCLjCl9+Wnp0acplgDhQf5kPSKqj4ebmnQqgu+Kdmd1O0J9DeiFKC+2lPlGV
 nVLeo5FL//GaCIHhbYli4JeZ03bDPq8FLQKT0T3+I6yOAlPlDNr7ffaHRHv5i695Vbll
 zlLQ==
X-Gm-Message-State: AOAM531cpaJcNdmbdlc8gfuf6HOvqxF8VdbctpbZDlvq3xvSsvzEsi2h
 1RbMoptZb2gyi2kP+6Mq8y6r+rntOefR0PwTMz0=
X-Google-Smtp-Source: ABdhPJx43lz+Z/RA0w3Wn3mS5XePj3J1AHxL2dj1dt/yWnWv3/Y5MGrIZHzrUd9GzYWZiv20TwQ1aoYPBVg5zkUixzc=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr26271411iod.118.1594053101123; 
 Mon, 06 Jul 2020 09:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200705211016.15241-1-f4bug@amsat.org>
 <20200705211016.15241-5-f4bug@amsat.org>
In-Reply-To: <20200705211016.15241-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:21:54 -0700
Message-ID: <CAKmqyKMJf6fWgmKsxFVDxVxZ4qYgesrUr9FexKc+eL4Aaxg7AQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/sd/milkymist: Do not create SD card within the
 SDHCI controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
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
> SDHCI controllers provide a SD Bus to plug SD cards, but don't
> come with SD card plugged in :) Let the machine/board object
> create and plug the SD cards when required.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/lm32/milkymist.c       | 13 +++++++++
>  hw/sd/milkymist-memcard.c | 55 +++++++++++++++++++++++----------------
>  2 files changed, 45 insertions(+), 23 deletions(-)
>
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 117973c967..8e2c68da5a 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -34,6 +34,7 @@
>  #include "elf.h"
>  #include "milkymist-hw.h"
>  #include "hw/display/milkymist_tmu2.h"
> +#include "hw/sd/sd.h"
>  #include "lm32.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/cutils.h"
> @@ -83,12 +84,24 @@ static void main_cpu_reset(void *opaque)
>  static DeviceState *milkymist_memcard_create(hwaddr base)
>  {
>      DeviceState *dev;
> +    DriveInfo *dinfo;
>
>      dev =3D qdev_new("milkymist-memcard");
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>      /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
>
> +    dinfo =3D drive_get_next(IF_SD);
> +    if (dinfo) {
> +        DeviceState *card;
> +
> +        card =3D qdev_new(TYPE_SD_CARD);
> +        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo=
),
> +                                &error_fatal);
> +        qdev_realize_and_unref(card, qdev_get_child_bus(dev, "sd-bus"),
> +                               &error_fatal);
> +    }
> +
>      return dev;
>  }
>
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index fb02309f07..e9f5db5e22 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -66,6 +66,8 @@ enum {
>  #define MILKYMIST_MEMCARD(obj) \
>      OBJECT_CHECK(MilkymistMemcardState, (obj), TYPE_MILKYMIST_MEMCARD)
>
> +#define TYPE_MILKYMIST_SDBUS "milkymist-sdbus"
> +
>  struct MilkymistMemcardState {
>      SysBusDevice parent_obj;
>
> @@ -253,6 +255,19 @@ static void milkymist_memcard_reset(DeviceState *d)
>      }
>  }
>
> +static void milkymist_memcard_set_readonly(DeviceState *dev, bool level)
> +{
> +    qemu_log_mask(LOG_UNIMP,
> +                  "milkymist_memcard: read-only mode not supported\n");
> +}
> +
> +static void milkymist_memcard_set_inserted(DeviceState *dev, bool level)
> +{
> +    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
> +
> +    s->enabled =3D !!level;
> +}
> +
>  static void milkymist_memcard_init(Object *obj)
>  {
>      MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(obj);
> @@ -266,27 +281,6 @@ static void milkymist_memcard_init(Object *obj)
>                          DEVICE(obj), "sd-bus");
>  }
>
> -static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
> -{
> -    MilkymistMemcardState *s =3D MILKYMIST_MEMCARD(dev);
> -    DeviceState *carddev;
> -    BlockBackend *blk;
> -    DriveInfo *dinfo;
> -    Error *err =3D NULL;
> -
> -    /* Create and plug in the sd card */
> -    /* FIXME use a qdev drive property instead of drive_get_next() */
> -    dinfo =3D drive_get_next(IF_SD);
> -    blk =3D dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
> -    carddev =3D qdev_new(TYPE_SD_CARD);
> -    qdev_prop_set_drive(carddev, "drive", blk);
> -    if (!qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err)) {
> -        error_propagate_prepend(errp, err, "failed to init SD card: %s")=
;
> -        return;
> -    }
> -    s->enabled =3D blk && blk_is_inserted(blk);
> -}
> -
>  static const VMStateDescription vmstate_milkymist_memcard =3D {
>      .name =3D "milkymist-memcard",
>      .version_id =3D 1,
> @@ -308,10 +302,9 @@ static void milkymist_memcard_class_init(ObjectClass=
 *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
> -    dc->realize =3D milkymist_memcard_realize;
>      dc->reset =3D milkymist_memcard_reset;
>      dc->vmsd =3D &vmstate_milkymist_memcard;
> -    /* Reason: init() method uses drive_get_next() */
> +    /* Reason: output IRQs should be wired up */
>      dc->user_creatable =3D false;
>  }
>
> @@ -323,9 +316,25 @@ static const TypeInfo milkymist_memcard_info =3D {
>      .class_init    =3D milkymist_memcard_class_init,
>  };
>
> +static void milkymist_sdbus_class_init(ObjectClass *klass, void *data)
> +{
> +    SDBusClass *sbc =3D SD_BUS_CLASS(klass);
> +
> +    sbc->set_inserted =3D milkymist_memcard_set_inserted;
> +    sbc->set_readonly =3D milkymist_memcard_set_readonly;
> +}
> +
> +static const TypeInfo milkymist_sdbus_info =3D {
> +    .name =3D TYPE_MILKYMIST_SDBUS,
> +    .parent =3D TYPE_SD_BUS,
> +    .instance_size =3D sizeof(SDBus),
> +    .class_init =3D milkymist_sdbus_class_init,
> +};
> +
>  static void milkymist_memcard_register_types(void)
>  {
>      type_register_static(&milkymist_memcard_info);
> +    type_register_static(&milkymist_sdbus_info);
>  }
>
>  type_init(milkymist_memcard_register_types)
> --
> 2.21.3
>
>

