Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D2C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B0620757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNGpCRCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B0620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJKg-0001DG-7s
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKJJP-0008Na-L4
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKJJO-0004t4-Ds
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:12:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKJJO-0004sl-AI
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585908750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t0YYhjaAK8hEfqLUNGNiJrJbAza2xy65+XUQfLZoZTM=;
 b=eNGpCRCb/hLHlrLYZau6FLFV/1L69eo1O/17RKXq/Y8Y7ghe/s8O85J7HawEiNfaAtkuQN
 DH9E+i5vrQnyC7FTmGNzJBOxPWImg44lMFCOXNMK+W8eHO1HmbciChiLKDyuAlpklAFAs0
 wS01CXXHwpNg002aNGvnb7hiN/CIIpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-psO0wLVBPF29Jzm6h4e5gA-1; Fri, 03 Apr 2020 06:12:26 -0400
X-MC-Unique: psO0wLVBPF29Jzm6h4e5gA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2462A477;
 Fri,  3 Apr 2020 10:12:25 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6846D60BF1;
 Fri,  3 Apr 2020 10:12:12 +0000 (UTC)
Date: Fri, 3 Apr 2020 12:12:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 09/12] acpi: move aml builder code for parallel device
Message-ID: <20200403121210.30a010cb@redhat.com>
In-Reply-To: <20200403080502.8154-10-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-10-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  3 Apr 2020 10:04:59 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/char/parallel.c   | 25 +++++++++++++++++++++++++
>  hw/i386/acpi-build.c | 23 -----------------------
>  2 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 8dd67d13759b..2bff1f17fda7 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -28,6 +28,7 @@
>  #include "qemu/module.h"
>  #include "chardev/char-parallel.h"
>  #include "chardev/char-fe.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -568,6 +569,28 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>                               s, "parallel");
>  }
>  
> +static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    ISAParallelState *isa = ISA_PARALLEL(isadev);
> +    Aml *dev;
> +    Aml *crs;
> +
> +    if (isa->iobase != 0x0378) {
> +        return;
> +    }
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
> +    aml_append(crs, aml_irq_no_flags(7));
> +
> +    dev = aml_device("LPT");
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>  /* Memory mapped interface */
>  static uint64_t parallel_mm_readfn(void *opaque, hwaddr addr, unsigned size)
>  {
> @@ -624,9 +647,11 @@ static Property parallel_isa_properties[] = {
>  static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = parallel_isa_realizefn;
>      dc->vmsd = &vmstate_parallel_isa;
> +    isa->build_aml = parallel_isa_build_aml;
>      device_class_set_props(dc, parallel_isa_properties);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 81805bf85f8d..0539620ddff5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1167,28 +1167,6 @@ static Aml *build_mouse_device_aml(void)
>      return dev;
>  }
>  
> -static void build_lpt_device_aml(Aml *scope)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    if (!memory_region_present(get_system_io(), 0x0378)) {
> -        return;
> -    }
> -
> -    dev = aml_device("LPT");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
> -    aml_append(crs, aml_irq_no_flags(7));
perhaps fetch values from device instead of hard-coding them

> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    aml_append(scope, dev);
> -}
> -
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> @@ -1202,7 +1180,6 @@ static void build_isa_devices_aml(Aml *table)
>      if (fdc) {
>          aml_append(scope, build_fdc_device_aml(fdc));
>      }
> -    build_lpt_device_aml(scope);
>  
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");


