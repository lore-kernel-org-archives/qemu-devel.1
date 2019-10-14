Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5BC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1001621882
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGeVmdBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1001621882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2c7-0008UZ-0D
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2Y3-0004nD-Pi
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2Y0-0007iC-Nn
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:14 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2Y0-0007hW-Ht
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:46:12 -0400
Received: by mail-oi1-x243.google.com with SMTP id a15so14153497oic.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ttVrenm4QLLTwpCCco+SKk5k4NpVsUUsicg6JQ4hx4k=;
 b=kGeVmdBoRJLq2eR2LuzVocnQwajwVXUOWfTqOTM3DycwX3S+18gpWMZPVeb9Hsinhs
 jVjQBcfnoX0/0+YLy8M3AXLFO2QBXIaHBQ6KTYc5MtXKJU4X/lkR1M05QG/PbgQtWo1A
 BOTNbndHuhq90cOkIBxCFFxCutohXsIXmJ25Vkxl5Wlnz9ceGEj+N7oV+4o5k2rcDvxz
 +hH01jZWf6CasriDgb8DZWBh0o3CkRM7aQ+E5B2TNVBmS+y1ggGo83onFl8wgdhCBQo5
 kUbpweADb6Ph2raDqchCq6KkyhN2702YicSyQj0eLpR8pn9MEAQgb8Xu+VgkE9ztZmYw
 qVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ttVrenm4QLLTwpCCco+SKk5k4NpVsUUsicg6JQ4hx4k=;
 b=ZXg66G1WjtP3U3/9U0Q7Hk0ToljiNk3x0Y3OJ/ejX9fddiSsgKGAu0Dj//bLYFyXTA
 W7WVYA6Utyqt866xa4YJqgc7cFZNwet1eupajcfzbzX2D0wW+yJle2tIVfkGXc8XJGv+
 7lhJbe1gqKNbIibjpOUROx1IOFN/yMaHOw6riXrh93odr+wmBvMJ1um5aYZ54I2MKBXI
 HUYzG4YnN32tpK/jCfHtIOWpPRLC/ypehEgWpPK8cTzwNrReqcHgqnEzLNXnCUKQoxzt
 cBI6YKd8OijQTA2qKCJXd873dlxodh5cL+0xt9qr/rt6aYPSQ7vNABtQ9zc5J/PUZFkP
 C1WQ==
X-Gm-Message-State: APjAAAX5naz/YhqrCBCllftacTfyRpb++ezWIRpOKhvfSk3aKEfPNuTp
 Qn6JcLbhDIqLPXUe6ojGzi9ctwVKtQpQvMJDvorQgg==
X-Google-Smtp-Source: APXvYqxm40idwVPHLypQMGSOpdSIbn5TTFoyZzs5JVY38rSwox3XO09ClljL4e+cbSzPTnsdheL1ACV0AIjKN16M5vc=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr23728332oia.48.1571067971007; 
 Mon, 14 Oct 2019 08:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 16:45:59 +0100
Message-ID: <CAFEAcA-2ovf5Y4uaCteRB7Ytt2bcOS1BgfQNRr8G6z5_VobKZw@mail.gmail.com>
Subject: Re: [PATCH 00/19] hw/arm/raspi: Improve Raspberry Pi 2/3 reliability
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 at 18:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Hi,
>
> I previously posted a RFC for the Raspberry Pi 4:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg642241.html
> and got it almost working (boots Linux kernel to userland, sadly
> I'm still having timeout issues with the eMMC block).
> However since it is quite usable, I started to clean up to post
> the series and realized it is way too big for Peter Maydell, so
> I'm following his rule of thumb by splitting in 3 sets of ~20
> functional patches.

> Philippe Mathieu-Daud=C3=A9 (19):
>   hw/arm/raspi: Use the IEC binary prefix definitions
>   hw/arm/bcm2835_peripherals: Improve logging
>   hw/arm/bcm2835_peripherals: Name various address spaces
>   hw/arm/bcm2835: Rename some definitions
>   hw/arm/bcm2835: Add various unimplemented peripherals
>   hw/char/bcm2835_aux: Add trace events
>   hw/misc/bcm2835_mbox: Add trace events
>   hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor
>   hw/arm/bcm2835_peripherals: Use the thermal sensor block
>   hw/timer/bcm2835: Add the BCM2835 SYS_timer
>   hw/arm/bcm2835_peripherals: Use the SYS_timer
>   hw/arm/bcm2835_peripherals: Add Clock/Power/Reset Manager blocks
>   hw/arm/raspi: Define various blocks base addresses
>   python/qemu/machine: Allow to use other serial consoles than default
>   tests/boot_linux_console: Extract the gunzip() helper
>   tests/boot_linux_console: Add a test for the Raspberry Pi 2
>   tests/boot_linux_console: Test the raspi2 UART1 (16550 based)
>   tests/boot_linux_console: Boot Linux and run few commands on raspi3
>   tests/boot_linux_console: Test SDHCI and termal sensor on raspi3

From this patchset, I'm going to apply patches 1-5 and 7
to target-arm.next, since they're good cleanups that have
been reviewed. I've given a few review comments on
some of the others but mostly it seems to have been reviewed
by others already (so thanks to those reviewers).

-- PMM

