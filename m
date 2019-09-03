Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B05C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7AA215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDX5CJvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7AA215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54rz-0005Iv-Ms
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i54rI-0004rR-TI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:12:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i54rH-0006eM-Mb
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:12:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i54rH-0006eB-Gt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:12:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id 97so13159521otr.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 02:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6yFJ1ErgznL++ga/j/AP2Y0Xkx9vBEnRE+4lupr9Yt0=;
 b=rDX5CJvwOp2QzqpRNu2T7mt6z65ybt6FOCLAxW+l09Z1c6tMQ0K7q6jh0/akbdObwE
 5JOtucRdul7wMyljrWE+of/xvT9qdO4xpqWgxo+s8zsXI8c9o2IMt56Zjxh7TcQcEd2k
 lRNEtHSt166RsQzxMOi6xfb9fa4wAK3xVovIjyx2tVRcDR3Dhvnipw9dowJErf69MVMg
 deU6AYc/Qx97kPibRGbJ4+AOiM710sUS5QVutQES+PHUDCK0g+g2vuL4J81p3rbbCFj2
 Ik6v7f7jYuQABy1XlPCtJOBZmt9SPo+DCtGz2zBzuYcGfbpyOk+ZVzWKrdvW048Taztg
 WHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6yFJ1ErgznL++ga/j/AP2Y0Xkx9vBEnRE+4lupr9Yt0=;
 b=DhUEterShL/qAfeahcfKyS9UmVQgOfZfoSZfq8gLHnKDWxI1h1rxwpgeyuG+HNCzc5
 PwHGVqoaHJuF63nsEypxxIvSSlrIrFmwwlxy0niKu2oKTpTUtBmKApywTZm32bEfRqgJ
 OUbpLepnqZCyIYv3fHmjpwSzztpKNNT8qM9yiOhMFSHqIWXyEegO3e0Njl6tZbMsFiRb
 TcomkKjGzH725lNxd1iHL41bk6QerG8TsyzpVd6DjC2byBtqZ9Rk59vTlULxNSIuEd+1
 S4XfTG0HkTYo6lPCyHspUs1TKEPH05+sC4QSxkYl2XbKftlUZv86Mt0wXfjSY6cKdsYI
 DOQw==
X-Gm-Message-State: APjAAAW1cN+VJLAYVkUf8+cFugAq6cCFgOn6gh9+VC/RxiUx7DytEs7+
 44oTUh+XSBemwwee9TDUmEXYFc3DDFoOU+Rf0vDpXw==
X-Google-Smtp-Source: APXvYqzm1q0lJvI8C/4ALmbGoUUaM8j+NlozAVflMPIp7aYJTQ3JQHYIKqaSM5An24yp38rWpYXa+2qEy0qDp5qH3U8=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr28201654otp.232.1567501934935; 
 Tue, 03 Sep 2019 02:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190709073222.26370-1-huth@tuxfamily.org>
 <20190709073222.26370-3-huth@tuxfamily.org>
 <CAFEAcA9uech2_Uc1XnxSm8Dk2rEAuyvxtnH74e_oCgw7ovVCaw@mail.gmail.com>
 <20190831071857.5e3f53dc@thl530.multi.box>
In-Reply-To: <20190831071857.5e3f53dc@thl530.multi.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 10:12:04 +0100
Message-ID: <CAFEAcA-EAZUL48-WVfrHLb6ONgW+VbV8RtppM_nAAHua+rH36g@mail.gmail.com>
To: Thomas Huth <huth@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 2/6] m68k: Add NeXTcube keyboard device
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Aug 2019 at 06:19, Thomas Huth <huth@tuxfamily.org> wrote:
>
> Am Tue, 13 Aug 2019 11:16:44 +0100
> schrieb Peter Maydell <peter.maydell@linaro.org>:
>
> > On Tue, 9 Jul 2019 at 08:35, Thomas Huth <huth@tuxfamily.org> wrote:
> > >
> > > It is likely still quite incomplete (e.g. mouse and interrupts are
> > > not implemented yet), but it is good enough for keyboard input at
> > > the firmware monitor.
> > > This code has been taken from Bryce Lanham's GSoC 2011 NeXT branch
> > > at
> > >
> > >  https://github.com/blanham/qemu-NeXT/blob/next-cube/hw/next-kbd.c
> > >
> > > and altered to fit the latest interface of the current QEMU (e.g.
> > > to use memory_region_init_io() instead of
> > > cpu_register_physical_memory()).
> > >
> > > Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> > > +static void nextkbd_class_init(ObjectClass *oc, void *data)
> > > +{
> > > +    DeviceClass *dc = DEVICE_CLASS(oc);
> > > +
> > > +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > > +    dc->realize = nextkbd_realize;
> > > +    dc->reset = nextkbd_reset;
> > > +}
> >
> > This one definitely needs migration state...
>
> m68k machines are currently unmigratable - see vmstate_m68k_cpu in
> target/m68k/cpu.c. So I assume it's currently enough if I add a
> ".unmigratable = 1" here, too?

Well, if you insist I guess. But personally I find it's just
as easy to simply implement migration state.

thanks
-- PMM

