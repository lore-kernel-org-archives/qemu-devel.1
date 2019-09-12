Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564AC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4ACF206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkfdzM6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ACF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8QKr-0004Dj-27
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8Q94-0003cj-Fj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8Q93-0004if-7P
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:32:26 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:33050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8Q93-0004hi-13
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:32:25 -0400
Received: by mail-qt1-x843.google.com with SMTP id r5so29849379qtd.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uBS103W/hIPtIJjDYmCrdnuJp0w4ne1F6jD7wH4AyKY=;
 b=IkfdzM6ieVxOJZC3DxVjzB4gLzt+mlX5MBmC1cUwDx5BxB9bkV7OCzc6OIA5D38gv0
 5Hytio2sJbZVahpsPLk1+WV9uO/X17K0Euxc84fcc+Y3IHYna4voNoD/Y5daQr4/wnlL
 G3dzGFiJdcZCdycahBMINwC+MN93DKl9A0IWxu9Cf1WjL17UN0meYaOgs/Y+zDUUCXqr
 7Lv4/72KLM+3omSuvF4z6I+mB7IhAz8of3jFzTcuRutb7ZeZWSMj6FYunwzQnRFpnX/P
 wPim+Gr77fxruHb9/hKZF5h8fjm7grzplR8J3V3vizq/2pQtPDjPjRad3jmpekZz9uhW
 XJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uBS103W/hIPtIJjDYmCrdnuJp0w4ne1F6jD7wH4AyKY=;
 b=lc+U3EB/8/UDtEqcMeTPtW0sV23f4RHr9D0JUKoIlKfRviqUmhE96CINb6UirSOks3
 NHPgi+f/bV5GvcyFbAcQsOL9IEanc+p6hQsx3vmUZNRMmzPlBsFCCoSprRKrrjCBLQ8J
 2qr6bc5D/4xB1aDtVFhCdje7oQ1SE6jWDHPl6c7JArf4JCa7qMpfxVqQmRforHkmqP9a
 rJnZ7EF4ftzKDoTyxAO0AgZk5TfL4WX7U6NCTrQfsege+enXtq/4sQuCuAj6fLTpLmpT
 pE4sXRDbSwiYSQIluBcjKqDiXcS0oykD7FBzzBSrDt0PFEnQAo8m/EX5XIk746GhvgsT
 qhdw==
X-Gm-Message-State: APjAAAVOKOA213HbUGpF5uB9jN/NKxpJQlpJqT8rhvHqZajVcksNoSvq
 qDyLNgxTe1N7FtXzJnKPuPzeRQ==
X-Google-Smtp-Source: APXvYqzzEKObUH+pYBq70hPKUjcOFt4JmrAf48u7z0pZgkb9qxu+9fjDTjLQG6Ic3lyfTGsf+nttGg==
X-Received: by 2002:aed:2da4:: with SMTP id i33mr8293066qtd.320.1568298743578; 
 Thu, 12 Sep 2019 07:32:23 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id c131sm11327881qke.24.2019.09.12.07.32.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 07:32:22 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-7-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <78f805d4-720f-6777-bf91-4b4aaf0a15a3@linaro.org>
Date: Thu, 12 Sep 2019 10:32:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-7-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [PATCH v2 06/17] RISC-V: add vector extension
 fault-only-first implementation
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 2:25 AM, liuzhiwei wrote:
> diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
> index 12aa3c0..d673fa5 100644
> --- a/linux-user/riscv/cpu_loop.c
> +++ b/linux-user/riscv/cpu_loop.c
> @@ -41,6 +41,13 @@ void cpu_loop(CPURISCVState *env)
>          sigcode = 0;
>          sigaddr = 0;
>  
> +        if (env->foflag) {
> +            if (env->vfp.vl != 0) {
> +                env->foflag = false;
> +                env->pc += 4;
> +                continue;
> +            }
> +        }
>          switch (trapnr) {
>          case EXCP_INTERRUPT:
>              /* just indicate that signals should be handled asap */
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e32b612..405caf6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -521,6 +521,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          [PRV_H] = RISCV_EXCP_H_ECALL,
>          [PRV_M] = RISCV_EXCP_M_ECALL
>      };
> +    if (env->foflag) {
> +        if (env->vfp.vl != 0) {
> +            env->foflag = false;
> +            env->pc += 4;
> +            return;
> +        }
> +    }

I renew my objection to this FOFLAG mechanism.  I believe, but have no proof,
that this will race between different types of interrupts.  Once again I
present the ARM SVE first-fault helpers as proof that there is another way.

Otherwise, all of the same comments from the normal loads apply.


r~

