Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C03C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF2120673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 11:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoNZXwbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF2120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnlI-0002VN-U7
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 07:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnj5-0000zo-QG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHnj0-0000u4-Ra
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:32:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHniy-0000qq-Rq
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 07:32:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id f22so2748827wmc.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ofj6Equz5xEgi6bS+/yltqkzQhKqD0+OdBLZGgmbhng=;
 b=LoNZXwbL84biY2OTDkIFEZZdtYaKHDEqC71k/DXh8WmTmhBjkLSWLjtxA3ZMp+cek6
 KNu136QBy5m2k8D8ecKcN51X4DBwX4zrwoMDp6sr87FeBpu2i64PUmP8x5rkCppqf9Kn
 YcIMaTdp5S+xWL5k2+/80AGNZY2FkEDueCrtLJ1V62JTzRljQ7Yhl+HjO/61MVviglLw
 WLsF7v7wSCheoKV1DOwg9Eaw4MLSrNODTZt4D6lP71Xf50TNlfCbDhmhBpsuqoC93MC5
 /NwpM8LDiv6hReXJg3RUljeZzMQW2sHG1Rlj0jn1NC6y6KIWY9f3uYeDWnEr8fTe0edP
 i3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ofj6Equz5xEgi6bS+/yltqkzQhKqD0+OdBLZGgmbhng=;
 b=hX/t5/GyuOaA8Afvg3TX2HVPe6FOWRfcrGbX1lswDP42PEFul/5x61OLjAZEq5BMIU
 aC3n9Kbr6SLo0qQ8HYbqacgdK1eQkz2fYxaCsCvcao8auwmYPV8KZARrS+4G7k4KFAln
 YMEf0gSGPpH6TpLZsaeVSAY9pgETRFQ+x4dnLTKkZVekes7+CHxytXOlf3sxAqQZbrso
 6H2eoLwoUTCSfLG64JnjuKxBqR3tuCIc0JewGgZF/GM2zXTFN3FYBaJyoCfcYeS7uHwl
 AIDc3FGSoC33t7O6G1zB4dWvdrDGDEiq5DhTbja1cc4BptC9ZAFClkAWXpbZIo5E3VK8
 eMTQ==
X-Gm-Message-State: APjAAAUv4Bm78eSOhWOOM55TNM0so63alvcmMF6ENBcjNVIMZLunwwuZ
 YM6tBGqPcVpdgoKhYXxXO2a7RQ==
X-Google-Smtp-Source: APXvYqzHX4aDAZoonQqjU8Y2ivFfqGpO7CmTrguy6AjfTrtya6Z49eHs1cINgD0zfelAd1PiHLyrkA==
X-Received: by 2002:a05:600c:48e:: with SMTP id
 d14mr3630238wme.175.1570534334307; 
 Tue, 08 Oct 2019 04:32:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y186sm6225902wmd.26.2019.10.08.04.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 04:32:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BDE2F1FF87;
 Tue,  8 Oct 2019 12:32:12 +0100 (BST)
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-8-f4bug@amsat.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 07/19] hw/misc/bcm2835_mbox: Add trace events
In-reply-to: <20190926173428.10713-8-f4bug@amsat.org>
Date: Tue, 08 Oct 2019 12:32:12 +0100
Message-ID: <87wodfiibn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 =?utf-8?Q?Zolt=C3=A1n?= Baldaszti <bztemail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Add trace events for read/write accesses and IRQ.
>
> Properties are structures used for the ARM particular MBOX.
> Since one call in bcm2835_property.c concerns the mbox block,
> name this trace event in the same bcm2835_mbox* namespace.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/misc/bcm2835_mbox.c     | 5 +++++
>  hw/misc/bcm2835_property.c | 2 ++
>  hw/misc/trace-events       | 6 ++++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
> index 77285624c9..77d2d80706 100644
> --- a/hw/misc/bcm2835_mbox.c
> +++ b/hw/misc/bcm2835_mbox.c
> @@ -15,6 +15,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>
>  #define MAIL0_PEEK   0x90
>  #define MAIL0_SENDER 0x94
> @@ -123,6 +124,7 @@ static void bcm2835_mbox_update(BCM2835MboxState *s)
>              set =3D true;
>          }
>      }
> +    trace_bcm2835_mbox_irq(set);
>      qemu_set_irq(s->arm_irq, set);

I'm kind surprised we don't have a common trace point for all IRQs.

>  }
>
> @@ -178,8 +180,10 @@ static uint64_t bcm2835_mbox_read(void *opaque, hwad=
dr offset, unsigned size)
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx=
"\n",
>                        __func__, offset);
> +        trace_bcm2835_mbox_read(size, offset, res);
>          return 0;
>      }
> +    trace_bcm2835_mbox_read(size, offset, res);
>
>      bcm2835_mbox_update(s);
>
> @@ -195,6 +199,7 @@ static void bcm2835_mbox_write(void *opaque, hwaddr o=
ffset,
>
>      offset &=3D 0xff;
>
> +    trace_bcm2835_mbox_write(size, offset, value);
>      switch (offset) {
>      case MAIL0_SENDER:
>          break;
> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
> index 43a5465c5d..0eea2e20f7 100644
> --- a/hw/misc/bcm2835_property.c
> +++ b/hw/misc/bcm2835_property.c
> @@ -13,6 +13,7 @@
>  #include "sysemu/dma.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>
>  /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interfa=
ce */
>
> @@ -283,6 +284,7 @@ static void bcm2835_property_mbox_push(BCM2835Propert=
yState *s, uint32_t value)
>              break;
>          }
>
> +        trace_bcm2835_mbox_property(tag, bufsize, resplen);
>          if (tag =3D=3D 0) {
>              break;
>          }
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 74276225f8..1deb1d08c1 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -143,3 +143,9 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsi=
gned size) "SSE-200 MHU wri
>
>  # aspeed_xdma.c
>  aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x=
%" PRIx64 " data 0x%" PRIx64
> +
> +# bcm2835_mbox.c
> +bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mb=
ox write sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
> +bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbo=
x read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
> +bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
> +bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "m=
box property tag:0x%08x in_sz:%u out_sz:%zu"

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

