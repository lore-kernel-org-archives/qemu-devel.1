Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8672DCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594F520663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594F520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNPcA-0007qN-I1
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 19:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNPaz-0005yX-CT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNPay-0007Oj-5D
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNPax-0007OM-TC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 18:59:12 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D890236955
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 22:59:10 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k9so181995wmb.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 15:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A8pShqn1sFf+5CuP5YbMdjr2cWN7fqAJBWkMnOgx8RI=;
 b=bkHPCCuKnRvJ+AODUiaWmmQNxGeqrHY7n/4+tX3bKD16Sl1Wu8ketA23juZzvo3KYZ
 WbeUhMpJ5IyM7XvK3I/UI42bb8q8fEhY5oD5WiBybsebPivLj/Qcpo//oXFJd3sKPmnT
 KU+QRCAGovcc46WrHx3GMQO39kXMo00+YMtVlT5OGxDGnphQG9gQyqZxrgPZo1xNJU37
 rMaljBgdbCvMq5PTZHgyEj3RPo7Cp8osVKgmza5WWOSRGuV7Urbm5cMRXyCX0rRP3GGb
 iXoiMky1vYlwD+TboRdimSUcEZD/DJ4WheTj1XwQ0cXk6MDkVPFpWnZoyKH3obahXCKM
 7AjA==
X-Gm-Message-State: APjAAAX0E8CXofYcAQExYaq+3fxu3PVxJr3rmyos6HeIuRZg2l7SQSBM
 eL9at24/58ptfJ2zHFOWVw5fqXM1CoxwQFY2tEsfWiUH/tJBMM9YhGItb+BJ9V3MxkjwVMcG+0M
 PsKI3rjj961OOhSo=
X-Received: by 2002:adf:db0e:: with SMTP id s14mr931771wri.341.1571871549499; 
 Wed, 23 Oct 2019 15:59:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIUsZA0I4uxRBisNTjRk4B5MBdNCW+E38xZPP7GUYzJnOAEVbcV4Bt4OYQT5rjFfHvO1ExvQ==
X-Received: by 2002:adf:db0e:: with SMTP id s14mr931746wri.341.1571871549270; 
 Wed, 23 Oct 2019 15:59:09 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id q25sm9077240wra.3.2019.10.23.15.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 15:59:08 -0700 (PDT)
Subject: Re: [PATCH v3 20/33] vmmouse: replace PROP_PTR with PROP_LINK
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-21-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8c5eefc2-6b6b-594d-bf55-02fc332c6ba7@redhat.com>
Date: Thu, 24 Oct 2019 00:59:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023173154.30051-21-marcandre.lureau@redhat.com>
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
> While at it, use the expected type.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/pc.c             | 6 +++---
>   hw/i386/vmmouse.c        | 8 +++-----
>   hw/input/pckbd.c         | 8 +++-----
>   include/hw/input/i8042.h | 4 +++-
>   4 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 00ee16ccab..021ec8c593 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1861,9 +1861,9 @@ static void pc_superio_init(ISABus *isa_bus, bool=
 create_fdctrl, bool no_vmport)
>           vmmouse =3D NULL;
>       }
>       if (vmmouse) {
> -        DeviceState *dev =3D DEVICE(vmmouse);
> -        qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
> -        qdev_init_nofail(dev);
> +        object_property_set_link(OBJECT(vmmouse), OBJECT(i8042),
> +                                 "i8042", &error_abort);
> +        qdev_init_nofail(DEVICE(vmmouse));
>       }
>       port92 =3D isa_create_simple(isa_bus, "port92");
>  =20
> diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> index 41ad91ad53..c0c329f817 100644
> --- a/hw/i386/vmmouse.c
> +++ b/hw/i386/vmmouse.c
> @@ -66,7 +66,7 @@ typedef struct VMMouseState
>       uint16_t status;
>       uint8_t absolute;
>       QEMUPutMouseEntry *entry;
> -    void *ps2_mouse;
> +    ISAKBDState *i8042;
>   } VMMouseState;
>  =20
>   static uint32_t vmmouse_get_status(VMMouseState *s)
> @@ -105,7 +105,7 @@ static void vmmouse_mouse_event(void *opaque, int x=
, int y, int dz, int buttons_
>  =20
>       /* need to still generate PS2 events to notify driver to
>          read from queue */
> -    i8042_isa_mouse_fake_event(s->ps2_mouse);
> +    i8042_isa_mouse_fake_event(s->i8042);
>   }
>  =20
>   static void vmmouse_remove_handler(VMMouseState *s)
> @@ -275,7 +275,7 @@ static void vmmouse_realizefn(DeviceState *dev, Err=
or **errp)
>   }
>  =20
>   static Property vmmouse_properties[] =3D {
> -    DEFINE_PROP_PTR("ps2_mouse", VMMouseState, ps2_mouse),
> +    DEFINE_PROP_LINK("i8042", VMMouseState, i8042, TYPE_I8042, ISAKBDS=
tate *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>  =20
> @@ -287,8 +287,6 @@ static void vmmouse_class_initfn(ObjectClass *klass=
, void *data)
>       dc->reset =3D vmmouse_reset;
>       dc->vmsd =3D &vmstate_vmmouse;
>       dc->props =3D vmmouse_properties;
> -    /* Reason: pointer property "ps2_mouse" */
> -    dc->user_creatable =3D false;
>   }
>  =20
>   static const TypeInfo vmmouse_info =3D {
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index f0acfd86f7..9b641021c9 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -483,17 +483,15 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mou=
se_irq,
>  =20
>   #define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
>  =20
> -typedef struct ISAKBDState {
> +struct ISAKBDState {
>       ISADevice parent_obj;
>  =20
>       KBDState kbd;
>       MemoryRegion io[2];
> -} ISAKBDState;
> +};
>  =20
> -void i8042_isa_mouse_fake_event(void *opaque)
> +void i8042_isa_mouse_fake_event(ISAKBDState *isa)
>   {
> -    ISADevice *dev =3D opaque;
> -    ISAKBDState *isa =3D I8042(dev);
>       KBDState *s =3D &isa->kbd;
>  =20
>       ps2_mouse_fake_event(s->mouse);
> diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
> index 246e6f3335..8eaebf50ce 100644
> --- a/include/hw/input/i8042.h
> +++ b/include/hw/input/i8042.h
> @@ -14,10 +14,12 @@
>  =20
>   #define I8042_A20_LINE "a20"
>  =20
> +typedef struct ISAKBDState ISAKBDState;
> +
>   void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
>                      MemoryRegion *region, ram_addr_t size,
>                      hwaddr mask);
> -void i8042_isa_mouse_fake_event(void *opaque);
> +void i8042_isa_mouse_fake_event(ISAKBDState *isa);
>   void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
>  =20
>   #endif /* HW_INPUT_I8042_H */
>=20

Nice!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

