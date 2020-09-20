Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87183C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 22:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A7120809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 22:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+p9A659"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A7120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK8HM-00055Y-3p
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 18:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8Gb-0004Hl-8d
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 18:57:09 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8GZ-00045L-QZ
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 18:57:08 -0400
Received: by mail-pj1-x1042.google.com with SMTP id kk9so6077832pjb.2
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 15:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WPhv/+y1lMebbLO/INKHNsFXw0HSeKO2ZoFERWZb5GE=;
 b=Y+p9A659m9Jpku7QPPxBxVXKd4j+HDzjhqDC7hDeNJApk/6QLrSpGEV90xcqbgiuDm
 Q11/7wx7K6Mu1NVgsCqXvMb6H5C+YdHOvgkh9n7tfitR/SqJGZXcMBiInyRYIQiZVUgi
 zFpoBi9L+N0cohjawnbPrs9KNRzvFJYzmwQlwLVOwL9QtWTGjafZQr9CVrq5SBlG4MiQ
 dexpQttPPjk2Aykw4Xdw57+9oqffGu611qWolTW34Q/vYCo23jEykqN1OvTaGIpnRotr
 eJxW5FZWOZm/1RCxD9xRQjhAiKqkpyagX8ib7unJlrO9qGa1hkNWN4V58KvqCDK2Eia4
 m4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WPhv/+y1lMebbLO/INKHNsFXw0HSeKO2ZoFERWZb5GE=;
 b=jGdakQxcO2a7FPO9UmzZp4L8vVahDW8uYCrQNibOIpiwWJbbeQCUxsySR6/xeFcfsM
 TtTWyrUJ8KQ1asibHi6I0UYpgEqc8T/zQxybgkHxi2FQ6HKNBCnHqC1ILHbJZj0Z8+Im
 l2c3bB+IYqqaj7bCe8jXEU0LQ7b2H8xf0dOGjmycMIGXXq6P565A1ksztnWbwz4gtbR2
 ihWBDaRsA4pB76C+tMBdwkU2/9dPXDsCuIu/IwEMx5SEn6vm4RokZ3z0XbVbg3AHyorj
 /E80lb9v3LcMt33YpYjTcoGyw0nxJt2sOBm7mNAKViNGzWgn0MQ4d/OFcD7gKRrlilRZ
 xewQ==
X-Gm-Message-State: AOAM530f9rdr1R7F3+gC7C5xVFM+AHW9uZVmeRN54maCrFszDUJtlcTA
 loJ7K1pobK3S8YDkRrSBo6lSfg==
X-Google-Smtp-Source: ABdhPJxgzIfYvxBUvFmvrV5FJ8wAZf1G+kCg36/wEVrCbVuPo8m4JpWwM67uIgTsjfY+2e7k4X4/Ng==
X-Received: by 2002:a17:90a:4005:: with SMTP id
 u5mr21422357pjc.7.1600642626211; 
 Sun, 20 Sep 2020 15:57:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g23sm10086252pfh.133.2020.09.20.15.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 15:57:05 -0700 (PDT)
Subject: Re: [PATCH] timer: Fix timer_mod_anticipate() documentation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200920155042.400737-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <41b6f742-ff73-65bd-f480-d32599316228@linaro.org>
Date: Sun, 20 Sep 2020 15:57:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920155042.400737-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 8:50 AM, Philippe Mathieu-Daudé wrote:
> timer_mod_anticipate() will be scaled to the timer unit,
> which is not always nanosecond. Fix the documentation.
> 
> Fixes: add40e9777d ("timer: add timer_mod_anticipate*")
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/qemu/timer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


