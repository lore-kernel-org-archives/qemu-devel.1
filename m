Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB881C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E6A206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjR1+6xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E6A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtK3d-0001o2-Uz
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtK2a-0001N5-Ha
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:03:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtK2Y-0005VA-RQ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:03:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id 72so75832ple.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=44zJ0BLabxtvajiH/W+HkJKQie0u2+TL3xVYxcmUzjY=;
 b=BjR1+6xJF0qT7ZDCE57l7FGxeGkrvJDLzmQO3mb4QIFXrT7/s+IQbUR8LbLXhFvnS2
 awt01wKRwjnvGR5KSUO/lBsbWrf44kC95orrtQ/oxpe2vUz3xDIfr8kFCh3H7/6sbAo4
 d/nrHBE7ozXwPYjJ4VgGYdEgGIKRS0huPUlXo/hBXKdidG8cwXuqKmC+xaDixSmeBVcd
 TDImGkQsruEZFH/bKYB0ibzuENIhPD4kG/IbR5BXvPuE8h1rqOT44edtMvbu3FgRDJLZ
 IatAUJAPGQ2Y6r7L2F4whQUy96BZlu3WI82BuboUbRF7dlhTHkcsjtXJX3VTf6OM9S2h
 lAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=44zJ0BLabxtvajiH/W+HkJKQie0u2+TL3xVYxcmUzjY=;
 b=gsq7r4kuN5vnbn3ky9SZPmRsIRP6eZ5gTMX9oBudkobDrcbiXCofpOfskUORP5cW5V
 XtmE6WQudrj9p4eSsUQ4ZaLkXf+FMsN3gCjnFwkOeq+DSPm1Msah+bD4KGp/Rz77pKni
 T+102O5pZVRmbDYfzb3/Ss3BFHWPcYcyPB5meUAsk/Z4GS2vs/90+0H20ZhkA8pBcy9t
 JiDBn054IeJP0cF9HlL4fb1ScklskWYNOr+0N5gXcjRMVJYxz//wkSwbp1fGTLpBs3SO
 4OJL/pnb9RHCUWUg3wq+Q8pmjXLMyynUFhj5qk7nNZvOxqgFbkpsNTU3NbSQ795D4cPw
 Vl/w==
X-Gm-Message-State: AOAM5301KmQPTsElvvNQwicB83oRDS5IjhLs08AEHIZKIAeWhEtWEZbX
 4VCpsRkW0ygp23Qpg2tduI+Tcw==
X-Google-Smtp-Source: ABdhPJz0CLI3u6FsZTgaDIHQfuWrXw3SyjC3XVQxwD7MQRgpfYGok/9jZdaIePO84IIyiwxd+Ji2hw==
X-Received: by 2002:a17:90a:3a81:: with SMTP id
 b1mr12412447pjc.217.1594253029425; 
 Wed, 08 Jul 2020 17:03:49 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id v28sm809416pgn.81.2020.07.08.17.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 17:03:48 -0700 (PDT)
Subject: Re: [PATCH v3 03/21] softfloat: add xtensa specialization for
 pickNaNMulAdd
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
 <20200708222101.24568-4-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9940df7c-4cb3-a994-d43f-adc959fd5257@linaro.org>
Date: Wed, 8 Jul 2020 17:03:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708222101.24568-4-jcmvbkbc@gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 3:20 PM, Max Filippov wrote:
> pickNaNMulAdd logic on Xtensa is to apply pickNaN to the inputs of the
> expression (a * b) + c. However if default NaN is produces as a result
> of (a * b) calculation it is not considered when c is NaN.
> So with two pickNaN variants there must be two pickNaNMulAdd variants.
> In addition the invalid flag is always set when (a * b) produces NaN.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - handle infzero case in pickNaNMulAdd properly and reword commit
>   message

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


