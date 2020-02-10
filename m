Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7545C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D262070A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+LooVQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D262070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19N0-0005VZ-Mi
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j19ME-0004i0-2d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j19MC-0006qG-Lq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:44:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57560
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j19MC-0006q4-Id
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581342252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQdUyuQyVZSg++rQvTdORNNiRypDOq5+9r3udxfImE0=;
 b=b+LooVQNumXFtl56B9YOidwMqnFO0NBNR/bfPd0OLFHYROneP4PM04RHKBXa6qU0GocaMa
 N3V8sLeBVOR1OP+tIYZ2ktpdjegK4IcG5Nk1n9otezFtzwJQB604dZccKW8jZPPyCiC5hf
 CUnslB2gwmWNYIqFHvf83rqL2O2wQYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-lf9a2MXgOIKl9yT0PD8ITw-1; Mon, 10 Feb 2020 08:44:08 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62A148010C4;
 Mon, 10 Feb 2020 13:44:06 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 281D55C1D4;
 Mon, 10 Feb 2020 13:43:57 +0000 (UTC)
Date: Mon, 10 Feb 2020 14:43:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 5/7] hw/arm/virt: Add nvdimm hotplug support
Message-ID: <20200210144355.523c2e83@redhat.com>
In-Reply-To: <20200117174522.22044-6-shameerali.kolothum.thodi@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
 <20200117174522.22044-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lf9a2MXgOIKl9yT0PD8ITw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, xuwei5@hisilicon.com,
 linuxarm@huawei.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 17:45:20 +0000
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This adds support for nvdimm hotplug events through GED
> and enables nvdimm for the arm/virt. Now Guests with ACPI
> can have both cold and hot plug of nvdimms.
> 
> Hot removal functionality is not yet supported.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  docs/specs/acpi_hw_reduced_hotplug.rst |  1 +
>  hw/acpi/generic_event_device.c         | 13 +++++++++++++
>  hw/arm/virt.c                          | 16 +++++++++++-----
>  include/hw/acpi/generic_event_device.h |  1 +
>  4 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
> index 911a98255b..e3abe975bf 100644
> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> @@ -63,6 +63,7 @@ GED IO interface (4 byte access)
>      bits:
>         0: Memory hotplug event
>         1: System power down event
> +       2: NVDIMM hotplug event
>      2-31: Reserved
>  
>  **write_access:**
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 9cee90cc70..ad1b684304 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -16,6 +16,7 @@
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/irq.h"
>  #include "hw/mem/pc-dimm.h"
> +#include "hw/mem/nvdimm.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
> @@ -23,6 +24,7 @@
>  static const uint32_t ged_supported_events[] = {
>      ACPI_GED_MEM_HOTPLUG_EVT,
>      ACPI_GED_PWR_DOWN_EVT,
> +    ACPI_GED_NVDIMM_HOTPLUG_EVT,
>  };
>  
>  /*
> @@ -110,6 +112,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_NVDIMM_HOTPLUG_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name("\\_SB.NVDR"),
> +                                      aml_int(0x80)));
> +                break;
>              default:
>                  /*
>                   * Please make sure all the events in ged_supported_events[]
> @@ -175,7 +182,11 @@ static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>      AcpiGedState *s = ACPI_GED(hotplug_dev);
>  
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> +            nvdimm_acpi_plug_cb(hotplug_dev, dev);
> +        } else {
>              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp);
> +        }
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported device"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -192,6 +203,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_MEM_HOTPLUG_EVT;
>      } else if (ev & ACPI_POWER_DOWN_STATUS) {
>          sel = ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
> +        sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7987c8f5b8..5ea2584491 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -543,6 +543,10 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
>      }
>  
> +    if (ms->nvdimms_state->is_enabled) {
> +        event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    }
> +
>      dev = qdev_create(NULL, TYPE_ACPI_GED);
>      qdev_prop_set_uint32(dev, "ged-event", event);
>  
> @@ -1928,19 +1932,20 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                   Error **errp)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +    const MachineState *ms = MACHINE(hotplug_dev);
>      const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
>  
> -    if (is_nvdimm) {
> -        error_setg(errp, "nvdimm is not yet supported");
> -        return;
> -    }
> -
>      if (!vms->acpi_dev) {
>          error_setg(errp,
>                     "memory hotplug is not enabled: missing acpi-ged device");
>          return;
>      }
>  
> +    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
> +        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
s/missing 'nvdimm' in '-M'/add 'nvdimm=on' to '-M'/

> +        return;
> +    }
> +
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
>  }
>  
> @@ -2071,6 +2076,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>      hc->plug = virt_machine_device_plug_cb;
>      hc->unplug_request = virt_machine_device_unplug_request_cb;
>      mc->numa_mem_supported = true;
> +    mc->nvdimm_supported = true;
>      mc->auto_enable_numa_with_memhp = true;
>  }
>  
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d157eac088..9eb86ca4fd 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -82,6 +82,7 @@
>   */
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
> +#define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  
>  typedef struct GEDState {
>      MemoryRegion io;


