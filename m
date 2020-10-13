Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A349C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B51823A3B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/PELe5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B51823A3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKVX-0002Em-U5
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKUS-00010d-Qx; Tue, 13 Oct 2020 09:37:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKUQ-0002Nn-JN; Tue, 13 Oct 2020 09:37:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id t9so24079632wrq.11;
 Tue, 13 Oct 2020 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VqT3hg7rV6DiC2mCy2h6XXMKcDOTTt2c17aw1dZP0v8=;
 b=O/PELe5zxgszvu3DOsMaUynQI63f1wTFWj3Oat+uwcMdSd+mS2+2U5RdKi31BxLNvH
 mLOZPfWcN/tG+1eJMhufATeSMgDp6DEkWaqFX3ug13BbOHXiI7qDRfLgqwOtBrPLoo1i
 pew7QoImBsNidRPejGfeTR8GTnmu1L2VyO13ANfjMBk9GclJ+nILppWLvwriKBFP+1Rd
 SFHPZcc2T0jHrGvBYp9EclJWzXqZE4F0gCULgUO6Lpnyv2ilEuhWWdwE1dMh9AicHusv
 GjMOEbSwMqUhBlZJQPQoQYv/IINB3RAq8KhMIcCDvTuEJiY3zGNVe0lXeQDC+uW+nkBL
 bZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VqT3hg7rV6DiC2mCy2h6XXMKcDOTTt2c17aw1dZP0v8=;
 b=oi4ra3yW9pUJ5FXLZCNwu74uMXP9P9ZlyoTobypH07sXYuwlHm8btSiOwdM4Vpzmuc
 cWyqfeXcL3plYufpMGgc0hnCU3e38lKGgDQCZhkQ8SoYK1OiTSXuZ+enc4CqStpBJmal
 Tki/eVbhabZqdBIPXqJfhwXfAprcett79b+UPx7kmEEvUkgXHhg767+4djqzK79tXVlz
 hZeCSxe7WaCbFV44+RNrwq7isG9lXUZofFUYx4bjzHE3sRvzdj+8lONMOyU0EOlgvoYJ
 npmd1/2FtW95w1aroK4QqVnavCd1mCU1Rc0nLNCkioSZvAALom16KMhLPGc6GuByf4Ji
 diVA==
X-Gm-Message-State: AOAM532QUTUYDCwHHpbvahi0WL3E4sG6iT/fpgYAC4YeSD9Gr6o6mZ1T
 tyBvOKJESZduciFBNcA791rhjN1hqIY=
X-Google-Smtp-Source: ABdhPJzvmlL7L+a363LEMxc3eiKd72WTnpVcskpuMGTJ8sbnN/bvFZp5K7C3sbyOwikfRUcNEL4yDQ==
X-Received: by 2002:a5d:6a86:: with SMTP id s6mr26676972wru.344.1602596236341; 
 Tue, 13 Oct 2020 06:37:16 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f14sm30101572wrt.53.2020.10.13.06.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 06:37:15 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] grackle: use qdev gpios for PCI IRQs
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c882279b-a561-2c3a-a6b5-b27446fddb02@amsat.org>
Date: Tue, 13 Oct 2020 15:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 1:49 PM, Mark Cave-Ayland wrote:
> Currently an object link property is used to pass a reference to the Heathrow
> PIC into the PCI host bridge so that grackle_init_irqs() can connect the PCI
> IRQs to the PIC itself.
> 
> This can be simplified by defining the PCI IRQs as qdev gpios and then wiring
> up the PCI IRQs to the PIC in the Old World machine init function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci-host/grackle.c | 19 ++-----------------
>   hw/ppc/mac_oldworld.c |  7 +++++--
>   2 files changed, 7 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
> index 57c29b20af..b05facf463 100644
> --- a/hw/pci-host/grackle.c
> +++ b/hw/pci-host/grackle.c
> @@ -28,7 +28,6 @@
>   #include "hw/ppc/mac.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci.h"
> -#include "hw/intc/heathrow_pic.h"
>   #include "hw/irq.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
> @@ -41,7 +40,6 @@ struct GrackleState {
>       PCIHostState parent_obj;
>   
>       uint32_t ofw_addr;
> -    HeathrowState *pic;
>       qemu_irq irqs[4];
>       MemoryRegion pci_mmio;
>       MemoryRegion pci_hole;
> @@ -62,15 +60,6 @@ static void pci_grackle_set_irq(void *opaque, int irq_num, int level)
>       qemu_set_irq(s->irqs[irq_num], level);
>   }
>   
> -static void grackle_init_irqs(GrackleState *s)
> -{
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(s->irqs); i++) {
> -        s->irqs[i] = qdev_get_gpio_in(DEVICE(s->pic), 0x15 + i);
> -    }
> -}
> -
>   static void grackle_realize(DeviceState *dev, Error **errp)
>   {
>       GrackleState *s = GRACKLE_PCI_HOST_BRIDGE(dev);
> @@ -85,7 +74,6 @@ static void grackle_realize(DeviceState *dev, Error **errp)
>                                        0, 4, TYPE_PCI_BUS);
>   
>       pci_create_simple(phb->bus, 0, "grackle");
> -    grackle_init_irqs(s);
>   }
>   
>   static void grackle_init(Object *obj)
> @@ -106,15 +94,12 @@ static void grackle_init(Object *obj)
>       memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops,
>                             DEVICE(obj), "pci-data-idx", 0x1000);
>   
> -    object_property_add_link(obj, "pic", TYPE_HEATHROW,
> -                             (Object **) &s->pic,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             0);
> -
>       sysbus_init_mmio(sbd, &phb->conf_mem);
>       sysbus_init_mmio(sbd, &phb->data_mem);
>       sysbus_init_mmio(sbd, &s->pci_hole);
>       sysbus_init_mmio(sbd, &s->pci_io);
> +
> +    qdev_init_gpio_out(DEVICE(obj), s->irqs, ARRAY_SIZE(s->irqs));
>   }
>   
>   static void grackle_pci_realize(PCIDevice *d, Error **errp)
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index d6a76d06dc..05e46ee6fe 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -253,10 +253,9 @@ static void ppc_heathrow_init(MachineState *machine)
>       /* Grackle PCI host bridge */
>       dev = qdev_new(TYPE_GRACKLE_PCI_HOST_BRIDGE);
>       qdev_prop_set_uint32(dev, "ofw-addr", 0x80000000);
> -    object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
> -                             &error_abort);
>       s = SYS_BUS_DEVICE(dev);
>       sysbus_realize_and_unref(s, &error_fatal);
> +
>       sysbus_mmio_map(s, 0, GRACKLE_BASE);
>       sysbus_mmio_map(s, 1, GRACKLE_BASE + 0x200000);
>       /* PCI hole */
> @@ -266,6 +265,10 @@ static void ppc_heathrow_init(MachineState *machine)
>       memory_region_add_subregion(get_system_memory(), 0xfe000000,
>                                   sysbus_mmio_get_region(s, 3));
>   
> +    for (i = 0; i < 4; i++) {
> +        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in(pic_dev, 0x15 + i));

If possible (follow up patch) please describe this 0x15 magic value.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    }
> +
>       pci_bus = PCI_HOST_BRIDGE(dev)->bus;
>   
>       pci_vga_init(pci_bus);
> 

