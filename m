Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C001C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606A72084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606A72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHP3I-0004mK-Bi
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHP2E-0003uc-IS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHP2D-0000Dn-4W
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:10:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <k.kozlowski.k@gmail.com>)
 id 1iHP2C-0000Df-UY; Mon, 07 Oct 2019 05:10:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so11776553wme.1;
 Mon, 07 Oct 2019 02:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Y6nZ6LcRDjdVl8384Zn9eJ0wmkcvEHxhAf9Dve/iToI=;
 b=e0kcuL4YRtOgY8mdy7pJbwqkXOz74dA1sAZR53/W1e8cQE+DDnq7a1Z+K8Izdrm5Io
 VypejqgdVG/7Mor8u9Yhy75Ufnzk953VebirjqTtZotemAhHKQZPOzCa5gD9Nfp59Xdv
 XpcZQ+7i745+2BQC3V3r1cCq4L2Dx4mOtnIfIa75JB23md5gTST1h17O3glzDUQVKuAF
 2+xY8WxYcyA3efAbScV3tcqMbROb19l9b/bvtvupfoufNW2tGxCZzgE+lmRTHjfe24L3
 wBjuViPCVwbNpDB/055KThs0gr+juR+YCq3AF6jVItUMZPwsM6/TloJnq4vXmmlr+XEx
 E3/g==
X-Gm-Message-State: APjAAAXiC2/mqULyaGGJDEl+4MGwESGBm9KLNcoaq3aGyrc6pF6Yv/2z
 z5RhGEqqR+CzDNJjm1ftHsU=
X-Google-Smtp-Source: APXvYqxOouUyRJmLoxpomBzsyAe5h6sktFWw1BD+OIqgpB8ub2dUOqNbqm0ma1+hB1RIFyX4sE1riA==
X-Received: by 2002:a1c:1aca:: with SMTP id
 a193mr20240492wma.120.1570439427628; 
 Mon, 07 Oct 2019 02:10:27 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id r13sm24795572wrn.0.2019.10.07.02.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 02:10:26 -0700 (PDT)
Date: Mon, 7 Oct 2019 11:10:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/5] hw/arm/exynos4210: Add acceptance tests to the
 SMDKC210 board
Message-ID: <20191007091024.GC541@pi3>
References: <20191005154748.21718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191005154748.21718-1-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Basse <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 05, 2019 at 05:47:43PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi all,
>=20
> Yesterday Peter Maydell asked on IRC if I had any working Exynos4
> image. I looked at some old backuped notes and could boot Guenter
> initrd with BusyBox.
> I'll use this cover letter to share my notes, they might help to
> have this board fully usable again.
>=20
> This board is listed as "Odd Fixes". Since we have it covered, I
> thought it was worthwhile to have it covered by tests to avoid
> more regressions.
>=20
> Fr=C3=A9d=C3=A9ric Basse used this board last year:
> https://fredericb.info/2018/03/emulating-exynos-4210-bootrom-in-qemu.html
>=20
> I'll have a look a these particular commits he added:
>=20
> - https://github.com/frederic/qemu-exynos-bootrom/commit/9be5c9f2253dbc04=
ee
>=20
>    sd: add sd clock support to SDHC_CLKCON
>=20
> - https://github.com/frederic/qemu-exynos-bootrom/commit/6f045949ee2fdec6=
24
>=20
>    sd: always reply to ACMD41 (SD_APP_OP_COND)
>=20
> Guenter also carries on this patch:
>=20
> - https://github.com/groeck/qemu/commit/0a80543cc910d
>=20
>   hw/timer/exynos4210_mct: Initialize timer before starting it
>=20
>   When booting a recent Linux kernel, the qemu message "Timer with period
>   zero, disabling" is seen, apparently because a timer is started before
>   being initialized.  Fix the problem by initializing the offending timer
>   before starting it.
>=20
> It might also be interesting to use Krzysztof's initramfs image:
> https://github.com/krzk/tools/blob/master/run-qemu.sh#L29

I haven't been working on QEMU since 2 years but I can try to find that
initramfs image.

The recent initramfs I create, is for testing kernel under my Buildbot.
I take standard initramfs from Arch ARM and then I add some more stuff:
Source/instruction is here:
https://github.com/krzk/tools/tree/master/buildbot/initramfs
and the script making it for each boot is here:
https://github.com/krzk/tools/blob/master/buildbot/build-slave-deploy.sh#L50
https://github.com/krzk/tools/blob/master/pi/make-initramfs.sh

Best regards,
Krzysztof


>=20
> The 1st test added works fine, however the 2nd (SD card) is not
> reliable so it is disabled. We might need to adapt the ADMA patch
> Igor sent once:
> https://patchwork.ozlabs.org/patch/181854/
>=20
> If you want to run the Avocado tests, you need these other patches
> pending review:
>=20
> - https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06439.html
>   "tests/boot_linux_console: Extract the gunzip() helper"
>=20
> - https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06438.html
>   "python/qemu/machine: Allow to use other serial consoles than default"
>   (only for the 2nd disabled test)
>=20
> Regards,
>=20
> Phil.
>=20
> Based-on: 20190926173428.10713-16-f4bug@amsat.org
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>   tests/boot_linux_console: Add initrd test for the Exynos4210
>   hw/sd/sdhci: Add a comment to distinct the i.MX eSDHC functions
>   hw/sd/sdhci: Add dummy Samsung SDHCI controller
>   hw/arm/exynos4210: Use the Samsung s3c SDHCI controller
>   tests/boot_linux_console: Add sdcard test for the Exynos4210
>=20
>  hw/arm/exynos4210.c                    |  2 +-
>  hw/sd/sdhci.c                          | 68 +++++++++++++++++++-
>  include/hw/sd/sdhci.h                  |  2 +
>  tests/acceptance/boot_linux_console.py | 88 ++++++++++++++++++++++++++
>  4 files changed, 158 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.20.1
>=20

