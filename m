Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B59C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:14:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1101233A2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfDvCgsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1101233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppre-0002kG-7C
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppqw-0001m4-S0; Mon, 29 Jun 2020 05:13:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppqv-0004mG-8Y; Mon, 29 Jun 2020 05:13:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so14645140wmi.3;
 Mon, 29 Jun 2020 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=N0UN+O5l2esWwI74Qmnl4aBoqsYE0UQVWHS+IM1spSo=;
 b=sfDvCgsJvTj9YYEU6DrNLvPUwu/Esvnwm3Oo12gvtDHMVsCjebHziBUDYJygqXWtkX
 OJY49b0egLpxIvxNFa69wQNqOeWgokrEFMMt4E+RdfskPy1yMaK0LQou8rj3ywOKlFb6
 6U1dpXunBV4/tdVCX6ge01hNz3uW/j9McM2XGFUBqm0Z4Xb8jTWxcen/zuu430CPG6bU
 PfL+Nh9zEgHbm4XMW0IDuIE5IXb7s1secO4olN1HZ1f+GoudtLeKuRP7T5j6F+v8zKzI
 bIUFLUGq+2Z+xEBWElyLPDKYGgodeVOaedguxyoavgKWV9UKpbCVQbm/9Fl3kn9rOuH6
 v/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N0UN+O5l2esWwI74Qmnl4aBoqsYE0UQVWHS+IM1spSo=;
 b=qa66t0TFxfa/grBvlZfl7GZJXZXMq6L3YouEm7tE++Pu5SBKPVx30S7tn+UJ82ChND
 LFXVYEuqhakQJCReMaLqAdjpELOV6vNpTD9GA6mGRl720dI13Vo2zvid2J5miShujC9o
 B8QOGug+Tezsx2NIxPc9HaZ60SufQanug8Ssk8rM4YYW68JCN7sBSC5P6wouSKFWtOUb
 yroG2XfcuTP083y1JWpxbKDHu4CY+Nq9Zw9Arsn6+ibVNv6D86OJO5oEINYSdZ3tWmsF
 rX+AIDa0Tv399OTMCBnJfZC3K34wcuQ+2v3osSq17RCUraVjDJryYkEXGwmtKrqDKvFC
 eTqQ==
X-Gm-Message-State: AOAM530NYQRxqE/qIqwJhSfOyZamd4R6XJv60e4FgHrmD1HNmgPCjt+p
 4Z+RZ3reKk3eSygUfZZ6w7M=
X-Google-Smtp-Source: ABdhPJxm0wxg2bED7+QUa7XtLLCm/uQNZfM+iayvVT+gdSq85OtHmvZn/vmLW+ZnRoWtOhLygI3pGQ==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr14938533wmm.183.1593422003667; 
 Mon, 29 Jun 2020 02:13:23 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j16sm8686881wrt.7.2020.06.29.02.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:13:23 -0700 (PDT)
Subject: Re: [PATCH 13/17] hw/gpio/zaurus.c: Use LOG_GUEST_ERROR for bad guest
 register accesses
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-14-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9383555d-87c3-5045-018d-3924656ba571@amsat.org>
Date: Mon, 29 Jun 2020 11:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
> Instead of logging guest accesses to invalid register offsets in this
> device using zaurus_printf() (which just prints to stderr), use the
> usual qemu_log_mask(LOG_GUEST_ERROR,...).
> 
> Since this was the only use of the zaurus_printf() macro outside
> spitz.c, we can move the definition of that macro from sharpsl.h
> to spitz.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/arm/sharpsl.h |  3 ---
>  hw/arm/spitz.c           |  3 +++
>  hw/gpio/zaurus.c         | 12 +++++++-----
>  3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/arm/sharpsl.h b/include/hw/arm/sharpsl.h
> index 89e168fbff3..e986b28c527 100644
> --- a/include/hw/arm/sharpsl.h
> +++ b/include/hw/arm/sharpsl.h
> @@ -9,9 +9,6 @@
>  
>  #include "exec/hwaddr.h"
>  
> -#define zaurus_printf(format, ...)	\
> -    fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
> -
>  /* zaurus.c */
>  
>  #define SL_PXA_PARAM_BASE	0xa0000a00
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index bab9968ccee..6eb46869157 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -62,6 +62,9 @@ typedef struct {
>  #define SPITZ_MACHINE_CLASS(klass) \
>      OBJECT_CLASS_CHECK(SpitzMachineClass, klass, TYPE_SPITZ_MACHINE)
>  
> +#define zaurus_printf(format, ...)                              \
> +    fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
> +
>  #undef REG_FMT
>  #define REG_FMT                         "0x%02lx"
>  
> diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
> index 9a12c683420..258e9264930 100644
> --- a/hw/gpio/zaurus.c
> +++ b/hw/gpio/zaurus.c
> @@ -22,9 +22,7 @@
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> -
> -#undef REG_FMT
> -#define REG_FMT			"0x%02lx"
> +#include "qemu/log.h"
>  
>  /* SCOOP devices */
>  
> @@ -104,7 +102,9 @@ static uint64_t scoop_read(void *opaque, hwaddr addr,
>      case SCOOP_GPRR:
>          return s->gpio_level;
>      default:
> -        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "scoop_read: bad register offset 0x%02" HWADDR_PRIx "\n",
> +                      addr);
>      }
>  
>      return 0;
> @@ -150,7 +150,9 @@ static void scoop_write(void *opaque, hwaddr addr,
>          scoop_gpio_handler_update(s);
>          break;
>      default:
> -        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "scoop_write: bad register offset 0x%02" HWADDR_PRIx "\n",
> +                      addr);
>      }
>  }
>  
> 


