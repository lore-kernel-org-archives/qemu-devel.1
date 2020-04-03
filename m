Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F0FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A4920757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvBod/5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A4920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJ9X-0001DH-4A
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jKJ8R-0008SK-VP
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jKJ8Q-00078q-FJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:01:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jKJ8Q-000783-Ae
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585908069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKruF7v0noXtQUSlv3KIzvm1lgIaTvg/OJ5vbnaO0/s=;
 b=FvBod/5X0hkzwpEZ+733N+91kqbflDXxdpthTgNvWY5g7P2jxoiUFBHzP6uOhkAGOnGEX4
 8TCRNjSwIToKzq2iSHNC5fzphHdac1RYdfZt3j3XuOw+aBSchg3jZ3KQ3xDra0lQ7emzun
 JGEyqCCLk7tSnlYher5uWJKIPTtgZGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-zGuhiDvIOeGwtHbi4-gC_A-1; Fri, 03 Apr 2020 06:01:07 -0400
X-MC-Unique: zGuhiDvIOeGwtHbi4-gC_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5D738017F6;
 Fri,  3 Apr 2020 10:01:06 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6BD97AE8;
 Fri,  3 Apr 2020 10:00:54 +0000 (UTC)
Date: Fri, 3 Apr 2020 12:00:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 04/12] acpi: serial: don't use _STA method
Message-ID: <20200403120052.5a40bb3f@redhat.com>
In-Reply-To: <20200403080502.8154-5-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-5-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On Fri,  3 Apr 2020 10:04:54 +0200
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
I'd drop this patch and squash commit message into 8/12,
but I don't insist since get_system_io() added here is removed by 8/12,
so either way 

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


also for patches that modify DSDT, see comment at the start of tests/qtest/bios-tables-test.c
to make 'make check' happy and don't break tests during bisection 

> ---
>  hw/i386/acpi-build.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 214b98671bf2..08433a06039f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1218,50 +1218,34 @@ static Aml *build_lpt_device_aml(void)
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
> @@ -1279,8 +1263,8 @@ static void build_isa_devices_aml(Aml *table)
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


