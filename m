Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D402C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3165C20724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrCqpgFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3165C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k966X-0004p6-FH
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k965u-00045l-In
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k965r-0008Rr-UF
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598012665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83qubCIb9tJhaPTInkf3YnCTy1oVuwJV/abYP4nW4Ug=;
 b=WrCqpgFjc8125iVQXYdl/LlUATDqdusos1X9bg3vayQ7ld1UXwp5bSb18IxGADs67RILXG
 eDeeS0AwfLtErBZTQ6hsuBejBXaNbpNGmwTCsPCiVoaN+NFt+7aMLMSVujY+e/S1Qiet13
 xkfVKSL6tRdKLT17xniSBYA4MOUmMTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-QYMP0joQPTurT-9ujlp8HQ-1; Fri, 21 Aug 2020 08:24:23 -0400
X-MC-Unique: QYMP0joQPTurT-9ujlp8HQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9CE91015C9D
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:24:22 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F23A760BF1;
 Fri, 21 Aug 2020 12:24:12 +0000 (UTC)
Date: Fri, 21 Aug 2020 14:24:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [RFC PATCH v2 4/4] hw/acpi/ich9: Enable ACPI PCI hot-plug
Message-ID: <20200821142411.6f5bcc0e@redhat.com>
In-Reply-To: <20200818215227.181654-5-jusual@redhat.com>
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-5-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 23:52:27 +0200
Julia Suvorova <jusual@redhat.com> wrote:

> Add acpi_pcihp to ich9_pm and use ACPI PCI hot-plug by default.

I don't see anything related to migrating hotplug state within series,

see VMSTATE_PCI_HOTPLUG for example.

 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
