Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A5C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EFF21726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EFF21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQyM-0000y6-Fk
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:41:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQxN-0000TA-9l
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCQxK-0002So-Ir
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:40:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCQxI-0002Cl-Il
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:40:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so10006994wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 08:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gIiL8dZoY0uYnlGla3GpL6lEU/vJXmMcboJ94OV0uiA=;
	b=OrJYdtC/QEg0eV+Gwkkm5btvj3ICy88p70wQz9ZZphy10/ZAZ8YztkDIn5XlRVYVku
	9WjPKGCf9TUItWKW9A7dC9Zug0ZqE2m0psGyRFVGqvrGJakVLZIp/+cl5MN2LbOWeBL9
	8cfuWKAro0oNjKkT66ndvm+waC4SX8i8SP85DMYty6HspZlWyIIlGlKbnCnhGC67ptoA
	duRYCydavRaahtKZikyBKjmlGHeyPHuTZE83mz07dxO7Ek6YtSwcKsupNDYaqrJebVXg
	96V8p4HxGbizT+KorSSeYhUGCZeLMMaRvdeJYB4z8i/CYXsPm+PQPm0F/KRxQGw+H8Rz
	QUZQ==
X-Gm-Message-State: APjAAAWIWfl/xE6HUIlhytXt0w+4twqpX4yrie66jQVcQ3s38ArbbS4d
	HNq5QiwFVd2GSlsNWATGElo5udQiSrA=
X-Google-Smtp-Source: APXvYqyV8qvlXqmqoOrxsTX07hJscNMKdZIupc3KFWzeGulRzC4/O2tDBqxNKykKtktf18XXx8Loaw==
X-Received: by 2002:a1c:e185:: with SMTP id y127mr7694591wmg.76.1554478830103; 
	Fri, 05 Apr 2019 08:40:30 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id a8sm3787816wmf.33.2019.04.05.08.40.29
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 08:40:29 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
References: <1554097196-9434-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <15bdf547-8714-021c-a3e2-3cb3af24b88c@redhat.com>
Date: Fri, 5 Apr 2019 17:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554097196-9434-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] hw/char: Move multi-serial devices into
 separate file
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Miroslav Rezanina <mrezanin@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405154028.hKWYStPHo_eAiBfYK70dfykqs20GO91evDSbMLKfwLA@z>

