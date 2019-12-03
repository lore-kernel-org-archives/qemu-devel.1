Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C4E2146E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C4E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic8wY-0004U2-SM
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 09:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic0tu-0003fh-5d
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Harish_Kandiga@mentor.com>) id 1ic0ts-0002uB-Lg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:39:05 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:53554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Harish_Kandiga@mentor.com>)
 id 1ic0ts-0002pj-D4
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:39:04 -0500
IronPort-SDR: fq7fUAlf+x9crPx/TDcLtyBZpRCe5qvKP8GdD0pYLjZb5/uMJ3ykbx7g/bA78kWDvTJyBeCreI
 xH3OSMBV50shw9pt9d2SfKStvyINN6bZs56C4H4BQHEs5kLgZz8QstNuT3ztBAgFATV1g5mpeX
 B114ypQXdRt/6WL68+8LGXX6r2pqBgVcFY8yc1qna/28ahrjohmmqVagnUzdmKtUVMRMzYY6IF
 86pKA+bGaFptWQ+c7hyss5R+5EXvXn9OnJdD+9MNHZnfiS1za6qwsEwVveVMc53Pax/7LPCFeN
 /aM=
X-IronPort-AV: E=Sophos;i="5.69,272,1571731200"; d="scan'208";a="43750555"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 02 Dec 2019 21:39:00 -0800
IronPort-SDR: CS+/PFfMeBEEboWNM9uO8MfkB5+1Jw2If93U9GqifcEak1hYwSyMqw80qtlCDQyGVTVWHHxfc0
 dY4fx5qx2hZcVWxqPasbVxOpZ5KBOx9wobtkmaFZHTfSfZIaS44+kQa5mxpJK+f6B0Y9I7hoVb
 aDUNpiduLHuKhhgObPo0fTv8wecaxveAm95henyvT9wLZMHJEBeHvhTt8XZg022fv0uUPzg31S
 WCX584OWrpCdgRRgexlrBpxMsnWLw19LLxA9T7wb421CTBowqE1cySEw4pDt5Gfq78kmgRknUE
 XnQ=
Subject: Re: [PATCH v3 7/7] MAINTAINERS: Add GPIO Aggregator/Repeater section
To: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
References: <20191127084253.16356-1-geert+renesas@glider.be>
 <20191127084253.16356-8-geert+renesas@glider.be>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <58717a28-8599-5f2b-a4fa-de1cce93e975@mentor.com>
Date: Tue, 3 Dec 2019 11:08:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127084253.16356-8-geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.137.252
X-Mailman-Approved-At: Tue, 03 Dec 2019 09:05:26 -0500
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


On 27/11/19 2:12 PM, Geert Uytterhoeven wrote:
> Add a maintainership section for the GPIO Aggregator/Repeater, covering
> documentation, Device Tree bindings, and driver source code.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Harish: Do you want to be listed as maintainer, too?


Yes. please.

>
> v3:
>   - New.
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5949b6827b72f2b..0f12ebdaa8faa76b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7043,6 +7043,14 @@ S:	Maintained
>  F:	Documentation/firmware-guide/acpi/gpio-properties.rst
>  F:	drivers/gpio/gpiolib-acpi.c
>  
> +GPIO AGGREGATOR/REPEATER
> +M:	Geert Uytterhoeven <geert+renesas@glider.be>
> +L:	linux-gpio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/admin-guide/gpio/gpio-aggregator.rst
> +F:	Documentation/devicetree/bindings/gpio/gpio-repeater.yaml
> +F:	drivers/gpio/gpio-aggregator.c
> +
>  GPIO IR Transmitter
>  M:	Sean Young <sean@mess.org>
>  L:	linux-media@vger.kernel.org

