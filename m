Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AC4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C842068D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvUSS5aU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C842068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUI6-0000re-J5
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPUHI-0008W0-CS
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:28:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPUHG-0005sk-ON
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:28:00 -0400
Received: by mail-oi1-x244.google.com with SMTP id x62so5028466oix.11
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 10:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Vvj7Q/vjg22wEhUCx076Xpo5uwcIqCBflAw/IBIhQmY=;
 b=UvUSS5aUAadsUU/SyHfaGttv/5m1bPQZ2oRrwCAz3CtU8Gwb3oNNTxquvR0eQek7+y
 3iI36fCK8HfQLnQYfKFH3t3EZo7AZpRZZeDeFRUEGp7RlUOjgPQ0xgq6dePDBmmdlW3r
 4NQwEG4fXWBe54RcSARaxp2mYec25AjAcLCT2Sm/FNtCAXAkhqyU115pSRuF3QAaRBfE
 lEopNp3TAsBg08In/vYO5Spna+Seag+QNZ/jc7liNDg3lOcNF+DRHS129zXELACIfAYD
 89ObWconAgm/UkkSRwg9A/JWai6of/GMynZew68doQwKRghyfX3HDY/wGP+XIg6zjZur
 YSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vvj7Q/vjg22wEhUCx076Xpo5uwcIqCBflAw/IBIhQmY=;
 b=V1sAB3b89HSxFx/ShtF7tE6fOzKAWKzFxRogvj0upwvF64ShbX+MhGgu9cdSQJwSNW
 2hqZ+uLPsIhMoF29LP2hrdiIAnYf5RwynNE7+r+lC3eIeBXkecWuRm3RGNtYeAB/QfVb
 BujRQG+mOm2KhzO2ay+ZTcuKllrhkIopufoh8xAHiR8f29IzyaJQJGVXsI7fvrm5UA8s
 B+8l+U+lHs1+aIPiD0q2KZLxcVrA0caBwqJECsR79wWbUQAY+QBq78JZCKdLSxpeutsp
 g130yed5uyTOSpCmH9DyIwXxm5kkp62S/arj269BNGJTtT03e9mItP10AojKm5fRs1zi
 jVpw==
X-Gm-Message-State: AOAM533Xn2nrrQ3Yabho6fYC8A3YJl+8YcXj8YN5hd9FJCZGubBYgORg
 RrDB9xZBj7iesU/DmLzoHCbL4w==
X-Google-Smtp-Source: ABdhPJzoQFhsQkAif1c8dxC1J0BjUTSYp0gCMyAsHcfvEbR2PQIXRuKyYMvXD5Slvi9870fRPMtO+A==
X-Received: by 2002:aca:bb09:: with SMTP id l9mr238748oif.175.1601918877483;
 Mon, 05 Oct 2020 10:27:57 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id y23sm161768ooj.34.2020.10.05.10.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 10:27:56 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Kele Huang <kele.hwang@gmail.com>, qemu-devel@nongnu.org
References: <20201002081420.10814-1-kele.hwang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be081131-ecf2-baec-3117-3fea85350f69@linaro.org>
Date: Mon, 5 Oct 2020 12:27:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002081420.10814-1-kele.hwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Xu Zou <iwatchnima@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 3:14 AM, Kele Huang wrote:
> Detect all MIPS store instructions in cpu_signal_handler for all available
> MIPS versions, and set is_write if encountering such store instructions.
> 
> This fixed the error while dealing with self-modified code for MIPS.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> Signed-off-by: Xu Zou <iwatchnima@gmail.com>
> ---
>  accel/tcg/user-exec.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)

Queued to tcg-next.


r~

