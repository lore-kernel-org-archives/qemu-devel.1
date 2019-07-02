Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B482EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A32D2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 17:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIz0Axiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A32D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiMwz-0004F5-68
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 13:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiLEH-00007i-Ot
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiLE8-0007Cy-M6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:01:59 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiLDu-00073J-K9; Tue, 02 Jul 2019 12:01:40 -0400
Received: by mail-lj1-x244.google.com with SMTP id 131so17444652ljf.4;
 Tue, 02 Jul 2019 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wIGWLe+5OEpUx2zrWqvM3paus1OxHsxJGQW19htOqMg=;
 b=IIz0AxizhitucEhEvevqOZ2t4c2bbLEu6u0fZn9+HssqOon5KQs2rtQoLz+vCH46Kg
 oPunA2zcxdzk+9lNYK0MVgbpC1mrxJtcGynkcXhyRGheG3xNc9YOig98XS+eJq66Q4Ho
 WTdHPPJR+Es7V7IcYj9QWioP6yBH2SV4WWDNmgaa97b9sROGPfacVVXX6MfjcCu6Q1xd
 UzKysl8voq/eAC3C85XBJE11bM9hP01q3J/BLvo1YD4vTpYkt2DKvndzq/lQ7wDEL+lL
 Yx7jqW1P68WNc81/E4JcjKXRl7gFl7ioz+qZ8vVwoU8TBDzr1Mr1lG7H3tPUckLJjpF3
 5VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wIGWLe+5OEpUx2zrWqvM3paus1OxHsxJGQW19htOqMg=;
 b=EkMnORHlf6iUHDUr+NEjziqv7mhGP/+R/3KsFBu+Sdhk0W3Ijqbmz+46m6gLcPZpE9
 KznZAibi4ohQoKgIGN+LLg6vDyO9DIgbAIsxQrDPOK0dm/e0stm2cvtogoumoo4MzoL4
 GRO6xifJG/nN/FZTVdqr9/JBGcbomSmVYECnMoGdOsCpgFNR4i3A3yvyzGM2fwRThtnH
 wiRV+fzSTFo5y+Gqu5a7ZqzDIweAhpYvpMoVIMFtBOc5S745dKj264kgsz0KZCrI9rjJ
 q75YynUhFOfeEn04PwdcB8CIu91faIb5YViEIIjVEEhNwDGwLIKLBoLLbVJ2FYVMmTEp
 y2og==
X-Gm-Message-State: APjAAAVgKWiaTLPTLw895Ro9rqmUxXyvkA8nT0eXOwSjo3H5nbkCHV0z
 yetK0qpNyDWWJnwXR/V6FQIGFE3Udj67naISRKg=
X-Google-Smtp-Source: APXvYqxzES5gqFeqFyYs9OobCu2LnxrD0eOgZreaht0y3/VzWwERjbqAkozVEGBNoIXkuZKtaJeTgjs3KmzCEkQFYWM=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr17532129ljj.146.1562083294552; 
 Tue, 02 Jul 2019 09:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190702001301.4768-1-philmd@redhat.com>
 <20190702001301.4768-2-philmd@redhat.com>
In-Reply-To: <20190702001301.4768-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 08:58:30 -0700
Message-ID: <CAKmqyKOa-C=y7e5iKR2FCxz1-rWc0VJn7B246roSVUhzEWb5iQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2 1/9] hw/block/pflash_cfi01: Removed an
 unused timer
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 5:13 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The 'CFI02' NOR flash was introduced in commit 29133e9a0fff, with
> timing modelled. One year later, the CFI01 model was introduced
> (commit 05ee37ebf630) based on the CFI02 model. As noted in the
> header, "It does not support timings". 12 years later, we never
> had to model the device timings. Time to remove the unused timer,
> we can still add it back if required.
>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v2: Fixed commit description (Laszlo)
> ---
>  hw/block/pflash_cfi01.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 35080d915f..dcc9885bf0 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -42,7 +42,6 @@
>  #include "hw/block/flash.h"
>  #include "sysemu/block-backend.h"
>  #include "qapi/error.h"
> -#include "qemu/timer.h"
>  #include "qemu/bitops.h"
>  #include "qemu/error-report.h"
>  #include "qemu/host-utils.h"
> @@ -90,7 +89,6 @@ struct PFlashCFI01 {
>      uint8_t cfi_table[0x52];
>      uint64_t counter;
>      unsigned int writeblock_size;
> -    QEMUTimer *timer;
>      MemoryRegion mem;
>      char *name;
>      void *storage;
> @@ -114,18 +112,6 @@ static const VMStateDescription vmstate_pflash =3D {
>      }
>  };
>
> -static void pflash_timer (void *opaque)
> -{
> -    PFlashCFI01 *pfl =3D opaque;
> -
> -    trace_pflash_timer_expired(pfl->cmd);
> -    /* Reset flash */
> -    pfl->status ^=3D 0x80;
> -    memory_region_rom_device_set_romd(&pfl->mem, true);
> -    pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> -}
> -
>  /* Perform a CFI query based on the bank width of the flash.
>   * If this code is called we know we have a device_width set for
>   * this flash.
> @@ -775,7 +761,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
>          pfl->max_device_width =3D pfl->device_width;
>      }
>
> -    pfl->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
>      pfl->wcycle =3D 0;
>      pfl->cmd =3D 0;
>      pfl->status =3D 0;
> --
> 2.20.1
>

