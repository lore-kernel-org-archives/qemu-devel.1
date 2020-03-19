Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC6DC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76D1120663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 14:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQHVm3jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D1120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwCi-00071X-LX
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 10:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEwBw-0006TF-7y
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEwBu-0003Wg-CR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:30:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEwBu-0003WN-43
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 10:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584628233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCCYJiZZ6I0+GAvWI4VBrcE9+KX3/b2FHAQomUHLaT4=;
 b=TQHVm3jEA5IjpQdmH0HNB1m/+VVay+fWP9iS2CJ7qEtwctNPV7uom4qdSO4IeryhrQCe9R
 Egft8P1WHhTKqQsd6yvUWjoDojXCXz6M5lkKK14CeiIKpAX1ZgWnp2O+8unXtywniNCpM1
 UcUbsRAZiWAA+tZ5YPjCvYd3fiZ6RdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-f-KbRQIDPe-K6i-Jqe7W_g-1; Thu, 19 Mar 2020 10:30:31 -0400
X-MC-Unique: f-KbRQIDPe-K6i-Jqe7W_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940F81857BF5;
 Thu, 19 Mar 2020 14:30:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4737660BF1;
 Thu, 19 Mar 2020 14:30:17 +0000 (UTC)
Date: Thu, 19 Mar 2020 15:30:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 05/13] microvm: add acpi_dsdt_add_virtio() for x86
Message-ID: <20200319153015.43f29fe0@redhat.com>
In-Reply-To: <20200319080117.7725-6-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-6-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 09:01:09 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Makes x86 linux kernel find virtio-mmio devices automatically.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-build.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0e45a646af56..80844db24d6b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qnum.h"
>  #include "acpi-build.h"
> @@ -60,6 +61,7 @@
>  #include "hw/pci-host/q35.h"
>  #include "hw/i386/x86-iommu.h"
>  #include "hw/i386/microvm.h"
> +#include "hw/virtio/virtio-mmio.h"
>  
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/utils.h"
> @@ -2750,6 +2752,54 @@ static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
>      return true;
>  }
>  
> +static void acpi_dsdt_add_virtio(Aml *scope)
> +{
> +    gchar *separator;
> +    long int index;
> +    BusState *bus;
> +    BusChild *kid;
> +
> +    bus = sysbus_get_default();
> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        DeviceState *dev = kid->child;
> +        ObjectClass *class = object_get_class(OBJECT(dev));
> +
> +        if (class == object_class_by_name(TYPE_VIRTIO_MMIO)) {
using object_dynamic_cast() would be cleaner

> +            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
> +            VirtioBusState *mmio_virtio_bus = &mmio->bus;
> +            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
> +
> +            if (QTAILQ_EMPTY(&mmio_bus->children)) {
> +                continue;
> +            }
> +            separator = g_strrstr(mmio_bus->name, ".");
> +            if (!separator) {
> +                continue;
> +            }
> +            if (qemu_strtol(separator + 1, NULL, 10, &index) != 0) {
> +                continue;
> +            }
> +
> +            uint32_t irq = VIRTIO_IRQ_BASE + index;
> +            hwaddr base = VIRTIO_MMIO_BASE + index * 512;
> +            hwaddr size = 512;
is it possible to fish these values out from device without poking in its guts
like using sysbus_get_connected_irq() and make up something to do get mmio parameters from sysbus device

> +
> +            Aml *dev = aml_device("VR%02u", (unsigned)index);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
> +            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
> +
> +            Aml *crs = aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
> +            aml_append(crs,
> +                       aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
> +                                     AML_EXCLUSIVE, &irq, 1));
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, dev);
> +        }
> +    }
> +}
> +
>  static void
>  build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>                     MicrovmMachineState *mms)
> @@ -2766,6 +2816,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
>  
>      sb_scope = aml_scope("_SB");
>      acpi_dsdt_add_fw_cfg(sb_scope, OBJECT(x86ms->fw_cfg));
> +    acpi_dsdt_add_virtio(sb_scope);
>      aml_append(dsdt, sb_scope);
>  
>      scope = aml_scope("\\");


