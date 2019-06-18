Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4957C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84AFF2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84AFF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd6Ts-0003as-SD
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 01:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50572)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hd6Sy-00030l-1W
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hd6Sw-0003ws-Lo
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:15:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hd6Sw-0003w3-D1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:15:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so12347189wrl.11
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 22:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GCk4qQeR5SdJGeBJfewhmQXKBbrGBzr1ytgOp2jg9As=;
 b=TQkqROKdvB1CexPif9cZiimdRBuTOZ48S3wAHhAYwucxcC6GCrityQ/ueKOs7+BzW6
 V7Ee5BteKND1Op1xYdgO7yv2ZrEGLTdB78bZctSZEYv0bJ9vL2wOe8BKsroTV+fPKyfy
 7yAerEOKPde8zQkT31q0p2imWBQtAlG67XiM6VdV8BDhb27M6N65f6hRKXAjKCUzuB2G
 WWxjKFFsRxfrymTyYFoTaWSfB0+AKJymm8AFfcf3ny/xikwTo2/mEoxJiCir3Bwl3H/f
 fqKAdJsAsWlf4bIWEOg8s92nPa0YtMsZJfDw45tCLefPBHLpccu+FX8dyqvlDv5JZURi
 cBVg==
X-Gm-Message-State: APjAAAXgxsgGesnRxmg4ZB0E3inbqXzzW4fy9RtexvqyWkF6kHp3B0gW
 X3YPxIPLa1F86BjlYkm4cf/XoA==
X-Google-Smtp-Source: APXvYqxLs+iXnzv5mJaVyrgbhVyU2BRB673+rr6Qee6L1kLdPq3s9w5VHDc4WgSiRWLpoxauKuYcuw==
X-Received: by 2002:a5d:42ca:: with SMTP id t10mr65237998wrr.202.1560834929394; 
 Mon, 17 Jun 2019 22:15:29 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id t14sm9729872wrr.33.2019.06.17.22.15.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 22:15:28 -0700 (PDT)
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
 <20190416013902.4941-2-andrew.smirnov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <02009ef4-a022-b8e8-ab3f-6256849c48c8@redhat.com>
Date: Tue, 18 Jun 2019 07:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416013902.4941-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/5] i.mx7d: Add no-op/unimplemented APBH
 DMA module
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/19 3:38 AM, Andrey Smirnov wrote:
> Instantiate no-op APBH DMA module. Needed to boot latest Linux kernel.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  include/hw/arm/fsl-imx7.h | 3 +++
>  hw/arm/fsl-imx7.c         | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
> index d848262bfd..aae4f860fc 100644
> --- a/include/hw/arm/fsl-imx7.h
> +++ b/include/hw/arm/fsl-imx7.h
> @@ -179,6 +179,9 @@ enum FslIMX7MemoryMap {
>      FSL_IMX7_PCIE_REG_SIZE        = 16 * 1024,
>  
>      FSL_IMX7_GPR_ADDR             = 0x30340000,
> +
> +    FSL_IMX7_DMA_APBH_ADDR        = 0x33000000,
> +    FSL_IMX7_DMA_APBH_SIZE        = 0x2000,

0x8000?

>  };
>  
>  enum FslIMX7IRQs {
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 7663ad6861..1abfa5910c 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -526,6 +526,12 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>       */
>      create_unimplemented_device("lcdif", FSL_IMX7_LCDIF_ADDR,
>                                  FSL_IMX7_LCDIF_SIZE);
> +
> +    /*
> +     * DMA APBH
> +     */
> +    create_unimplemented_device("dma-apbh", FSL_IMX7_DMA_APBH_ADDR,
> +                                FSL_IMX7_DMA_APBH_SIZE);
>  }
>  
>  static void fsl_imx7_class_init(ObjectClass *oc, void *data)
> 

