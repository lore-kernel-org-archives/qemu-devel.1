Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253CEC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CADCC20637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUwMgsjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADCC20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBk8l-00080J-VS
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58203)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jBk7k-0007VJ-49
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jBk7i-0003jJ-Uc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:01:03 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:37326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jBk7i-0003g9-Pe
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:01:02 -0400
Received: by mail-il1-x141.google.com with SMTP id a6so13045322ilc.4
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3ezCVamF2xWOFfF1htrhpaZ+IsH+1dAHSrrDFtxJt/8=;
 b=pUwMgsjLuBC5WCj9/vH5jyCTe6B1FjVmxpgwe30lVnDN0jfwFtKD4+J/mTvylq3nDV
 5E6GYCXRUq3UQLsj0p9ij5P6qFSjv+9pxII19iVepv3HbvQio7SM3dP0ZpPop9N1TKeQ
 cbJe997gf5Un9vWQ5jnDsh4j1Vln03kfDtcRfFK7/5CmNEvydIGFifW/8XcIs7GfGhMZ
 9NQf8dM4MctpPEAQTnHwM8BOzcrdynbCtbGG15hd23aZdZMDq1S/EYZYaLcFl+ZuQ53E
 QgR+vgNR/4thJRrBX2O53VHflyqHpFogOSGk0qITcakhPdAEnD4nDoI37XfWyR9fyWiH
 2IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3ezCVamF2xWOFfF1htrhpaZ+IsH+1dAHSrrDFtxJt/8=;
 b=RHQWS3QT3OIkUyS14RV8KEG23grLJPtJy8z6BqBSnCKkHdWW8MYM0/UmWW0GFKDHjd
 LyCyhAmWCiHb1mkHddacW88r2wGPTpfNh21TMOuX456KyIQBvw5090+yzC0ALMfq1Rt8
 QSAwNAshJx5uRpJIOZJq94QD3cRDHEubQBV1VBouidWqtYlfYaB7+78yK0Xz/8OQHciW
 MC1DeWY6zMoJOAOaSG6A9qiakaySfCxuHQTqv6S9rKOnyNKsWk4mc+sQyDskgGwUEE1g
 8qez08L6PKk3qYkxjWaMKMni4nJxmdh/Hw3x6xjGQF9dTA2DFInOQRwMbXMbyHeIkGTC
 131Q==
X-Gm-Message-State: ANhLgQ38WFR7QqpH0npe+UTBsDFg5+uJAzOTEz2b+wNBYilXMchAKqW5
 bE02zrjda99PFJCQtA37KhBipW0phHrKvVB7JE4=
X-Google-Smtp-Source: ADFU+vsm69bR1k9oarWMe4Gqqv3IUQMth/a8GlTeRfqLOkH+Jtqt/YLFs0Pgd8rNXaWWZN9OrOuqjN4+fqfdFEBn2Jg=
X-Received: by 2002:a92:d1c2:: with SMTP id u2mr17163309ilg.217.1583866861859; 
 Tue, 10 Mar 2020 12:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <CADBGO79s5ZTWrvheAu=XHrVQO0O_RxLu9LD9=B=k982c8_mC6g@mail.gmail.com>
 <CAFEAcA9wDGjw_EBg5OxnWAxxJ0M-FS7=dh2A98Aa4LiPfEkaLw@mail.gmail.com>
In-Reply-To: <CAFEAcA9wDGjw_EBg5OxnWAxxJ0M-FS7=dh2A98Aa4LiPfEkaLw@mail.gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 10 Mar 2020 12:00:35 -0700
Message-ID: <CADBGO7_GY8xO-QP73JzTgqAz_ZozT0Odv_WfrWDftuOmaRT96g@mail.gmail.com>
Subject: Re: Any interest in dwc-otg (aka dwc2) device emulation? For Raspi 3
 and below.
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

I used to work for Synopsys, who is the vendor for the usb-otg IP, and
am the author of the dwc2 driver in the Linux kernel (actually just a
port of the vendor driver to Linux). So I am pretty familiar with the
hardware. But I had to give up all the documentation when I left
Synopsys. So, beyond what I could find on the web (register
description and programming model), I don't have any further
documentation.

Thanks,
Paul

On Tue, Mar 10, 2020 at 2:27 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 7 Mar 2020 at 00:34, Paul Zimmerman <pauldzim@gmail.com> wrote:
> >
> > Hi Folks,
> >
> > I have been working on an emulation of the dwc-otg USB controller
> > (host mode only for now), as implemented on the Raspberry Pi 3 and
> > below, and on numerous other embedded platforms. I have it to a point
> > where it works pretty well with the dwc2 driver in the mainline Linux
> > kernel, and with the dwc-otg driver in the Raspbian kernel. Mouse and
> > keyboard work fine, and I *think* the usb-net device is working too,
> > although I have been unsuccessful in connecting to the outside world
> > with it.
>
> Do you have documentation of the hardware? One of the issues
> we've had with this in the past is that we couldn't find the
> hardare specs for the USB controller, so it was a bit difficult
> to tell if a model of it was correct or not.
>
> thanks
> -- PMM

