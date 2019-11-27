Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14F5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BEE20674
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BEE20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyNp-0003xI-24
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <erosca@de.adit-jv.com>) id 1iZy7x-0002vQ-C5
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <erosca@de.adit-jv.com>) id 1iZy6X-0005dz-Ku
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:15:42 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <erosca@de.adit-jv.com>)
 id 1iZy6X-0005cM-Df
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:15:41 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id E725A3C057C;
 Wed, 27 Nov 2019 15:15:37 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bipKjdt3AzRZ; Wed, 27 Nov 2019 15:15:32 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D79383C00BE;
 Wed, 27 Nov 2019 15:15:32 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Wed, 27 Nov 2019 15:15:32 +0100
Date: Wed, 27 Nov 2019 15:15:29 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 5/7] gpio: Add GPIO Aggregator/Repeater driver
Message-ID: <20191127141529.GA18189@vmlxhi-102.adit-jv.com>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-6-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20191127084253.16356-6-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 93.241.18.167
X-Mailman-Approved-At: Wed, 27 Nov 2019 09:32:05 -0500
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Phil Reid <preid@electromag.com.au>, Eugeniu Rosca <roscaeugeniu@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-doc@vger.kernel.org,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Harish Jenny K N <harish_kandiga@mentor.com>,
 linux-gpio@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Geert,

Many thanks for the series upgrade.
A few static-analysis findings below (could be false positives).

On Wed, Nov 27, 2019 at 09:42:51AM +0100, Geert Uytterhoeven wrote:

[..]

> +static bool isrange(const char *s)
> +{
> +	size_t n =3D strlen(s);

Cppcheck 1.40-18521-ge6d692d96058:
drivers/gpio/gpio-aggregator.c:69:11: style: Variable 'n' is assigned a v=
alue that is never used. [unreadVariable]

Smatch v0.5.0-6150-gc1ed13e4ee7b:
drivers/gpio/gpio-aggregator.c:69 isrange() warn: unused return: n =3D st=
rlen()

[..]

> +	aggr->lookups->dev_id =3D kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, id=
);
> +	if (!aggr->lookups) {
> +		res =3D -ENOMEM;
> +		goto remove_idr;
> +	}

s/aggr->lookups/aggr->lookups->dev_id/ ?

[..]

> +static int gpio_fwd_get_multiple(struct gpio_chip *chip, unsigned long=
 *mask,
> +				 unsigned long *bits)
> +{
> +	struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
> +	unsigned long *values, flags;

gcc 9.2.1:
warning: =E2=80=98flags=E2=80=99 may be used uninitialized in this functi=
on [-Wmaybe-uninitialized]

[..]

> +static void gpio_fwd_set_multiple(struct gpio_chip *chip, unsigned lon=
g *mask,
> +				  unsigned long *bits)
> +{
> +	struct gpiochip_fwd *fwd =3D gpiochip_get_data(chip);
> +	unsigned long *values, flags;

gcc 9.2.1, same as above:
warning: =E2=80=98flags=E2=80=99 may be used uninitialized in this functi=
on [-Wmaybe-uninitialized]

Should these be silenced like in 2bf593f101f3ca ("xilinx_uartps.c:
suppress "may be used uninitialised" warning") ?

I plan to do some runtime testing soon.

--=20
Best Regards,
Eugeniu

