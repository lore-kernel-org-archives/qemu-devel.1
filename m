Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EDBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890EA20790
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpUwrpVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890EA20790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2BF-0003CW-Hd
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kX27V-0000o9-0x
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:01:05 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kX27P-0002NS-JA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:01:04 -0400
Received: by mail-lj1-x242.google.com with SMTP id a4so9901272lji.12
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RpfeeoDviQV6DXLvvMEhJ2UVvtRanZGrvRd5j475GgA=;
 b=RpUwrpVMpErJqzGO45RZ5MI+XY73/NgzQvBqkPHfwsrSi9D7uhiD7SDmEfNDJyJRFF
 lgbz+CubmxMKMVmALIkxVtk+UIaNTK6D4Q6f5iXqoB1xTkA9Agls9TreuutCu4OsWTyI
 y8PPn9D54vlU1ZC8mwrEJ7AKxk1JHG6AR7HQIh5tHd2+U85JplJz3mBKKew54m0aJWjp
 ZbTZT9HPMLqtikWAU11oAJSj2T6aRJ6zF2HgkziBqXokhZiKAnmJbkSPW/UhUZr0TX3U
 1Gkm93iQDfUf9ZXI6UklYyXyYheNi3EoXv2QIUY7SeoVE20t7ICY73OQxAfYq7utbPeq
 Tv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RpfeeoDviQV6DXLvvMEhJ2UVvtRanZGrvRd5j475GgA=;
 b=GCM9VIEbs5PfEzPt8xnrrqBqu/r6N4wFP0pDF5y3OivCyux2byWZ5sZjymw8TS1o/1
 3+K7fulNJINoq1DH0XkhPP6v/GTm7Qy/+Z7oRfn3WK4eRvcQnUVWwU0UHRAkvH21i9bv
 K2o/mOuYGOG6uinRMgi2SQUuxikXyxENVRkspvMRQ7kkH72z3PQS3T/1PqXL42EjFfrl
 GruBwxgUYLc3Bqd1m8Jz/md5aG9IK3/SAR/nutldv+jShAWb3GbX6nK1y/j+lEFYjyxc
 84I91QECeV8qaVn9z2Hy06jrNOytiy/7ucIoehJFwXDiUhGV/scshmUHnMrY2S/+dOCv
 WFaQ==
X-Gm-Message-State: AOAM530PPoLbqCGykaC9USOo1IX67LeEwcTucFI5SYeE1n4LobxAxIBV
 pnMG18Gp0VphsZHR+USIZRagC9c1smR4lm7zS+Q=
X-Google-Smtp-Source: ABdhPJzomO6ix0sJipLbvhfDdoxWduW3+QfaS11GnPcVvCH7txj+jTpg6jTHfO/BcNkKSaGTcF45qHhCb3cc3UZFjBU=
X-Received: by 2002:a2e:b0c7:: with SMTP id g7mr5431540ljl.433.1603717256254; 
 Mon, 26 Oct 2020 06:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-9-mark.cave-ayland@ilande.co.uk>
 <20201026095450.ko6snc4dusk3pvnw@function>
 <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
 <20201026111406.jvpexlkh53g4fxff@function>
In-Reply-To: <20201026111406.jvpexlkh53g4fxff@function>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 26 Oct 2020 09:00:44 -0400
Message-ID: <CAKf6xpvcnmEs+v3+Tm1srQfo=m37EAGRPynJDJy4HkMuCmD6NQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] dev-serial: fix FTDI_GET_MDM_ST response
To: Samuel Thibault <samuel.thibault@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 7:21 AM Samuel Thibault <samuel.thibault@gnu.org> wrote:
>
> Mark Cave-Ayland, le lun. 26 oct. 2020 10:58:43 +0000, a ecrit:
> > On 26/10/2020 09:54, Samuel Thibault wrote:
> > > Mark Cave-Ayland, le lun. 26 oct. 2020 08:34:00 +0000, a ecrit:
> > > > The FTDI_GET_MDM_ST response should only return a single byte indicating the
> > > > modem status with bit 0 cleared (as documented in the Linux ftdi_sio.h header
> > > > file).
> > > >
> > > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > ---
> > > >   hw/usb/dev-serial.c | 5 ++---
> > > >   1 file changed, 2 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> > > > index 4c374d0790..fa734bcf54 100644
> > > > --- a/hw/usb/dev-serial.c
> > > > +++ b/hw/usb/dev-serial.c
> > > > @@ -360,9 +360,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
> > > >           /* TODO: TX ON/OFF */
> > > >           break;
> > > >       case VendorDeviceRequest | FTDI_GET_MDM_ST:
> > > > -        data[0] = usb_get_modem_lines(s) | 1;
> > > > -        data[1] = FTDI_THRE | FTDI_TEMT;
> > > > -        p->actual_length = 2;
> > > > +        data[0] = usb_get_modem_lines(s);
> > > > +        p->actual_length = 1;
> > >
> [...]
> > A quick test shows my Chipi-X returns 0x1 0x60 with nothing attached in
> > response to FTDI_SIO_GET_MODEM_STATUS_REQUEST: assuming the reply length
> > should be 2 bytes, the comment about B0-B3 being zero and the response from
> > my Chip-X above suggests that the "| 1" should still be dropped from the
> > response.
>
> Aurelien, you introduced the "| 1" in
>
> commit abb8a13918ecc1e8160aa78582de9d5224ea70df
> Author: Aurelien Jarno <aurelien@aurel32.net>
> Date:   Wed Aug 13 04:23:17 2008 +0000
>
>     usb-serial: add support for modem lines
>
> [...]
> @@ -357,9 +393,9 @@ static int usb_serial_handle_control(USBDevice *dev, int request, int value,
>          /* TODO: TX ON/OFF */
>          break;
>      case DeviceInVendor | FTDI_GET_MDM_ST:
> -        /* TODO: return modem status */
> -        data[0] = 0;
> -        ret = 1;
> +        data[0] = usb_get_modem_lines(s) | 1;
> +        data[1] = 0;
> +        ret = 2;
>          break;
>
> do you know exactly what it is for?

Hi,

I'm not particularly familiar with the FTDI USB serial devices.  I
found setting FTDI_THRE | FTDI_TEMT by comparing with real hardware.

A little searching found this:
https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L541

That shows "B0   Reserved - must be 1", so maybe that is why "| 1" was added?

Regards,
Jason

