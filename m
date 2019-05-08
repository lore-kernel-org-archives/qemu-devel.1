Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB361C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953C321655
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953C321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKTx-0001wZ-Rc
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:11:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKST-0000Mb-01
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:09:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKSN-0007fg-F4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:09:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKSN-0007eU-7i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:09:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so7383858wre.7
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kTeDAeJHTbTbhAf6Au5D/u+567YefQgAfLgDokL+9fI=;
	b=pZP+aOH89IskoFvqrZMzxCWisb5FeVEIonoV9xsaVAt/jY1MDkhLyHV6oIrupzBxGN
	aSJLuryMaE13WUXp5oJFK6CWk0k+YAJYi4AV3JAkz4YOe8TnqLml7P2jdduZTZ8IBnj+
	FYwIjjsbaqwx3FdSFDwqsWosGHdhTTDaLzKjocBPsgDMAgK7ZsQp6vE4m2l0r8zDOTI5
	AtYdQDlkRO9N2eOtgcJiF9yYFzAJL0zHOf18C8ANzaHrhxgaaIxxh92h3AezhO95CgIX
	fkQDBEQeQ8Eq3fciwMYTi/xtcOqZh9myYwRM5uzxTUiK4+ywBrV2GH/Tb4kk6DTQ18QZ
	9mcQ==
X-Gm-Message-State: APjAAAW0Ezt2vQfbidWenXpUFExDaJEcWfBuRts6eKN6KTykvTy1HtOR
	6weTFYCDwBok3fTAp+s1/13i8Q==
X-Google-Smtp-Source: APXvYqxk+0VBIy2Pzdh7ma1eZSt8r6OtU4m8g37+swm1fS/axRwagKUoLQ5LszaUJkwfFVDIxkk62Q==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr7888937wrt.290.1557313788236; 
	Wed, 08 May 2019 04:09:48 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id
	s10sm2224950wrt.66.2019.05.08.04.09.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:09:47 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-6-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b88c1846-5490-8468-dfd5-1c35ac6a640f@redhat.com>
Date: Wed, 8 May 2019 13:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
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
	Paul Burton <pburton@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 11:34, Philippe Mathieu-Daudé wrote:
> To be coherent with the other peripherals contained in the
> BCM2835PeripheralState structure, directly allocate the PL011State
> (instead of using the pl011 uart as a pointer to a SysBusDevice).
> 
> Initialize the PL011State with object_initialize() instead of
> object_new().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
> -    s->uart0 = SYS_BUS_DEVICE(object_new(TYPE_PL011));
> -    object_property_add_child(obj, "uart0", OBJECT(s->uart0), NULL);
> -    qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
> +    object_initialize(&s->uart0, sizeof(s->uart0), TYPE_PL011);
> +    object_property_add_child(obj, "uart0", OBJECT(&s->uart0), NULL);
> +    qdev_set_parent_bus(DEVICE(&s->uart0), sysbus_get_default());
>  
>      /* AUX / UART1 */
>      object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
> @@ -166,16 +166,16 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
> diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
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
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

