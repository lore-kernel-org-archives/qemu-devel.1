Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD4BC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A175206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVtyln8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A175206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1zO0-0006AK-Fl
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 16:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j1zN6-0005kx-Qb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j1zN5-000588-O2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:16:36 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j1zN5-00057a-Ek
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:16:35 -0500
Received: by mail-lf1-x144.google.com with SMTP id 203so2614345lfa.12
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 13:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sBqcUBxCANXQFJU3FEnbftOqu1L0ICjqa8GyUYu+cVg=;
 b=tVtyln8NgY4sfHjaWKOEBG5dP76ch/Zcy6G+aQjD/RSr5XGaouFR/lAc1GWx7tpr6F
 SSxaVmmP+4vxQgQgub41+0b8K+ADrwGCB7lIZwDLgNz6wCh7sd5hlu02eoaagerLbjBi
 qBAikrbsDNFIXYWvtgMBw2+WY/fYdRdq9ccnUo1ayo5xovb/tUmEdMnRjSO/xmdjhX5h
 N7/ozUXhB7us5d7smNhiSsiuNvmNHsjOLHaOd9spWj31V+znrKdaAbnUvriQLmmUDVKx
 I9MDMstVKocJm9reNdK7UbXzXE+MaxTV3LoHU4uuM4hXkZ+lEiIoKEyEc13Sx+D+PM2X
 wUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sBqcUBxCANXQFJU3FEnbftOqu1L0ICjqa8GyUYu+cVg=;
 b=c868lRFfsGoDp/eP/p1KP/90frB7cx3YoOc3MoIxqqIRP516GIbXrdQYEre7SPtMHt
 iphH1KZDqaZWevNzdfmBFln/B9ySfH+ygByJeDKfQqnXRPEAX1rgAilRf0C8l/iDFehP
 q7T4gd3KgXLjKwHjacE5YEPDGPodHr0opPe5vSLhFih9vEmUUROD6p5CTKtuHGFIs84f
 xNnDGh7MSenvkybr8NE40G9lD+usmDs5qDcV/Cq+WwG0fKnltGoXelsiLOA/RQohciCH
 U5kVuCrfqDjCzWKJpivouAahlsqFvpce/qH39oY/ZGQ5SIoGU0GhI03KtNUBuB9/i3Yu
 uuPw==
X-Gm-Message-State: APjAAAVjDso6sSuZc3qJ42CDi2uRTBncU1sM69wSb5nMEjegiQ7shXv6
 w4eCT+5zYf7cxLPInYl4aeStX2hTk28jmUMnPkI=
X-Google-Smtp-Source: APXvYqwihCjd4MMX5Ohwy2rYvx85ATAoWp/Oaee/+3xs+V8gwHa4nG8TRRrxdgbTsYuwkzAmAZ56tksIhKb82j35na4=
X-Received: by 2002:a19:5057:: with SMTP id z23mr7664606lfj.132.1581542193720; 
 Wed, 12 Feb 2020 13:16:33 -0800 (PST)
MIME-Version: 1.0
References: <CANA1cB+D-Uth0C-6qNE5HcAJkQeDsCbKqmYG7uHsLqbbofSsZQ@mail.gmail.com>
 <CANA1cBKtbYqnxnSacEK3sXOYM987J5+MacpKWHdKHwB5sk672w@mail.gmail.com>
 <CAEUhbmUsK7u9ubVH+4vidgQUDmO4oN5AdSUZPXiioMFgMHg-Jg@mail.gmail.com>
In-Reply-To: <CAEUhbmUsK7u9ubVH+4vidgQUDmO4oN5AdSUZPXiioMFgMHg-Jg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Feb 2020 13:09:17 -0800
Message-ID: <CAKmqyKMZipi-Fv0Y+1W32Cv5sj+CeeHFsusa5iNpLPJgoLa-1g@mail.gmail.com>
Subject: Re: Question: SiFive U SPI and SD
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Nikita Ermakov <arei@altlinux.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 7:51 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Nikita,
>
> On Sun, Feb 9, 2020 at 10:56 PM Nikita Ermakov <arei@altlinux.org> wrote:
> >
> > Hello!
> >
> > I am trying to make an SD card working on the sifive_u (hw/riscv/sifive_u.c) SoC machine.
> > As far as I understand there is no way to connect an SD card to the SoC with cmdline for now. So, I started to dig in to the QEMU internals and especially sifive_u SoC implementation to try to understand how I could connect SD card to this SoC.
> >
> > From what I understood I need to:
> > 1) Implement SiFive U SPI controller.
>
> This one is definitely needed.
>
> > 2) Implement spi-sd adapter in a way like the hw/sd/ssi-sd.c
>
> I believe we can just use hw/sd/ssi-sd.c.

I had a crack at this awhile ago and you can see the patches here (I
just rebased them):
https://github.com/alistair23/qemu/tree/mainline/alistair/sifive_spi.next

Debugging failures was really hard in Linux, but now that U-Boot and
Oreboot (https://github.com/oreboot/oreboot/pull/234) have SPI support
it is probably easier to debug.

If you wanted to help you could try to debug that branch and figure
out why it isn't working.

Alistair

>
> >
> > Probably I should merge 1) and 2) into one hw/riscv/sifive_u_spi.c source file.
> >
> > Could somebody correct me please if I am wrong at some point?
> > I am newbie in the QEMU internals :)
> >
> > The purpose is why I want to implement this is to boot up the Linux kernel on '-machine sifive_u' and load rootfs from SD.
>
> Regards,
> Bin
>

