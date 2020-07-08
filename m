Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0556C20720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmjUuOHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0556C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtC7W-00017T-4s
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtC6M-0008Ga-0s
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:35:14 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtC6K-0005Vu-8N
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:35:13 -0400
Received: by mail-pg1-x542.google.com with SMTP id z5so21841241pgb.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=3ZQH0alUD3Zp96+g8BoS1WF2d2sdMRo/yKNKwXYcWIA=;
 b=OmjUuOHnQedYv9UYGun+8Tec2K9zBcE4ORhLp4/JPasV1gMXklJlXbCeWmKVnc8OO3
 9c8NhZnbURJ42Sow9Oym2R05HYl4LaDSuOoUT3ijqOixgq12oufhF0adqecMM1Yzs4D2
 u6nkNsF3fOjZi8U1hoMGPoyBkiOtLWmXFchyV8vmwwNgQjyGEQu+W4OGpC2NdUG9U3Fg
 JBs4g8CUwBciThpNJyHNyyt8jym3gr7PPy4JaCM9PwTuUCjSI74aIoZOwZe9J7CW9I+5
 kIZ9hkSu496QckoqL42Iammx+4kGqjqOVPA/zkm8r3uEVSCn2uLXnu6dcZTAinmhfoHV
 cskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ZQH0alUD3Zp96+g8BoS1WF2d2sdMRo/yKNKwXYcWIA=;
 b=czpW9UwmCz0AI4WUJz9h2S7XZk6UR2hFFGpjIQf/jhvevJMfPyT9ycSkLcnei/liwF
 a28XhyOfAUXy2Nuh3Meo/ZrOT05OD7GJpG4RwafTo424phYwMLuct0jeeCuiLY26RIBk
 5RW044ePnfhNssIAS9djVtm6HFxqdIJBgJj31zdEcgIj3xpeh8I2oxbsW9BK0/7v7ydK
 Vb8VYQmUvy1KUSyCdv0fm/4heyIxUe6daAfFymwLJBEOfPA0+OPPs5wlgYVrnrAb8cJb
 7sbosbKIAayHFYy5oshmdvj0leDeVJCtqnOabeIdgbq2Dq+/NyNC5kqlz68qTjmvJ5WP
 ETnQ==
X-Gm-Message-State: AOAM533avy42UVUeqFTK3myaXvG/gk0OSrjDX4jdHz3CB5TWMADtPCLP
 a88UgUT56MjpiC9rNDfdxYe8nQ==
X-Google-Smtp-Source: ABdhPJxC9m+qSIV9Z/0bMZErYJeefg9VnXc4jdVvTBoekQI2S+bn+AsEyabFB/HzIbJk8cqZfJ/l2w==
X-Received: by 2002:aa7:8e0c:: with SMTP id c12mr12657544pfr.38.1594222510075; 
 Wed, 08 Jul 2020 08:35:10 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id a14sm232660pfh.81.2020.07.08.08.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:35:09 -0700 (PDT)
Subject: Re: [PATCH 0/6] target/riscv: NaN-boxing for multiple precison
To: LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <6d2e6876-18a8-b32a-0879-565693b6d446@linaro.org>
 <3c139607-9cac-a28a-c296-b0e147b3b20f@c-sky.com>
 <53a00d93-be8b-6cc2-e091-215c71661453@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d484d59-ceeb-862b-4c44-e57065b914c0@linaro.org>
Date: Wed, 8 Jul 2020 08:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <53a00d93-be8b-6cc2-e091-215c71661453@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 2:45 PM, LIU Zhiwei wrote:
>> On 2020/7/3 1:37, Richard Henderson wrote:
>>> I think it would be better to do all of the nan-boxing work inside of the
>>> helpers, including the return values.
>> Do you mean a helper function just for nan-boxing work?

No, that's not what I mean.

>> I don't think so.
>>
>> The inputs are flushed to canonical NAN only when they are
>> not legal nan-boxed values.
>>
>> The result is nan-boxed before writing  to  destination register.
>>
>> Both of them have some relations to nan-boxing, but they are not the same.

I mean

uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1,
                       uint64_t frs2)
{
    float32 in1 = check_nanbox(frs1);
    float32 in2 = check_nanbox(frs2);
    float32 res = float32_add(in1, in2, &env->fp_status);

    return gen_nanbox(res);
}

I.e., always require nan-boxed inputs and return a nan-boxed output.

>>> If, for RVF && !RVD, we always maintain the invariant that the values are
>>> nanboxed anyway, then we do not even have to check for RVD at runtime.
>> Do you mean if FMV.X.S and FLW are nan-boxed, then we will not get the
>> invalid values？

No, I mean that if !RVD, there is no way to put an unboxed value into the fp
registers because...

>> First, FMV.X.D can transfer any 64 bits value to float register.
>> Second, users may set  invalid values  to float register by GDB.

... FMV.X.D does not exist for !RVD, nor does FLD.

The check_nanbox test will always succeed for !RVD, so we do not need to check
that RVD is set before performing check_nanbox.

Because the check is inexpensive, and because we expect !RVD to be an unusual
configuration, we do not bother to provide a second set of helpers that do not
perform the nan-boxing.


r~

