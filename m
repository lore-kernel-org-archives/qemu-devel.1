Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0D7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2417D2071F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUNqQR+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2417D2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSi2-0001UY-Rw
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXSfk-0007VB-70
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXSfh-0001lK-Lg
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:17:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXSfh-0001ka-Hw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574266654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8W/LpO5pgqfsljlClWX+pu1ChwLcOGD53C5WQBONvI=;
 b=AUNqQR+EEAG9BDTZ2xFWGk4HCEoI1aujBsm0m3wEYcQZVQwjgF5cxoghPUgkl3GrttULT2
 WbkgEsQ3ocC8VXd3V5z4Q4LRqdf4DnRa0oJlmS4FSRAsABzTZC9iqv5a5MYjxWTR/Gq9GL
 ldPEklgzr/SiZ4A1HKnLxhILzigjTyY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-NwZhOim5MX6feNcsol_jDQ-1; Wed, 20 Nov 2019 11:17:33 -0500
Received: by mail-wr1-f72.google.com with SMTP id l3so21561542wrx.21
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E08CRqGH00uENqeWAg4OcZe8hUHYnXHRrYc1F94ICko=;
 b=lqVAJpqjq857iNu8eEIOSrpmakNbPmJnGxblXIs0/PWsyAXJwyTPQFvtSrO3fQ9kCM
 VnscgcIG5qwQsg8ylihF9DcKkMKF0LQCRLXTtY4imf0To5wkNKEwkhb4bMsdovfCPb4Q
 FZBktVNzHohoyPdOt+6yGOGF3XQEyiMOc39AeH+2mmTM5nv17HMiYRCuXMDzZfsOezqh
 379Ar792QyJPc0V9aojOB92fzqm1z9a6OO6wVMkRRxqIiyfbhd3xePjoqBbA6KoZKmUX
 fU8v7L3paw8D7HVJF5i7LQsYxU9Xv/gB/UVZCDy7dJrWO8ZD0DEwN2/gUrRFZhtAFxM5
 tuyA==
X-Gm-Message-State: APjAAAVIF7z8ePfmIyBT3qfSErMec6BT7EqZE9EzRgPKpSIf/77eVv+g
 c4QdMvtVEQx+vMGAKuScFUkiO3o755qtZoKkvpeVpnH0ag+1WLYYcBLTCRZ+JRURo3VaC4z7Aqh
 CHUT79A69GJDKr1g=
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr4332364wmc.143.1574266651975; 
 Wed, 20 Nov 2019 08:17:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVZ0WOsvpEXnj7ICDHGcSA3fppfOW0GspRiYXqQ7XbyVpsT6SGtL/4YDNIBbQa2SCYQq/2DA==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr4332331wmc.143.1574266651747; 
 Wed, 20 Nov 2019 08:17:31 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id p14sm32758026wrq.72.2019.11.20.08.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:17:31 -0800 (PST)
Subject: Re: [PATCH v4 17/37] mips: inline serial_init()
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-18-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a81bb9b0-fbc4-019d-5459-a6e046d7c37c@redhat.com>
Date: Wed, 20 Nov 2019 17:17:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-18-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: NwZhOim5MX6feNcsol_jDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> The function is specific to mipssim, let's inline it.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial.c         | 16 ----------------
>   hw/mips/mips_mipssim.c   | 15 ++++++++++++---
>   include/hw/char/serial.h |  2 --
>   3 files changed, 12 insertions(+), 21 deletions(-)
>=20
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 164146ede8..23f0b02516 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1023,22 +1023,6 @@ static const TypeInfo serial_io_info =3D {
>       .class_init =3D serial_io_class_init,
>   };
>  =20
> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> -                         Chardev *chr, MemoryRegion *system_io)
> -{
> -    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> -
> -    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
> -    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
> -    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
> -    qdev_init_nofail(DEVICE(sio));
> -
> -    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
> -    memory_region_add_subregion(system_io, base, &sio->serial.io);
> -
> -    return sio;
> -}
> -
>   static Property serial_properties[] =3D {
>       DEFINE_PROP_CHR("chardev", SerialState, chr),
>       DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 282bbecb24..bfafa4d7e9 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -40,6 +40,7 @@
>   #include "hw/loader.h"
>   #include "elf.h"
>   #include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
>   #include "exec/address-spaces.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/qtest.h"
> @@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)
>        * A single 16450 sits at offset 0x3f8. It is attached to
>        * MIPS CPU INT2, which is interrupt 4.
>        */
> -    if (serial_hd(0))
> -        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
> -                    get_system_io());
> +    if (serial_hd(0)) {
> +        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
> +
> +        qdev_prop_set_uint32(DEVICE(dev), "baudbase", 115200);
> +        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
> +        qdev_init_nofail(dev);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
> +        memory_region_add_subregion(get_system_io(), 0x3f8,
> +                                    &SERIAL_IO(dev)->serial.io);
> +    }
>  =20
>       if (nd_table[0].used)
>           /* MIPSnet uses the MIPS CPU INT0, which is interrupt 2. */
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index d356ba838c..535fa23a2b 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -108,8 +108,6 @@ void serial_set_frequency(SerialState *s, uint32_t fr=
equency);
>   #define TYPE_SERIAL_IO "serial-io"
>   #define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)
>  =20
> -SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> -                      Chardev *chr, MemoryRegion *system_io);
>   SerialMM *serial_mm_init(MemoryRegion *address_space,
>                            hwaddr base, int regshift,
>                            qemu_irq irq, int baudbase,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


