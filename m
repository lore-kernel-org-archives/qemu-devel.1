Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3E3CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E83F205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 22:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E83F205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPJg-0003WG-JX
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 18:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPIH-0001b5-Nj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPIG-0000BO-Ib
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:39:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPIG-0000Ao-At
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:39:52 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5267F3B77
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:39:51 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id e25so11193869wra.9
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q2d+e4Ggzpxfb7QDQFDgQozuUXUmaOle5Uf7KEetu8g=;
 b=HSI33d5QvDrN2o64M0LdORtlTkUREt+LstBN6MqqcBg6D1hPxbn87VrXeY1OyUS7Hf
 LbRBQHL8eXJwbvdP6kOAWr3RH83xYObqQi+O0rWuNl1UjvIjJWyYhg0VC9bBHCRFDB4X
 z9xZ5cuDg3ocYfFCbX/IBN8z7klw6rSAvVDUDB1zER7+q95jPoKuYJrHZ9SHcOzu3ir2
 7ZxTxnS6DRlCeGQTkpX31mGYQLPzq2OBJ0md4+ZBY933D1yJNUpdzs/wkfjVZ4N+ICU1
 GJ3gzmUOylW024VPNanb2fXeKTZ9y35GRL2fpgjzxsyDs2VC9I5j8RRE0Xxi7MZkRexD
 S5Rg==
X-Gm-Message-State: APjAAAXBs+Qm/CgEtuzDve28WiVvGx1McmYwAcBaOimtflXkdtKOvcop
 1tAtt49MBUtyFmq6IbEMHvqAI15oDDZrEEs1tMGYgYPdw2nJhNR5aVF5k+mWukLdq/E78LzOW5z
 6BAUQafB29yYfhnE=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr849153wrv.86.1571870389981;
 Wed, 23 Oct 2019 15:39:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHjLMLsJ/c9ILJPgs9Jpx05bJ5HFCLDlYbOCdQvL7eeZ5wsNuG7Goum5tlBM9m8pcbxMptYA==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr849135wrv.86.1571870389796;
 Wed, 23 Oct 2019 15:39:49 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id q196sm1171454wme.23.2019.10.23.15.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 15:39:49 -0700 (PDT)
Subject: Re: [PATCH v3 08/33] serial: add "chardev" property
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-9-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5190425d-1246-3eaa-dcb7-84cc346a7102@redhat.com>
Date: Thu, 24 Oct 2019 00:39:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 7:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> This is more QOM-friendly, callers may set/get the property themself.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 4af8b0ce4c..09e89727a6 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -34,6 +34,7 @@
>   #include "sysemu/runstate.h"
>   #include "qemu/error-report.h"
>   #include "trace.h"
> +#include "hw/qdev-properties.h"
>  =20
>   //#define DEBUG_SERIAL
>  =20
> @@ -988,7 +989,7 @@ SerialState *serial_init(int base, qemu_irq irq, in=
t baudbase,
>  =20
>       s->irq =3D irq;
>       s->baudbase =3D baudbase;
> -    qemu_chr_fe_init(&s->chr, chr, &error_abort);
> +    qdev_prop_set_chr(dev, "chardev", chr);
>       serial_realize_core(s, &error_fatal);
>       qdev_set_legacy_instance_id(dev, base, 2);
>       qdev_init_nofail(dev);
> @@ -999,11 +1000,17 @@ SerialState *serial_init(int base, qemu_irq irq,=
 int baudbase,
>       return s;
>   }
>  =20
> +static Property serial_properties[] =3D {
> +    DEFINE_PROP_CHR("chardev", SerialState, chr),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void serial_class_init(ObjectClass *klass, void* data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>  =20
>       dc->vmsd =3D &vmstate_serial;
> +    dc->props =3D serial_properties;
>   }
>  =20
>   static const TypeInfo serial_info =3D {
> @@ -1064,7 +1071,7 @@ SerialState *serial_mm_init(MemoryRegion *address=
_space,
>       s->it_shift =3D it_shift;
>       s->irq =3D irq;
>       s->baudbase =3D baudbase;
> -    qemu_chr_fe_init(&s->chr, chr, &error_abort);
> +    qdev_prop_set_chr(dev, "chardev", chr);
>  =20
>       serial_realize_core(s, &error_fatal);
>       qdev_set_legacy_instance_id(dev, base, 2);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

