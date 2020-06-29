Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7A0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4608A233A2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oom61WQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4608A233A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpptL-0004Kr-JJ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpprf-0002w0-Ld; Mon, 29 Jun 2020 05:14:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppre-0004ql-75; Mon, 29 Jun 2020 05:14:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so15712420wrw.12;
 Mon, 29 Jun 2020 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PEGaT+wBDMjqizMkb6z3mJHU1DQccZiYBEej4c1eh+M=;
 b=Oom61WQoUzXxUMAdXvWhifLmXU3VMRz1Yg9YdLuMkrTLQ+E1v6j5PZcfC+mJLzg06C
 fsA9esBo8UIp5RTHsi88Y/ZvUPSt7o2v9Ab1OvTL6Ff4Kqt+KOE36vnqFV8KNWL90Q0p
 r7nBCqNc6i/SKoCCVpg+xSPZFxA6tHu1/Zpb3CxYnlPlQ+GjCbObcwQ3Ql1eflhAm6Y2
 DH51WsS7PUICLbIk0tBEL6I3gqidD5rUjLkqbcqPNQBZUJyP00pYiYmhWWKhjFrSeraJ
 BwBPamxrBR0rPrSn5Uqfqm93i72hmYWhCBej71BomAeSqtkDJ8VBW3w2MQ/ze7pvixaO
 7lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PEGaT+wBDMjqizMkb6z3mJHU1DQccZiYBEej4c1eh+M=;
 b=M+AuSACo9HzWIlJ4gsQI2NKboK7qYcRfrU+oyiaFAURBK0gwkE3QgaVY281JxFotaT
 kAplOG9oQU5zrhRHHlbTpoWIYNH8Cpwe1dV0X621DgtreklhMop2Y/Lt5rp2Pw9gpatf
 VsJ/kudA8WucKti7OByp64RLkya3ak2saKbIKEB9cP/j1fCniIRitCF8K1OjvqkKUDXf
 5pAQdDcY4xh4z8FC62SnJg5MbSITUyoomeT2R91uKMBzrIgtoKLQgxZSjigUzMF2ylKn
 i9kSdnqa59zf1dOZL2K5tlavalSqJRXzV+8UfL21/ZBJWRGI8OStT/Nb1lxc6k7VIl/J
 czEg==
X-Gm-Message-State: AOAM530LqW3CXCIVhI/u7mmMr0F4JIerPJRWmkr+M4xeSYTqBbmkyJ/k
 EQ0ug5d8xWD5ZhSTThgHJAo=
X-Google-Smtp-Source: ABdhPJzSaCBlyzBt4MY02GkJVY64cmkk+L0lHOTldqYwq4bW2fidQdRSjF5WUtSKeywK7cnu4PWkDw==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr15447474wrp.100.1593422048486; 
 Mon, 29 Jun 2020 02:14:08 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r10sm30638053wrm.17.2020.06.29.02.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:14:07 -0700 (PDT)
Subject: Re: [PATCH 14/17] hw/arm/spitz: Use LOG_GUEST_ERROR for bad guest
 register accesses
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-15-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae39d9d6-0b73-3ecc-b8f6-3baa3e7ecd33@amsat.org>
Date: Mon, 29 Jun 2020 11:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
> Instead of logging guest accesses to invalid register offsets in the
> Spitz flash device with zaurus_printf() (which just prints to stderr),
> use the usual qemu_log_mask(LOG_GUEST_ERROR,...).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/arm/spitz.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 6eb46869157..49eae3fce4e 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -23,6 +23,7 @@
>  #include "hw/ssi/ssi.h"
>  #include "hw/block/flash.h"
>  #include "qemu/timer.h"
> +#include "qemu/log.h"
>  #include "hw/arm/sharpsl.h"
>  #include "ui/console.h"
>  #include "hw/audio/wm8750.h"
> @@ -65,9 +66,6 @@ typedef struct {
>  #define zaurus_printf(format, ...)                              \
>      fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
>  
> -#undef REG_FMT
> -#define REG_FMT                         "0x%02lx"
> -
>  /* Spitz Flash */
>  #define FLASH_BASE              0x0c000000
>  #define FLASH_ECCLPLB           0x00    /* Line parity 7 - 0 bit */
> @@ -137,7 +135,9 @@ static uint64_t sl_read(void *opaque, hwaddr addr, unsigned size)
>          return ecc_digest(&s->ecc, nand_getio(s->nand));
>  
>      default:
> -        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "sl_read: bad register offset 0x%02" HWADDR_PRIx "\n",
> +                      addr);
>      }
>      return 0;
>  }
> @@ -168,7 +168,9 @@ static void sl_write(void *opaque, hwaddr addr,
>          break;
>  
>      default:
> -        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "sl_write: bad register offset 0x%02" HWADDR_PRIx "\n",
> +                      addr);
>      }
>  }
>  
> 


