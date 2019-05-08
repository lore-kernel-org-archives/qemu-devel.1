Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55261C04AAB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2016721655
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2016721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34922 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKVI-0002sH-Ar
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:12:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKSb-0000UL-F1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hOKSX-0007jx-Ni
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:10:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hOKSU-0007gz-LE
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:09:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so26613435wra.12
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=kfVn3PcHbJJyc67HYE+LAqAbpidfU5TEawPfmSHoBB4=;
	b=nli1NiTts2tuLEWn6vuiKdxxGYbLPpF66itWjtM9g+Cjp2AopJwQ8HmQE2sVbAKqLB
	KCuXPmHQABfpNsACAKhielYjLi0i9vZDmgEsQqVAWrfh3i8AGot+WK1YBewLMBi5BAkK
	V9VOgv4mjBvGHIPe645H2HhaIskzAO0TyjzVEot+1qgoujaZR1JsAahAsJTA8dtpwCf9
	LlTzhQS842NmFyrR6ioA/dRfQdxNEfDZR+F7VWWzSBHCSVJ9HFiIs5riMjW7OxqOleb7
	8l4X27Y+27eZi4R/YVNwMo35AUSKu5wzsZT+U6chbinErRy1fCV3aGXLv33/2+HESz88
	UfeA==
X-Gm-Message-State: APjAAAWd9rj060hKKxIEEZrm+ZJQOrHQAwpIoWbjrRjnfvLg+4xuHFBW
	LM0Lx+zGGGYY/pPVMPsa3Rm7nw==
X-Google-Smtp-Source: APXvYqza8Gq/DCTrlTi7gStagmO9Ry+82li4z2/p2xAzr+vcNKvpvcZEb1E0PXuWpPPCzuQJo8Nzxg==
X-Received: by 2002:adf:e845:: with SMTP id d5mr3647661wrn.154.1557313795010; 
	Wed, 08 May 2019 04:09:55 -0700 (PDT)
Received: from [10.201.49.229] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
	by smtp.gmail.com with ESMTPSA id a4sm2520109wmf.45.2019.05.08.04.09.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 04:09:54 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
References: <20190507163416.24647-1-philmd@redhat.com>
	<20190507163416.24647-7-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa64aca9-b72e-6f0d-d7f3-f9e68b2487b7@redhat.com>
