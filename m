Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED639C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36042177B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 20:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6dcIsiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36042177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOq8I-0002Oy-19
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 16:59:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOq75-0001fF-2Z
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOq73-0002LO-8k
	for qemu-devel@nongnu.org; Thu, 09 May 2019 16:57:59 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOq71-0002JW-DU; Thu, 09 May 2019 16:57:56 -0400
Received: by mail-lf1-x144.google.com with SMTP id v18so2588643lfi.1;
	Thu, 09 May 2019 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=1gUsH8RD9e4/YMZn7Mv0dErig9AgWg5mBmnpGnGRHKI=;
	b=U6dcIsiAWIxN5BWKQfjVWH09XLFotGbw4ZijEh08TE0qr1hcW3so8k4ConStN07TJn
	1qJGxYq3eg9ZzbW/Q6awOlnd/yoIht9Qer0HymhCPLZ/xrdtkXMJKVXtRKG0cC2mshnK
	jzhOWg72JYxSv1d4Pc75otQfqAC1YTMIGS2m4g0dB/OWOPiXFbQrLJKsYavp3PxjgokN
	WpkNAeENQNfitL09VM01ulzOX+l0ZKH30BlZOgJ4y1HFKByAmH14bbl3IbSxWUZHt5yK
	S5lHLiAxEjLVZ96andYrN750VcCjSgzsBCzsmSng+Pub8ULYmjGyfYTHQv7gbIDvISr9
	K9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=1gUsH8RD9e4/YMZn7Mv0dErig9AgWg5mBmnpGnGRHKI=;
	b=atFWgxgzEHY+tyrYXeQWMt7HTPTRtxD1eFtfFgSSbayAqAV54lDwcCnYa0AM9P62GE
	iWA8TFvjbK/Xd7Hb0S/a8bd97zWrD4eS3RvmT9MXaNNLjYROHeauu6681yhHMjEGKVDI
	yqPceOMWUrwaCZtSendQH/2uLsXKMxvHk9gBg+AXLU2zQ3HO9tIjNNtW6Gpq+A3DtIfk
	jNXERQ62D4N7n7uKFiYwsSnNCABPMNVmMbrHNObP3JN0r+wJA77YK9MOOMyOznSXFgYh
	iagsxzoNSbVNCR77GvfoyiVCUXLANHQRqtK39kgtYZzhGBETb1GnfJulBH4Ws23KHn7j
	RIPg==
X-Gm-Message-State: APjAAAVXjQBOCNrPImuTDtSirRRViUqyOtj3dKRJvptVLgsy+BlnvCHG
	RrsMUgKmy+0v2SGpeG2ycEaCOu2TLNjbX5/LXBg=
X-Google-Smtp-Source: APXvYqzlWAsL44wXHRxYI2Ee2C4Karx+HKhmdMziH5eALOZpvNDSVtJDmJ2iMun6soNNzqUvLpjM+YdwiNNL9dZIkrY=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr3634344lfl.118.1557435472816; 
	Thu, 09 May 2019 13:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-6-philmd@redhat.com>
In-Reply-To: <20190507163416.24647-6-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 13:55:45 -0700
Message-ID: <CAKmqyKO+drSjQ1x9J6HkjA0kJZ3qdq2TZnMvB7=5Gf+qAZ4Bsg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v2 05/16] hw/arm/bcm2835: Use
 object_initialize() on PL011State
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

On Tue, May 7, 2019 at 9:42 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> To be coherent with the other peripherals contained in the
> BCM2835PeripheralState structure, directly allocate the PL011State
> (instead of using the pl011 uart as a pointer to a SysBusDevice).
>
> Initialize the PL011State with object_initialize() instead of
> object_new().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/bcm2835_peripherals.c         | 14 +++++++-------
>  include/hw/arm/bcm2835_peripherals.h |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 7ffb51b6927..2931a82a25a 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -46,9 +46,9 @@ static void bcm2835_peripherals_init(Object *obj)
>      qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
>
>      /* UART0 */
> -    s->uart0 =3D SYS_BUS_DEVICE(object_new(TYPE_PL011));
> -    object_property_add_child(obj, "uart0", OBJECT(s->uart0), NULL);
> -    qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
> +    object_initialize(&s->uart0, sizeof(s->uart0), TYPE_PL011);
> +    object_property_add_child(obj, "uart0", OBJECT(&s->uart0), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->uart0), sysbus_get_default());
>
>      /* AUX / UART1 */
>      object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
> @@ -166,16 +166,16 @@ static void bcm2835_peripherals_realize(DeviceState=
 *dev, Error **errp)
>      sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
>
>      /* UART0 */
> -    qdev_prop_set_chr(DEVICE(s->uart0), "chardev", serial_hd(0));
> -    object_property_set_bool(OBJECT(s->uart0), true, "realized", &err);
> +    qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
> +    object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
>
>      memory_region_add_subregion(&s->peri_mr, UART0_OFFSET,
> -                                sysbus_mmio_get_region(s->uart0, 0));
> -    sysbus_connect_irq(s->uart0, 0,
> +                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart0), 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart0), 0,
>          qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
>                                 INTERRUPT_UART));
>      /* AUX / UART1 */
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
> index 959508d57dd..e79c21771fe 100644
> --- a/include/hw/arm/bcm2835_peripherals.h
> +++ b/include/hw/arm/bcm2835_peripherals.h
> @@ -38,7 +38,7 @@ typedef struct BCM2835PeripheralState {
>      MemoryRegion ram_alias[4];
>      qemu_irq irq, fiq;
>
> -    SysBusDevice *uart0;
> +    PL011State uart0;
>      BCM2835AuxState aux;
>      BCM2835FBState fb;
>      BCM2835DMAState dma;
> --
> 2.20.1
>
>

