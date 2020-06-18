Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9228BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A192067D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVq4j1rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A192067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlySg-0002ej-Ix
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlyRk-0001uL-El
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:35:28 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlyRi-0006r8-Kt
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:35:28 -0400
Received: by mail-pf1-x444.google.com with SMTP id x22so3104709pfn.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TSe2y6vq2iDFC/V5hLR+mmaFKnIAn3KvGSjCLSEdV8M=;
 b=sVq4j1rktIcGeAAEeHSHqzFKvKR7pN2XAJ9x3vuf6qTx3Y63aPdZEb4kwk2univoGY
 cOYjmyyPfhRJTYMojCFtjUvL14eWf7rBssp7GQmwpXyaNV3Ze/ejdhsx7AEIn/Ifj95T
 0iCOUcRsf0VD/LchrewQIWrCTYQOt+qq0eWFTHqcgDs/GSKNH7sAMJGhF0SawtldyTQ0
 Xtvg9R/FEqF3eLpY1XXXz2gtediVyd521M41BUHZb+1lAtfTYMGYIdoTzjZaalHziUYh
 MkCq3SUz47HwuJ17yyDNBDMygKWkkRhcaCTzBcS+v6uaTcbueYSed0OVjCKdD7LTdaUE
 FvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TSe2y6vq2iDFC/V5hLR+mmaFKnIAn3KvGSjCLSEdV8M=;
 b=bewLB2MKPhLhdxDu+scvpDWR9Po1PVe9vr4Hrb9AJm8OH7cXQNd73klFQ//BHZxCrx
 Ps0r3/Jb8469oDctNrbXzEmEUhhXtSpe5LvfJrJPK18ExyYEfdY1o74IOVIvgYWXmTgd
 RJgUpB30wrGqbUTQ9/vKYKn91gvvsBv9DJGd5nW0CDogX4eBpaCxYL+bCuW+aTjsS0GE
 ZFOByi4yqLwNYeOTpIzFZ40iYF8t9yDqTMiTyNNYM9cbZ2YWuTmHzKx/1qKBD1xe0r89
 T3UFovi1/F6HwKmW1FpC/H36XXlFjVnh6cMkOgT9eQtAlS3JcVYzpK29phpFcMpHKvhf
 erzA==
X-Gm-Message-State: AOAM530SoyaZ7sFZItv3w0FFn65dAHCM0F5gQ/NE/niqPSjEywx/zP3u
 3a116Lar3sugeoCEWNGFF6ZpOg==
X-Google-Smtp-Source: ABdhPJxA7117Z3VooPhVIL5X7lZZoCVHSxG358jgfiJ1mIV8dKiTgpGXmNOtUlwsKJ0iU6dxKlshBg==
X-Received: by 2002:a62:848f:: with SMTP id k137mr4222458pfd.99.1592501725072; 
 Thu, 18 Jun 2020 10:35:25 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t186sm3572152pfc.39.2020.06.18.10.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 10:35:24 -0700 (PDT)
Subject: Re: [PATCH v7 39/42] target/arm: Enable MTE
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-40-richard.henderson@linaro.org>
 <CAFEAcA83Tb0r11R6EUFPrqLWrXNx4+9Q13q0m8X-jwO49Wgysw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <39a5f769-50f4-d79c-f469-18815551e764@linaro.org>
Date: Thu, 18 Jun 2020 10:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83Tb0r11R6EUFPrqLWrXNx4+9Q13q0m8X-jwO49Wgysw@mail.gmail.com>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 9:39 AM, Peter Maydell wrote:
>>          t = cpu->isar.id_aa64pfr1;
>>          t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
>> +        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
>>          cpu->isar.id_aa64pfr1 = t;
> 
> If we don't actually have tagged memory yet should we really
> set the MTE field to 2 rather than 1 ?

Well, we reduce that later in arm_cpu_realizefn.
But perhaps this patch should be sorted after patch 41.


r~

