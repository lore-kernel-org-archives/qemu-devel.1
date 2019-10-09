Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8B0C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7A3F20679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVSHSz/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A3F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIH2J-0003KH-KB
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iICAV-0004to-2Y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iICAT-0000W9-H3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:38:18 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iICAS-0000Uu-Bw
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:38:16 -0400
Received: by mail-oi1-x242.google.com with SMTP id a15so1776673oic.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P08TWrCBDxKZrMV6zgQNMe2wlSOlc9XxZTTE8PdhRGc=;
 b=TVSHSz/WazGxwIns/A5Ojm8ySjkJR8mt1AHcuqDlGqLTBMXQjRZ3+4WntOwOJ2PDt5
 zVMCHRcOhffPNMpkL6IOnaylGvnAF/S/Teq37s1LuVXVQ6zzAcOl6ZEWViCjrcIZMMfo
 bBkS6iIW8gy8zjBCLx97/HxWQSAynPueto1SDzNxvrg097yBpBo1As01qNtJH0gsc9Mh
 AHLZpjC+7WOaseJulgtYo8UEV4FXJD6qJrTPwLL43lNA2HQ9yhgd2vceLJbNSXIFl7Ac
 ynHWIlD9o4J8OEeIuVyHNyZw6oDeHNzWKEKZbDld56O582fHSJ520BjQopIDt6gIOuMZ
 U0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P08TWrCBDxKZrMV6zgQNMe2wlSOlc9XxZTTE8PdhRGc=;
 b=b4k81z8L5UL0x1Qj3Hp3XVqi8ArgfI8ng4pWx9CZ+40I2mg1Cwbxa97Bvh8KR1NJim
 onYtXtY5w8784xLwfTFbzs0r7r+UTR0FtzqOUy5Ck/71F3opC/HRL3E8haEi+MEb+9+X
 DDoNPh5sJEK8XF3gDuDVO5wGfmn/nXnvKEDt5ObNq2RgDKK2rdV/lonsBoMPYaNdvvk1
 jq4rR4yts3qIIUFvBRHPSk5wlM3oiE9jsnX4b010PCPqYXH7jYLN4fMD5Xtth4UDTLC1
 JYPWT7p6lhTFAKimPyzYg/5NNQspO3jCLdP/2d1nNmnjN/MVEJm9nA+/QjmoyT469q8i
 Rtaw==
X-Gm-Message-State: APjAAAUKLobjpmhwFztQ1WadjKBRAOUVR9tfyrt6BJ+oukj8ZOdAFRxb
 6Imm3IasC/O8LR3opwSpqe133esQCkNZuC5z90jnDg==
X-Google-Smtp-Source: APXvYqyKJLvs2IR1ah1AY5+FxoKTCG7p9Dx3Qd9L10/R84RBsHg0gT+J08+FF+0CJLy/bWVnvn2T2RDuC6YBRXIxXw8=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr2234816oia.48.1570628294186; 
 Wed, 09 Oct 2019 06:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
 <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
 <20191008214907.GA28137@localhost.localdomain>
In-Reply-To: <20191008214907.GA28137@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Oct 2019 14:38:02 +0100
Message-ID: <CAFEAcA9DzeObmtsc2VJmw=1yruANZ6ajY2SG0cAPdehkeRN3wA@mail.gmail.com>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXNzZQ==?= <contact@fredericb.info>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Maksim Kozlov <m.kozlov@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 at 22:49, Cleber Rosa <crosa@redhat.com> wrote:
> On Mon, Oct 07, 2019 at 05:28:49PM +0100, Peter Maydell wrote:
> > Do our other acceptance tests download random third-party
> > (ie "not a well-known distro") binaries for the tests ?
> > It seems a bit hazardous for reproducability and trustability
> > reasons...

> A quick and dirty grep shows (excluding comments and docs):
>
>    boot_linux_console.py:        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
>    boot_linux_console.py:        deb_url = ('http://snapshot.debian.org/archive/debian/'
>    boot_linux_console.py:        deb_url = ('http://snapshot.debian.org/archive/debian/'
>    boot_linux_console.py:        deb_url = ('http://snapshot.debian.org/archive/debian/'
>    boot_linux_console.py:        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>    boot_linux_console.py:        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
>    boot_linux_console.py:        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
>    boot_linux_console.py:        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
>    boot_linux_console.py:        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
>    boot_linux_console.py:        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
>    boot_linux_console.py:        uboot_url = ('https://raw.githubusercontent.com/'
>    boot_linux_console.py:        spi_url = ('https://raw.githubusercontent.com/'
>    boot_linux_console.py:        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
>    boot_linux_console.py:        kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
>    boot_linux_console.py:        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
>    linux_initrd.py:        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora/li'
>    linux_initrd.py:        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
>    linux_ssh_mips_malta.py:        'be': {'image_url': ('https://people.debian.org/~aurel32/qemu/mips/'
>    linux_ssh_mips_malta.py:        'le': {'image_url': ('https://people.debian.org/~aurel32/qemu/mipsel/'
>    linux_ssh_mips_malta.py:        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
>    linux_ssh_mips_malta.py:        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
>    linux_ssh_mips_malta.py:        kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
>    linux_ssh_mips_malta.py:        kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
>    machine_m68k_nextcube.py:        rom_url = ('http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/'
>
> I find it hard to judge precisely how much of a third-party some of
> these are.  I remember Philippe mentioning that one of them, I guess
> the images used on linux_ssh_mips_malta.py, were "as official as it
> gets" (my words, from my often misleading memory).
>
> Reproducibility is definitely an issue, in the sense given that some
> of these can indeed go away, but as long as they're available the hash
> recorded in the test should guarantee that we're running the same
> images.
>
> Do you think we should do something different here?

I'm not sure, which is why I asked whether this new test
was in line with what we've done previously. Since these
are just test cases and we don't redistribute them to
other people there's less of a traceability/reproducibility
worry, and if we check hashes on download that cuts off
a lot of "fail to notice if the image changes for some
reason" possible problems.

thanks
-- PMM

