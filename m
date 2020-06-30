Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A97C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F101F20772
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F101F20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMWK-0000D8-Ui
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqMVM-00081W-FN; Tue, 30 Jun 2020 16:05:20 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:41904
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqMVJ-00051J-GQ; Tue, 30 Jun 2020 16:05:20 -0400
Received: from host86-182-221-235.range86-182.btcentralplus.com
 ([86.182.221.235] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jqMV5-0002qh-Ok; Tue, 30 Jun 2020 21:05:09 +0100
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200630090351.1247703-1-armbru@redhat.com>
 <20200630090351.1247703-16-armbru@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <bef9956c-8079-ae1d-857e-394ed1699b45@ilande.co.uk>
Date: Tue, 30 Jun 2020 21:04:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630090351.1247703-16-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.182.221.235
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 15/26] hw: Fix error API violation around
 object_property_set_link()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Alistair Francis <alistair@alistair23.me>, Eric Auger <eric.auger@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/2020 10:03, Markus Armbruster wrote:

> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
> 
> virtio_gpu_pci_base_realize(), virtio_vga_base_realize(),
> sparc32_ledma_device_realize(), sparc32_dma_realize(),
> sparc32_dma_realize() xilinx_axidma_realize(), mips_cps_realize(),
> macio_realize_ide(), xilinx_enet_realize(), and
> virtio_iommu_pci_realize() are wrong that way: they reuse the argument
> they pass to object_property_set_link() for another call.
> 
> Harmless, because object_property_set_link() can't actually fail for
> them: it fails when the property doesn't exist, is not settable, or
> its .check() method fails.  Fix by passing &error_abort instead.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/display/virtio-gpu-pci.c  |  2 +-
>  hw/display/virtio-vga.c      |  2 +-
>  hw/dma/sparc32_dma.c         |  6 +++---
>  hw/dma/xilinx_axidma.c       | 12 ++----------
>  hw/mips/cps.c                |  6 ++++--
>  hw/misc/macio/macio.c        |  3 ++-
>  hw/net/xilinx_axienet.c      | 12 ++----------
>  hw/virtio/virtio-iommu-pci.c |  2 +-
>  8 files changed, 16 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
> index b532fe8b5f..41b88b878d 100644
> --- a/hw/display/virtio-gpu-pci.c
> +++ b/hw/display/virtio-gpu-pci.c
> @@ -44,7 +44,7 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      for (i = 0; i < g->conf.max_outputs; i++) {
>          object_property_set_link(OBJECT(g->scanout[i].con),
>                                   OBJECT(vpci_dev),
> -                                 "device", errp);
> +                                 "device", &error_abort);
>      }
>  }
>  
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index 68a062ece6..67f409e106 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -154,7 +154,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      for (i = 0; i < g->conf.max_outputs; i++) {
>          object_property_set_link(OBJECT(g->scanout[i].con),
>                                   OBJECT(vpci_dev),
> -                                 "device", errp);
> +                                 "device", &error_abort);
>      }
>  }
>  
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index f02aca6f40..2d7dbbb92d 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -346,7 +346,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
>      d = qdev_new(TYPE_LANCE);
>      object_property_add_child(OBJECT(dev), "lance", OBJECT(d));
>      qdev_set_nic_properties(d, nd);
> -    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
> +    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", &error_abort);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(d), &error_fatal);
>  }
>  
> @@ -379,7 +379,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
>      }
>  
>      espdma = qdev_new(TYPE_SPARC32_ESPDMA_DEVICE);
> -    object_property_set_link(OBJECT(espdma), iommu, "iommu", errp);
> +    object_property_set_link(OBJECT(espdma), iommu, "iommu", &error_abort);
>      object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(espdma), &error_fatal);
>  
> @@ -394,7 +394,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
>                                  sysbus_mmio_get_region(sbd, 0));
>  
>      ledma = qdev_new(TYPE_SPARC32_LEDMA_DEVICE);
> -    object_property_set_link(OBJECT(ledma), iommu, "iommu", errp);
> +    object_property_set_link(OBJECT(ledma), iommu, "iommu", &error_abort);
>      object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(ledma), &error_fatal);
>  
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 6a9df2c4db..a069637bf2 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -537,7 +537,6 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>      XilinxAXIDMAStreamSlave *ds = XILINX_AXI_DMA_DATA_STREAM(&s->rx_data_dev);
>      XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
>                                                              &s->rx_control_dev);
> -    Error *local_err = NULL;
>      int i;
>  
>      object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
> @@ -548,11 +547,8 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>                               (Object **)&cs->dma,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG);
> -    object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &local_err);
> -    object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &local_err);
> -    if (local_err) {
> -        goto xilinx_axidma_realize_fail;
> -    }
> +    object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &error_abort);
> +    object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &error_abort);
>  
>      for (i = 0; i < 2; i++) {
>          struct Stream *st = &s->streams[i];
> @@ -567,10 +563,6 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>  
>      address_space_init(&s->as,
>                         s->dma_mr ? s->dma_mr : get_system_memory(), "dma");
> -    return;
> -
> -xilinx_axidma_realize_fail:
> -    error_propagate(errp, local_err);
>  }
>  
>  static void xilinx_axidma_init(Object *obj)
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index cdfab19826..5382bc86f7 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -150,8 +150,10 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>      object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp", &err);
>      object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev", &err);
>      object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base", &err);
> -    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic", &err);
> -    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc", &err);
> +    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic",
> +                             &error_abort);
> +    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc",
> +                             &error_abort);
>      sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err);
>      if (err != NULL) {
>          error_propagate(errp, err);
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index 8ba7af073c..3251c79f46 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -136,7 +136,8 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
>      sysbus_connect_irq(sysbus_dev, 0, irq0);
>      sysbus_connect_irq(sysbus_dev, 1, irq1);
>      qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
> -    object_property_set_link(OBJECT(ide), OBJECT(&s->dbdma), "dbdma", errp);
> +    object_property_set_link(OBJECT(ide), OBJECT(&s->dbdma), "dbdma",
> +                             &error_abort);
>      macio_ide_register_dma(ide);
>  
>      qdev_realize(DEVICE(ide), BUS(&s->macio_bus), errp);
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index c2f40b8ea9..679a359f9a 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -980,7 +980,6 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>      XilinxAXIEnetStreamSlave *ds = XILINX_AXI_ENET_DATA_STREAM(&s->rx_data_dev);
>      XilinxAXIEnetStreamSlave *cs = XILINX_AXI_ENET_CONTROL_STREAM(
>                                                              &s->rx_control_dev);
> -    Error *local_err = NULL;
>  
>      object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
>                               (Object **) &ds->enet,
> @@ -990,11 +989,8 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>                               (Object **) &cs->enet,
>                               object_property_allow_set_link,
>                               OBJ_PROP_LINK_STRONG);
> -    object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &local_err);
> -    object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &local_err);
> -    if (local_err) {
> -        goto xilinx_enet_realize_fail;
> -    }
> +    object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &error_abort);
> +    object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &error_abort);
>  
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
>      s->nic = qemu_new_nic(&net_xilinx_enet_info, &s->conf,
> @@ -1008,10 +1004,6 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>  
>      s->rxmem = g_malloc(s->c_rxmem);
>      s->txmem = g_malloc(s->c_txmem);
> -    return;
> -
> -xilinx_enet_realize_fail:
> -    error_propagate(errp, local_err);
>  }
>  
>  static void xilinx_enet_init(Object *obj)
> diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
> index 632533abaf..bd61d6e2f8 100644
> --- a/hw/virtio/virtio-iommu-pci.c
> +++ b/hw/virtio/virtio-iommu-pci.c
> @@ -56,7 +56,7 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      }
>      object_property_set_link(OBJECT(dev),
>                               OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
> -                             "primary-bus", errp);
> +                             "primary-bus", &error_abort);
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>  }

The sparc32 and macio parts look good to me:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

