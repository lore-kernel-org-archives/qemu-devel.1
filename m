Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC7EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 07:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856BC206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 07:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaGIzof6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856BC206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy8p6-0002a9-Q8
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 03:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jy8oW-00023L-7I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 03:05:16 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:44206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jy8oU-00041o-Kc
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 03:05:15 -0400
Received: by mail-ej1-x641.google.com with SMTP id ga4so1027472ejb.11
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YVcr9dlIRHcXSTchZ8SDAoE80W7SlBpCuC8rZdxzR+E=;
 b=aaGIzof6ENeLaRfu1b8k2QGUJz6UjNAMWw5TH/KT/6Yz69Bth0ttT3uWn4mSqzJUPT
 TksPvVeTeNl+dI9NsaRdSMMyfCrauQXiTkQEaMFsuJyxku6RRsMxyHY9vwyXGzXtjksP
 Gdad51nHEmX/WKqG9ywa1OvYBHA+wMhMwWw0OzqwayqXkSQYTUtXWDnMibzHsf60YRPC
 rw/DoXIFtXv5NryosLT/b6F4cs+29nEc347v0s9YP7eFm+q0XUIA/aYy61jgWeItTmK7
 R0Qe0yFJiOC385NTZnnBAjyZ6e80MsKIKNgTYd1M8//lawKwVdQAfBv+zbNyxYJvOips
 fiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YVcr9dlIRHcXSTchZ8SDAoE80W7SlBpCuC8rZdxzR+E=;
 b=Z1OnWIPyyieRqrgs1xtRzCTwr16uZtvfX4dDP1EBc1GnZ88MlAcz4kuz+LOHREFjcV
 qMcwdI9e4uoZAfhqSvYHjfJC/J8QyRPhQq7C8UedwQ69kjDOxcNG9lNzyMc944XI6bPz
 d/oBb0OP00iOsbnNmtcnTZBvhIAfhBpDaBPMRnG+DExll0fpUEAivDfGY10287hinnP5
 RUb/7KYoVIh9HoSjOm3YjTJ2KxYk/NOrP6oBjx/2Mc8MN5UAFmaXw/ZgPBGXW60gkalj
 jJRjZLVZSESIyZbdE3gm47r6K0VyTqfgvBViEolZ8x7Q/zki0sTuBeoSbu5tzQNk9FrL
 40Lw==
X-Gm-Message-State: AOAM533O8bS+JjlIx7FSRj3UynMfRVK/vMf4waTvNVGo+A0lHBuSQ+9j
 2uHM8WHJc9wcLDbfYwlRurQ=
X-Google-Smtp-Source: ABdhPJxEc6ksKmfwTfTB26UjMf3g9AKwSfJdIqYxqP45Sa76CHm/tl3n6w2qC6hGJdpfDzlp5Fd+Kg==
X-Received: by 2002:a17:906:c0d9:: with SMTP id
 bn25mr28271552ejb.176.1595401513044; 
 Wed, 22 Jul 2020 00:05:13 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j21sm18958709edq.20.2020.07.22.00.05.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 00:05:12 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] linux-user: fix clock_nanosleep()
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39b8fb3c-8784-eb58-443a-218c29e2bff6@amsat.org>
Date: Wed, 22 Jul 2020 09:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722062902.24509-13-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 8:29 AM, Alex Bennée wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> If clock_nanosleep() encounters an error, it returns one of the positive
> error number.
> 
> If the call is interrupted by a signal handler, it fails with error EINTR
> and if "remain" is not NULL and "flags" is not TIMER_ABSTIME, it returns
> the remaining unslept time in "remain".
> 
> Update linux-user to not overwrite the "remain" structure if there is no
> error.
> 
> Found with "make check-tcg", linux-test fails on nanosleep test:
> 
>   TEST    linux-test on x86_64
> .../tests/tcg/multiarch/linux-test.c:242: nanosleep
> make[2]: *** [../Makefile.target:153: run-linux-test] Error 1
> make[1]: *** [.../tests/tcg/Makefile.qemu:76: run-guest-tests] Error 2
> make: *** [.../tests/Makefile.include:857: run-tcg-tests-x86_64-linux-user] Error 2
> 
> Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <20200721201754.2731479-1-laurent@vivier.eu>

(Missing your S-o-b)

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c26..caa7cd3cab9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11829,10 +11829,19 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      {
>          struct timespec ts;
>          target_to_host_timespec(&ts, arg3);
> -        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
> -                                             &ts, arg4 ? &ts : NULL));
> -        if (arg4)
> +        /*
> +         * clock_nanosleep() returns 0 or one of the *positive* error number.
> +         */
> +        ret = host_to_target_errno(safe_clock_nanosleep(arg1, arg2, &ts,
> +                                                        arg4 ? &ts : NULL));
> +        /*
> +         * if the call is interrupted by a signal handler, it fails
> +         * with error TARGET_EINTR and if arg4 is not NULL and arg2 is not
> +         * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
> +         */
> +        if (ret == TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
>              host_to_target_timespec(arg4, &ts);
> +        }
>  
>  #if defined(TARGET_PPC)
>          /* clock_nanosleep is odd in that it returns positive errno values.
> 

