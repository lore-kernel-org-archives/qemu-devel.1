Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B6C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 18:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619AE21655
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 18:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVljEpA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619AE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUDPT-0007OU-Cj
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 14:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUDOe-0006yb-FP
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 14:27:08 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUDOb-0004MF-VV
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 14:27:08 -0400
Received: by mail-pf1-x444.google.com with SMTP id y14so4626601pfp.13
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/0qWPGmudoomYwRR+BRCHC7xAtJc4xD2ZNExFt0WbDs=;
 b=NVljEpA+ONIvKj1GM4591mlVZij3jGSbxzgOrzVKnHQhSd5rYmP1iNLY6bCRNT3VQO
 CwjfGd3cDNgrk+Pm56MmXjoMd4unPGyPa84hBOPrWnKfkkihgl1cAkq+O8Kqfoq8diQ/
 9chSDWUydJw6hly04xo6D/mDYslSzKezAvh0n2hZQIAWoiBBFTBkV6EmTbRUQSvnSmUm
 6rkcvjybcfU9t+jZ7hh8FTDpKDBJlPdVqrhU1kTQSe/Kfa8UYBIJmb3JnnSGEVb9vGi1
 YZrcHlDygy4WnqcyEwkAk189CQ4QIHTTM8B8XZFH8dDh8s/B0EOObe/zHA7VjsDvrFA1
 LFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/0qWPGmudoomYwRR+BRCHC7xAtJc4xD2ZNExFt0WbDs=;
 b=uJAc0UrMGmEKn1mgN71EQahxD02qbP9zvYfUUI3EhkGmPi7FrHsxFRnGpqymqGX1rZ
 tLA2tpKdps0NEzswxquC6Ji1RfJiAOjZbWzHAUeuXxQchkfd4z9I1Z0bPRlyguU2ymcK
 YKXU3Gv5F8j6McUMgBFmiMQ7zRcaN2iVxoJnFBuik4Fh8IXWbSj0a5V+NZbrauqsJami
 PQn1Rpsx8Ep5rx3rWyLozxQk7bL/LS/S6QLXrjm5+v5VjpVwsfBi+DODKpoAnlfXOaJV
 37HukK2GPcUZDWgcipK5faxZ1Rz9AOVTdpecn4ibW9l/5Qzw44atWADB9/SDIfRqqZu3
 77FQ==
X-Gm-Message-State: AOAM5316Un/ait6gq/6nD1YlolwhWjYLB2ty3eUiiTPloNzIePH/FznF
 DXedEBWyHCkm2irlTQVF8fX1Zw==
X-Google-Smtp-Source: ABdhPJxXZhy9ICnDo5kxwDGte7ZSSyA6t11G3Tpuu6QK+sEFA3PSIh9T4gXMENWmSquSc5pHYr6+mQ==
X-Received: by 2002:a63:551:: with SMTP id 78mr8701021pgf.292.1603045623221;
 Sun, 18 Oct 2020 11:27:03 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l82sm10089055pfd.102.2020.10.18.11.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 11:27:02 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] target/arm: Implement an IMPDEF pauth algorithm
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200814213938.369628-1-richard.henderson@linaro.org>
Message-ID: <bcab99e8-f738-4d07-d42a-7dfbe9ac2b49@linaro.org>
Date: Sun, 18 Oct 2020 11:26:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814213938.369628-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, drjones@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

On 8/14/20 2:39 PM, Richard Henderson wrote:
> The architected pauth algorithm is quite slow without
> hardware support, and boot times for kernels that enable
> use of the feature have been significantly impacted.
> 
> Version 1 blurb at
>   https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg02172.html
> which contains larger study of the tradeoffs.
> 
> Version 2 changes:
>   * Use boolean properties, for qmp_query_cpu_model_expansion (drjones).
>   * Move XXH64 implementation to xxhash.h (ajb).
>   * Include a small cleanup to parsing the "sve" property
>     that I noticed along the way.
> 
> Version 3 changes:
>   * Swap order of patches (drjones).
>   * Add properties test case (drjones).
> 
> 
> r~
> 
> Richard Henderson (3):
>   target/arm: Implement an IMPDEF pauth algorithm
>   target/arm: Add cpu properties to control pauth
>   target/arm: Use object_property_add_bool for "sve" property
> 
>  include/qemu/xxhash.h          | 82 ++++++++++++++++++++++++++++++++++
>  target/arm/cpu.h               | 25 +++++++++--
>  target/arm/cpu.c               | 13 ++++++
>  target/arm/cpu64.c             | 64 ++++++++++++++++++--------
>  target/arm/monitor.c           |  1 +
>  target/arm/pauth_helper.c      | 41 ++++++++++++++---
>  tests/qtest/arm-cpu-features.c | 13 ++++++
>  7 files changed, 212 insertions(+), 27 deletions(-)
> 


