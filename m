Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD1DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F4E20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbuYMn5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4E20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joaBn-0006b3-56
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 18:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joaAd-0005tH-Nc
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:16:36 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joaAb-0003Vs-54
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 18:16:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id b16so3677141pfi.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ytgSCXirQ/gNtbGdXqATNvET+/yVuoIGtac1C2Wow+g=;
 b=JbuYMn5IZBVvXsI9NNBZ+hJmBix5fJThuQSbA76p1zggfa1MDHAQo2yHf3Ql3B5HLi
 6qVlwXmyCBrPzdqob4CzOS7rVy2GyvCBPVqSq1PXMfre89WThvQgK6wF1RkaMokI3sam
 IS1BbZpQ0/2DDP/ZJcWzYMmAF6gTi+lMINwXkeOJ3mU3S0xUQSix1nUoNubny9qXN3Gs
 NeVQAFb0vyRrCSifmnthHNdasI6YdQLCtXoLeuks+I234+9xX2qhyOT/osKO5jjo1/m4
 o7veKciBoYNxDvPPlzCr4Fe6zuWkMkgEsS7zFC1hMTfp5puIy9Rh7bhAw0jrMPJ0/Okd
 dAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ytgSCXirQ/gNtbGdXqATNvET+/yVuoIGtac1C2Wow+g=;
 b=tSrt0aoqyB6mixqyC/FjitoAY13155t8YB/5ERk5BkjaVBZ3fQsjO3DwLUEtqaRpoN
 DNeOdIVkXnKwIKAGWm9RLqKK15plbqBgmfYfRxgy9rh4+qqziVzmrNeG5RTRK5sWTpXk
 rK4qmlorPoMqF1qT1UhCbzGL82K+tV05CjwK3psd94QHfq6r72OiOnWRhLWfQ2IWfcXb
 qMSfwHxCI80/kEgZhA+DNWrKdO9UVGew9zUeh/qV4qWDopoqCae9YgM4y3+8tiIZ2hdq
 4TdMMC+pyAJm2gcHNyq4GpZ75ADYFVqaVnzWUPPzGpz61mFqc9HnASfE4IaZ5CH8PSGE
 aSpw==
X-Gm-Message-State: AOAM533lGCs+KW/7kqMErb1jVvEFV8rIT8Ouxqv1E8VYEA3wix5yf5Tn
 0jUpGf8SInpu5x1CEwD/7Tm1EQ==
X-Google-Smtp-Source: ABdhPJz/hqebaTyIcfXXubyY6xMpzgXM7NkxyWVIdsA9812sSsxzGa4AdIxyRV3imLlAsajWdMO6yw==
X-Received: by 2002:a63:e74b:: with SMTP id j11mr11990pgk.237.1593123390736;
 Thu, 25 Jun 2020 15:16:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m7sm21169770pgg.69.2020.06.25.15.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 15:16:29 -0700 (PDT)
Subject: Re: [PATCH v8 44/45] target/arm: Add allocation tag storage for
 system mode
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-45-richard.henderson@linaro.org>
 <CAFEAcA_svDHEDP5g3aaEL6_b-8hy0AB8oRBWj=y6G1K_r6E9nQ@mail.gmail.com>
 <f15d6bf6-03ef-70fe-2f40-0665d49b0851@linaro.org>
 <CAFEAcA_qOznfoAWtXGh-85C86fSft5ccSKQKv_uVw6-9bD4Oag@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91051d8a-d105-4119-c3af-6fe7f797bd33@linaro.org>
Date: Thu, 25 Jun 2020 15:16:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qOznfoAWtXGh-85C86fSft5ccSKQKv_uVw6-9bD4Oag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Spickett <david.spickett@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:09 AM, Peter Maydell wrote:
>>> Comment says we're checking a memory attribute, but the code
>>> is checking for TLB_MMIO, which isn't the same thing.
>>
>> Comment is not trying to allude to Normal vs Device, but "ram" vs "mmio" in the
>> qemu sense.
> 
> Oh, I see: maybe "if not backed by host RAM, then" ? I tend to
> assume "normal memory" means "Normal memory" :-)

Sure, changed.  Also noticed two more places where calling via mte_probe1
should not fault.


r~

