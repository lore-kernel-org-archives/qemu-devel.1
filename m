Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB071C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEF521019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEF521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36141 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLXF-0003WW-MD
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:18:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOLTm-0007z7-JT
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOLTk-0006dK-Ol
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:15:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOLTk-0006b7-HC
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:15:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so2978443wma.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 05:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UIwsR/ZNvp+XSOZL34+yTxqnZwwE+IrugCqniDYGrX8=;
	b=jXtJ7GenIvKYc34X0E0nkNbHRXARn8JnYMFezhzojBupiSOvXFh5niJZb0gLCp3AJA
	8e4ic7R1EQ9ixOK6k0o7SPWirV1BYhlAFhKL01AylA2xQ0nmoU5IFs/x8bfhvcSk71Wr
	rCC9vgYyslC2qumhpeDjLq4lpx0OM3OQ6nyPTeg/BVBy+eoJoLfDPDcLMrPDY3ziK1F7
	g1PHg6eG7v2T4AjR44uJL+sDbCpWSq/+UPWIbfn2+1p7AESAKXUjHUEvNp4qQYkUbn9q
	1MaXYVs1XSIG+Z5/iq+5MmTysjAR+0Rj+0ihVpypQvRys43M1O7NiF5T3fX/J97EzdWS
	1R4g==
X-Gm-Message-State: APjAAAW+SPOPuv93p0TN6Vp837xfmWOSbz8aVWdVNADu+phX9DFsv2+U
	OYhjjg0BCXO0b42IDzzh+IX8vQ==
X-Google-Smtp-Source: APXvYqyc8+UiFMS2dFqzyrgCzQCZ+BJ/53GNczGu5V2TFtczg3Skt58x9HnFcSAuYo7KxaHHvBFyvg==
X-Received: by 2002:a1c:ef18:: with SMTP id n24mr2723580wmh.94.1557317719254; 
	Wed, 08 May 2019 05:15:19 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	v5sm22571019wra.83.2019.05.08.05.15.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 05:15:18 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190504123538.14952-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc2ede5e-4761-e585-dfee-7026c2f06db8@redhat.com>
Date: Wed, 8 May 2019 14:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504123538.14952-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] hw/net/ne2000: Extract the PCI device from
 the chipset common code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/05/19 07:35, Philippe Mathieu-Daudé wrote:
