Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB529C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E5C20775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhhzG9Jc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E5C20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGm4J-0005h8-Tv
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jGm2k-0003vc-AF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jGm2j-0007ub-0h
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:04:42 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:39928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jGm2g-0007s8-CG; Tue, 24 Mar 2020 12:04:38 -0400
Received: by mail-vs1-xe42.google.com with SMTP id j128so4879366vsd.6;
 Tue, 24 Mar 2020 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vbhvlv+VbNXkIg6kT2d/mzvdrSvgE+JmNkuAgdwxn30=;
 b=jhhzG9JcJEPxMLGs/HS+1eXfMAhovoP7GyYd8K4rkAp4mbkIRLJoHHitf/17cZv1S5
 /M5ieUn4u/gCFZIkhwQ7UZAT1yX5cWAWoPJlNxvlDrUEz9KRyA4RHAGeSSARcfxhBQHX
 LWf3HT6l6gLhtEbrToSgr6jIAGBF5QVUacRs+tTbhHDPAvWaUn3sH1Rr7FyANXxFwmid
 ErjvlwiifjpsBf0iBlNRHCud4XPRah+D5aP6hhrK7aH/CfMyGSQPKqfTEMwubgMpHT9b
 Tc85MypPqD+gAbY6GcWdya7vqI8I0zkOT0TChiWMsv2YR0XQExUfNzbt4jS+xmL5LxnZ
 eWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vbhvlv+VbNXkIg6kT2d/mzvdrSvgE+JmNkuAgdwxn30=;
 b=gh4RA9SPloA9lp6NgkX3mcGR/0O6ek/lr1LperWOgAqlRTT9u7P2wT7OM/4v3O6zOz
 f8G6RMevWJxrLyK7HZGYZHp6caKqd0aPhk/HxEg19UDyHW4bIPibfuiRuIiSSTdLhyH6
 QU6B8WoPBJKkYSrtlkdUoqYAGBQnYKmYr2zZblcfi/DPGSBKsqNHvPQ2x4HjanWj+Ij3
 AiYQja59Sf/wClZm0ajNiy7OJwkdQf2TrE7/g15GUcWghmnEssF1nzLARYyXuTtlcICt
 0rqT1QO4e6w/O+wVXJjXMtREeIg8Vw6oqC+/W5GcxOlBT02tleihPhNe7065pG7hwAv5
 FarQ==
X-Gm-Message-State: ANhLgQ1lIzrL30LY3gQvaPfpB6eaTX5nfxoeHmv66px3R+H6xgJLqVEB
 PEqVVTSyi3tGODhCxQWOVwMaOl+hleEiDi1pmqs=
X-Google-Smtp-Source: ADFU+vtRDvTkbUp0TZHL1Cp5HKe9ErmO+O5OsaoZd/GpUWr0fMynh8JXpK7jZbM/Img7OhlC6pkykqZ0+YJrqhPt/R4=
X-Received: by 2002:a67:26c2:: with SMTP id
 m185mr20502695vsm.180.1585065877605; 
 Tue, 24 Mar 2020 09:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200324134947.15384-1-peter.maydell@linaro.org>
 <20200324134947.15384-3-peter.maydell@linaro.org>
In-Reply-To: <20200324134947.15384-3-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Mar 2020 08:56:39 -0700
Message-ID: <CAKmqyKNpw=oWsCjFSocsahRJQDO3Z8F7dnE-JUrhNk_tfHOCtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/xlnx-zynqmp.c: Add missing error-propagation
 code
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e42
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 6:50 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In some places in xlnx_zynqmp_realize() we were putting an
> error into our local Error*, but forgetting to check for
> failure and pass it back to the caller. Add the missing code.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Spotted while I was writing the previous patch.
> ---
>  hw/arm/xlnx-zynqmp.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index a13dbeeacec..b84d153d56a 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -530,8 +530,20 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>           * - eMMC Specification Version 4.51
>           */
>          object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_uint(sdhci, UHS_I, "uhs", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(sdhci, true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
> @@ -551,6 +563,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          gchar *bus_name;
>
>          object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0, spi_addr[i]);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->spi[i]), 0,
> @@ -565,6 +581,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>      }
>
>      object_property_set_bool(OBJECT(&s->qspi), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 1, LQSPI_ADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->qspi), 0, gic_spi[QSPI_IRQ]);
> @@ -619,6 +639,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
>          object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
>          object_property_set_bool(OBJECT(&s->gdma[i]), true, "realized", &err);
>          if (err) {
>              error_propagate(errp, err);
> --
> 2.20.1
>
>

