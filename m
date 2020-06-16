Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21310C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE175207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9seZ234"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE175207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlGpa-0002G8-3g
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlGoG-0001Gp-MJ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:59:48 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlGoB-0001dE-PF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 14:59:48 -0400
Received: by mail-pj1-x1041.google.com with SMTP id i12so1840367pju.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o7ps3wGvKL1kZ4fCeed8jixQ/nEFktW3NRHBgvRpEDQ=;
 b=p9seZ234ejiKxnsCIyQW2QzMxHYnAnyl7BfK9fxdLOD4bw2H+60fFIFNfNjG08yIto
 X4Uwc5RAjUNiuaQGZwltT9SZ7oUdrECdLIy5JUTTA9OgedATppxylAUv+oFcuLZit/jP
 HPiT74P9fk8vLeaZU1W/mmxTTtj3C0FpUxqVHm6+A+cb+MvMKp+7tvBivguLOZwtmPAj
 K1zIYEHw8/JWfCOnUbzmnEDIR0WK2YKUv625na8T+y9CYAIrmkIK4Nktp3lsD4yxW1wG
 RY5yG8mzsvEgu59QPF4lS02HQXQ9PvyzG6IhttvBxPoBzcdfEQvIEQG5H3nTDUeoa9SJ
 3PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o7ps3wGvKL1kZ4fCeed8jixQ/nEFktW3NRHBgvRpEDQ=;
 b=tp3TmQEtu+Wytvvqsf9fjTe8BFwMNiNVEVBGKPUZMV47SN1CB7mPND5etqKMoGpdM2
 qzMoae1doJ6IezDKqCXhuZhxe6MuKvKmwrqzO6m78LoB6bmkSBu5B3yah6lUIebJW0lH
 5NxQo5df7QHK2UiEGzJvWTfJabV0956t+Z08NlprxBDq+RV0T/gxckoGUW/woIVNXgSZ
 5v+HjHEDlNowyNqMdFB1vnzoFF42xBhUK3hkBAGh3DcMDG4DZk6FQxTbQLDnrYuwQdlg
 cNxeH2xNVG07QufaYgv0fY+3MS/xYDsjgkkAQp8wJEmnxWJp6Qak0gLeCVewEYVXMpyg
 TyQA==
X-Gm-Message-State: AOAM533gJI/5cYBWyX5OXcRLilgoF9JfVQvFa1JrxAYmcYg9jPao5sWG
 wevtZ7EyeC6iIT7fgGgVmVVk0Q==
X-Google-Smtp-Source: ABdhPJzrYf4c1XH+ZFtQaSM+VdpXL7KBhUBRNKQqqsZ1PfZkpSmtM1XdM2PJMRaYQMuxu3rXON0JnA==
X-Received: by 2002:a17:90a:6886:: with SMTP id
 a6mr4721617pjd.170.1592333982246; 
 Tue, 16 Jun 2020 11:59:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m7sm18295967pfb.1.2020.06.16.11.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 11:59:41 -0700 (PDT)
Subject: Re: [PATCH RFC 3/3] target/arm: Implement SVE2 FCVTXNT
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200428174332.17162-1-steplong@quicinc.com>
 <20200428174332.17162-4-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1760d76c-068c-4842-f5dc-5f4b3f3719cd@linaro.org>
Date: Tue, 16 Jun 2020 11:59:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200428174332.17162-4-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 10:43 AM, Stephen Long wrote:
> +void HELPER(sve2_fcvtxnt)(void *vd, void *vn, void *vg,
> +                          void *status, uint32_t desc)
> +{
> +    set_float_rounding_mode(float_round_to_odd, status);
> +    HELPER(sve2_fcvtnt_ds)(vd, vn, vg, status, desc);
> +}

This is incorrect, as it leaves the rounding mode set to odd.

I've adjusted trans_FCVTXNT to the existing do_frint_mode, which handles
switching to and back from a fixed rounding mode.


r~

