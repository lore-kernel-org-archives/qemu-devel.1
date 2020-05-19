Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08E720758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIUFmWTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08E720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9dM-0008KE-5X
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9c8-0007PV-FT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:17:29 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:42656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9c7-0004A3-3d
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:17:28 -0400
Received: by mail-il1-x142.google.com with SMTP id 18so906729iln.9
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WlEsgimLfKk7gGzU3HswYYWzO7X4LBUhl2fHDMR/uR0=;
 b=aIUFmWTK0YGqNm4sR2I8Ptl6h2kylosliL7qQDULjZEf8HeW+ic633icQovUgHExpU
 pTHehBa3WJEMbqBcV4W2CzsJ+6XaUyIuKWlg3tS0C74OjRWY6DXHIwzJAGf1DPwDBD9I
 qIGztZ+3HMIKKRNQoGYRfyM9DpXaaNoIOnT0uVYlK8m1+vSNSVslZI9q7W3TR0pYafei
 1QeYGNO6HP3gLZcRKNWfsiNWw8u/sBSpKG01U50pCtzX6qa3WAXgzYue0qOI4fULQ29U
 qNuMJqv5gqf5s/diYUBvv7SvStlRFfWVwvxcm+xqAosQxBDrXV9RFjgJia0HTG16+vo3
 NVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WlEsgimLfKk7gGzU3HswYYWzO7X4LBUhl2fHDMR/uR0=;
 b=CH2Q3f5fuAMPqXE05hHyuMDmuukpzPSxYV2tLM+U4AiSAT4O2EgxEKUU3RpgxdGz/D
 MuM2BwvCCrQJyRZad+lBowqX0FYPaEs7XOw3pB01+dNJrmg3z1cegA4Nzp0Yuog89RM4
 ezk0JI3JaiWoF5RoHh3L+lGA8mMsktwVl7NJpRwnyt2mqL1P8FQYd+6dpz+8kuB2UyKp
 S8QxrbUk+O26Efe1++lSmSKFaXIjFelx731wS4WGPnCBvHT+vTxF3N3jrOW4Qh0fqC0/
 p0nmCTGN0mC2XJtct3AY3Tx9DzIVK8x0XIQ79x2C2w6E7RDXbXNFEm5YFEn+FhEq8I9G
 bOww==
X-Gm-Message-State: AOAM531a6HgTZnawhQJU10s3p4NbJdQj7LlCXiMKH0ONR2F9PVnTIhXs
 ToT4NYGQUxRb5zJKZabGl8JQpgqVEnc9VOiZk5o=
X-Google-Smtp-Source: ABdhPJyrnowwPqXPUW96Py461vIvDJZQlP7ApD5u2L0IaxJDQ026EViVE0KGb9JD3AeQB7QBFCm/Zg9JpQx7CPTKIEY=
X-Received: by 2002:a05:6e02:52e:: with SMTP id
 h14mr1034127ils.177.1589923042842; 
 Tue, 19 May 2020 14:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-22-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-22-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 14:08:30 -0700
Message-ID: <CAKmqyKOh_OS5tMOwOpMVo-ZSP3ht_vEaqCWn7ZJqvkBZ9swDmA@mail.gmail.com>
Subject: Re: [PATCH 21/55] ssi: ssi_auto_connect_slaves() never does anything,
 drop
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 8:14 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> ssi_auto_connect_slaves(parent, cs_line, bus) iterates over @parent's
> QOM children @dev of type TYPE_SSI_SLAVE.  It puts these on @bus, and
> sets cs_line[] to qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0).
>
> Suspicious: there is no protection against overrunning cs_line[].
>
> Turns out it's safe because ssi_auto_connect_slaves() never finds any
> such children.  Its called by realize methods of some (but not all)
> devices providing an SSI bus, and gets passed the device.
>
> SSI slave devices are always created with ssi_create_slave_no_init(),
> optionally via ssi_create_slave().  This adds them to their SSI bus.
> It doesn't set their QOM parent.
>
> ssi_create_slave_no_init() is always immediately followed by
> qdev_init_nofail(), with no QOM parent assigned, so
> device_set_realized() puts the device into the /machine/unattached/
> orphanage.  None become QOM children of a device providing an SSI bus.
>
> ssi_auto_connect_slaves() was added in commit b4ae3cfa57 "ssi: Add
> slave autoconnect helper".  I can't see which slaves it was supposed
> to connect back then.
>
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

