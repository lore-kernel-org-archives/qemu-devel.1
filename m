Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E442C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E073B20767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxAe8buw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E073B20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXwp-0008Pu-4W
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXwI-00081G-AA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:54:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtXwG-0005Pk-MT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:54:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so2710917wrl.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ocqas2lGLVNqSD7DlHw5knGZXw7k8HS06PXgqz0cKVo=;
 b=PxAe8buw6XWD516uGaTe25um1h9ReMCW6GejGjsOpb6GUR9KRNqtrUbuFtmWBUgYft
 7LGq9PxWcWm9AKjow4/X40LuVeNJnc3e4CC7YnaBDg/4jQTR50f3M/EKvqn0csx/Iqvb
 jIOAFBGQy/TIgNIhnDPeZrUpouD0Iyk0F180wz6DwC2FDCyXWpbinm3uyK+mlYwbwpLW
 C7rTJphbFoEDNM7hO9iqdFcKNB39tGdBDF4MAUpaUmWIVXLnAr5v87ToUn6v0qW5HzGq
 XtDWGGIjIZq69ZRj39mN3Ed6CHz/Jj/LocRL3L3ctP2IxVqc4jvNyaD8GgTioutIn3BN
 4fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ocqas2lGLVNqSD7DlHw5knGZXw7k8HS06PXgqz0cKVo=;
 b=G+S/3Q+0JcurV+XdEn8d4o6Cb8zYZgkru5IiN8YjakFD6EkVR1pVUCxGK7mcKOozrr
 8qIDKm1vTcu60yoCpsdF4nG/edqxTO25233RRK9PlSbLLxwvholiD8TOy7DfnXiKavud
 4HizPZYAz2DeDJEdahI3Tl2ep9URRc+xnflSTPtLg6hjJdYHO/9iCSS/wzlFOdOJX0W8
 HVDUvsSaZhgMqRfdp/x0M9MyskzjZvi1l8yr5ERsKxRiHrhcNgFqitxK1rUFevDnqfCM
 LUqI0NroA/yFVSxK4e3h3MHl5LL3jUw1k+Xb2Dvj2eR619ICC8t7hO/V1Fb8q8/0euEJ
 UMoQ==
X-Gm-Message-State: AOAM533EkJ4+kZMHzLEmeUMkL8Hs1AjG25EZp+0W17DgwpT1TjAQcujk
 8NrlTIBXJYiPFSH/jOFaRWo=
X-Google-Smtp-Source: ABdhPJwRFpIfXf4hCINEO513wJihrrtAp7M+dUmOYLh9VzXu8V/u9hp7gaPKhrRcOxF8c/A0uc8FqA==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr65213758wrp.96.1594306454978; 
 Thu, 09 Jul 2020 07:54:14 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k126sm5320725wmf.3.2020.07.09.07.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 07:54:14 -0700 (PDT)
Subject: Re: [PATCH v1 12/13] tests/docker: update toolchain set in
 debian-xtensa-cross
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19929734-1986-8d07-94d0-aeebd449631c@amsat.org>
Date: Thu, 9 Jul 2020 16:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-13-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, robhenry@microsoft.com,
 Max Filippov <jcmvbkbc@gmail.com>, aaron@os.amperecomputing.com,
 cota@braap.org, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:13 PM, Alex Bennée wrote:
> From: Max Filippov <jcmvbkbc@gmail.com>
> 
> Switch to the prebuilt xtensa toolchains release 2020.07.
> Drop csp toolchain as the csp core is not a part of QEMU.
> Add de233_fpu and dsp3400 toolchains to enable DFPU and FPU2000 tests.

Yay thanks Max!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200708082347.27318-1-jcmvbkbc@gmail.com>
> ---
>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> index beb73f46baa6..ba4148299c5a 100644
> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> @@ -18,12 +18,12 @@ RUN apt-get update && \
>          git \
>          python3-minimal
>  
> -ENV CPU_LIST csp dc232b dc233c
> -ENV TOOLCHAIN_RELEASE 2018.02
> +ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
> +ENV TOOLCHAIN_RELEASE 2020.07
>  
>  RUN for cpu in $CPU_LIST; do \
>          curl -#SL http://github.com/foss-xtensa/toolchain/releases/download/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
>          | tar -xzC /opt; \
>      done
>  
> -ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/bin
> +ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
> 

