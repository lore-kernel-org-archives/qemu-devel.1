Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA8C56201
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA722068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 13:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgkCXa0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA722068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7Uz-0002mK-PQ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 08:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kc7Pa-0006Wa-8j
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:40:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kc7PX-0001Ec-Sv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 08:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604929242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eq3jGqK1LFTaUd/Dy3H/B96P+EouWzns6tDkLGiS7DY=;
 b=HgkCXa0+eDBWuPN4a720l/xgXuahsO8fTlD2vssWMOc1cV37D/SFgRUIDxHULAnvdK4WiG
 UDbtFtJ4so9q8WZyNi8tqjfZTcGbEAEUkx/GOTeBvhFiDug7DnceyilRyFiIftVddSJ665
 EDB3dQs2oXcJg80924vFotzKdrGl0Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-XoZ3XJl3PDiCee67eV9R4A-1; Mon, 09 Nov 2020 08:40:40 -0500
X-MC-Unique: XoZ3XJl3PDiCee67eV9R4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F7C1018F79;
 Mon,  9 Nov 2020 13:40:39 +0000 (UTC)
Received: from [10.36.114.125] (ovpn-114-125.ams2.redhat.com [10.36.114.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5800F5B4D1;
 Mon,  9 Nov 2020 13:40:31 +0000 (UTC)
Subject: Re: [PATCH v2] hw/arm/virt enable support for virtio-mem
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org
References: <20201105174311.566751-1-Jonathan.Cameron@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c48890ff-9225-0d67-85d3-ae5161a204cf@redhat.com>
Date: Mon, 9 Nov 2020 14:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201105174311.566751-1-Jonathan.Cameron@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, linuxarm@huawei.com,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jonathan,

On 11/5/20 6:43 PM, Jonathan Cameron wrote:
> Basically a cut and paste job from the x86 support with the exception of
> needing a larger block size as the Memory Block Size (MIN_SECTION_SIZE)
> on ARM64 in Linux is 1G.
> 
> Tested:
> * In full emulation and with KVM on an arm64 server.
> * cold and hotplug for the virtio-mem-pci device.
> * Wide range of memory sizes, added at creation and later.
> * Fairly basic memory usage of memory added.  Seems to function as normal.
> * NUMA setup with virtio-mem-pci devices on each node.
> * Simple migration test.

I would add in the commit message that the hot-unplug of the device is
not supported.
> 
> Related kernel patch just enables the Kconfig item for ARM64 as an
> alternative to x86 in drivers/virtio/Kconfig
> 
> The original patches from David Hildenbrand stated that he thought it should
> work for ARM64 but it wasn't enabled in the kernel [1]
> It appears he was correct and everything 'just works'.
Did you try with 64kB page guest as well?
> 
> The build system related stuff is intended to ensure virtio-mem support is
> not built for arm32 (build will fail due no defined block size).
> If there is a more elegant way to do this, please point me in the right
> direction.
I guess you meant CONFIG_ARCH_VIRTIO_MEM_SUPPORTED introduction
> 
> [1] https://lore.kernel.org/linux-mm/20191212171137.13872-1-david@redhat.com/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  default-configs/devices/aarch64-softmmu.mak |  1 +
>  hw/arm/Kconfig                              |  1 +
>  hw/arm/virt.c                               | 64 ++++++++++++++++++++-
>  hw/virtio/Kconfig                           |  4 ++
>  hw/virtio/virtio-mem.c                      |  2 +
>  5 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/default-configs/devices/aarch64-softmmu.mak b/default-configs/devices/aarch64-softmmu.mak
> index 958b1e08e4..31d6128a29 100644
> --- a/default-configs/devices/aarch64-softmmu.mak
> +++ b/default-configs/devices/aarch64-softmmu.mak
> @@ -6,3 +6,4 @@ include arm-softmmu.mak
>  CONFIG_XLNX_ZYNQMP_ARM=y
>  CONFIG_XLNX_VERSAL=y
>  CONFIG_SBSA_REF=y
> +CONFIG_ARCH_VIRTIO_MEM_SUPPORTED=y
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index fdf4464b94..eeae77eee9 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -20,6 +20,7 @@ config ARM_VIRT
>      select PLATFORM_BUS
>      select SMBIOS
>      select VIRTIO_MMIO
> +    select VIRTIO_MEM_SUPPORTED if ARCH_VIRTIO_MEM_SUPPORTED
>      select ACPI_PCI
>      select MEM_DEVICE
>      select DIMM
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8abb385d4e..6c96d71106 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -73,9 +73,11 @@
>  #include "hw/acpi/acpi.h"
>  #include "target/arm/internals.h"
>  #include "hw/mem/pc-dimm.h"
> +#include "hw/mem/memory-device.h"
>  #include "hw/mem/nvdimm.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/virtio/virtio-mem-pci.h"
>  #include "hw/char/pl011.h"
>  #include "qemu/guest-random.h"
>  
> @@ -2286,6 +2288,34 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
>                           dev, &error_abort);
>  }
>  
> +static void virt_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
> +                                      DeviceState *dev, Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +    Error *local_err = NULL;
> +
> +    if (!hotplug_dev2 && dev->hotplugged) {
> +        /*
> +         * Without a bus hotplug handler, we cannot control the plug/unplug
> +         * order. We should never reach this point when hotplugging,
> +         * however, better add a safety net.
> +         */
> +        error_setg(errp, "hotplug of virtio-mem based memory devices not"
> +                   " supported on this bus.");
> +        return;
> +    }
> +    /*
> +     * First, see if we can plug this memory device at all. If that
> +     * succeeds, branch of to the actual hotplug handler.
> +     */
> +    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
> +                           &local_err);
> +    if (!local_err && hotplug_dev2) {
> +        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
> +    }
> +    error_propagate(errp, local_err);
> +}
> +
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **errp)
>  {
> @@ -2293,6 +2323,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        virt_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          hwaddr db_start = 0, db_end = 0;
>          char *resv_prop_str;
> @@ -2322,6 +2354,27 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>      }
>  }
>  
> +static void virt_virtio_md_pci_plug(HotplugHandler *hotplug_dev,
> +                                  DeviceState *dev, Error **errp)
> +{
> +    HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
> +    Error *local_err = NULL;
> +
> +    /*
> +     * Plug the memory device first and then branch off to the actual
> +     * hotplug handler. If that one fails, we can easily undo the memory
> +     * device bits.
> +     */
> +    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +    if (hotplug_dev2) {
> +        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
> +        if (local_err) {
> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +        }
> +    }
> +    error_propagate(errp, local_err);
> +}
> +
>  static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
> @@ -2336,6 +2389,9 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_plug(hotplug_dev, dev, errp);
>      }
nit: while at it we can use "else if" here and below
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
> +    }
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>          PCIDevice *pdev = PCI_DEVICE(dev);
>  
> @@ -2363,6 +2419,11 @@ static void virt_dimm_unplug_request(HotplugHandler *hotplug_dev,
>          goto out;
>      }
virt_dimm_unplug_request() is called if the device type is TYPE_PC_DIMM
while here the device type is TYPE_VIRTIO_MEM_PCI.

