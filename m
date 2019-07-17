Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C3C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD012173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD012173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnl6x-0002QD-S1
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hnl6m-0001sF-5F
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hnl6k-00046L-3G
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hnl6g-00043y-Mz; Wed, 17 Jul 2019 10:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A4956C18B2CC;
 Wed, 17 Jul 2019 14:40:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3844260BEE;
 Wed, 17 Jul 2019 14:40:27 +0000 (UTC)
Date: Wed, 17 Jul 2019 16:40:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190717164026.19145b9d@redhat.com>
In-Reply-To: <20190716153816.17676-5-shameerali.kolothum.thodi@huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 17 Jul 2019 14:40:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 04/10] hw/arm/virt: Add memory
 hotplug framework
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
 shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 16:38:10 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
> 
> This patch adds the memory hot-plug/hot-unplug infrastructure
> in machvirt. The device memory is not yet exposed to the Guest
> either through DT or ACPI and hence both cold/hot plug of memory
> is explicitly disabled for now.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/Kconfig |  2 ++
>  hw/arm/virt.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index ab65ecd216..84961c17ab 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -20,6 +20,8 @@ config ARM_VIRT
>      select SMBIOS
>      select VIRTIO_MMIO
>      select ACPI_PCI
> +    select MEM_DEVICE
> +    select DIMM
>  
>  config CHEETAH
>      bool
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index d9496c9363..907fb64bb9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -64,6 +64,8 @@
>  #include "hw/arm/smmuv3.h"
>  #include "hw/acpi/acpi.h"
>  #include "target/arm/internals.h"
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/mem/nvdimm.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1871,6 +1873,40 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>      return ms->possible_cpus;
>  }
>  
> +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                 Error **errp)
> +{
> +
> +    /*
> +     * The device memory is not yet exposed to the Guest either through
> +     * DT or ACPI and hence both cold/hot plug of memory is explicitly
> +     * disabled for now.
> +     */
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        error_setg(errp, "memory cold/hot plug is not yet supported");
> +        return;
> +    }
> +
> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
> +}
> +
> +static void virt_memory_plug(HotplugHandler *hotplug_dev,
> +                             DeviceState *dev, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +
> +    pc_dimm_plug(PC_DIMM(dev), MACHINE(vms), NULL);
> +
> +}
> +
> +static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> +                                            DeviceState *dev, Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    }
> +}
> +
>  static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
> @@ -1882,12 +1918,23 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                       SYS_BUS_DEVICE(dev));
>          }
>      }
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        virt_memory_plug(hotplug_dev, dev, errp);
> +    }
> +}
> +
> +static void virt_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                                          DeviceState *dev, Error **errp)
> +{
> +    error_setg(errp, "device unplug request for unsupported device"
> +               " type: %s", object_get_typename(OBJECT(dev)));
>  }
>  
>  static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>                                                          DeviceState *dev)
>  {
> -    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
> +       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
>          return HOTPLUG_HANDLER(machine);
>      }
>  
> @@ -1951,7 +1998,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->kvm_type = virt_kvm_type;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
> +    hc->pre_plug = virt_machine_device_pre_plug_cb;
>      hc->plug = virt_machine_device_plug_cb;
> +    hc->unplug_request = virt_machine_device_unplug_request_cb;
>      mc->numa_mem_supported = true;
>  }
>  


