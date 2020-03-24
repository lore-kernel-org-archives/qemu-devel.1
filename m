Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C245C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE91B2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 16:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsAI7UFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE91B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGm3K-0004ab-V8
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 12:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jGm27-0002zm-Bs
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jGm26-0007Np-7Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:04:03 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:37116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jGm22-0007KD-1G; Tue, 24 Mar 2020 12:03:59 -0400
Received: by mail-vs1-xe43.google.com with SMTP id o3so11474796vsd.4;
 Tue, 24 Mar 2020 09:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0h/TwjEcebCcGsV2tARcocmmiJM/HkWArO7LTFSeZ5w=;
 b=qsAI7UFSOEIVtzsOxnqe51d+4dHFNvDj7V7TB7NJmoZdQXm48xsARVZPqT9JGwprnO
 T8Nhxojpi7iDlDMZSLOmcQfcwnZK94cX61pjrFT2QlWeUbe+WIBn+eLCe24nGzLax3Pf
 GpchIYFjjkRepNrVBJZh5bzmBuuvdUDevqbRonFVIQpb1qzPiwfn8SksjZETr9IEUm2Z
 5EfHgm2kvYGSCIua8kCqIhTLZEFcZVfUaZZzQEwuV2fucUTjGfBGQ9a11V12YVhRWgd5
 vtGjopH8klP4XSj1c4v+BeWIgQ3O/afmY6hg2y+fvNgB+/8ew4s08MRHBIMG6MTdPG0e
 +mRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0h/TwjEcebCcGsV2tARcocmmiJM/HkWArO7LTFSeZ5w=;
 b=dRhGAKxtYKAogLkUK9NUxDuuKYbskyIR+qTa0oujT6C72TVJ0bt+bwG/w4YbdImY0o
 jCzFSR1DXJ8Def/ZKp4Q0uqWiZ6LVj1+tBtRBb+5H8kvqAT+oIrMeY0MYwRYYGNkVlX7
 rkYWhNWBTGDC6HvWTziQNWQPsga25TKv0BEUCxkqfQcAGsWZasZyU6DeKNqtZlbj39g7
 ZCZBP/6TzZVoOucZqI8a/BTjdp0wDDl+y37qiPf2fe4Mxl205EOU2hMaIKf+SGCMJ8KU
 QeFCAn8LsXWulV+lt9IY1+Owo+2SiHx3wi/f7984NmMe5nvhMGVDe5B+hmlThhmcboYq
 WbRQ==
X-Gm-Message-State: ANhLgQ3iJUrpC+6PxohuTqdXmz9Gas44Kb174Hq7tLWJfnwAcjHdWIT/
 81tlQ94kUpIlnQa8ygodvWyzbiflC8tdBuFAd5E=
X-Google-Smtp-Source: ADFU+vsAV3vcUeHoFoVjd5xnJzrJYKH/cdLViWqNbWE1zJYdgO/qt9y8OLtsoW9uRJ5Aavbvk8de2rDUbeXhTS9bqsE=
X-Received: by 2002:a67:ffd0:: with SMTP id w16mr11669933vsq.151.1585065836790; 
 Tue, 24 Mar 2020 09:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200324134947.15384-1-peter.maydell@linaro.org>
 <20200324134947.15384-2-peter.maydell@linaro.org>
In-Reply-To: <20200324134947.15384-2-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Mar 2020 08:55:58 -0700
Message-ID: <CAKmqyKMUgDkXdk+gASP-W4_-dSmZOyjVdhtpAQh8ARtNn2ZXow@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/xlnx-zynqmp.c: Avoid memory leak in
 error-return path
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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
> In xlnx_zynqmp_realize() if the attempt to realize the SD
> controller object fails then the error-return path will leak
> the 'bus_name' string. Fix this by deferring the allocation
> until after the realize has succeeded.
>
> Fixes: Coverity CID 1421911
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-zynqmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 49f1c8d0de2..a13dbeeacec 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -520,7 +520,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, gic_spi[SATA_INTR]);
>
>      for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
> -        char *bus_name = g_strdup_printf("sd-bus%d", i);
> +        char *bus_name;
>          SysBusDevice *sbd = SYS_BUS_DEVICE(&s->sdhci[i]);
>          Object *sdhci = OBJECT(&s->sdhci[i]);
>
> @@ -541,6 +541,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
>
>          /* Alias controller SD bus to the SoC itself */
> +        bus_name = g_strdup_printf("sd-bus%d", i);
>          object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus",
>                                    &error_abort);
>          g_free(bus_name);
> --
> 2.20.1
>
>

