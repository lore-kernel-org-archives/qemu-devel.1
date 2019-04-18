Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE1AC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07D821479
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 12:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07D821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH6Hm-0004Su-3e
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 08:37:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6Ga-0003p6-D0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:35:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH6GX-0007Pg-IS
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:35:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH6GX-0007Oi-87
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 08:35:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so2780755wrn.6
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=zQwBempIzIUrribaiGB/Mp746QSFxAZdfJjAET/MPqg=;
	b=K4RSPlT+iPlktrs0XUEkbKHDt3WVzKL6/IUdCRO16PlSdUFf1NRK3u+0RtsBYIlgSp
	GVu/4cNeWUkFrj+gtJ/ryxZgEgllm9oLh+uE887/k1n09QSOc9qTAf0F4RPAhqdxyayy
	+hZjXfIPWU/gxojtFj9D8ek/eO85/LBkGI0FBfB+eDKsv1MEUVvjXiwZz3iOv0MnjG/o
	0UTpLn1ITpU1zwQtIgJZ12hmbi8u/M81R5hP2jS+HOwk8XOjaSof7CmIpwC6DpIB2n9+
	B2UhcheicrNZ1zI0CSrMfoZzgHr7G4+ynGQU55nG4A3dDguptH2e/Gb7czY9srlHYNu0
	5GOg==
X-Gm-Message-State: APjAAAVsIV/MPPKU0rJeMA+XOMiN6oY4RLnYBoaOZEurhNUCKJbm/Ss5
	jHVScXGkIV2yKm8ndt1cbp2naA==
X-Google-Smtp-Source: APXvYqxPkGtRDPgyLDWW/juslXbdmHN3rNGXE34yR9qaJdYAPRWGjwZA8KIogmLjaw/5SJPv7u8Tzw==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr55857467wre.246.1555590944057;
	Thu, 18 Apr 2019 05:35:44 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z84sm2797702wmg.24.2019.04.18.05.35.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 05:35:43 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>
References: <20190418111019.4080-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6bd7dd96-cd2c-22aa-5533-ae341f942a5c@redhat.com>
Date: Thu, 18 Apr 2019 14:35:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418111019.4080-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/usb/hcd-ohci: Move PCI-related
 code into a separate file
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
Cc: Yang Zhong <yang.zhong@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418123537.wxbnmdorcRDlaItCUkd8HU0pD_Pcn8nYaevIQgf8NNs@z>

Hi Thomas,

On 4/18/19 1:10 PM, Thomas Huth wrote:
> Some machines (like the pxa2xx-based ARM machines) only have a sysbus
> OHCI controller, but no PCI. With the new Kconfig-style build system,
> it will soon be possible to create QEMU binaries that only contain
> such PCI-less machines. However, the two OHCI controllers, for sysbus
> and for PCI, are currently both located in one file, so the PCI code
> is still required for linking here. Move the OHCI-PCI device code
> into a separate file, so that it is possible to use the sysbus OHCI
> device also without the PCI dependency.
> 
> Apart from moving code to a new file (and a new header), this patch
> might also fix one subtle bug: The ohci_die() function always assumed
> to be running with a OHCI-PCI controller and called some PCI-specific
> functions - but if I got the code right, ohci_die() might also get
> called for the sysbus-OHCI device, so it likely failed in that case.
> I've changed this part of the code now, so that there are two ohci_die()
> implementations now, one for sysbus and one for PCI.

