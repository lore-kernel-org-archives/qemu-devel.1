Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E197C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8154204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iah/YAD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8154204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7k7C-0002hL-8X
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 14:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k7k6D-0001eC-0i; Mon, 17 Aug 2020 14:43:13 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k7k68-0005eV-L0; Mon, 17 Aug 2020 14:43:12 -0400
Received: by mail-io1-xd42.google.com with SMTP id g13so4382396ioo.9;
 Mon, 17 Aug 2020 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GMhR1Gx1rLoumR7zMslWjuPCl1uDGyxb7bYRZ5+7rjs=;
 b=iah/YAD4KMNUBvl0BFrFB6VDTA8lWzaOW3KUZPOHS/E0OWrrwJMX9b5kiahNOrmQ9R
 pFO4yViHCAMKcXKcuBqxo0Kll+6SSdSJlZC8zBnnvfszkUrWt979NzPuPb2mV00lsAZP
 0Mz51uCDWfTFDE0UjgVFCzwb6DT3fotLnN6z+JSbdLXfY/6GUVr70LiqG1jOV334lSTr
 08ICeq9yf2XQrm7KEps04A7N79LowWx+Fg25rX5nfHl49jcwOJ9t2c87n6TX55WszGpl
 eKbCIYVX5bmZtBhRH64pMkV7xDu4PQztNuQiXKaotu4/yjCIwQwCvv+qHHo2e1QFnGFf
 otWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GMhR1Gx1rLoumR7zMslWjuPCl1uDGyxb7bYRZ5+7rjs=;
 b=IitHR2RXM4JhnlB04hFMuAZLUX8u9ZITvDDyXe3mW+2ahLluGPi0BmDJkkYIyGXTfV
 X6tZVXrrfZLszB3Z9RfNr/D9yOd4ez9qMBoMEC75ujKpo6J13mm4C0RIsBTQva6/Bsx0
 y4eZkWkxE32OhKrVdCNxNRagolGkrJ0jE00jAzCMcJysFE5wNSA3eU4nVaLVV+OflZkU
 gZZsewghB3pGfE3DdX/vNvW5hGi4OcSS2hdtSRrv6s03SK+Pb1yg+pxyi6jy8IES5kVj
 UEvwptln/KFx2DAm30YgF0T7yXycRHYgTBAkaWS1ZdUI/j1OwWeYLnh0JZsBqbgH9kJ7
 C+yw==
X-Gm-Message-State: AOAM532OKwjTMWB5DYY5CPmEYArnBXb9XCNqSgL+m0LLFGCZECmDNfT9
 23Jv0d0szsIpIuMww4SIOvAw84YzKaA1k3An7n0=
X-Google-Smtp-Source: ABdhPJx97ltfOWm6k6irtlTLNe2UyzPw5XEma9q9ITCg7L7lDP03yWiKJD91/1GcmiJzUkENqbQ0DUmmEJzMMHrCoiQ=
X-Received: by 2002:a6b:3bd4:: with SMTP id
 i203mr13370799ioa.205.1597689787458; 
 Mon, 17 Aug 2020 11:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200814122907.27732-1-f4bug@amsat.org>
In-Reply-To: <20200814122907.27732-1-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 17 Aug 2020 20:42:56 +0200
Message-ID: <CAPan3WpabibQhV2Mm20JTXsHnGn-4SaM69_RQ6tmX_QDwu_g3g@mail.gmail.com>
Subject: Re: [PATCH] hw/net/allwinner-sun8i-emac: Use AddressSpace for DMA
 transfers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000003e29ad05ad1724e9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003e29ad05ad1724e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Same as the one for the SD device: I tested it with the avocado tests and
the official image OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
and networking is working good (ran some apt-get commands etc).

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek

