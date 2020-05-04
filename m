Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 22:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 656842078C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 22:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMj9hCYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656842078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVjK5-00083o-D3
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 18:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVjI3-0006ck-Vp
 for qemu-devel@nongnu.org; Mon, 04 May 2020 18:10:20 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVjHz-0004PA-8K
 for qemu-devel@nongnu.org; Mon, 04 May 2020 18:10:19 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t9so102403pjw.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=POfn3Xr7PiNAjzgxgJS6QntR719fdNsg4/1jeA6GuYE=;
 b=zMj9hCYc6P/MJ6LY7C+REDWOIm1S0Pi0Z1fc1ICQdsSQt1HNU0rP2hQ8HqoShnjWGs
 hCLoscGLvTGL6P/zxIXGdBuAFroYSO2fjkeYZuRh7awtvfiAVck0Jk02xW9ll/H7GT1i
 9d1i0EUJGuYC28GDE74DgWg+wiur7U6p9U+YKgnPIyZ6rwBA30nkDiQ5M9PNLoVb76xz
 H/hn4kl4gHLH7X2JJRj7uNz8E6dtXP0qtv2bGsLAQe619vV4g0na0ZM5TiSye5cCv9RW
 2BuB/+fhrW063TIIWVBUxuH47WyC8V2zvS49U2lYs/o5GVjAj6TtMAeCcWWxaBDhMSK5
 V3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=POfn3Xr7PiNAjzgxgJS6QntR719fdNsg4/1jeA6GuYE=;
 b=S4C0ds7aU2ecxBTp1GUoaNTgds8e5z0DUFi+lefq4TrLFKj3Gd7+KrxrU1y/9awTfr
 QImSYVjYu6z4flk3XzKXWKt/Mu1xOBesZpHPrKOgzG0UEx9LWOnkSagIXjmALqYhHTG6
 +MIu2zOqbzrkcl09F72YGjjusYnMyljh9ZUB0OBoKRcUvLeIS98UVUs70mJSldZPFfui
 93lLZerWFCg6Ok68rORLqp8P46mk+q9kMPsn4xrXkLNPz7s5ZByuDZsXpPS+3hCl0lJu
 sCJLLEgsuBMjAHO3zogHlOqnUUqbo3/4Cbxbcqr/NztN3Ke7KlkmmtgLGvjP5Fd1lxsj
 xKIA==
X-Gm-Message-State: AGi0PuauVzY75Jzkvq8+fib/Moft4ToY2FbL3SxehKPVLWXPfGqIuQnn
 JrSmKyf6e9FtZt4/wJc9cpb3EQ==
X-Google-Smtp-Source: APiQypLiLYWWed9gLsD8Sqq0rDFYkZ+p5SDrpYAD7arLflI9IqVREpv1m6YhoIIwDYODhZ+7y2yqzg==
X-Received: by 2002:a17:90a:e013:: with SMTP id u19mr90549pjy.16.1588630210662; 
 Mon, 04 May 2020 15:10:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id t80sm88495pfc.23.2020.05.04.15.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 15:10:09 -0700 (PDT)
Subject: Re: [PATCH] ppc: Use hard-float in ppc fp_hlper as early as
 possible...
To: luoyonggang@gmail.com, qemu-devel@nongnu.org
References: <20200504192954.1387-1-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81b2392a-d049-b8d3-30ad-6b9550c63126@linaro.org>
Date: Mon, 4 May 2020 15:10:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504192954.1387-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 12:29 PM, luoyonggang@gmail.com wrote:

> Re: [PATCH] ppc: Use hard-float in ppc fp_hlper as early as possible. This would increase the performance better than enable hard-float it in soft-float.c; Just using fadd fsub fmul fdiv as a simple bench demo. With this patch, performance are increased 2x. and 1.3x than the one enable hard-float in soft-float.c Both version are not considerate inexact fp exception yet.

Use a return after the one sentence title to separate it from the body of the
description.


>  float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d = arg1;
> +    u2.d = arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd = u1.nd + u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }

First, you need to verify that the current rounding mode is
float_round_nearest_even.  Otherwise you are actively computing wrong results
for other rounding modes.

Second, including zero result in your acceptance test misses out on underflow
exceptions.

Third, what is your plan for inexact?  There's no point in continuing this
thread unless you fill in the TODO a bit more.

https://cafehayek.com/wp-content/uploads/2014/03/miracle_cartoon.jpg


r~

