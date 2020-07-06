Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA38C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C24A20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8eXVMxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C24A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVNA-0002fJ-VK
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsVLV-00089P-SV; Mon, 06 Jul 2020 13:56:02 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:43125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsVLS-0008Rr-So; Mon, 06 Jul 2020 13:56:01 -0400
Received: by mail-io1-xd42.google.com with SMTP id k23so40237213iom.10;
 Mon, 06 Jul 2020 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mSCfOyGk5eR0zmUJmXHZ59WLz9pikUBhIKrsmcLRwKY=;
 b=j8eXVMxaY8jrHLiJej23Zer/m3spONPlFZ4KX79ZeAzpTiTZv8QpRQThnjOB9bjZEz
 9XqRX+ZacKvhEpEkSiAFCBRMsBRSLouiILP7wtr57JI+XSK4o9JxmLpHI2oc0Q86y5LI
 gKZaeo5iEWUhOrVi4VXiejkfsAXXi1Jok0jj0Lf06WbI9xEOKdvw0l2w9Ddex+SQocdw
 XLAtjlWIGAf3HjvdQdebloODZ+hOYtihnQpNOqqLzXX50FzndxNMA7kTZPk8LHDy3Eqy
 yQzhSTGA0MNqrwk/qGgrvgHt1PhK5+f5Ta5eL+9/+kmDpG8FN1o8jhVPg/ep/hzRREdv
 u/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mSCfOyGk5eR0zmUJmXHZ59WLz9pikUBhIKrsmcLRwKY=;
 b=rVVrUlKzEDVe+9ttToJBQNzagehOtwNE5yaPObTstkCKYr27dtavvOSid39L+bmpGF
 Q6je64r72SC40iDNGnN38LcqPs/pfVLmlVzF/PODsSZfo2qT1Kx4FxghNlijPcMxnM8w
 6Xg8AfYpgtYqZy+3cPGIEL4uspPI0k+zi3KZUYCYxkKZde+xNaAuE4DRw2I+/ZWS5S3B
 YHrTlJjgrL2pVQ5eDyhc6e3rR13/rwzD3bEYJMcz07QgOkBw3YRdBTuzGpK5yuUgL7O2
 TDbsH0/5xyIjhDc1hknQaiTM6InX6B/nw77RGMxvpTXcwb56hkdH/gmb926O63Vmv1ea
 3wFg==
X-Gm-Message-State: AOAM530CxPDiPXzSd2QOkk+WWFnjMsO0gFoB8+S3gLXyMlqDIz2QEa7J
 lI3YGxEITzoSdveM+Cv7yOY2MGtQHDgU+/oirO0=
X-Google-Smtp-Source: ABdhPJwgU07aL+RYrZdIeE1eEIZgLeMLC2jE22itCYBokk5fp9t9EJA/ZYEPpHOeXw6oU4TodkfjqRVYChow5WL9Imc=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr26452978ioe.176.1594058157255; 
 Mon, 06 Jul 2020 10:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-17-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-17-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 10:46:09 -0700
Message-ID: <CAKmqyKNj_iiadDJEYme-HWxSNm5y7cE=ESRtxxXd4XvToGsRHw@mail.gmail.com>
Subject: Re: [PATCH 16/26] hw/usb/bus: Simplify usb_get_dev_path()
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

On Sat, Jul 4, 2020 at 8:00 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Simplify usb_get_dev_path() a bit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/bus.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 111c3af7c1..f8901e822c 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -580,19 +580,18 @@ static void usb_bus_dev_print(Monitor *mon, DeviceS=
tate *qdev, int indent)
>  static char *usb_get_dev_path(DeviceState *qdev)
>  {
>      USBDevice *dev =3D USB_DEVICE(qdev);
> -    DeviceState *hcd =3D qdev->parent_bus->parent;
> -    char *id =3D NULL;
>
>      if (dev->flags & (1 << USB_DEV_FLAG_FULL_PATH)) {
> -        id =3D qdev_get_dev_path(hcd);
> -    }
> -    if (id) {
> -        char *ret =3D g_strdup_printf("%s/%s", id, dev->port->path);
> -        g_free(id);
> -        return ret;
> -    } else {
> -        return g_strdup(dev->port->path);
> +        DeviceState *hcd =3D qdev->parent_bus->parent;
> +        char *id =3D qdev_get_dev_path(hcd);
> +
> +        if (id) {
> +            char *ret =3D g_strdup_printf("%s/%s", id, dev->port->path);
> +            g_free(id);
> +            return ret;
> +        }
>      }
> +    return g_strdup(dev->port->path);
>  }
>
>  static char *usb_get_fw_dev_path(DeviceState *qdev)
> --
> 2.21.3
>
>

