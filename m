Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2120C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A1420659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPyW1O3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A1420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47jX-0004gZ-OF
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j47ic-0004CR-V1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j47ib-0000pU-I0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:35:38 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j47ib-0000mT-73
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:35:37 -0500
Received: by mail-oi1-x244.google.com with SMTP id i1so21091072oie.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mKLg6s8iWW0H2hDAFAJSR86Yja9qQUYtPKowHOSv9Ok=;
 b=OPyW1O3bd38nwuf027FQ7DmF1FRG1tAjVl5oS2dWXBpXoEPbhjDGOp18nb+XBsWJUl
 zF8xOx8cgqGDVzyDJJ8vkI8nVWSdMsPTNfIjitebyweC71cVVMhfKv26ATaHzyxo7mz7
 4Dg+TynDqqvYO0oHKA9aElZUBxCD0V0fC/1H1e/HBCzWvkRHnRMPkJiZ8qIr96TIBdwx
 hzDw6AImaENEt36p1DwDJakoSvIkrAiUEV5MzzLOrz2OxPgl7EYqgx9Sl3xsEBiDRK1v
 CtfddLW9WkhczK3YbYFMJMFDx60bW1a4VPJCyvvwdfUDW41P5v1msBGZ9+0mVUInbLW7
 ka6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mKLg6s8iWW0H2hDAFAJSR86Yja9qQUYtPKowHOSv9Ok=;
 b=Kt5SrnmGbwilM/Sy9PoPhaY1bV7G3PuMpyt6dDh3WPhRqxChrFmoaCpxbHffN7yasJ
 +F7IaHcfLqBkGllh2DL7/uDfFD8jEjwVYv5FyLCB3ivhY+HEK4MxWI7r19sZuuSbcXCj
 hgekzQ4kuFo/jodrTjGN3rI8nGzPQwn09hg2L4g8RzRRNS53ulOsJp8WW8UqFNZjXO2N
 38mFeAOEwyg33wnnLoogrPWYfUIbyj6CvtlynjDp2DyGib9eyuYMejptCYzcDejiQk6t
 mBj2ADyAS4PxhsyR6aqkUJ5K1ss9op94t3fA5hbdyqSYFnDJsk07vN1umeyPVVyFRK0f
 jw7Q==
X-Gm-Message-State: APjAAAVNhkEXppPi21lmSMQ6DJJoq7eMiygVEnnQp9TzasqItCj2rvDZ
 9jDm3pXT8wcbH0kkJ/Tc89yexD6+uP7UAX7rDUPnGw==
X-Google-Smtp-Source: APXvYqxR11+XW2GqGm/URlaSK/QLrHxd0OXGw9LIctDRLN5Jan09f/41FawNRUdQHvE7UyvIZtraEGQfhPlHZYDd79o=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2156006oif.163.1582050935848; 
 Tue, 18 Feb 2020 10:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20200217203734.18703-1-linux@roeck-us.net>
 <CAFEAcA9v+9ohanZFGTgT1SLgNCnqZccnhcbsxm0MuNYQ_WSgjQ@mail.gmail.com>
 <20200218174938.GA30564@roeck-us.net>
In-Reply-To: <20200218174938.GA30564@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 18:35:24 +0000
Message-ID: <CAFEAcA8L3yPrL5nHzM4jdssJGox-E4k2wHdpc-zx4q2=7JFZJA@mail.gmail.com>
Subject: Re: [PATCH] sh4: Remove bad memory alias 'sh_pci.isa'
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 17:49, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Feb 18, 2020 at 04:33:49PM +0000, Peter Maydell wrote:
> > I think the correct fix would be to have the handling of
> > PCIIOBR call memory_region_set_alias_offset() (thus updating
> > where this alias window points within the system IO space),
> > rather than doing the del/add subregion calls.
> >
> Like this ?
>
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -67,12 +67,7 @@ static void sh_pci_reg_write (void *p, hwaddr addr, uint64_t val,
>          pcic->mbr = val & 0xff000001;
>          break;
>      case 0x1c8:
> -        if ((val & 0xfffc0000) != (pcic->iobr & 0xfffc0000)) {
> -            memory_region_del_subregion(get_system_memory(), &pcic->isa);
> -            pcic->iobr = val & 0xfffc0001;
> -            memory_region_add_subregion(get_system_memory(),
> -                                        pcic->iobr & 0xfffc0000, &pcic->isa);
> -        }
> +        memory_region_set_alias_offset(&pcic->isa, val & 0xfffc0000);
>          break;
>
> This works for me as well. Please let me know if it is correct (especially
> the mask), and I'll resubmit.

The mask and call to set_alias_offset look right, but you have
lost the setting of pcic->iobr, which is necessary so that the
register reads back correctly.

We should also drop the
    s->iobr = 0xfe240000;
in sh_pci_device_realize(), as the register resets to zero,
and just hardcode the 0xfe240000 as the argument to
memory_region_add_subregion() in that function.

(A better place for that add_subregion would be to put it
in the board model, and just have this pci controller
device expose the alias window as a sysbus mmio region,
the same way we do with the a7 and p4 windows,
but that's a separate cleanup from this bugfix.)

Incidentally, the device is missing a reset method, but
I guess Linux is programming the whole controller from
scratch and not relying on any of the registers having
known values out of reset.

thanks
-- PMM

