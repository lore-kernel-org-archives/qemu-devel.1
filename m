Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE86C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D48121726
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D48121726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43521 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCQot-0003Vr-7V
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:31:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hCQnX-00030k-9s
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hCQnP-0006ig-BG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:30:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hCQmz-0005mW-Cf
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:30:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id h39so7860350qte.2
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 08:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=7BRwe0rDl/gTtfUItdR8qVa61uETp+c8nDE3GBv+t4U=;
	b=ttpk92nvFSiVbkztX1A6FOFYwwSukdmkL2+PE5vOttEfClBejCfNK2OBJ7Ci4BYo5q
	+FiGJPsCotZFCHc14g2o5PPrCIglAlTmbomiC2VEII993zVta3FP93L26B2Dm1Xjbvlq
	+x7Mst88WQjUEa3rDgZFkHBcqa0FwE//tDiRMrJmH7Ty3jTYhL6NSz/xRxz9288fVTD2
	lmhKhvXB5/1BbH3Xiyk+qPSNH535OQf2pMHhk7axiMAqjwnbOFp/Oyy8wcD2dZ9dSCZF
	mKf529GAOj6fw6Y0xUuyp+YcAZ9rEQyqPktgo5LvnEB8DDr9r6dl87kCGTt2WszbIqf4
	3w+w==
X-Gm-Message-State: APjAAAXJRkYsh+UaQyt+Bglj/rckDI2T61V0awCdfCCIBAol/btJPQN9
	nMWExAGevL0tDNWqNnsNRdYzmyKh8i5P75fGIzYb2g==
X-Google-Smtp-Source: APXvYqxKNB02ZTC1IyctKko3cx55Mo0F6l4o49dO5iBJz4siMWWwgbLa0tCHxz1vzOz3pHuvOUN3CUwRx/E6bAxQcJo=
X-Received: by 2002:aed:3aaa:: with SMTP id o39mr11706903qte.100.1554478195392;
	Fri, 05 Apr 2019 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <1554097196-9434-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1554097196-9434-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Apr 2019 17:29:43 +0200
Message-ID:
 <CAMxuvazVFBM0jEGsK=fXNovh6En+jp_Z96cUmXVG132kjuBtQA@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
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
	Miroslav Rezanina <mrezanin@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405152943.LRI8g6ra7TP3yekvaPCRHTEsiw8ephD05xJUAVuDgKQ@z>

Hi

