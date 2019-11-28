Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1974BC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EB5215A5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 03:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="i1gMsNMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EB5215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaAhp-0001Ez-1a
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 22:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <uli@fpond.eu>) id 1iaAeM-0005nt-FG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <uli@fpond.eu>) id 1iaAeI-0004BH-U2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:39:25 -0500
Received: from mo6-p02-ob.smtp.rzone.de ([2a01:238:20a:202:5302::8]:20558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <uli@fpond.eu>) id 1iaAeC-00042V-On
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 22:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574912354;
 s=strato-dkim-0002; d=fpond.eu;
 h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=qjrBmargKbQJaNw983uGNYrR6fuiqDOtF3J2Kjzo0RU=;
 b=i1gMsNMXf9t2MDd4ubDvI69BiLvc5slwHRe0DwVRSbX6ostEWc5KWJFySN/VupB5on
 Ae3lxb/X+AMyJ7LjKppwwoqrFDqhy2ytzsU/TWnZaUVSHuwkWS/68YGbWItafLvVuhm2
 ++OAsXPZY36ZWOg62MwbRxp9TMeTwsHQ6ptUJ+gklTSl1xUyDjojEcZsTmSdsWv+QEXo
 EhzAC+cNRVbN5NVabf9wiDlzQeG7Ryiewl6DxGNcGEn6Or82B48LPj6gjwMc87N/55cP
 L619cKoLoqRJibp8100q0Y5ZKqxVnk/htG0GqJHg6MvIrBA4/bEijO7fl4jb6BBD2hSR
 Ijqg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de by smtp-ox.front (RZmta 46.0.0 AUTH)
 with ESMTPSA id 604beevAS3dE2Ir
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 28 Nov 2019 04:39:14 +0100 (CET)
Date: Thu, 28 Nov 2019 04:39:14 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Message-ID: <1581673808.1467700.1574912354104@webmail.strato.com>
In-Reply-To: <20191127084253.16356-4-geert+renesas@glider.be>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-4-geert+renesas@glider.be>
Subject: Re: [PATCH v3 3/7] gpiolib: Add support for GPIO line table lookup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev22
X-Originating-IP: 112.198.74.215
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5302::8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 linux-doc@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On November 27, 2019 at 9:42 AM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> Currently GPIOs can only be referred to by GPIO controller and offset in
> GPIO lookup tables.
> 
> Add support for looking them up by line name.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> If this is rejected, the GPIO Aggregator documentation and code must be
> updated.
> 
> v3:
>   - New.
> ---
>  drivers/gpio/gpiolib.c       | 12 ++++++++++++
>  include/linux/gpio/machine.h |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index d24a3d79dcfe69ad..cb608512ad6bbded 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4475,6 +4475,18 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
>  		if (p->con_id && (!con_id || strcmp(p->con_id, con_id)))
>  			continue;
>  
> +		if (p->chip_hwnum == (u16)-1) {
> +			desc = gpio_name_to_desc(p->chip_label);
> +			if (desc) {
> +				*flags = p->flags;
> +				return desc;
> +			}
> +
> +			dev_warn(dev, "cannot find GPIO line %s, deferring\n",
> +				 p->chip_label);
> +			return ERR_PTR(-EPROBE_DEFER);
> +		}
> +
>  		chip = find_chip_by_name(p->chip_label);
>  
>  		if (!chip) {
> diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
> index 1ebe5be05d5f81fa..84c1c097e55eefaf 100644
> --- a/include/linux/gpio/machine.h
> +++ b/include/linux/gpio/machine.h
> @@ -31,7 +31,7 @@ enum gpio_lookup_flags {
>   */
>  struct gpiod_lookup {
>  	const char *chip_label;
> -	u16 chip_hwnum;
> +	u16 chip_hwnum;			/* if -1, chip_label is named line */

The magic number "-1" might deserve a #define.

>  	const char *con_id;
>  	unsigned int idx;
>  	unsigned long flags;
> -- 
> 2.17.1
>

With or without #define,
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli

