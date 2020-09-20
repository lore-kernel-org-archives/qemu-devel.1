Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD136C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4551A20874
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK0dEdtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4551A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJwyI-0002gj-Bo
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 06:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwuQ-00012I-6E; Sun, 20 Sep 2020 06:49:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwuO-0002RT-Jm; Sun, 20 Sep 2020 06:49:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id a9so9733961wmm.2;
 Sun, 20 Sep 2020 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JFwmq2zJZ0dEQslULSsVw7mYZVOLM3rmG4xjhUXS3I0=;
 b=QK0dEdtNFHFiR8yZMHA3xDc43SyCljJmOqO53KFiKNs1BzCGvrGEVFc8IHEWpQXLwH
 m4BCYthyKxCCaHmMEn4s/s2V8ybejwZJVAfcK8McFFWyY4LRgIB4w+KofSf1H0uWOHLV
 306rjwuvwmdqsEbh2t/veK2hCh9MiFe+zp2OVoBqql0ahFHgtPSG7tpo1jE5dhm4qJhe
 MFbGEY0QCXQKHsSikoqUw1PsmpPjAiLQA566VzIMhusX8v/yQI8YM77bDbIPngArMNbV
 fC00nqs0OGo+xZEjxiGVYoYCxCwGsOemNqL2Pk0X/h9BBPI07kCdVd8BxrSaNRaJzU9L
 tKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JFwmq2zJZ0dEQslULSsVw7mYZVOLM3rmG4xjhUXS3I0=;
 b=bFaKHS1fvJgnYhXDOAwynkf5MCrEaIxx92prfksMG4+ZMo+yMv4sKK6tF/64alTf9u
 hJbn6OZhI/oa1gOc/13D+gKYGTdR3VbaHutfnbWeG+U2H4WQa9pvhS/5JQejFyzXF5l5
 B/5VpUfiU3rkiV74s4A5uJTNyeLiA8xIc+qUu2TUNVbEcd/UsdRnJjLkiZ41L+01hI1o
 oN0rAoGA48sMJVr1ktoEqpxaWR9aXgiGg/ZttFd3u38F7C0vY2YCHtAUaMBNyWSiHxKU
 KZItpFh6jGeEo+kAFJe3rHb9CX0heZ6UUiTKHudQgzkL4AQab6BLClkNve2MIWoZQyhR
 eciw==
X-Gm-Message-State: AOAM532xaxzQRkwQMArjZJEQk61lO0rKEd0VIP/sztHPXe3sLPQB/0bc
 77OlyEiGtnD+4GdZ/v4NfrgGcqoX6Xc=
X-Google-Smtp-Source: ABdhPJyph1U57lXQ+YSTfZQz+PeudcRu1RlrLgkSoeiEXk/Wa2BcG+eeLdRQBq8EBmWAjk7z10XgZg==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr24780828wmj.106.1600598961422; 
 Sun, 20 Sep 2020 03:49:21 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 9sm13381774wmf.7.2020.09.20.03.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 03:49:20 -0700 (PDT)
Subject: Re: [PATCH 2/6] sparc32-ledma: use object_initialize_child() for
 lance child object
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f341b901-958e-a2ff-d871-459587edb6a6@amsat.org>
Date: Sun, 20 Sep 2020 12:49:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920082018.16135-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
> Store the child object directly within the sparc32-ledma object rather than
> using link properties.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c           | 14 ++++++++------
>  include/hw/sparc/sparc32_dma.h |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index b25a212f7a..84196afb95 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -331,24 +331,26 @@ static const TypeInfo sparc32_espdma_device_info = {
>  static void sparc32_ledma_device_init(Object *obj)
>  {
>      DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
> +    LEDMADeviceState *ls = SPARC32_LEDMA_DEVICE(obj);
>  
>      memory_region_init_io(&s->iomem, OBJECT(s), &dma_mem_ops, s,
>                            "ledma-mmio", DMA_SIZE);
> +
> +    object_initialize_child(obj, "lance", &ls->lance, TYPE_LANCE);
>  }
>  
>  static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *d;
> +    LEDMADeviceState *s = SPARC32_LEDMA_DEVICE(dev);
> +    SysBusPCNetState *lance = SYSBUS_PCNET(&s->lance);
>      NICInfo *nd = &nd_table[0];
>  
>      /* FIXME use qdev NIC properties instead of nd_table[] */
>      qemu_check_nic_model(nd, TYPE_LANCE);
>  
> -    d = qdev_new(TYPE_LANCE);
> -    object_property_add_child(OBJECT(dev), "lance", OBJECT(d));
> -    qdev_set_nic_properties(d, nd);
> -    object_property_set_link(OBJECT(d), "dma", OBJECT(dev), &error_abort);
> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(d), &error_fatal);
> +    qdev_set_nic_properties(DEVICE(lance), nd);
> +    object_property_set_link(OBJECT(lance), "dma", OBJECT(dev), &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
>  }
>  
>  static void sparc32_ledma_device_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
> index a7b1dd8418..f2bfe272ba 100644
> --- a/include/hw/sparc/sparc32_dma.h
> +++ b/include/hw/sparc/sparc32_dma.h
> @@ -43,7 +43,7 @@ DECLARE_INSTANCE_CHECKER(LEDMADeviceState, SPARC32_LEDMA_DEVICE,
>  struct LEDMADeviceState {
>      DMADeviceState parent_obj;
>  
> -    SysBusPCNetState *lance;
> +    SysBusPCNetState lance;
>  };
>  
>  #define TYPE_SPARC32_DMA "sparc32-dma"
> 


