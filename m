Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02BAC4724C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7CF205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoI8/lzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7CF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVfWy-00027z-La
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 14:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVfW2-00011w-5o
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:08:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVfVz-0002Kt-5D
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:08:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id w3so62790plz.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qbdHUTIG1XQ0SccWx4aQ4x20USpOl3NWAwKSe/b3WMw=;
 b=zoI8/lzn9zXO7Hayf0PY6hVjLFnb8JGBM6wYT1zJdDKzPaTpJzRlzbo9iRa/891X7k
 ze2XVvgbq1R7blZkfwYykQorqHCApZ/m9cvU46mYuf8vmuuhlVfau8q2piTGvXY2Z0+d
 z9XgXEKC1OJ+Z5Idr7KLlj0h6tbGxryo2GohGu+RBRTbi5Xbf9Xdek0yYwrWnHtw/xuR
 wN17aS1PBlwNer3jFIOzeVmYH5pKWxs9bLiLnCG4kHoFyKuB2V55naPZQj49VPwCwbvq
 10rDQ2RLHbwC/+2d6gBmxMir6BrgsanmVv+WnZUVGC+A8zR0vVOHXeULXKwFSyGfzm2W
 XB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbdHUTIG1XQ0SccWx4aQ4x20USpOl3NWAwKSe/b3WMw=;
 b=Y0jhDbu45WKHtmfTBrpeWcxsTm39FRQXPeUlTYACX3ExdFclYgGw5ZkSBW2AOu9k7D
 4ZVQc/UqCkWJVdtbKStBYKLYdGU3dOgGCFS5pwyLlSll2Kv4jXorXCBKwUgdh1fIuHGy
 lZjp2FInaL5YtkLVb2vhCeye4hli0OS87UqooLhtQZJdNpJgOx89CKM5/4T3N3lgUEjT
 svVTOejJ/0apc9CD9V7Q3dHnOltUXzRtcLp/OgxjT1EeT+FIKvzNi4ZfHUR+oRiA4h6y
 dGxm+GI/aQ5XCBUrfIXwTeoI5PL+/uLCPC4sepAaXf65pWe0GSpYpIFb+O0fAguHGFQu
 Ev9A==
X-Gm-Message-State: AGi0Pua5nJDpHFO8J4Oelb+/R6u6noQiw9cTrvVMeN8Ccc1ExuC1YYnh
 KwM0N1vtPxO1nhVHFLcxClOFtg==
X-Google-Smtp-Source: APiQypLULmqEsUMdP/Y0wV1iQwH16VGGwVho6wde5hG67YHXm0eEAcZkw8hIFwNMh50p9+bGZQTofg==
X-Received: by 2002:a17:902:7241:: with SMTP id
 c1mr401449pll.113.1588615705303; 
 Mon, 04 May 2020 11:08:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a12sm9263327pfr.28.2020.05.04.11.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 11:08:24 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] target/arm/cpu: Use ARRAY_SIZE() to iterate over
 ARMCPUInfo[]
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200504172448.9402-1-philmd@redhat.com>
 <20200504172448.9402-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eedbc418-970b-e8ac-576d-7bfc27c4b361@linaro.org>
Date: Mon, 4 May 2020 11:08:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504172448.9402-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 10:24 AM, Philippe Mathieu-Daudé wrote:
> +    if (cpu_count) {
> +        size_t i;
> +
> +        for (i = 0; i < cpu_count; ++i) {
> +            arm_cpu_register(&arm_cpus[i]);
> +        }
> +    }

You can use int instead of size_t to avoid the i < 0 type warning.


r~

