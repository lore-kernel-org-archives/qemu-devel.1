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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8717421655
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLlWpUSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8717421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3F1-0004L1-LG
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kX37G-0004Yp-OE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:04:54 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:34078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1kX37D-0003k5-GU
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:04:54 -0400
Received: by mail-lj1-x241.google.com with SMTP id y16so10297561ljk.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lO2teJbqfei5HCYIxtT5ppWnmsb4ThM15yZGiTFoJ0c=;
 b=SLlWpUSRORjK7X3tguqqnRHMdK/7Lu5+Iw91h77JpHBK9SnEe3gZ2FpuW0Tbo8XIfN
 ap1MwQEkNdnljAX4XLZV6uEsfjf5fjj+JDnZmoh5zkY/BqZGRzvN7F7tJvtw88afVWzs
 DpPAC/sBlBmEE/n5t9o3+gEkVjaMaXyTc7capDTu2IkaYDlp6qOfHla0IvSoirPkCgXd
 DlCqgA1VnYRUqAsoodLoZnG/kD4oC0weagGawW+kkODDHKVwiha+t+EiwNGZeOpDzoVI
 G55zmc0XHyhfpr5A42T6i5iYSHtp2Y/TNSCYEjrC4nw9XnICXvbiwLlh0DL/S/8v7Do1
 KhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lO2teJbqfei5HCYIxtT5ppWnmsb4ThM15yZGiTFoJ0c=;
 b=qspESdqe4xAnNBlXYaKJxaa0guVCl7xL63ilVm7WL5tM+Q79e0u8WwW870vlTETbko
 hguTuDWO2NzfBYScTcRhOT8ENgL0ksav6e7iGY3/SgPBerXY4+dDhSPDZytmFP3J3ZEJ
 C6QNhtSxjwvrQPsiMz6BZF5JjhTuiPxGzOofEtCq7fyhR0HZeRAgX7i0fYBZ47bWn8j1
 7PoERzzRuzL5a+9RgYIdCFU08zuDLlkJdB3TdAtou4WcLrDncniGRbNu7+xRyjUcjjuB
 1AcVie3nwIbbN7pcFKtyHEs6VbCsvWdye1XBYLQBtwSkPq1ZxIXcMI/EtD9jz1cZ45w+
 nC/Q==
X-Gm-Message-State: AOAM533YwRspm8yYi7Mu7zuTUR08h6X3t7UWHjJo45S1K7gWTd0Pf8og
 2sCebrRRU4cwHmEiJnVKzxTpDykEckFZsJftfoI=
X-Google-Smtp-Source: ABdhPJwO7OVXFr0UA5xdgFD4z0GW0xnbAl1ElxAqgsm8lBrRY7bvwZbibzNdq03CfNFo3fYOJlQG40WFkjNE/alp1hQ=
X-Received: by 2002:a2e:9ccd:: with SMTP id g13mr6186612ljj.127.1603721089414; 
 Mon, 26 Oct 2020 07:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201026083401.13231-1-mark.cave-ayland@ilande.co.uk>
 <20201026083401.13231-9-mark.cave-ayland@ilande.co.uk>
 <20201026095450.ko6snc4dusk3pvnw@function>
 <547c0ea5-dad4-d246-1de8-844a2e9a9507@ilande.co.uk>
 <20201026111406.jvpexlkh53g4fxff@function>
 <CAKf6xpvcnmEs+v3+Tm1srQfo=m37EAGRPynJDJy4HkMuCmD6NQ@mail.gmail.com>
 <38110b4a-34b1-3e97-5a7f-4fad1bfff080@ilande.co.uk>
