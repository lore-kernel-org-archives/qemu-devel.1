Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29935C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF2920672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sw3EFcVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF2920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVLR-0007tJ-Uh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsVKh-000746-J4; Mon, 06 Jul 2020 13:55:11 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:35860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsVKf-00089r-PW; Mon, 06 Jul 2020 13:55:11 -0400
Received: by mail-il1-x144.google.com with SMTP id x9so33709723ila.3;
 Mon, 06 Jul 2020 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZmQuG2AsZpbcelM7uL4uy958NUT2KgddZYhFWXtMNSA=;
 b=sw3EFcVvNcwfVu/7C/5MKee4SfHxGIkTeN62Bpx/IWWA6WEjBoEsPgTFuyYd6ZY1Gr
 Qwm/uOcoKwEe7yPYLDyX6FKsDnnjIKYbDfhXcIVJoaIWO51pxpebtQvXo1r77bVQsIV2
 snUKierNhFsvQkA+r4nhTOEPGaPvgQucQE7v1hXTNwuO6Bflgp9C4akbtRkZFD2Bn56i
 Va703Rt1blJoaKzcsdzSBGIjNvCPgsv8s+J8CuUiWFaVS09XY83K4ePMKOa2uI/x5fBF
 ilYijGKucyyL6AqRX03DPpw8PttqRUK+wW2UNv+aMLPfL/FGkxT/vFWlOeK6Jh5ql4cc
 xxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZmQuG2AsZpbcelM7uL4uy958NUT2KgddZYhFWXtMNSA=;
 b=cRzknMfI6zfbIFQu5Gu36u+SH/CL5gMm/R1GWeHvu7eHOuRe35GfQgziw6ftb5sEWX
 nLwFTfN3qVpyxzc3gkCC5tkJ+V1/7mOZIUZUHqwUDxKoNZd6gUfEVjWsWr+4iJdnU3VA
 cfKLWf67IwuryWbKn12gvhHGHAdvxkAYKmHVhHzzeri+p9l/imIQvtWyYp1QCVB3EIPr
 5jER+Ys5aa0wn9eBN0fAloOEHLmS0nskzkntPgp41FXKfHBSUdvtSnDRx4qmDVxL+NJ9
 3GYvQ1D/icNFEhoJp5AlO4OSNbwr3VaqjL4JdYxPr79XJ0zenuQwRY/cZEo5VTKhuMGz
 +SQQ==
X-Gm-Message-State: AOAM532g47bRd7YzbbHfq+QVMSVva1a2h4C6jKaWBHaNTqoD9JkS2f/C
 5kWTn32UsvPAWMyAktqQmZD9ghPzXM8kM948/js=
X-Google-Smtp-Source: ABdhPJzISbzqletUc82Eswi6ouHI51/TKv7NeZldaWm+9iDTc1RF7eyNcAo0E5IEVoJI+14cfVcFe8k3uljOlhawiqg=
X-Received: by 2002:a92:d186:: with SMTP id z6mr33477001ilz.227.1594058108088; 
 Mon, 06 Jul 2020 10:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-16-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-16-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 10:45:21 -0700
Message-ID: <CAKmqyKMk1b28i9xh_w1tp2hUcbxWNPUxWthy9VbRbnMtkrVpcQ@mail.gmail.com>
Subject: Re: [PATCH 15/26] hw/usb: Add new 'usb-quirks.h' local header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Paul Zimmerman <pauldzim@gmail.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 4, 2020 at 7:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Only redirect.c consumes the quirks API. Reduce the big "hw/usb.h"
> header by moving the quirks related declaration into their own
> header. As nothing out of hw/usb/ requires it, keep it local.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/usb-quirks.h | 27 +++++++++++++++++++++++++++
>  include/hw/usb.h    | 11 -----------
>  hw/usb/quirks.c     |  1 +
>  hw/usb/redirect.c   |  1 +
>  4 files changed, 29 insertions(+), 11 deletions(-)
>  create mode 100644 hw/usb/usb-quirks.h
>
> diff --git a/hw/usb/usb-quirks.h b/hw/usb/usb-quirks.h
> new file mode 100644
> index 0000000000..542889efc4
> --- /dev/null
> +++ b/hw/usb/usb-quirks.h
> @@ -0,0 +1,27 @@
> +/*
> + * USB quirk handling
> + *
> + * Copyright (c) 2012 Red Hat, Inc.
> + *
> + * Red Hat Authors:
> + * Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef HW_USB_QUIRKS_H
> +#define HW_USB_QUIRKS_H
> +
> +/* In bulk endpoints are streaming data sources (iow behave like isoc ep=
s) */
> +#define USB_QUIRK_BUFFER_BULK_IN        0x01
> +/* Bulk pkts in FTDI format, need special handling when combining packet=
s */
> +#define USB_QUIRK_IS_FTDI               0x02
> +
> +int usb_get_quirks(uint16_t vendor_id, uint16_t product_id,
> +                   uint8_t interface_class, uint8_t interface_subclass,
> +                   uint8_t interface_protocol);
> +
> +#endif
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index 18f1349bdc..8c3bc920ff 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -549,15 +549,4 @@ int usb_device_alloc_streams(USBDevice *dev, USBEndp=
oint **eps, int nr_eps,
>                               int streams);
>  void usb_device_free_streams(USBDevice *dev, USBEndpoint **eps, int nr_e=
ps);
>
> -/* quirks.c */
> -
> -/* In bulk endpoints are streaming data sources (iow behave like isoc ep=
s) */
> -#define USB_QUIRK_BUFFER_BULK_IN       0x01
> -/* Bulk pkts in FTDI format, need special handling when combining packet=
s */
> -#define USB_QUIRK_IS_FTDI              0x02
> -
> -int usb_get_quirks(uint16_t vendor_id, uint16_t product_id,
> -                   uint8_t interface_class, uint8_t interface_subclass,
> -                   uint8_t interface_protocol);
> -
>  #endif
> diff --git a/hw/usb/quirks.c b/hw/usb/quirks.c
> index 655b36f2d5..b0d0f87e35 100644
> --- a/hw/usb/quirks.c
> +++ b/hw/usb/quirks.c
> @@ -15,6 +15,7 @@
>  #include "qemu/osdep.h"
>  #include "quirks.inc.c"
>  #include "hw/usb.h"
> +#include "usb-quirks.h"
>
>  static bool usb_id_match(const struct usb_device_id *ids,
>                           uint16_t vendor_id, uint16_t product_id,
> diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
> index 417a60a2e6..4c5925a039 100644
> --- a/hw/usb/redirect.c
> +++ b/hw/usb/redirect.c
> @@ -45,6 +45,7 @@
>  #include "hw/usb.h"
>  #include "migration/qemu-file-types.h"
>  #include "migration/vmstate.h"
> +#include "usb-quirks.h"
>
>  /* ERROR is defined below. Remove any previous definition. */
>  #undef ERROR
> --
> 2.21.3
>
>

