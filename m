Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8AFC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183B52054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSMv12QR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183B52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOqh-0001ut-45
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jLOmF-0002uV-75
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jLOmD-0004mS-EF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jLOmD-0004lx-9u
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586168084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVuZ0YChZq1ZmbbPzp7f10giAdwnD+gJFtu8iupNPnw=;
 b=gSMv12QRtOFwh8EIeLHNEieymeFAUCqr3QwXy0A47a4rnekI1g9IpSNOc9Se12u2OKb2BI
 0HCrvKMAukjPGJ7iftM3+NgHoeuw+uvUtczoJEn/Cxn5dQu2/31GkuVyx7JkX/q9UX78yZ
 5XfMChhMwsVJPUJt82IiNjuFsBspVbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-ZcO69RTeMgijUAcFqhRrNA-1; Mon, 06 Apr 2020 06:14:40 -0400
X-MC-Unique: ZcO69RTeMgijUAcFqhRrNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E514107ACC4;
 Mon,  6 Apr 2020 10:14:39 +0000 (UTC)
Received: from localhost (unknown [10.40.208.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B868B60C18;
 Mon,  6 Apr 2020 10:14:36 +0000 (UTC)
Date: Mon, 6 Apr 2020 12:14:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200406121434.6e598842@redhat.com>
In-Reply-To: <20200403142308.82990-6-arilou@gmail.com>
References: <20200403142308.82990-1-arilou@gmail.com>
 <20200403142308.82990-6-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 qemu-devel@nongnu.org, Roman Kagan <rkagan@virtuozzo.com>, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Apr 2020 17:23:08 +0300
Jon Doron <arilou@gmail.com> wrote:

> Guest OS uses ACPI to discover vmbus presence.  Add a corresponding
> entry to DSDT in case vmbus has been enabled.
> 
> Experimentally Windows guests were found to require this entry to
> include two IRQ resources, so this patch adds two semi-arbitrarily
> chosen ones (7 and 13).  This results, in particular, in parallel port
> conflicting with vmbus.
> 
> TODO: discover and use spare IRQs to avoid conflicts.

CCing Vitaly
as he might know whom to ping wrt 'spec' that describes vmbus
and confirm  with ACPI tables that native hyperv generates.

 
> Signed-off-by: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  hw/i386/acpi-build.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2a7e55bae7..6d7fdbbe9b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -43,6 +43,7 @@
>  #include "hw/acpi/tpm.h"
>  #include "hw/acpi/vmgenid.h"
>  #include "hw/boards.h"
> +#include "hw/vmbus/vmbus.h"
>  #include "sysemu/tpm_backend.h"
>  #include "hw/rtc/mc146818rtc_regs.h"
>  #include "migration/vmstate.h"
> @@ -1270,6 +1271,43 @@ static Aml *build_com_device_aml(uint8_t uid)
>      return dev;
>  }
>  
> +static Aml *build_vmbus_device_aml(void)
> +{
> +    Aml *dev;
> +    Aml *method;
> +    Aml *crs;
> +
> +    dev = aml_device("VMBS");
> +    aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
> +    aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
> +    aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
> +
> +    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_and(aml_name("STA"), aml_int(0xD), NULL),
> +                                     aml_name("STA")));
> +    aml_append(dev, method);
> +
> +    method = aml_method("_PS0", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_or(aml_name("STA"), aml_int(0xF), NULL),
> +                                     aml_name("STA")));
> +    aml_append(dev, method);
> +
> +    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_store(aml_name("STA"), aml_local(0)));
> +    aml_append(method, aml_return(aml_local(0)));
> +    aml_append(dev, method);
does it need all that complicated _STA handling?
Would simple
   aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
work for you?

> +    aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_irq_no_flags(7));
> +    aml_append(crs, aml_irq_no_flags(13));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    return dev;
> +}
> +
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> @@ -1296,6 +1334,10 @@ static void build_isa_devices_aml(Aml *table)
>          build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
>      }
>  
> +    if (vmbus_exists()) {
> +        aml_append(scope, build_vmbus_device_aml());
> +    }
> +
>      aml_append(table, scope);
>  }
>  


