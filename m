Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A12320738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 09:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hprH945d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A12320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbh6A-0005hC-BP
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 05:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbh5J-0004sY-EY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:01:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28458
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jbh5I-0003kN-KH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 05:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590051707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Qu0BqCtF9E5LbjwS6WZEPgemCZXIfsp5pEtcNbY/O0=;
 b=hprH945dOCtmr1tNzOvCJvB0RXN8ap/CbhtvtstYZIGHAdObCdepYvNShxewXOB/SpaDzN
 KunH32eLw+Y4pvdy/r+urwRlrRHp5sJFJ9gEaGMBRWiz2O8cDxUE0R9gbahU5BeOlA7V4V
 DCfeB+VrPCbACO6qzMnuWoshOphB66E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-mxXCBvObOIaaMtTvPDoXdw-1; Thu, 21 May 2020 05:01:46 -0400
X-MC-Unique: mxXCBvObOIaaMtTvPDoXdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B3A8018A5;
 Thu, 21 May 2020 09:01:44 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 302C66EA22;
 Thu, 21 May 2020 09:01:31 +0000 (UTC)
Date: Thu, 21 May 2020 11:01:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 11/22] acpi: ged: add x86 device variant.
Message-ID: <20200521110127.31898f2f@redhat.com>
In-Reply-To: <20200520132003.9492-12-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-12-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Wed, 20 May 2020 15:19:52 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Set AcpiDeviceIfClass->madt_cpu,
> otherwise identical to TYPE_ACPI_GED.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/generic_event_device.h |  4 +++
>  hw/i386/generic_event_device_x86.c     | 36 ++++++++++++++++++++++++++
>  hw/i386/Makefile.objs                  |  1 +
>  3 files changed, 41 insertions(+)
>  create mode 100644 hw/i386/generic_event_device_x86.c
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 474c92198080..9687cb524258 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -69,6 +69,10 @@
>  #define ACPI_GED(obj) \
>      OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
>  
> +#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
> +#define ACPI_GED_X86(obj) \
> +    OBJECT_CHECK(AcpiGedX86State, (obj), TYPE_ACPI_GED_X86)
> +
>  #define ACPI_GED_EVT_SEL_OFFSET    0x0
>  #define ACPI_GED_EVT_SEL_LEN       0x4
>  
> diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_device_x86.c
> new file mode 100644
> index 000000000000..e26fb02a2ef6
> --- /dev/null
> +++ b/hw/i386/generic_event_device_x86.c
> @@ -0,0 +1,36 @@
> +/*
> + * x86 variant of the generic event device for hw reduced acpi
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/generic_event_device.h"
> +#include "hw/i386/pc.h"
> +
> +static void acpi_ged_x86_class_init(ObjectClass *class, void *data)
> +{
> +    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
> +
> +    adevc->madt_cpu = pc_madt_cpu_entry;
> +}
> +
> +static const TypeInfo acpi_ged_x86_info = {
> +    .name          = TYPE_ACPI_GED_X86,
> +    .parent        = TYPE_ACPI_GED,
> +    .class_init    = acpi_ged_x86_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { TYPE_ACPI_DEVICE_IF },
> +        { }
> +    }
> +};
> +
> +static void acpi_ged_x86_register_types(void)
> +{
> +    type_register_static(&acpi_ged_x86_info);
> +}
> +
> +type_init(acpi_ged_x86_register_types)
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 6abc74551a72..622739305882 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -17,4 +17,5 @@ obj-$(CONFIG_PC) += port92.o
>  
>  obj-y += kvmvapic.o
>  obj-$(CONFIG_ACPI) += acpi-common.o
> +obj-$(CONFIG_ACPI_HW_REDUCED) += generic_event_device_x86.o
>  obj-$(CONFIG_PC) += acpi-build.o


