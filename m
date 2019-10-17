Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC020C4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7317B21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Jy+lkGxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7317B21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKzPQ-00049g-HZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 02:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iKzM6-00037L-H2
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iKzM5-0006Vi-Ca
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:33:50 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:36531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iKzLx-0006QI-Q3; Thu, 17 Oct 2019 02:33:42 -0400
Received: by mail-qk1-x743.google.com with SMTP id y189so886760qkc.3;
 Wed, 16 Oct 2019 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=liYEOxYNZbGAJroK2AsMxBWZpouKVq7N+VunlUN+J9k=;
 b=Jy+lkGxuNzyQS5aPmMqdNWInJeLZPl26ozmTl/EMaQ7sReehhYRFoHQjdv+SxsMyt1
 mRcFBLcwTuwO8vEu/JsxELDNHueRa6YRzi90hjpUQ33zlFt5P8SnPl7EdEcxR4kR1OuH
 noGcbbB+VX8FViAnrO53Vgudta8l9MySuv+m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=liYEOxYNZbGAJroK2AsMxBWZpouKVq7N+VunlUN+J9k=;
 b=nJ9jEaaK1CJo9JsRYGnpYFy5Ni3gzCF5LeVHeStLNQKTyAOVfg4LCDtuFuwiOHy51r
 e9TtUq160URup93VCn2vo2Nih9lDAVrEY0q/H6P7yXMC90fmuYwoQtkKZGI5UsTzYEo6
 AePCEMfaMnzvS2saKZQOCcu5exdlzdggMBcPFpfdLRihumih1EjMn4X74PDmvbaZ/jK1
 1texpv73aNZpIAvovCKhpcHEOBMyBnU0BHwhnaKDh3ZbOTGbKHgbcja6vPgQ7tjtw0zK
 Qyn7SXtxTU4rUPlIf/7Rxmr65iEejsXSiK/IXO98H3et/kq2+xeGXz8Qw5v+9zOrJO4m
 GcyA==
X-Gm-Message-State: APjAAAUjWjZmNwOChTRJiEanO8Lxn64zRwVUGUiEAGwWcMbKxWGaAopU
 t9Je4zxtMNfBl36JUzRFEe0s/kEWU3OcUcRaHys=
X-Google-Smtp-Source: APXvYqxycyQYZ2XnZKaaP9TFvACDoBDyc8Ldss3UmlLlLBpi9qMVab8KhyX/fvYM2Hwbbtetegy+3iCyKvzDF1E10Yk=
X-Received: by 2002:a37:4dca:: with SMTP id a193mr1822231qkb.292.1571294020365; 
 Wed, 16 Oct 2019 23:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191016090745.15334-1-clg@kaod.org>
In-Reply-To: <20191016090745.15334-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Oct 2019 06:33:28 +0000
Message-ID: <CACPK8XdT0_JCxzfxd4dCafK0Ae9+18ZWcusuXV+d4eEmwwBnkA@mail.gmail.com>
Subject: Re: [PATCH] aspeed: Add an AST2600 eval board
To: Peter Maydell <peter.maydell@linaro.org>
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 09:08, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Define the board with 1 GiB of RAM but some boards can have up to 2
> GiB.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>
>  Changes since AST2600 patchset:
>
>  - lowered the RAM size to 1 GiB as it was breaking the tests on some
>    hosts.

Peter,

After chatting with C=C3=A9dric I agree we should merge this patch.

As it turns out the EVBs have differing amounts of RAM; his has 1GB
while mine has 2GB. So we are not being inaccurate by setting 1GB as
the default here.

Cheers,

Joel

>
>  include/hw/arm/aspeed.h |  1 +
>  hw/arm/aspeed.c         | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index 02073a6b4d61..f49bc7081e4d 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -18,6 +18,7 @@ typedef struct AspeedBoardConfig {
>      const char *desc;
>      const char *soc_name;
>      uint32_t hw_strap1;
> +    uint32_t hw_strap2;
>      const char *fmc_model;
>      const char *spi_model;
>      uint32_t num_cs;
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 52993f84b461..028191ff36fc 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -88,6 +88,10 @@ struct AspeedBoardState {
>  /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) *=
/
>  #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
>
> +/* AST2600 evb hardware value */
> +#define AST2600_EVB_HW_STRAP1 0x000000C0
> +#define AST2600_EVB_HW_STRAP2 0x00000003
> +
>  /*
>   * The max ram region is for firmwares that scan the address space
>   * with load/store to guess how much RAM the SoC has.
> @@ -187,6 +191,8 @@ static void aspeed_board_init(MachineState *machine,
>                               &error_abort);
>      object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap1, "hw-strap=
1",
>                              &error_abort);
> +    object_property_set_int(OBJECT(&bmc->soc), cfg->hw_strap2, "hw-strap=
2",
> +                            &error_abort);
>      object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
>                              &error_abort);
>      object_property_set_int(OBJECT(&bmc->soc), machine->smp.cpus, "num-c=
pus",
> @@ -308,6 +314,12 @@ static void ast2500_evb_i2c_init(AspeedBoardState *b=
mc)
>      i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338"=
, 0x32);
>  }
>
> +static void ast2600_evb_i2c_init(AspeedBoardState *bmc)
> +{
> +    /* Start with some devices on our I2C busses */
> +    ast2500_evb_i2c_init(bmc);
> +}
> +
>  static void romulus_bmc_i2c_init(AspeedBoardState *bmc)
>  {
>      AspeedSoCState *soc =3D &bmc->soc;
> @@ -455,6 +467,17 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
>          .num_cs    =3D 2,
>          .i2c_init  =3D witherspoon_bmc_i2c_init,
>          .ram       =3D 512 * MiB,
> +    }, {
> +        .name      =3D MACHINE_TYPE_NAME("ast2600-evb"),
> +        .desc      =3D "Aspeed AST2600 EVB (Cortex A7)",
> +        .soc_name  =3D "ast2600-a0",
> +        .hw_strap1 =3D AST2600_EVB_HW_STRAP1,
> +        .hw_strap2 =3D AST2600_EVB_HW_STRAP2,
> +        .fmc_model =3D "w25q512jv",
> +        .spi_model =3D "mx66u51235f",
> +        .num_cs    =3D 1,
> +        .i2c_init  =3D ast2600_evb_i2c_init,
> +        .ram       =3D 1 * GiB,
>      },
>  };
>
> --
> 2.21.0
>

