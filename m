Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4DDC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109FC204EC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109FC204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54131 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMETV-0003h8-CE
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:22:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMERe-0002NM-1v
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMERV-00078F-4k
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hMEQz-0006Mg-Pw; Thu, 02 May 2019 12:19:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 081E287627;
	Thu,  2 May 2019 16:19:44 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-72.brq.redhat.com [10.40.204.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F74CA221;
	Thu,  2 May 2019 16:19:34 +0000 (UTC)
Date: Thu, 2 May 2019 18:19:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190502181929.0bad1fb5@Igors-MacBook-Pro>
In-Reply-To: <20190409102935.28292-5-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 02 May 2019 16:19:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 4/8] hw/arm/virt: Add memory hotplug
 framework
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, shannon.zhaosl@gmail.com,
	ard.biesheuvel@linaro.org, qemu-devel@nongnu.org,
	xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
	qemu-arm@nongnu.org, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502161929.CMGL9fdaG6H3LNKgVbta1Cd9xwVOlUrP8ub_6SXEXJw@z>

On Tue, 9 Apr 2019 11:29:31 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Eric Auger <eric.auger@redhat.com>
> 
> This patch adds the memory hot-plug/hot-unplug infrastructure
> in machvirt. The device memory is not yet exposed to the Guest
> either though DT or ACPI and hence both cold/hot plug of memory
s/though/through/

> is explicitly disabled for now.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  default-configs/arm-softmmu.mak |  3 +++
>  hw/arm/virt.c                   | 45 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 613d19a..9f4b803 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -160,3 +160,6 @@ CONFIG_MUSICPAL=y
>  
>  # for realview and versatilepb
>  CONFIG_LSI_SCSI_PCI=y
> +
> +CONFIG_MEM_DEVICE=y
> +CONFIG_DIMM=y
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ce2664a..da516b3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -61,6 +61,8 @@
>  #include "hw/arm/smmuv3.h"
>  #include "hw/acpi/acpi.h"
>  #include "target/arm/internals.h"
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/mem/nvdimm.h"
>  
>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> @@ -1806,6 +1808,34 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
>      return ms->possible_cpus;
>  }
>  
> +static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> +                                 Error **errp)
> +{
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        error_setg(errp, "memory cold/hot plug is not yet supported");
> +        return;
> +    }
add comment here why it's needed.

> +
> +    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
maybe before calling this there probably should be check if acpi is enabled.

not sure if arm/virt board honors -no-acpi CLI option.

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
> @@ -1817,12 +1847,23 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
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
> @@ -1886,7 +1927,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      mc->kvm_type = virt_kvm_type;
>      assert(!mc->get_hotplug_handler);
>      mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
> +    hc->pre_plug = virt_machine_device_pre_plug_cb;
>      hc->plug = virt_machine_device_plug_cb;
> +    hc->unplug_request = virt_machine_device_unplug_request_cb;
>  }
>  
>  static void virt_instance_init(Object *obj)