This looks ok. I haven't tested it though.

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/ssi/ssi.h  |  4 ----
>  hw/ssi/aspeed_smc.c   |  1 -
>  hw/ssi/imx_spi.c      |  2 --
>  hw/ssi/mss-spi.c      |  1 -
>  hw/ssi/ssi.c          | 33 ---------------------------------
>  hw/ssi/xilinx_spi.c   |  1 -
>  hw/ssi/xilinx_spips.c |  4 ----
>  7 files changed, 46 deletions(-)
>
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 1107cb89ee..1725b13c32 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -86,10 +86,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
>
>  uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>
> -/* Automatically connect all children nodes a spi controller as slaves */
> -void ssi_auto_connect_slaves(DeviceState *parent, qemu_irq *cs_lines,
> -                             SSIBus *bus);
> -
>  /* max111x.c */
>  void max111x_set_input(DeviceState *dev, int line, uint8_t value);
>
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 2edccef2d5..4fab1f5f85 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -1356,7 +1356,6 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>
>      /* Setup cs_lines for slaves */
>      s->cs_lines = g_new0(qemu_irq, s->num_cs);
> -    ssi_auto_connect_slaves(dev, s->cs_lines, s->spi);
>
>      for (i = 0; i < s->num_cs; ++i) {
>          sysbus_init_irq(sbd, &s->cs_lines[i]);
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index 2dd9a631e1..2f09f15892 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -424,8 +424,6 @@ static void imx_spi_realize(DeviceState *dev, Error **errp)
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>
> -    ssi_auto_connect_slaves(dev, s->cs_lines, s->bus);
> -
>      for (i = 0; i < 4; ++i) {
>          sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->cs_lines[i]);
>      }
> diff --git a/hw/ssi/mss-spi.c b/hw/ssi/mss-spi.c
> index 3050fabb69..b2432c5a13 100644
> --- a/hw/ssi/mss-spi.c
> +++ b/hw/ssi/mss-spi.c
> @@ -376,7 +376,6 @@ static void mss_spi_realize(DeviceState *dev, Error **errp)
>      s->spi = ssi_create_bus(dev, "spi");
>
>      sysbus_init_irq(sbd, &s->irq);
> -    ssi_auto_connect_slaves(dev, &s->cs_line, s->spi);
>      sysbus_init_irq(sbd, &s->cs_line);
>
>      memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index c6415eb6e3..54106f5ef8 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -142,36 +142,3 @@ static void ssi_slave_register_types(void)
>  }
>
>  type_init(ssi_slave_register_types)
> -
> -typedef struct SSIAutoConnectArg {
> -    qemu_irq **cs_linep;
> -    SSIBus *bus;
> -} SSIAutoConnectArg;
> -
> -static int ssi_auto_connect_slave(Object *child, void *opaque)
> -{
> -    SSIAutoConnectArg *arg = opaque;
> -    SSISlave *dev = (SSISlave *)object_dynamic_cast(child, TYPE_SSI_SLAVE);
> -    qemu_irq cs_line;
> -
> -    if (!dev) {
> -        return 0;
> -    }
> -
> -    cs_line = qdev_get_gpio_in_named(DEVICE(dev), SSI_GPIO_CS, 0);
> -    qdev_set_parent_bus(DEVICE(dev), BUS(arg->bus));
> -    **arg->cs_linep = cs_line;
> -    (*arg->cs_linep)++;
> -    return 0;
> -}
> -
> -void ssi_auto_connect_slaves(DeviceState *parent, qemu_irq *cs_line,
> -                             SSIBus *bus)
> -{
> -    SSIAutoConnectArg arg = {
> -        .cs_linep = &cs_line,
> -        .bus = bus
> -    };
> -
> -    object_child_foreach(OBJECT(parent), ssi_auto_connect_slave, &arg);
> -}
> diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
> index eba7ccd46a..80d1488dc7 100644
> --- a/hw/ssi/xilinx_spi.c
> +++ b/hw/ssi/xilinx_spi.c
> @@ -334,7 +334,6 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
>
>      sysbus_init_irq(sbd, &s->irq);
>      s->cs_lines = g_new0(qemu_irq, s->num_cs);
> -    ssi_auto_connect_slaves(dev, s->cs_lines, s->spi);
>      for (i = 0; i < s->num_cs; ++i) {
>          sysbus_init_irq(sbd, &s->cs_lines[i]);
>      }
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index e76cf290c8..b9371dbf8d 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1270,7 +1270,6 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
>      XilinxSPIPS *s = XILINX_SPIPS(dev);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      XilinxSPIPSClass *xsc = XILINX_SPIPS_GET_CLASS(s);
> -    qemu_irq *cs;
>      int i;
>
>      DB_PRINT_L(0, "realized spips\n");
> @@ -1297,9 +1296,6 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
>
>      s->cs_lines = g_new0(qemu_irq, s->num_cs * s->num_busses);
>      s->cs_lines_state = g_new0(bool, s->num_cs * s->num_busses);
> -    for (i = 0, cs = s->cs_lines; i < s->num_busses; ++i, cs += s->num_cs) {
> -        ssi_auto_connect_slaves(DEVICE(s), cs, s->spi[i]);
> -    }
>
>      sysbus_init_irq(sbd, &s->irq);
>      for (i = 0; i < s->num_cs * s->num_busses; ++i) {
> --
> 2.21.1
>
>

