Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22048C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA3282065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPIKIEX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3282065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsq6p-0000xb-3z
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsq5d-0007yR-Hi; Tue, 07 Jul 2020 12:05:01 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsq5b-0006Px-Qe; Tue, 07 Jul 2020 12:05:01 -0400
Received: by mail-io1-xd41.google.com with SMTP id k23so43665478iom.10;
 Tue, 07 Jul 2020 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rT/UCYFlxrI6UNQnpwYU8XAErmWANqgovsEEzMYtj0E=;
 b=rPIKIEX8SYpLl57LVSl58gTyUq1N9RNKtNjNaglJWqxC8ljbviYBTsRgzTbqAHaBC0
 F91vxjqT3BB3ehAJMJoGremYzv1IBDoGD+qXj6GVy674bWiGGVP4y2I9L4Ksd9W9nxIQ
 kiH97V4Tev2M3PzaM6WLOeUwbeG9n8xf88S8vYfU7POvuE+2csfwLrsrAmEqOGVlT01z
 BLC3wOn4utTOfm/3OKrjEPukKvCZdywtlZNBD42HctZdsFFifQgWOJayGBHd9IxJwzSl
 ilXBbpp3clTIgOLMcMYrnc8BaA+N7Mo8vWpW5y8azbmpqU3hnMjjnkOL2xVi2ZiyxVul
 tnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rT/UCYFlxrI6UNQnpwYU8XAErmWANqgovsEEzMYtj0E=;
 b=keKthBYRVccW++rWSsSa8M3OFOgf2eTY8xqbiwYwuVlZZIzP88QgkfQ0wv4Zqad2+B
 mxUZ47BKKZewGlWBOstNxZLPWhQaK+dc/5IUuhZc8F1vNi6CBfKS/2bF+DIOz6Wwg4kP
 b8tvT/7W0vYYDZ3/BFohEsWugPdiCaSZAdZbD1Sxxw2Agcu2srf7Bd3l0oVGmFppuI0m
 CeGv9dPODRpU/hQX60sia+qmk6hMu/bCm6Wkl95h3Yob5whTNb0m0XsKbAUz8VUupAAF
 +7SH7pqi20JsixIyIum5ciqXaq10ojKG/2+agzSvT0cOF14hiDy+3I2hagyjvWRz6N25
 WdhQ==
X-Gm-Message-State: AOAM531ACC9+a7hxa0RGvYwrZ0Yy3Ofr/tgFvOw9HB+8GuVVjTofBsQw
 vc9BOPHlFsFBwICNbdLa7cypT7GP0xMQiM2Gfj8=
X-Google-Smtp-Source: ABdhPJxRT2QFY9UEjtXTs9YmcDGYfGfhG5UFWKX6x3RgEaT9fhis1IgACmvtDitjMtSw5eyfKo0JdYymwftIfkFo7Yo=
X-Received: by 2002:a05:6638:dd3:: with SMTP id
 m19mr62089086jaj.106.1594137898288; 
 Tue, 07 Jul 2020 09:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
In-Reply-To: <20200707132116.26207-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2020 08:55:10 -0700
Message-ID: <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 7, 2020 at 6:22 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> QEMU allows to create SD card with unrealistic sizes. This could work,
> but some guests (at least Linux) consider sizes that are not a power
> of 2 as a firmware bug and fix the card size to the next power of 2.
>
> Before CVE-2020-13253 fix, this would allow OOB read/write accesses
> past the image size end.
>
> CVE-2020-13253 has been fixed as:
>
>     Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     occurred and no data transfer is performed.
>
>     Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>     occurred and no data transfer is performed.
>
>     WP_VIOLATION errors are not modified: the error bit is set, we
>     stay in receive-data state, wait for a stop command. All further
>     data transfer is ignored. See the check on sd->card_status at the
>     beginning of sd_read_data() and sd_write_data().
>
> While this is the correct behavior, in case QEMU create smaller SD
> cards, guests still try to access past the image size end, and QEMU
> considers this is an invalid address, thus "all further data transfer
> is ignored". This is wrong and make the guest looping until
> eventually timeouts.
>
> Fix by not allowing invalid SD card sizes.  Suggesting the expected
> size as a hint:
>
>   $ qemu-system-arm -M orangepi-pc -drive file=3Drootfs.ext2,if=3Dsd,form=
at=3Draw
>   qemu-system-arm: Invalid SD card size: 60 MiB (expecting at least 64 Mi=
B)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index cb81487e5c..c45106b78e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -32,6 +32,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/cutils.h"
>  #include "hw/irq.h"
>  #include "hw/registerfields.h"
>  #include "sysemu/block-backend.h"
> @@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *dev, Error **=
errp)
>      }
>
>      if (sd->blk) {
> +        int64_t blk_size;
> +
>          if (blk_is_read_only(sd->blk)) {
>              error_setg(errp, "Cannot use read-only drive as SD card");
>              return;
>          }
>
> +        blk_size =3D blk_getlength(sd->blk);
> +        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +            int64_t blk_size_aligned =3D pow2ceil(blk_size);
> +            char *blk_size_str =3D size_to_str(blk_size);
> +            char *blk_size_aligned_str =3D size_to_str(blk_size_aligned)=
;
> +
> +            error_setg(errp, "Invalid SD card size: %s (expecting at lea=
st %s)",
> +                       blk_size_str, blk_size_aligned_str);

Should we print that we expect a power of 2? This isn't always obvious
from the message.

Alistair

> +            g_free(blk_size_str);
> +            g_free(blk_size_aligned_str);
> +            return;
> +        }
> +
>          ret =3D blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PER=
M_WRITE,
>                             BLK_PERM_ALL, errp);
>          if (ret < 0) {
> --
> 2.21.3
>
>