Date: Wed, 8 May 2019 13:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507163416.24647-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 06/16] hw/arm/bcm2835: Use
 object_initialize_child for correct ref. counting
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
> As explained in commit aff39be0ed97:
> 
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
> 
> This patch was generated using the following Coccinelle script
> (with a bit of manual fix-up for overly long lines):
> 
>  @use_object_initialize_child@
>  expression parent_obj;
>  expression child_ptr;
>  expression child_name;
>  expression child_type;
>  expression child_size;
>  expression errp;
>  @@
>  (
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_size,
>  +                           child_type, &error_abort, NULL);
>      ... when != parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr), NULL);
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  |
>  -   object_initialize(child_ptr, child_size, child_type);
>  +   object_initialize_child(parent_obj, child_name,  child_ptr, child_size,
>  +                            child_type, errp, NULL);
>      ... when != parent_obj
>  -   object_property_add_child(parent_obj, child_name, OBJECT(child_ptr), errp);
>      ...
>  ?-  object_unref(OBJECT(child_ptr));
>  )
> 
>  @use_sysbus_init_child_obj@
>  expression parent_obj;
>  expression dev;
>  expression child_ptr;
>  expression child_name;
>  expression child_type;
>  expression child_size;
>  expression errp;
>  @@
>  (
>  -   object_initialize_child(parent_obj, child_name, child_ptr, child_size,
>  -                           child_type, errp, NULL);
>  +   sysbus_init_child_obj(parent_obj, child_name, child_ptr, child_size,
>  +                         child_type);
>      ...
>  -   qdev_set_parent_bus(DEVICE(child_ptr), sysbus_get_default());
>  |
>  -   object_initialize_child(parent_obj, child_name, child_ptr, child_size,
>  -                           child_type, errp, NULL);
>  +   sysbus_init_child_obj(parent_obj, child_name, child_ptr, child_size,
>  +                         child_type);
>  -   dev = DEVICE(child_ptr);
>  -   qdev_set_parent_bus(dev, sysbus_get_default());
>  )
> 
> While the object_initialize() function doesn't take an
> 'Error *errp' argument, the object_initialize_child() does.
> Since this code is used when a machine is created (and is not
> yet running), we deliberately choose to use the &error_abort
> argument instead of ignoring errors if an object creation failed.
> This choice also matches when using sysbus_init_child_obj(),
> since its code is:
> 
>   void sysbus_init_child_obj(Object *parent,
>                              const char *childname, void *child,
>                              size_t childsize, const char *childtype)
>   {
>       object_initialize_child(parent, childname, child, childsize,
>                               childtype, &error_abort, NULL);
> 
>       qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
>   }
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/bcm2835_peripherals.c | 53 ++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 33 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 2931a82a25a..0fb54c7964e 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -41,44 +41,36 @@ static void bcm2835_peripherals_init(Object *obj)
>                         MBOX_CHAN_COUNT << MBOX_AS_CHAN_SHIFT);
>  
>      /* Interrupt Controller */
> -    object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
> -    object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
>  
>      /* UART0 */
> -    object_initialize(&s->uart0, sizeof(s->uart0), TYPE_PL011);
> -    object_property_add_child(obj, "uart0", OBJECT(&s->uart0), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->uart0), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
> +                          TYPE_PL011);
>  
>      /* AUX / UART1 */
> -    object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
> -    object_property_add_child(obj, "aux", OBJECT(&s->aux), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->aux), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "aux", &s->aux, sizeof(s->aux),
> +                          TYPE_BCM2835_AUX);
>  
>      /* Mailboxes */
> -    object_initialize(&s->mboxes, sizeof(s->mboxes), TYPE_BCM2835_MBOX);
> -    object_property_add_child(obj, "mbox", OBJECT(&s->mboxes), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->mboxes), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "mbox", &s->mboxes, sizeof(s->mboxes),
> +                          TYPE_BCM2835_MBOX);
>  
>      object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
>                                     OBJECT(&s->mbox_mr), &error_abort);
>  
>      /* Framebuffer */
> -    object_initialize(&s->fb, sizeof(s->fb), TYPE_BCM2835_FB);
> -    object_property_add_child(obj, "fb", OBJECT(&s->fb), NULL);
> +    sysbus_init_child_obj(obj, "fb", &s->fb, sizeof(s->fb), TYPE_BCM2835_FB);
>      object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size",
>                                &error_abort);
> -    qdev_set_parent_bus(DEVICE(&s->fb), sysbus_get_default());
>  
>      object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
>                                     OBJECT(&s->gpu_bus_mr), &error_abort);
>  
>      /* Property channel */
> -    object_initialize(&s->property, sizeof(s->property), TYPE_BCM2835_PROPERTY);
> -    object_property_add_child(obj, "property", OBJECT(&s->property), NULL);
> +    sysbus_init_child_obj(obj, "property", &s->property, sizeof(s->property),
> +                          TYPE_BCM2835_PROPERTY);
>      object_property_add_alias(obj, "board-rev", OBJECT(&s->property),
>                                "board-rev", &error_abort);
> -    qdev_set_parent_bus(DEVICE(&s->property), sysbus_get_default());
>  
>      object_property_add_const_link(OBJECT(&s->property), "fb",
>                                     OBJECT(&s->fb), &error_abort);
> @@ -86,32 +78,27 @@ static void bcm2835_peripherals_init(Object *obj)
>                                     OBJECT(&s->gpu_bus_mr), &error_abort);
>  
>      /* Random Number Generator */
> -    object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
> -    object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
> +                          TYPE_BCM2835_RNG);
>  
>      /* Extended Mass Media Controller */
> -    object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
> -    object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "sdhci", &s->sdhci, sizeof(s->sdhci),
> +                          TYPE_SYSBUS_SDHCI);
>  
>      /* SDHOST */
> -    object_initialize(&s->sdhost, sizeof(s->sdhost), TYPE_BCM2835_SDHOST);
> -    object_property_add_child(obj, "sdhost", OBJECT(&s->sdhost), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "sdhost", &s->sdhost, sizeof(s->sdhost),
> +                          TYPE_BCM2835_SDHOST);
>  
>      /* DMA Channels */
> -    object_initialize(&s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
> -    object_property_add_child(obj, "dma", OBJECT(&s->dma), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->dma), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "dma", &s->dma, sizeof(s->dma),
> +                          TYPE_BCM2835_DMA);
>  
>      object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
>                                     OBJECT(&s->gpu_bus_mr), &error_abort);
>  
>      /* GPIO */
> -    object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
> -    object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
> -    qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
> +                          TYPE_BCM2835_GPIO);
>  
>      object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
>                                     OBJECT(&s->sdhci.sdbus), &error_abort);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

