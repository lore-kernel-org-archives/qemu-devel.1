Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE675C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB19220880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB19220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho68P-0002BV-AS
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55131)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1ho685-0001EN-Dz
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ho684-0003cf-Fo
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:07:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1ho682-0003b0-9L; Thu, 18 Jul 2019 09:07:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBDB330BD1B1;
 Thu, 18 Jul 2019 13:07:20 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 323DB1001B02;
 Thu, 18 Jul 2019 13:07:15 +0000 (UTC)
Date: Thu, 18 Jul 2019 15:07:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190718150714.691f91f9@redhat.com>
In-Reply-To: <20190716153816.17676-9-shameerali.kolothum.thodi@huawei.com>
References: <20190716153816.17676-1-shameerali.kolothum.thodi@huawei.com>
 <20190716153816.17676-9-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 18 Jul 2019 13:07:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v7 08/10] hw/acpi: Add system power
 down support to GED
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

On Tue, 16 Jul 2019 16:38:14 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This adds support to use GED for system power down event.
[...]

> @@ -232,6 +238,13 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>      acpi_ged_event(s, sel);
>  }
>  
> +static void acpi_ged_pm_powerdown_req(Notifier *n, void *opaque)
> +{
> +    AcpiGedState *s = container_of(n, AcpiGedState, powerdown_notifier);
> +
> +    acpi_ged_event(s, ACPI_GED_PWR_DOWN_EVT);
> +}
> +
>  static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
>  {
>      AcpiGedState *s = ACPI_GED(dev);
> @@ -243,6 +256,9 @@ static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
>      }
>  
>      acpi_ged_init(get_system_memory(), dev, &s->ged_state);
> +
> +    s->powerdown_notifier.notify = acpi_ged_pm_powerdown_req;

one more thing:
I'd reuse virt_powerdown_req() instead.

pass it machine pointer and then from notifier you'd be able to get to acpi_dev

> +    qemu_register_powerdown_notifier(&s->powerdown_notifier);
>  }
>  
>  static Property acpi_ged_properties[] = {
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index f69d084c89..9e63b72cb9 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -61,6 +61,8 @@
>  
>  #include "hw/acpi/memory_hotplug.h"
>  
> +#define ACPI_POWER_BUTTON_DEVICE "PWRB"
> +
>  #define TYPE_ACPI_GED "acpi-ged"
>  #define ACPI_GED(obj) \
>      OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
> @@ -79,6 +81,7 @@
>   * through GED.
>   */
>  #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
> +#define ACPI_GED_PWR_DOWN_EVT      0x2
>  
>  typedef struct GEDState {
>      MemoryRegion io;
> @@ -88,6 +91,7 @@ typedef struct GEDState {
>  
>  typedef struct AcpiGedState {
>      DeviceClass parent_obj;
> +    Notifier powerdown_notifier;
>      MemHotplugState memhp_state;
>      hwaddr memhp_base;
>      hwaddr ged_base;