In-Reply-To: <38110b4a-34b1-3e97-5a7f-4fad1bfff080@ilande.co.uk>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 26 Oct 2020 10:04:37 -0400
Message-ID: <CAKf6xpvz=a=q27LxAgVzQVyzR+2HSrvxNAn_NbmnYqmr9GNMxA@mail.gmail.com>
Subject: Re: [PATCH 8/9] dev-serial: fix FTDI_GET_MDM_ST response
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@gnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 9:40 AM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 26/10/2020 13:00, Jason Andryuk wrote:
>
> > On Mon, Oct 26, 2020 at 7:21 AM Samuel Thibault <samuel.thibault@gnu.org> wrote:
> >>
> >> Mark Cave-Ayland, le lun. 26 oct. 2020 10:58:43 +0000, a ecrit:
> >>> On 26/10/2020 09:54, Samuel Thibault wrote:
> >>>> Mark Cave-Ayland, le lun. 26 oct. 2020 08:34:00 +0000, a ecrit:
> >>>>> The FTDI_GET_MDM_ST response should only return a single byte indicating the
> >>>>> modem status with bit 0 cleared (as documented in the Linux ftdi_sio.h header
> >>>>> file).
> >>>>>
> >>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>>>> ---
> >>>>>    hw/usb/dev-serial.c | 5 ++---
> >>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> >>>>> index 4c374d0790..fa734bcf54 100644
> >>>>> --- a/hw/usb/dev-serial.c
> >>>>> +++ b/hw/usb/dev-serial.c
> >>>>> @@ -360,9 +360,8 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
> >>>>>            /* TODO: TX ON/OFF */
> >>>>>            break;
> >>>>>        case VendorDeviceRequest | FTDI_GET_MDM_ST:
> >>>>> -        data[0] = usb_get_modem_lines(s) | 1;
> >>>>> -        data[1] = FTDI_THRE | FTDI_TEMT;
> >>>>> -        p->actual_length = 2;
> >>>>> +        data[0] = usb_get_modem_lines(s);
> >>>>> +        p->actual_length = 1;
> >>>>
> >> [...]
> >>> A quick test shows my Chipi-X returns 0x1 0x60 with nothing attached in
> >>> response to FTDI_SIO_GET_MODEM_STATUS_REQUEST: assuming the reply length
> >>> should be 2 bytes, the comment about B0-B3 being zero and the response from
> >>> my Chip-X above suggests that the "| 1" should still be dropped from the
> >>> response.
> >>
> >> Aurelien, you introduced the "| 1" in
> >>
> >> commit abb8a13918ecc1e8160aa78582de9d5224ea70df
> >> Author: Aurelien Jarno <aurelien@aurel32.net>
> >> Date:   Wed Aug 13 04:23:17 2008 +0000
> >>
> >>      usb-serial: add support for modem lines
> >>
> >> [...]
> >> @@ -357,9 +393,9 @@ static int usb_serial_handle_control(USBDevice *dev, int request, int value,
> >>           /* TODO: TX ON/OFF */
> >>           break;
> >>       case DeviceInVendor | FTDI_GET_MDM_ST:
> >> -        /* TODO: return modem status */
> >> -        data[0] = 0;
> >> -        ret = 1;
> >> +        data[0] = usb_get_modem_lines(s) | 1;
> >> +        data[1] = 0;
> >> +        ret = 2;
> >>           break;
> >>
> >> do you know exactly what it is for?
> >
> > Hi,
> >
> > I'm not particularly familiar with the FTDI USB serial devices.  I
> > found setting FTDI_THRE | FTDI_TEMT by comparing with real hardware.
> >
> > A little searching found this:
> > https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L541
> >
> > That shows "B0   Reserved - must be 1", so maybe that is why "| 1" was added?
>
> Right - that's for the modem status returned as part of the first 2 status bytes for
> incoming data which is slightly different from modem status returned directly from
> FTDI_SIO_GET_MODEM_STATUS:
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/serial/ftdi_sio.h#L423.

Okay, sorry for the confusion there.

I thought your "it's the SIO chipsets that return 1 byte which are older
than the chipset being emulated by QEMU" meant you thought your change
to 1 byte was unnecessary.  You also posted two bytes (0x1 0x60) from
your hardware.

> It is the latter which this patch changes and appears to match what I see on my
> Chipi-X hardware here.

I don't have my hardware readily available, but I must have been
seeing 2 bytes from FTDI_GET_MDM_ST with data[1] = FTDI_THRE |
FTDI_TEMT; to make the change.

I don't have the USB captures anymore to compare the lowest bit value.

So right now you are just interested in dropping the lowest bit
setting but preserving the 2 bytes modem status?

Regards,
Jason