On Fri, Aug 14, 2020 at 2:29 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Allow the device to execute the DMA transfers in a different
> AddressSpace.
>
> The H3 SoC keeps using the system_memory address space,
> but via the proper dma_memory_access() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Tested with:
>   AVOCADO_ALLOW_LARGE_STORAGE=3D1 avocado run -t machine:orangepi-pc
> tests/acceptance/
> ---
>  include/hw/net/allwinner-sun8i-emac.h |  6 ++++
>  hw/arm/allwinner-h3.c                 |  2 ++
>  hw/net/allwinner-sun8i-emac.c         | 46 +++++++++++++++++----------
>  3 files changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/include/hw/net/allwinner-sun8i-emac.h
> b/include/hw/net/allwinner-sun8i-emac.h
> index eda034e96b..dd1d7b96cd 100644
> --- a/include/hw/net/allwinner-sun8i-emac.h
> +++ b/include/hw/net/allwinner-sun8i-emac.h
> @@ -49,6 +49,12 @@ typedef struct AwSun8iEmacState {
>      /** Interrupt output signal to notify CPU */
>      qemu_irq     irq;
>
> +    /** Memory region where DMA transfers are done */
> +    MemoryRegion *dma_mr;
> +
> +    /** Address space used internally for DMA transfers */
> +    AddressSpace dma_as;
> +
>      /** Generic Network Interface Controller (NIC) for networking API */
>      NICState     *nic;
>
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index ff92ded82c..21a5d759d1 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -363,6 +363,8 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>          qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
>          qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
>      }
> +    object_property_set_link(OBJECT(&s->emac), "dma-memory",
> +                             OBJECT(get_system_memory()), &error_fatal);
>      sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_EMAC]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
> diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.=
c
> index 28637ff4c1..38d328587e 100644
> --- a/hw/net/allwinner-sun8i-emac.c
> +++ b/hw/net/allwinner-sun8i-emac.c
> @@ -19,6 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "net/net.h"
> @@ -29,6 +30,7 @@
>  #include "net/checksum.h"
>  #include "qemu/module.h"
>  #include "exec/cpu-common.h"
> +#include "sysemu/dma.h"
>  #include "hw/net/allwinner-sun8i-emac.h"
>
>  /* EMAC register offsets */
> @@ -337,12 +339,13 @@ static void
> allwinner_sun8i_emac_update_irq(AwSun8iEmacState *s)
>      qemu_set_irq(s->irq, (s->int_sta & s->int_en) !=3D 0);
>  }
>
> -static uint32_t allwinner_sun8i_emac_next_desc(FrameDescriptor *desc,
> +static uint32_t allwinner_sun8i_emac_next_desc(AwSun8iEmacState *s,
> +                                               FrameDescriptor *desc,
>                                                 size_t min_size)
>  {
>      uint32_t paddr =3D desc->next;
>
> -    cpu_physical_memory_read(paddr, desc, sizeof(*desc));
> +    dma_memory_read(&s->dma_as, paddr, desc, sizeof(*desc));
>
>      if ((desc->status & DESC_STATUS_CTL) &&
>          (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size) {
> @@ -352,7 +355,8 @@ static uint32_t
> allwinner_sun8i_emac_next_desc(FrameDescriptor *desc,
>      }
>  }
>
> -static uint32_t allwinner_sun8i_emac_get_desc(FrameDescriptor *desc,
> +static uint32_t allwinner_sun8i_emac_get_desc(AwSun8iEmacState *s,
> +                                              FrameDescriptor *desc,
>                                                uint32_t start_addr,
>                                                size_t min_size)
>  {
> @@ -360,7 +364,7 @@ static uint32_t
> allwinner_sun8i_emac_get_desc(FrameDescriptor *desc,
>
>      /* Note that the list is a cycle. Last entry points back to the head=
.
> */
>      while (desc_addr !=3D 0) {
> -        cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
> +        dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc));
>
>          if ((desc->status & DESC_STATUS_CTL) &&
>              (desc->status2 & DESC_STATUS2_BUF_SIZE_MASK) >=3D min_size) =
{
> @@ -379,20 +383,21 @@ static uint32_t
> allwinner_sun8i_emac_rx_desc(AwSun8iEmacState *s,
>                                               FrameDescriptor *desc,
>                                               size_t min_size)
>  {
> -    return allwinner_sun8i_emac_get_desc(desc, s->rx_desc_curr, min_size=
);
> +    return allwinner_sun8i_emac_get_desc(s, desc, s->rx_desc_curr,
> min_size);
>  }
>
>  static uint32_t allwinner_sun8i_emac_tx_desc(AwSun8iEmacState *s,
>                                               FrameDescriptor *desc,
>                                               size_t min_size)
>  {
> -    return allwinner_sun8i_emac_get_desc(desc, s->tx_desc_head, min_size=
);
> +    return allwinner_sun8i_emac_get_desc(s, desc, s->tx_desc_head,
> min_size);
>  }
>
> -static void allwinner_sun8i_emac_flush_desc(FrameDescriptor *desc,
> +static void allwinner_sun8i_emac_flush_desc(AwSun8iEmacState *s,
> +                                            FrameDescriptor *desc,
>                                              uint32_t phys_addr)
>  {
> -    cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));
> +    dma_memory_write(&s->dma_as, phys_addr, desc, sizeof(*desc));
>  }
>
>  static bool allwinner_sun8i_emac_can_receive(NetClientState *nc)
> @@ -450,8 +455,8 @@ static ssize_t
> allwinner_sun8i_emac_receive(NetClientState *nc,
>                              << RX_DESC_STATUS_FRM_LEN_SHIFT;
>          }
>
> -        cpu_physical_memory_write(desc.addr, buf, desc_bytes);
> -        allwinner_sun8i_emac_flush_desc(&desc, s->rx_desc_curr);
> +        dma_memory_write(&s->dma_as, desc.addr, buf, desc_bytes);
> +        allwinner_sun8i_emac_flush_desc(s, &desc, s->rx_desc_curr);
>          trace_allwinner_sun8i_emac_receive(s->rx_desc_curr, desc.addr,
>                                             desc_bytes);
>
> @@ -465,7 +470,7 @@ static ssize_t
> allwinner_sun8i_emac_receive(NetClientState *nc,
>          bytes_left -=3D desc_bytes;
>
>          /* Move to the next descriptor */
> -        s->rx_desc_curr =3D allwinner_sun8i_emac_next_desc(&desc, 64);
> +        s->rx_desc_curr =3D allwinner_sun8i_emac_next_desc(s, &desc, 64)=
;
>          if (!s->rx_desc_curr) {
>              /* Not enough buffer space available */
>              s->int_sta |=3D INT_STA_RX_BUF_UA;
> @@ -501,10 +506,10 @@ static void
> allwinner_sun8i_emac_transmit(AwSun8iEmacState *s)
>              desc.status |=3D TX_DESC_STATUS_LENGTH_ERR;
>              break;
>          }
> -        cpu_physical_memory_read(desc.addr, packet_buf + packet_bytes,
> bytes);
> +        dma_memory_read(&s->dma_as, desc.addr, packet_buf + packet_bytes=
,
> bytes);
>          packet_bytes +=3D bytes;
>          desc.status &=3D ~DESC_STATUS_CTL;
> -        allwinner_sun8i_emac_flush_desc(&desc, s->tx_desc_curr);
> +        allwinner_sun8i_emac_flush_desc(s, &desc, s->tx_desc_curr);
>
>          /* After the last descriptor, send the packet */
>          if (desc.status2 & TX_DESC_STATUS2_LAST_DESC) {
> @@ -519,7 +524,7 @@ static void
> allwinner_sun8i_emac_transmit(AwSun8iEmacState *s)
>              packet_bytes =3D 0;
>              transmitted++;
>          }
> -        s->tx_desc_curr =3D allwinner_sun8i_emac_next_desc(&desc, 0);
> +        s->tx_desc_curr =3D allwinner_sun8i_emac_next_desc(s, &desc, 0);
>      }
>
>      /* Raise transmit completed interrupt */
> @@ -623,7 +628,7 @@ static uint64_t allwinner_sun8i_emac_read(void
> *opaque, hwaddr offset,
>          break;
>      case REG_TX_CUR_BUF:        /* Transmit Current Buffer */
>          if (s->tx_desc_curr !=3D 0) {
> -            cpu_physical_memory_read(s->tx_desc_curr, &desc,
> sizeof(desc));
> +            dma_memory_read(&s->dma_as, s->tx_desc_curr, &desc,
> sizeof(desc));
>              value =3D desc.addr;
>          } else {
>              value =3D 0;
> @@ -636,7 +641,7 @@ static uint64_t allwinner_sun8i_emac_read(void
> *opaque, hwaddr offset,
>          break;
>      case REG_RX_CUR_BUF:        /* Receive Current Buffer */
>          if (s->rx_desc_curr !=3D 0) {
> -            cpu_physical_memory_read(s->rx_desc_curr, &desc,
> sizeof(desc));
> +            dma_memory_read(&s->dma_as, s->rx_desc_curr, &desc,
> sizeof(desc));
>              value =3D desc.addr;
>          } else {
>              value =3D 0;
> @@ -790,6 +795,13 @@ static void allwinner_sun8i_emac_realize(DeviceState
> *dev, Error **errp)
>  {
>      AwSun8iEmacState *s =3D AW_SUN8I_EMAC(dev);
>
> +    if (!s->dma_mr) {
> +        error_setg(errp, TYPE_AW_SUN8I_EMAC " 'dma-memory' link not set"=
);
> +        return;
> +    }
> +
> +    address_space_init(&s->dma_as, s->dma_mr, "emac-dma");
> +
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
>      s->nic =3D qemu_new_nic(&net_allwinner_sun8i_emac_info, &s->conf,
>                             object_get_typename(OBJECT(dev)), dev->id, s)=
;
> @@ -799,6 +811,8 @@ static void allwinner_sun8i_emac_realize(DeviceState
> *dev, Error **errp)
>  static Property allwinner_sun8i_emac_properties[] =3D {
>      DEFINE_NIC_PROPERTIES(AwSun8iEmacState, conf),
>      DEFINE_PROP_UINT8("phy-addr", AwSun8iEmacState, mii_phy_addr, 0),
> +    DEFINE_PROP_LINK("dma-memory", AwSun8iEmacState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.21.3
>
>

--=20
Niek Linnenbank

--0000000000003e29ad05ad1724e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>Same as the one=
 for the SD device: I tested it with the avocado tests and the official ima=
ge OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img</div><div>and netw=
orking is working good (ran some apt-get commands etc).</div><div><br></div=
><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gma=
il.com">nieklinnenbank@gmail.com</a>&gt;</div><div>Tested-by: Niek Linnenba=
nk &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com=
</a>&gt;</div><div><br></div><div>Regards,</div><div>Niek<br></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, =
Aug 14, 2020 at 2:29 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f=
4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Allow the device to execute the DMA transf=
ers in a different<br>
AddressSpace.<br>
<br>
The H3 SoC keeps using the system_memory address space,<br>
but via the proper dma_memory_access() API.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
Tested with:<br>
=C2=A0 AVOCADO_ALLOW_LARGE_STORAGE=3D1 avocado run -t machine:orangepi-pc t=
ests/acceptance/<br>
---<br>
=C2=A0include/hw/net/allwinner-sun8i-emac.h |=C2=A0 6 ++++<br>
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0hw/net/allwinner-sun8i-emac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 46 +=
++++++++++++++++----------<br>
=C2=A03 files changed, 38 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/include/hw/net/allwinner-sun8i-emac.h b/include/hw/net/allwinn=
er-sun8i-emac.h<br>
index eda034e96b..dd1d7b96cd 100644<br>
--- a/include/hw/net/allwinner-sun8i-emac.h<br>
+++ b/include/hw/net/allwinner-sun8i-emac.h<br>
@@ -49,6 +49,12 @@ typedef struct AwSun8iEmacState {<br>
=C2=A0 =C2=A0 =C2=A0/** Interrupt output signal to notify CPU */<br>
=C2=A0 =C2=A0 =C2=A0qemu_irq=C2=A0 =C2=A0 =C2=A0irq;<br>
<br>
+=C2=A0 =C2=A0 /** Memory region where DMA transfers are done */<br>
+=C2=A0 =C2=A0 MemoryRegion *dma_mr;<br>
+<br>
+=C2=A0 =C2=A0 /** Address space used internally for DMA transfers */<br>
+=C2=A0 =C2=A0 AddressSpace dma_as;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/** Generic Network Interface Controller (NIC) for netw=
orking API */<br>
=C2=A0 =C2=A0 =C2=A0NICState=C2=A0 =C2=A0 =C2=A0*nic;<br>
<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index ff92ded82c..21a5d759d1 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -363,6 +363,8 @@ static void allwinner_h3_realize(DeviceState *dev, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_check_nic_model(&amp;nd_table[0], TY=
PE_AW_SUN8I_EMAC);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_nic_properties(DEVICE(&amp;s-&gt=
;emac), &amp;nd_table[0]);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 object_property_set_link(OBJECT(&amp;s-&gt;emac), &quot;dma-=
memory&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(get_system_memory()), &amp;error_fata=
l);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;emac), &amp;er=
ror_fatal);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0, s-&=
gt;memmap[AW_H3_EMAC]);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0,<=
br>
diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c<=
br>
index 28637ff4c1..38d328587e 100644<br>
--- a/hw/net/allwinner-sun8i-emac.c<br>
+++ b/hw/net/allwinner-sun8i-emac.c<br>
@@ -19,6 +19,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;net/net.h&quot;<br>
@@ -29,6 +30,7 @@<br>
=C2=A0#include &quot;net/checksum.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;exec/cpu-common.h&quot;<br>
+#include &quot;sysemu/dma.h&quot;<br>
=C2=A0#include &quot;hw/net/allwinner-sun8i-emac.h&quot;<br>
<br>
=C2=A0/* EMAC register offsets */<br>
@@ -337,12 +339,13 @@ static void allwinner_sun8i_emac_update_irq(AwSun8iEm=
acState *s)<br>
=C2=A0 =C2=A0 =C2=A0qemu_set_irq(s-&gt;irq, (s-&gt;int_sta &amp; s-&gt;int_=
en) !=3D 0);<br>
=C2=A0}<br>
<br>
-static uint32_t allwinner_sun8i_emac_next_desc(FrameDescriptor *desc,<br>
+static uint32_t allwinner_sun8i_emac_next_desc(AwSun8iEmacState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0FrameDescriptor *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 size_t min_size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t paddr =3D desc-&gt;next;<br>
<br>
-=C2=A0 =C2=A0 cpu_physical_memory_read(paddr, desc, sizeof(*desc));<br>
+=C2=A0 =C2=A0 dma_memory_read(&amp;s-&gt;dma_as, paddr, desc, sizeof(*desc=
));<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ((desc-&gt;status &amp; DESC_STATUS_CTL) &amp;&amp;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(desc-&gt;status2 &amp; DESC_STATUS2_BUF_=
SIZE_MASK) &gt;=3D min_size) {<br>
@@ -352,7 +355,8 @@ static uint32_t allwinner_sun8i_emac_next_desc(FrameDes=
criptor *desc,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static uint32_t allwinner_sun8i_emac_get_desc(FrameDescriptor *desc,<br>
+static uint32_t allwinner_sun8i_emac_get_desc(AwSun8iEmacState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 FrameDescriptor *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t start_addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0size_t min_size)<br>
=C2=A0{<br>
@@ -360,7 +364,7 @@ static uint32_t allwinner_sun8i_emac_get_desc(FrameDesc=
riptor *desc,<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Note that the list is a cycle. Last entry points bac=
k to the head. */<br>
=C2=A0 =C2=A0 =C2=A0while (desc_addr !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(desc_addr, desc, size=
of(*desc));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_memory_read(&amp;s-&gt;dma_as, desc_addr, =
desc, sizeof(*desc));<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((desc-&gt;status &amp; DESC_STATUS_CT=
L) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(desc-&gt;status2 &amp; DES=
C_STATUS2_BUF_SIZE_MASK) &gt;=3D min_size) {<br>
@@ -379,20 +383,21 @@ static uint32_t allwinner_sun8i_emac_rx_desc(AwSun8iE=
macState *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 FrameDescriptor *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 size_t min_size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return allwinner_sun8i_emac_get_desc(desc, s-&gt;rx_desc_cur=
r, min_size);<br>
+=C2=A0 =C2=A0 return allwinner_sun8i_emac_get_desc(s, desc, s-&gt;rx_desc_=
curr, min_size);<br>
=C2=A0}<br>
<br>
=C2=A0static uint32_t allwinner_sun8i_emac_tx_desc(AwSun8iEmacState *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 FrameDescriptor *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 size_t min_size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return allwinner_sun8i_emac_get_desc(desc, s-&gt;tx_desc_hea=
d, min_size);<br>
+=C2=A0 =C2=A0 return allwinner_sun8i_emac_get_desc(s, desc, s-&gt;tx_desc_=
head, min_size);<br>
=C2=A0}<br>
<br>
-static void allwinner_sun8i_emac_flush_desc(FrameDescriptor *desc,<br>
+static void allwinner_sun8i_emac_flush_desc(AwSun8iEmacState *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 FrameDescriptor *desc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0uint32_t phys_addr)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 cpu_physical_memory_write(phys_addr, desc, sizeof(*desc));<b=
r>
+=C2=A0 =C2=A0 dma_memory_write(&amp;s-&gt;dma_as, phys_addr, desc, sizeof(=
*desc));<br>
=C2=A0}<br>
<br>
=C2=A0static bool allwinner_sun8i_emac_can_receive(NetClientState *nc)<br>
@@ -450,8 +455,8 @@ static ssize_t allwinner_sun8i_emac_receive(NetClientSt=
ate *nc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&lt; RX_DESC_STATUS_FRM_LEN_SHIFT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write(desc.addr, buf, desc=
_bytes);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_sun8i_emac_flush_desc(&amp;desc, s-&=
gt;rx_desc_curr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_memory_write(&amp;s-&gt;dma_as, desc.addr,=
 buf, desc_bytes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_sun8i_emac_flush_desc(s, &amp;desc, =
s-&gt;rx_desc_curr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_allwinner_sun8i_emac_receive(s-&gt;=
rx_desc_curr, desc.addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 desc_bytes);<br>
<br>
@@ -465,7 +470,7 @@ static ssize_t allwinner_sun8i_emac_receive(NetClientSt=
ate *nc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes_left -=3D desc_bytes;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Move to the next descriptor */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_desc_curr =3D allwinner_sun8i_emac_ne=
xt_desc(&amp;desc, 64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_desc_curr =3D allwinner_sun8i_emac_ne=
xt_desc(s, &amp;desc, 64);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!s-&gt;rx_desc_curr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Not enough buffer space =
available */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;int_sta |=3D INT_STA_=
RX_BUF_UA;<br>
@@ -501,10 +506,10 @@ static void allwinner_sun8i_emac_transmit(AwSun8iEmac=
State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc.status |=3D TX_DESC_ST=
ATUS_LENGTH_ERR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(desc.addr, packet_buf=
 + packet_bytes, bytes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_memory_read(&amp;s-&gt;dma_as, desc.addr, =
packet_buf + packet_bytes, bytes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet_bytes +=3D bytes;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc.status &amp;=3D ~DESC_STATUS_CTL;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_sun8i_emac_flush_desc(&amp;desc, s-&=
gt;tx_desc_curr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_sun8i_emac_flush_desc(s, &amp;desc, =
s-&gt;tx_desc_curr);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* After the last descriptor, send the pa=
cket */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (desc.status2 &amp; TX_DESC_STATUS2_LA=
ST_DESC) {<br>
@@ -519,7 +524,7 @@ static void allwinner_sun8i_emac_transmit(AwSun8iEmacSt=
ate *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packet_bytes =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0transmitted++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_desc_curr =3D allwinner_sun8i_emac_ne=
xt_desc(&amp;desc, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_desc_curr =3D allwinner_sun8i_emac_ne=
xt_desc(s, &amp;desc, 0);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Raise transmit completed interrupt */<br>
@@ -623,7 +628,7 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque,=
 hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_TX_CUR_BUF:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Tran=
smit Current Buffer */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;tx_desc_curr !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(s-&gt;t=
x_desc_curr, &amp;desc, sizeof(desc));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_memory_read(&amp;s-&gt;dma_a=
s, s-&gt;tx_desc_curr, &amp;desc, sizeof(desc));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D desc.addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D 0;<br>
@@ -636,7 +641,7 @@ static uint64_t allwinner_sun8i_emac_read(void *opaque,=
 hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case REG_RX_CUR_BUF:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Rece=
ive Current Buffer */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;rx_desc_curr !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read(s-&gt;r=
x_desc_curr, &amp;desc, sizeof(desc));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_memory_read(&amp;s-&gt;dma_a=
s, s-&gt;rx_desc_curr, &amp;desc, sizeof(desc));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D desc.addr;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D 0;<br>
@@ -790,6 +795,13 @@ static void allwinner_sun8i_emac_realize(DeviceState *=
dev, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AwSun8iEmacState *s =3D AW_SUN8I_EMAC(dev);<br>
<br>
+=C2=A0 =C2=A0 if (!s-&gt;dma_mr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, TYPE_AW_SUN8I_EMAC &quot; &#3=
9;dma-memory&#39; link not set&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 address_space_init(&amp;s-&gt;dma_as, s-&gt;dma_mr, &quot;em=
ac-dma&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qemu_macaddr_default_if_unset(&amp;s-&gt;conf.macaddr);=
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;nic =3D qemu_new_nic(&amp;net_allwinner_sun8i_ema=
c_info, &amp;s-&gt;conf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 object_get_typename(OBJECT(dev)), dev-&gt;id, s);<=
br>
@@ -799,6 +811,8 @@ static void allwinner_sun8i_emac_realize(DeviceState *d=
ev, Error **errp)<br>
=C2=A0static Property allwinner_sun8i_emac_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_NIC_PROPERTIES(AwSun8iEmacState, conf),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT8(&quot;phy-addr&quot;, AwSun8iEmacStat=
e, mii_phy_addr, 0),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;dma-memory&quot;, AwSun8iEmacState, d=
ma_mr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TYPE_MEMORY_REGION, MemoryRegion *),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
<br>
-- <br>
2.21.3<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--0000000000003e29ad05ad1724e9--

