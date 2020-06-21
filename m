Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9730EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE9524879
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhdXLU2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE9524879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmymE-0007Ys-Jt
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmyle-00077p-7j
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:08:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmylc-00065b-3Y
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:08:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id g18so4875069wrm.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6JzoXj6HJgxXG6w4ybCmHlLyAAJbfRXp84wuN5CxjoE=;
 b=AhdXLU2yu/w7aQIqiMyRaAo7h/j6jCXkTgGaXKSFF0K4+fnRp26eAq6rcQHXQrF06i
 ANuVSk76PR9Lo7i/0lGOflHkcFi74VC4VTQncxhnIxy0eO1IKpKg9gUPKuBCn0Xzudv7
 iZTsR6khSedL9kiP3BJntSZQ1iVhTVRUK/t/KtAzmfk2gLdKhjUnQR0G2edofHMKnbie
 rX1k7HLp3J6KTp+vfk68ruR3NBn+KPzQoSPWxNa+GqJVWRM7sS43pEFhG5wqLMNPlm+M
 qmc8xDXApvMMCNEqMS/ruG0oWthPSjz1E33XNIv44NZ+UCym92WM0eH4yxaXOWBOeQow
 5hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6JzoXj6HJgxXG6w4ybCmHlLyAAJbfRXp84wuN5CxjoE=;
 b=izXUZt3whyvm9wS3C5lFMi6mE9/Wzb8y3zrW4Xswzp/4RD6OtXadeUK+cx8TG2Xy3u
 sJvY1cmJhIXTzBjtHpQbjxkv2oSlplC0fIa8JiP00GZNHSRUxo+qXLQ6WlXnAWfTZbz0
 Wc1hje3nAaBEt4kb6ifpb/Hahm+4y+6WAghhbXsSKIQsZ6dA2OpEKjavPTzwmLGpcs1G
 5bTKBK9K66Ti/+Uf/HevdnuThmtjt6VL92zEa8ZDrCGiMdd+TNnQJ1QdOUgdjuGEmqOk
 WIVHioidXnLj31rSAhyk54n/eyeGDwhHdwcJfZlmnHhEJuWixKqLXppBU+x2HKQRzR8G
 P6LQ==
X-Gm-Message-State: AOAM532gIUgPAFYz+gjcW9c9T4NAX+Cax7nT2rFHTAaNvdaQC0cnqG8F
 krxPDubetu7uNHWiByaYwdw=
X-Google-Smtp-Source: ABdhPJxRkwvUSnDAoSSu2B/vhF+WQVe3/699NS+5A4+Rquxpw9PGNpBqoID79kqgF26iUaB6QKL4iw==
X-Received: by 2002:adf:9286:: with SMTP id 6mr13810999wrn.361.1592741286651; 
 Sun, 21 Jun 2020 05:08:06 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id k11sm10787766wrd.23.2020.06.21.05.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 05:08:05 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Build acceptance tests with -O2 compiler
 optimization
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620232947.17895-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6ec17c5e-a7a2-ec47-cc30-807405cd39c0@amsat.org>
Date: Sun, 21 Jun 2020 14:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200620232947.17895-1-f4bug@amsat.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 1:29 AM, Philippe Mathieu-Daudé wrote:
> As we just want the tests to succeed, build them with compiler
> optimizations enabled to run the tests faster.

Maybe it is a good opportunity to test -O3 instead...
Since this configuration is not covered.

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 74158f741b..61b247db9f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -293,7 +293,7 @@ jobs:
>      - name: "GCC check-acceptance"
>        dist: bionic
>        env:
> -        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
> +        - CONFIG="--extra-cflags=-O2 --enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>          - TEST_CMD="make check-acceptance"
>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
>        after_script:
> 


