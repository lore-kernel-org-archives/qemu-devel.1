Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E91DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CCE20756
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDzj/XMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CCE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZjFW-0008Fo-7z
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZjEq-0007gB-Ke
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:55:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZjEp-0007fk-7Z
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:55:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id t11so1691890pgg.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=bSk+j3z6J7bFedrMgMHv2jmU2o0wk5kh3M5NzgL4M2M=;
 b=lDzj/XMmBk2jYC3IWxh3g1ZYCX7MekVBtHnbyNtcgasqk1eZdMiyoqtCRPOxXaBJRd
 Nl8t7zbviGZo2Eacu7f9ldibioyoeLdFc8/r+LPtex0YNu/niM7z4umzU5qHrUFVH1hz
 UGlze43dPm1GoJ6S6u7cB6p7+dak3We8Fza8zVTNvNBNoeKK2b05xQwo6N1S80QZEJXX
 dzOU1EOEm1iELRXu1gsoOYj7j+tXX4vIVs7JoNeLCEhzp7eLq3fiVN5OlQRIPjDBjkkH
 xqCZJtl/8nIdu4+mIFPwyWS+5zbYnm0l02syIHMuLTjjQaAVZM/IE/XL2PKE58fryjhX
 DYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bSk+j3z6J7bFedrMgMHv2jmU2o0wk5kh3M5NzgL4M2M=;
 b=ZiKGuxHL6auOMCp84YWe9dNOcS6tl/F6L45PlXdi52cB+Eh7muXDTRdX6T6MSOGllC
 vliUfQbYoOroQoJ4SmvpCQE2Udgyw0Oo6AXVb5lfMhSwAk7ZhJx/ltGt7m6TTPNkaMlW
 odjxits4167/j5OsJb9dENdSTp9hhoHs6BCnFspT5qO3/6tpK9k3SzsRqLuS0kzOlQPW
 KyIUpO7H8kRjMrhJJOY2lYhmOefI3N50hntnwXeUG4aXhF9obZ06WrClZyLvPQs3cNZF
 ZcPacBbrddA39ZBjFO8HyQW8Zd8Zg9YNxoDREW9B2NSX8pPTonH0uIMQjp25Dapm2kZx
 bCKQ==
X-Gm-Message-State: AOAM530nyogbp1XVovKQ6i7/mRvdiyLUN5FTq4glATn1USRjgiF72N7U
 69x71LfInoKjR2M8oe47Ih+21XZ89V4=
X-Google-Smtp-Source: ABdhPJxBX7XwsKLDR+zfZLSJWx0iRb1nYd9S5ayf7cMFfwfA4ZHg6YxrjESrKrxk/kHjFI4XymxTuA==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr5316083pgb.218.1589583329257; 
 Fri, 15 May 2020 15:55:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id v1sm2283039pjs.36.2020.05.15.15.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 15:55:28 -0700 (PDT)
Subject: Re: [PATCH 05/10] target/arm: Convert VQSHLU, VQSHL 2-reg-shift insns
 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a8cf026-97b1-fb38-d2c0-d9e03e09aa8d@linaro.org>
Date: Fri, 15 May 2020 15:55:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:20 AM, Peter Maydell wrote:
> Convert the VQSHLU and QVSHL 2-reg-shift insns to decodetree.
> These are the last of the simple shift-by-immediate insns.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  27 ++++++++
>  target/arm/translate-neon.inc.c | 108 +++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 110 +-------------------------------
>  3 files changed, 138 insertions(+), 107 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

