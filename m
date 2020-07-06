Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72380C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407F8206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+NfzrMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407F8206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUyX-0001Rc-EY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUf5-0006ah-Es; Mon, 06 Jul 2020 13:12:11 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUf3-0008Fp-Cd; Mon, 06 Jul 2020 13:12:11 -0400
Received: by mail-io1-xd42.google.com with SMTP id c16so40148349ioi.9;
 Mon, 06 Jul 2020 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P0d8Iq06s1RxhBs4I7BZ5yRhluIYSvpMY7wkvFtI2Xg=;
 b=Y+NfzrMhVjazx3jBHloldv5qQ1eAAl6uiOiG7IwSb4NMG6+903IYIYU0tSMwa8mrC3
 cTQQBM94OvCgQ7efQJmM6schD+rLNB+ozc5/uJgypYi55rBKWT+NxRBPTgvuL6eWEhhE
 7rUuX7OsT4URw2jWCniwP0L1yU131oOJcE/YnIXdhlnn6n4G1LcX+iI6fNOgQFNSh157
 m2EprNayyIy7Rbewu0VeNMbCXbX+6iCdEKOcr8WRTrTBw4Gh4m+fC7fmitA3XMXG66WL
 XqFVF5UEWj2WlfQevGi6yVpV9hZNiy39mq2dQqoo5OhqyH5Quk+sfoOIKSNr3g+956up
 gJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P0d8Iq06s1RxhBs4I7BZ5yRhluIYSvpMY7wkvFtI2Xg=;
 b=o9kr4IPVkgZwGwhTRvh1Dg+4z3YgYEMtmUBL0sWZadUqvnpHLwWc1LjXgWwF31X5G/
 GJ3eG5rsMWkWrvxKfbXByasaNm2oKFbUoiEZ7q9YVn7lA6e3VZnc+ylsp2mZ14750nOc
 4ag0OgDwcaGFRN4bs0kZZc3TN+Wsx2zk3tpgXCuhiwb2cFX5Q2wb72Ua3vp88RgutASg
 XywiOIg66/jJ/XttM8aZz2vu+9n8hL+K8v/g263f6UUrTJ6C8+op+7jZw5vHmCP99r6W
 gzl/4C9Ze/aCuVzx9LCl/NOwwAB2/3lxlTxNNljluynun+E0tAYtMODT3uKCA//PnjFg
 Md6Q==
X-Gm-Message-State: AOAM532fnfOxkGZyGoYLqxq/wX07oCUO0QfAoWupwLarON+//1f5gukM
 cT2uJkvQkwxXkHZjemufnjgEaOoFZ0YvRrPTsGI=
X-Google-Smtp-Source: ABdhPJwQ4Y5SU2PHxNBgM6arl9mZiS4VMzkN+WtIMsTLI4VHjyaJG6nzbQPzYC2Wzjh5CnPd7DP0E6zy1bY/U6O6MAw=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr26961459ion.105.1594055527579; 
 Mon, 06 Jul 2020 10:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-15-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-15-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 10:02:20 -0700
Message-ID: <CAKmqyKNYrB+BxS41KFWhYc2wXetJH4sJ_18kEDcaYPzu87r49A@mail.gmail.com>
Subject: Re: [PATCH 14/26] hw/usb/quirks: Rename included source with '.inc.c'
 suffix
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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

On Sat, Jul 4, 2020 at 7:58 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> This file is not a header, but contains source code which is
> included and compiled once. We use the '.inc.c' suffix in few
> other cases in the repository. Follow the same convention with
> this file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/quirks.c                   | 2 +-
>  hw/usb/{quirks.h =3D> quirks.inc.c} | 5 -----
>  2 files changed, 1 insertion(+), 6 deletions(-)
>  rename hw/usb/{quirks.h =3D> quirks.inc.c} (99%)
>
> diff --git a/hw/usb/quirks.c b/hw/usb/quirks.c
> index 23ea7a23ea..655b36f2d5 100644
> --- a/hw/usb/quirks.c
> +++ b/hw/usb/quirks.c
> @@ -13,7 +13,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "quirks.h"
> +#include "quirks.inc.c"
>  #include "hw/usb.h"
>
>  static bool usb_id_match(const struct usb_device_id *ids,
> diff --git a/hw/usb/quirks.h b/hw/usb/quirks.inc.c
> similarity index 99%
> rename from hw/usb/quirks.h
> rename to hw/usb/quirks.inc.c
> index 50ef2f9c2e..004b228aba 100644
> --- a/hw/usb/quirks.h
> +++ b/hw/usb/quirks.inc.c
> @@ -12,9 +12,6 @@
>   * (at your option) any later version.
>   */
>
> -#ifndef HW_USB_QUIRKS_H
> -#define HW_USB_QUIRKS_H
> -
>  /* 1 on 1 copy of linux/drivers/usb/serial/ftdi_sio_ids.h */
>  #include "quirks-ftdi-ids.h"
>  /* 1 on 1 copy of linux/drivers/usb/serial/pl2303.h */
> @@ -915,5 +912,3 @@ static const struct usb_device_id usbredir_ftdi_seria=
l_ids[] =3D {
>
>  #undef USB_DEVICE
>  #undef USB_DEVICE_AND_INTERFACE_INFO
> -
> -#endif
> --
> 2.21.3
>
>