On Mon, Apr 1, 2019 at 7:40 AM Thomas Huth <thuth@redhat.com> wrote:
>
> In our downstream distribution of QEMU, we'd like to ship the binary
> without the multi-serial PCI devices. To make this disablement easier,
> let's move the devices into a separate file and add a proper Kconfig-
> switch for these devices.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  I've forgot to Cc: qemu-devel when I sent this yesterday, so sorry if
>  you've got this mail twice.
>
>  hw/char/Kconfig            |   6 ++
>  hw/char/Makefile.objs      |   1 +
>  hw/char/serial-pci-multi.c | 208 +++++++++++++++++++++++++++++++++++++++=
++++++
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
> @@ -7,6 +7,7 @@ common-obj-$(CONFIG_PL011) +=3D pl011.o
>  common-obj-$(CONFIG_SERIAL) +=3D serial.o
>  common-obj-$(CONFIG_SERIAL_ISA) +=3D serial-isa.o
>  common-obj-$(CONFIG_SERIAL_PCI) +=3D serial-pci.o
> +common-obj-$(CONFIG_SERIAL_PCI_MULTI) +=3D serial-pci-multi.o
>  common-obj-$(CONFIG_VIRTIO_SERIAL) +=3D virtio-console.o
>  common-obj-$(CONFIG_XILINX) +=3D xilinx_uartlite.o
>  common-obj-$(CONFIG_XEN) +=3D xen_console.o
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
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
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
> +    PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, dev=
);
> +    SerialState *s;
> +    int i;
> +
> +    for (i =3D 0; i < pci->ports; i++) {
> +        s =3D pci->state + i;
> +        serial_exit_core(s);
> +        memory_region_del_subregion(&pci->iobar, &s->io);
> +        g_free(pci->name[i]);
> +    }
> +    qemu_free_irqs(pci->irqs, pci->ports);
> +}
> +
> +static void multi_serial_irq_mux(void *opaque, int n, int level)
> +{
> +    PCIMultiSerialState *pci =3D opaque;
> +    int i, pending =3D 0;
> +
> +    pci->level[n] =3D level;
> +    for (i =3D 0; i < pci->ports; i++) {
> +        if (pci->level[i]) {
> +            pending =3D 1;
> +        }
> +    }
> +    pci_set_irq(&pci->dev, pending);
> +}
> +
> +static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
> +{
> +    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
> +    PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, dev=
);
> +    SerialState *s;
> +    Error *err =3D NULL;
> +    int i, nr_ports =3D 0;
> +
> +    switch (pc->device_id) {
> +    case 0x0003:
> +        nr_ports =3D 2;
> +        break;
> +    case 0x0004:
> +        nr_ports =3D 4;
> +        break;
> +    }
> +    assert(nr_ports > 0);
> +    assert(nr_ports <=3D PCI_SERIAL_MAX_PORTS);
> +
> +    pci->dev.config[PCI_CLASS_PROG] =3D pci->prog_if;
> +    pci->dev.config[PCI_INTERRUPT_PIN] =3D 0x01;
> +    memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nr_p=
orts);
> +    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->ioba=
r);
> +    pci->irqs =3D qemu_allocate_irqs(multi_serial_irq_mux, pci,
> +                                   nr_ports);
> +
> +    for (i =3D 0; i < nr_ports; i++) {
> +        s =3D pci->state + i;
> +        s->baudbase =3D 115200;
> +        serial_realize_core(s, &err);
> +        if (err !=3D NULL) {
> +            error_propagate(errp, err);
> +            multi_serial_pci_exit(dev);
> +            return;
> +        }
> +        s->irq =3D pci->irqs[i];
> +        pci->name[i] =3D g_strdup_printf("uart #%d", i + 1);
> +        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
> +                              pci->name[i], 8);
> +        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
> +        pci->ports++;
> +    }
> +}
> +
> +static const VMStateDescription vmstate_pci_multi_serial =3D {
> +    .name =3D "pci-serial-multi",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(dev, PCIMultiSerialState),
> +        VMSTATE_STRUCT_ARRAY(state, PCIMultiSerialState, PCI_SERIAL_MAX_=
PORTS,
> +                             0, vmstate_serial, SerialState),
> +        VMSTATE_UINT32_ARRAY(level, PCIMultiSerialState, PCI_SERIAL_MAX_=
PORTS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static Property multi_2x_serial_pci_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
> +    DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
> +    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static Property multi_4x_serial_pci_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
> +    DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
> +    DEFINE_PROP_CHR("chardev3",  PCIMultiSerialState, state[2].chr),
> +    DEFINE_PROP_CHR("chardev4",  PCIMultiSerialState, state[3].chr),
> +    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *d=
ata)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
> +    pc->realize =3D multi_serial_pci_realize;
> +    pc->exit =3D multi_serial_pci_exit;
> +    pc->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> +    pc->device_id =3D PCI_DEVICE_ID_REDHAT_SERIAL2;
> +    pc->revision =3D 1;
> +    pc->class_id =3D PCI_CLASS_COMMUNICATION_SERIAL;
> +    dc->vmsd =3D &vmstate_pci_multi_serial;
> +    dc->props =3D multi_2x_serial_pci_properties;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *d=
ata)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
> +    pc->realize =3D multi_serial_pci_realize;
> +    pc->exit =3D multi_serial_pci_exit;
> +    pc->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> +    pc->device_id =3D PCI_DEVICE_ID_REDHAT_SERIAL4;
> +    pc->revision =3D 1;
> +    pc->class_id =3D PCI_CLASS_COMMUNICATION_SERIAL;
> +    dc->vmsd =3D &vmstate_pci_multi_serial;
> +    dc->props =3D multi_4x_serial_pci_properties;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +}
> +
> +static const TypeInfo multi_2x_serial_pci_info =3D {
> +    .name          =3D "pci-serial-2x",
> +    .parent        =3D TYPE_PCI_DEVICE,
> +    .instance_size =3D sizeof(PCIMultiSerialState),
> +    .class_init    =3D multi_2x_serial_pci_class_initfn,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { },
> +    },
> +};
> +
> +static const TypeInfo multi_4x_serial_pci_info =3D {
> +    .name          =3D "pci-serial-4x",
> +    .parent        =3D TYPE_PCI_DEVICE,
> +    .instance_size =3D sizeof(PCIMultiSerialState),
> +    .class_init    =3D multi_4x_serial_pci_class_initfn,
> +    .interfaces =3D (InterfaceInfo[]) {
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
> @@ -72,64 +58,6 @@ static void serial_pci_realize(PCIDevice *dev, Error *=
*errp)
>      pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
>  }
>
> -static void multi_serial_irq_mux(void *opaque, int n, int level)
> -{
> -    PCIMultiSerialState *pci =3D opaque;
> -    int i, pending =3D 0;
> -
> -    pci->level[n] =3D level;
> -    for (i =3D 0; i < pci->ports; i++) {
> -        if (pci->level[i]) {
> -            pending =3D 1;
> -        }
> -    }
> -    pci_set_irq(&pci->dev, pending);
> -}
> -
> -static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
> -{
> -    PCIDeviceClass *pc =3D PCI_DEVICE_GET_CLASS(dev);
> -    PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, dev=
);
> -    SerialState *s;
> -    Error *err =3D NULL;
> -    int i, nr_ports =3D 0;
> -
> -    switch (pc->device_id) {
> -    case 0x0003:
> -        nr_ports =3D 2;
> -        break;
> -    case 0x0004:
> -        nr_ports =3D 4;
> -        break;
> -    }
> -    assert(nr_ports > 0);
> -    assert(nr_ports <=3D PCI_SERIAL_MAX_PORTS);
> -
> -    pci->dev.config[PCI_CLASS_PROG] =3D pci->prog_if;
> -    pci->dev.config[PCI_INTERRUPT_PIN] =3D 0x01;
> -    memory_region_init(&pci->iobar, OBJECT(pci), "multiserial", 8 * nr_p=
orts);
> -    pci_register_bar(&pci->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->ioba=
r);
> -    pci->irqs =3D qemu_allocate_irqs(multi_serial_irq_mux, pci,
> -                                   nr_ports);
> -
> -    for (i =3D 0; i < nr_ports; i++) {
> -        s =3D pci->state + i;
> -        s->baudbase =3D 115200;
> -        serial_realize_core(s, &err);
> -        if (err !=3D NULL) {
> -            error_propagate(errp, err);
> -            multi_serial_pci_exit(dev);
> -            return;
> -        }
> -        s->irq =3D pci->irqs[i];
> -        pci->name[i] =3D g_strdup_printf("uart #%d", i+1);
> -        memory_region_init_io(&s->io, OBJECT(pci), &serial_io_ops, s,
> -                              pci->name[i], 8);
> -        memory_region_add_subregion(&pci->iobar, 8 * i, &s->io);
> -        pci->ports++;
> -    }
> -}
> -
>  static void serial_pci_exit(PCIDevice *dev)
>  {
>      PCISerialState *pci =3D DO_UPCAST(PCISerialState, dev, dev);
> @@ -139,21 +67,6 @@ static void serial_pci_exit(PCIDevice *dev)
>      qemu_free_irq(s->irq);
>  }
>
> -static void multi_serial_pci_exit(PCIDevice *dev)
> -{
> -    PCIMultiSerialState *pci =3D DO_UPCAST(PCIMultiSerialState, dev, dev=
);
> -    SerialState *s;
> -    int i;
> -
> -    for (i =3D 0; i < pci->ports; i++) {
> -        s =3D pci->state + i;
> -        serial_exit_core(s);
> -        memory_region_del_subregion(&pci->iobar, &s->io);
> -        g_free(pci->name[i]);
> -    }
> -    qemu_free_irqs(pci->irqs, pci->ports);
> -}
> -
>  static const VMStateDescription vmstate_pci_serial =3D {
>      .name =3D "pci-serial",
>      .version_id =3D 1,
> @@ -165,41 +78,12 @@ static const VMStateDescription vmstate_pci_serial =
=3D {
>      }
>  };
>
> -static const VMStateDescription vmstate_pci_multi_serial =3D {
> -    .name =3D "pci-serial-multi",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(dev, PCIMultiSerialState),
> -        VMSTATE_STRUCT_ARRAY(state, PCIMultiSerialState, PCI_SERIAL_MAX_=
PORTS,
> -                             0, vmstate_serial, SerialState),
> -        VMSTATE_UINT32_ARRAY(level, PCIMultiSerialState, PCI_SERIAL_MAX_=
PORTS),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>  static Property serial_pci_properties[] =3D {
>      DEFINE_PROP_CHR("chardev",  PCISerialState, state.chr),
>      DEFINE_PROP_UINT8("prog_if",  PCISerialState, prog_if, 0x02),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> -static Property multi_2x_serial_pci_properties[] =3D {
> -    DEFINE_PROP_CHR("chardev1",  PCIMultiSerialState, state[0].chr),
> -    DEFINE_PROP_CHR("chardev2",  PCIMultiSerialState, state[1].chr),
> -    DEFINE_PROP_UINT8("prog_if",  PCIMultiSerialState, prog_if, 0x02),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static Property multi_4x_serial_pci_properties[] =3D {
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
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -215,36 +99,6 @@ static void serial_pci_class_initfn(ObjectClass *klas=
s, void *data)
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>
> -static void multi_2x_serial_pci_class_initfn(ObjectClass *klass, void *d=
ata)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
> -    pc->realize =3D multi_serial_pci_realize;
> -    pc->exit =3D multi_serial_pci_exit;
> -    pc->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> -    pc->device_id =3D PCI_DEVICE_ID_REDHAT_SERIAL2;
> -    pc->revision =3D 1;
> -    pc->class_id =3D PCI_CLASS_COMMUNICATION_SERIAL;
> -    dc->vmsd =3D &vmstate_pci_multi_serial;
> -    dc->props =3D multi_2x_serial_pci_properties;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -}
> -
> -static void multi_4x_serial_pci_class_initfn(ObjectClass *klass, void *d=
ata)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    PCIDeviceClass *pc =3D PCI_DEVICE_CLASS(klass);
> -    pc->realize =3D multi_serial_pci_realize;
> -    pc->exit =3D multi_serial_pci_exit;
> -    pc->vendor_id =3D PCI_VENDOR_ID_REDHAT;
> -    pc->device_id =3D PCI_DEVICE_ID_REDHAT_SERIAL4;
> -    pc->revision =3D 1;
> -    pc->class_id =3D PCI_CLASS_COMMUNICATION_SERIAL;
> -    dc->vmsd =3D &vmstate_pci_multi_serial;
> -    dc->props =3D multi_4x_serial_pci_properties;
> -    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> -}
> -
>  static const TypeInfo serial_pci_info =3D {
>      .name          =3D "pci-serial",
>      .parent        =3D TYPE_PCI_DEVICE,
> @@ -256,33 +110,9 @@ static const TypeInfo serial_pci_info =3D {
>      },
>  };
>
> -static const TypeInfo multi_2x_serial_pci_info =3D {
> -    .name          =3D "pci-serial-2x",
> -    .parent        =3D TYPE_PCI_DEVICE,
> -    .instance_size =3D sizeof(PCIMultiSerialState),
> -    .class_init    =3D multi_2x_serial_pci_class_initfn,
> -    .interfaces =3D (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> -    },
> -};
> -
> -static const TypeInfo multi_4x_serial_pci_info =3D {
> -    .name          =3D "pci-serial-4x",
> -    .parent        =3D TYPE_PCI_DEVICE,
> -    .instance_size =3D sizeof(PCIMultiSerialState),
> -    .class_init    =3D multi_4x_serial_pci_class_initfn,
> -    .interfaces =3D (InterfaceInfo[]) {
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
> --
> 1.8.3.1
>

