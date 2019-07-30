Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4A3C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429AE206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429AE206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsU1L-0003jh-Gy
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 11:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hsU0R-0002Sr-Ax
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hsU0Q-0006WT-8g
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1hsU0L-0006Sp-W0; Tue, 30 Jul 2019 11:25:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D1D1A3B74;
 Tue, 30 Jul 2019 15:25:32 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-67.brq.redhat.com [10.40.204.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5245B19C67;
 Tue, 30 Jul 2019 15:25:27 +0000 (UTC)
Date: Tue, 30 Jul 2019 17:25:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-ID: <20190730172524.6cf566ed@Igors-MacBook-Pro>
In-Reply-To: <20190726104519.23812-4-shameerali.kolothum.thodi@huawei.com>
References: <20190726104519.23812-1-shameerali.kolothum.thodi@huawei.com>
 <20190726104519.23812-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 30 Jul 2019 15:25:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 3/9] hw/acpi: Add ACPI Generic
 Event Device Support
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
 Paolo Bonzini <pbonzini@redhat.com>, sebastien.boeuf@intel.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 11:45:13 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> From: Samuel Ortiz <sameo@linux.intel.com>
> 
> The ACPI Generic Event Device (GED) is a hardware-reduced specific
> device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> including the hotplug ones. This patch generates the AML code that
> defines GEDs.
> 
> Platforms need to specify their own GED Event bitmap to describe
> what kind of events they want to support through GED.  Also this
> uses a a single interrupt for the  GED device, relying on IO
> memory region to communicate the type of device affected by the
> interrupt. This way, we can support up to 32 events with a unique
> interrupt.
> 
> This supports only memory hotplug for now.
> 

> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> new file mode 100644
> index 0000000000..7902e9d706
> --- /dev/null
> +++ b/hw/acpi/generic_event_device.c
[...]
> +void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
> +                   uint32_t ged_irq, AmlRegionSpace rs)
> +{
[...]
> +
> +        if (ged_events) {
> +            error_report("GED: Unsupported events specified");
> +            exit(1);
I'd use error_abort instead, since it's programing error, if you have to respin series.

> +        }
> +    }
> +
> +    /* Append _EVT method */
> +    aml_append(dev, evt);
> +
> +    aml_append(table, dev);
> +}
> +
[...]
> +static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
> +{
> +    AcpiGedState *s = ACPI_GED(dev);
> +
> +    assert(s->ged_base);
> +    acpi_ged_init(get_system_memory(), dev, &s->ged_state);

calling get_system_memory() from device code used to be a reason for rejecting patch,
I'm not sure what suggest though. 

Maybe Paolo could suggest something.

> +
> +    if (s->memhp_state.is_enabled) {
> +        assert(s->memhp_base);
> +        acpi_memory_hotplug_init(get_system_memory(), OBJECT(dev),
                                     ^^^^
ditto

> +                                 &s->memhp_state,
> +                                 s->memhp_base);
> +    }
> +}
[...]

> +
> +#endif


