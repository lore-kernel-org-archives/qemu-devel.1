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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF5EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2839204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyZB8bvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2839204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7k4E-0000qE-AJ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 14:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k7k3N-0008TQ-Ig; Mon, 17 Aug 2020 14:40:17 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k7k3L-0005Fz-B0; Mon, 17 Aug 2020 14:40:17 -0400
Received: by mail-io1-xd42.google.com with SMTP id a5so18547561ioa.13;
 Mon, 17 Aug 2020 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B/hG8QxsiThGggJe9eFxDqjXVsYoZFaQC1mz/Og4tOk=;
 b=FyZB8bvos628DtwjjnEXkOpeBv0kELtjNe6FJC2C5rhEbPM2/0M7ybjId605Skm5rN
 7AzcysqI/sNFAWJ91ZqbBb5eX7AmHbBR6F7HuI3SiSSceg4Dn6wp3kDvOcvR4SA0vcrl
 aRnUo27+SpKzAjXkmXqDQnkhKriNn5Ct/VTfaVnbTKoC0EF/z83lPP83QNQPMNEX4vEX
 yA+s4xVnBuCGMaM7s2AahNXaVKtUKxMNx0AjEn5gsD4NuywYJmpcaIzF1RFeE6V5fOj1
 m0gA4r5brIhrZfj6YTQCqugEk2rbUGuN1wNtc6ejdGKgZBvM38M0XqutM911q2tUKZsp
 n0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B/hG8QxsiThGggJe9eFxDqjXVsYoZFaQC1mz/Og4tOk=;
 b=nHGemlnvrZKW6UjQvjjwzBiNzAd/YERwpbvCi8OdKqc7lSM5egP/F8Uv2rfy4BizqU
 rzsgqqwTXiQfr3gmGDHIphBu/td9o9+taY1pbb4I4ConcKAhMU2cImH3qc8jMf9GzFgs
 dNBNl8Xs33+HMD++dA1hSTsambs7DFnyGQA+x+XnP3XlhpvZxKynpGyg9TS9D2RFehnE
 Uca4tYlMx+oAf/wx9X23NPIQtsG1KyP9JjtY+8Nss+c6pBbP03W8mgMdDP1fL6NhqjIS
 dLVnBjKz/zX0dGL4DQ0VPlLFSc9gEAjoYOo3rJIr0KN8LFt9ufHXT6557rD/hFWIwnIV
 UBeA==
X-Gm-Message-State: AOAM532fDSGOgSfMZAZHpSN3ZDs+OGmx0Ud5feu7Py/JpEjtMUZpLGJC
 JQqYb72fDnp/eizE3O3TZzW9FmGCqI3S4LeeQHY=
X-Google-Smtp-Source: ABdhPJyL1nXveqTaodpgh/SlMUr0TCj7G9Y3nTIx2LTHkz79B9nOUjtKqUvvMgGSbccaXvDTHdfXE6xt/F5/hcPZi5g=
X-Received: by 2002:a5d:8a04:: with SMTP id w4mr13329556iod.15.1597689613232; 
 Mon, 17 Aug 2020 11:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200814110057.307-1-f4bug@amsat.org>
In-Reply-To: <20200814110057.307-1-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 17 Aug 2020 20:40:01 +0200
Message-ID: <CAPan3Wod8CRZczqw1AGGzGPxwW3KPDhyP0DQ=apTZn6cV9bgrg@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000dbae7c05ad1719fb"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dbae7c05ad1719fb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Nice improvement, I didnt know about this API. Makes sense to use it indeed=
.
The patch works fine. I tested your patches by applying the previous two
sets first, and then this one.
It ran well with the avocado tests and also with the official image
OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img.

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek



