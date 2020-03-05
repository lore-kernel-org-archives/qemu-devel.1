Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D9AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B292072A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dahG+KWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B292072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wXd-0008E0-UD
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9wWv-0007gf-DV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9wWu-00048l-CG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:51:37 -0500
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:40099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9wWu-00048X-8V; Thu, 05 Mar 2020 14:51:36 -0500
Received: by mail-vs1-xe41.google.com with SMTP id c18so4420987vsq.7;
 Thu, 05 Mar 2020 11:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GKElllibpcvRWEhrnifCMB0YbyIa2Zcxj7sNsXWVa0g=;
 b=dahG+KWo92MfpdfHw15aexMlALyGlJxjk8/C7ouogLkWeWm6SS3ewQy/JbL/Ok+v+e
 KwZNU7IxkesshiU7il/UanRlofUOLpOZniRVEj9VXYXp8kJwueXly9VKPaDvvY7x0GSh
 +41JMQBbTujawmo8NB/O3U1H3Tk1RYQUw3GjPxKk+RrIrBlv35eyLVtoZ3mZ+Zl2gMG3
 /cEj3n2yotkhvE38ltexHM9aPesNmaW+LmB6eSuXuYN9HaOhPTRIusvE405LtcEWOVio
 hd8lMjELok7BglDlI+BrqwxN+xVYEkqIO2PwIRxWOGStuz9t0AY6yD3NjI7ZIaGFWOHS
 J5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GKElllibpcvRWEhrnifCMB0YbyIa2Zcxj7sNsXWVa0g=;
 b=TkpmQRJi5aHD51hkDnjY4pS/QjfHuIpkN2vgKlYqK0f40aD3KJpNT4sDTbZM1G7eQd
 soPHHdqAoZeGc8sl6fYSCOFcUgIdPV8weD/dY3Vv/WpLpEgj9fEhSZ4WgcW/YL4Hdvh5
 o5sc3hkP9IOGrhkHJf7z8VkZfzmbYrio9P2D5ljG61MljoZxWjQYvmG1Gye+VYtMoy1R
 d8OWzrruJSAZOIWGVwT6CjMPS2yajxoPbzrUm7k2+MWky1M0hDU61HXl6Tn6AjkWdw2m
 Wh25yjCgGx6GuC4GhaZQenuXveu+s60dcAurVhnKvdVga0T3NVjxU0lwkslnCGUst9Oj
 yjlw==
X-Gm-Message-State: ANhLgQ16EQlLrOFGUB9PhVhtfdVrUirW+HUAlhXKKLsL1F/CxDSdSf61
 moxrHf8CTMfC1PZJR5n+fE/thUGu8SH0mZ4R8+s=
X-Google-Smtp-Source: ADFU+vvsC4LrLUIYuABUPh7RqDB3m1BMz+8X9SMEDWgfoVEImmXEvk5ow2cu7lOvoCiFKnjzS1WQWD6Eb6PIUCfUPIE=
X-Received: by 2002:a05:6102:205:: with SMTP id
 z5mr324369vsp.151.1583437895635; 
 Thu, 05 Mar 2020 11:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20200229141011.58989-1-root@stephanos.io>
 <CAKmqyKP1QFiWSQzUsoV9TLWBQ8hrx+yg7UM2=DnAoCAanLRuwA@mail.gmail.com>
 <CAFEAcA_O6ScMF0fJgHORVXDQ+PvFNW4w6kBkeeB0vHixHo0zqA@mail.gmail.com>
In-Reply-To: <CAFEAcA_O6ScMF0fJgHORVXDQ+PvFNW4w6kBkeeB0vHixHo0zqA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2020 11:43:47 -0800
Message-ID: <CAKmqyKPp3tSf4vpxPh9ozH0G9=__DSU3BFYB2JPvJUjgg9-iyw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/stm32f405: Add preliminary RCC emulation support
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e41
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Stephanos Ioannidis <root@stephanos.io>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 11:30 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 5 Mar 2020 at 19:24, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Sat, Feb 29, 2020 at 6:12 AM Stephanos Ioannidis <root@stephanos.io> wrote:
>
> > > +typedef union {
> > > +    struct {
> > > +        uint32_t hsion : 1;
> > > +        uint32_t hsirdy : 1;
> > > +        uint32_t reserved0 : 1;
> > > +        uint32_t hsitrim : 5;
> > > +        uint32_t hsical : 8;
> > > +        uint32_t hseon : 1;
> > > +        uint32_t hserdy : 1;
> > > +        uint32_t hsebyp : 1;
> > > +        uint32_t csson : 1;
> > > +        uint32_t reserved1 : 4;
> > > +        uint32_t pllon : 1;
> > > +        uint32_t pllrdy : 1;
> > > +        uint32_t plli2son : 1;
> > > +        uint32_t plli2srdy : 1;
> > > +        uint32_t reserved2 : 4;
> > > +    };
> > > +    uint32_t reg;
> > > +} RccCrType;
> >
> > This is a pretty interesting way to represent the registers
>
> Is it portable, though? I thought C bitfield order and
> packing was implementation-defined, which would mean that
> you can't guarantee that this union will give you the
> required thing in the uint32_t half.

Yep, it is implementation defined, this won't work correctly then.

>
> I think it would be better to do this the way that
> other device models do it, and avoid bitfields.

I agree, I would recommend the bit fields I mentioned earlier as that
is similar to what you already have. You don't have to use the
RegisterAccessInfo method if you don't want to. I think the ARM SMMUv3
is an example of using the bit fields with the traditional QEMU
read/write functions.

Alistair

>
> thanks
> -- PMM

