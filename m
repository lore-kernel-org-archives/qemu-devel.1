Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5A1C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 05:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F382072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 05:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="S6mo9Vhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F382072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFATG-0001I3-U7
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 01:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1jFAQs-0000em-Rv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 01:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1jFAQr-00085y-KC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 01:42:58 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:39663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1jFAQk-00084D-QE; Fri, 20 Mar 2020 01:42:51 -0400
Received: by mail-qk1-x741.google.com with SMTP id t17so5739193qkm.6;
 Thu, 19 Mar 2020 22:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kRKgru/C/4SxQ3jyweadKM188j334/htLs6Vp9RUPq4=;
 b=S6mo9Vhv+HU+HL4kKnYwUu68MmpPiTQeQ7ZduQDXSb9skBnjyNfCqBKLKeJwWV0QVn
 KZNdaQO8Qc+OTwlARFGX8bYGpWbqPqhkuITcaUGRw+0HpN9FMYgJ/8LpHvSJX9QBmYTq
 9T0me5QzsC+aBj4kmqHX16lkZ2JzuyVpF54ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kRKgru/C/4SxQ3jyweadKM188j334/htLs6Vp9RUPq4=;
 b=LpfAv45EGvCyzX7Ioh5b7uy3KEMyByXDJEe0Cj6J/CVurkCoYFeQ/DDxmotTMM/JCI
 PI53j6Xiy+HjknKEyDHJTuzfxO1a20S8RmuxScgQ4tR5WCNERPP9gCllCpTqbSYNzXcE
 JbMftGg4/cSUIBjlLTQpMQHF09ML2ZElLdu/EXUj72t1vmgYN385i+CedzTVgd3mJvvj
 ZqbRXuItHijlXCwIgG9poLuyjfNPfgbCi9mfRGgSeVRdw/eeZdztkI/3j2xIw+E1MjE/
 mf+MaT6u8Jw9Oyx1WpLG6f5S8H0BoXqzYgHD+ATPAFE2AEEVcW8A1Ux6cpoLqNSmEjch
 pUSg==
X-Gm-Message-State: ANhLgQ2aJJ1BoNc8c9grjWJidOFBzyo2aRVLnTRYrT/GU9IXzQjCN/DX
 ZXbC1IyadWl/rGHtgrXudUDIyghDbihJM3kmUcw=
X-Google-Smtp-Source: ADFU+vvGFaxdTjyyB20ANydo/ecSQszxNEV0Vo5UPduwwfMI0opFIyPhTZJsyHh5ldK0Xm2wYEPKkDd8MwNV/N90m5c=
X-Received: by 2002:ae9:e810:: with SMTP id a16mr6378393qkg.208.1584682969550; 
 Thu, 19 Mar 2020 22:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200320053923.20565-1-clg@kaod.org>
In-Reply-To: <20200320053923.20565-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Mar 2020 05:42:37 +0000
Message-ID: <CACPK8Xe=TCQyE+E6a3v-xc7uU=HePrSvZfQr32OkQ=DVVO1DcA@mail.gmail.com>
Subject: Re: [PATCH] aspeed/smc: Fix DMA support for AST2600
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 05:39, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Recent firmwares uses SPI DMA transfers in U-Boot to load the
> different images (kernel, initrd, dtb) in the SoC DRAM. The AST2600
> FMC model is missing the masks to be applied on the DMA registers
> which resulted in incorrect values. Fix that and wire the SPI
> controllers which have DMA support on the AST2600.
>
> Fixes: bcaa8ddd081c ("aspeed/smc: Add AST2600 support")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

