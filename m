Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B88CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF72218AE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF72218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqPz-0002Sf-N8
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMqOi-0001TD-8G
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMqOf-0000Zv-US
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMqOd-0000Yq-VP
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:24:09 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 605443DE31
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:24:05 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 7so8898377wrl.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rmHRiSQ0xYIbBclsLjP0Mqrc4vkxuAKZyulQhyvaCqg=;
 b=jDqxmIsBwuhUQ/Sjrlcd/7IPfULbY4YnZghwIzmY/nZp6H19Xl3nbW3X2tS7WwsQ9f
 gt0hmEm53gqPnXEyiX4hWLzMlo63TdZa/HIPxQbOyZBzAQGuo2OQ14l1I+8Ci6AoC3qt
 rqBEALIAynd1a8NilCDmwwhnGRds6rpwgGtA++CusiRWwaloitq+YOKwEcH0jpsRogo6
 g+YdxF0JyUlxeeX/Tvuid+h0Hpi9NZQiy3EholSsPlTzuRwBG1olcy3h5P8+DaBcSd9C
 iXAEF3KU3mchyV1J2gbBLoN6Sgd27gThTQy36mXetMjEHag3Uzlq+nd60kR6Oe2/Cc+J
 DxoQ==
X-Gm-Message-State: APjAAAWaNc7rrUst0AbWIiYbMLv8BkjZ5oC4jV/Gu1D2wDtANzcuWD/M
 QMkXdLTQJI3HoIDQwu7wptsUsyzRIrNXU+arzP9vDO1zduj/5wv2PtPiwpq2uQ3yLHj9aEa7hWV
 FA6FHFk2eieayF7E=
X-Received: by 2002:a5d:464f:: with SMTP id j15mr2536856wrs.366.1571736244006; 
 Tue, 22 Oct 2019 02:24:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6+LTfBJsmV0uFtg+3S1k9JHp13p9zJxiEM3J7f0kaOCDBKejyDNHQNL4aWdF8GL20BLrilg==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr2536810wrs.366.1571736243564; 
 Tue, 22 Oct 2019 02:24:03 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id c8sm4043291wml.44.2019.10.22.02.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 02:24:03 -0700 (PDT)
Subject: Re: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as
 specified in datasheet
To: Esteban Bosse <estebanbosse@gmail.com>, qemu-devel@nongnu.org
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-4-philmd@redhat.com>
 <b1255a22fe4409244f7a68887137fbe43b71a08d.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7861a0c5-fcc5-2e39-a403-0165d5809158@redhat.com>
Date: Tue, 22 Oct 2019 11:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b1255a22fe4409244f7a68887137fbe43b71a08d.camel@gmail.com>
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
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 10:48 AM, Esteban Bosse wrote:
> El vie, 18-10-2019 a las 15:47 +0200, Philippe Mathieu-Daud=C3=A9 escri=
bi=C3=B3:
>> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>
>> Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4
>> gpio out.
>> Remove i8259 instanciated in malta board, to not have it twice.
>>
>> We can also remove the now unused piix4_init() function.
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>> Message-Id: <20171216090228.28505-8-hpoussin@reactos.org>
>> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> [PMD: rebased, updated includes, use ISA_NUM_IRQS in for loop]
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   hw/isa/piix4.c       | 43 ++++++++++++++++++++++++++++++++--------
>> ---
>>   hw/mips/mips_malta.c | 32 +++++++++++++-------------------
>>   include/hw/i386/pc.h |  1 -
>>   3 files changed, 45 insertions(+), 31 deletions(-)
>>
>> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>> index d0b18e0586..9c37c85ae2 100644
>> --- a/hw/isa/piix4.c
>> +++ b/hw/isa/piix4.c
>> @@ -24,6 +24,7 @@
>>    */
>>  =20
>>   #include "qemu/osdep.h"
>> +#include "hw/irq.h"
>>   #include "hw/i386/pc.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/isa/isa.h"
>> @@ -36,6 +37,8 @@ PCIDevice *piix4_dev;
>>  =20
>>   typedef struct PIIX4State {
>>       PCIDevice dev;
>> +    qemu_irq cpu_intr;
>> +    qemu_irq *isa;
>>  =20
>>       /* Reset Control Register */
>>       MemoryRegion rcr_mem;
>> @@ -94,6 +97,18 @@ static const VMStateDescription vmstate_piix4 =3D {
>>       }
>>   };
>>  =20
>> +static void piix4_request_i8259_irq(void *opaque, int irq, int
>> level)
>> +{
>> +    PIIX4State *s =3D opaque;
>> +    qemu_set_irq(s->cpu_intr, level);
>> +}
> I would like to understand why in `PIIX4State *s =3D opaque;` its not
> necessary a cast or a object macro magic.
> Something like:
> PIIX4State *s =3D (PIIX4State*)opaque;
> PIIX4State *s =3D PIIX4STATE(opaque);

I guess you mean:

#define PIIX4_PCI_DEVICE(obj) \
     OBJECT_CHECK(PIIX4State, (obj), TYPE_PIIX4_PCI_DEVICE)

IIUC the OBJECT_CHECK(STATE, OBJ, TYPE) macro verify the QEMU Object
OBJ is of the correct type TYPE, then cast it as a pointer to STATE.
This has some runtime cost.

This is useful when you deal with some child Object which is not TYPE
but inheritate TYPE from a parent, or if the object is an abstract
parent and you want to use its children TYPE implementations.

In piix4_realize(), the function piix4_request_i8259_irq() is registered=20
by qemu_allocate_irqs() as a handler with 's' as opaque pointer, and we
already know 's' is of type PIIX4State, so using OBJECT_CHECK() is not
necessary.

