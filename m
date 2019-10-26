Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC434CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 14:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F93C20659
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 14:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F93C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iON5t-0005NJ-IT
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 10:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iON4S-0003to-1c
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iON4O-0006Ir-1s
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iON4N-0006IH-PP
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 10:29:32 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC9734E938
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:29:29 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 4so3031482wrf.19
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 07:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VST6zQt3Q0bwGF42gd/P6zeRHDzGN8RT2c7GyTzRe6U=;
 b=CYmrtJUlXADX5kb00nUT2ULxABnd5CIUo0dEFB1IPA36zDgrauzvKHsugINwhJrIWL
 T7IwRz/+uUwH1esIgxoAVHaU81XoXtkkvkQ6FQjSfMW7ZiACphbcQE9cFZ2DzfTbZmQI
 nr6jTU01oyyoXK/MimuKJVZAK/wNHzX5Rh777CkuWHJgh18At9JPAcEsvyE0OIO5iAtt
 BEeoWWkxAQZ7H8/hNRuSaNxs9Uorsi73ogBS7N+33Uabb3Gf0LmhDsDjIsAIXC95srUk
 gZW93wZ9cjCEj1Muio2zaC1cjcFXW0VPMA0pyzpo32Q3cIYzkAtlLdYmfUkamuez/l6v
 69/Q==
X-Gm-Message-State: APjAAAVPHrFxXNVYs/+uFemU9OQ2IrICHlq42kwM0H2QUBb6WwPhogSV
 e/75h8K601CQa0aXU2tVEBE4I2CpaHvbQDcokQGV/p5lUbJZO/L7OtKrHcYx7Jjxs/i1r2Om3h+
 puVNG2M21Od+5A3s=
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr7122960wrn.24.1572100168329; 
 Sat, 26 Oct 2019 07:29:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+llsCxQMGx5J0akgOL10Y0oYU1R+NXjI1UylTeey3YJvCuAqATKAkoCkMD1kqK1lPeepieA==
X-Received: by 2002:adf:ebcb:: with SMTP id v11mr7122932wrn.24.1572100167959; 
 Sat, 26 Oct 2019 07:29:27 -0700 (PDT)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id a17sm7356120wrx.84.2019.10.26.07.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 07:29:27 -0700 (PDT)
Subject: Re: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as
 specified in datasheet
To: Li Qiang <liq3ea@gmail.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-4-philmd@redhat.com>
 <CAKXe6SJB5cqR7yq-_TDcMzWCq7UoGvq=A9kCh11tNoqYjQgp3g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2a36567-195e-f1c2-12f6-b2f10c37d933@redhat.com>
