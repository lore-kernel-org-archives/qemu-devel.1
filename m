Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D9C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C049A2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDF4gRkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C049A2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOq70-0001VM-1T
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:57:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOq6A-0001D7-CG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOq68-00020D-Sd
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:57:02 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOq68-0001zS-Fq; Thu, 09 May 2019 16:57:00 -0400
Received: by mail-lj1-x242.google.com with SMTP id j24so2434721ljg.1;
	Thu, 09 May 2019 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=VYAcRdT/mb3BHhDgApPEA9BvSdyHhy6Gi1+JCxkx5oI=;
	b=BDF4gRktlRQZFUXk23niQPLbuJDmanPaydeDWXJx4IwKiRJgYZ4UZdJbqqcWqrsuXD
	SakAwUNklTfZ/4dlOuPYiDygKdPOppiC1UsMMJBe7Hw+p/UOIrymvtOYOZdtFiVI3IVn
	f2dl/0Lmh/aXTxyKt2mnJVjc2GyPHcWPgzmzpxEWnIgcq4jviYraevuo/MACC7sQUL+e
	kiiFwR7F9SetJwIXf6MxGPiHw9NoUiVGVAJtSelw+js+D8GnoRJqVJFvQMdlhIEzmVtO
	/1BRNhALezCI/orWlHu3pLz1iQ5GZW37wDWmivmdmb1oBWvjfb5xSDIlxk7/bZ4VqqVL
	fytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=VYAcRdT/mb3BHhDgApPEA9BvSdyHhy6Gi1+JCxkx5oI=;
	b=pALrfCxC9gWbb51j8D2/7vRJdWMSB8gq940nVQvkuKJnONQ2iYjYFevx0bIkv49hC4
	wbtoo4D1hQUoVyoh4g3pTnBbhFhPPylVAXebewTyAfQgrH+hugetuf5Yo4PfT6GBfoCS
	PEP/3JntWmZ4HrZ0TSkLedbChFTMPYPnycfH16Icrp3HnOr30SfLcgDDaX0bhJb5iUXd
	7CO04MXISFKFTLwV4qr6UE00nWLLQO5gTy2TEkeggzzBq2Pf38EZQ3oleWao2bIiDWYB
	w3IwnHGVHw/pNbg+Yz+xvVgMpYV+1K9vU8t7M/JbtdLA+NE3hjl1eV23V3yVg6LFLjuE
	foXQ==
X-Gm-Message-State: APjAAAX2rd5GXeW9M4w6dMl6ApiFLmhakhFyQlN9tqTp7Tuh/NRDEX2Z
	qu6QrdhRwyVtFWIQ/ArhKp5sq7Xy4XIYQtKNbNM=
X-Google-Smtp-Source: APXvYqwazAyvVzvZRaK9AqKEfl1MDLUv0JuYRxyDdww7IYSit0EQHBK9G1qKhoOtlrfJvOpIB4hf7Wrka2YVo/cHMm0=
X-Received: by 2002:a2e:9692:: with SMTP id q18mr3418371lji.89.1557435417716; 
	Thu, 09 May 2019 13:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-5-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-5-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:54:50 -0700
Message-ID: <CAKmqyKMzRiAsd+wazeY9ExAkWBs4p0DMsTHThKMMFciaLFED=w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 04/16] hw/arm/bcm2835: Use TYPE_PL011
 instead of hardcoded string
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paul Burton <pburton@wavecomp.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	"open list:New World" <qemu-ppc@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 9:41 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/bcm2835_peripherals.c         | 2 +-
>  include/hw/arm/bcm2835_peripherals.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 6be7660e8cb..7ffb51b6927 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -46,7 +46,7 @@ static void bcm2835_peripherals_init(Object *obj)
>      qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
>
>      /* UART0 */
> -    s->uart0 =3D SYS_BUS_DEVICE(object_new("pl011"));
> +    s->uart0 =3D SYS_BUS_DEVICE(object_new(TYPE_PL011));
>      object_property_add_child(obj, "uart0", OBJECT(s->uart0), NULL);
>      qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
>
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
> index f5b193f6707..959508d57dd 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -13,6 +13,7 @@
>
>  #include "qemu-common.h"
>  #include "hw/sysbus.h"
> +#include "hw/char/pl011.h"
>  #include "hw/char/bcm2835_aux.h"
>  #include "hw/display/bcm2835_fb.h"
>  #include "hw/dma/bcm2835_dma.h"
> --
> 2.20.1
>
>

