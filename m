Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AC5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CC3206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljSt4YTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CC3206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVAJ-0007KH-8y
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joV9R-0006Ht-JZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:55:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joV9P-0004gQ-If
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:55:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id p3so3560197pgh.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wYC5IYJjTNZDnMPFwIwmpQTVqAlfDoQB96PN41pXC3o=;
 b=ljSt4YTYFmDenRtOhyt1jOLd5Msq/g33Yh1MuYOe7IqGDnfjrZh6bNS3kVNFgTslXl
 oedZK6pQsPj2HjFYw9jsuqD8OPcf4FyMlsIXnNcgV7IStTHnEdJPR/wbmDtHZwZxYOGN
 ebHvflNtkV7vTpuH1mvTDvyGSdgKvLGVxAg1q5p+UFgwbqhmmw3LOnVL4bePvW/+cdsV
 vLttuB18a4W1jfXFc6FknngT9U9YM/1i43dtzWveGKSOF90rYDB3kWlCjClpj+wey0gj
 E7Q0z/1vUwrdGEcLKE6f4lkHJ3PNxS0iLWSJqDqQ4mikgPOkEGJASU0U/4FzKsuiSZ+k
 nArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wYC5IYJjTNZDnMPFwIwmpQTVqAlfDoQB96PN41pXC3o=;
 b=iOrdbjti68Cr1XThOHR+MgyZzEUMLLk+7JfpNnvFrryJnHhXw6JzKzW88mPKSqdnvF
 uHob3ygppHBrThUbW14b7OZvdUGyx1nZprklWfFLZ0R41cnGN0jZzvrAR0tNRs2rYY0I
 edUvFHUNcwJlb85ZMZMDxBfV83In0uefsjjd205pvPV483Nzxcw2s21IaSZeukPDkkOf
 753MLoHfrhsN8m+hxjiQDsZi9/+geE7gxqOYy6E0tK5d6v6mxxUxeAzXcr8sRLWbfsBY
 toA9MsdTv/Yw8gdgKvfSuD7WoSto3dHqdRyqaveAOrWewO4zfriEe/9zdRloagkfrTla
 OYIA==
X-Gm-Message-State: AOAM531RR7UiQ9byOjGmYsbfgiJkIyk8xEV7qWlpTS5QiUqzqp9T8W30
 Itxqt54o7z00QvbJte2kqFzJwA==
X-Google-Smtp-Source: ABdhPJzecfHborDcVleOvUCWanRVBOC/B0KyECD8Ij8q6yhndspCwHLvmGc2KtfsdRb0jOj6sWaz5g==
X-Received: by 2002:a63:1e60:: with SMTP id p32mr26285770pgm.172.1593104097711; 
 Thu, 25 Jun 2020 09:54:57 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y7sm8697823pgk.93.2020.06.25.09.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 09:54:57 -0700 (PDT)
Subject: Re: [PATCH v8 38/45] target/arm: Complete TBI clearing for user-only
 for SVE
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-39-richard.henderson@linaro.org>
 <CAFEAcA8xy_Q-6zXexBEHLR=WSYTXVvttL9V4HqiMPmtRm__TEw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e80eb42-655f-9ffa-264a-f72627efdf42@linaro.org>
Date: Thu, 25 Jun 2020 09:54:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8xy_Q-6zXexBEHLR=WSYTXVvttL9V4HqiMPmtRm__TEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 5:52 AM, Peter Maydell wrote:
> On Tue, 23 Jun 2020 at 20:37, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> There are a number of paths by which the TBI is still intact
>> for user-only in the SVE helpers.
>>
>> Because we currently always set TBI for user-only, we do not
>> need to pass down the actual TBI setting from above, and we
>> can remove the top byte in the inner-most primitives, so that
>> none are forgotten.  Moreover, this keeps the "dirty" pointer
>> around at the higher levels, where we need it for any MTE checking.
>>
>> Since the normal case, especially for user-only, goes through
>> RAM, this clearing merely adds two insns per page lookup, which
>> will be completely in the noise.
> 
> Can we have an assert() somewhere suitable that TBI is set?
> That way if we ever do have an SVE-capable linux-user which
> doesn't set TBI for some reason we'll get a useful reminder
> that we need to fix something.

At what level would you like such an assert?
At present we have, in arm_cpu_reset,

      /*
       * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
       * turning on both here will produce smaller code and otherwise
       * make no difference to the user-level emulation.
       */
      env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);


r~