On 4/1/19 7:39 AM, Thomas Huth wrote:
> In our downstream distribution of QEMU, we'd like to ship the binary
> without the multi-serial PCI devices. To make this disablement easier,
> let's move the devices into a separate file and add a proper Kconfig-
> switch for these devices.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  I've forgot to Cc: qemu-devel when I sent this yesterday, so sorry if
>  you've got this mail twice.
> 
>  hw/char/Kconfig            |   6 ++
>  hw/char/Makefile.objs      |   1 +
>  hw/char/serial-pci-multi.c | 208 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/char/serial-pci.c       | 170 ------------------------------------
>  4 files changed, 215 insertions(+), 170 deletions(-)
>  create mode 100644 hw/char/serial-pci-multi.c
> 
> diff --git a/hw/char/Kconfig b/hw/char/Kconfig
> index 6360c9f..40e7a8b 100644
> --- a/hw/char/Kconfig
> +++ b/hw/char/Kconfig
> @@ -24,6 +24,12 @@ config SERIAL_PCI
>      depends on PCI
>      select SERIAL
>  
> +config SERIAL_PCI_MULTI
> +    bool
> +    default y if PCI_DEVICES
> +    depends on PCI
> +    select SERIAL
> +
>  config VIRTIO_SERIAL
>      bool
>      default y
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index cf086e7..02d8a66 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_PL011) += pl011.o
>  common-obj-$(CONFIG_SERIAL) += serial.o
>  common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
>  common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
> +common-obj-$(CONFIG_SERIAL_PCI_MULTI) += serial-pci-multi.o
>  common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
>  common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
>  common-obj-$(CONFIG_XEN) += xen_console.o
> diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
> new file mode 100644
> index 0000000..63dcbaa
> --- /dev/null
> +++ b/hw/char/serial-pci-multi.c
> @@ -0,0 +1,208 @@
> +/*
> + * QEMU 16550A multi UART emulation
> + *
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + * Copyright (c) 2008 Citrix Systems, Inc.
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
> +
> +/* see docs/specs/pci-serial.txt */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/char/serial.h"
> +#include "hw/pci/pci.h"
> +
> +#define PCI_SERIAL_MAX_PORTS 4
> +
> +typedef struct PCIMultiSerialState {
> +    PCIDevice    dev;
> +    MemoryRegion iobar;
> +    uint32_t     ports;
> +    char         *name[PCI_SERIAL_MAX_PORTS];
> +    SerialState  state[PCI_SERIAL_MAX_PORTS];
> +    uint32_t     level[PCI_SERIAL_MAX_PORTS];
> +    qemu_irq     *irqs;
> +    uint8_t      prog_if;
> +} PCIMultiSerialState;
> +
> +static void multi_serial_pci_exit(PCIDevice *dev)
> +{
> +    PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
> +    SerialState *s;
> +    int i;
> +
> +    for (i = 0; i < pci->ports; i++) {
> +        s = pci->state + i;
> +        serial_exit_core(s);
> +        memory_region_del_subregion(&pci->iobar, &s->io);
> +        g_free(pci->name[i]);
> +    }
> +    qemu_free_irqs(pci->irqs, pci->ports);
> +}
> +
> +static void multi_serial_irq_mux(void *opaque, int n, int level)
> +{
> +    PCIMultiSerialState *pci = opaque;
> +    int i, pending = 0;
> +
> +    pci->level[n] = level;
> +    for (i = 0; i < pci->ports; i++) {
> +        if (pci->level[i]) {
> +            pending = 1;
> +        }
> +    }
> +    pci_set_irq(&pci->dev, pending);
> +}
> +
> +static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
> +    PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
> +    SerialState *s;
> +    Error *err = NULL;
> +    int i, nr_ports = 0;
> +
> +    switch (pc->device_id) {
> +    case 0x0003:
> +        nr_ports = 2;
> +        break;
> +    case 0x0004:
> +        nr_ports = 4;
> +        break;
> +    }
> +    assert(nr_ports > 0);
> +    assert(nr_ports <= PCI_SERIAL_MAX_PORTS);
> +
> +    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
> +    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
> +    memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nr_ports);
> +    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->iobar);
> +    pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci,
> +                                   nr_ports);
> +
> +    for (i = 0; i < nr_ports; i++) {
> +        s = pci->state + i;
> +        s->baudbase = 115200;
> +        serial_realize_core(s, &err);
> +        if (err != NULL) {
> +            error_propagate(errp, err);
> +            multi_serial_pci_exit(dev);
> +            return;
> +        }
> +        s->irq = pci->irqs[i];
> +        pci->name[i] = g_strdup_printf("uart #%d", i + 1);
> +        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
> +                              pci->name[i], 8);
> +        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
> +        pci->ports++;
> +    }
> +}
> +
> +static const VMStateDescription vmstate_pci_multi_serial = {
> +    .name = "pci-serial-multi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, PCIMultiSerialState),
> +        VMSTATE_STRUCT_ARRAY(state, PCIMultiSerialState, PCI_SERIAL_MAX_PORTS,
> +                             0, vmstate_serial, SerialState),
> +        VMSTATE_UINT32_ARRAY(level, PCIMultiSerialState, PCI_SERIAL_MAX_PORTS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property multi_2x_serial_pci_properties[] = {
> +    DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
> +    DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
> +    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static Property multi_4x_serial_pci_properties[] = {
> +    DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
> +    DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
> +    DEFINE_PROP_CHR("chardev3",  PCIMultiSerialState, state[2].chr),
> +    DEFINE_PROP_CHR("chardev4",  PCIMultiSerialState, state[3].chr),
> +    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> +    pc->realize = multi_serial_pci_realize;
> +    pc->exit = multi_serial_pci_exit;
> +    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    pc->device_id = PCI_DEVICE_ID_REDHAT_SERIAL2;
> +    pc->revision = 1;
> +    pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
> +    dc->vmsd = &vmstate_pci_multi_serial;
> +    dc->props = multi_2x_serial_pci_properties;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> +    pc->realize = multi_serial_pci_realize;
> +    pc->exit = multi_serial_pci_exit;
> +    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    pc->device_id = PCI_DEVICE_ID_REDHAT_SERIAL4;
> +    pc->revision = 1;
> +    pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
> +    dc->vmsd = &vmstate_pci_multi_serial;
> +    dc->props = multi_4x_serial_pci_properties;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static const TypeInfo multi_2x_serial_pci_info = {
> +    .name          = "pci-serial-2x",
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(PCIMultiSerialState),
> +    .class_init    = multi_2x_serial_pci_class_initfn,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static const TypeInfo multi_4x_serial_pci_info = {
> +    .name          = "pci-serial-4x",
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(PCIMultiSerialState),
> +    .class_init    = multi_4x_serial_pci_class_initfn,
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static void multi_serial_pci_register_types(void)
> +{
> +    type_register_static(&multi_2x_serial_pci_info);
> +    type_register_static(&multi_4x_serial_pci_info);
> +}
> +
> +type_init(multi_serial_pci_register_types)
> diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
> index cb0d04c..2d5ffae 100644
> --- a/hw/char/serial-pci.c
> +++ b/hw/char/serial-pci.c
> @@ -30,26 +30,12 @@
>  #include "hw/char/serial.h"
>  #include "hw/pci/pci.h"
>  
> -#define PCI_SERIAL_MAX_PORTS 4
> -
>  typedef struct PCISerialState {
>      PCIDevice dev;
>      SerialState state;
>      uint8_t prog_if;
>  } PCISerialState;
>  
> -typedef struct PCIMultiSerialState {
> -    PCIDevice    dev;
> -    MemoryRegion iobar;
> -    uint32_t     ports;
> -    char         *name[PCI_SERIAL_MAX_PORTS];
> -    SerialState  state[PCI_SERIAL_MAX_PORTS];
> -    uint32_t     level[PCI_SERIAL_MAX_PORTS];
> -    qemu_irq     *irqs;
> -    uint8_t      prog_if;
> -} PCIMultiSerialState;
> -
> -static void multi_serial_pci_exit(PCIDevice *dev);
>  
>  static void serial_pci_realize(PCIDevice *dev, Error **errp)
>  {
> @@ -72,64 +58,6 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
>      pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
>  }
>  
> -static void multi_serial_irq_mux(void *opaque, int n, int level)
> -{
> -    PCIMultiSerialState *pci = opaque;
> -    int i, pending = 0;
> -
> -    pci->level[n] = level;
> -    for (i = 0; i < pci->ports; i++) {
> -        if (pci->level[i]) {
> -            pending = 1;
> -        }
> -    }
> -    pci_set_irq(&pci->dev, pending);
> -}
> -
> -static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
> -{
> -    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
> -    PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
> -    SerialState *s;
> -    Error *err = NULL;
> -    int i, nr_ports = 0;
> -
> -    switch (pc->device_id) {
> -    case 0x0003:
> -        nr_ports = 2;
> -        break;
> -    case 0x0004:
> -        nr_ports = 4;
> -        break;
> -    }
> -    assert(nr_ports > 0);
> -    assert(nr_ports <= PCI_SERIAL_MAX_PORTS);
> -
> -    pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
> -    pci->dev.config[PCI_INTERRUPT_PIN] = 0x01;
> -    memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nr_ports);
> -    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->iobar);
> -    pci->irqs = qemu_allocate_irqs(multi_serial_irq_mux, pci,
> -                                   nr_ports);
> -
> -    for (i = 0; i < nr_ports; i++) {
> -        s = pci->state + i;
> -        s->baudbase = 115200;
> -        serial_realize_core(s, &err);
> -        if (err != NULL) {
> -            error_propagate(errp, err);
> -            multi_serial_pci_exit(dev);
> -            return;
> -        }
> -        s->irq = pci->irqs[i];
> -        pci->name[i] = g_strdup_printf("uart #%d", i+1);
> -        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
> -                              pci->name[i], 8);
> -        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
> -        pci->ports++;
> -    }
> -}
> -
>  static void serial_pci_exit(PCIDevice *dev)
>  {
>      PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
> @@ -139,21 +67,6 @@ static void serial_pci_exit(PCIDevice *dev)
>      qemu_free_irq(s->irq);
>  }
>  
> -static void multi_serial_pci_exit(PCIDevice *dev)
> -{
> -    PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
> -    SerialState *s;
> -    int i;
> -
> -    for (i = 0; i < pci->ports; i++) {
> -        s = pci->state + i;
> -        serial_exit_core(s);
> -        memory_region_del_subregion(&pci->iobar, &s->io);
> -        g_free(pci->name[i]);
> -    }
> -    qemu_free_irqs(pci->irqs, pci->ports);
> -}
> -
>  static const VMStateDescription vmstate_pci_serial = {
>      .name = "pci-serial",
>      .version_id = 1,
> @@ -165,41 +78,12 @@ static const VMStateDescription vmstate_pci_serial = {
>      }
>  };
>  
> -static const VMStateDescription vmstate_pci_multi_serial = {
> -    .name = "pci-serial-multi",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(dev, PCIMultiSerialState),
> -        VMSTATE_STRUCT_ARRAY(state, PCIMultiSerialState, PCI_SERIAL_MAX_PORTS,
> -                             0, vmstate_serial, SerialState),
> -        VMSTATE_UINT32_ARRAY(level, PCIMultiSerialState, PCI_SERIAL_MAX_PORTS),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>  static Property serial_pci_properties[] = {
>      DEFINE_PROP_CHR("chardev",  PCISerialState, state.chr),
>      DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static Property multi_2x_serial_pci_properties[] = {
> -    DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
> -    DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
> -    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static Property multi_4x_serial_pci_properties[] = {
> -    DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
> -    DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
> -    DEFINE_PROP_CHR("chardev3",  PCIMultiSerialState, state[2].chr),
> -    DEFINE_PROP_CHR("chardev4",  PCIMultiSerialState, state[3].chr),
> -    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void serial_pci_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -215,36 +99,6 @@ static void serial_pci_class_initfn(ObjectClass *klass, void *data)
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>  
> -static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> -    pc->realize = multi_serial_pci_realize;
> -    pc->exit = multi_serial_pci_exit;
> -    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
> -    pc->device_id = PCI_DEVICE_ID_REDHAT_SERIAL2;
> -    pc->revision = 1;
> -    pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
> -    dc->vmsd = &vmstate_pci_multi_serial;
> -    dc->props = multi_2x_serial_pci_properties;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -}
> -
> -static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
> -    pc->realize = multi_serial_pci_realize;
> -    pc->exit = multi_serial_pci_exit;
> -    pc->vendor_id = PCI_VENDOR_ID_REDHAT;
> -    pc->device_id = PCI_DEVICE_ID_REDHAT_SERIAL4;
> -    pc->revision = 1;
> -    pc->class_id = PCI_CLASS_COMMUNICATION_SERIAL;
> -    dc->vmsd = &vmstate_pci_multi_serial;
> -    dc->props = multi_4x_serial_pci_properties;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -}
> -
>  static const TypeInfo serial_pci_info = {
>      .name          = "pci-serial",
>      .parent        = TYPE_PCI_DEVICE,
> @@ -256,33 +110,9 @@ static const TypeInfo serial_pci_info = {
>      },
>  };
>  
> -static const TypeInfo multi_2x_serial_pci_info = {
> -    .name          = "pci-serial-2x",
> -    .parent        = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(PCIMultiSerialState),
> -    .class_init    = multi_2x_serial_pci_class_initfn,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    },
> -};
> -
> -static const TypeInfo multi_4x_serial_pci_info = {
> -    .name          = "pci-serial-4x",
> -    .parent        = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(PCIMultiSerialState),
> -    .class_init    = multi_4x_serial_pci_class_initfn,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    },
> -};
> -
>  static void serial_pci_register_types(void)
>  {
>      type_register_static(&serial_pci_info);
> -    type_register_static(&multi_2x_serial_pci_info);
> -    type_register_static(&multi_4x_serial_pci_info);
>  }
>  
>  type_init(serial_pci_register_types)
> 

