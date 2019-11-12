Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA07C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC467214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 13:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMQtAL52"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC467214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUVpE-0003yX-PV
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 08:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iUVo0-0002ex-A5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iUVny-0005Oa-Qg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:02:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20084
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iUVny-0005OP-Mk
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573563717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsBUanOsuGMlQrRd7wFmfdPgoLITqUpiAVc+JdLSNsM=;
 b=UMQtAL52abPLHgLEZeqV3y2aimSWQ7glNPLKCj3fISz1pW/Bx9ATQWD8YbTeB6mtrzEImS
 vwPJzs8ukgNERd5/Q/NrKS/OaZ3TcAKWfA52cZnlYkNXh5qUtM0Q9uGKQ5sYiME4rpXs5F
 3BwfithfRu5EnY0tyYpWeBTN4NxIPq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-2XUNvjmsMXuNKjaiMOeo-g-1; Tue, 12 Nov 2019 08:01:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2755B18B5F6A;
 Tue, 12 Nov 2019 13:01:53 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF1746292A;
 Tue, 12 Nov 2019 13:01:47 +0000 (UTC)
Date: Tue, 12 Nov 2019 14:01:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 5/5] hw/arm/virt: Add nvdimm hotplug support
Message-ID: <20191112140145.7ad2f034@redhat.com>
In-Reply-To: <20191004155302.4632-6-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <20191004155302.4632-6-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2XUNvjmsMXuNKjaiMOeo-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 16:53:02 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This adds support for nvdimm hotplug events through GED
> and enables nvdimm for the arm/virt. Now Guests with DT boot
> can have nvdimm cold plug and with ACPI both cold/hot plug.
>=20
> Hot removal functionality is not yet supported.
>=20
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

I'd move out DT cold-plug out of this patch is it's not related
to this patch at all

otherwise patch looks good, so=20
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/specs/acpi_hw_reduced_hotplug.rst |  1 +
>  hw/acpi/generic_event_device.c         | 13 +++++++++++++
>  hw/arm/virt.c                          | 20 +++++++++++++++-----
>  include/hw/acpi/generic_event_device.h |  1 +
>  4 files changed, 30 insertions(+), 5 deletions(-)
>=20
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_=
reduced_hotplug.rst
> index 911a98255b..e3abe975bf 100644
> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> @@ -63,6 +63,7 @@ GED IO interface (4 byte access)
>      bits:
>         0: Memory hotplug event
>         1: System power down event
> +       2: NVDIMM hotplug event
>      2-31: Reserved
> =20
>  **write_access:**
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_devic=
e.c
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
>  static const uint32_t ged_supported_events[] =3D {
>      ACPI_GED_MEM_HOTPLUG_EVT,
>      ACPI_GED_PWR_DOWN_EVT,
> +    ACPI_GED_NVDIMM_HOTPLUG_EVT,
>  };
> =20
>  /*
> @@ -110,6 +112,11 @@ void build_ged_aml(Aml *table, const char *name, Hot=
plugHandler *hotplug_dev,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE)=
,
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_NVDIMM_HOTPLUG_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name("\\_SB.NVDR"),
> +                                      aml_int(0x80)));
> +                break;
>              default:
>                  /*
>                   * Please make sure all the events in ged_supported_even=
ts[]
> @@ -175,7 +182,11 @@ static void acpi_ged_device_plug_cb(HotplugHandler *=
hotplug_dev,
>      AcpiGedState *s =3D ACPI_GED(hotplug_dev);
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> +            nvdimm_acpi_plug_cb(hotplug_dev, dev);
> +        } else {
>              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev, errp)=
;
> +        }
>      } else {
>          error_setg(errp, "virt: device plug request for unsupported devi=
ce"
>                     " type: %s", object_get_typename(OBJECT(dev)));
> @@ -192,6 +203,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, A=
cpiEventStatusBits ev)
>          sel =3D ACPI_GED_MEM_HOTPLUG_EVT;
>      } else if (ev & ACPI_POWER_DOWN_STATUS) {
>          sel =3D ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
> +        sel =3D ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else {
>          /* Unknown event. Return without generating interrupt. */
>          warn_report("GED: Unsupported event %d. No irq injected", ev);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 30bc8a7803..acdcba9638 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -543,6 +543,10 @@ static inline DeviceState *create_acpi_ged(VirtMachi=
neState *vms, qemu_irq *pic)
>          event |=3D ACPI_GED_MEM_HOTPLUG_EVT;
>      }
> =20
> +    if (ms->nvdimms_state->is_enabled) {
> +        event |=3D ACPI_GED_NVDIMM_HOTPLUG_EVT;
> +    }
> +
>      dev =3D qdev_create(NULL, TYPE_ACPI_GED);
>      qdev_prop_set_uint32(dev, "ged-event", event);
> =20
> @@ -1938,9 +1942,12 @@ static void virt_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>      }
> =20
>      if (!vms->acpi_dev) {
> -        error_setg(errp,
> -                   "memory hotplug is not enabled: missing acpi-ged devi=
ce");
> -        return;
> +        /* Allow nvdimm DT or cold plug */
> +        if (!(is_nvdimm && !dev->hotplugged)) {
> +            error_setg(errp,
> +                       "memory hotplug is not enabled: missing acpi-ged =
device");
> +            return;
> +         }



>      }
> =20
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
> @@ -1964,8 +1971,10 @@ static void virt_memory_plug(HotplugHandler *hotpl=
ug_dev,
>          nvdimm_plug(ms->nvdimms_state);
>      }
> =20
> -    hhc =3D HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> -    hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
> +    if (vms->acpi_dev) {
> +        hhc =3D HOTPLUG_HANDLER_GET_CLASS(vms->acpi_dev);
> +        hhc->plug(HOTPLUG_HANDLER(vms->acpi_dev), dev, &error_abort);
> +    }
>  out:
>      error_propagate(errp, local_err);
>  }
> @@ -2073,6 +2082,7 @@ static void virt_machine_class_init(ObjectClass *oc=
, void *data)
>      hc->plug =3D virt_machine_device_plug_cb;
>      hc->unplug_request =3D virt_machine_device_unplug_request_cb;
>      mc->numa_mem_supported =3D true;
> +    mc->nvdimm_supported =3D true;
>      mc->auto_enable_numa_with_memhp =3D true;
>  }
> =20
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/gen=
eric_event_device.h
> index d157eac088..9eb86ca4fd 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -82,6 +82,7 @@
>   */
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
> +#define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> =20
>  typedef struct GEDState {
>      MemoryRegion io;


