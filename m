Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B65CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB9E205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB9E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqaI-0001RS-R7
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMqZa-0000ky-0j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMqZX-0007Se-QZ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:35:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMqZX-0007SK-Hw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:35:23 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 459715AFE9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:35:22 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id g67so5618846wmg.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 02:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q4R2Ov/Xp5E4k4igkbd5xhkfk2aRC2fc67pDccCS7m0=;
 b=tq3aDnoYGBa6fOj4CJ07JZngBVX7DIc+1RoJhTimFGf+QkLm5gb+uVcqcnqXLyzEE4
 U8DRx3uKA6T2mOmkvtMAuvgK8ptUfwiqcz1o0aijOTFrfk0OT0tqABgp+1oAHK5CF+Xj
 c5nqzJYzIFXpGkWlxZkJFKsKt4P0tJbE/XBlRYxC3D2oYyho2r9GKRro/pnBB5M27TfP
 yu3uv0Ml1VopHgEDhBacwLoQsTv5s9m1uZ8k2omXZX8uEtIQKc4jd/tHT5Wyu1Q+QYGh
 UrdeJjmDMoCClKJ/q1bCPvNcSqJCDOtaq0t1bQKXW00mP6PCxbxjCFM0DWjrkzjwgO05
 otZg==
X-Gm-Message-State: APjAAAVCiR/gWoPGGGlRc3Lk1NFgkFyYrgyWfyw7xCLLAqtSUaiyhSFD
 M/y6gR7wzVLnIbL4R++tmqQ8xB58syaDOzFOeH+ohlRbMI0OAwY4JD0jxq04k8I+oBNf8NhnbII
 nfDAJ8CNavKH/o+M=
X-Received: by 2002:a05:600c:294c:: with SMTP id
 n12mr1977427wmd.99.1571736920901; 
 Tue, 22 Oct 2019 02:35:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpGF7VloquicJHVFeMrdv3kwO9dg2gB4D3XRbnC4l7Qd/Px1IoU/AE+aEkO8imxmLww76lDQ==
X-Received: by 2002:a05:600c:294c:: with SMTP id
 n12mr1977394wmd.99.1571736920561; 
 Tue, 22 Oct 2019 02:35:20 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id d11sm20550317wrf.80.2019.10.22.02.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 02:35:19 -0700 (PDT)
Subject: Re: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as
 specified in datasheet
To: Esteban Bosse <estebanbosse@gmail.com>, qemu-devel@nongnu.org
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-4-philmd@redhat.com>
 <27c31440fdab11eff969e656a8ad7063c5e7234c.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2e3e8cd0-8dbf-46c8-b1d1-e9e3d20f6336@redhat.com>
Date: Tue, 22 Oct 2019 11:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <27c31440fdab11eff969e656a8ad7063c5e7234c.camel@gmail.com>
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

On 10/22/19 10:44 AM, Esteban Bosse wrote:
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
> My question is not about this patch:
>=20
> The function name is "qdev_init_gpio_out_named" but support more than 1
> gpio, right? in this case, the name shouldn't be something like
> "qdev_init_gpios_out_named"?

Indeed devices can have various IRQ output lines.

Note, QEMU does not intend to model full devices, but only the
part required to run a guest. If a guest doesn't use some part
of a device, QEMU will likely not model it.

For example, sometimes a device can have N output IRQ to signal
various error conditions, which are usually used by specific
firmwares in embedded devices. QEMU might not model embedded
boards using this device but we can find it in a generic machine
which runs a full operating system. So far these OS don't care
about handling these errors, so QEMU will only model the IRQ
line required to run the OS, no more. This is on purpose.

Now about the naming, I have no preference which form is better.

>> +
>>       memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops,
>> s,
>>                             "reset-control", 1);
>>       memory_region_add_subregion_overlap(pci_address_space_io(dev),
>> 0xcf9,
>>                                           &s->rcr_mem, 1);
> Why do you use the priority 1 in this case?
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

16 -> ISA_NUM_IRQS

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

