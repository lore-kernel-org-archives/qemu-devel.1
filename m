Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF1FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563452071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="lj2t+wLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563452071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kARzi-0002b5-Bx
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 01:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kARxC-0001yb-28; Tue, 25 Aug 2020 01:57:06 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kARx8-0000JG-Sj; Tue, 25 Aug 2020 01:57:05 -0400
Received: by mail-ed1-x544.google.com with SMTP id bs17so10147057edb.1;
 Mon, 24 Aug 2020 22:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/aD9qkx3dItPYsJa84Gx5bqxbnbVUVWagU8sXmDR4hQ=;
 b=lj2t+wLXySqKB8Ug4msLqUENDCJYbiAIoXr17RVJZ/aHPdFbp9T0ZvPQDyYrH6aewU
 dfIGxQ6yu3HC3TGMsGT3PLvyrJv+ROeT+Ad0VvnoT3bwh+7ozj7aBytwGSukCr/2nzHt
 vZk3FvqXVPf+HtcZDZs3vFa3ppgqkC6eBnogI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/aD9qkx3dItPYsJa84Gx5bqxbnbVUVWagU8sXmDR4hQ=;
 b=cM/AkDOUFJPp1OJhmnq6MIQ+LvIFZbmDdWYPvznTgav1HBcG/J3FmnwM2a2FVdT/6L
 gbj5LfleBjdF6NdURbR3w+DnLC5ZhIUB/cQN/YLRqGFCWpyMbpW+MBvo4IUx+bS3gtuF
 6+YJiIE5DJfRmxTCtEhpc7anVkxsGsYa2MG1nsQirMZP8M2oK3h1D1VsVjFYsy+NQmWS
 SMMAK7X3XK8FF4tAZ0jiQRD8NdPRN/3ONVPuseDuUULO43tksKrrTgNvkebaZnbBrIuT
 VNq0MUtbU6ZrD22G0KEaYuXYjC0Z/BCtrTscY0IlXNLeFS+3Dj0bbcTSWlnAl6s6SF4k
 DHnQ==
X-Gm-Message-State: AOAM531zB2/cHb4EgJqtjiKIsYS5Oo3WgMmm5lt5vcg2enhEYWYR3flg
 Okx/o2EwkeGo1DwvV1TKnlMJ44iyRebqVYvuRCE=
X-Google-Smtp-Source: ABdhPJzSIgdeIWO8WnYGMRyfPvAm9xwPG4Ifj5y/OQRtFO+1KX4bKGSS1p2skCYqnrW1uAPs8WbIpZ16EBklFupUylM=
X-Received: by 2002:a50:f403:: with SMTP id r3mr7540875edm.260.1598335020522; 
 Mon, 24 Aug 2020 22:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200819100956.2216690-1-clg@kaod.org>
 <20200819100956.2216690-9-clg@kaod.org>
In-Reply-To: <20200819100956.2216690-9-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 25 Aug 2020 05:56:47 +0000
Message-ID: <CACPK8Xep5-nUqDFwd_HbG9OjV+vrwS1t_WgPsJJQoh9HHeSf+Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] aspeed/sdhci: Fix reset sequence
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 qemu-arm <qemu-arm@nongnu.org>, Eddie James <eajames@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 at 10:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> BIT(0) of the ASPEED_SDHCI_INFO register is set by SW and polled until
> the bit is cleared by HW.
>
> Use the number of supported slots to define the default value of this
> register (The AST2600 eMMC Controller only has one). Fix the reset
> sequence by clearing automatically the RESET bit.
>
> Cc: Eddie James <eajames@linux.ibm.com>
> Fixes: 2bea128c3d0b ("hw/sd/aspeed_sdhci: New device")
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/sd/aspeed_sdhci.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index 22cafce0fbdc..4f24b7d2f942 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -16,7 +16,9 @@
>  #include "hw/qdev-properties.h"
>
>  #define ASPEED_SDHCI_INFO            0x00
> -#define  ASPEED_SDHCI_INFO_RESET     0x00030000
> +#define  ASPEED_SDHCI_INFO_SLOT1     (1 << 17)
> +#define  ASPEED_SDHCI_INFO_SLOT0     (1 << 16)
> +#define  ASPEED_SDHCI_INFO_RESET     (1 << 0)
>  #define ASPEED_SDHCI_DEBOUNCE        0x04
>  #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
>  #define ASPEED_SDHCI_BUS             0x08
> @@ -67,6 +69,10 @@ static void aspeed_sdhci_write(void *opaque, hwaddr ad=
dr, uint64_t val,
>      AspeedSDHCIState *sdhci =3D opaque;
>
>      switch (addr) {
> +    case ASPEED_SDHCI_INFO:
> +        /* The RESET bit automatically clears. */
> +        sdhci->regs[TO_REG(addr)] =3D (uint32_t)val & ~ASPEED_SDHCI_INFO=
_RESET;
> +        break;
>      case ASPEED_SDHCI_SDIO_140:
>          sdhci->slots[0].capareg =3D (uint64_t)(uint32_t)val;
>          break;
> @@ -155,7 +161,11 @@ static void aspeed_sdhci_reset(DeviceState *dev)
>      AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
>
>      memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
> -    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D ASPEED_SDHCI_INFO_RESET;
> +
> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D ASPEED_SDHCI_INFO_SLOT0;
> +    if (sdhci->num_slots =3D=3D 2) {
> +        sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] |=3D ASPEED_SDHCI_INFO_SL=
OT1;
> +    }
>      sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] =3D ASPEED_SDHCI_DEBOUNCE=
_RESET;
>  }
>
> --
> 2.25.4
>

