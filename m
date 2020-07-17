Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C4BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2E720704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYP98jXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2E720704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwL8q-0006pI-KJ
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 03:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwL88-0006Ka-I1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 03:50:04 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwL87-0002ot-3w
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 03:50:04 -0400
Received: by mail-ej1-x641.google.com with SMTP id f12so9769403eja.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bip2/niXyDhRGsZlo8/oxFjr09Dwg5qOEOcFuDMVAo0=;
 b=ZYP98jXCMEjBS715J3BKE2It4ITroPjN58Ia+qgY4BG4PpGAKy9lyLtdqdyzVBL7jo
 9Yeow9fAlK+kcQfxBnXZDLbqHSsNbkXWJsnh1LvDce6sORAbCyhjyIUM/Vp19sNDBQjK
 DcpkFIt2LjrTjbxoKeaBsK125tkGrW79VrNvAbOhuvSES866ARloNz2VzFhRV0WbtZPv
 rk6o/afHMin35ZGPW8qBVgKsVfwTJiKuI+bcEuqBGvhO7JC643elv2+y89qW0827sLsw
 ZK4zhMVg/4y8RvEa2q7cCdCmOd7dQKqY5/pOSe1j5R3lNs/zWIXq9rH7QWjy15/HY4mw
 lXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bip2/niXyDhRGsZlo8/oxFjr09Dwg5qOEOcFuDMVAo0=;
 b=cpil97uP8aSdk4fvEtSQdB1rfBTZ/CH/5pj3P7KGzlzx/ux6hBddDNxWAqij8fVE8v
 Juqx7ZtxoBQkePQY7DGAVl6X7bfLOiGsl3FlTAqeZrbfv5xDx0ZZ9Xj40DAye7cdkUlq
 0rq6nE0/Mqgr4n3q7OklCmIjAXxH/RNCp9nMzl36FreZtRJqkVr/3HwnMc4fbsydFwp3
 v4b7CIAohETP3u/M7h2rNaLF6OGzQh1mh1eMBX/gIxRMGJSCOUjpSdQ9LBedMuJNtd36
 MvaN2blG8gY1Qcgh98v0Gp7Nx+cGXlqDrOCpTuc37O6Yd7ymeLCjBhMn0CmJkRNJD5Oe
 SJVw==
X-Gm-Message-State: AOAM5321An1wR67b7cH29Jo6WIZPWYd6MUo3+6fBZglvCgm89nhJOcxi
 RBq+02K/8ONREuhbhDzy0a7Slojme2M=
X-Google-Smtp-Source: ABdhPJzR+zpm+8+lsBMc37mUSuFeDIbBxx4K/K5msZkzR5Hl02uPDJI9uHKymemn5xGS+b98nqAAhw==
X-Received: by 2002:a17:906:594c:: with SMTP id
 g12mr7415234ejr.255.1594972201633; 
 Fri, 17 Jul 2020 00:50:01 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w8sm7263885ejb.10.2020.07.17.00.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 00:50:00 -0700 (PDT)
Subject: Re: [PATCH] usb: only build hcd-dwc2 host controller for RASPI target
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200717010548.9902-1-pauldzim@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <31c9069a-9ee9-cbbb-8ec9-eec49466dd3c@amsat.org>
Date: Fri, 17 Jul 2020 09:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200717010548.9902-1-pauldzim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 3:05 AM, Paul Zimmerman wrote:
> The hcd-dwc2 host controller is currently built for all targets.
> Since for now hcd-dwc2 is only implemented on RASPI, restrict its
> build to that target only.
> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> ---
> 
> Hi Gerd,
> 
> Do we want to apply this before the 5.1.0 release? It seems a waste
> to build this code for every target when it's only used on one.
> Sorry I didn't realize this earlier.

Not a big deal ;)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Thanks,
> Paul
> 
>  hw/arm/Kconfig | 1 +
>  hw/usb/Kconfig | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 4a224a6351..bc3a423940 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -315,6 +315,7 @@ config RASPI
>      select FRAMEBUFFER
>      select PL011 # UART
>      select SDHCI
> +    select USB_DWC2
>  
>  config STM32F205_SOC
>      bool
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index d4d8c37c28..5e63dc75f8 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -48,7 +48,6 @@ config USB_MUSB
>  
>  config USB_DWC2
>      bool
> -    default y
>      select USB
>  
>  config TUSB6010
> 


