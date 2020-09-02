Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB00C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1430F20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohRU3oVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1430F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDayg-0003Ic-9A
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDaxA-0001Yo-Tx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:10:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDax8-0004VJ-MJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:10:04 -0400
Received: by mail-pg1-x543.google.com with SMTP id d19so410486pgl.10
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nP+/npvxTKz+OscZ2pYf+5f2vhMceoDfb+kQZAy/2Xo=;
 b=ohRU3oVkjYDRzXf3lgu04fVGVU4cgv9DOgV/eOEoaeifx6EOGtdM7cUcI2HME6ymFG
 UF8fLZSlcHv11uOhHOi55vpgX1ih0tBDGNty82xk/0nm7MbaysOFyBDj5HrOh9CcIMHF
 IuT4ic876tXwuTBqonc+9D3lDnepNF4LzV4Gqd9G+J/7RM3VL3tr+kr0QbtoulN+ZnuP
 oatDGLyPdYNPoANYLdS/Q8i/nNqueNeoTR2ULoqhDFAsu+WeEO+wE6YqA89ZCroDuRFa
 1e+n+cQPsue/scTrJUCJPSs8VacUUhFUfKzRFeQAShg1hDgj6Jd0IPRmJQNqLVAE2BzB
 8vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nP+/npvxTKz+OscZ2pYf+5f2vhMceoDfb+kQZAy/2Xo=;
 b=fYIK9YR5mjRb5UYQjNI7VHqgTma4HxJ0vPXGJ/Z7YnimcsBSi1AJfI2dobWYFhdP/0
 7kpOqlY/A850yHtBtyPjkc4ld7UXosD3TsA4WNCdRtIpVpvnhIwB6eOf1Gl4NAXeFN36
 0FyudSVItgtYQ1knWjGmwXt0P33gYapyce/u8WdPO0Qtf4DnLLZom+a7opeub4Vso3pu
 5TCQXEKeUpiZETMSnMfaNOQc9A1XJ+O4EV61O9pjUG4m1B5rejV5swySuzDNKMCfcgur
 ifDID/pXFUaIEsHfqvR0uq2z6315kGr/NrO+GqKg3v64YyLsqsABVHZzCOwoNiY0/yLc
 MJXQ==
X-Gm-Message-State: AOAM531ozYURqjdrjS1GQcvbA/g4h4oT2PBiTYhX5xW2KOZrhYhEgv/t
 oOJK5F1bFt7dQ66KC48+YBQyYA==
X-Google-Smtp-Source: ABdhPJxIidSKh7YXaera8Yn5CHdcjIAnhw0FeD0wppQF4L/7U5p8McCY/hPI4zz8kkZ5DgDEWG4Syg==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr491933plc.88.1599084600164; 
 Wed, 02 Sep 2020 15:10:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s8sm534732pfm.180.2020.09.02.15.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 15:09:59 -0700 (PDT)
Subject: Re: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
To: Helge Deller <deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-7-deller@gmx.de>
 <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
 <20200902214819.GA2424@ls3530.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
Date: Wed, 2 Sep 2020 15:09:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902214819.GA2424@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 2:48 PM, Helge Deller wrote:
>> Is it a bug that these Y were using 0x3ff and not 0x7ff?
>> Because it's pretty consistent...
> 
> I'm not sure if was intentional, a bug or just initial coding by Sven.
> The old code was limiting to 1024 lines.
> I assume that there doesn't exist any real hardware with > 1024 lines,
> so it's more theoretical.
> I tested the code, and it seems to work with > 1024 at least.
> So, I think to use 0x7ff is probably more correct - at least if we
> allow more lines.
> 
>> You should make that a separate change, for sure.
> 
> I'd prefer to keep it in one patch.
> It's simply moving code around and reuse a macro.

It's more than that, it's a behaviour change.

Code refactoring should be separate from feature changes, when at all possible.
 And here, its certainly possible.

>> Was the original values chosen by the user?
> 
> Yes, can bet set by user via
> -global -global artist.width=800 -global artist.height=600
> 
>> Should we be giving some sort of error for out-of-range values?
> 
> I had a warning there, but then removed it again. Most users will
> probably use the default values anyway. If you really want, I will add a
> warning. I'm not a fan of errors. Errors usually abort, but we can
> adjust and simply continue here.

It's exactly the same error as -smp 1234, when only 8 cpus are supported.  An
error is more than appropriate.


r~

