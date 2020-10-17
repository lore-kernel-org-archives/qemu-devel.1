Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2CAC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A377C206CB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDRlBBqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A377C206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTijx-00068v-Q6
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTij1-00058m-8B; Sat, 17 Oct 2020 05:42:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTiiy-0000G8-RF; Sat, 17 Oct 2020 05:42:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id j7so2038138wrt.9;
 Sat, 17 Oct 2020 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hiAB/tWncDRl6CZSNt1Dr5zLHeBH/uNB/uIZ9DtyeYk=;
 b=SDRlBBqbZ2CtxxgBaqRfOrEZJFctXFpxiHdjPpmAofQq+OYhorVULGqzub9AXlL3mC
 VYYxi7OOedO36c8+Ck02xMxuA5AbTw5udQIsLklGylmN4wCJ7TeAT4RDRpDpqcoTx6BM
 ySM4HCyC7mYpts4X9StmCziFDH7aRvf6es+s7y9u7v7/eCnMddeQNBYYav1nD3RQip0D
 fkrvk+VqzXQgcnt1Hh9mdyihyCOC6GmmJoDvPM/hMeU9gFJ+dWYCpvQRgVCdl1AkWTTt
 7syyU4mAx1RKGyXo7Go2KCKt5wolO+58MtFwfcXvUHHhm3fnBtftqPbNnFItPo73Wk0r
 cQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hiAB/tWncDRl6CZSNt1Dr5zLHeBH/uNB/uIZ9DtyeYk=;
 b=JJ1Av8muLITVceGYvUSO6R7We/AsU0mOaJHbbTnYnLKa5gkLbDSvgZDhDQdhx/cUYb
 RNYh7F9IeP4thVChyAKUl5G76yCsznUjjSszjhTNd2xFsyz5mbD8tC+JSebo9ECaeYv8
 +I4u6kuG9+rzchuYtEeNYg+FPox8lGbOqCeBURa22h0/ZoEGGMJCiLi8itK2JZQNZXHm
 AxrRGP3fYRRTKPJsR2uJx3cZJUTy9tinayMyBlt4xKNGJsmAoBwn9W5AdQuS4Xx/9hUJ
 MGZlxWfoEYGMESTIJdlBm4yLfu7GHnScx8rAaI209F8qZUqVfAT8w4q8bbWZDT3ISIj0
 gGow==
X-Gm-Message-State: AOAM531L2/7u4oUAMmYf1lG59KE1GbaxuQa79JkT7edPAcmMQBgj+KWx
 9M+Y7WqBqhKPAV5cv6Eg2eI=
X-Google-Smtp-Source: ABdhPJyvoYzxXE5rQBpKLSuudCK3V47YcVkPhXcUK/VL6inzzEIZcV+QcQeU5Unchymx/5vtF6bdiw==
X-Received: by 2002:a05:6000:10cd:: with SMTP id
 b13mr8898097wrx.4.1602927722637; 
 Sat, 17 Oct 2020 02:42:02 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id u63sm6778010wmb.13.2020.10.17.02.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:42:01 -0700 (PDT)
Subject: Re: [PATCH 2/5] sun4m: use qdev properties instead of legacy
 m48t59_init() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, hpoussin@reactos.org, qemu-ppc@nongnu.org,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <387e845e-48b1-e78b-7d94-753fdeab4385@amsat.org>
Date: Sat, 17 Oct 2020 11:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016182739.22875-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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



On 10/16/20 8:27 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/sparc/sun4m.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 54a2b2f9ef..a9bb60f2b2 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -966,7 +966,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>           create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
>       }
>   
> -    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
> +    dev = qdev_new("sysbus-m48t08");
> +    qdev_prop_set_int32(dev, "base-year", 1968);
> +    s = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_connect_irq(s, 0, slavio_irq[0]);
> +    sysbus_mmio_map(s, 0, hwdef->nvram_base);
> +    nvram = NVRAM(dev);

While here, can you declare "Nvram *nvram"?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   
>       slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
>   
> 

