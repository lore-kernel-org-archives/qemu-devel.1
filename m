Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4B1C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485182080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUhr8pRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485182080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBlMr-0006D6-H0
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlMJ-0005fh-DO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:52:27 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBlMI-00060S-0M
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:52:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id i10so1007119pgk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=6HWwyRBboB3mXOi4/h8P7lQHZuPp1wXKHBqsje7IBFA=;
 b=dUhr8pRJGmHCSPokSXLw+NpQBCmrhfKW6/+nHaCz3b5GMpDnW18CZmzwgZOrzsScim
 H1KRvtE8zAVz9CXupD3JE5VP9oWtayarQtZiGrXb4vJktN8KYzu8jd8VfBE6ekfUVKnE
 5KNUNqN8trHuy0np8hLCKo6Cjdkcjm4yJS5f76QyRLvP0oOczAmXoVfmfyIrQdFNPhGK
 pK3VxIhNanBqT5ttSZNM7gNa4Z2htdKVYr1/tF22ZwhWg84VcDzg2UkemaEEbCiP40iQ
 jzaXTkgW7kYCPndVqOr3emm1KN8YXkdh+toG5JWq4F75/Xp4cuMOBrKG4BMEsQF+pK9P
 Jwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6HWwyRBboB3mXOi4/h8P7lQHZuPp1wXKHBqsje7IBFA=;
 b=MX+X1xd/LG2o1XHFCjkMgCdraVm5x7af8LGaTdQ4GLUGY2AG71pmfrQHtAJwtxfMXX
 2eEWlAIQL7fRo8MAw4czpNAWizdxho8/EpomvXejESefZn6eVx5cCAtF9kIJ6sPDjkCN
 6APYaZo/K74WpDAgMCtFj/pAdwMYhoHhdlEO17LhSjHFD2X7AJ2JqF4HDapjfLHRqs2f
 OdS158OZ79zyrdECFBgpGPMCBKTZ4/gmzsj1358DwcP+7THFcPUuY2j7S/p5NCqGbbx7
 RhrbbUOtT1dvZRQOHopJ6Fop6LuqscA5iCd6F4G7QCw0UYb2pFPNSOZH4cy+EyKdxY7Q
 4Cvg==
X-Gm-Message-State: AOAM5329hSFj7DJ5TmIzz2EPB2XIhfo6t9JMKdLG8XlQvSlINWyf3QAi
 yraeZFhaokh8UiCB2eHYvbDZwo4kB+aq4Q==
X-Google-Smtp-Source: ABdhPJwIryYKP2ES2IBffyISirEXiLt6BdE20iUAwJ1DrfL06fTqhw7zaQg1QAk8GsvF3dfNAZSWgg==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr464532pga.24.1598647943426;
 Fri, 28 Aug 2020 13:52:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n17sm354972pgg.6.2020.08.28.13.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:52:22 -0700 (PDT)
Subject: Re: [PATCH v2 29/45] target/arm: Implement fp16 for Neon VMAXNM,
 VMINNM
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-30-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <62ad0946-d2bc-e287-6668-df7a1196fd95@linaro.org>
Date: Fri, 28 Aug 2020 13:52:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-30-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
> Convert the Neon floating point VMAXNM and VMINNM insns to
> using a gvec helper and use this to implement the fp16 case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  6 ++++++
>  target/arm/vec_helper.c         |  6 ++++++
>  target/arm/translate-neon.c.inc | 23 +++++++++++++++--------
>  3 files changed, 27 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


