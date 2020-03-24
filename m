Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A9C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BA720786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BA720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhIG-0006qt-57
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGhHW-0006PV-JS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGhHV-0007Q4-Dl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:59:38 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jGhHV-0007Ok-4U; Tue, 24 Mar 2020 06:59:37 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MmyzH-1jiJ4R2Cxz-00k7gO; Tue, 24 Mar 2020 11:59:20 +0100
Subject: Re: [PATCH v4 3/3] timer/exynos4210_mct: Remove redundant statement
 in exynos4210_mct_write()
To: Chen Qun <kuhn.chenqun@huawei.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20200324082235.27980-1-kuhn.chenqun@huawei.com>
 <20200324082235.27980-4-kuhn.chenqun@huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b1e4dbf2-842a-dedd-819e-4f2b272dcfb9@vivier.eu>
Date: Tue, 24 Mar 2020 11:59:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324082235.27980-4-kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GWZNHaelLFq8QGIKGd/6WOl0PWGlEPbhU3SZWVZ56nuBb60U2w9
 7px/jGNxss98t8WMRqw+n89yVSCFoFLSM2RnLledwD0w5Ar7glGrN+qLRLUm/uDrJr0oWO+
 nTwTjAV0FNP8X1IyuVmgvdzS7U8qYDz78aRoGmAa8453gb8BSTjeSN4r40uxIvzRxyehqjx
 bjmLtLgrwF0swJ02QX1GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QpGY5pnbCow=:FNB8elLuM3vANXOTpaiclx
 apxGPHFYBl1mR/7aNbXoyGkl8oJBQVXJ3UF70BvQjFpmOoVPUh9NMi5rnfvBQ/sob/iR4uTwB
 FARxAZEzC4cPwM87+tGcWcVP+rPWVUrGGXwSNEEeSq1/11qglr21vkhYQFF8e9EI8Kvu1fkP8
 d0LCjG08p406nTk6aLgiXtZ7ZPOEYtG5zxpiJals0xjYOo86U8uKaLBg7ZWt/9OyVnPW/1YGq
 Bq7MMJ1b004GIWeQnNlsDV3hRcPTYwtx2GyaDEO9YqYGszFWFEOKZnjLLfd+06cK8Dmo4bwzu
 YKGAyjivLhEm1RQQ5Wpz1+fkorQpSWGfsNL/ddT5UeNN85N/7ZMWmjepFnlBtUiKcw2UXS7cv
 SkQVfdTtxYDY/wNQN0aRZXVjYbpGxpIFzU7r+YKCEROqTN6aMq3W4gOYpDKYFoSsNbcNhPhLc
 SkMwURZ5ehoOMsU3DvG9Nx2quP90O0XjEhKEtQi4yMfKl2QdfHEDwS9h+Ol6tN6GDqDRplTn8
 2IlG/ozKlWNhN7b9EZOCnglmA3admoz+dRXxH9O/SFMhaEpmucXIicmk9J2dMaAxE8yMQvHIB
 YMvg7GvJmKeih/6cf4OcozAGEixXm2qgUDkHrNPhTU197COR8PpFKDrfZzoAWDZMJvSO73/9S
 wNjuBts/TkHJ6G9svVyDkfIrATV1X9tCl4zqEwPwURytT7d1WwcPHdd3Wdnt4Y6OKH5/i3wCz
 Lk6f7yXjPHc6blDjuiyrRmPrwHXDfzmDCwM+rvd7IRoZZnihGHeD4Q+ksNuv2cBW/TdLOdRJe
 Leq05st42fSDHnzmzYQy3nOwZqBgPM8kbYbIo354xfxBkObP+DHXNUg3giT2c2WJNlU1O+l
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@redhat.com,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/03/2020 à 09:22, Chen Qun a écrit :
> Clang static code analyzer show warning:
> hw/timer/exynos4210_mct.c:1370:9: warning: Value stored to 'index' is never read
>         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/timer/exynos4210_mct.c:1399:9: warning: Value stored to 'index' is never read
>         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/timer/exynos4210_mct.c:1441:9: warning: Value stored to 'index' is never read
>         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It would be interesting to understand why we need the index for these
registers in exynos4210_mct_read() and not in exynos4210_mct_write().

Thanks,
Laurent

> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/exynos4210_mct.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 944120aea5..570cf7075b 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -1367,7 +1367,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>  
>      case L0_TCNTB: case L1_TCNTB:
>          lt_i = GET_L_TIMER_IDX(offset);
> -        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>  
>          /*
>           * TCNTB is updated to internal register only after CNT expired.
> @@ -1396,7 +1395,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>  
>      case L0_ICNTB: case L1_ICNTB:
>          lt_i = GET_L_TIMER_IDX(offset);
> -        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>  
>          s->l_timer[lt_i].reg.wstat |= L_WSTAT_ICNTB_WRITE;
>          s->l_timer[lt_i].reg.cnt[L_REG_CNT_ICNTB] = value &
> @@ -1438,8 +1436,6 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
>  
>      case L0_FRCNTB: case L1_FRCNTB:
>          lt_i = GET_L_TIMER_IDX(offset);
> -        index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
> -
>          DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
>  
>          s->l_timer[lt_i].reg.wstat |= L_WSTAT_FRCCNTB_WRITE;
> 


