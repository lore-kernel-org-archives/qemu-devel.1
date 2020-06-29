Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49555C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:17:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 119A4233A2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtxMjxrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119A4233A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppuc-0005FI-7q
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppsN-0003ao-HX; Mon, 29 Jun 2020 05:14:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppsL-0004xw-Ta; Mon, 29 Jun 2020 05:14:55 -0400
Received: by mail-wm1-x341.google.com with SMTP id w3so2904544wmi.4;
 Mon, 29 Jun 2020 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j6/T5YgWZ6vOd2dvMBWSe9xG+C7qb+4lDmG/H9meMPM=;
 b=VtxMjxrmY4cx+3YMcq4E9euYUPhoJf7lfAMvBtBwYAoqIUMXf3u+0pKlHdVDaJxAnQ
 rerTsbyx5M28Vl24shWrJx/bUiUL/EX61P9LZQsixh67ZxnYNSoZIgLodvsQnx19AqoQ
 CBFn7aCRIvOa+6Atmiotp/++lqwv3TheyYWUvvJJrGYJnKTOpc+mWU/4ddJzN2X+OnRa
 TACzo0YGww8Ou86ZcnjYyc3RXiQZPf5eMjl78yabEw3TtU4UKp8ULibT0T//hzdjTf8G
 evAqQd6A15IcI2eMram9gBv0zfaQo0YQLIERghmTEThMx+EEYg6ZeZyt8fl1YeQWFGKg
 t9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j6/T5YgWZ6vOd2dvMBWSe9xG+C7qb+4lDmG/H9meMPM=;
 b=Q/T5NIaR77ERH7YMF1/asBRE6UcV5WGikPje/n9s29sbO14AJ/yJm1RUfWMhhEnLYj
 aiRHcAlIZMxUGEg3UOCctHK+TDVB+mp67sQxo8GcrM5+sn+xRtcHwTZsWHRYNc/BL6PJ
 yK+GD+py1wVlxamlShWekRmnNNVIymHVfWY9YCMWpvC8TAWuNoquZ5vgrVlVDzvt1/s5
 KjQr1zPOmnSKGcj4yK27yEO+PSHInglwsq5a3VobvWAUZfh6PpcWlQ7Gp6vmpH4NRacH
 J/YRIlMKLe7r+GKGfdNnFOCGECOOgjaheS7x1IlJiBpGcCyCLgyn//WocFAgloa4dLI1
 ybLA==
X-Gm-Message-State: AOAM530v801FDKzTfGcdPXoOj5GLaZvCSpkwlF7crYAP9P64F1A3AMQn
 b9A4ihXtAGltVQq7rsD4mE4=
X-Google-Smtp-Source: ABdhPJzk4Y+FWDfcZScjqkk5Fa0qq68UAubEdJs6JZjjKjpFd2nPMDywSPdnlknOjLqQyOddMT/jRg==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr15391204wmb.122.1593422092096; 
 Mon, 29 Jun 2020 02:14:52 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z132sm22099612wmb.21.2020.06.29.02.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:14:51 -0700 (PDT)
Subject: Re: [PATCH 15/17] hw/arm/pxa2xx_pic: Use LOG_GUEST_ERROR for bad
 guest register accesses
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-16-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1fa30b47-f7df-21b6-0616-debfb7220607@amsat.org>
Date: Mon, 29 Jun 2020 11:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> Instead of using printf() for logging guest accesses to invalid
> register offsets in the pxa2xx PIC device, use the usual
> qemu_log_mask(LOG_GUEST_ERROR,...).
> 
> This was the only user of the REG_FMT macro in pxa.h, so we can
> remove that.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/pxa.h | 1 -
>  hw/arm/pxa2xx_pic.c  | 9 +++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
> index f6dfb5c0cf0..8843e5f9107 100644
> --- a/include/hw/arm/pxa.h
> +++ b/include/hw/arm/pxa.h
> @@ -184,7 +184,6 @@ struct PXA2xxI2SState {
>  };
>  
>  # define PA_FMT			"0x%08lx"
> -# define REG_FMT		"0x" TARGET_FMT_plx
>  
>  PXA2xxState *pxa270_init(MemoryRegion *address_space, unsigned int sdram_size,
>                           const char *revision);
> diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
> index 105c5e63f2f..ceee6aa48db 100644
> --- a/hw/arm/pxa2xx_pic.c
> +++ b/hw/arm/pxa2xx_pic.c
> @@ -11,6 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  #include "cpu.h"
>  #include "hw/arm/pxa.h"
>  #include "hw/sysbus.h"
> @@ -166,7 +167,9 @@ static uint64_t pxa2xx_pic_mem_read(void *opaque, hwaddr offset,
>      case ICHP:	/* Highest Priority register */
>          return pxa2xx_pic_highest(s);
>      default:
> -        printf("%s: Bad register offset " REG_FMT "\n", __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "pxa2xx_pic_mem_read: bad register offset 0x%" HWADDR_PRIx
> +                      "\n", offset);
>          return 0;
>      }
>  }
> @@ -199,7 +202,9 @@ static void pxa2xx_pic_mem_write(void *opaque, hwaddr offset,
>          s->priority[32 + ((offset - IPR32) >> 2)] = value & 0x8000003f;
>          break;
>      default:
> -        printf("%s: Bad register offset " REG_FMT "\n", __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "pxa2xx_pic_mem_write: bad register offset 0x%"
> +                      HWADDR_PRIx "\n", offset);
>          return;
>      }
>      pxa2xx_pic_update(opaque);
> 


