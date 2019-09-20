Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31823C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA602086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="TkHrmNNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA602086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBOG-000529-Vb
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAx7-0006mn-Q0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBAic-0004vw-1L
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:40:30 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBAia-0004vR-Me; Fri, 20 Sep 2019 00:40:28 -0400
Received: by mail-qk1-x743.google.com with SMTP id h126so5967560qke.10;
 Thu, 19 Sep 2019 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nfIYww4aSvg/Xy1lI9Qt7dwpBN/ypbmuNqNckj9f5js=;
 b=TkHrmNNsDQ3+dh4R1zd4sdc+bOSI5kvfqygM/VycQ38oPjbiG5F96Z3GszoPw4Qf4W
 WZPo2MC43lMJdH5thTD3x8wWo1S3WkYEBlkFRcFur+vOKMu0Aon/Ld6GIJvQqekp2o7d
 sBwGCQYatxQlcn3p1kU6QREA2k4ieQ46hiL4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nfIYww4aSvg/Xy1lI9Qt7dwpBN/ypbmuNqNckj9f5js=;
 b=iAOc0LmN/xB8MVR05/AFz5IXdDMx0MOGKB0TmER3bPcFWa868I8djQdVS7eXssAedh
 zZ+DdBnIKXD1x+dI7OweUtUDLXp6Z7L8tMU3HwxqLEbMs0rd9M29CDSwXT/Z34Yfkk7U
 WyikUmCkilc9ysLcYJYxw+CLVMBy3X4n0LowXt54UXUsKJvsmadJJAccpoxJ/pu9zf4i
 XgOGRkuTfR8lAHnwkQPKlegbsHEdP8wje2UQu8NOAkACsB3Ks8blY4YSEEDr12oCSPkg
 1qWpYWxaqw1IlTFtvwoRx97IDIzl9ZUVNggBBOUu0doYHRttAn+coJNMSXEnq1oJLXed
 9nGw==
X-Gm-Message-State: APjAAAXadGtJHv0IfgG4HRwdjxvG5rfdrWnhaFtmelJlGInCO4TsTJ/g
 QIdzVgoOz5kpIHb9HTDP9OvO3Oxq/llGfSY71yE=
X-Google-Smtp-Source: APXvYqxIed3ZTSMhhg5MVl3mB0y7Lj+mH+Xrlmp/QttnotyvFATYwyM9sy8dL1cwZbypM6j3SrBKHMO4XQ3vox60ce8=
X-Received: by 2002:a37:4f4c:: with SMTP id d73mr1670173qkb.171.1568954427786; 
 Thu, 19 Sep 2019 21:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-19-clg@kaod.org>
In-Reply-To: <20190919055002.6729-19-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:40:16 +0000
Message-ID: <CACPK8XcfEqYUju2S9Q3Qy7=gNaN-7rnD0yOWK9KUHd++K2j7Fw@mail.gmail.com>
Subject: Re: [PATCH 18/21] aspeed: Add an AST2600 eval board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 05:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 52993f84b461..4450e71e5547 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -88,6 +88,9 @@ struct AspeedBoardState {
>  /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
>  #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>
> +/* AST2600 evb hardware value: (QEMU prototype) */
> +#define AST2600_EVB_HW_STRAP1 AST2500_EVB_HW_STRAP1

We can change this to be the actual values if you want:

STRAP1: 0x000000C0
STRAP2: 0x00000003

> +        .name      =3D MACHINE_TYPE_NAME("ast2600-evb"),
> +        .desc      =3D "Aspeed AST2600 EVB (Cortex A7)",
> +        .soc_name  =3D "ast2600-a0",
> +        .hw_strap1 =3D AST2600_EVB_HW_STRAP1,
> +        .fmc_model =3D "mx25l25635e",
> +        .spi_model =3D "mx25l25635e",
> +        .num_cs    =3D 1,
> +        .i2c_init  =3D ast2600_evb_i2c_init,

Can we add a default ram size?

mc->default_ram_size =3D 2 * GiB;

With these two fixed:

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