I gave this a spin with the Tacoma machine and it resolved the issue I
saw. Thanks for fixing it.

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
>  hw/arm/aspeed_ast2600.c |  6 ++++++
>  hw/ssi/aspeed_smc.c     | 15 +++++++++++++--
>  hw/ssi/trace-events     |  1 +
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 446b44d31cf1..1a869e09b96a 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -411,6 +411,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
>
>      /* SPI */
>      for (i =3D 0; i < sc->spis_num; i++) {
> +        object_property_set_link(OBJECT(&s->spi[i]), OBJECT(s->dram_mr),
> +                                 "dram", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
>          object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
>                                   &local_err);
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 9d5c696d5a17..2edccef2d54d 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -364,6 +364,8 @@ static const AspeedSMCController controllers[] =3D {
>          .flash_window_base =3D ASPEED26_SOC_FMC_FLASH_BASE,
>          .flash_window_size =3D 0x10000000,
>          .has_dma           =3D true,
> +        .dma_flash_mask    =3D 0x0FFFFFFC,
> +        .dma_dram_mask     =3D 0x3FFFFFFC,
>          .nregs             =3D ASPEED_SMC_R_MAX,
>          .segment_to_reg    =3D aspeed_2600_smc_segment_to_reg,
>          .reg_to_segment    =3D aspeed_2600_smc_reg_to_segment,
> @@ -379,7 +381,9 @@ static const AspeedSMCController controllers[] =3D {
>          .segments          =3D aspeed_segments_ast2600_spi1,
>          .flash_window_base =3D ASPEED26_SOC_SPI_FLASH_BASE,
>          .flash_window_size =3D 0x10000000,
> -        .has_dma           =3D false,
> +        .has_dma           =3D true,
> +        .dma_flash_mask    =3D 0x0FFFFFFC,
> +        .dma_dram_mask     =3D 0x3FFFFFFC,
>          .nregs             =3D ASPEED_SMC_R_MAX,
>          .segment_to_reg    =3D aspeed_2600_smc_segment_to_reg,
>          .reg_to_segment    =3D aspeed_2600_smc_reg_to_segment,
> @@ -395,7 +399,9 @@ static const AspeedSMCController controllers[] =3D {
>          .segments          =3D aspeed_segments_ast2600_spi2,
>          .flash_window_base =3D ASPEED26_SOC_SPI2_FLASH_BASE,
>          .flash_window_size =3D 0x10000000,
> -        .has_dma           =3D false,
> +        .has_dma           =3D true,
> +        .dma_flash_mask    =3D 0x0FFFFFFC,
> +        .dma_dram_mask     =3D 0x3FFFFFFC,
>          .nregs             =3D ASPEED_SMC_R_MAX,
>          .segment_to_reg    =3D aspeed_2600_smc_segment_to_reg,
>          .reg_to_segment    =3D aspeed_2600_smc_reg_to_segment,
> @@ -1135,6 +1141,11 @@ static void aspeed_smc_dma_rw(AspeedSMCState *s)
>      MemTxResult result;
>      uint32_t data;
>
> +    trace_aspeed_smc_dma_rw(s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE ?
> +                            "write" : "read",
> +                            s->regs[R_DMA_FLASH_ADDR],
> +                            s->regs[R_DMA_DRAM_ADDR],
> +                            s->regs[R_DMA_LEN]);
>      while (s->regs[R_DMA_LEN]) {
>          if (s->regs[R_DMA_CTRL] & DMA_CTRL_WRITE) {
>              data =3D address_space_ldl_le(&s->dram_as, s->regs[R_DMA_DRA=
M_ADDR],
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> index 0a70629801a9..0ea498de910b 100644
> --- a/hw/ssi/trace-events
> +++ b/hw/ssi/trace-events
> @@ -6,5 +6,6 @@ aspeed_smc_do_snoop(int cs, int index, int dummies, int d=
ata) "CS%d index:0x%x d
>  aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t d=
ata, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
>  aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRI=
x64 " size %u: 0x%" PRIx64
>  aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
> +aspeed_smc_dma_rw(const char *dir, uint32_t flash_addr, uint32_t dram_ad=
dr, uint32_t size) "%s flash:@0x%08x dram:@0x%08x size:0x%08x"
>  aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PR=
Ix64 " size %u: 0x%" PRIx64
>  aspeed_smc_flash_select(int cs, const char *prefix) "CS%d %sselect"
> --
> 2.21.1
>

