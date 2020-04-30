Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E4C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29B9214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyCzopMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29B9214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU34L-0001BX-RP
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU327-00081n-Ie
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU31R-0002EV-Ff
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:50:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23861
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU31R-0002E2-0P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588229412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEoUyM8z+SxuMv2oFeJZNldCnqreSkX/hmouxBficDg=;
 b=HyCzopMYAemwOkr/S4vAv3s7rU+UfR0w0HC0ixSp1bjfq+gNNhOJWdkVL1jLwD5uxH6Tjh
 fTgeJQdOUV6ErT6DZpunXoppO/psB/k9nizS5HjjJTmBxV3caxbBs/OGmDJ2vac7+QIq5Q
 uSUZQzhwP0TDhSjamOhXRftTfbIZbT0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-47Wy_GGqOFKjwgnEXl63Yg-1; Thu, 30 Apr 2020 02:50:10 -0400
X-MC-Unique: 47Wy_GGqOFKjwgnEXl63Yg-1
Received: by mail-wm1-f72.google.com with SMTP id n127so179230wme.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 23:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p1FPe2/Vcoa5nFndeZfbNGfgxbzh9VV+0OWLJY+KWOg=;
 b=gXcry8IMq22gRarqJVH15QOiH2MVzxtAaiFGespTLUOodV53/mIX9yC8snHKSR//xi
 b6W30h20TI8vnLYs58zaC3yqhWowsqIYZkBc8VYqCsTQb+hyeAWpNvCttbumyBHDGqMd
 Fbvb5rmAEX44opxFzXxiFaPzPzZ0u+8mShzxprlhQauIj3Qc+oGP+LKIOGFyDC9UVDb3
 8TM1s2bcXpihy0ldMLYRnEcjDEIy6mrHgo1E8IirB902J5jyq9fdF5igKrFWpmRgm0Yr
 NQgWsugFJ8vXotFQK5UhWA9QIsOEbO7RNAUhMIPmTeyVRkJ8eA5zbkZ2foxMBGWGJ9By
 HR4w==
X-Gm-Message-State: AGi0PuaY7v3unX33eEdBcfJF0+B6RXbRS4kQyjWOQuvuLFcihx1AY9kp
 g5Ip1h6ZCF5JIQCQlMC7/5gC6RJhnm/t9gHGPqjHxASX4G7qY94ZmX2UvhwloYI/QeYKhMRM1sJ
 U/6T6ZZjMWXCvp8c=
X-Received: by 2002:a7b:c399:: with SMTP id s25mr1181214wmj.169.1588229409018; 
 Wed, 29 Apr 2020 23:50:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHJO5Ht8EBuI+OnWYGqFic+IUnQC82mlyiZyFG+QwOt85Tu/pZX61jch5sK1WsAtuZrOELVg==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr1181179wmj.169.1588229408786; 
 Wed, 29 Apr 2020 23:50:08 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id q143sm11660841wme.31.2020.04.29.23.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 23:50:08 -0700 (PDT)
Subject: Re: [PATCH v3 13/15] acpi: move aml builder code for i8042
 (kbd+mouse) device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-14-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9661537b-dc9c-7ad1-59c5-eedd4738a925@redhat.com>
Date: Thu, 30 Apr 2020 08:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-14-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 4:00 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/i386/acpi-build.c | 39 ---------------------------------------
>   hw/input/pckbd.c     | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+), 39 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 7415bd5fdce0..643e875c05a5 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1052,42 +1052,6 @@ static void build_hpet_aml(Aml *table)
>       aml_append(table, scope);
>   }
>  =20
> -static Aml *build_kbd_device_aml(void)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    dev =3D aml_device("KBD");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs =3D aml_resource_template();
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
> -    dev =3D aml_device("MOU");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs =3D aml_resource_template();
> -    aml_append(crs, aml_irq_no_flags(12));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    return dev;
> -}
> -
>   static void build_isa_devices_aml(Aml *table)
>   {
>       bool ambiguous;
> @@ -1095,9 +1059,6 @@ static void build_isa_devices_aml(Aml *table)
>       Aml *scope =3D aml_scope("_SB.PCI0.ISA");
>       Object *obj =3D object_resolve_path_type("", TYPE_ISA_BUS, &ambiguo=
us);
>  =20
> -    aml_append(scope, build_kbd_device_aml());
> -    aml_append(scope, build_mouse_device_aml());
> -
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI d=
ata");
>       } else if (!obj) {
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 60a41303203a..29d633ca9478 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -26,6 +26,7 @@
>   #include "qemu/log.h"
>   #include "hw/isa/isa.h"
>   #include "migration/vmstate.h"
> +#include "hw/acpi/aml-build.h"
>   #include "hw/input/ps2.h"
>   #include "hw/irq.h"
>   #include "hw/input/i8042.h"
> @@ -561,12 +562,42 @@ static void i8042_realizefn(DeviceState *dev, Error=
 **errp)
>       qemu_register_reset(kbd_reset, s);
>   }
>  =20
> +static void i8042_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    Aml *kbd;
> +    Aml *mou;
> +    Aml *crs;
> +
> +    crs =3D aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
> +    aml_append(crs, aml_irq_no_flags(1));
> +
> +    kbd =3D aml_device("KBD");
> +    aml_append(kbd, aml_name_decl("_HID", aml_eisaid("PNP0303")));
> +    aml_append(kbd, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(kbd, aml_name_decl("_CRS", crs));
> +
> +    crs =3D aml_resource_template();
> +    aml_append(crs, aml_irq_no_flags(12));
> +
> +    mou =3D aml_device("MOU");
> +    aml_append(mou, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
> +    aml_append(mou, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(mou, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, kbd);
> +    aml_append(scope, mou);
> +}
> +
>   static void i8042_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
>  =20
>       dc->realize =3D i8042_realizefn;
>       dc->vmsd =3D &vmstate_kbd_isa;
> +    isa->build_aml =3D i8042_build_aml;
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>   }
>  =20
>=20


