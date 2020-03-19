Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B569C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E597520789
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ndt+YJRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E597520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvSY-000873-4s
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEvRT-0007Hi-EO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEvRS-0007Tg-3B
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:42:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEvRR-0007TY-VC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584625353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2aNf0xbp6H0wxrFeV7ocaqMSNmxjVyAC5poBuwcdJa8=;
 b=Ndt+YJRYWl4JsB0BM5214vmuTiZdc6MHEd0I96RZSYwOmOcgTFj6rbpeYDfdnJOfutwXX/
 PM151/xC3J3FCkOtm0xkaWBSCqsQN1RApeXKYf+yAGjiAZIDqWmwyjdPgjZnfbll92bqq9
 m/mUeEshhb85tzZML9shN+cZ10uFYRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-TcMdyWbZPHyNLeudf52R-Q-1; Thu, 19 Mar 2020 09:42:32 -0400
X-MC-Unique: TcMdyWbZPHyNLeudf52R-Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5785800D53;
 Thu, 19 Mar 2020 13:42:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CC635C219;
 Thu, 19 Mar 2020 13:42:20 +0000 (UTC)
Date: Thu, 19 Mar 2020 14:42:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 03/13] microvm: add isa-acpi device
Message-ID: <20200319144218.5d2f8fd3@redhat.com>
In-Reply-To: <20200319080117.7725-4-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-4-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 09:01:07 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Minimal ACPI device for PCI-less machines like microvm.
it seems that x86 kernel is able to boot on hw-reduced acpi systems
(but I haven't really tested any distro kernel, not sure how usable NEMU is)

Maybe reusing hw/acpi/generic_event_device.c (which was borrowed
for NEMU effort) would be better since guest won't have to initialize
not necessary interfaces and QEMU could implement simpler hw impl
compared to full ACPI with GPEs, SCIs & co.


> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/acpi/isa-acpi.c    | 114 ++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/Makefile.objs |   1 +
>  2 files changed, 115 insertions(+)
>  create mode 100644 hw/acpi/isa-acpi.c
> 
> diff --git a/hw/acpi/isa-acpi.c b/hw/acpi/isa-acpi.c
> new file mode 100644
> index 000000000000..5d7d770a5c0b
> --- /dev/null
> +++ b/hw/acpi/isa-acpi.c
> @@ -0,0 +1,114 @@
> +#include "qemu/osdep.h"
> +#include "hw/i386/pc.h"
> +#include "hw/acpi/acpi.h"
> +#include "sysemu/runstate.h"
> +
> +typedef struct ISAACPI {
> +    ISADevice base;
> +
> +    uint32_t io_base;
> +    uint16_t sci_irq;
> +    uint32_t gpe_base;
> +    uint32_t gpe_len;
> +
> +    qemu_irq irq;
> +    MemoryRegion io;
> +    ACPIREGS acpi;
> +    Notifier powerdown_req;
> +} ISAACPI;
> +
> +#define TYPE_ISA_ACPI "isa-acpi"
> +#define ISA_ACPI(obj) \
> +    OBJECT_CHECK(ISAACPI, (obj), TYPE_ISA_ACPI)
> +
> +static void isa_acpi_timer(ACPIREGS *acpi)
> +{
> +    ISAACPI *s = container_of(acpi, ISAACPI, acpi);
> +    acpi_update_sci(&s->acpi, s->irq);
> +}
> +
> +static void isa_acpi_init(Object *obj)
> +{
> +    ISAACPI *s = ISA_ACPI(obj);
> +
> +    s->io_base = 0x600;
> +    s->sci_irq = 9;
> +    s->gpe_base = 0x680;
> +    s->gpe_len = 4;
> +}
> +
> +static void isa_acpi_powerdown_req(Notifier *n, void *opaque)
> +{
> +    ISAACPI *s = container_of(n, ISAACPI, powerdown_req);
> +
> +    acpi_pm1_evt_power_down(&s->acpi);
> +}
> +
> +static void isa_acpi_add_propeties(ISAACPI *s)
> +{
> +    static const uint8_t zero;
> +
> +    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
> +                                  &zero, NULL);
> +    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
> +                                  &zero, NULL);
> +    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
> +                                   &s->gpe_base, NULL);
> +    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
> +                                   &s->gpe_len, NULL);
> +    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
> +                                   &s->sci_irq, NULL);
> +    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
> +                                   &s->io_base, NULL);
> +}
> +
> +static void isa_acpi_realize(DeviceState *dev, Error **errp)
> +{
> +    ISADevice *isa = ISA_DEVICE(dev);
> +    ISAACPI *s = ISA_ACPI(dev);
> +
> +    memory_region_init(&s->io, OBJECT(s), "isa-acpi", 64);
> +    memory_region_set_enabled(&s->io, true);
> +    isa_register_ioport(isa, &s->io, s->io_base);
> +    isa_init_irq(isa, &s->irq, s->sci_irq);
> +
> +    acpi_pm_tmr_init(&s->acpi, isa_acpi_timer, &s->io);
> +    acpi_pm1_evt_init(&s->acpi, isa_acpi_timer, &s->io);
> +    acpi_pm1_cnt_init(&s->acpi, &s->io, true, true, 0);
> +    acpi_gpe_init(&s->acpi, 4);
> +
> +    s->powerdown_req.notify = isa_acpi_powerdown_req;
> +    qemu_register_powerdown_notifier(&s->powerdown_req);
> +
> +    isa_acpi_add_propeties(s);
> +}
> +
> +static void isa_acpi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(klass);
> +
> +    dc->realize = isa_acpi_realize;
> +    dc->user_creatable = false;
> +    dc->hotpluggable = false;
> +    adevc->madt_cpu = pc_madt_cpu_entry;
> +}
> +
> +static const TypeInfo isa_acpi_info = {
> +    .name          = TYPE_ISA_ACPI,
> +    .parent        = TYPE_ISA_DEVICE,
> +    .instance_size = sizeof(ISAACPI),
> +    .instance_init = isa_acpi_init,
> +    .class_init    = isa_acpi_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_ACPI_DEVICE_IF },
> +        { }
> +    }
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&isa_acpi_info);
> +}
> +
> +type_init(register_types)
> diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
> index 777da07f4d70..aae53c73ebbd 100644
> --- a/hw/acpi/Makefile.objs
> +++ b/hw/acpi/Makefile.objs
> @@ -14,6 +14,7 @@ common-obj-$(call lnot,$(CONFIG_PC)) += acpi-x86-stub.o
>  common-obj-y += acpi_interface.o
>  common-obj-y += bios-linker-loader.o
>  common-obj-y += aml-build.o utils.o
> +common-obj-$(CONFIG_PC) += isa-acpi.o
>  common-obj-$(CONFIG_ACPI_PCI) += pci.o
>  common-obj-$(CONFIG_TPM) += tpm.o
>  