Date: Sat, 26 Oct 2019 16:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJB5cqR7yq-_TDcMzWCq7UoGvq=A9kCh11tNoqYjQgp3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 10/21/19 4:59 PM, Li Qiang wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E=20
> 2019=E5=B9=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=88=
9:52=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     From: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>=20
>     Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4
>     gpio out.
>     Remove i8259 instanciated in malta board, to not have it twice.
>=20
>     We can also remove the now unused piix4_init() function.
>=20
>     Acked-by: Michael S. Tsirkin <mst@redhat.com <mailto:mst@redhat.com=
>>
>     Acked-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
>     Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>     Message-Id: <20171216090228.28505-8-hpoussin@reactos.org
>     <mailto:20171216090228.28505-8-hpoussin@reactos.org>>
>     Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
>     <mailto:amarkovic@wavecomp.com>>
>     [PMD: rebased, updated includes, use ISA_NUM_IRQS in for loop]
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 43 ++++++++++++++=
++++++++++++++++++-----------
>      =C2=A0hw/mips/mips_malta.c | 32 +++++++++++++-------------------
>      =C2=A0include/hw/i386/pc.h |=C2=A0 1 -
>      =C2=A03 files changed, 45 insertions(+), 31 deletions(-)
>=20
>     diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>     index d0b18e0586..9c37c85ae2 100644
>     --- a/hw/isa/piix4.c
>     +++ b/hw/isa/piix4.c
>     @@ -24,6 +24,7 @@
>      =C2=A0 */
>=20
>      =C2=A0#include "qemu/osdep.h"
>     +#include "hw/irq.h"
>      =C2=A0#include "hw/i386/pc.h"
>      =C2=A0#include "hw/pci/pci.h"
>      =C2=A0#include "hw/isa/isa.h"
>     @@ -36,6 +37,8 @@ PCIDevice *piix4_dev;
>=20
>      =C2=A0typedef struct PIIX4State {
>      =C2=A0 =C2=A0 =C2=A0PCIDevice dev;
>     +=C2=A0 =C2=A0 qemu_irq cpu_intr;
>     +=C2=A0 =C2=A0 qemu_irq *isa;
>=20
>      =C2=A0 =C2=A0 =C2=A0/* Reset Control Register */
>      =C2=A0 =C2=A0 =C2=A0MemoryRegion rcr_mem;
>     @@ -94,6 +97,18 @@ static const VMStateDescription vmstate_piix4 =3D=
 {
>      =C2=A0 =C2=A0 =C2=A0}
>      =C2=A0};
>=20
>     +static void piix4_request_i8259_irq(void *opaque, int irq, int lev=
el)
>     +{
>     +=C2=A0 =C2=A0 PIIX4State *s =3D opaque;
>     +=C2=A0 =C2=A0 qemu_set_irq(s->cpu_intr, level);
>     +}
>     +
>     +static void piix4_set_i8259_irq(void *opaque, int irq, int level)
>     +{
>     +=C2=A0 =C2=A0 PIIX4State *s =3D opaque;
>     +=C2=A0 =C2=A0 qemu_set_irq(s->isa[irq], level);
>     +}
>     +
>      =C2=A0static void piix4_rcr_write(void *opaque, hwaddr addr, uint6=
4_t val,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int len)
>      =C2=A0{
>     @@ -127,29 +142,35 @@ static const MemoryRegionOps piix4_rcr_ops =3D=
 {
>      =C2=A0static void piix4_realize(PCIDevice *dev, Error **errp)
>      =C2=A0{
>      =C2=A0 =C2=A0 =C2=A0PIIX4State *s =3D PIIX4_PCI_DEVICE(dev);
>     +=C2=A0 =C2=A0 ISABus *isa_bus;
>     +=C2=A0 =C2=A0 qemu_irq *i8259_out_irq;
>=20
>     -=C2=A0 =C2=A0 if (!isa_bus_new(DEVICE(dev), pci_address_space(dev)=
,
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0pci_address_space_io(dev), errp)) {
>     +=C2=A0 =C2=A0 isa_bus =3D isa_bus_new(DEVICE(dev), pci_address_spa=
ce(dev),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 pci_address_space_io(dev), errp);
>     +=C2=A0 =C2=A0 if (!isa_bus) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>     +=C2=A0 =C2=A0 qdev_init_gpio_in_named(DEVICE(dev), piix4_set_i8259=
_irq,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "isa", ISA_NUM_IRQS);
>     +=C2=A0 =C2=A0 qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"intr", 1);
>     +
>=20
>=20
>=20
> Does the piix4 hardware has the GPIO for interrupt? Seems not.

Yes it does, you can check in the datasheet:
https://www.intel.com/Assets/PDF/datasheet/290562.pdf

Page 3 is the 'Simplified Block Diagram' you see the INTR pin.

Page 24 table "2.1.5. INTERRUPT CONTROLLER/APIC SIGNALS"

   INTR: INTERRUPT. See CPU Interface Signals.

Page 26 "2.1.6. CPU INTERFACE SIGNALS"


   CPU INTERRUPT. INTR is driven by PIIX4 to signal the CPU that
   an interrupt request is pending and needs to be serviced. It
   is asynchronous with respect to SYSCLK or PCICLK and is always
   an output. The interrupt controller must be programmed following
   PCIRST# to ensure that INTR is at a known state.

>=20
>      =C2=A0 =C2=A0 =C2=A0memory_region_init_io(&s->rcr_mem, OBJECT(dev)=
, &piix4_rcr_ops, s,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"reset-control", 1);
>      =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_overlap(pci_addres=
s_space_io(dev),
>     0xcf9,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&s->rcr_mem, 1);
>=20
>     +=C2=A0 =C2=A0 /* initialize i8259 pic */
>     +=C2=A0 =C2=A0 i8259_out_irq =3D qemu_allocate_irqs(piix4_request_i=
8259_irq, s, 1);
>     +=C2=A0 =C2=A0 s->isa =3D i8259_init(isa_bus, *i8259_out_irq);
>=20
>=20
> In i8259_init, we also allocate 16 input line and 1 output line.
> Seems it is duplicated with the GPIO allocation in previous.

No, this is different, here we don't allocate the 16 i8259
INPUT lines, we allocate 1 input IRQ and pass it to the
i8259_init function which uses it as its OUTPUT line.

IOW:

* i8259
   - 16 INPUT (from ISA devices)
   - 1 OUTPUT (to PIIX)

* PIIX
   - 1 INPUT (from i8259)
   - 1 OUTPUT (to CPU, on the Malta board: CPU IRQ2)

> Also
> Maybe here can uses
> i8259(isa_bus, qemu_allocate_irq(piix4_request_i8259_irq, s, 0));
>=20
>     +
>     +=C2=A0 =C2=A0 /* initialize ISA irqs */
>     +=C2=A0 =C2=A0 isa_bus_irqs(isa_bus, s->isa);
>     +
>      =C2=A0 =C2=A0 =C2=A0piix4_dev =3D dev;
>      =C2=A0}
>=20
>     -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
>     -{
>     -=C2=A0 =C2=A0 PCIDevice *d;
>     -
>     -=C2=A0 =C2=A0 d =3D pci_create_simple_multifunction(bus, devfn, tr=
ue, "PIIX4");
>     -=C2=A0 =C2=A0 *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(d), "=
isa.0"));
>     -=C2=A0 =C2=A0 return d->devfn;
>     -}
>     -
>      =C2=A0static void piix4_class_init(ObjectClass *klass, void *data)
>      =C2=A0{
>      =C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);
>     diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>     index 4d9c64b36a..7d25ab6c23 100644
>     --- a/hw/mips/mips_malta.c
>     +++ b/hw/mips/mips_malta.c
>     @@ -97,7 +97,7 @@ typedef struct {
>      =C2=A0 =C2=A0 =C2=A0SysBusDevice parent_obj;
>=20
>      =C2=A0 =C2=A0 =C2=A0MIPSCPSState cps;
>     -=C2=A0 =C2=A0 qemu_irq *i8259;
>     +=C2=A0 =C2=A0 qemu_irq i8259[16];
>      =C2=A0} MaltaState;
>=20
>      =C2=A0static ISADevice *pit;
>     @@ -1235,8 +1235,8 @@ void mips_malta_init(MachineState *machine)
>      =C2=A0 =C2=A0 =C2=A0int64_t kernel_entry, bootloader_run_addr;
>      =C2=A0 =C2=A0 =C2=A0PCIBus *pci_bus;
>      =C2=A0 =C2=A0 =C2=A0ISABus *isa_bus;
>     -=C2=A0 =C2=A0 qemu_irq *isa_irq;
>      =C2=A0 =C2=A0 =C2=A0qemu_irq cbus_irq, i8259_irq;
>     +=C2=A0 =C2=A0 PCIDevice *pci;
>      =C2=A0 =C2=A0 =C2=A0int piix4_devfn;
>      =C2=A0 =C2=A0 =C2=A0I2CBus *smbus;
>      =C2=A0 =C2=A0 =C2=A0DriveInfo *dinfo;
>     @@ -1407,30 +1407,24 @@ void mips_malta_init(MachineState *machine)
>      =C2=A0 =C2=A0 =C2=A0/* Board ID =3D 0x420 (Malta Board with CoreLV=
) */
>      =C2=A0 =C2=A0 =C2=A0stl_p(memory_region_get_ram_ptr(bios_copy) + 0=
x10, 0x00000420);
>=20
>     -=C2=A0 =C2=A0 /*
>     -=C2=A0 =C2=A0 =C2=A0* We have a circular dependency problem: pci_b=
us depends on
>     isa_irq,
>     -=C2=A0 =C2=A0 =C2=A0* isa_irq is provided by i8259, i8259 depends =
on ISA, ISA depends
>     -=C2=A0 =C2=A0 =C2=A0* on piix4, and piix4 depends on pci_bus.=C2=A0=
 To stop the cycle
>     we have
>     -=C2=A0 =C2=A0 =C2=A0* qemu_irq_proxy() adds an extra bit of indire=
ction, allowing us
>     -=C2=A0 =C2=A0 =C2=A0* to resolve the isa_irq -> i8259 dependency a=
fter i8259 is
>     initialized.
>     -=C2=A0 =C2=A0 =C2=A0*/
>     -=C2=A0 =C2=A0 isa_irq =3D qemu_irq_proxy(&s->i8259, 16);
>     -
>      =C2=A0 =C2=A0 =C2=A0/* Northbridge */
>     -=C2=A0 =C2=A0 pci_bus =3D gt64120_register(isa_irq);
>     +=C2=A0 =C2=A0 pci_bus =3D gt64120_register(s->i8259);
>=20
>      =C2=A0 =C2=A0 =C2=A0/* Southbridge */
>      =C2=A0 =C2=A0 =C2=A0ide_drive_get(hd, ARRAY_SIZE(hd));
>=20
>     -=C2=A0 =C2=A0 piix4_devfn =3D piix4_init(pci_bus, &isa_bus, 80);
>     +=C2=A0 =C2=A0 pci =3D pci_create_simple_multifunction(pci_bus, PCI=
_DEVFN(10, 0),
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 true, "PIIX4");
>     +=C2=A0 =C2=A0 dev =3D DEVICE(pci);
>     +=C2=A0 =C2=A0 isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0")=
);
>     +=C2=A0 =C2=A0 piix4_devfn =3D pci->devfn;
>=20
>     -=C2=A0 =C2=A0 /*
>     -=C2=A0 =C2=A0 =C2=A0* Interrupt controller
>     -=C2=A0 =C2=A0 =C2=A0* The 8259 is attached to the MIPS CPU INT0 pi=
n, ie interrupt 2
>     -=C2=A0 =C2=A0 =C2=A0*/
>     -=C2=A0 =C2=A0 s->i8259 =3D i8259_init(isa_bus, i8259_irq);
>     +=C2=A0 =C2=A0 /* Interrupt controller */
>     +=C2=A0 =C2=A0 qdev_connect_gpio_out_named(dev, "intr", 0, i8259_ir=
q);
>     +=C2=A0 =C2=A0 for (int i =3D 0; i < ISA_NUM_IRQS; i++) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->i8259[i] =3D qdev_get_gpio_in_named=
(dev, "isa", i);
>     +=C2=A0 =C2=A0 }
>=20
>=20
> Also here s->i8259 and the piix4 isa point to the same input line. Seem=
s=20
> duplicated.

