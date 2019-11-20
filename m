Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704DEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374BD20659
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EH4KI8hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374BD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSkG-0004NW-B9
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXSgC-00088D-8j
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXSgA-0001uC-UW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:18:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXSgA-0001u1-Q5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574266686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U19FrPZpF5riIvGsUAyjV0qFROUnzE0CokTc1lb5HJk=;
 b=EH4KI8hnqcHcmlA5TG+kp7x3b8ncJn3FZuDEj2JMSjN5/kZcrcFViGTP0TWnwjDTaf2UWO
 h+li7pg7/hokoZU4IhJGbPo2/OAugglBZuZHhvD0/eA42dXWNtRunh/MlWPIY5RuNfDH83
 QbYc72ILUJ5fLZ/MG3TAn955GsOxn4o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-jYAuHnA9PsmIFZOvrjNhMg-1; Wed, 20 Nov 2019 11:18:04 -0500
Received: by mail-wr1-f71.google.com with SMTP id u2so21542330wrm.7
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KCtvv8PLmyMleB7Wu1gVp4ReBVJO28QvY0b2ZE4ZSoE=;
 b=GrIGehxUoLah9UsqUJfuymx08LsH6+GKPQVlPtV6BOyiv5AcyY0TzrLzizhjvdlZqy
 O51hy1eMxpicNAjD8lC3jwLF/6UQJl1BnyiWaK0OYKj3GfHmxIpnP8ZI2g0X2Wg2nS8C
 XfvIk1p0NHBdpHsyoO8wwDmBp60tdy/O+hdFqfNfmoJNqn9btRqv7ePUKkb69dgLO87U
 oXV1Joz65PWEqW0Ck6TR6X249a7cG2fX2OLypJRJHK9Dd2bt0P6MZyVg+0vBkFKsGsry
 H7VIrU0MCqqL6Amd9FkYuBb+/yuROLdyp4kcp2Laol07yRuj/+RToySzBSpoPdN03fVP
 GfGw==
X-Gm-Message-State: APjAAAWfh4z7B1qyIZQC1Jza3fveKgEitBUJVKetG3KE4s5/rHXNJ3/C
 C/CSqBFyAb/Lcu4JiaiTwLgZfgIttY8uQFBZnJWpuUmw68gsziTHRbKQhlojzzPI7giTYC7ChAw
 bAlm5j4tLJ7S6A5M=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr4067023wmi.107.1574266683423; 
 Wed, 20 Nov 2019 08:18:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBxV/pXWn0BRv0R2B0YLrJeKSC/6IUB78vdDE0CqhH4ccc/xSp9d1w7JL3EEhdOXqK0ukIFA==
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr4066995wmi.107.1574266683181; 
 Wed, 20 Nov 2019 08:18:03 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id g11sm7218477wmh.27.2019.11.20.08.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 08:18:02 -0800 (PST)
Subject: Re: [PATCH v4 16/37] serial: make SerialIO a sysbus device
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-17-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <445110f9-2db2-f995-da62-7dee03160bbd@redhat.com>
Date: Wed, 20 Nov 2019 17:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120152442.26657-17-marcandre.lureau@redhat.com>
Content-Language: en-US
X-MC-Unique: jYAuHnA9PsmIFZOvrjNhMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 4:24 PM, Marc-Andr=C3=A9 Lureau wrote:
> Make serial IO a proper sysbus device, similar to serial MM.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial.c         | 59 ++++++++++++++++++++++++++++++++--------
>   include/hw/char/serial.h | 13 +++++++--
>   2 files changed, 59 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index e0f1a99e8b..164146ede8 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -985,22 +985,58 @@ const MemoryRegionOps serial_io_ops =3D {
>       .endianness =3D DEVICE_LITTLE_ENDIAN,
>   };
>  =20
> -SerialState *serial_init(int base, qemu_irq irq, int baudbase,
> -                         Chardev *chr, MemoryRegion *system_io)
> +static void serial_io_realize(DeviceState *dev, Error **errp)
>   {
> -    DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL));
> -    SerialState *s =3D SERIAL(dev);
> +    SerialIO *sio =3D SERIAL_IO(dev);
> +    SerialState *s =3D &sio->serial;
>  =20
> -    s->irq =3D irq;
> -    qdev_prop_set_uint32(dev, "baudbase", baudbase);
> -    qdev_prop_set_chr(dev, "chardev", chr);
> -    qdev_set_legacy_instance_id(dev, base, 2);
> -    qdev_init_nofail(dev);
> +    qdev_init_nofail(DEVICE(s));
>  =20
>       memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8)=
;
> -    memory_region_add_subregion(system_io, base, &s->io);
> +    sysbus_init_irq(SYS_BUS_DEVICE(sio), &s->irq);
> +}
> +
> +static void serial_io_class_init(ObjectClass *klass, void* data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D serial_io_realize;
> +    /* No dc->vmsd: class has no migratable state */
> +}
> +
> +static void serial_io_instance_init(Object *o)
> +{
> +    SerialIO *sio =3D SERIAL_IO(o);
> +
> +    object_initialize_child(o, "serial", &sio->serial, sizeof(sio->seria=
l),
> +                            TYPE_SERIAL, &error_abort, NULL);
> +
> +    qdev_alias_all_properties(DEVICE(&sio->serial), o);
> +}
> +
> +
> +static const TypeInfo serial_io_info =3D {
> +    .name =3D TYPE_SERIAL_IO,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(SerialIO),
> +    .instance_init =3D serial_io_instance_init,
> +    .class_init =3D serial_io_class_init,
> +};
> +
> +SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> +                         Chardev *chr, MemoryRegion *system_io)
> +{
> +    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
> +
> +    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
> +    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
> +    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
> +    qdev_init_nofail(DEVICE(sio));
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
> +    memory_region_add_subregion(system_io, base, &sio->serial.io);
>  =20
> -    return s;
> +    return sio;
>   }
>  =20
>   static Property serial_properties[] =3D {
> @@ -1142,6 +1178,7 @@ static const TypeInfo serial_mm_info =3D {
>   static void serial_register_types(void)
>   {
>       type_register_static(&serial_info);
> +    type_register_static(&serial_io_info);
>       type_register_static(&serial_mm_info);
>   }
>  =20
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index d586924937..d356ba838c 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -88,6 +88,12 @@ typedef struct SerialMM {
>       uint8_t endianness;
>   } SerialMM;
>  =20
> +typedef struct SerialIO {
> +    SysBusDevice parent;
> +
> +    SerialState serial;
> +} SerialIO;
> +
>   extern const VMStateDescription vmstate_serial;
>   extern const MemoryRegionOps serial_io_ops;
>  =20
> @@ -99,8 +105,11 @@ void serial_set_frequency(SerialState *s, uint32_t fr=
equency);
>   #define TYPE_SERIAL_MM "serial-mm"
>   #define SERIAL_MM(s) OBJECT_CHECK(SerialMM, (s), TYPE_SERIAL_MM)
>  =20
> -SerialState *serial_init(int base, qemu_irq irq, int baudbase,
> -                         Chardev *chr, MemoryRegion *system_io);
> +#define TYPE_SERIAL_IO "serial-io"
> +#define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)
> +
> +SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
> +                      Chardev *chr, MemoryRegion *system_io);
>   SerialMM *serial_mm_init(MemoryRegion *address_space,
>                            hwaddr base, int regshift,
>                            qemu_irq irq, int baudbase,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


