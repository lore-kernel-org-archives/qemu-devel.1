Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A49C43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F6920897
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ/M1wI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F6920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJx2E-0005kR-Mk
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 06:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwuY-00013w-Dp; Sun, 20 Sep 2020 06:49:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwuW-0002Uv-W9; Sun, 20 Sep 2020 06:49:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id e17so9378468wme.0;
 Sun, 20 Sep 2020 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=S/6eEeq1W/MrAk6VqJ5JLkNBx9VHYstASaFuTpqg69c=;
 b=MJ/M1wI5TV8aeBm+SfAZxVXq3zdSjj/BrkPihDRjmvNihaHC3JxtD4do5yb25nhcLv
 x7P6jn+Nnz85a6t5xGqBy04MgU1el6LWbpoM51COE+SVL8Y3XSeQu7gl79VH5ADgkOSJ
 UgkOtMqiHgjcwI2JdRqjLXBDzkhehYbmtGpxqT7rurkmknNdELLP39kfBKrazxj7XW2+
 VR227H5Gb132NQZIRhkViwIZxkU7/aWEk5N7D2bWQEIuRLC/h5phRtDZugju0g2qGkNR
 ZiI36sSXcgohe+uZO6+CTFvcumM2R0XTQBtujNr8FA6kX8kCuIUPFahEG4xN6eKotxuC
 E/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S/6eEeq1W/MrAk6VqJ5JLkNBx9VHYstASaFuTpqg69c=;
 b=HqQmf18xkbBXc2x7rxaVkHyLqLvMZ65KnQdT/Bku+LHxk2WYgG0HfQC89bOmxZh4AJ
 kJIe+YGWfRtIka3nICxp+ivgA5ExLzDKmbIYl63IWlB1bq8FsfxEydmPeH0F0OvrVRPZ
 ZyEvIYT+615nzkSr9PF8DJUBA0Drxfa7B+RaS8WxbegUnpKgni8Qr5H+UcsZBAokbhi7
 Jol669giLAYIEYlROF/YQhuzwJpuLKPpJYVREpMZkp8i0DJcvuDWCzczr5e/bwN3QWZU
 AzV1IpqK99x9FRyoR0I7qF+6oPOxVBcViyaW8y6lBRCUSS4M1eTcU4TeWYRieRbxbdJw
 dVkw==
X-Gm-Message-State: AOAM532ue9C40U94XByZWbctjCct6HNqpOj5y3eGYZQKTOXIHuEltqjM
 k9H0HLGK0JJwfug7ndvZ9bZmbq/xBFQ=
X-Google-Smtp-Source: ABdhPJyTJL7ouDFPhPfmXCbmq2wHJyM2KCG+KCSBrdXuBeggTrDaGtTyHH+EM/S3gzKfgFKO2pV3ZA==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr26691918wmj.68.1600598974954; 
 Sun, 20 Sep 2020 03:49:34 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i11sm15043748wre.32.2020.09.20.03.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 03:49:34 -0700 (PDT)
Subject: Re: [PATCH 3/6] sparc32-espdma: use object_initialize_child() for esp
 child object
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb9850a7-83fb-edc1-e2bb-856986d6acdf@amsat.org>
Date: Sun, 20 Sep 2020 12:49:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920082018.16135-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
> Store the child object directly within the sparc32-espdma object rather than
> using link properties.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c           | 17 ++++++++---------
>  include/hw/sparc/sparc32_dma.h |  2 +-
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 84196afb95..2cbe331959 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -290,27 +290,26 @@ static const TypeInfo sparc32_dma_device_info = {
>  static void sparc32_espdma_device_init(Object *obj)
>  {
>      DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
> +    ESPDMADeviceState *es = SPARC32_ESPDMA_DEVICE(obj);
>  
>      memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
>                            "espdma-mmio", DMA_SIZE);
> +
> +    object_initialize_child(obj, "esp", &es->esp, TYPE_ESP);
>  }
>  
>  static void sparc32_espdma_device_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *d;
> -    SysBusESPState *sysbus;
> -    ESPState *esp;
> -
> -    d = qdev_new(TYPE_ESP);
> -    object_property_add_child(OBJECT(dev), "esp", OBJECT(d));
> -    sysbus = ESP(d);
> -    esp = &sysbus->esp;
> +    ESPDMADeviceState *es = SPARC32_ESPDMA_DEVICE(dev);
> +    SysBusESPState *sysbus = ESP(&es->esp);
> +    ESPState *esp = &sysbus->esp;
> +
>      esp->dma_memory_read = espdma_memory_read;
>      esp->dma_memory_write = espdma_memory_write;
>      esp->dma_opaque = SPARC32_DMA_DEVICE(dev);
>      sysbus->it_shift = 2;
>      esp->dma_enabled = 1;
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(d), &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(sysbus), &error_fatal);
>  }
>  
>  static void sparc32_espdma_device_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index f2bfe272ba..d40eca0cc8 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -32,7 +32,7 @@ DECLARE_INSTANCE_CHECKER(ESPDMADeviceState, SPARC32_ESPDMA_DEVICE,
>  struct ESPDMADeviceState {
>      DMADeviceState parent_obj;
>  
> -    SysBusESPState *esp;
> +    SysBusESPState esp;
>  };
>  
>  #define TYPE_SPARC32_LEDMA_DEVICE "sparc32-ledma"
> 


