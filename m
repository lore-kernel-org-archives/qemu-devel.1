Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825EC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2179320644
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+GS3vga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2179320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS65v-0006i1-8K
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS655-0005y2-Cq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jS654-0005rH-2D
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:41:55 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jS653-0005q6-GS
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:41:53 -0400
Received: by mail-pg1-x541.google.com with SMTP id g6so5247296pgs.9
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GDHYGyuzm9dNqhkX6g8V5LQmZj92nILH1EXV+q3Ivjo=;
 b=m+GS3vgaYzy0fzhoQvNiF4GUiQDpoONtR2afQs0nVoagIAaHGtMS2LmVulZDrINrBO
 ozBMXIjiNXQDBcODPJKA/Xv4EbNlv85ELCw6WKyG3T/07/WY6nWWT5RvqyaIleGoEmCh
 ImUjDI4iFTFVqQJtMZcWNx7DpClg7It/9ilhZxVKlXuFPzDuf7KooF1l9J18srUt0nx+
 X9cBkfQ8FJY4nx73IApczkukOiUZRUYkg25yrwpPP6qPca/W8lsIF6tKmm5TSgtODnZB
 r9ikLfF6KGx4Y8+clySx+owoOcE8JssexhEFw4gjExBbR+Gen4t2ZNaQKFQIJMwDSc2G
 tEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GDHYGyuzm9dNqhkX6g8V5LQmZj92nILH1EXV+q3Ivjo=;
 b=aqm8Olu2KuOQPTzoTkCJesF+5mzbrxQzIxcv50WRQzXWNuw+n5qLYhrSlBHpMCnQ42
 PwyidIFsHdHtLKjzKdl2CEFDh3xUvqC+gLcSTV/bRh0+f6c4iYZZYaXrzFq28GboPOmq
 JzABKmy6CXhQ/ada95wXxpNKGK+ZQ1GOXB3MdjnavXqJODYjqwIbxU41W2fE+7Av/O1T
 guu/b+iF4ydXz33fRU+dAr/FucdlBdiQtUElF1nk38QRVtaGJC+2V3EGRPXNgXSf18kL
 +57ILjC14CxJsVPFXpRAuuyemefenIAu4wfTSZVD7oMpoUP2ZAuOTew+FB/oKcb3Fqpj
 4www==
X-Gm-Message-State: AGi0PuYHnsornKmXub6/BHoIT7x8zSQml3vhjns+UCEru37PQjS8523k
 FUR6z0d++oJpBpx7SKlNKOL7Xw==
X-Google-Smtp-Source: APiQypIZ1CC0YLFz32nqMVjyU3fdXiN7rdCMTt5HOpmyg1ypwicJpQcNWiP7+bRvbEbV0/4JGJvbQg==
X-Received: by 2002:a63:d00e:: with SMTP id z14mr11189793pgf.125.1587764512003; 
 Fri, 24 Apr 2020 14:41:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z13sm5327502pjz.42.2020.04.24.14.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2020 14:41:51 -0700 (PDT)
Subject: Re: [PATCH RFC 1/3] target/arm: Implement SVE2 AESMC, AESIMC
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200423223739.31715-1-steplong@quicinc.com>
 <20200423223739.31715-2-steplong@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5681d692-6c1c-fa54-1f10-1b96742f9a7e@linaro.org>
Date: Fri, 24 Apr 2020 14:41:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423223739.31715-2-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 3:37 PM, Stephen Long wrote:
> +#define DO_CRYPTO_AESMC(NAME, DECRYPT)                          \
> +void HELPER(NAME)(void *vd, void *vn, uint32_t desc)            \
> +{                                                               \
> +    intptr_t i, opr_sz = simd_oprsz(desc);                      \
> +    void *d = vd, *n = vn;                                      \
> +    for (i = 0; i < opr_sz; i += 16) {                          \
> +        HELPER(crypto_aesmc)(vd + i, vn + i, DECRYPT);          \
> +    }
> +}

Better, IMO, is to add a "desc" parameter to crypto_aesmc and move the loop
there.  Then all variants of this operation use the exact same helper.  The
separate decrypt parameter would become simd_data().

Same for the other two patches in this series.


r~

