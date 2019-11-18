Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06113C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8085220722
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 07:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="cedjCcfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8085220722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWbOJ-00052X-8V
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 02:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iWbFx-0000yb-IM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iWbFw-0000DK-7z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 02:15:29 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:36957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iWbFt-0000Bk-82; Mon, 18 Nov 2019 02:15:25 -0500
Received: by mail-qv1-xf42.google.com with SMTP id s18so6122990qvr.4;
 Sun, 17 Nov 2019 23:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q5sp6VNx9wexE8ZcBy7gIVJOZHvmfhANEpomWVTrTsg=;
 b=cedjCcfHC7l/FovxBLXLSGPYV4U+5jMSMeLadvqPMmqVo5cI1wyH1p+YWJrmp72fa7
 y0bEUPh6H2U0GZ2bgLR8KovtxPUuk0Xs8XA74zy98u9fpyyd7IqbKbT5K7xcgfn1aIR5
 6K6kJGojYgYn5kW1Z7th4WldQZzwpgX31K8sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q5sp6VNx9wexE8ZcBy7gIVJOZHvmfhANEpomWVTrTsg=;
 b=iATEMpdL+okGcReu9pZdhzgieTFFfgsAOiOFkXY/cyntH6Be699GJwbXsxGDi4jfi5
 mRnNEue+V/hzoMTOQ5AhtHhJAsyn8USeBRr0qXfGoPk355lXnd5gkL7hwyo/WToT+QpR
 W/6fkwBxIQCykYiUqXrORk6Kzl8DK15QFHnhSKsR53H/pl/2nybkhnIAdM+6a2F2NwEC
 w5lPjmdUEDtEij348kjimvY5dRBhzTenouFhhowGix6ILi31bNSPVjJEf5cDoEiBESUZ
 EOE+olDRYfSrua40z6OpTTpUcJJ+PeG0ooJtZUEr8N0KCkqie4jSBXaA88CyMboehiZq
 hASA==
X-Gm-Message-State: APjAAAVhal0sj8RhQmWHHOV0tV5WUxVUZ1uBr7vOLc7p36OLqCtMr4NE
 IsnZju4IBjJ0fENAzKCH5EoloacuJQtW85rXeXw=
X-Google-Smtp-Source: APXvYqxSjyxSRTQFIILkt5/5yRwxnMgFR2OHianp3wDTp3f4pm3lBvDGys6Xt4NIUri5DPPtf7/btz05r2StEsIAAJ8=
X-Received: by 2002:a05:6214:2c2:: with SMTP id
 g2mr23856072qvu.210.1574061324137; 
 Sun, 17 Nov 2019 23:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20191114094544.30114-1-clg@kaod.org>
 <20191114094544.30114-4-clg@kaod.org>
In-Reply-To: <20191114094544.30114-4-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 18 Nov 2019 07:15:12 +0000
Message-ID: <CACPK8XcXAYkanw2+fxVh9y+PnQEgrX64PkYYFpxQ5i4B1YgZOQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] aspeed/smc: Add AST2600 timings registers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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

On Thu, 14 Nov 2019 at 09:46, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Each CS has its own Read Timing Compensation Register on newer SoCs.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  include/hw/ssi/aspeed_smc.h |  1 +
>  hw/ssi/aspeed_smc.c         | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 684d16e33613..6fbbb238f158 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -40,6 +40,7 @@ typedef struct AspeedSMCController {
>      uint8_t r_ce_ctrl;
>      uint8_t r_ctrl0;
>      uint8_t r_timings;
> +    uint8_t nregs_timings;
>      uint8_t conf_enable_w0;
>      uint8_t max_slaves;
>      const AspeedSegments *segments;
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 86cadbe4cc00..7755eca34976 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -137,7 +137,7 @@
>  /* Checksum Calculation Result */
>  #define R_DMA_CHECKSUM    (0x90 / 4)
>
> -/* Misc Control Register #2 */
> +/* Read Timing Compensation Register */
>  #define R_TIMINGS         (0x94 / 4)
>
>  /* SPI controller registers and bits (AST2400) */
> @@ -256,6 +256,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 1,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 5,
>          .segments          =3D aspeed_segments_legacy,
> @@ -271,6 +272,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 1,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 5,
>          .segments          =3D aspeed_segments_fmc,
> @@ -288,6 +290,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D 0xff,
>          .r_ctrl0           =3D R_SPI_CTRL0,
>          .r_timings         =3D R_SPI_TIMINGS,
> +        .nregs_timings     =3D 1,
>          .conf_enable_w0    =3D SPI_CONF_ENABLE_W0,
>          .max_slaves        =3D 1,
>          .segments          =3D aspeed_segments_spi,
> @@ -303,6 +306,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 1,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 3,
>          .segments          =3D aspeed_segments_ast2500_fmc,
> @@ -320,6 +324,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 1,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 2,
>          .segments          =3D aspeed_segments_ast2500_spi1,
> @@ -335,6 +340,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 1,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 2,
>          .segments          =3D aspeed_segments_ast2500_spi2,
> @@ -350,6 +356,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 1,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 3,
>          .segments          =3D aspeed_segments_ast2600_fmc,
> @@ -365,6 +372,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 2,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 2,
>          .segments          =3D aspeed_segments_ast2600_spi1,
> @@ -380,6 +388,7 @@ static const AspeedSMCController controllers[] =3D {
>          .r_ce_ctrl         =3D R_CE_CTRL,
>          .r_ctrl0           =3D R_CTRL0,
>          .r_timings         =3D R_TIMINGS,
> +        .nregs_timings     =3D 3,
>          .conf_enable_w0    =3D CONF_ENABLE_W0,
>          .max_slaves        =3D 3,
>          .segments          =3D aspeed_segments_ast2600_spi2,
> @@ -951,7 +960,8 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr =
addr, unsigned int size)
>      addr >>=3D 2;
>
>      if (addr =3D=3D s->r_conf ||
> -        addr =3D=3D s->r_timings ||
> +        (addr >=3D s->r_timings &&
> +         addr < s->r_timings + s->ctrl->nregs_timings) ||
>          addr =3D=3D s->r_ce_ctrl ||
>          addr =3D=3D R_INTR_CTRL ||
>          addr =3D=3D R_DUMMY_DATA ||
> @@ -1216,7 +1226,8 @@ static void aspeed_smc_write(void *opaque, hwaddr a=
ddr, uint64_t data,
>      addr >>=3D 2;
>
>      if (addr =3D=3D s->r_conf ||
> -        addr =3D=3D s->r_timings ||
> +        (addr >=3D s->r_timings &&
> +         addr < s->r_timings + s->ctrl->nregs_timings) ||
>          addr =3D=3D s->r_ce_ctrl) {
>          s->regs[addr] =3D value;
>      } else if (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs) {
> --
> 2.21.0
>

