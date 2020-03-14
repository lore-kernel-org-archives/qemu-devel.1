Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F1FC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4062074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZhpvyyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4062074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD27R-0000O1-3T
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD26g-0008Hc-IZ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD26f-0001P0-Fj
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:25:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD26f-0001Ms-8v
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:25:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay11so5450653plb.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DKAdSIn18nL2qOH/s8IKICH6EQC4wBlD3mdDnlC9Q04=;
 b=mZhpvyylcr73Vav4cYN2f/qjgxel1kGg0pknAwG3jGJApfLSn+aAtU94qMhfdtMblT
 M5cCy1t9OOcM/Im8ESBnLE5+sp3O5GLn92gu7MYSnwD5YUHQE39oREh/loQXqRyvUYqu
 gcdBE50Jdf852fVsOjHApLjv5S7PAzdaSLoHCHhj+cqZu9hltlS16WxCwjWZ4zYwGvxV
 jrXnwsqHTjNnw9cdEe/vEbYvH7xgVpvTBibEnkm64PpBPAoU9xx94DnjAteKkfx91hIn
 u9QLIG3vw6QC8v1cuXuLcDlEGeamLW3G8Oh2lhCJd6nPvbfYTyeZ+yHooeYE5h4KVJur
 mHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DKAdSIn18nL2qOH/s8IKICH6EQC4wBlD3mdDnlC9Q04=;
 b=RgVLUTl7ppjb3Hnce2M+6VqPVSMEjlEVD718hC+ZzFjd9WgsiTXApJrf2cFx6Dtms0
 tiLcDyD4TE/RjaH4SGqtlazTkvmgrPC2Mb0V4x6SmPcJuXW4E97jZ4UexZUkoGrP7BjY
 ddpQ79p9AZcc+nkwZtp0M5vJe4QGwM8SQ3fTkQKsF8iX9fBlrYPlF7ghDSs5jgSKUyjk
 m1RRHQR8cr1EBGeTfcA2GM8PqfYWLDeQrGlHutiNUT8c3mNiR2nYvHworc07vgA+ck2E
 v7XbSc78UO4zb7JmDIKYX/lPHABo6IOI61C9ula9xmlPCHqrpIJFsP03CJ/139DnHYuJ
 X8Nw==
X-Gm-Message-State: ANhLgQ3giHlAA8QyZeQNM7Dt5sBl8qg9dl3jkW2i4nlPiPSOl7uaGtZk
 FaPVmWlVAq9hjk1pwhtXsB1F9w==
X-Google-Smtp-Source: ADFU+vsiEN9dfdNLanVRHOEZLW2vheqpJRSnVIvRWeKbdC+7UVBf05Nvo5tU0fl/Lz+inJKORjC6tA==
X-Received: by 2002:a17:90a:8d86:: with SMTP id
 d6mr14111422pjo.119.1584174315762; 
 Sat, 14 Mar 2020 01:25:15 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y7sm20510106pfq.159.2020.03.14.01.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:25:15 -0700 (PDT)
Subject: Re: [PATCH v5 24/60] target/riscv: vector single-width averaging add
 and subtract
From: Richard Henderson <richard.henderson@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-25-zhiwei_liu@c-sky.com>
 <834922de-5107-0d00-6d4d-47bd830129a5@linaro.org>
Message-ID: <2db448ea-f17f-e627-055d-fb3cdf6cfddc@linaro.org>
Date: Sat, 14 Mar 2020 01:25:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <834922de-5107-0d00-6d4d-47bd830129a5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 1:14 AM, Richard Henderson wrote:
> I think you should have 4 versions of aadd8, for each of the rounding modes,
> 
>> +RVVCALL(OPIVV2_ENV, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd8)
> 
> then use this, or something like it, to define 4 functions containing main
> loops, which will get the helper above inlined.

Alternately, a set of inlines, where a (constant) vxrm is passed down from above.

> Then use a final outermost wrapper to select one of the 4 functions based on
> env->vxrm.

The outermost wrapper could look like

    switch (env->vxrm) {
    case 0:  somefunc(some, args, 0); break;
    case 1:  somefunc(some, args, 1); break;
    case 2:  somefunc(some, args, 2); break;
    default: somefunc(some, args, 3); break;
    }

so that somefunc (and its subroutines) are expanded with a constant, and we
switch on that constant at the outermost level.


r~

