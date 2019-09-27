Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8544C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800CB21655
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSCa2Zgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800CB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDy8T-0006w5-V6
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDy1P-0002x8-AG
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDy1N-00060E-5S
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:43:27 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDy1M-0005yh-NZ; Fri, 27 Sep 2019 17:43:24 -0400
Received: by mail-lj1-x242.google.com with SMTP id a22so3906633ljd.0;
 Fri, 27 Sep 2019 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z3z2HJgtQRyIS4euPZSz8ASTQEQCVryL16ycqUnflPw=;
 b=HSCa2Zgh3JXvYXQ9jzo1JGDOnRbDrBcm6DTlsC9pHobFxgumNJOj2C2lbElJbxtMKk
 ImUjp8UgjfL8Plqn9ARocJ56YgGV81zQ01+m8CPMqIOx91EzuTF52XDdR58mZbaVv5mj
 5jHnyrdN9F6vPitNI2K3C3GEEIOW7ivb8/i/X3cNAWAdfdWUMvfq/h1VLEQiOJj/T2ic
 QYw8rBzIp1S17bssKfC4/v5cVWXQ/oDbsUxoXkNksTp6mYwELAAWQuN2dNSpXfEKj5cf
 MVVxvNn2/rN0+Ra4t8qjtZhVaz/GOQd71gYCI0eeDqxYCMSCMC8HlnLQWrYzMzwxWWq/
 Q7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z3z2HJgtQRyIS4euPZSz8ASTQEQCVryL16ycqUnflPw=;
 b=H0ataQ+jpJ8WzwnFxPDM04vs2tdry/DAloP44L0ewzHSntQ7UbmftuH4DkFfI5EA9n
 gKOaG9HmcZFwMFqjq/KOSykBZlbeEjVcEyIFjBuhwmOc9H0iS7Wut1iN72z2kPfUueE/
 Rjn5G4iwaHqBtGkibEAb/+BiIhqBDykbRuKcQqIQfdHwFdx2FiDxuTvFZcinTWm8+YIS
 9CBCZWFnWXeqO919l8FmoU9/S/kVufh8xyW2tkJUjCA2bjDUDsZ+/YB+GNe2QbqgDM0i
 STeOaLXJ+tw+rXTMqoyTybp1iYJov50qRFwYhVaCTXl5SwiNNQ3EBihQDhXGs8thNesS
 e8ig==
X-Gm-Message-State: APjAAAXSlDYXnIXaQqFwA7RcoxUQ0zJ0fpx761Sf0WiUkN4Ne07ZdPjp
 LN2kt7bJeL4MG3O48rdYqu06kkX6MMyj2Scpc00=
X-Google-Smtp-Source: APXvYqychEopiXHGb+HjBrDuWH9HVQ/+04lbY2tpnbFmteoP9JUNeXPLDcr4OQQ57QU3Gzu1jLxpEbhreqQs7FfZC+4=
X-Received: by 2002:a2e:3902:: with SMTP id g2mr4450813lja.196.1569620603159; 
 Fri, 27 Sep 2019 14:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-4-f4bug@amsat.org>
In-Reply-To: <20190926173428.10713-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:38:36 -0700
Message-ID: <CAKmqyKOOo5nRSiSHWXKUMLR_pMbZexzY_N3a014tbZNgEgoTGQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] hw/arm/bcm2835_peripherals: Name various address
 spaces
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 10:36 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Various address spaces from the BCM2835 are reported as
> 'anonymous' in memory tree:
>
>   (qemu) info mtree
>
>   address-space: anonymous
>     0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
>       0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
>       0000000000000080-000000000000008f (prio 0, i/o): bcm2835-property
>
>   address-space: anonymous
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peri=
pherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>
>   [...]
>
> Since the address_space_init() function takes a 'name' argument,
> set it to correctly describe each address space:
>
>   (qemu) info mtree
>
>   address-space: bcm2835-mbox-memory
>     0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
>       0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
>       0000000000000080-000000000000008f (prio 0, i/o): bcm2835-property
>
>   address-space: bcm2835-fb-memory
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peri=
pherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>
>   address-space: bcm2835-property-memory
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peri=
pherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>
>   address-space: bcm2835-dma-memory
>     0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
>       0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peri=
pherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
>       0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>       00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-=
ram-alias[*] @ram 0000000000000000-000000003fffffff
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/bcm2835_fb.c    | 2 +-
>  hw/dma/bcm2835_dma.c       | 2 +-
>  hw/misc/bcm2835_mbox.c     | 2 +-
>  hw/misc/bcm2835_property.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index 8f856878cd..85aaa54330 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -425,7 +425,7 @@ static void bcm2835_fb_realize(DeviceState *dev, Erro=
r **errp)
>      s->initial_config.base =3D s->vcram_base + BCM2835_FB_OFFSET;
>
>      s->dma_mr =3D MEMORY_REGION(obj);
> -    address_space_init(&s->dma_as, s->dma_mr, NULL);
> +    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_FB "-memory")=
;
>
>      bcm2835_fb_reset(dev);
>
> diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
> index 6acc2b644e..1e458d7fba 100644
> --- a/hw/dma/bcm2835_dma.c
> +++ b/hw/dma/bcm2835_dma.c
> @@ -383,7 +383,7 @@ static void bcm2835_dma_realize(DeviceState *dev, Err=
or **errp)
>      }
>
>      s->dma_mr =3D MEMORY_REGION(obj);
> -    address_space_init(&s->dma_as, s->dma_mr, NULL);
> +    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_DMA "-memory"=
);
>
>      bcm2835_dma_reset(dev);
>  }
> diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
> index 7690b9afaf..77285624c9 100644
> --- a/hw/misc/bcm2835_mbox.c
> +++ b/hw/misc/bcm2835_mbox.c
> @@ -311,7 +311,7 @@ static void bcm2835_mbox_realize(DeviceState *dev, Er=
ror **errp)
>      }
>
>      s->mbox_mr =3D MEMORY_REGION(obj);
> -    address_space_init(&s->mbox_as, s->mbox_mr, NULL);
> +    address_space_init(&s->mbox_as, s->mbox_mr, TYPE_BCM2835_MBOX "-memo=
ry");
>      bcm2835_mbox_reset(dev);
>  }
>
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index 0a1a3eb5d9..43a5465c5d 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -407,7 +407,7 @@ static void bcm2835_property_realize(DeviceState *dev=
, Error **errp)
>      }
>
>      s->dma_mr =3D MEMORY_REGION(obj);
> -    address_space_init(&s->dma_as, s->dma_mr, NULL);
> +    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_PROPERTY "-me=
mory");
>
>      /* TODO: connect to MAC address of USB NIC device, once we emulate i=
t */
>      qemu_macaddr_default_if_unset(&s->macaddr);
> --
> 2.20.1
>
>

