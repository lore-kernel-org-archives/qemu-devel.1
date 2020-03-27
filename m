Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC768C2D0E5
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79079206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQvVLHrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79079206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHq4P-0000lS-LT
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 10:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHq3j-0000LD-OM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHq3g-00064u-T2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:34:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22009)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHq3g-00061e-JO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585319643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCwWcSTS4hQoQyZsHnoE5ZYmIj/Tv5/K6gelc7YfMC4=;
 b=ZQvVLHrcDn6ue4R8ubbhMBAcg4ylTZObVYS91iyreSlsGtP7Zu1uBxsK//3KHelWotfSB9
 V/8EUZksQRGsatuyyMKf3NGuv5u/vUdW48r5N5gLU5Jgu0DgEFLZeaka/wauFBNsI3L3om
 wIfAJ1oJF/5SiRvirgD/LImZ5igNNhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-Z--2zv7QO_uR488RTKjNGg-1; Fri, 27 Mar 2020 10:33:53 -0400
X-MC-Unique: Z--2zv7QO_uR488RTKjNGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8507B107ACC7;
 Fri, 27 Mar 2020 14:33:51 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A290F5DA85;
 Fri, 27 Mar 2020 14:33:41 +0000 (UTC)
Date: Fri, 27 Mar 2020 15:33:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/6] acpi: serial: don't use _STA method
Message-ID: <20200327153340.519fac3f@redhat.com>
In-Reply-To: <20200327121111.1530-6-kraxel@redhat.com>
References: <20200327121111.1530-1-kraxel@redhat.com>
 <20200327121111.1530-6-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 13:11:10 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The _STA method dates back to the days where we had a static DSDT.  The
> device is listed in the DSDT table unconditionally and the _STA method
> checks a bit in the isa bridge pci config space to figure whenever a
> given is isa device is present or not, then evaluates to 0x0f (present)
> or 0x00 (absent).
> 
> These days the DSDT is generated by qemu anyway, so if a device is not
> present we can simply drop it from the DSDT instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-build-pc.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/i386/acpi-build-pc.c b/hw/i386/acpi-build-pc.c
> index 18ca2fd46961..97af5eac3d79 100644
> --- a/hw/i386/acpi-build-pc.c
> +++ b/hw/i386/acpi-build-pc.c
> @@ -1204,50 +1204,34 @@ static Aml *build_lpt_device_aml(void)
>      return dev;
>  }
>  
> -static Aml *build_com_device_aml(uint8_t uid)
> +static void build_com_device_aml(Aml *scope, uint8_t uid)
>  {
>      Aml *dev;
>      Aml *crs;
> -    Aml *method;
> -    Aml *if_ctx;
> -    Aml *else_ctx;
> -    Aml *zero = aml_int(0);
> -    Aml *is_present = aml_local(0);
> -    const char *enabled_field = "CAEN";
>      uint8_t irq = 4;
>      uint16_t io_port = 0x03F8;
>  
>      assert(uid == 1 || uid == 2);
>      if (uid == 2) {
> -        enabled_field = "CBEN";
>          irq = 3;
>          io_port = 0x02F8;
>      }
> +    if (!memory_region_present(get_system_io(), io_port)) {
                                  ^^^^^^
even though acpi_setup() is a part of board code, usually it's not recommended to 
use get_system_foo() outside of machine_init()

how about fishing out present serial ports from isa device in a helper
like acpi_get_misc_info(), and then generalize AML like
   build_com_device_aml(Aml *scope, uint8_t uid, io_port, irq)
   

> +        return;
> +    }
>  
>      dev = aml_device("COM%d", uid);
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>  
> -    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_store(aml_name("%s", enabled_field), is_present));
> -    if_ctx = aml_if(aml_equal(is_present, zero));
> -    {
> -        aml_append(if_ctx, aml_return(aml_int(0x00)));
> -    }
> -    aml_append(method, if_ctx);
> -    else_ctx = aml_else();
> -    {
> -        aml_append(else_ctx, aml_return(aml_int(0x0f)));
> -    }
> -    aml_append(method, else_ctx);
> -    aml_append(dev, method);
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  
>      crs = aml_resource_template();
>      aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
>      aml_append(crs, aml_irq_no_flags(irq));
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
> -    return dev;
> +    aml_append(scope, dev);
>  }
>  
>  static void build_isa_devices_aml(Aml *table)
> @@ -1265,8 +1249,8 @@ static void build_isa_devices_aml(Aml *table)
>          aml_append(scope, build_fdc_device_aml(fdc));
>      }
>      aml_append(scope, build_lpt_device_aml());
> -    aml_append(scope, build_com_device_aml(1));
> -    aml_append(scope, build_com_device_aml(2));
> +    build_com_device_aml(scope, 1);
> +    build_com_device_aml(scope, 2);
>  
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");


