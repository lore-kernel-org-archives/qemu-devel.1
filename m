Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985EDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 02:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F67206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 02:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="am6FmJiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F67206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfZxz-0004PH-Lb
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 22:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfZxR-0003w5-QF
 for qemu-devel@nongnu.org; Sun, 31 May 2020 22:13:45 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfZxQ-000271-RX
 for qemu-devel@nongnu.org; Sun, 31 May 2020 22:13:45 -0400
Received: by mail-pl1-x643.google.com with SMTP id q16so3619181plr.2
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V9ol7DQEmw8WnwjUmnbGsnZhFwXrV0Iktmr7RpQ1nN0=;
 b=am6FmJiFoji6YWvQ9ndBQbqZs9CC/WOzqFDseyfyAmt19vGikEbpiNTLHvOUAP3zp0
 DRXyU6uoCjtZt8oFtM7yaoPbwPoQM+ofeWWvIG1qyb+Ky8gd16A5+zc+gXSkNBog9YC+
 /LaUEN754aq15twqDbS0/s41AeR32ynjE7enSQRi1aKewU99A2ZVA50q70swftbnRb6J
 OTLuKZXM861kIcq9BYKOZhrBVxPofWtXKEJPtayErRqmFFIA6NXZ3xkVoqQ8C310K6/W
 k23j7w5k7BlRAMuVJol/xIuEk1bjJ2R+e337g2XM4//915GS5RhEjsfNTHAkpg7TubKC
 WXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V9ol7DQEmw8WnwjUmnbGsnZhFwXrV0Iktmr7RpQ1nN0=;
 b=I3j49jI5EuOYEXk6M6SVu6Qi0TZWuXkFLSg7+bQIaQ56F9owc3m8IUX+bqph/rJj/w
 W+4pkGzPi7u7WK6HMnm4/XXf7BMtp+I+IOeQjEwM6MwECxImzMGGIeXSZJjRDFJoeG79
 jRnplwK1fsipubxZWjELWDfJEDjDHVJUnXrnxDplBO1Sf4L56+XL34Yx5XeIJGbcthST
 weE3boS037c1UHUds8p1oChh8qoJ+mDAx1SFY0X+S99y0g/haar3fKVSfiPCN2xaXFsu
 JilhOoYmnjPSnAXsqGLRXyiGWXvBPt4Q/6YAgdo/KlkX+OBvIMZHlmYPOaE3UlgPaBlx
 navQ==
X-Gm-Message-State: AOAM531PYrOGAsQWo8MAfzUXNKya5O1VlwgLW90c8nrAPqWU3aOa+Mtq
 +XwhzT9OOsF9o3vZoXu83Fg7mA==
X-Google-Smtp-Source: ABdhPJzvjmcyHTTTLKU53T9eTWwSGKJgfib4uytfdgc/ZLsHFXQZ2Z4fShYOkn+WEHJuIe7vKLH2fA==
X-Received: by 2002:a17:90b:1104:: with SMTP id
 gi4mr19143044pjb.115.1590977622704; 
 Sun, 31 May 2020 19:13:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h3sm5908390pjk.10.2020.05.31.19.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 19:13:42 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] rules.mak: Add base-arch() rule
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200522163759.11480-1-philmd@redhat.com>
 <20200522163759.11480-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e83f0de-871b-9fc7-6489-d4a94ff0066c@linaro.org>
Date: Sun, 31 May 2020 19:13:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522163759.11480-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 9:37 AM, Philippe Mathieu-Daudé wrote:
> +		      $(if $(call startwith,risc,$1),risc,\

Should be "riscv" not "risc".  Especially the substitution.

> +		        $(if $(call startwith,aarch64,$1),arm,\
> +		          $(if $(call startwith,x86_64,$1),i386,\

We don't have an exact equality function?


r~