> Note: New pc_compats are usually added shortly after release.
>       I will switch to pc_compat_5_1 when it becomes available.
> 
>  hw/i386/acpi-build.h   |  1 +
>  include/hw/acpi/ich9.h |  3 +++
>  hw/acpi/ich9.c         | 45 ++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/pcihp.c        |  5 ++++-
>  hw/i386/acpi-build.c   |  2 +-
>  hw/i386/pc.c           |  1 +
>  6 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
> index 6f94312c39..f0bb080018 100644
> --- a/hw/i386/acpi-build.h
> +++ b/hw/i386/acpi-build.h
> @@ -17,5 +17,6 @@ typedef enum {
>  } AcpiOSCField;
>  
>  void acpi_setup(void);
> +Object *acpi_get_i386_pci_host(void);
>  
>  #endif
> diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
> index 28a53181cb..9947085e9c 100644
> --- a/include/hw/acpi/ich9.h
> +++ b/include/hw/acpi/ich9.h
> @@ -24,6 +24,7 @@
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/cpu_hotplug.h"
>  #include "hw/acpi/cpu.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/acpi/memory_hotplug.h"
>  #include "hw/acpi/acpi_dev_interface.h"
>  #include "hw/acpi/tco.h"
> @@ -53,6 +54,8 @@ typedef struct ICH9LPCPMRegs {
>      AcpiCpuHotplug gpe_cpu;
>      CPUHotplugState cpuhp_state;
>  
> +    bool use_acpi_hotplug_bridge;
> +    AcpiPciHpState acpi_pci_hotplug;
>      MemHotplugState acpi_memory_hotplug;
>  
>      uint8_t disable_s3;
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index a2a1742aa6..fde86d12ae 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -265,6 +265,7 @@ static void pm_reset(void *opaque)
>      }
>      pm->smi_en_wmask = ~0;
>  
> +    acpi_pcihp_reset(&pm->acpi_pci_hotplug);
>      acpi_update_sci(&pm->acpi_regs, pm->irq);
>  }
>  
> @@ -303,6 +304,17 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm,
>      pm->enable_tco = true;
>      acpi_pm_tco_init(&pm->tco_regs, &pm->io);
>  
> +    if (pm->use_acpi_hotplug_bridge) {
> +        acpi_pcihp_init(OBJECT(lpc_pci),
> +                        &pm->acpi_pci_hotplug,
> +                        pci_get_bus(lpc_pci),
> +                        pci_address_space_io(lpc_pci),
> +                        true, false);
> +
> +        qbus_set_hotplug_handler(BUS(pci_get_bus(lpc_pci)),
> +                                 OBJECT(lpc_pci));
> +    }
> +
>      pm->irq = sci_irq;
>      qemu_register_reset(pm_reset, pm);
>      pm->powerdown_notifier.notify = pm_powerdown_req;
> @@ -374,6 +386,20 @@ static void ich9_pm_set_enable_tco(Object *obj, bool value, Error **errp)
>      s->pm.enable_tco = value;
>  }
>  
> +static bool ich9_pm_get_acpi_pci_hotplug(Object *obj, Error **errp)
> +{
> +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> +
> +    return s->pm.use_acpi_hotplug_bridge;
> +}
> +
> +static void ich9_pm_set_acpi_pci_hotplug(Object *obj, bool value,
> +                                               Error **errp)
> +{
> +    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
> +
> +    s->pm.use_acpi_hotplug_bridge = value;
> +}
>  void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>  {
>      static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
> @@ -382,6 +408,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>      pm->disable_s3 = 0;
>      pm->disable_s4 = 0;
>      pm->s4_val = 2;
> +    pm->use_acpi_hotplug_bridge = true;

I'd prefer default to be false, and managment turn it on when creating
config for Windows.

i.e. if users need it, they should enable it explicitly so overhead it produces
won't affect other configs. 

>      object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
>                                     &pm->pm_io_base, OBJ_PROP_FLAG_READ);
> @@ -405,6 +432,9 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>      object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
>                               ich9_pm_get_enable_tco,
>                               ich9_pm_set_enable_tco);
> +    object_property_add_bool(obj, "acpi-pci-hotplug-with-bridge-support",
> +                             ich9_pm_get_acpi_pci_hotplug,
> +                             ich9_pm_set_acpi_pci_hotplug);
>  }
>  
>  void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> @@ -412,6 +442,11 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  {
>      ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
>  
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_pre_plug_cb(hotplug_dev, dev, errp);
> +        return;
> +    }
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
>          !lpc->pm.acpi_memory_hotplug.is_enabled)
>          error_setg(errp,
> @@ -437,6 +472,9 @@ void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>          } else {
>              acpi_cpu_plug_cb(hotplug_dev, &lpc->pm.cpuhp_state, dev, errp);
>          }
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_plug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> +                                  dev, errp);
>      } else {
>          error_setg(errp, "acpi: device plug request for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -457,6 +495,10 @@ void ich9_pm_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                 !lpc->pm.cpu_hotplug_legacy) {
>          acpi_cpu_unplug_request_cb(hotplug_dev, &lpc->pm.cpuhp_state,
>                                     dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_request_cb(hotplug_dev,
> +                                            &lpc->pm.acpi_pci_hotplug,
> +                                            dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug request for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -474,6 +516,9 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU) &&
>                 !lpc->pm.cpu_hotplug_legacy) {
>          acpi_cpu_unplug_cb(&lpc->pm.cpuhp_state, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> +        acpi_pcihp_device_unplug_cb(hotplug_dev, &lpc->pm.acpi_pci_hotplug,
> +                                    dev, errp);
>      } else {
>          error_setg(errp, "acpi: device unplug for not supported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 9a35ed6c83..46ebd1bb15 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -30,6 +30,8 @@
>  #include "hw/pci-host/i440fx.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/i386/acpi-build.h"
>  #include "hw/acpi/acpi.h"
>  #include "exec/address-spaces.h"
>  #include "hw/pci/pci_bus.h"
> @@ -90,6 +92,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>  static void acpi_set_pci_info(void)
>  {
>      static bool bsel_is_set;
> +    Object *host = acpi_get_i386_pci_host();
>      PCIBus *bus;
>      unsigned bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT;
>  
> @@ -98,7 +101,7 @@ static void acpi_set_pci_info(void)
>      }
>      bsel_is_set = true;
>  
> -    bus = find_i440fx(); /* TODO: Q35 support */
> +    bus = PCI_HOST_BRIDGE(host)->bus;
>      if (bus) {
>          /* Scan all PCI buses. Set property to enable acpi based hotplug. */
>          pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_alloc);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index c5f4802b8c..8cecdf722f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -270,7 +270,7 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
>   * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
>   * On i386 arch we only have two pci hosts, so we can look only for them.
>   */
> -static Object *acpi_get_i386_pci_host(void)
> +Object *acpi_get_i386_pci_host(void)
>  {
>      PCIHostState *host;
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 47c5ca3e34..175e6911a1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -98,6 +98,7 @@
>  #include "trace.h"
>  
>  GlobalProperty pc_compat_5_0[] = {
> +    { "ICH9-LPC", "acpi-pci-hotplug-with-bridge-support", "off" },
>  };
>  const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
>  


