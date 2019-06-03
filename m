Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA6C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F3E263CC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="cnYlZ8d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F3E263CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXwhj-0008VG-LG
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 19:49:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hXwgQ-0007rP-Kj
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 19:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hXwWG-0003Ym-1u
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 19:37:37 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hXwWC-0003Tv-GU; Mon, 03 Jun 2019 19:37:33 -0400
Received: by mail-qt1-x841.google.com with SMTP id d23so11669531qto.2;
	Mon, 03 Jun 2019 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=IedQnp4n7sc7uhKmP28GSGedfo6Wzjji7nOXohQAD28=;
	b=cnYlZ8d6hCbp1G6CpcTvjkH9vK0QIu19eYL0DUWg9YQo8i7PtV+73O24HR/z6K/3Es
	9+4WyhPfyNR1B0Aznzd4dJ8uKFRWJw7h5PKE9o+fSZnWJ6S/4b9CM4b8seCNWus7uvz3
	9XfpvGR6ZYBoHNNTYL62iQcZfhQySX0oaHDiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=IedQnp4n7sc7uhKmP28GSGedfo6Wzjji7nOXohQAD28=;
	b=VZD4SvKjG942LrVgqg9F7jSns4TCwYzyHfojJWFbEWvi+O69+jeZiBqrqfkNNX33S+
	Sob2ZRdZb+RfT+93yIQ9Zl3DwnRx/feaXy/sCK4BguS8L9Ey4B1MeaB824r9aILqiH27
	tvPB7h0nXETcvAjmCBUNY/aF5dnx3iiU1EtpXGSV+2QGBCIaiK3qSrwjsuc/HW6kkuAW
	gtYfjIkoxdazmi03+rFxVju5aRdnmhiB+33O7ghYeEACTo04Vgc1RyoRpyCtSu36zoOZ
	1G/aL4eZylvG0fJNFboh+cBRKNlDksO1/ZlT/sqUpFXt0Usyb8b9JYjlB28Yp21HT+n8
	P/vg==
X-Gm-Message-State: APjAAAUiHnhmcujBjJx97vWmIQ3RCJm2KMxE7ahFDe1q2WPrrgpqP7qY
	6HUJ/NLZ+pliWmNTprIpG3D6fQzhHj5PANjqh18=
X-Google-Smtp-Source: APXvYqwPMn6C+aXt0Y4aR9EA6ZdAQeg8ALTcCFMKpcLpzaeiWS0UtIsmLIVvDQLYTWlGOwCJVduLL/7CvYS9ANe6bug=
X-Received: by 2002:a0c:8732:: with SMTP id 47mr3389651qvh.105.1559605049053; 
	Mon, 03 Jun 2019 16:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <1559589055-71202-1-git-send-email-anoo@linux.ibm.com>
In-Reply-To: <1559589055-71202-1-git-send-email-anoo@linux.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 3 Jun 2019 23:37:17 +0000
Message-ID: <CACPK8XdDBYK4V50efHiqjwR7GAu+WYMsxpeRyOMTgATS05re7g@mail.gmail.com>
To: Adriana Kobylak <anoo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH qemu] aspeed: Add support for the swift-bmc
 board
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
	Adriana Kobylak <anoo@us.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Jun 2019 at 19:11, Adriana Kobylak <anoo@linux.ibm.com> wrote:
>
> From: Adriana Kobylak <anoo@us.ibm.com>
>
> The Swift board is an OpenPOWER system hosting POWER processors.
> Add support for their BMC including the I2C devices as found on HW.
>
> Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 33070a6..cd95b3c 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -73,6 +73,9 @@ struct AspeedBoardState {
>          SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              =
\
>          SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
>
> +/* TODO: Swift hardware value: ? (use romulus definition for now) */
> +#define SWIFT_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1

I got this from hardware: 0xF11AD206

The rest looks okay.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> +
>  /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
>  #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>
> @@ -287,6 +290,35 @@ static void romulus_bmc_i2c_init(AspeedBoardState *b=
mc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
>  }
>
> +static void swift_bmc_i2c_init(AspeedBoardState *bmc)
> +{
> +    AspeedSoCState *soc =3D &bmc->soc;
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552"=
, 0x60);
> +
> +    /* The swift board expects a TMP275 but a TMP105 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105",=
 0x48);
> +    /* The swift board expects a pca9551 but a pca9552 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "pca9552"=
, 0x60);
> +
> +    /* The swift board expects an Epson RX8900 RTC but a ds1338 is compa=
tible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "ds1338",=
 0x32);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552"=
, 0x60);
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp423",=
 0x4c);
> +    /* The swift board expects a pca9539 but a pca9552 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "pca9552"=
, 0x74);
> +
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "tmp423"=
, 0x4c);
> +    /* The swift board expects a pca9539 but a pca9552 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "pca9552=
",
> +                     0x74);
> +
> +    /* The swift board expects a TMP275 but a TMP105 is compatible */
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105"=
, 0x48);
> +    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105"=
, 0x4a);
> +}
> +
>  static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
>  {
>      AspeedSoCState *soc =3D &bmc->soc;
> @@ -378,6 +410,16 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>          .i2c_init  =3D romulus_bmc_i2c_init,
>          .ram       =3D 512 * MiB,
>      }, {
> +        .name      =3D MACHINE_TYPE_NAME("swift-bmc"),
> +        .desc      =3D "OpenPOWER Swift BMC (ARM1176)",
> +        .soc_name  =3D "ast2500-a1",
> +        .hw_strap1 =3D SWIFT_BMC_HW_STRAP1,
> +        .fmc_model =3D "mx66l1g45g",
> +        .spi_model =3D "mx66l1g45g",
> +        .num_cs    =3D 2,
> +        .i2c_init  =3D swift_bmc_i2c_init,
> +        .ram       =3D 512 * MiB,
> +    }, {
>          .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
>          .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
>          .soc_name  =3D "ast2500-a1",
> --
> 1.8.3.1
>

