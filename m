Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAB6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17132086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuwKUllW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17132086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnUp-0001xW-0Q
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnU9-0001Pz-HT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:08:41 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnU8-0004UV-64
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:08:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id v15so1127236pgh.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=uJa3ICx2B1uQJg3u48HE9FY4yQe6djaNU5QbKQaRHso=;
 b=wuwKUllWIWgvPDAurzjSZVGcy10lipbQbLKmT4RwI4cwVv8j2t23l0M1DXDBeOEfkx
 8wkCIRVjzCeUxZFg3z6SNML+f3Hpg7mSM7drmH8E8/j2GC0248thtFKbf0flPTH+3axX
 erOtX8pS72u1ELtZHBxfKOmFawIReXjhtz3c25szxi79ziVWMfj/zPzyi0ZDjxgw8hDs
 dUNXHtFMVe+UfQU9hhkvGVhKuX3a3YdeLk7JjiqTxw0rK48ZUvmk/mXofPbw0iS4Zavo
 KhbrpljlSMttC5APRwkkCMT6gtiYrVfjJXIZ7q0U2sUU213YkxupsORmuTUTm3AmZcY3
 5mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uJa3ICx2B1uQJg3u48HE9FY4yQe6djaNU5QbKQaRHso=;
 b=oCqjB94ODa7yKlOmm9RsCZW+2pVbHTKUYMz4UELb1sDTRE8/z0Z8q3ZER3aNleaxTT
 BEsQoFe1mclkKyWFFQc1hcX81hIFC6CWpOoK0yQZh6AybYAiGd0MiGhAitRECNUv288e
 IOXt3H4JpGNkMcGQi9pVD4wN51UdO2XXQrVwCPpeXxhThsW1z54c98h4uMQyPWDaXp0I
 uTrL9Q2ap8RQL/nIa75f4EgE81SkuJlSIRXNIqdZCiRUVZ8u14XSAKkgFaeN9nK6LdVD
 CWEkp5LYh4QoBqrw7G9PhX7d9qbDXcC+L/Vl6Asjc6Ai40u8654eOLjI0ACgMzphm55r
 VuDA==
X-Gm-Message-State: AOAM5334c0HBGOHwtS56YOzWsDzb2JcLxh/MOWmntAwipb1NNc43xGF1
 OMt6fLAh5XDEqcZx+iEfnbz5bMIR5X5zsw==
X-Google-Smtp-Source: ABdhPJx+wsUHwGIhO9IWn0LPi//4lv6YyPGQA+HjrzVUiwgeVN8o7tVAnlgyDbC0ySyASv5pHFSF7g==
X-Received: by 2002:aa7:96d1:: with SMTP id h17mr1046190pfq.68.1598656118183; 
 Fri, 28 Aug 2020 16:08:38 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a13sm498125pgn.17.2020.08.28.16.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:08:37 -0700 (PDT)
Subject: Re: [PATCH v2 37/45] target/arm: Convert Neon VCVT fixed-point to gvec
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-38-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98160666-d11d-89c5-cdc3-bfe125616392@linaro.org>
Date: Fri, 28 Aug 2020 16:08:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-38-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Convert the Neon VCVT float<->fixed-point insns to a
> gvec style, in preparation for adding fp16 support.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  5 +++++
>  target/arm/vec_helper.c         | 20 +++++++++++++++++++
>  target/arm/translate-neon.c.inc | 35 +++++++++++++++++----------------
>  3 files changed, 43 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