>> +
>> +static void piix4_set_i8259_irq(void *opaque, int irq, int level)
>> +{
>> +    PIIX4State *s =3D opaque;
>> +    qemu_set_irq(s->isa[irq], level);
>> +}
>> +
>>   static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
>>                               unsigned int len)
>>   {
>> @@ -127,29 +142,35 @@ static const MemoryRegionOps piix4_rcr_ops =3D {
>>   static void piix4_realize(PCIDevice *dev, Error **errp)
>>   {
>>       PIIX4State *s =3D PIIX4_PCI_DEVICE(dev);
>> +    ISABus *isa_bus;
>> +    qemu_irq *i8259_out_irq;
>>  =20
>> -    if (!isa_bus_new(DEVICE(dev), pci_address_space(dev),
>> -                     pci_address_space_io(dev), errp)) {
>> +    isa_bus =3D isa_bus_new(DEVICE(dev), pci_address_space(dev),
>> +                          pci_address_space_io(dev), errp);
>> +    if (!isa_bus) {
>>           return;
>>       }
>>  =20
>> +    qdev_init_gpio_in_named(DEVICE(dev), piix4_set_i8259_irq,
>> +                            "isa", ISA_NUM_IRQS);
>> +    qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
>> +                             "intr", 1);
>> +
>>       memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops,
>> s,
>>                             "reset-control", 1);
>>       memory_region_add_subregion_overlap(pci_address_space_io(dev),
>> 0xcf9,
>>                                           &s->rcr_mem, 1);
>>  =20
>> +    /* initialize i8259 pic */
>> +    i8259_out_irq =3D qemu_allocate_irqs(piix4_request_i8259_irq, s,
>> 1);
>> +    s->isa =3D i8259_init(isa_bus, *i8259_out_irq);
>> +
>> +    /* initialize ISA irqs */
>> +    isa_bus_irqs(isa_bus, s->isa);
>> +
>>       piix4_dev =3D dev;
>>   }
>>  =20
>> -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
>> -{
>> -    PCIDevice *d;
>> -
>> -    d =3D pci_create_simple_multifunction(bus, devfn, true, "PIIX4");
>> -    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(d), "isa.0"));
>> -    return d->devfn;
>> -}
>> -
>>   static void piix4_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index 4d9c64b36a..7d25ab6c23 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -97,7 +97,7 @@ typedef struct {
>>       SysBusDevice parent_obj;
>>  =20
>>       MIPSCPSState cps;
>> -    qemu_irq *i8259;
>> +    qemu_irq i8259[16];
>>   } MaltaState;
>>  =20
>>   static ISADevice *pit;
>> @@ -1235,8 +1235,8 @@ void mips_malta_init(MachineState *machine)
>>       int64_t kernel_entry, bootloader_run_addr;
>>       PCIBus *pci_bus;
>>       ISABus *isa_bus;
>> -    qemu_irq *isa_irq;
>>       qemu_irq cbus_irq, i8259_irq;
>> +    PCIDevice *pci;
>>       int piix4_devfn;
>>       I2CBus *smbus;
>>       DriveInfo *dinfo;
>> @@ -1407,30 +1407,24 @@ void mips_malta_init(MachineState *machine)
>>       /* Board ID =3D 0x420 (Malta Board with CoreLV) */
>>       stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10, 0x00000420);
>>  =20
>> -    /*
>> -     * We have a circular dependency problem: pci_bus depends on
>> isa_irq,
>> -     * isa_irq is provided by i8259, i8259 depends on ISA, ISA
>> depends
>> -     * on piix4, and piix4 depends on pci_bus.  To stop the cycle we
>> have
>> -     * qemu_irq_proxy() adds an extra bit of indirection, allowing
>> us
>> -     * to resolve the isa_irq -> i8259 dependency after i8259 is
>> initialized.
>> -     */
>> -    isa_irq =3D qemu_irq_proxy(&s->i8259, 16);
>> -
>>       /* Northbridge */
>> -    pci_bus =3D gt64120_register(isa_irq);
>> +    pci_bus =3D gt64120_register(s->i8259);
>>  =20
>>       /* Southbridge */
>>       ide_drive_get(hd, ARRAY_SIZE(hd));
>>  =20
>> -    piix4_devfn =3D piix4_init(pci_bus, &isa_bus, 80);
>> +    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0)=
,
>> +                                          true, "PIIX4");
>> +    dev =3D DEVICE(pci);
>> +    isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>> +    piix4_devfn =3D pci->devfn;
>>  =20
>> -    /*
>> -     * Interrupt controller
>> -     * The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2
>> -     */
>> -    s->i8259 =3D i8259_init(isa_bus, i8259_irq);
>> +    /* Interrupt controller */
>> +    qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
>> +    for (int i =3D 0; i < ISA_NUM_IRQS; i++) {
>> +        s->i8259[i] =3D qdev_get_gpio_in_named(dev, "isa", i);
>> +    }
>>  =20
>> -    isa_bus_irqs(isa_bus, s->i8259);
>>       pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
>>       pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
>>       smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 37bfd95113..374f3e8835 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -286,7 +286,6 @@ PCIBus *i440fx_init(const char *host_type, const
>> char *pci_type,
>>   PCIBus *find_i440fx(void);
>>   /* piix4.c */
>>   extern PCIDevice *piix4_dev;
>> -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
>>  =20
>>   /* pc_sysfw.c */
>>   void pc_system_flash_create(PCMachineState *pcms);
>=20

