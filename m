Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D29C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6358120874
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXHB4mGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6358120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJx0r-0004HP-A7
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 06:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwu6-0000yq-7a; Sun, 20 Sep 2020 06:49:10 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwu4-0002P6-IS; Sun, 20 Sep 2020 06:49:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id y15so9710462wmi.0;
 Sun, 20 Sep 2020 03:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KI8Q9z8EAoJJJEX4rYsy8ZmqgGFdYDsg+9FFVOWCbBw=;
 b=bXHB4mGZ8r+L3orJ8yfhYCe1PBBpN8g2Idy5ub82pD1+stQEApvvnWtKFqfCelQ4K4
 6X+EPgkoP7Z/g4I2Qzgo6PDOQDKiNPAwQrZlSnzhPE0ilCKV3NffTPnOXvyc6dgiCYLi
 2dd/hoOMNsewQx4ooeo9dqX3glbhP5cxXNgH2wD3hgOu6zTM649pGGRuDcZw2dDwAz//
 D6pgeK0pFcWogkn1aiJL147bapAYBL5dajlaCkJAA559N4npaiLJs6B4XWawqAq972ls
 SECxYvBmO4MBMKq7nnJWSEWgOzHu4dklxNfZk6tiYROOFbhM61jp38jDEyChAjCXNuB4
 PqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KI8Q9z8EAoJJJEX4rYsy8ZmqgGFdYDsg+9FFVOWCbBw=;
 b=g22gcJfFwJ2zeH72ktu1RYco59iLhdkH0qLFKN9iy4qnSE7xGdPNmJ4y/zIJ8OXBxT
 EVoXfINP30pV1ayVxnZXXRlDAWJPHJYqx0Jr1xNZu/eWFPhSAvh8Ep8qdjZ5HtSmPo1a
 +UgnneokN3uWDfr/iGaQnTkqMITrlzoWVRhOxZB5EfIJlL5Z3qUzxhmxXtE6c5qizQPX
 Iboa21p4LOJj/xQCCwoVRQcc3kxo91DeYANqPGOys9vy6K8PfisegVLi4wdgm6BNYYiG
 a1f5AaHmEriwvXNeteZisgg12fZUb0Vbx784YP8sYdMYy/i/JIxei4N30VQUn7yxhZiO
 O4wQ==
X-Gm-Message-State: AOAM5314L8tpkaCAKqiE3rJJVL/Wjjs3N9OKJshk+T+CM2NB8SoOWK4b
 hALunnoixetx4pRvpbkN+kn8XqUdc48=
X-Google-Smtp-Source: ABdhPJwqOPwT/qzbZSSiowx887k0wkoGqHad1wHVKWxVf5tCS9PJWXZv8esSuekSXcQDZ3srcs11lA==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr25405863wmg.117.1600598946610; 
 Sun, 20 Sep 2020 03:49:06 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m3sm14126133wrs.83.2020.09.20.03.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 03:49:06 -0700 (PDT)
Subject: Re: [PATCH 1/6] sparc32-dma: use object_initialize_child() for espdma
 and ledma child objects
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8e33e688-5c73-7a4b-5bd5-30ead26d8647@amsat.org>
Date: Sun, 20 Sep 2020 12:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920082018.16135-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 10:20 AM, Mark Cave-Ayland wrote:
> Store the child objects directly within the sparc32-dma object rather than using
> link properties.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/dma/sparc32_dma.c           | 15 +++++++++------
>  include/hw/sparc/sparc32_dma.h |  4 ++--

Consider using scripts/git.orderfile to avoid reviewer scrolling :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index d20a5bc065..b25a212f7a 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -379,10 +379,9 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    espdma = qdev_new(TYPE_SPARC32_ESPDMA_DEVICE);
> +    espdma = DEVICE(&s->espdma);
>      object_property_set_link(OBJECT(espdma), "iommu", iommu, &error_abort);
> -    object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(espdma), &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(espdma), &error_fatal);
>  
>      esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
>      sbd = SYS_BUS_DEVICE(esp);
> @@ -394,10 +393,9 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(&s->dmamem, 0x0,
>                                  sysbus_mmio_get_region(sbd, 0));
>  
> -    ledma = qdev_new(TYPE_SPARC32_LEDMA_DEVICE);
> +    ledma = DEVICE(&s->ledma);
>      object_property_set_link(OBJECT(ledma), "iommu", iommu, &error_abort);
> -    object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(ledma), &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(ledma), &error_fatal);
>  
>      lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));
>      sbd = SYS_BUS_DEVICE(lance);
> @@ -421,6 +419,11 @@ static void sparc32_dma_init(Object *obj)
>  
>      memory_region_init(&s->dmamem, OBJECT(s), "dma", DMA_SIZE + DMA_ETH_SIZE);
>      sysbus_init_mmio(sbd, &s->dmamem);
> +
> +    object_initialize_child(obj, "espdma", &s->espdma,
> +                            TYPE_SPARC32_ESPDMA_DEVICE);
> +    object_initialize_child(obj, "ledma", &s->ledma,
> +                            TYPE_SPARC32_LEDMA_DEVICE);
>  }
>  
>  static void sparc32_dma_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index a402665a9c..a7b1dd8418 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -56,8 +56,8 @@ struct SPARC32DMAState {
>  
>      MemoryRegion dmamem;
>      MemoryRegion ledma_alias;
> -    ESPDMADeviceState *espdma;
> -    LEDMADeviceState *ledma;
> +    ESPDMADeviceState espdma;
> +    LEDMADeviceState ledma;
>  };
>  
>  /* sparc32_dma.c */
> 