'i8259_irq' might be misnamed, it is initialized as the CPU INPUT IRQ:

   mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);

Then we connect the ISA PIC OUTPUT IRQ to the CPU INPUT IRQ:

   qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);

Earlier, we created the GT64120 with an array of OUTPUT IRQs:

   pci_bus =3D gt64120_register(s->i8259);

Here we connect the GT64120 OUTPUT IRQs from the PCI bus to
be INPUT of the ISA PIC:

   for (int i =3D 0; i < ISA_NUM_IRQS; i++) {
       s->i8259[i] =3D qdev_get_gpio_in_named(dev, "isa", i);
   }

There were the previously used 'proxy-irq'. Now the circular
problem is resolved:

/*
  * We have a circular dependency problem: pci_bus depends on isa_irq,
  * isa_irq is provided by i8259, i8259 depends on ISA, ISA depends
  * on piix4, and piix4 depends on pci_bus.  To stop the cycle we have
  * qemu_irq_proxy() adds an extra bit of indirection, allowing us
  * to resolve the isa_irq -> i8259 dependency after i8259 is
  * initialized.
  */

Future plan is to remove the X86 dependency on the i8259 PIC,
then we'll be able to improve the GT64120 model and simplify
how IRQs are connected.

> I have come up with a more cleaner patch as following:
>=20
> Though 'i8259_init' is called in the mips_malta_init. But is uses the=20
> isa bus from piix4 device.
> And seems it's more clean.
> You can test it with more tests.

