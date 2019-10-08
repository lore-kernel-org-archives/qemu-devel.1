Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E7FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9DD2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiz/5XeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9DD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlTA-0008HE-KN
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHlQL-00064S-Ul
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHlQJ-0001w6-Qq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:04:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHlQJ-0001u5-Dx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:04:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id z9so18381514wrl.11
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mC5ThNNuVFG3u2PgZlIwNW8UhDb/zSvWrbCucUIxMPw=;
 b=yiz/5XeX7cmQ2uL9TUsol1PriNU47Gln30g/5YfbAI4M2kwlczz2zncbqdrQ5hsXkO
 489x7Z3dtPU1+Pn3S0OGnSBATlovmU5234D8jkVEJak7UagUbPlQoT3zoZkAyFwhJd//
 7WNGH4vNRI0dMEOVGO9+HHNWLfyuqTV/koI+GnFwMFNk3qVj1uSWQOm1npXGZMeX5EgX
 WNJztYZZX+2m9qFsJUUlaqcjA2TJCX2zCKOrtwFFMQ28ABu6241WAmB2xpMRqsZAEP2s
 rZkyg58C4E0lwWBgiqLJibsiGQ31r4HSkO1MEPWoXrbyFipvCHZ/nWivxlcb2D1Rlzel
 nADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mC5ThNNuVFG3u2PgZlIwNW8UhDb/zSvWrbCucUIxMPw=;
 b=nfdF23Ru9DzNgcJmXT6PAnNqGHtv5zj4U8BO46gHrZHMycLVhNaIdO77FRI87nsC90
 QFPYxC24qEB6O1yPmuckCKMSjXsf8ip+ZkdSKBE8R7lrVNuG2U74xG9jT591j/KnxjcI
 uQqYXnJwFhOOEzZcC7uK8pC+mfTmWMdLz7kzElRV5hz4EfFzQ60C2D2ftx3pwCe/HkBf
 h3lZGO641wom6K43aLo/JG5qT5Zw/s82SvuLv0CSQlwiDM+VLcONf6kKvqp+Fb9hRWVT
 fhxMcitQGkvQUIhR9jsN/o2esNMnglEIYY/5+wT7X4RezK7rpJ3DU1jKEKyW31Joi8X7
 BPDw==
X-Gm-Message-State: APjAAAX61dt0OhpKvTdfeeWEV7ilaF1ijANHTA84RdnCo8bqGCdN1eWa
 8fV9MZqHrA4/5jvyQxPRy4RKog==
X-Google-Smtp-Source: APXvYqy22fBqzQjf2z4Y2SCynT0FUZ1n9AAJc/XeOz51pu0jNddDBfiEbDgk4Kq2gYNM4JQaSrBk2g==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr9205319wro.197.1570525489658; 
 Tue, 08 Oct 2019 02:04:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t6sm3594884wmf.8.2019.10.08.02.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 02:04:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B7681FF87;
 Tue,  8 Oct 2019 10:04:48 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-4-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH 03/19] hw/arm/bcm2835_peripherals: Name various address
 spaces
In-reply-to: <20190926173428.10713-4-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 10:04:48 +0100
Message-ID: <8736g3k3pr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Various address spaces from the BCM2835 are reported as
> 'anonymous' in memory tree:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

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
> +    address_space_init(&s->dma_as, s->dma_mr, TYPE_BCM2835_FB "-memory");
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


--
Alex Benn=C3=A9e