On Fri, Aug 14, 2020 at 1:01 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Allow the device to execute the DMA transfers in a different
> AddressSpace.
>
> The A10 and H3 SoC keep using the system_memory address space,
> but via the proper dma_memory_access() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Based-on: <20200814092346.21825-1-f4bug@amsat.org>
> "hw/sd: Use sdbus_read_data/sdbus_write_data for multiple bytes access"
>
> Tested with:
>   AVOCADO_ALLOW_LARGE_STORAGE=3D1 avocado run -t machine:orangepi-pc -t
> machine:cubieboard tests/acceptance/
> ---
>  include/hw/sd/allwinner-sdhost.h |  6 ++++++
>  hw/arm/allwinner-a10.c           |  2 ++
>  hw/arm/allwinner-h3.c            |  2 ++
>  hw/sd/allwinner-sdhost.c         | 37 ++++++++++++++++++++++++++------
>  4 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/sd/allwinner-sdhost.h
> b/include/hw/sd/allwinner-sdhost.h
> index d94606a853..839732ebf3 100644
> --- a/include/hw/sd/allwinner-sdhost.h
> +++ b/include/hw/sd/allwinner-sdhost.h
> @@ -71,6 +71,12 @@ typedef struct AwSdHostState {
>      /** Interrupt output signal to notify CPU */
>      qemu_irq irq;
>
> +    /** Memory region where DMA transfers are done */
> +    MemoryRegion *dma_mr;
> +
> +    /** Address space used internally for DMA transfers */
> +    AddressSpace dma_as;
> +
>      /** Number of bytes left in current DMA transfer */
>      uint32_t transfer_cnt;
>
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index e258463747..d404f31e02 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -155,6 +155,8 @@ static void aw_a10_realize(DeviceState *dev, Error
> **errp)
>      }
>
>      /* SD/MMC */
> +    object_property_set_link(OBJECT(&s->mmc0), "dma-memory",
> +                             OBJECT(get_system_memory()), &error_fatal);
>      sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, AW_A10_MMC0_BASE);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, qdev_get_gpio_in(dev=
,
> 32));
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index ff92ded82c..43a8d3dc48 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -349,6 +349,8 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
>
>      /* SD/MMC */
> +    object_property_set_link(OBJECT(&s->mmc0), "dma-memory",
> +                             OBJECT(get_system_memory()), &error_fatal);
>      sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_MMC0]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
> diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
> index f9eb92c09e..e82afb75eb 100644
> --- a/hw/sd/allwinner-sdhost.c
> +++ b/hw/sd/allwinner-sdhost.c
> @@ -21,7 +21,10 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qemu/units.h"
> +#include "qapi/error.h"
>  #include "sysemu/blockdev.h"
> +#include "sysemu/dma.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/irq.h"
>  #include "hw/sd/allwinner-sdhost.h"
>  #include "migration/vmstate.h"
> @@ -306,7 +309,7 @@ static uint32_t
> allwinner_sdhost_process_desc(AwSdHostState *s,
>      uint8_t buf[1024];
>
>      /* Read descriptor */
> -    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
> +    dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc));
>      if (desc->size =3D=3D 0) {
>          desc->size =3D klass->max_desc_size;
>      } else if (desc->size > klass->max_desc_size) {
> @@ -331,22 +334,24 @@ static uint32_t
> allwinner_sdhost_process_desc(AwSdHostState *s,
>
>          /* Write to SD bus */
>          if (is_write) {
> -            cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK) +
> num_done,
> -                                      buf, buf_bytes);
> +            dma_memory_read(&s->dma_as,
> +                            (desc->addr & DESC_SIZE_MASK) + num_done,
> +                            buf, buf_bytes);
>              sdbus_write_data(&s->sdbus, buf, buf_bytes);
>
>          /* Read from SD bus */
>          } else {
>              sdbus_read_data(&s->sdbus, buf, buf_bytes);
> -            cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) +
> num_done,
> -                                       buf, buf_bytes);
> +            dma_memory_write(&s->dma_as,
> +                             (desc->addr & DESC_SIZE_MASK) + num_done,
> +                             buf, buf_bytes);
>          }
>          num_done +=3D buf_bytes;
>      }
>
>      /* Clear hold flag and flush descriptor */
>      desc->status &=3D ~DESC_STATUS_HOLD;
> -    cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));
> +    dma_memory_write(&s->dma_as, desc_addr, desc, sizeof(*desc));
>
>      return num_done;
>  }
> @@ -721,6 +726,12 @@ static const VMStateDescription
> vmstate_allwinner_sdhost =3D {
>      }
>  };
>
> +static Property allwinner_sdhost_properties[] =3D {
> +    DEFINE_PROP_LINK("dma-memory", AwSdHostState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void allwinner_sdhost_init(Object *obj)
>  {
>      AwSdHostState *s =3D AW_SDHOST(obj);
> @@ -734,6 +745,18 @@ static void allwinner_sdhost_init(Object *obj)
>      sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
>  }
>
> +static void allwinner_sdhost_realize(DeviceState *dev, Error **errp)
> +{
> +    AwSdHostState *s =3D AW_SDHOST(dev);
> +
> +    if (!s->dma_mr) {
> +        error_setg(errp, TYPE_AW_SDHOST " 'dma-memory' link not set");
> +        return;
> +    }
> +
> +    address_space_init(&s->dma_as, s->dma_mr, "sdhost-dma");
> +}
> +
>  static void allwinner_sdhost_reset(DeviceState *dev)
>  {
>      AwSdHostState *s =3D AW_SDHOST(dev);
> @@ -792,6 +815,8 @@ static void allwinner_sdhost_class_init(ObjectClass
> *klass, void *data)
>
>      dc->reset =3D allwinner_sdhost_reset;
>      dc->vmsd =3D &vmstate_allwinner_sdhost;
> +    dc->realize =3D allwinner_sdhost_realize;
> +    device_class_set_props(dc, allwinner_sdhost_properties);
>  }
>
>  static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass, void
> *data)
> --
> 2.21.3
>
>

--=20
Niek Linnenbank

--000000000000dbae7c05ad1719fb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>Nice improvemen=
t, I didnt know about this API. Makes sense to use it indeed.</div><div>The=
 patch works fine. I tested your patches by applying the previous two sets =
first, and then this one.</div><div>It ran well with the avocado tests and =
also with the official image OrangePi_pc_debian_stretch_server_linux5.3.5_v=
1.0.img.</div><div><br></div><div>Tested-by: Niek Linnenbank &lt;<a href=3D=
"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><di=
v>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.c=
om">nieklinnenbank@gmail.com</a>&gt;</div><div><br></div><div>Regards,</div=
><div>Niek<br></div><div><br></div><div><br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 14, 2020 at 1=
:01 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f=
4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Allow the device to execute the DMA transfers in a different<=
br>
AddressSpace.<br>
<br>
The A10 and H3 SoC keep using the system_memory address space,<br>
but via the proper dma_memory_access() API.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
Based-on: &lt;<a href=3D"mailto:20200814092346.21825-1-f4bug@amsat.org" tar=
get=3D"_blank">20200814092346.21825-1-f4bug@amsat.org</a>&gt;<br>
&quot;hw/sd: Use sdbus_read_data/sdbus_write_data for multiple bytes access=
&quot;<br>
<br>
Tested with:<br>
=C2=A0 AVOCADO_ALLOW_LARGE_STORAGE=3D1 avocado run -t machine:orangepi-pc -=
t machine:cubieboard tests/acceptance/<br>
---<br>
=C2=A0include/hw/sd/allwinner-sdhost.h |=C2=A0 6 ++++++<br>
=C2=A0hw/arm/allwinner-a10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 ++<br>
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 ++<br>
=C2=A0hw/sd/allwinner-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 37 ++++++=
++++++++++++++++++++------<br>
=C2=A04 files changed, 41 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdh=
ost.h<br>
index d94606a853..839732ebf3 100644<br>
--- a/include/hw/sd/allwinner-sdhost.h<br>
+++ b/include/hw/sd/allwinner-sdhost.h<br>
@@ -71,6 +71,12 @@ typedef struct AwSdHostState {<br>
=C2=A0 =C2=A0 =C2=A0/** Interrupt output signal to notify CPU */<br>
=C2=A0 =C2=A0 =C2=A0qemu_irq irq;<br>
<br>
+=C2=A0 =C2=A0 /** Memory region where DMA transfers are done */<br>
+=C2=A0 =C2=A0 MemoryRegion *dma_mr;<br>
+<br>
+=C2=A0 =C2=A0 /** Address space used internally for DMA transfers */<br>
+=C2=A0 =C2=A0 AddressSpace dma_as;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/** Number of bytes left in current DMA transfer */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t transfer_cnt;<br>
<br>
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c<br>
index e258463747..d404f31e02 100644<br>
--- a/hw/arm/allwinner-a10.c<br>
+++ b/hw/arm/allwinner-a10.c<br>
@@ -155,6 +155,8 @@ static void aw_a10_realize(DeviceState *dev, Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SD/MMC */<br>
+=C2=A0 =C2=A0 object_property_set_link(OBJECT(&amp;s-&gt;mmc0), &quot;dma-=
memory&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(get_system_memory()), &amp;error_fata=
l);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), &amp;er=
ror_fatal);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0, AW_=
A10_MMC0_BASE);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0, =
qdev_get_gpio_in(dev, 32));<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index ff92ded82c..43a8d3dc48 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -349,6 +349,8 @@ static void allwinner_h3_realize(DeviceState *dev, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, s-&g=
t;memmap[AW_H3_SID]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SD/MMC */<br>
+=C2=A0 =C2=A0 object_property_set_link(OBJECT(&amp;s-&gt;mmc0), &quot;dma-=
memory&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(get_system_memory()), &amp;error_fata=
l);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), &amp;er=
ror_fatal);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0, s-&=
gt;memmap[AW_H3_MMC0]);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0,<=
br>
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c<br>
index f9eb92c09e..e82afb75eb 100644<br>
--- a/hw/sd/allwinner-sdhost.c<br>
+++ b/hw/sd/allwinner-sdhost.c<br>
@@ -21,7 +21,10 @@<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;sysemu/blockdev.h&quot;<br>
+#include &quot;sysemu/dma.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/sd/allwinner-sdhost.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
@@ -306,7 +309,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostS=
tate *s,<br>
=C2=A0 =C2=A0 =C2=A0uint8_t buf[1024];<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Read descriptor */<br>
-=C2=A0 =C2=A0 cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));<br=
>
+=C2=A0 =C2=A0 dma_memory_read(&amp;s-&gt;dma_as, desc_addr, desc, sizeof(*=
desc));<br>
=C2=A0 =C2=A0 =C2=A0if (desc-&gt;size =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc-&gt;size =3D klass-&gt;max_desc_size=
;<br>
=C2=A0 =C2=A0 =C2=A0} else if (desc-&gt;size &gt; klass-&gt;max_desc_size) =
{<br>
@@ -331,22 +334,24 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHos=
tState *s,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Write to SD bus */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_write) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_read((desc-&=
gt;addr &amp; DESC_SIZE_MASK) + num_done,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf, buf_bytes)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_memory_read(&amp;s-&gt;dma_a=
s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (desc-&gt;addr &amp; DESC_SIZE_MASK) + num_done,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 buf, buf_bytes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdbus_write_data(&amp;s-&gt=
;sdbus, buf, buf_bytes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Read from SD bus */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdbus_read_data(&amp;s-&gt;=
sdbus, buf, buf_bytes);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_physical_memory_write((desc-=
&gt;addr &amp; DESC_SIZE_MASK) + num_done,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf, buf_=
bytes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_memory_write(&amp;s-&gt;dma_=
as,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(desc-&gt;addr &amp; DESC_SIZE_MASK) + num_d=
one,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf, buf_bytes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_done +=3D buf_bytes;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Clear hold flag and flush descriptor */<br>
=C2=A0 =C2=A0 =C2=A0desc-&gt;status &amp;=3D ~DESC_STATUS_HOLD;<br>
-=C2=A0 =C2=A0 cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));<b=
r>
+=C2=A0 =C2=A0 dma_memory_write(&amp;s-&gt;dma_as, desc_addr, desc, sizeof(=
*desc));<br>
<br>
=C2=A0 =C2=A0 =C2=A0return num_done;<br>
=C2=A0}<br>
@@ -721,6 +726,12 @@ static const VMStateDescription vmstate_allwinner_sdho=
st =3D {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
+static Property allwinner_sdhost_properties[] =3D {<br>
+=C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;dma-memory&quot;, AwSdHostState, dma_=
mr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TYPE_MEMORY_REGION, MemoryRegion *),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
+};<br>
+<br>
=C2=A0static void allwinner_sdhost_init(Object *obj)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostState *s =3D AW_SDHOST(obj);<br>
@@ -734,6 +745,18 @@ static void allwinner_sdhost_init(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0sysbus_init_irq(SYS_BUS_DEVICE(s), &amp;s-&gt;irq);<br>
=C2=A0}<br>
<br>
+static void allwinner_sdhost_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 AwSdHostState *s =3D AW_SDHOST(dev);<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;dma_mr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, TYPE_AW_SDHOST &quot; &#39;dm=
a-memory&#39; link not set&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 address_space_init(&amp;s-&gt;dma_as, s-&gt;dma_mr, &quot;sd=
host-dma&quot;);<br>
+}<br>
+<br>
=C2=A0static void allwinner_sdhost_reset(DeviceState *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostState *s =3D AW_SDHOST(dev);<br>
@@ -792,6 +815,8 @@ static void allwinner_sdhost_class_init(ObjectClass *kl=
ass, void *data)<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;reset =3D allwinner_sdhost_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_allwinner_sdhost;<br>
+=C2=A0 =C2=A0 dc-&gt;realize =3D allwinner_sdhost_realize;<br>
+=C2=A0 =C2=A0 device_class_set_props(dc, allwinner_sdhost_properties);<br>
=C2=A0}<br>
<br>
=C2=A0static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass, voi=
d *data)<br>
-- <br>
2.21.3<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--000000000000dbae7c05ad1719fb--