You can test with:

$ make mips{,64}{,el}-softmmu/all
$ make check-venv
$ AVOCADO_TIMEOUT_EXPECTED=3D1 \
   tests/venv/bin/avocado \
     --show=3Dapp,ssh,console \
     run \
       -t arch:mips \
       -t arch:mipsel \
       -t arch:mips64 \
       -t arch:mips64el \
     tests/acceptance/

Regards,

Phil.

> Author: Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>>
> Date: =C2=A0 Mon Oct 21 22:41:17 2019 +0800
>=20
>  =C2=A0 =C2=A0 piix4
>=20
> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index d0b18e0586..66a041040a 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -24,6 +24,7 @@
>  =C2=A0 */
>=20
>  =C2=A0#include "qemu/osdep.h"
> +#include "hw/irq.h"
>  =C2=A0#include "hw/i386/pc.h"
>  =C2=A0#include "hw/pci/pci.h"
>  =C2=A0#include "hw/isa/isa.h"
> @@ -46,6 +47,7 @@ typedef struct PIIX4State {
>  =C2=A0#define PIIX4_PCI_DEVICE(obj) \
>  =C2=A0 =C2=A0 =C2=A0OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEV=
ICE)
>=20
> +
>  =C2=A0static void piix4_isa_reset(DeviceState *dev)
>  =C2=A0{
>  =C2=A0 =C2=A0 =C2=A0PIIX4State *d =3D PIIX4_PCI_DEVICE(dev);
> @@ -141,14 +143,6 @@ static void piix4_realize(PCIDevice *dev, Error **=
errp)
>  =C2=A0 =C2=A0 =C2=A0piix4_dev =3D dev;
>  =C2=A0}
>=20
> -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
> -{
> - =C2=A0 =C2=A0PCIDevice *d;
> -
> - =C2=A0 =C2=A0d =3D pci_create_simple_multifunction(bus, devfn, true, =
"PIIX4");
> - =C2=A0 =C2=A0*isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(d), "isa.=
0"));
> - =C2=A0 =C2=A0return d->devfn;
> -}
>=20
>  =C2=A0static void piix4_class_init(ObjectClass *klass, void *data)
>  =C2=A0{
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4d9c64b36a..420e0e9e80 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -28,6 +28,7 @@
>  =C2=A0#include "cpu.h"
>  =C2=A0#include "hw/i386/pc.h"
>  =C2=A0#include "hw/isa/superio.h"
> +//#include "hw/isa/piix4.h"
>  =C2=A0#include "hw/dma/i8257.h"
>  =C2=A0#include "hw/char/serial.h"
>  =C2=A0#include "net/net.h"
> @@ -97,7 +98,7 @@ typedef struct {
>  =C2=A0 =C2=A0 =C2=A0SysBusDevice parent_obj;
>=20
>  =C2=A0 =C2=A0 =C2=A0MIPSCPSState cps;
> - =C2=A0 =C2=A0qemu_irq *i8259;
> + =C2=A0 =C2=A0qemu_irq i8259[ISA_NUM_IRQS];
>  =C2=A0} MaltaState;
>=20
>  =C2=A0static ISADevice *pit;
> @@ -1235,8 +1236,9 @@ void mips_malta_init(MachineState *machine)
>  =C2=A0 =C2=A0 =C2=A0int64_t kernel_entry, bootloader_run_addr;
>  =C2=A0 =C2=A0 =C2=A0PCIBus *pci_bus;
>  =C2=A0 =C2=A0 =C2=A0ISABus *isa_bus;
> - =C2=A0 =C2=A0qemu_irq *isa_irq;
>  =C2=A0 =C2=A0 =C2=A0qemu_irq cbus_irq, i8259_irq;
> + =C2=A0 =C2=A0qemu_irq *i8259;
> + =C2=A0 =C2=A0PCIDevice *pci;
>  =C2=A0 =C2=A0 =C2=A0int piix4_devfn;
>  =C2=A0 =C2=A0 =C2=A0I2CBus *smbus;
>  =C2=A0 =C2=A0 =C2=A0DriveInfo *dinfo;
> @@ -1407,29 +1409,24 @@ void mips_malta_init(MachineState *machine)
>  =C2=A0 =C2=A0 =C2=A0/* Board ID =3D 0x420 (Malta Board with CoreLV) */
>  =C2=A0 =C2=A0 =C2=A0stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10,=
 0x00000420);
