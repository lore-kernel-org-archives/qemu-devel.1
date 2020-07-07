Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DDEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 00:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E57C20723
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 00:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqyIFaGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E57C20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsbJB-0002Fb-CM
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 20:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsbIY-0001VL-1e; Mon, 06 Jul 2020 20:17:22 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:41488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsbIW-0005Tn-9O; Mon, 06 Jul 2020 20:17:21 -0400
Received: by mail-io1-xd43.google.com with SMTP id o5so41220815iow.8;
 Mon, 06 Jul 2020 17:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xZHsjKeHdF8oSJPzmzNmydGOMCfVdbd//sjNZ5Rs0FA=;
 b=KqyIFaGBNvxmnVxltXTlM8plCPYeRrgISiKJM/tD9Kbd27KFI1CC7U0Ah/UKNvGvBg
 udFg++6flfZ4WUK+dzYiQSHta158kukJeZPAWj8r78SZcxpO46xXXxk1U51fbtaaN8pW
 UUCcU4MWbVB6kfLXhL8LBTDGNTCBtLlclVpwbmfb8fc3Pybi9c1feC4krWSyTbkz5e1Y
 y4Z6EjmYKfDfUXGci6vsVY6FDN+h/uZ7WFoe4Z/Mng26z5b9+VGMf5VATYlQYQgKYJbG
 M2f7j3PxAAcsq2PA3Cmtzp0bdi4S1My+kFFeorzw6Q9DCqpqjbysqVEwUzznWFoV5qpK
 AgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xZHsjKeHdF8oSJPzmzNmydGOMCfVdbd//sjNZ5Rs0FA=;
 b=IaOBHnRggEkCMUiaq10KTiF543vtIrYwUb0mGOqYVcBlox3Al9VVRT9ud34HXOjs4T
 1tVCplTNZ9ll6nlqXLCbt9Il60+yZKc53I9Fcsrpn40zmoew8IyV5o/RueAeoBsmGQvn
 xgQzt6YV84W1OIfdEHs+f9XT9iQ+otyFoGIEmwIOPTqQSPCgDYtunX6ColUvdtqVNpYD
 DM/MMA3R4gZTodHdSxsiDHaUGV/j2z1zx6s3iwIYla+rHaN4kaJfDm/3fHQXka1hOlaR
 O3F45jqxgg5UE+CjwNmpXhB3ckGoNC0BG84iaDfmyHRHJiDsiROLuJSOXwwYtrD91aRJ
 hsAg==
X-Gm-Message-State: AOAM530tAINADVxakXZnGMygfaECBPuocaf8LIFxpO8EZXR9HQMj9Yfa
 FgY91BYuvumvEtAk6VwDbnjvcVXC5idzGCi0/D8=
X-Google-Smtp-Source: ABdhPJwKg5wBZ5JjpthevN5ot/tUHiyPrdatBIYezb12DomQ74k4H3YD9KYALnZc1QOGl4kgMIw8ZxCjVKiXCiSB2KI=
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr28308672ios.42.1594081038532; 
 Mon, 06 Jul 2020 17:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-19-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-19-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 17:07:31 -0700
Message-ID: <CAKmqyKPSpKQXAOH7A55+zJXTa_1+eDNHLbwToLFdXx0r1n8Lpw@mail.gmail.com>
Subject: Re: [PATCH 18/26] hw/usb/bus: Add usb_get_port_path()
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

On Sat, Jul 4, 2020 at 8:00 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Refactor usb_get_full_dev_path() to take a 'want_full_path'
> argument, and add usb_get_port_path() which returns a short
> path.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/usb.h | 10 ++++++++++
>  hw/usb/bus.c     | 18 +++++++++++++-----
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index 8c3bc920ff..7ea502d421 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -506,6 +506,16 @@ void usb_port_location(USBPort *downstream, USBPort =
*upstream, int portnr);
>  void usb_unregister_port(USBBus *bus, USBPort *port);
>  void usb_claim_port(USBDevice *dev, Error **errp);
>  void usb_release_port(USBDevice *dev);
> +/**
> + * usb_get_port_path:
> + * @dev: the USB device
> + *
> + * The returned data must be released with g_free()
> + * when no longer required.
> + *
> + * Returns: a dynamically allocated pathname.
> + */
> +char *usb_get_port_path(USBDevice *dev);
>  void usb_device_attach(USBDevice *dev, Error **errp);
>  int usb_device_detach(USBDevice *dev);
>  void usb_check_attach(USBDevice *dev, Error **errp);
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index fad8194bf5..518e5b94ed 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -577,12 +577,10 @@ static void usb_bus_dev_print(Monitor *mon, DeviceS=
tate *qdev, int indent)
>                     dev->attached ? ", attached" : "");
>  }
>
> -static char *usb_get_full_dev_path(DeviceState *qdev)
> +static char *usb_get_dev_path(USBDevice *dev, bool want_full_path)
>  {
> -    USBDevice *dev =3D USB_DEVICE(qdev);
> -
> -    if (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH)) {
> -        DeviceState *hcd =3D qdev->parent_bus->parent;
> +    if (want_full_path && (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH))) =
{
> +        DeviceState *hcd =3D DEVICE(dev)->parent_bus->parent;
>          char *id =3D qdev_get_dev_path(hcd);
>
>          if (id) {
> @@ -594,6 +592,16 @@ static char *usb_get_full_dev_path(DeviceState *qdev=
)
>      return g_strdup(dev->port->path);
>  }
>
> +static char *usb_get_full_dev_path(DeviceState *qdev)
> +{
> +    return usb_get_dev_path(USB_DEVICE(qdev), true);
> +}
> +
> +char *usb_get_port_path(USBDevice *dev)
> +{
> +    return usb_get_dev_path(dev, false);
> +}
> +
>  static char *usb_get_fw_dev_path(DeviceState *qdev)
>  {
>      USBDevice *dev =3D USB_DEVICE(qdev);
> --
> 2.21.3
>
>

