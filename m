Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D5BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDADB25307
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rN1o9EBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDADB25307
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNdt-00006f-Ni
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNdD-0007zL-Rn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:58:35 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNdC-0006fl-C7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:58:35 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a1so242286pjd.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=kjcdsLCEJCFzeMrTcX3WjkgAnDjuz9bXPb1/3p7Dwoc=;
 b=rN1o9EBgVAlbdP950rNMWE+oFMxSUkYsQbgTEGl2hdhRTIAzfNXnemaCqTPxoq8XUK
 ZuQx31NfM4A5U4nZIBlh0VAdUt7I676zLu3N8yqnP/P/D5HMFTRXGudKNthQ+UonPmFf
 yH5yx40lO809dOKU00kJlDE5y02kClvoERCbXfOL+Nzb8zEYT4t7KwnaK2Cq6Jr5TitI
 1fLi8RXn5kPcLDg8ysGdEEoJ7x2GYuEHCSV+70/Tv640ynoZ6xpLtudbGadNFfthXeJz
 WDD3hcK72jDX4POsA/tZ7MXjZLAWBwRmEGdlVpG8YBI+uCNMpd02ajcw1bSG2YQj/XqN
 sm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kjcdsLCEJCFzeMrTcX3WjkgAnDjuz9bXPb1/3p7Dwoc=;
 b=tjCzrwNgZK7FeIyzsYmnyNLPMgUDothx2ePGLMThnBHcGVDO5SNy3hzItuiLxypdyP
 Ij2o8TDXudmgN2y45QwYbIaa7VcK1z4R1LgHFwcH8wr+25b+1plvwxVI1aTdSgNjJCkw
 UH2loNSQhRozFAbxUBQK+fkb0qphDhQHcV+WACItTgvEmpSlc2kcDRrWsbtM/uA6wzhd
 OR+luwJfxfyYgjd47eK6liPlGiTylGgJjeCD0UQic0Xv11xSWji6kAg/nhqJ5W+R3A71
 ZWg8HFc0ciR4QktoShBbOTzYujD+879MyemAQDarNDl40R9UBJKzU9usUUFTeMr6U6yM
 XyDA==
X-Gm-Message-State: AOAM532FoksSlPHvxesLHIGCf0fWFypaGJJcgJSq+vTl9LJhm3ddvMeT
 WvtbTG3N43c1FuGAiZKkuHFBlCEGz77IcP9P
X-Google-Smtp-Source: ABdhPJzhpIdyaNUrN2O/SIeqjgz12MWbdzC9pdBWtPZ8UF7pnYGwA7ZKyawcXHnOk9z3k0M5lP+hAQ==
X-Received: by 2002:a17:90a:bf05:: with SMTP id c5mr657235pjs.11.1602608312296; 
 Tue, 13 Oct 2020 09:58:32 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x25sm178339pfr.132.2020.10.13.09.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 09:58:31 -0700 (PDT)
Subject: Re: [PATCH 06/10] target/arm: Implement v8.1M branch-future insns (as
 NOPs)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a055900d-a7a9-e1f7-6354-fb8e518d6763@linaro.org>
Date: Tue, 13 Oct 2020 09:58:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012153746.9996-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 8:37 AM, Peter Maydell wrote:
> v8.1M implements a new 'branch future' feature, which is a
> set of instructions that request the CPU to perform a branch
> "in the future", when it reaches a particular execution address.
> In hardware, the expected implementation is that the information
> about the branch location and destination is cached and then
> acted upon when execution reaches the specified address.
> However the architecture permits an implementation to discard
> this cached information at any point, and so guest code must
> always include a normal branch insn at the branch point as
> a fallback. In particular, an implementation is specifically
> permitted to treat all BF insns as NOPs (which is equivalent
> to discarding the cached information immediately).
> 
> For QEMU, implementing this caching of branch information
> would be complicated and would not improve the speed of
> execution at all, so we make the IMPDEF choice to implement
> all BF insns as NOPs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

