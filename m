Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63083C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6EA2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbM8lpTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6EA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC72-0006Jl-7c
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUC0n-00060T-07
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUC0O-0003uD-SB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:26:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jUC0O-0003tp-AR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588263942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V82U2sYGinmEIVY+2iCP4flRXqmo7UGXvPo7A9OlMS4=;
 b=YbM8lpTlvYdHS95c4WiTxp0PXOlZGLhEFYDjcdgAqgDsCF9RQc3c5Zbo5s/DTDrfTsnTUA
 dyATpaCaXtYdfAdcqhYwepI2FURQ42wzPcwRZ06Z84U365fB/SbWrmW4WThk2pls7g8P2D
 zZS5qhc4rvUSDKFNMJ2oC34gFAQ1FQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-wJjc0NMCP0GpOfr1FAo0nA-1; Thu, 30 Apr 2020 12:25:40 -0400
X-MC-Unique: wJjc0NMCP0GpOfr1FAo0nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEB99872FE0;
 Thu, 30 Apr 2020 16:25:39 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBA1310013BD;
 Thu, 30 Apr 2020 16:25:26 +0000 (UTC)
Date: Thu, 30 Apr 2020 18:25:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 10/15] acpi: parallel: don't use _STA method
Message-ID: <20200430182524.5e6fd311@redhat.com>
In-Reply-To: <20200429140003.7336-11-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-11-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Wed, 29 Apr 2020 15:59:58 +0200
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
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

looking more at it, we should also cleanup no longer used LPEN field
the same applies to similar fields for serial and ... 


> ---
>  hw/i386/acpi-build.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index fea83352e6ab..e01afbd011d9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1167,39 +1167,26 @@ static Aml *build_mouse_device_aml(void)
>      return dev;
>  }
>  
> -static Aml *build_lpt_device_aml(void)
> +static void build_lpt_device_aml(Aml *scope)
>  {
>      Aml *dev;
>      Aml *crs;
> -    Aml *method;
> -    Aml *if_ctx;
> -    Aml *else_ctx;
> -    Aml *zero = aml_int(0);
> -    Aml *is_present = aml_local(0);
> +
> +    if (!memory_region_present(get_system_io(), 0x0378)) {
> +        return;
> +    }
>  
>      dev = aml_device("LPT");
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
>  
> -    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_store(aml_name("LPEN"), is_present));
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
>      aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
>      aml_append(crs, aml_irq_no_flags(7));
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
> -    return dev;
> +    aml_append(scope, dev);
>  }
>  
>  static void build_isa_devices_aml(Aml *table)
> @@ -1215,7 +1202,7 @@ static void build_isa_devices_aml(Aml *table)
>      if (fdc) {
>          aml_append(scope, build_fdc_device_aml(fdc));
>      }
> -    aml_append(scope, build_lpt_device_aml());
> +    build_lpt_device_aml(scope);
>  
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");