>=20
> - =C2=A0 =C2=A0/*
> - =C2=A0 =C2=A0 * We have a circular dependency problem: pci_bus depend=
s on isa_irq,
> - =C2=A0 =C2=A0 * isa_irq is provided by i8259, i8259 depends on ISA, I=
SA depends
> - =C2=A0 =C2=A0 * on piix4, and piix4 depends on pci_bus.=C2=A0 To stop=
 the cycle we have
> - =C2=A0 =C2=A0 * qemu_irq_proxy() adds an extra bit of indirection, al=
lowing us
> - =C2=A0 =C2=A0 * to resolve the isa_irq -> i8259 dependency after i825=
9 is=20
> initialized.
> - =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0isa_irq =3D qemu_irq_proxy(&s->i8259, 16);
> -
>  =C2=A0 =C2=A0 =C2=A0/* Northbridge */
> - =C2=A0 =C2=A0pci_bus =3D gt64120_register(isa_irq);
> + =C2=A0 =C2=A0pci_bus =3D gt64120_register(s->i8259);
>=20
>  =C2=A0 =C2=A0 =C2=A0/* Southbridge */
>  =C2=A0 =C2=A0 =C2=A0ide_drive_get(hd, ARRAY_SIZE(hd));
>=20
> - =C2=A0 =C2=A0piix4_devfn =3D piix4_init(pci_bus, &isa_bus, 80);
> + =C2=A0 =C2=A0pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEV=
FN(10, 0),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0true, "PIIX4");
> + =C2=A0 =C2=A0dev =3D DEVICE(pci);
> + =C2=A0 =C2=A0isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> + =C2=A0 =C2=A0piix4_devfn =3D pci->devfn;
>=20
> - =C2=A0 =C2=A0/*
> - =C2=A0 =C2=A0 * Interrupt controller
> - =C2=A0 =C2=A0 * The 8259 is attached to the MIPS CPU INT0 pin, ie int=
errupt 2
> - =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0s->i8259 =3D i8259_init(isa_bus, i8259_irq);
>=20
> + =C2=A0 =C2=A0i8259 =3D i8259_init(isa_bus, i8259_irq);
> + =C2=A0 =C2=A0for (int i =3D 0; i < ISA_NUM_IRQS; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0s->i8259[i] =3D i8259[i];
> + =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0g_free(i8259);
>  =C2=A0 =C2=A0 =C2=A0isa_bus_irqs(isa_bus, s->i8259);
>  =C2=A0 =C2=A0 =C2=A0pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
>  =C2=A0 =C2=A0 =C2=A0pci_create_simple(pci_bus, piix4_devfn + 2, "piix4=
-usb-uhci");
>=20
>     -=C2=A0 =C2=A0 isa_bus_irqs(isa_bus, s->i8259);
>      =C2=A0 =C2=A0 =C2=A0pci_piix4_ide_init(pci_bus, hd, piix4_devfn + =
1);
>      =C2=A0 =C2=A0 =C2=A0pci_create_simple(pci_bus, piix4_devfn + 2, "p=
iix4-usb-uhci");
>      =C2=A0 =C2=A0 =C2=A0smbus =3D piix4_pm_init(pci_bus, piix4_devfn +=
 3, 0x1100,
>     diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>     index 37bfd95113..374f3e8835 100644
>     --- a/include/hw/i386/pc.h
>     +++ b/include/hw/i386/pc.h
>     @@ -286,7 +286,6 @@ PCIBus *i440fx_init(const char *host_type, cons=
t
>     char *pci_type,
>      =C2=A0PCIBus *find_i440fx(void);
>      =C2=A0/* piix4.c */
>      =C2=A0extern PCIDevice *piix4_dev;
>     -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
>=20
>      =C2=A0/* pc_sysfw.c */
>      =C2=A0void pc_system_flash_create(PCMachineState *pcms);
>     --=20
>     2.21.0
>=20
>=20

