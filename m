Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74F9C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6E82084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6E82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOuq-0001AX-C7
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHOsO-0008PX-1P
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHOsJ-0003pn-2g
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:00:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45027)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <k.kozlowski.k@gmail.com>)
 id 1iHOsI-0003pE-Sc; Mon, 07 Oct 2019 05:00:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so14190584wrl.11;
 Mon, 07 Oct 2019 02:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=2mpH4Ugy9/Oa6ReWsoDL+YtOjgGW70O4N98QRChpJ5I=;
 b=MhPoKHfCDGG3/fwNUEO+snGAAVGtzN9lcGtw3zQ2K/K5tzKI16NuUTrzAO2n4/LNfG
 bz+xpJTJY1uuV+8du6G6cmrMNEgKaqNZFf2un0LdJCdOsAGVS3WKi/d4GbLwKBko9HK0
 H1Y7EEJNQbraTRfpLy4GHGvmRZ5q92n8cTg7qdxPZkDkhR+alpoEcC+/ftAUXQfgQsHe
 mFST3X8HnLUg7WmjPhQWDDSnrjWgLyU1b0LI+QOd34mpI33Wye6eWI4lHzma6TcnF9j3
 AMm2VMBcfSiCnsXa3LLJJowCdOIXEOaIA/FBATi5/KV+M+NAKK3cj3K41OBNtsPA3ii3
 /K5Q==
X-Gm-Message-State: APjAAAWw9fUd4QbcgqiSschVp0hQyXZ/gHYY0dl/y1vKoFy7rhrIWTb/
 2qK0rLtdql3z5wLx3us/FtHQ7q/9K8s=
X-Google-Smtp-Source: APXvYqxhSccF5T3WbKUTilfL09MMI8tb+dVX4luy/Y0DNluQ6NSy4sub6RCVqWNIj1W491FkxGA/Rg==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr15560441wrb.312.1570438813748; 
 Mon, 07 Oct 2019 02:00:13 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id h14sm22824821wro.44.2019.10.07.02.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 02:00:13 -0700 (PDT)
Date: Mon, 7 Oct 2019 11:00:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 4/5] hw/arm/exynos4210: Use the Samsung s3c SDHCI
 controller
Message-ID: <20191007090010.GB541@pi3>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191005154748.21718-5-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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

On Sat, Oct 05, 2019 at 05:47:47PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> The Exynos SoC has specific SDHCI registers. Use the s3c SDHCI
> model which handle these specific registers.
>=20
> This silents the following "SDHC ... not implemented" warnings so
> we can focus on the important registers missing:
>=20
>   $ qemu-system-arm ... -d unimp \
>     -append "... root=3D/dev/mmcblk0 rootfstype=3Dext4 rw rootwait" \
>     -drive file=3Dlinux-build-test/rootfs/arm/rootfs-armv5.ext2,if=3Dsd,f=
ormat=3Draw
>   [...]
>   [   25.744858] sdhci: Secure Digital Host Controller Interface driver
>   [   25.745862] sdhci: Copyright(c) Pierre Ossman
>   [   25.783188] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2 (=
12000000 Hz)
>   SDHC rd_4b @0x80 not implemented
>   SDHC wr_4b @0x80 <- 0x00000020 not implemented
>   SDHC wr_4b @0x8c <- 0x00030000 not implemented
>   SDHC rd_4b @0x80 not implemented
>   SDHC wr_4b @0x80 <- 0xc0004100 not implemented
>   SDHC wr_4b @0x84 <- 0x80808080 not implemented
>   [   26.013318] mmc0: SDHCI controller on samsung-hsmmc [12530000.sdhci]=
 using ADMA
>   [   26.032318] Synopsys Designware Multimedia Card Interface Driver
>   [   42.024885] Waiting for root device /dev/mmcblk0...
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/exynos4210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


