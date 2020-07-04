Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE7C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 10:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116EC20890
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 10:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ6NH/4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116EC20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrfW6-0002qR-A9
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 06:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrfVX-0002Qz-6k
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 06:34:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrfVV-0001UJ-PE
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 06:34:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id z13so35332012wrw.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FDZiKo/Ng8IE6CL4NSvHiMPFKRX6Qlmqyhg4VqOLAgE=;
 b=dJ6NH/4A/UO8Bgd9p1CZnaBpjp3Sci/TdTZiQxSpe965kNNQYct2ID0bfNWKO5ntja
 hzNVDG/XA+/IudJyIgsWuUly/JTPIS8/la2c8+X6rHwz2UUuNayZnrAb2oHYxJzf09R+
 10puSGG8oD4w4u9PMGRARCShUBT7o6wERVA9gWHHZK1JX6FY8ghzka1Z20Sp9RDMQRCQ
 PjtgRla6ztUqsHyx3hgdYoeTJE2J8/+E33aFOQs7EyTc84pf5P7QZkdL781g8raerKBp
 h7fZxqhBWNgAVobL1Jt0R4Fs2PQ0qmTCoNaeWKqOZMaVYk5sfKFytKBEWY9C80burY89
 a6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FDZiKo/Ng8IE6CL4NSvHiMPFKRX6Qlmqyhg4VqOLAgE=;
 b=SNIhJnxr5T8qYRonlGrb2H9t1MWTutBAPzQQkSDZFXz+tz4fbax9I3zJvBrAuKiaCQ
 5IsMY4tU4m4FkJIo5mrQJluhIVvCdLRyUAoNHL0yioG9fHov/JByzkcBhEz1My8tY0u3
 4NFYfTMu0quyAWplzWaZJezYv1eSkWe3ev+Dmi+Nly3oWBV3cqDiebrymqJXovy2o/3d
 czt/yGr6ohd4TSvajIjYtcfB+0bHPIp76q/OQTBtG2UYRrcwYgn4jLg5eC7D+dKZ/xzq
 /CBxGkwSLXWXBMIzmc2VEbKBCGtcUmvYEy22mX0sGHBk/C1u8j6usEshTxHSCd5cSne+
 OpAw==
X-Gm-Message-State: AOAM530+wS3XRNmi2EkCWgOxGly4uitpyqI6Gx/58yjEU0vx3I7Mmfcu
 27vDe9iCZMNy0HAhJlLU1mc=
X-Google-Smtp-Source: ABdhPJzHJnoxrLcYnLOrU8aGcNDFIrHo5kfmcjd5aErgJYemhtede1ljGmP6aFC3yf0Rc6JUgTIBZA==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr9934184wro.406.1593858891838; 
 Sat, 04 Jul 2020 03:34:51 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k11sm17963945wrd.23.2020.07.04.03.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 03:34:50 -0700 (PDT)
Subject: Re: [PATCH] net/tap-solaris.c: Include qemu-common.h for TFR macro
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200704092317.12943-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96bc8d06-542d-1010-75cc-2a09b49f3c86@amsat.org>
Date: Sat, 4 Jul 2020 12:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200704092317.12943-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 11:23 AM, Peter Maydell wrote:
> In commit a8d2532645cf5ce4 we cleaned up usage of the qemu-common.h header
> so that it was always included from .c files and never from other .h files.
> We missed adding it to net/tap-solaris.c (which previously was pulling it
> in via tap-int.h), which broke building on Solaris hosts.
> 
> Fixes: a8d2532645cf5ce4
> Reported-by: Michele Denber <denber@mindspring.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Untested: Michele, could you give this a try?
> ---
>  net/tap-solaris.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/tap-solaris.c b/net/tap-solaris.c
> index 4725d2314ee..d03165c57c9 100644
> --- a/net/tap-solaris.c
> +++ b/net/tap-solaris.c
> @@ -27,6 +27,7 @@
>  #include "tap_int.h"
>  #include "qemu/ctype.h"
>  #include "qemu/cutils.h"
> +#include "qemu-common.h"
>  
>  #include <sys/ethernet.h>
>  #include <sys/sockio.h>
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

