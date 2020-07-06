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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E036C433E3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D508620672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boamkXe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D508620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVNG-0002qe-62
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsVM8-0000lI-L8; Mon, 06 Jul 2020 13:56:40 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:37287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsVM6-0000ED-Rm; Mon, 06 Jul 2020 13:56:40 -0400
Received: by mail-io1-xd41.google.com with SMTP id v6so26634570iob.4;
 Mon, 06 Jul 2020 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/6i6SzUyP91tXZAmPR05xH5j33bfBUucUM0URzPP61A=;
 b=boamkXe9J4H35VxNzJVu2sKkuqZ5atZU6A1A5XhvxgFGrzuqn6g5Q7BEAyZTMpUh8n
 XRbR8Zv3k0pfntdT7a07EFE6ygQpqlJVA3b21L/ZK7KeNdytEnvSULDnEbDknQCWxcgX
 8bbfye39D1BUQ1BAcIRGiuZaAl7MvRJXkFgyzJlB0nYJGuCrTzE1/V8GyGEUUtzXB8lM
 +2k1yGzCz+XgJBwBT+e0m0Q+bF9LqSXCkqqxeQqvPuvyliNqKuOjs+oMEntue55kn1mj
 5tVcq8YkluSFwe7RLw7lEjbqMwpHKUCokr6yZ39bWVzbROv/rIppb5UyQ6xsvhdvU64B
 V1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/6i6SzUyP91tXZAmPR05xH5j33bfBUucUM0URzPP61A=;
 b=XOIVeHjXdE3T0VgRWeJSD/IrVP1qXiTFt+dsSjNzRTGt/6g9d314uhg3I8J3lYzCNA
 2rSjLByy8+GF7vSLkHnjOY1ByZWAnVTaMEqDrrVLnSpcW2hhJsN3TVYtZo5I/QqCMlCb
 9bhBnD7fllGxZf7nlBnOO8D57rudmpJF6LwQD/AHBy4qCYPyh4HVNPyG6NEhV4sR7PI3
 kHHGws3yo+c/vLlvTrN9eI9rNCqkKB5wxq6cC+tIaHUp9/2FSA8w0Gv+ULzNweep9Xk/
 oSkdXb7+J4Msnz+NnSt/OqvNh9B7x5g5TBC0dPO+xHIz48OeVXWi7DQ2cAEpD19UD936
 ySrA==
X-Gm-Message-State: AOAM5317OiZWPuIyvic05lheNbGb7ohTD0l114qAZRix4VdL3Qx0NZod
 5j72jsuh5Ajbl6TBQuZQDcfJaVKw7E6dEA90Ufo=
X-Google-Smtp-Source: ABdhPJyWgOX4whXvLnmyTPkPv87oz9JfwIp4De0q7D/H/TDK5ZXEnOeDquw+Fo5nyel8hcaNjKzEOm1ikS3FuMmOoSw=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr27140837ion.105.1594058197170; 
 Mon, 06 Jul 2020 10:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-18-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-18-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 10:46:50 -0700
Message-ID: <CAKmqyKMk==4rbi4iqEuH1aYcUNE+zTbBst5gKp8NkePz6OmDNg@mail.gmail.com>
Subject: Re: [PATCH 17/26] hw/usb/bus: Rename usb_get_dev_path() as
 usb_get_full_dev_path()
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
> If the device has USB_DEV_FLAG_FULL_PATH set, usb_get_dev_path()
> returns the full port path. Rename the function accordingly.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index f8901e822c..fad8194bf5 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -13,7 +13,7 @@
>
>  static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int inden=
t);
>
> -static char *usb_get_dev_path(DeviceState *dev);
> +static char *usb_get_full_dev_path(DeviceState *dev);
>  static char *usb_get_fw_dev_path(DeviceState *qdev);
>  static void usb_qdev_unrealize(DeviceState *qdev);
>
> @@ -33,7 +33,7 @@ static void usb_bus_class_init(ObjectClass *klass, void=
 *data)
>      HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(klass);
>
>      k->print_dev =3D usb_bus_dev_print;
> -    k->get_dev_path =3D usb_get_dev_path;
> +    k->get_dev_path =3D usb_get_full_dev_path;
>      k->get_fw_dev_path =3D usb_get_fw_dev_path;
>      hc->unplug =3D qdev_simple_device_unplug_cb;
>  }
> @@ -577,7 +577,7 @@ static void usb_bus_dev_print(Monitor *mon, DeviceSta=
te *qdev, int indent)
>                     dev->attached ? ", attached" : "");
>  }
>
> -static char *usb_get_dev_path(DeviceState *qdev)
> +static char *usb_get_full_dev_path(DeviceState *qdev)
>  {
>      USBDevice *dev =3D USB_DEVICE(qdev);
>
> --
> 2.21.3
>
>