> The ne2000.c file contains functions common the the ISA and PCI
> devices. To allow to build with one or another, extract the PCI
> specific part into a new file.
> 
> This fix an issue where the NE2000_ISA Kconfig had to pull the
> full PCI core objects.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/net/Kconfig       |   7 ++-
>  hw/net/Makefile.objs |   3 +-
>  hw/net/ne2000-pci.c  | 132 +++++++++++++++++++++++++++++++++++++++++++
>  hw/net/ne2000.c      | 105 ----------------------------------
>  4 files changed, 139 insertions(+), 108 deletions(-)
>  create mode 100644 hw/net/ne2000-pci.c
> 
> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> index 7d7bbc5d7c9..4ef86dc3a53 100644
> --- a/hw/net/Kconfig
> +++ b/hw/net/Kconfig
> @@ -1,10 +1,14 @@
>  config DP8393X
>      bool
>  
> +config NE2000_COMMON
> +    bool
> +
>  config NE2000_PCI
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> +    select NE2000_COMMON
>  
>  config EEPRO100_PCI
>      bool
> @@ -51,8 +55,7 @@ config NE2000_ISA
>      bool
>      default y
>      depends on ISA_BUS
> -    depends on PCI # for NE2000State
> -    select NE2000_PCI
> +    select NE2000_COMMON
>  
>  config OPENCORES_ETH
>      bool
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index ea637157802..9904273b060 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -1,8 +1,9 @@
>  common-obj-$(CONFIG_DP8393X) += dp8393x.o
>  common-obj-$(CONFIG_XEN) += xen_nic.o
> +common-obj-$(CONFIG_NE2000_COMMON) += ne2000.o
>  
>  # PCI network cards
> -common-obj-$(CONFIG_NE2000_PCI) += ne2000.o
> +common-obj-$(CONFIG_NE2000_PCI) += ne2000-pci.o
>  common-obj-$(CONFIG_EEPRO100_PCI) += eepro100.o
>  common-obj-$(CONFIG_PCNET_PCI) += pcnet-pci.o
>  common-obj-$(CONFIG_PCNET_COMMON) += pcnet.o
> diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
> new file mode 100644
> index 00000000000..cb05744f3c3
> --- /dev/null
> +++ b/hw/net/ne2000-pci.c
> @@ -0,0 +1,132 @@
> +/*
> + * QEMU NE2000 emulation (PCI bus)
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "ne2000.h"
> +#include "sysemu/sysemu.h"
> +
> +typedef struct PCINE2000State {
> +    PCIDevice dev;
> +    NE2000State ne2000;
> +} PCINE2000State;
> +
> +static const VMStateDescription vmstate_pci_ne2000 = {
> +    .name = "ne2000",
> +    .version_id = 3,
> +    .minimum_version_id = 3,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, PCINE2000State),
> +        VMSTATE_STRUCT(ne2000, PCINE2000State, 0, vmstate_ne2000, NE2000State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static NetClientInfo net_ne2000_info = {
> +    .type = NET_CLIENT_DRIVER_NIC,
> +    .size = sizeof(NICState),
> +    .receive = ne2000_receive,
> +};
> +
> +static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> +    NE2000State *s;
> +    uint8_t *pci_conf;
> +
> +    pci_conf = d->dev.config;
> +    pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
> +
> +    s = &d->ne2000;
> +    ne2000_setup_io(s, DEVICE(pci_dev), 0x100);
> +    pci_register_bar(&d->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
> +    s->irq = pci_allocate_irq(&d->dev);
> +
> +    qemu_macaddr_default_if_unset(&s->c.macaddr);
> +    ne2000_reset(s);
> +
> +    s->nic = qemu_new_nic(&net_ne2000_info, &s->c,
> +                          object_get_typename(OBJECT(pci_dev)),
> +                          pci_dev->qdev.id, s);
> +    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
> +}
> +
> +static void pci_ne2000_exit(PCIDevice *pci_dev)
> +{
> +    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> +    NE2000State *s = &d->ne2000;
> +
> +    qemu_del_nic(s->nic);
> +    qemu_free_irq(s->irq);
> +}
> +
> +static void ne2000_instance_init(Object *obj)
> +{
> +    PCIDevice *pci_dev = PCI_DEVICE(obj);
> +    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> +    NE2000State *s = &d->ne2000;
> +
> +    device_add_bootindex_property(obj, &s->c.bootindex,
> +                                  "bootindex", "/ethernet-phy@0",
> +                                  &pci_dev->qdev, NULL);
> +}
> +
> +static Property ne2000_properties[] = {
> +    DEFINE_NIC_PROPERTIES(PCINE2000State, ne2000.c),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void ne2000_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = pci_ne2000_realize;
> +    k->exit = pci_ne2000_exit;
> +    k->romfile = "efi-ne2k_pci.rom",
> +    k->vendor_id = PCI_VENDOR_ID_REALTEK;
> +    k->device_id = PCI_DEVICE_ID_REALTEK_8029;
> +    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
> +    dc->vmsd = &vmstate_pci_ne2000;
> +    dc->props = ne2000_properties;
> +    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> +}
> +
> +static const TypeInfo ne2000_info = {
> +    .name          = "ne2k_pci",
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(PCINE2000State),
> +    .class_init    = ne2000_class_init,
> +    .instance_init = ne2000_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void ne2000_register_types(void)
> +{
> +    type_register_static(&ne2000_info);
> +}
> +
> +type_init(ne2000_register_types)
> diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
> index 037afc8052a..ca792d96f1b 100644
> --- a/hw/net/ne2000.c
> +++ b/hw/net/ne2000.c
> @@ -22,7 +22,6 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> -#include "hw/pci/pci.h"
>  #include "net/eth.h"
>  #include "ne2000.h"
>  #include "sysemu/sysemu.h"
> @@ -118,11 +117,6 @@
>  #define ENTSR_CDH 0x40	/* The collision detect "heartbeat" signal was lost. */
>  #define ENTSR_OWC 0x80  /* There was an out-of-window collision. */
>  
> -typedef struct PCINE2000State {
> -    PCIDevice dev;
> -    NE2000State ne2000;
> -} PCINE2000State;
> -
>  void ne2000_reset(NE2000State *s)
>  {
>      int i;
> @@ -644,17 +638,6 @@ const VMStateDescription vmstate_ne2000 = {
>      }
>  };
>  
> -static const VMStateDescription vmstate_pci_ne2000 = {
> -    .name = "ne2000",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(dev, PCINE2000State),
> -        VMSTATE_STRUCT(ne2000, PCINE2000State, 0, vmstate_ne2000, NE2000State),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>  static uint64_t ne2000_read(void *opaque, hwaddr addr,
>                              unsigned size)
>  {
> @@ -711,91 +694,3 @@ void ne2000_setup_io(NE2000State *s, DeviceState *dev, unsigned size)
>  {
>      memory_region_init_io(&s->io, OBJECT(dev), &ne2000_ops, s, "ne2000", size);
>  }
> -
> -static NetClientInfo net_ne2000_info = {
> -    .type = NET_CLIENT_DRIVER_NIC,
> -    .size = sizeof(NICState),
> -    .receive = ne2000_receive,
> -};
> -
> -static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
> -{
> -    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> -    NE2000State *s;
> -    uint8_t *pci_conf;
> -
> -    pci_conf = d->dev.config;
> -    pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
> -
> -    s = &d->ne2000;
> -    ne2000_setup_io(s, DEVICE(pci_dev), 0x100);
> -    pci_register_bar(&d->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
> -    s->irq = pci_allocate_irq(&d->dev);
> -
> -    qemu_macaddr_default_if_unset(&s->c.macaddr);
> -    ne2000_reset(s);
> -
> -    s->nic = qemu_new_nic(&net_ne2000_info, &s->c,
> -                          object_get_typename(OBJECT(pci_dev)), pci_dev->qdev.id, s);
> -    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
> -}
> -
> -static void pci_ne2000_exit(PCIDevice *pci_dev)
> -{
> -    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> -    NE2000State *s = &d->ne2000;
> -
> -    qemu_del_nic(s->nic);
> -    qemu_free_irq(s->irq);
> -}
> -
> -static void ne2000_instance_init(Object *obj)
> -{
> -    PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    PCINE2000State *d = DO_UPCAST(PCINE2000State, dev, pci_dev);
> -    NE2000State *s = &d->ne2000;
> -
> -    device_add_bootindex_property(obj, &s->c.bootindex,
> -                                  "bootindex", "/ethernet-phy@0",
> -                                  &pci_dev->qdev, NULL);
> -}
> -
> -static Property ne2000_properties[] = {
> -    DEFINE_NIC_PROPERTIES(PCINE2000State, ne2000.c),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void ne2000_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> -
> -    k->realize = pci_ne2000_realize;
> -    k->exit = pci_ne2000_exit;
> -    k->romfile = "efi-ne2k_pci.rom",
> -    k->vendor_id = PCI_VENDOR_ID_REALTEK;
> -    k->device_id = PCI_DEVICE_ID_REALTEK_8029;
> -    k->class_id = PCI_CLASS_NETWORK_ETHERNET;
> -    dc->vmsd = &vmstate_pci_ne2000;
> -    dc->props = ne2000_properties;
> -    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> -}
> -
> -static const TypeInfo ne2000_info = {
> -    .name          = "ne2k_pci",
> -    .parent        = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(PCINE2000State),
> -    .class_init    = ne2000_class_init,
> -    .instance_init = ne2000_instance_init,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    },
> -};
> -
> -static void ne2000_register_types(void)
> -{
> -    type_register_static(&ne2000_info);
> -}
> -
> -type_init(ne2000_register_types)
> 

Queued, thanks.

Paolo

