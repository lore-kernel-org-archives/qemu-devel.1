Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2288A206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8976DY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2288A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6dJV-0004mF-An
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6dIY-0004CM-2T
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:15:22 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6dIW-0006gR-Ic
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:15:21 -0400
Received: by mail-pf1-x443.google.com with SMTP id a79so4851101pfa.8
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=CyfIuBitr0M4127zmcgmGJkcl/QsOfLyJWEJwkNjrNk=;
 b=z8976DY8XohBgL7ZzFqDCq7LUMRIHn6fUEWP+/PbR4O5BIZW2OINEGbPXD3gyA8rUL
 nzqSVamDcd7BOK6KNXjKFnEUl/ET3snrs8Or7eyMEoa2kf53CX0uwZyrN1RvdwAP1bju
 r3hwO7eFvshXRJf6PGHk692lPbbTqo3CFe17PHYqUkK+LBxJobXKBjBRfsbIW/jGqCUP
 jSG6YBIMmeiu4pChABx41Tsj2fck61rvGSgWi5FqGhkw5xj2MEtx+/TSxKY9tuhfFwRg
 VSIjc/8rF1cQP+Vw3swWZgzw04RPNRWsW4xI5HPKPOhE44jrOJTbXl6+qmr1A0N6VJf0
 DhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CyfIuBitr0M4127zmcgmGJkcl/QsOfLyJWEJwkNjrNk=;
 b=Upe4qHAI9g56BTmtMxCtGEGugOd/MUDzbOtdn8lTiYS9VN74Taqzt37EVHzfvUNl2/
 M7Og+Dp7trSMDlVvcy4fDRHNxVP77MaHCxAbm4w7Tw/I2Kl01BPUlewDwnTSSks/J2Be
 XyoNIxuOJXgnftcTrCuEZoEoTRlklP/uwInby5p9fbUQES5LwhB5f/k6VPTxWIMf/+Rl
 pYqe3Bc9WFAmA/d1yfjZfyKnzBwcpof7SSZjGYVnFWJCRF4sKV8G5nqPTBES90Yo1cqB
 lh5fyrRrH+jETlc2ltCQ4dFhXR4ZHM/O4etiu6HgC57xgMVoullsKUhtaiV24//muJjF
 17iA==
X-Gm-Message-State: AOAM530WLnZRE7AUUGrLEB7M/52s0zTXcCDrOd8VC1NfS/e/ZaQb4gjI
 XAmZVXYU4Ld2xhBr8x/d4IzWIVNChlEqLw==
X-Google-Smtp-Source: ABdhPJzmzcX0zw3H9V/3xFgzRC16VVcVVrAzIJjSIkj7f+RKdM0SW1GeqU1TBIKcHXLu/BlmBaPMWQ==
X-Received: by 2002:aa7:8757:: with SMTP id g23mr2497294pfo.283.1597425318916; 
 Fri, 14 Aug 2020 10:15:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o192sm10511895pfg.81.2020.08.14.10.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:15:18 -0700 (PDT)
Subject: Re: [PATCH 1/1] include/elf.h: Add EM_RX.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200814131438.28406-1-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8901d3ad-b7fa-1793-391d-6663c37c2c25@linaro.org>
Date: Fri, 14 Aug 2020 10:15:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814131438.28406-1-ysato@users.sourceforge.jp>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 6:14 AM, Yoshinori Sato wrote:
> RX's ELF machine not defined elf.h.
> Added it.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/elf.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


