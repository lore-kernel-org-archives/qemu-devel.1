Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CCCC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 02:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC072086A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 02:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvhnfVrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC072086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEkDH-0001nn-FV
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 22:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEkCh-0001Eo-Uz
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 22:14:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEkCg-00032L-81
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 22:14:51 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh1so2860447plb.12
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 19:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rnqKeYjT1gCh07zTwKxNFwiWzunpvcDckfNSKQmPOY4=;
 b=WvhnfVrAWGpO5YTZa8vTdwwo3vDGFUJ4Bz/6ejCfuascmI5lugPsAd2KdCEdK+rZpc
 W2d3k8GZaUAJMHpfvJBzagl5LGAiAoBWaKerVOo3WVz2sCp/K8o+X9liJQWgJu347JYC
 ypnCADbshTYxd5KaG/DIrfN7WQj5+7Vne+yapgICQemn+kQewOfQ4kpK+ewKfLgQpF2a
 w+432JJKx5ZCQcJsk4ievLkaiwzYQoKdqfQ/FsNJBSU98r7AI3DK811m7TMzmfezMR+S
 U41trQEVX/JQXl4O+wAJo8FYdT+zauuLxfh83HWg/INvu7VXQ3Mn+2IldRYGhOGh9YHD
 cK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rnqKeYjT1gCh07zTwKxNFwiWzunpvcDckfNSKQmPOY4=;
 b=MSo+ZKPQAlMLUkCKTCjSCvx2GIdd4yuqZHit2wgJN8VfHM8z22UbGUQlsx4JagBgIZ
 zDrCEB0WhX5ZTyBAQ5G7+PrtG3NPtczNzKZLOhtY2ej9/P+BLwPCUguBB5yufVe9/GRr
 l2dHRF0GlYW5Ew5oXMbosM5skb0l4KdobdFKD71BPN3zFbzq8p8Ouu3F5236hojGdIc7
 oud0/CBWhYnT+CzPloPTmt8tgAkXn6AiB55vOd/zPRCrOweWooJBEMdQ074sXg3LuOI7
 DIK+Sc1+4VsVDUIhNk2HESsqUx5ChLtCblBHfwHirUNjw2419z/VUHfaewZ+omienUoU
 9kQg==
X-Gm-Message-State: AOAM53169yNncn4+5IuNl+B7pMcIc0Dh1W73qNdfOJy99qKyuzPK7TaQ
 drxTguZQOJ99y3IMLmqCxsgWhQ==
X-Google-Smtp-Source: ABdhPJxnQicC9/9sXGfEWdOzMd5HfEWMxdxOrLXEN4TGKOo8fioo1QFh2SfcKoGimyiepEvtbQqKAA==
X-Received: by 2002:a17:902:56a:: with SMTP id
 97mr14845116plf.130.1599358488564; 
 Sat, 05 Sep 2020 19:14:48 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 64sm3846510pfz.204.2020.09.05.19.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 19:14:47 -0700 (PDT)
Subject: Re: [PATCH] tests: Fixes building test-util-filemonitor.c on
 msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200905203425.1470-1-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0a88f9e-b4a9-9ef1-ee47-6054a1cbbc5e@linaro.org>
Date: Sat, 5 Sep 2020 19:14:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200905203425.1470-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/5/20 1:34 PM, Yonggang Luo wrote:
> Fixes the following compiling error:
> ../tests/test-util-filemonitor.c: In function 'test_file_monitor_events':
> ../tests/test-util-filemonitor.c:620:17: error: too many arguments to function 'mkdir'
>   620 |             if (mkdir(pathsrc, 0700) < 0) {
>       |                 ^~~~~
> In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/unistd.h:10,
>                  from C:/work/xemu/qemu/include/qemu/osdep.h:93,
>                  from ../tests/test-util-filemonitor.c:21:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/io.h:282:15: note: declared here
>   282 |   int __cdecl mkdir (const char *) __MINGW_ATTRIB_DEPRECATED_MSVC2005;
>       |               ^~~~~
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/test-util-filemonitor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

