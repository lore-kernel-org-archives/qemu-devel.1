Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D93C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F3A224F9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRzocVo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F3A224F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQdT-0000oN-80
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvQcb-0000C1-M1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:29:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvQcY-0006lb-VC
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:29:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id j18so8457920wmi.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tnKvJwsoGOJA1uHwQtCX/bXPsMIijhMEs09hYCQBsoM=;
 b=aRzocVo4cvhhYKXKSzw4QMmQSbpuNxEC26E7gcKrWPfx5qHpSLfMU4Z2zELsydCEHt
 24xewIudUoza4e0Ta0O6136Qizlw/AbxhwCeoilWPSMq6PDOB6NY+xAr+W/W0JxVYnQT
 85DVNV8ff0Jze5UxgU7ZGfCfjDv2fRM712tNXNABNOemB5txGDRHkbMi/u8QLFCnoxxr
 dXqRRER0Oo3qjgSYeYZoS40qGTH34lBjNpnLm3ql050D6GDcq6nTxOVvaMPWTHunFHtE
 Zn09WL2Qv9wDe0drfCgg9RJUfMPu2Kmh0/7r0UAzbTR4ww6+5VSqNZf8PoeMLiD7RRX/
 Cfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tnKvJwsoGOJA1uHwQtCX/bXPsMIijhMEs09hYCQBsoM=;
 b=ZA9lyYeaI0Efss4JunEpXjjBiLQbtBrNbVfq4HqH9W6DWomdkKY3EZ3GgC9xVmYg/D
 mq1lrAX1oY1pSleTpdneWj3/THreD3X2wBB6Dup1hzUtUFWB6VvlqO+leRTHo3tu8hUg
 2T5GGadvVa80dQPTgkiud5MdONsadoefPPZ8vdQeV1ADfUsqWeK1t8CqxTtsDREDVite
 oOPgSj8AcV7fbfRLAP/sjQu3xkNMseSLCu+wHTQAEcpcypZSoXXkC9hg7ampBY4fmhdS
 m3MQ9ODQjOUid4nogN0MoehDxZIjjy5FIoPKO0+KzV6lQcytjFGlKvzbzhRe44Qc70Ap
 ALbg==
X-Gm-Message-State: AOAM5330jk2QC+L1Mwoye9JkPaMyr5BKEbCe/6an/xkbT6nvMeZIyJoz
 gNM3f2gNQ3nYZ6F+DwpqINk=
X-Google-Smtp-Source: ABdhPJw0np4TO6JsRxTlx00jv91zSemRfLxAbzSlqSqtBuhIu4vUUShi7ofrgyZONY8bkf73apDnsw==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr5229772wmu.142.1594754981080; 
 Tue, 14 Jul 2020 12:29:41 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 14sm5641783wmk.19.2020.07.14.12.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 12:29:40 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: skip ppc64abi32-linux-user with plugins
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200714175516.5475-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96f467b0-a2c1-0e67-02e3-0565620fb0e0@amsat.org>
Date: Tue, 14 Jul 2020 21:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714175516.5475-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 7:55 PM, Alex Bennée wrote:
> We actually see failures on threadcount running without plugins:
> 
>   retry.py -n 1000 -c -- \
>     ./ppc64abi32-linux-user/qemu-ppc64abi32 \
>     ./tests/tcg/ppc64abi32-linux-user/threadcount
> 
> which reports:
> 
>   0: 978 times (97.80%), avg time 0.270 (0.01 varience/0.08 deviation)
>   -6: 21 times (2.10%), avg time 0.336 (0.01 varience/0.12 deviation)
>   -11: 1 times (0.10%), avg time 0.502 (0.00 varience/0.00 deviation)
>   Ran command 1000 times, 978 passes
> 
> But when running with plugins we hit the failure a lot more often:
> 
>   0: 91 times (91.00%), avg time 0.302 (0.04 varience/0.19 deviation)
>   -11: 9 times (9.00%), avg time 0.558 (0.01 varience/0.11 deviation)
>   Ran command 100 times, 91 passes
> 
> The crash occurs in guest code which is the same in both pass and fail
> cases. However we see various messages reported on the console about
> corrupted memory lists which seems to imply the guest memory allocation
> is corrupted. This lines up with the seg fault being in the guest
> __libc_free function. So we think this is a guest bug which is
> exacerbated by various modes of translation. If anyone has access to
> real hardware to soak test the test case we could prove this properly.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index ab429500fc..6695c0620f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -350,9 +350,10 @@ jobs:
>      # Run check-tcg against linux-user (with plugins)
>      # we skip sparc64-linux-user until it has been fixed somewhat
>      # we skip cris-linux-user as it doesn't use the common run loop
> +    # we skip ppc64abi32-linux-user as it seems to have a broken libc
>      - name: "GCC plugins check-tcg (user)"
>        env:
> -        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
> +        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user,ppc64abi32-linux-user"
>          - TEST_BUILD_CMD="make build-tcg"
>          - TEST_CMD="make check-tcg"
>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
> 


