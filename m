Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C55C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493F0206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 13:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493F0206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i82MX-0003TQ-2X
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 09:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1i82L2-0002W8-61
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1i82L1-0008P6-2y
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 09:07:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1i82Kx-0008NZ-Jc; Wed, 11 Sep 2019 09:07:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9445F3082E03;
 Wed, 11 Sep 2019 13:07:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E74AD10018F8;
 Wed, 11 Sep 2019 13:07:01 +0000 (UTC)
Date: Wed, 11 Sep 2019 15:07:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190911150700.7a917d14@redhat.com>
In-Reply-To: <20190904085629.13872-6-shameerali.kolothum.thodi@huawei.com>
References: <20190904085629.13872-1-shameerali.kolothum.thodi@huawei.com>
 <20190904085629.13872-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 11 Sep 2019 13:07:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v10 05/11] hw/arm/virt: Enable
 device memory cold/hot plug with ACPI boot
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, shannon.zhaosl@gmail.com,
 ard.biesheuvel@linaro.org, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 09:56:23 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

[...]
> @@ -730,6 +733,19 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                        vms->highmem, vms->highmem_ecam);
>      acpi_dsdt_add_gpio(scope, &memmap[VIRT_GPIO],
>                         (irqmap[VIRT_GPIO] + ARM_SPI_BASE));
> +    if (vms->acpi_dev) {
> +        build_ged_aml(scope, "\\_SB."GED_DEVICE,
> +                      HOTPLUG_HANDLER(vms->acpi_dev),
> +                      irqmap[VIRT_ACPI_GED] + ARM_SPI_BASE, AML_SYSTEM_MEMORY,
> +                      memmap[VIRT_ACPI_GED].base);
> +    }
> +
> +    if (vms->acpi_dev && ms->ram_slots) {
> +        build_memory_hotplug_aml(scope, ms->ram_slots, "\\_SB", NULL,
> +                                 AML_SYSTEM_MEMORY,
> +                                 memmap[VIRT_PCDIMM_ACPI].base);
> +    }
one more thing (though non critical), if ms->ram_slots == 0 ^^^^
makes IASL spew a warning

    External (_SB_.MHPC.MSCN, MethodObj)    // Warning: Unknown method, guessing 0 arguments

In general non-existing references within methods are fine if they aren't ever used.
however we can be a little bit less sloppy.
Below you advertise "event = ACPI_GED_MEM_HOTPLUG_EVT", and then here suddenly
don't generate essential AML part for it here.

For consistency if above is conditioned on ms->ram_slots != 0, probably
it would be better to move that condition where you set 'event' value and
check property value above instead of ms->ram_slots

[...]
> +static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq *pic)
> +{
> +    DeviceState *dev;
> +    int irq = vms->irqmap[VIRT_ACPI_GED];
> +    uint32_t event = ACPI_GED_MEM_HOTPLUG_EVT;
> +
> +    dev = qdev_create(NULL, TYPE_ACPI_GED);
> +    qdev_prop_set_uint32(dev, "ged-event", event);
> +    qdev_init_nofail(dev);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
> +
> +    return dev;
> +}
> +
[...]

