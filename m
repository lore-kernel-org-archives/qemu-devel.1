Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD3BC4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02D720759
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoBkB9yJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02D720759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvt3-0002xR-UA
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvrP-0001u2-Mt
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:06:35 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLvrN-0007Dm-0v
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:06:35 -0400
Received: by mail-pj1-x1043.google.com with SMTP id jw11so203097pjb.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Gm0hfYjHC+YoNFn4Qc8b8DDBPaPC/MFe4xUHN2MuYVk=;
 b=WoBkB9yJ97l5zdIAURCPoKBLpjiTOgC62RJuhxhTugYYFTRCZbxZZyvLis+1e5Rv4t
 bx/SkEqAlN77LCpQRG0hLbgGPmGBB43u8gYJv/Zbzv3MTs5cA+YoVc2fDkGOa3R4+7aI
 vu18LOP2A0Q+mZ78HVgBjl8Pb+pRJ84JUqT7cFaBx0yFFB9AhtA0aTZ4hbeUp/ZLmRcT
 J5QML5FcE5hFZvERVo1y2ruckeBj7ZDOO26IeTQGHP8298ObCVdTTPLj+KqYps9/fgjM
 kHYWo6Nw8VoechE+AJe9olRxKxSDyjHPXmKj04gF4AdhZQ28xkCKCJXndny9Lf5SyFtU
 YY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gm0hfYjHC+YoNFn4Qc8b8DDBPaPC/MFe4xUHN2MuYVk=;
 b=kR8QGvccTE7lyBnXw5zfy6Eylmdvj7BHVJRR33xBsRBmM3OWuiIJbIF39iHAcHVy76
 7Yajif1jo/gSTpfecwSENWu4U/phdBccpdByeUhnpLJG35UjP/z3IRAlbnTA6CU0pyMt
 3t3ZSE8h9dPHeJgH7gOpLOwb7CW2fwGcm2651cut2ReccjBr2ooCIyU2BujxmACe7T5k
 BEWKMH/s3jK0NHpFtbE9OR/QXhrx7c/QVzsHK4uqN6cViJKDEEGObSytG+/ijvm+9NxN
 FuvbMKBJYORXhtPUdBZPxy16GP4yO/aQzSRH6HE5DhvP1oVD7FtdjmZ0q3kTvnX7Hitp
 2TRg==
X-Gm-Message-State: AOAM531yqXTdvBA1cLHm0wVVcesrfvBXgEMao+OJYc3c4wFyfLYVymCp
 VfXgAc5GINOQgDkQkvuAY8TYgw==
X-Google-Smtp-Source: ABdhPJwPJrJRC76sHcHVeo1+lNywPDqw3mQIay+5H5pG2HcpUl9PXVFeEIhgRwNW0WhMW2YgybKcDg==
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr572468pjm.12.1601071591144; 
 Fri, 25 Sep 2020 15:06:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id p11sm3536211pfq.130.2020.09.25.15.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 15:06:30 -0700 (PDT)
Subject: Re: [PATCH v1 6/8] s390x/tcg: Implement MULTIPLY SINGLE (MSC, MSGC,
 MSGRKC, MSRKC)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
 <20200922103129.12824-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <371cb429-a7e2-819e-a016-08bd7adff54e@linaro.org>
Date: Fri, 25 Sep 2020 15:06:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 3:31 AM, David Hildenbrand wrote:
> +static uint32_t cc_calc_muls_32(int64_t res)
> +{
> +    /* Arithmetic shift with sign extension so we can compare against -1ull. */
> +    const uint64_t tmp = res >> 31;
> +
> +    if (!res) {
> +        return 0;
> +    } else if (!(!tmp || tmp == -1ull)) {

Comparing signed vs unsigned.  Use -1 without suffix.

> +static uint64_t cc_calc_muls_64(int64_t res_high, uint64_t res_low)
> +{
> +    const uint8_t tmp = res_low >> 63;
> +
> +    if (!res_high && !res_low) {
> +        return 0;
> +    } else if (!(!res_high && !tmp) || !(res_high == -1ull && tmp)) {

This simplifies to res_high + tmp != 0.

Probably better to keep tmp as uint64_t; otherwise we're likely to have an
unnecessary zero-extension from uint8_t to uint64_t.
Or, drop 'tmp' altogether and use

  if (res_high + (res_low >> 63) != 0)

Otherwise, looks good.


r~

