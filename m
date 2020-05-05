Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5327C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6328420675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH+114iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6328420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzAE-0005Ph-JP
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVz8A-0003ww-6u
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:05:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jVz83-0003VT-80
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588691101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBQH+ztcGk1a9scrWZ0fR9yJJUQmOKpCoPSCWHrDOwk=;
 b=WH+114iD/T3lzGkPS/q4rTmQv4L+3wJawhcjdSFL26G/sqRKnR2evr7mBlSl6oJ40VWKwK
 aT76BOZ1Fn0adcz7Iyvm+I3OKr8IQ+aNcKGs1WBia7Pu8lYlValm2wKgQTrN3+033ZHEwe
 b0rEYL/B/PbtLedBdhFXp0X8X780EDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-fQptCKV_PmGEGVLM_PhjdQ-1; Tue, 05 May 2020 11:03:36 -0400
X-MC-Unique: fQptCKV_PmGEGVLM_PhjdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23DB0100CCC1;
 Tue,  5 May 2020 15:03:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C1BE5D9D5;
 Tue,  5 May 2020 15:03:18 +0000 (UTC)
Date: Tue, 5 May 2020 17:03:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 08/13] acpi: generic event device for x86
Message-ID: <20200505170316.7e72da4d@redhat.com>
In-Reply-To: <20200505134305.22666-9-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-9-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 15:43:00 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Uses TYPE_ACPI_GED as QOM parent for code reuse.
> Add registers for sleep states and reset.
> Add powerdown notifier for power button events.
registers aren't x86 specific per spec,
can we put these registers into TYPE_ACPI_GED
and enable the optionally like is done with memory hotplug registers
in acpi_ged_initfn()

> Set AcpiDeviceIfClass->madt_cpu.
that's the only reason I could justify adding x86 specific flavour.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/acpi/generic_event_device.h |  10 +++
>  hw/i386/generic_event_device_x86.c     | 114 +++++++++++++++++++++++++
>  hw/i386/Makefile.objs                  |   1 +
>  3 files changed, 125 insertions(+)
>  create mode 100644 hw/i386/generic_event_device_x86.c
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 9eb86ca4fd94..16d1f2b3cd30 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -68,9 +68,19 @@
>  #define ACPI_GED(obj) \
>      OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
>  
> +#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
> +#define ACPI_GED_X86(obj) \
> +    OBJECT_CHECK(AcpiGedX86State, (obj), TYPE_ACPI_GED_X86)
> +
>  #define ACPI_GED_EVT_SEL_OFFSET    0x0
>  #define ACPI_GED_EVT_SEL_LEN       0x4
>  
> +#define ACPI_GED_X86_REG_SLEEP_CTL 0x00
> +#define ACPI_GED_X86_REG_SLEEP_STS 0x01
> +#define ACPI_GED_X86_REG_RESET     0x02
> +#define   ACPI_GED_X86_RESET_VALUE 0x42
> +#define ACPI_GED_X86_REG_COUNT     0x03
> +
>  #define GED_DEVICE      "GED"
>  #define AML_GED_EVT_REG "EREG"
>  #define AML_GED_EVT_SEL "ESEL"
> diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_device_x86.c
> new file mode 100644
> index 000000000000..8ae4a63084f3
> --- /dev/null
> +++ b/hw/i386/generic_event_device_x86.c
> @@ -0,0 +1,114 @@
> +/*
> + * x86 variant of the generic event device for hw reduced acpi
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/i386/pc.h"
> +#include "hw/irq.h"
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/runstate.h"
> +
> +typedef struct AcpiGedX86State {
> +    struct AcpiGedState parent_obj;
> +    MemoryRegion regs;
> +    Notifier powerdown_req;
> +} AcpiGedX86State;
> +
> +static uint64_t acpi_ged_x86_regs_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void acpi_ged_x86_regs_write(void *opaque, hwaddr addr, uint64_t data,
> +                                    unsigned int size)
> +{
> +    bool slp_en;
> +    int slp_typ;
> +
> +    switch (addr) {
> +    case ACPI_GED_X86_REG_SLEEP_CTL:
> +        slp_typ = (data >> 2) & 0x07;
> +        slp_en  = (data >> 5) & 0x01;
> +        if (slp_en && slp_typ == 5) {
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        }
> +        return;
> +    case ACPI_GED_X86_REG_SLEEP_STS:
> +        return;
> +    case ACPI_GED_X86_REG_RESET:
> +        if (data == ACPI_GED_X86_RESET_VALUE) {
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        }
> +        return;
> +    }
> +}
> +
> +static const MemoryRegionOps acpi_ged_x86_regs_ops = {
> +    .read = acpi_ged_x86_regs_read,
> +    .write = acpi_ged_x86_regs_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +};
> +
> +static void acpi_ged_x86_powerdown_req(Notifier *n, void *opaque)
> +{
> +    AcpiGedX86State *s = container_of(n, AcpiGedX86State, powerdown_req);
> +    AcpiDeviceIf *adev = ACPI_DEVICE_IF(s);
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(OBJECT(s));
> +
> +    adevc->send_event(adev, ACPI_POWER_DOWN_STATUS);
> +}
> +
> +static void acpi_ged_x86_initfn(Object *obj)
> +{
> +    AcpiGedX86State *s = ACPI_GED_X86(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->regs, obj, &acpi_ged_x86_regs_ops,
> +                          obj, "acpi-regs", ACPI_GED_X86_REG_COUNT);
> +    sysbus_init_mmio(sbd, &s->regs);
> +
> +    s->powerdown_req.notify = acpi_ged_x86_powerdown_req;
> +    qemu_register_powerdown_notifier(&s->powerdown_req);
> +}
> +
> +static void acpi_ged_x86_class_init(ObjectClass *class, void *data)
> +{
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
> +
> +    adevc->madt_cpu = pc_madt_cpu_entry;
> +}
> +
> +static const TypeInfo acpi_ged_x86_info = {
> +    .name          = TYPE_ACPI_GED_X86,
> +    .parent        = TYPE_ACPI_GED,
> +    .instance_size = sizeof(AcpiGedX86State),
> +    .instance_init  = acpi_ged_x86_initfn,
> +    .class_init    = acpi_ged_x86_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { TYPE_ACPI_DEVICE_IF },
> +        { }
> +    }
> +};
> +
> +static void acpi_ged_x86_register_types(void)
> +{
> +    type_register_static(&acpi_ged_x86_info);
> +}
> +
> +type_init(acpi_ged_x86_register_types)
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 6abc74551a72..622739305882 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -17,4 +17,5 @@ obj-$(CONFIG_PC) += port92.o
>  
>  obj-y += kvmvapic.o
>  obj-$(CONFIG_ACPI) += acpi-common.o
> +obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device_x86.o
>  obj-$(CONFIG_PC) += acpi-build.o


