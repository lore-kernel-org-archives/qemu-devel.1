Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E31C388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BBF20702
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 14:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrX/AziJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BBF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbPav-0003s0-Jh
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 09:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbPZf-000357-JM
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:52:15 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbPZd-0003do-V9
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 09:52:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id p1so4229790wrf.12
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WTk8CLmn3H4rCxGMS/xI4SrNYM3HqqXpVO5Z7ICvWpg=;
 b=JrX/AziJ08ivmSkiakj0xSbmcY5q+rkzcLTjv/yo9iqsmCAx5MEHOTwBJkOWKYhTiv
 LTljsUTnbMtrt57Oj6n+yjFzx245tZ+vp24YgntVH/tHy/N/E1VNr98FrPAHml6XyCGT
 uGom173FKbdajfsVmd6Z1RuvpS2UPcybP3KE7XybqB6fTNI17oZg9CU6sPp0RVlZBLEo
 VtmrgdBjeP0/Atjy6DWLJ3ML8xbkidYygx3A9c9mxV62BstRoJ/tec8vxWM2skcuBIYj
 YdzAiXZB+nqX+l8bIanhdfNzjIsOFL7tB2dZD5GCbzHsO96z/f5yLemsVNq/qXPtbRFM
 HfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WTk8CLmn3H4rCxGMS/xI4SrNYM3HqqXpVO5Z7ICvWpg=;
 b=HRBGSgM0eDTNP4Ve88p6anoN7CVLL2QaCogS32x+l0e7X8m8q6NPM4Yh1gmu5m+e3b
 +CrToOHDUzlo8O59SonThbrX/HMfngngkhD03EKkjXF1QG6otV7winbk5aZ/D6wXe2SL
 o6gpLPkjrSu7kpgAqCXrBPW3k0gAf2m3efwhkwcFe/kxl38mlsZgY5ksU6qhExRG2vnq
 wHaL6gDGTt9L/+hmh+CCUKSAqnJns8WVXgYoXCdiqs4c5j6iuVcNocF1XB0zAw2cEIMu
 CVa9O6KwA/43IoZsIIkL/a4Yxf0DsEEBqRUW7Ca7M6hUUj6aJV2fSOpZl5ostoV3u7y1
 uqcQ==
X-Gm-Message-State: AOAM530rFOcoYUddpPK+kEh9mc9DSS5Aw5CZphQzYwG73wRAA+0Nleon
 fKmJiV5pxTaEqJWP1JwApbs=
X-Google-Smtp-Source: ABdhPJwGE/UyL9VP+lM2VygBPOUsj4rvPpvT0fqF2Tc2L7CfJapLi4JuBl3LQlSbC0zBCzVgl+PJkA==
X-Received: by 2002:a5d:4104:: with SMTP id l4mr7031070wrp.276.1604760732006; 
 Sat, 07 Nov 2020 06:52:12 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d16sm6816179wrw.17.2020.11.07.06.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 06:52:11 -0800 (PST)
Subject: Re: [PATCH 1/2] hw/m68k/q800: Don't connect two qemu_irqs directly to
 the same input
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106235109.7066-1-peter.maydell@linaro.org>
 <20201106235109.7066-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11e6fcf5-fbd3-d2d8-ab20-c017080599d4@amsat.org>
Date: Sat, 7 Nov 2020 15:52:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201106235109.7066-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing SPARC maintainers ...

On 11/7/20 12:51 AM, Peter Maydell wrote:
> The q800 board code connects both of the IRQ outputs of the ESCC
> to the same pic[3] qemu_irq. Connecting two qemu_irqs outputs directly
> to the same input is not valid as it produces subtly wrong behaviour
> (for instance if both the IRQ lines are high, and then one goes
> low, the PIC input will see this as a high-to-low transition
> even though the second IRQ line should still be holding it high).
> 
> This kind of wiring needs an explicitly created OR gate; add one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/m68k/q800.c  | 12 ++++++++++--
>  hw/m68k/Kconfig |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index ce4b47c3e34..dc13007aaf2 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -28,6 +28,7 @@
>  #include "hw/hw.h"
>  #include "hw/boards.h"
>  #include "hw/irq.h"
> +#include "hw/or-irq.h"
>  #include "elf.h"
>  #include "hw/loader.h"
>  #include "ui/console.h"
> @@ -171,6 +172,7 @@ static void q800_init(MachineState *machine)
>      CPUState *cs;
>      DeviceState *dev;
>      DeviceState *via_dev;
> +    DeviceState *escc_orgate;
>      SysBusESPState *sysbus_esp;
>      ESPState *esp;
>      SysBusDevice *sysbus;
> @@ -283,8 +285,14 @@ static void q800_init(MachineState *machine)
>      qdev_prop_set_uint32(dev, "chnAtype", 0);
>      sysbus = SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(sysbus, &error_fatal);
> -    sysbus_connect_irq(sysbus, 0, pic[3]);
> -    sysbus_connect_irq(sysbus, 1, pic[3]);

... because sun4m_hw_init() has the same issue:

 986     dev = qdev_new(TYPE_ESCC);
...
 996     sysbus_connect_irq(s, 0, slavio_irq[14]);
 997     sysbus_connect_irq(s, 1, slavio_irq[14]);
...
1011     sysbus_connect_irq(s, 0, slavio_irq[15]);
1012     sysbus_connect_irq(s, 1,  slavio_irq[15]);

> +
> +    /* Logically OR both its IRQs together */
> +    escc_orgate = DEVICE(object_new(TYPE_OR_IRQ));
> +    object_property_set_int(OBJECT(escc_orgate), "num-lines", 2, &error_fatal);
> +    qdev_realize_and_unref(escc_orgate, NULL, &error_fatal);
> +    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
> +    sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
> +    qdev_connect_gpio_out(DEVICE(escc_orgate), 0, pic[3]);
>      sysbus_mmio_map(sysbus, 0, SCC_BASE);
>  
>      /* SCSI */
> diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
> index c757e7dfa48..60d7bcfb8f2 100644
> --- a/hw/m68k/Kconfig
> +++ b/hw/m68k/Kconfig
> @@ -22,3 +22,4 @@ config Q800
>      select ESCC
>      select ESP
>      select DP8393X
> +    select OR_IRQ
> 