Shouldn't this error be returned in
virt_machine_device_unplug_request_cb instead or do like it is done in
pc.c, add a virt_virtio_md_pci_unplug_request() helper with the
error_setg there.
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> +        error_setg(&local_err,
> +                   "virtio-mem based memory devices cannot be unplugged.");
> +        goto out;
> +    }
>      hotplug_handler_unplug_request(HOTPLUG_HANDLER(vms->acpi_dev), dev,
>                                     &local_err);
>  out:
> @@ -2413,7 +2474,8 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>                                                          DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE) ||
> -       (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM))) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>          return HOTPLUG_HANDLER(machine);
>      }
>      if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 0eda25c4e1..00dbf2939e 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -48,6 +48,10 @@ config VIRTIO_PMEM
>      depends on VIRTIO_PMEM_SUPPORTED
>      select MEM_DEVICE
>  
> +config ARCH_VIRTIO_MEM_SUPPORTED
> +    bool
> +    default n
> +
>  config VIRTIO_MEM_SUPPORTED
>      bool
>  
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 7c8ca9f28b..16f9de6ab6 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -53,6 +53,8 @@
>   */
>  #if defined(TARGET_X86_64) || defined(TARGET_I386)
>  #define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
> +#elif defined(TARGET_AARCH64)
> +#define VIRTIO_MEM_USABLE_EXTENT (2 * (1024 * MiB))
>  #else
>  #error VIRTIO_MEM_USABLE_EXTENT not defined
>  #endif
> 
Otherwise looks good to me.

Thanks!

Eric