Can this be done in 2 patches?

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/usb/Kconfig        |   6 +-
>  hw/usb/Makefile.objs  |   1 +
>  hw/usb/hcd-ohci-pci.c | 166 ++++++++++++++++++++++++++++
>  hw/usb/hcd-ohci.c     | 244 +++---------------------------------------
>  hw/usb/hcd-ohci.h     | 132 +++++++++++++++++++++++
>  5 files changed, 321 insertions(+), 228 deletions(-)
>  create mode 100644 hw/usb/hcd-ohci-pci.c
>  create mode 100644 hw/usb/hcd-ohci.h
> 
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index a1b7acb12a..564305e283 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -8,10 +8,14 @@ config USB_UHCI
>      select USB
>  
>  config USB_OHCI
> +    bool
> +    select USB
> +
> +config USB_OHCI_PCI
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> -    select USB
> +    select USB_OHCI
>  
>  config USB_EHCI
>      bool
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 2b929649ac..81688f6e70 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -5,6 +5,7 @@ common-obj-$(CONFIG_USB) += desc.o desc-msos.o
>  # usb host adapters
>  common-obj-$(CONFIG_USB_UHCI) += hcd-uhci.o
>  common-obj-$(CONFIG_USB_OHCI) += hcd-ohci.o
> +common-obj-$(CONFIG_USB_OHCI_PCI) += hcd-ohci-pci.o
>  common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o hcd-ehci-pci.o
>  common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci.o hcd-ehci-sysbus.o
>  common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
> diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
> new file mode 100644
> index 0000000000..e972df35c9
> --- /dev/null
> +++ b/hw/usb/hcd-ohci-pci.c
> @@ -0,0 +1,166 @@
> +/*
> + * QEMU USB OHCI Emulation
> + * Copyright (c) 2004 Gianni Tedesco
> + * Copyright (c) 2006 CodeSourcery
> + * Copyright (c) 2006 Openedhand Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/hw.h"
> +#include "qapi/error.h"
> +#include "qemu/timer.h"
> +#include "hw/usb.h"
> +#include "hw/pci/pci.h"
> +#include "hw/sysbus.h"
> +#include "hw/qdev-dma.h"
> +#include "trace.h"
> +#include "hcd-ohci.h"
> +
> +#define TYPE_PCI_OHCI "pci-ohci"
> +#define PCI_OHCI(obj) OBJECT_CHECK(OHCIPCIState, (obj), TYPE_PCI_OHCI)
> +
> +typedef struct {
> +    /*< private >*/
> +    PCIDevice parent_obj;
> +    /*< public >*/
> +
> +    OHCIState state;
> +    char *masterbus;
> +    uint32_t num_ports;
> +    uint32_t firstport;
> +} OHCIPCIState;
> +
> +/**
> + * A typical O/EHCI will stop operating, set itself into error state
> + * (which can be queried by MMIO) and will set PERR in its config
> + * space to signal that it got an error
> + */
> +static void ohci_pci_die(OHCIState *ohci)
> +{
> +    OHCIPCIState *dev = container_of(ohci, OHCIPCIState, state);
> +
> +    trace_usb_ohci_die();
> +
> +    ohci_set_interrupt(ohci, OHCI_INTR_UE);
> +    ohci_bus_stop(ohci);
> +    pci_set_word(dev->parent_obj.config + PCI_STATUS,
> +                 PCI_STATUS_DETECTED_PARITY);
> +}
> +
> +static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
> +{
> +    Error *err = NULL;
> +    OHCIPCIState *ohci = PCI_OHCI(dev);
> +
> +    dev->config[PCI_CLASS_PROG] = 0x10; /* OHCI */
> +    dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
> +
> +    usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
> +                  ohci->masterbus, ohci->firstport,
> +                  pci_get_address_space(dev), ohci_pci_die, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    ohci->state.irq = pci_allocate_irq(dev);
> +    pci_register_bar(dev, 0, 0, &ohci->state.mem);
> +}
> +
> +static void usb_ohci_exit(PCIDevice *dev)
> +{
> +    OHCIPCIState *ohci = PCI_OHCI(dev);
> +    OHCIState *s = &ohci->state;
> +
> +    trace_usb_ohci_exit(s->name);
> +    ohci_bus_stop(s);
> +
> +    if (s->async_td) {
> +        usb_cancel_packet(&s->usb_packet);
> +        s->async_td = 0;
> +    }
> +    ohci_stop_endpoints(s);
> +
> +    if (!ohci->masterbus) {
> +        usb_bus_release(&s->bus);
> +    }
> +
> +    timer_del(s->eof_timer);
> +    timer_free(s->eof_timer);
> +}
> +
> +static void usb_ohci_reset_pci(DeviceState *d)
> +{
> +    PCIDevice *dev = PCI_DEVICE(d);
> +    OHCIPCIState *ohci = PCI_OHCI(dev);
> +    OHCIState *s = &ohci->state;
> +
> +    ohci_hard_reset(s);
> +}
> +
> +static Property ohci_pci_properties[] = {
> +    DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
> +    DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
> +    DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static const VMStateDescription vmstate_ohci = {
> +    .name = "ohci",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(parent_obj, OHCIPCIState),
> +        VMSTATE_STRUCT(state, OHCIPCIState, 1, vmstate_ohci_state, OHCIState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void ohci_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +
> +    k->realize = usb_ohci_realize_pci;
> +    k->exit = usb_ohci_exit;
> +    k->vendor_id = PCI_VENDOR_ID_APPLE;
> +    k->device_id = PCI_DEVICE_ID_APPLE_IPID_USB;
> +    k->class_id = PCI_CLASS_SERIAL_USB;
> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> +    dc->desc = "Apple USB Controller";
> +    dc->props = ohci_pci_properties;
> +    dc->hotpluggable = false;
> +    dc->vmsd = &vmstate_ohci;
> +    dc->reset = usb_ohci_reset_pci;
> +}
> +
> +static const TypeInfo ohci_pci_info = {
> +    .name          = TYPE_PCI_OHCI,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(OHCIPCIState),
> +    .class_init    = ohci_pci_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void ohci_pci_register_types(void)
> +{
> +    type_register_static(&ohci_pci_info);
> +}
> +
> +type_init(ohci_pci_register_types)
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 81cf5ab7a5..343816d561 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -30,86 +30,19 @@
>  #include "qapi/error.h"
>  #include "qemu/timer.h"
>  #include "hw/usb.h"
> -#include "hw/pci/pci.h"
>  #include "hw/sysbus.h"
>  #include "hw/qdev-dma.h"
>  #include "trace.h"
> +#include "hcd-ohci.h"
>  
>  /* This causes frames to occur 1000x slower */
>  //#define OHCI_TIME_WARP 1
>  
> -/* Number of Downstream Ports on the root hub.  */
> -
> -#define OHCI_MAX_PORTS 15
> -
>  #define ED_LINK_LIMIT 32
>  
>  static int64_t usb_frame_time;
>  static int64_t usb_bit_time;
>  
> -typedef struct OHCIPort {
> -    USBPort port;
> -    uint32_t ctrl;
> -} OHCIPort;
> -
> -typedef struct {
> -    USBBus bus;
> -    qemu_irq irq;
> -    MemoryRegion mem;
> -    AddressSpace *as;
> -    uint32_t num_ports;
> -    const char *name;
> -
> -    QEMUTimer *eof_timer;
> -    int64_t sof_time;
> -
> -    /* OHCI state */
> -    /* Control partition */
> -    uint32_t ctl, status;
> -    uint32_t intr_status;
> -    uint32_t intr;
> -
> -    /* memory pointer partition */
> -    uint32_t hcca;
> -    uint32_t ctrl_head, ctrl_cur;
> -    uint32_t bulk_head, bulk_cur;
> -    uint32_t per_cur;
> -    uint32_t done;
> -    int32_t done_count;
> -
> -    /* Frame counter partition */
> -    uint16_t fsmps;
> -    uint8_t fit;
> -    uint16_t fi;
> -    uint8_t frt;
> -    uint16_t frame_number;
> -    uint16_t padding;
> -    uint32_t pstart;
> -    uint32_t lst;
> -
> -    /* Root Hub partition */
> -    uint32_t rhdesc_a, rhdesc_b;
> -    uint32_t rhstatus;
> -    OHCIPort rhport[OHCI_MAX_PORTS];
> -
> -    /* PXA27x Non-OHCI events */
> -    uint32_t hstatus;
> -    uint32_t hmask;
> -    uint32_t hreset;
> -    uint32_t htest;
> -
> -    /* SM501 local memory offset */
> -    dma_addr_t localmem_base;
> -
> -    /* Active packets.  */
> -    uint32_t old_ctl;
> -    USBPacket usb_packet;
> -    uint8_t usb_buf[8192];
> -    uint32_t async_td;
> -    bool async_complete;
> -
> -} OHCIState;
> -
>  /* Host Controller Communications Area */
>  struct ohci_hcca {
>      uint32_t intr[32];
> @@ -122,7 +55,6 @@ struct ohci_hcca {
>  #define ED_WBACK_OFFSET offsetof(struct ohci_ed, head)
>  #define ED_WBACK_SIZE   4
>  
> -static void ohci_bus_stop(OHCIState *ohci);
>  static void ohci_async_cancel_device(OHCIState *ohci, USBDevice *dev);
>  
>  /* Bitfields for the first word of an Endpoint Desciptor.  */
> @@ -229,16 +161,6 @@ struct ohci_iso_td {
>  #define OHCI_STATUS_OCR       (1<<3)
>  #define OHCI_STATUS_SOC       ((1<<6)|(1<<7))
>  
> -#define OHCI_INTR_SO          (1U<<0) /* Scheduling overrun */
> -#define OHCI_INTR_WD          (1U<<1) /* HcDoneHead writeback */
> -#define OHCI_INTR_SF          (1U<<2) /* Start of frame */
> -#define OHCI_INTR_RD          (1U<<3) /* Resume detect */
> -#define OHCI_INTR_UE          (1U<<4) /* Unrecoverable error */
> -#define OHCI_INTR_FNO         (1U<<5) /* Frame number overflow */
> -#define OHCI_INTR_RHSC        (1U<<6) /* Root hub status change */
> -#define OHCI_INTR_OC          (1U<<30) /* Ownership change */
> -#define OHCI_INTR_MIE         (1U<<31) /* Master Interrupt Enable */
> -
>  #define OHCI_HCCA_SIZE        0x100
>  #define OHCI_HCCA_MASK        0xffffff00
>  
> @@ -302,25 +224,9 @@ struct ohci_iso_td {
>  
>  #define OHCI_HRESET_FSBIR       (1 << 0)
>  
> -static void ohci_die(OHCIState *ohci);
> -
> -/* Update IRQ levels */
> -static inline void ohci_intr_update(OHCIState *ohci)
> +static inline void ohci_die(OHCIState *ohci)
>  {
> -    int level = 0;
> -
> -    if ((ohci->intr & OHCI_INTR_MIE) &&
> -        (ohci->intr_status & ohci->intr))
> -        level = 1;
> -
> -    qemu_set_irq(ohci->irq, level);
> -}
> -
> -/* Set an interrupt */
> -static inline void ohci_set_interrupt(OHCIState *ohci, uint32_t intr)
> -{
> -    ohci->intr_status |= intr;
> -    ohci_intr_update(ohci);
> +    ohci->ohci_die(ohci);
>  }
>  
>  /* Attach or detach a device on a root hub port.  */
> @@ -426,7 +332,7 @@ static USBDevice *ohci_find_device(OHCIState *ohci, uint8_t addr)
>      return NULL;
>  }
>  
> -static void ohci_stop_endpoints(OHCIState *ohci)
> +void ohci_stop_endpoints(OHCIState *ohci)
>  {
>      USBDevice *dev;
>      int i, j;
> @@ -498,7 +404,7 @@ static void ohci_soft_reset(OHCIState *ohci)
>      ohci->lst = OHCI_LS_THRESH;
>  }
>  
> -static void ohci_hard_reset(OHCIState *ohci)
> +void ohci_hard_reset(OHCIState *ohci)
>  {
>      ohci_soft_reset(ohci);
>      ohci->ctl = 0;
> @@ -1372,7 +1278,7 @@ static int ohci_bus_start(OHCIState *ohci)
>  }
>  
>  /* Stop sending SOF tokens on the bus */
> -static void ohci_bus_stop(OHCIState *ohci)
> +void ohci_bus_stop(OHCIState *ohci)
>  {
>      trace_usb_ohci_stop(ohci->name);
>      timer_del(ohci->eof_timer);
> @@ -1852,15 +1758,16 @@ static USBPortOps ohci_port_ops = {
>  static USBBusOps ohci_bus_ops = {
>  };
>  
> -static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
> -                          uint32_t num_ports, dma_addr_t localmem_base,
> -                          char *masterbus, uint32_t firstport,
> -                          AddressSpace *as, Error **errp)
> +void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports,
> +                   dma_addr_t localmem_base, char *masterbus,
> +                   uint32_t firstport, AddressSpace *as,
> +                   void (*ohci_die_func)(OHCIState *ohci), Error **errp)
>  {
>      Error *err = NULL;
>      int i;
>  
>      ohci->as = as;
> +    ohci->ohci_die = ohci_die_func;
>  
>      if (num_ports > OHCI_MAX_PORTS) {
>          error_setg(errp, "OHCI num-ports=%u is too big (limit is %u ports)",
> @@ -1919,85 +1826,16 @@ static void usb_ohci_init(OHCIState *ohci, DeviceState *dev,
>                                     ohci_frame_boundary, ohci);
>  }
>  
> -#define TYPE_PCI_OHCI "pci-ohci"
> -#define PCI_OHCI(obj) OBJECT_CHECK(OHCIPCIState, (obj), TYPE_PCI_OHCI)
> -
> -typedef struct {
> -    /*< private >*/
> -    PCIDevice parent_obj;
> -    /*< public >*/
> -
> -    OHCIState state;
> -    char *masterbus;
> -    uint32_t num_ports;
> -    uint32_t firstport;
> -} OHCIPCIState;
> -
> -/** A typical O/EHCI will stop operating, set itself into error state
> - * (which can be queried by MMIO) and will set PERR in its config
> - * space to signal that it got an error
> +/**
> + * A typical O/EHCI will stop operating, set itself into error state
> + * (which can be queried by MMIO) to signal that it got an error
>   */
> -static void ohci_die(OHCIState *ohci)
> +static void ohci_sysbus_die(OHCIState *ohci)
>  {
> -    OHCIPCIState *dev = container_of(ohci, OHCIPCIState, state);
> -
>      trace_usb_ohci_die();
>  
>      ohci_set_interrupt(ohci, OHCI_INTR_UE);
>      ohci_bus_stop(ohci);
> -    pci_set_word(dev->parent_obj.config + PCI_STATUS,
> -                 PCI_STATUS_DETECTED_PARITY);
> -}
> -
> -static void usb_ohci_realize_pci(PCIDevice *dev, Error **errp)
> -{
> -    Error *err = NULL;
> -    OHCIPCIState *ohci = PCI_OHCI(dev);
> -
> -    dev->config[PCI_CLASS_PROG] = 0x10; /* OHCI */
> -    dev->config[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
> -
> -    usb_ohci_init(&ohci->state, DEVICE(dev), ohci->num_ports, 0,
> -                  ohci->masterbus, ohci->firstport,
> -                  pci_get_address_space(dev), &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -        return;
> -    }
> -
> -    ohci->state.irq = pci_allocate_irq(dev);
> -    pci_register_bar(dev, 0, 0, &ohci->state.mem);
> -}
> -
> -static void usb_ohci_exit(PCIDevice *dev)
> -{
> -    OHCIPCIState *ohci = PCI_OHCI(dev);
> -    OHCIState *s = &ohci->state;
> -
> -    trace_usb_ohci_exit(s->name);
> -    ohci_bus_stop(s);
> -
> -    if (s->async_td) {
> -        usb_cancel_packet(&s->usb_packet);
> -        s->async_td = 0;
> -    }
> -    ohci_stop_endpoints(s);
> -
> -    if (!ohci->masterbus) {
> -        usb_bus_release(&s->bus);
> -    }
> -
> -    timer_del(s->eof_timer);
> -    timer_free(s->eof_timer);
> -}
> -
> -static void usb_ohci_reset_pci(DeviceState *d)
> -{
> -    PCIDevice *dev = PCI_DEVICE(d);
> -    OHCIPCIState *ohci = PCI_OHCI(dev);
> -    OHCIState *s = &ohci->state;
> -
> -    ohci_hard_reset(s);
>  }
>  
>  #define TYPE_SYSBUS_OHCI "sysbus-ohci"
> @@ -2023,7 +1861,7 @@ static void ohci_realize_pxa(DeviceState *dev, Error **errp)
>  
>      usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
>                    s->masterbus, s->firstport,
> -                  &address_space_memory, &err);
> +                  &address_space_memory, ohci_sysbus_die, &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
> @@ -2040,13 +1878,6 @@ static void usb_ohci_reset_sysbus(DeviceState *dev)
>      ohci_hard_reset(ohci);
>  }
>  
> -static Property ohci_pci_properties[] = {
> -    DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),
> -    DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),
> -    DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static const VMStateDescription vmstate_ohci_state_port = {
>      .name = "ohci-core/port",
>      .version_id = 1,
> @@ -2075,7 +1906,7 @@ static const VMStateDescription vmstate_ohci_eof_timer = {
>      },
>  };
>  
> -static const VMStateDescription vmstate_ohci_state = {
> +const VMStateDescription vmstate_ohci_state = {
>      .name = "ohci-core",
>      .version_id = 1,
>      .minimum_version_id = 1,
> @@ -2122,46 +1953,6 @@ static const VMStateDescription vmstate_ohci_state = {
>      }
>  };
>  
> -static const VMStateDescription vmstate_ohci = {
> -    .name = "ohci",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(parent_obj, OHCIPCIState),
> -        VMSTATE_STRUCT(state, OHCIPCIState, 1, vmstate_ohci_state, OHCIState),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static void ohci_pci_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> -
> -    k->realize = usb_ohci_realize_pci;
> -    k->exit = usb_ohci_exit;
> -    k->vendor_id = PCI_VENDOR_ID_APPLE;
> -    k->device_id = PCI_DEVICE_ID_APPLE_IPID_USB;
> -    k->class_id = PCI_CLASS_SERIAL_USB;
> -    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> -    dc->desc = "Apple USB Controller";
> -    dc->props = ohci_pci_properties;
> -    dc->hotpluggable = false;
> -    dc->vmsd = &vmstate_ohci;
> -    dc->reset = usb_ohci_reset_pci;
> -}
> -
> -static const TypeInfo ohci_pci_info = {
> -    .name          = TYPE_PCI_OHCI,
> -    .parent        = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(OHCIPCIState),
> -    .class_init    = ohci_pci_class_init,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    },
> -};
> -
>  static Property ohci_sysbus_properties[] = {
>      DEFINE_PROP_STRING("masterbus", OHCISysBusState, masterbus),
>      DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),
> @@ -2190,7 +1981,6 @@ static const TypeInfo ohci_sysbus_info = {
>  
>  static void ohci_register_types(void)
>  {
> -    type_register_static(&ohci_pci_info);
>      type_register_static(&ohci_sysbus_info);
>  }
>  
> diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
> new file mode 100644
> index 0000000000..481ceba7ff
> --- /dev/null
> +++ b/hw/usb/hcd-ohci.h
> @@ -0,0 +1,132 @@
> +/*
> + * QEMU USB OHCI Emulation
> + * Copyright (c) 2004 Gianni Tedesco
> + * Copyright (c) 2006 CodeSourcery
> + * Copyright (c) 2006 Openedhand Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HCD_OHCI_H
> +#define HCD_OHCI_H
> +
> +#include "sysemu/dma.h"
> +
> +/* Number of Downstream Ports on the root hub: */
> +#define OHCI_MAX_PORTS 15
> +
> +typedef struct OHCIPort {
> +    USBPort port;
> +    uint32_t ctrl;
> +} OHCIPort;
> +
> +typedef struct OHCIState {
> +    USBBus bus;
> +    qemu_irq irq;
> +    MemoryRegion mem;
> +    AddressSpace *as;
> +    uint32_t num_ports;
> +    const char *name;
> +
> +    QEMUTimer *eof_timer;
> +    int64_t sof_time;
> +
> +    /* OHCI state */
> +    /* Control partition */
> +    uint32_t ctl, status;
> +    uint32_t intr_status;
> +    uint32_t intr;
> +
> +    /* memory pointer partition */
> +    uint32_t hcca;
> +    uint32_t ctrl_head, ctrl_cur;
> +    uint32_t bulk_head, bulk_cur;
> +    uint32_t per_cur;
> +    uint32_t done;
> +    int32_t done_count;
> +
> +    /* Frame counter partition */
> +    uint16_t fsmps;
> +    uint8_t fit;
> +    uint16_t fi;
> +    uint8_t frt;
> +    uint16_t frame_number;
> +    uint16_t padding;
> +    uint32_t pstart;
> +    uint32_t lst;
> +
> +    /* Root Hub partition */
> +    uint32_t rhdesc_a, rhdesc_b;
> +    uint32_t rhstatus;
> +    OHCIPort rhport[OHCI_MAX_PORTS];
> +
> +    /* PXA27x Non-OHCI events */
> +    uint32_t hstatus;
> +    uint32_t hmask;
> +    uint32_t hreset;
> +    uint32_t htest;
> +
> +    /* SM501 local memory offset */
> +    dma_addr_t localmem_base;
> +
> +    /* Active packets.  */
> +    uint32_t old_ctl;
> +    USBPacket usb_packet;
> +    uint8_t usb_buf[8192];
> +    uint32_t async_td;
> +    bool async_complete;
> +
> +    void (*ohci_die)(struct OHCIState *ohci);
> +} OHCIState;
> +
> +extern const VMStateDescription vmstate_ohci_state;
> +
> +#define OHCI_INTR_SO          (1U << 0)   /* Scheduling overrun */
> +#define OHCI_INTR_WD          (1U << 1)   /* HcDoneHead writeback */
> +#define OHCI_INTR_SF          (1U << 2)   /* Start of frame */
> +#define OHCI_INTR_RD          (1U << 3)   /* Resume detect */
> +#define OHCI_INTR_UE          (1U << 4)   /* Unrecoverable error */
> +#define OHCI_INTR_FNO         (1U << 5)   /* Frame number overflow */
> +#define OHCI_INTR_RHSC        (1U << 6)   /* Root hub status change */
> +#define OHCI_INTR_OC          (1U << 30)  /* Ownership change */
> +#define OHCI_INTR_MIE         (1U << 31)  /* Master Interrupt Enable */
> +
> +/* Update IRQ levels */
> +static inline void ohci_intr_update(OHCIState *ohci)
> +{
> +    int level = 0;
> +
> +    if ((ohci->intr & OHCI_INTR_MIE) &&
> +        (ohci->intr_status & ohci->intr))
> +        level = 1;
> +
> +    qemu_set_irq(ohci->irq, level);
> +}
> +
> +/* Set an interrupt */
> +static inline void ohci_set_interrupt(OHCIState *ohci, uint32_t intr)
> +{
> +    ohci->intr_status |= intr;
> +    ohci_intr_update(ohci);
> +}
> +
> +void usb_ohci_init(OHCIState *ohci, DeviceState *dev, uint32_t num_ports,
> +                   dma_addr_t localmem_base, char *masterbus,
> +                   uint32_t firstport, AddressSpace *as,
> +                   void (*ohci_die_func)(OHCIState *ohci), Error **errp);
> +void ohci_hard_reset(OHCIState *ohci);
> +void ohci_bus_stop(OHCIState *ohci);
> +void ohci_stop_endpoints(OHCIState *ohci);
> +
> +#endif
> 

