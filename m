Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7954C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CD5206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKn9oCI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CD5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfThO-000685-QG
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfTga-00059l-Oj; Sun, 31 May 2020 15:31:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfTgZ-0003L3-Q5; Sun, 31 May 2020 15:31:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id q11so9414069wrp.3;
 Sun, 31 May 2020 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kcAk4jMkgQDcQ57Ja0V3NalzXX4EhBVZJ2gA37gPLk4=;
 b=XKn9oCI/5rlAtuH+ePBpAJoccKkrgUJ7DKmdgLCc1MA1pEuiBPwg9V2MpM322eBMDy
 l4ntCPmbsvjopfw5CahzfNUYczF0Vk3c1mjNTXx3tqC+2IqZv1EGbUJ/BF7q0WpJDmnm
 A8fU/bqIHO4dBaQLKcYa/4Mc96Lkp9iZe4toe1mMgvvNxPc7dW4k6yHi6aVcFeRUbfAV
 v/u/uSzCDViimauPMEND0qXNmq0gXlc5K5YbSzb/gxkaaOVhptazMLuJC5cXMBNGt/hT
 IBMWtZfOXp91W2sFPHoA4Aj+Uwl64pzCeogGqc+69uWkTY1w2tF+U/5ZlOl7eWQwJ0YN
 cSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kcAk4jMkgQDcQ57Ja0V3NalzXX4EhBVZJ2gA37gPLk4=;
 b=LWxgGENSiDs7rFEGEFzYn6m0FvxtL8S4VbuwrNya9ZmGOB0WmjSfsiNIvRoN0oIy7a
 i79qEQHYAp/RLoGEcUBphQXQZNWk6T5N8BH+5iYAaOgJSJZSRLIP+NTWyAW6VZ+30QAg
 oaJlooJ+OxrBwkGsmVcIwKjU2iHx3oR0oJot5rypuDjelpMy4LXAOwEtBvn7TIoTBnbY
 iMUMA2FUEmdZgKy0cfOnCiGNL9FU5Mo3mv8X6BmcUR8Z4Ars7Zy1N4WmsnW0f5+oWoxh
 r25f9ilE6UDe7ZeoRziUo2OZQWfE1MRsQ4DgPYTmdQgF6WA3p68vmkWHHQ97zHbSazB3
 1czw==
X-Gm-Message-State: AOAM530blMfZiYrroWB27crDrFbm+PmkxpfzQCKkWFzE+2wTQEEajZ31
 +/2uYfBaLoc9RG+mQxk4D7s=
X-Google-Smtp-Source: ABdhPJw7eXcKZQ0vlLc4y314v/1EAGViwbNaYnFUiFxBzCTV8+hBmR3Pojl9+6Ddy9kdDF9II0QMAA==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr18483412wrt.52.1590953513674; 
 Sun, 31 May 2020 12:31:53 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id b18sm17680602wrn.88.2020.05.31.12.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 12:31:53 -0700 (PDT)
Subject: Re: [PATCH 3/6] hw/sd/allwinner-sdhost: Do DMA accesses via DMA
 address space
To: qemu-devel@nongnu.org
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-4-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a0a5e642-c5f6-158f-5dcd-14c95b782e39@amsat.org>
Date: Sun, 31 May 2020 21:31:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200531175425.10329-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 7:54 PM, Philippe Mathieu-Daudé wrote:
> The DMA operations should not use the CPU address space, but
> the DMA address space. Add support for a DMA address space,
> and replace the cpu_physical_memory API calls by equivalent
> dma_memory_read/write calls.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/sd/allwinner-sdhost.h |  4 ++++
>  hw/sd/allwinner-sdhost.c         | 36 ++++++++++++++++++++++++++------
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
[...]> @@ -742,6 +747,17 @@ static void allwinner_sdhost_init(Object *obj)
>      sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
>  }
>  
> +static void allwinner_sdhost_realize(DeviceState *dev, Error **errp)
> +{
> +    AwSdHostState *s = AW_SDHOST(dev);
> +
> +    if (!s->dma_mr) {
> +        error_setg(errp, "\"dma\" property must be provided.");

Oops I forgot to include the part that sets this property in the A10/H3
SoCs.

> +        return;
> +    }
> +    address_space_init(&s->dma_as, s->dma_mr, "sdhost-dma");
> +}
> +
>  static void allwinner_sdhost_reset(DeviceState *dev)
>  {
>      AwSdHostState *s = AW_SDHOST(dev);
> @@ -787,6 +803,12 @@ static void allwinner_sdhost_reset(DeviceState *dev)
>      s->status_crc = REG_SD_CRC_STA_RST;
>  }
>  
> +static Property allwinner_sdhost_properties[] = {
> +    DEFINE_PROP_LINK("dma", AwSdHostState,
> +                     dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void allwinner_sdhost_bus_class_init(ObjectClass *klass, void *data)
>  {
>      SDBusClass *sbc = SD_BUS_CLASS(klass);
> @@ -798,7 +820,9 @@ static void allwinner_sdhost_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    device_class_set_props(dc, allwinner_sdhost_properties);
>      dc->reset = allwinner_sdhost_reset;
> +    dc->realize = allwinner_sdhost_realize;
>      dc->vmsd = &vmstate_allwinner_sdhost;
>  }
>  
> 

