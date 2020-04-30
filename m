Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB47C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257E7208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFI6wud+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257E7208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCHI-0007Eq-9A
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUC3K-0001wu-Ei
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUC3B-0006h9-OX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42617
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jUC3B-0006g4-0N
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588264115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kq4pZnthQXOZnj0KLnnnXqqWshOnHvqSA8HHuHukXe0=;
 b=YFI6wud+Fd4LvtQ52BClriOKyTTfAXwT3cdyKiln0Ld9OrO3fQO0mFuvTUbyPKPKilh9SB
 OmXsHPmnMvIOrnMWlXjNM1P5Ag1VksGUr2zPMyvxnf6p+lMKJ/4MnQ0cBA8D5BXr08shuX
 hZRug543y4hr2ZiEyAgA4uVtouLjejM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-d6Fj5FDNPRq_0EtRQRI4Cw-1; Thu, 30 Apr 2020 12:28:32 -0400
X-MC-Unique: d6Fj5FDNPRq_0EtRQRI4Cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F83645F;
 Thu, 30 Apr 2020 16:28:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C68B38A;
 Thu, 30 Apr 2020 16:28:18 +0000 (UTC)
Date: Thu, 30 Apr 2020 18:28:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 13/15] acpi: move aml builder code for i8042
 (kbd+mouse) device
Message-ID: <20200430182817.7b8ba8f1@redhat.com>
In-Reply-To: <20200429140003.7336-14-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-14-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 16:00:01 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 39 ---------------------------------------
>  hw/input/pckbd.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 7415bd5fdce0..643e875c05a5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1052,42 +1052,6 @@ static void build_hpet_aml(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static Aml *build_kbd_device_aml(void)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    dev = aml_device("KBD");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
> -    aml_append(crs, aml_irq_no_flags(1));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    return dev;
> -}
> -
> -static Aml *build_mouse_device_aml(void)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    dev = aml_device("MOU");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_irq_no_flags(12));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    return dev;
> -}
> -
>  static void build_isa_devices_aml(Aml *table)
>  {
>      bool ambiguous;
> @@ -1095,9 +1059,6 @@ static void build_isa_devices_aml(Aml *table)
>      Aml *scope = aml_scope("_SB.PCI0.ISA");
>      Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
>  
> -    aml_append(scope, build_kbd_device_aml());
> -    aml_append(scope, build_mouse_device_aml());
> -
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");
>      } else if (!obj) {
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 60a41303203a..29d633ca9478 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -26,6 +26,7 @@
>  #include "qemu/log.h"
>  #include "hw/isa/isa.h"
>  #include "migration/vmstate.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/input/ps2.h"
>  #include "hw/irq.h"
>  #include "hw/input/i8042.h"
> @@ -561,12 +562,42 @@ static void i8042_realizefn(DeviceState *dev, Error **errp)
>      qemu_register_reset(kbd_reset, s);
>  }
>  
> +static void i8042_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    Aml *kbd;
> +    Aml *mou;
> +    Aml *crs;
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
> +    aml_append(crs, aml_irq_no_flags(1));
> +
> +    kbd = aml_device("KBD");
> +    aml_append(kbd, aml_name_decl("_HID", aml_eisaid("PNP0303")));
> +    aml_append(kbd, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(kbd, aml_name_decl("_CRS", crs));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_irq_no_flags(12));
> +
> +    mou = aml_device("MOU");
> +    aml_append(mou, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
> +    aml_append(mou, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(mou, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, kbd);
> +    aml_append(scope, mou);
> +}
> +
>  static void i8042_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = i8042_realizefn;
>      dc->vmsd = &vmstate_kbd_isa;
> +    isa->build_aml = i8042_build_aml;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>  


