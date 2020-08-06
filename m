Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE7FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253092075A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 23:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jQd2fDDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253092075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3pH7-00085I-1a
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 19:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pEz-00076k-Po; Thu, 06 Aug 2020 19:24:06 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k3pEx-0001u6-OW; Thu, 06 Aug 2020 19:24:05 -0400
Received: by mail-ej1-x644.google.com with SMTP id bo3so96111ejb.11;
 Thu, 06 Aug 2020 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ns+VUHIhkunqh3gb5/0BaCpY+0iYgc0OmBiyxFo4YW4=;
 b=jQd2fDDzYrAKWnVjw6T2imkW6kN9vx4TJ7iEstR7yY5Fe9sQRHyKFT1yx2XWBelFQu
 mnQ/XJMT/S+2p4ff3gS1qZBN1GfRIrfaPNW1atoMWBNy/moegAhzN07/Dp4PiNsFBBVY
 nbWVYpw0NKNJPraTeNOgTUClFwITzOlLlbBP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ns+VUHIhkunqh3gb5/0BaCpY+0iYgc0OmBiyxFo4YW4=;
 b=hZy6EMiu0fKDwLB9ZuTRM4NOIv+rDVGFyH3YUAutEPEGEzr7IPG185vTUc9hz7sZ0g
 yNm2+pqae4JPKsCv7MkVxXl+PhPtJDMWJJChMjwZW0athSbFCnupmv3IsBNdVx5zIRkS
 88fatbWe6xRZV7n5n7AjZmeTwk14xJ+FHznDOFptaY1y3jL3NaR0rDwunwo4MsliCa46
 VYWC1HysEvwvVBA1INdvu44LPB3GcVUPJImzXbTneuVJzTQMjW7+Z04IceHi8gOEGjg9
 mV7/kbKHGsuY8z94r9pRGzFq7qTDWejTmbyawiTWY4pLrpZiG6ZbSxRWQAzOU/8USFE/
 7hTw==
X-Gm-Message-State: AOAM531UwJTzI0zzKYZqWUxgzrjFCs7t4ot78jplHSE6ZncOpFe/fDhE
 KSR2+fTla9V8SOfnjpSBeFDMHcnFSNcXAUxMsCc=
X-Google-Smtp-Source: ABdhPJxhQLdnuB2Uoi/YQwnjGJpy6P8ribD//OL6FUl5VNjj7flWQlGVN3BudDOjUIIeX+9rZxK673OhlcRPmecfglo=
X-Received: by 2002:a17:906:7790:: with SMTP id
 s16mr7125793ejm.254.1596756240334; 
 Thu, 06 Aug 2020 16:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-6-clg@kaod.org>
In-Reply-To: <20200806132106.747414-6-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 6 Aug 2020 23:23:47 +0000
Message-ID: <CACPK8Xc2A+FX4tz-mXy0eH8-SkOn3=_9zQ5xzMynMgLYBckAcw@mail.gmail.com>
Subject: Re: [PATCH for-5.2 05/19] hw/arm/aspeed: Add board model for
 Supermicro X11 BMC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
 erik-smit <erik.lucas.smit@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> From: erik-smit <erik.lucas.smit@gmail.com>
>
> The BMC Firmware can be downloaded from :
>
>   https://www.supermicro.com/en/products/motherboard/X11SSL-F
>
> Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> [ clg: Modified commit log ]
> Message-Id: <20200715173418.186-1-erik.lucas.smit@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/arm/aspeed.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index fcb1a7cd8729..d17a4885a03c 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -57,6 +57,20 @@ struct AspeedMachineState {
>          SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       =
\
>          SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
>
> +/* TODO: Find the actual hardware value */

I've asked some bmc people if they could provide this.

> +#define SUPERMICROX11_BMC_HW_STRAP1 (                                   =
\
> +        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               =
\
> +        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2) |                           =
\
> +        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 =
\
> +        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       =
\
> +        SCU_HW_STRAP_VGA_CLASS_CODE |                                   =
\
> +        SCU_HW_STRAP_LPC_RESET_PIN |                                    =
\
> +        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                =
\
> +        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1=
) | \
> +        SCU_HW_STRAP_SPI_WIDTH |                                        =
\
> +        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       =
\
> +        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
> +
>  /* AST2500 evb hardware value: 0xF100C2E6 */
>  #define AST2500_EVB_HW_STRAP1 ((                                        =
\
>          AST2500_HW_STRAP1_DEFAULTS |                                    =
\
> @@ -603,6 +617,23 @@ static void aspeed_machine_palmetto_class_init(Objec=
tClass *oc, void *data)
>          aspeed_soc_num_cpus(amc->soc_name);
>  };
>
> +static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
> +                                                        void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc       =3D "Supermicro X11 BMC (ARM926EJ-S)";
> +    amc->soc_name  =3D "ast2400-a1";
> +    amc->hw_strap1 =3D SUPERMICROX11_BMC_HW_STRAP1;
> +    amc->fmc_model =3D "mx25l25635e";
> +    amc->spi_model =3D "mx25l25635e";
> +    amc->num_cs    =3D 1;
> +    amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON;
> +    amc->i2c_init  =3D palmetto_bmc_i2c_init;
> +    mc->default_ram_size =3D 256 * MiB;
> +}
> +
>  static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void =
*data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -731,6 +762,10 @@ static const TypeInfo aspeed_machine_types[] =3D {
>          .name          =3D MACHINE_TYPE_NAME("palmetto-bmc"),
>          .parent        =3D TYPE_ASPEED_MACHINE,
>          .class_init    =3D aspeed_machine_palmetto_class_init,
> +    }, {
> +        .name          =3D MACHINE_TYPE_NAME("supermicrox11-bmc"),
> +        .parent        =3D TYPE_ASPEED_MACHINE,
> +        .class_init    =3D aspeed_machine_supermicrox11_bmc_class_init,
>      }, {
>          .name          =3D MACHINE_TYPE_NAME("ast2500-evb"),
>          .parent        =3D TYPE_ASPEED_MACHINE,
> --
> 2.25.4
>

