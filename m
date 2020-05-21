Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE8F20721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 08:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+RB/JDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE8F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbh30-0003Ih-SB
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 04:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbh2R-0002mC-BW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 04:58:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbh2Q-0002hv-IF
 for qemu-devel@nongnu.org; Thu, 21 May 2020 04:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590051529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KT3me/hqtUdfUJNqE59XrEPDBgfSAYlDm++Tcyh5plY=;
 b=O+RB/JDFoCg5BsF8RmeIGIc0SJX6XS/N0+9+fqWnQ5xDiLtGSWFYoYLS75N9cNvgD2LpYI
 Rh4ga/TQbXUqM64wZW0cM3ew5yWN2f7bSMRPtcnkWVToiJJCj6wthMh4eExOtaCP4+Fsdh
 wfX67ufHrKTwHWCLJLJ8cb9C8SC069M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-3r5OI8LrNAi4CIjLGzCgwA-1; Thu, 21 May 2020 04:58:46 -0400
X-MC-Unique: 3r5OI8LrNAi4CIjLGzCgwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9C17107ACF2;
 Thu, 21 May 2020 08:58:44 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 682725D9C9;
 Thu, 21 May 2020 08:58:33 +0000 (UTC)
Date: Thu, 21 May 2020 10:58:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 10/22] acpi: ged: add control regs
Message-ID: <20200521105829.4c5da13c@redhat.com>
In-Reply-To: <20200520132003.9492-11-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-11-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 May 2020 15:19:51 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Add control regs (sleep, reset) for hw-reduced acpi.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

this should be acompanied by docs update
  docs/specs/acpi_hw_reduced_hotplug.rst
to document new registers and their semantics
and probaly rename file to something more appropriate

> ---
>  include/hw/acpi/generic_event_device.h |  7 ++++
>  hw/acpi/generic_event_device.c         | 44 ++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 90a9180db572..474c92198080 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -72,6 +72,12 @@
>  #define ACPI_GED_EVT_SEL_OFFSET    0x0
>  #define ACPI_GED_EVT_SEL_LEN       0x4
>  
> +#define ACPI_GED_REG_SLEEP_CTL     0x00
> +#define ACPI_GED_REG_SLEEP_STS     0x01
> +#define ACPI_GED_REG_RESET         0x02
> +#define   ACPI_GED_RESET_VALUE     0x42
> +#define ACPI_GED_REG_COUNT         0x03
> +
>  #define GED_DEVICE      "GED"
>  #define AML_GED_EVT_REG "EREG"
>  #define AML_GED_EVT_SEL "ESEL"
> @@ -87,6 +93,7 @@
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> +    MemoryRegion regs;
>      uint32_t     sel;
>  } GEDState;
>  
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 1cb34111e59a..3072fb4ab32b 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -20,6 +20,7 @@
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
> +#include "sysemu/runstate.h"
>  
>  static const uint32_t ged_supported_events[] = {
>      ACPI_GED_MEM_HOTPLUG_EVT,
> @@ -176,6 +177,45 @@ static const MemoryRegionOps ged_evt_ops = {
>      },
>  };
>  
> +static uint64_t ged_regs_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
> +                           unsigned int size)
> +{
> +    bool slp_en;
> +    int slp_typ;
> +
> +    switch (addr) {
> +    case ACPI_GED_REG_SLEEP_CTL:
> +        slp_typ = (data >> 2) & 0x07;
> +        slp_en  = (data >> 5) & 0x01;
> +        if (slp_en && slp_typ == 5) {
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        }
> +        return;
> +    case ACPI_GED_REG_SLEEP_STS:
> +        return;
> +    case ACPI_GED_REG_RESET:
> +        if (data == ACPI_GED_RESET_VALUE) {
> +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        }
> +        return;
> +    }
> +}
> +
> +static const MemoryRegionOps ged_regs_ops = {
> +    .read = ged_regs_read,
> +    .write = ged_regs_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 1,
> +    },
> +};
> +
>  static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>                                      DeviceState *dev, Error **errp)
>  {
> @@ -305,6 +345,10 @@ static void acpi_ged_initfn(Object *obj)
>       sysbus_init_mmio(sbd, &s->container_memhp);
>       acpi_memory_hotplug_init(&s->container_memhp, OBJECT(dev),
>                                &s->memhp_state, 0);
> +
> +    memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
> +                          TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
> +    sysbus_init_mmio(sbd, &ged_st->regs);
>  }
>  
>  static void acpi_ged_class_init(ObjectClass *class, void *data)


