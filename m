Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9909EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E05020842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 20:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NA99CEQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E05020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k33iQ-00084q-Eg
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 16:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k33hf-0007ZI-4p
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:38:31 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k33hc-0006xI-VX
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 16:38:30 -0400
Received: by mail-pl1-x644.google.com with SMTP id q17so23948056pls.9
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9FAJakEgbKjpmXyutDshmIZF2utxHX29IOuXxNo/7Xk=;
 b=NA99CEQKmM5BMsykOgt5jcf/klVDVBqRy3T8iewI49SMTJAlREPxnaZa3JYJRETDOt
 wu+kuk9squokYJhGKy6uE/S8OpdVhbE+MPosecGGcm+hj2leBiUVMO/nlW0eP9dknbQb
 0bvSSmxKTz4+vlRLBAiCfKUidXcioL6Q376pxwIJLe824Q4+SqfhKxQNRZ+aj7EZCarH
 nJqK1ZfUl0zaFFIatCSQcVzmcPmgNnHwoq5Gzn/I/zNyi2fCBURa4BFzQonhTNtSiPA7
 iHTfvUvpbTsxY0xMvJUt5Jc+Ifa8EokMMazQaBaOHnIwmWZixgaWXpGPmQjCAFtrmApn
 nznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9FAJakEgbKjpmXyutDshmIZF2utxHX29IOuXxNo/7Xk=;
 b=W4GuDbk518kzNzv4GLRSimlcYuuIMQ6qXIgCxFJ/wwUnm3qVUtG+mxys75uba3imJb
 9R0SlRuP8x02wT37C5y6CmgNCzrNrCv1zL/UgtqkgZbEJdh8SAwOlQpqgM8rOndVvYoJ
 AV6qmcA+uzK5zN3IfPtvwL+p3iLolwzwiGb0RAw1qCsBwrFI1csih/yGTXOayKPZQPKX
 d8uDQCiOgcHG34sQ4jWWM4MllH/Ml1gGpixDGjZQNBF0sG3YfzpVpA7CPqM2GG8vMa4C
 WVjOyMQ9UqyLTmvN5nzTXu4qCenJJbVJlFM315lhbTjNwcPuDDl9y9njVQ+b61rhz1Aw
 pVbQ==
X-Gm-Message-State: AOAM533AHVYTzJ0Dq2EMCVnsQhpEoPYjshr+C5YGs2uy19ruGU60UhpW
 fQcz1o6kbQDxzmd4shHkjiYr+cJ8hW0=
X-Google-Smtp-Source: ABdhPJyqGzAJ4B1RZ1KDM1lLqzeb5neJ3wWCv9Kz4/Gk5FKOXSP7LcpeGRQyPsYYg/226bU6xt3F9A==
X-Received: by 2002:a17:90b:1116:: with SMTP id
 gi22mr6365860pjb.209.1596573507165; 
 Tue, 04 Aug 2020 13:38:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b22sm7009474pfb.213.2020.08.04.13.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 13:38:26 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix Rt/Rt2 in ESR_ELx for copro traps from
 AArch32 to 64
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803165409.15099-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b9b926a-0a46-1660-9a85-bae29cd56cf9@linaro.org>
Date: Tue, 4 Aug 2020 13:38:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803165409.15099-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/3/20 9:54 AM, Peter Maydell wrote:
> +    case 14:
> +        switch (mode) {
> +        case ARM_CPU_MODE_USR:
> +        case ARM_CPU_MODE_SYS:
> +            return 14;
> +        case ARM_CPU_MODE_HYP:
> +            return 16;

Hyp uses LR_usr...

> +        case ARM_CPU_MODE_IRQ:
> +            return 18;
> +        case ARM_CPU_MODE_SVC:
> +            return 20;
> +        case ARM_CPU_MODE_ABT:
> +            return 22;
> +        case ARM_CPU_MODE_UND:
> +            return 24;

... making all of these off-by-2.

> +        case ARM_CPU_MODE_FIQ:
> +            return 30;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    case 15:
> +        return 31;

I don't see that R15 is mapped at all.  Is this really reachable?

Otherwise it looks ok.


r~

