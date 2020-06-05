Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4447C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E59206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzaKLTax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E59206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKHP-0004fb-Pa
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 17:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhKG4-0002pi-6O
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:52:12 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhKG3-0003fx-Bl
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:52:11 -0400
Received: by mail-pl1-x642.google.com with SMTP id n2so4201472pld.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hw0sxcsgGJAm4C7/HVjWZij3aE9QrBGSh2yyjifznPA=;
 b=yzaKLTaxAFGZBSet8gYR6KCoQjnKfjDmAatcNflWqGOz05CdhFM3uduXgql1abeNMR
 v/Zo6W2dInLOzzGh39HOBBff6YbAmddqm6ZRPCrdVIOIc2lVe9GLmxfSPUqHLyTa1uko
 aUtykRPIT99D6rgSfBjk7TxrYrtHHgCX0FImFEL0TkDnjFGL+JABTkjZ+Q2JsiHFrOZE
 2NAvhqmegebBEVeKdbVf5DMCJP217ary3BTVht+PF/amf9kndGERLNO/PWp8luK0Rd1L
 lydXBK19+Vjz01Oa2ie5H/j3BS0maShqFs50jYr/+7qNCNBlI8FNpajT3abAtVlNNc+t
 Va1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hw0sxcsgGJAm4C7/HVjWZij3aE9QrBGSh2yyjifznPA=;
 b=rv1WXZEl6srgnBlWZJYmsawNs7ghQR3uHjY6BO7OsXbpRy3speiAko22N+MWqN6AL0
 4WCTaPUDGfVL6YOrPNt5N1L+8epsCnlC9NaVo/xo9rgt50s4ZAIBvWMXKXKmymLxDZGz
 FYjvBKqV3E/kqWt/YZB86ZwZffictMJHzYXpAs98vAcwqhw7+Tj2dnGzg6AytxL2ppaa
 r8VE0jq9eaSUd3ZjS+xRNtnvUZzEvDQM1z1b6hvxYj84zfulFXSvqpLSZolYgSLq9UNW
 Cn4maBZz0cVNQKuYxSimIiDrVaHtcz+HVJ5i9q1p5HQI3f2oOG17e8HlU9y5/Yi07U9w
 H4pw==
X-Gm-Message-State: AOAM531GFWxoDI/cx38+wmNvDDO1eBjiVM5KbfY/5WfmWHF7gKMYBr+0
 unYlAzG177Psls2kBjiQVemXxA==
X-Google-Smtp-Source: ABdhPJxr+cxe+S+lJg9yUaKQFlhkNN0wdvCxrFEZu3NW0NUsSAxVlIKkd6J8kcDEBD0X3YE3UOiJSA==
X-Received: by 2002:a17:90b:3005:: with SMTP id
 hg5mr5073677pjb.215.1591393930037; 
 Fri, 05 Jun 2020 14:52:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i191sm500862pfe.99.2020.06.05.14.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 14:52:09 -0700 (PDT)
Subject: Re: [PATCH v7 05/11] rules.mak: Add base-arch() rule
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200605175821.20926-1-philmd@redhat.com>
 <20200605175821.20926-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aaf04dd1-507d-d7d9-80cc-90002762677e@linaro.org>
Date: Fri, 5 Jun 2020 14:52:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605175821.20926-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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

On 6/5/20 10:58 AM, Philippe Mathieu-Daudé wrote:
> Add a rule to return the base architecture for a QEMU target.
> 
> The current list of TARGET_BASE_ARCH is:
> 
>   $ git grep  TARGET_BASE_ARCH configure
>   configure:7785:TARGET_BASE_ARCH=""
>   configure:7795:    TARGET_BASE_ARCH=i386
>   configure:7813:    TARGET_BASE_ARCH=arm
>   configure:7846:    TARGET_BASE_ARCH=mips
>   configure:7854:    TARGET_BASE_ARCH=mips
>   configure:7864:    TARGET_BASE_ARCH=openrisc
>   configure:7871:    TARGET_BASE_ARCH=ppc
>   configure:7879:    TARGET_BASE_ARCH=ppc
>   configure:7887:    TARGET_BASE_ARCH=ppc
>   configure:7894:    TARGET_BASE_ARCH=riscv
>   configure:7900:    TARGET_BASE_ARCH=riscv
>   configure:7920:    TARGET_BASE_ARCH=sparc
>   configure:7925:    TARGET_BASE_ARCH=sparc
> 
> The rule can be tested calling 'print-base-arch-$TARGET':
> 
>   $ make \
>       print-base-arch-openrisc \
>       print-base-arch-aarch64_be \
>       print-base-arch-x86_64 \
>       print-base-arch-mips64el \
>       print-base-arch-ppc64 \
>       print-base-arch-riscv64
>   openrisc=openrisc
>   aarch64_be=arm
>   x86_64=i386
>   mips64el=mips
>   ppc64=ppc
>   riscv64=riscv
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  rules.mak | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


