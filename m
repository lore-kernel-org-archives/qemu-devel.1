Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5148C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5132468F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 20:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1Bf/egg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5132468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Prq-0002qe-Rq
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 15:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Pr9-0002RD-DI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Pr8-0005r3-FR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:34:03 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7Pr8-0005qn-9z
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 15:34:02 -0500
Received: by mail-pg1-x541.google.com with SMTP id t3so288684pgn.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tONjEr0Ng/oBil5mm71kEehmGk+VL1dTAYgOngSId1A=;
 b=k1Bf/eggu6PcGe24Ve+hS5wghJhcrvfESqSb/Gp1uSQaRe1d90k3cBBeNeEVYVJRt0
 1go68fpG2K2ZzzeX7NBMR48YdEVHK3GWRUPVrlnF5FdppOLLHEgeCkuAftxuOILe5tXy
 cU3hvbLTsfTtRpf66LaNYJIJhEYDUVvXOqLezhYvNhNjlW2rq4cF+1M+zZV+pF8HHTwh
 MHurwpoeVkzC740qahZFk9R3pfVxP5ywkxdEpMImrllL9XPpjbozTzD4e1yZtt77nyfl
 w5cmadQq5c9hsBSJxfOaVnRxM9wAgT6lCtBaGu2wy+ASwJ8HYDK9ZMtrzFWQH1vYBhjx
 +Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tONjEr0Ng/oBil5mm71kEehmGk+VL1dTAYgOngSId1A=;
 b=J0NP6MEQ5JqqD9Oq/Osd3d+Y5bnUV6JflmAtGK3e2tqePMCOdcyjNrMxnsFN6B89NK
 yUrEx+1waVac+CCoUIOjK1EyCgLnLulbFWHuyRZ9cd06kppTZaMNeUq6YXOugznNmoq/
 J9YWj/+aNFjNRnsDTqEgN4BGb95gfvBeKuZOTh7FZc7VoUkl6j80J9twzqkH5/3UYkT6
 Ky/yHw75c8c4VsOD+rbzCIcueDLimw3LHmuXdRSzUZKrMtRc9pKUn6sczHpqbWLQxo6k
 CmD+56577IYH6SmtMsIPzLBw9TD5acbefMqPGosnKb7MM3CkfV4n8O6AUikv14KVWqkj
 12Vw==
X-Gm-Message-State: APjAAAVPgEbO8ZylkCBAzIAhnfWPCBSj5Y+xC88E4b8o7TUnpvyAZk2H
 +hBFrKyYXQUw/hLQrkeNAyRcCA==
X-Google-Smtp-Source: APXvYqyggQU25Z75YGwMw+VfW7xK/GL/DrCzcxfRTQRd9jswRjS23eZjHJCwKyVkRsgrpMa0cM/MaA==
X-Received: by 2002:a62:6842:: with SMTP id d63mr761892pfc.113.1582835641238; 
 Thu, 27 Feb 2020 12:34:01 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h29sm4054854pfk.57.2020.02.27.12.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 12:34:00 -0800 (PST)
Subject: Re: [PATCH v5 2/4] target/riscv: implementation-defined constant
 parameters
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <20200221094531.61894-3-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <76e0dffd-103a-c3cf-7f7f-25c7a54965f1@linaro.org>
Date: Thu, 27 Feb 2020 12:33:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221094531.61894-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 1:45 AM, LIU Zhiwei wrote:
> vlen is the vector register length in bits.
> elen is the max element size in bits.
> vext_spec is the vector specification version, default value is v0.7.1.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.c | 7 +++++++
>  target/riscv/cpu.h | 5 +++++
>  2 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

