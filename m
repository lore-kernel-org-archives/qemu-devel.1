Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3253C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CF0208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxNDPMkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CF0208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlyQf-00014Z-R3
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlyPG-000052-Kw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:32:54 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlyPE-0006Lv-Bo
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:32:54 -0400
Received: by mail-pl1-x641.google.com with SMTP id d8so2703057plo.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LQvfrDAxgR85n6U1y26lS2xEzeNm/9ZQpuW6mmxGDSQ=;
 b=gxNDPMkxlCSGXurntK9+xwZYWDfbbHTPFqsOwWuLggZqB/6iLzQ1XdFteOHnsbEJs+
 ITwosdyh2Ke4mRV0KvRRWMNLULsSiT6kV8MTFD9pTYAbtMk8ZjhmwFw4vXJdRY79eKkL
 BweB7umboSwaW5txqW/X8WQefkdbVLH+bxtnqtGZmB++rPXVCnr4byLL/dc/kYapZKNU
 d14LhlCBt8FpSCFCiqM1VBJNcQifkRha8OJqZ5Mpq9726LzQ3ZO0wKSPo2QqwBiEEIHT
 E/uUU/lEXqVF5gSnnzKe3MniYivfmuEtxVR0MhEFMhuk9mqrc4/CDLxgyNt0cN7/fPy+
 L0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LQvfrDAxgR85n6U1y26lS2xEzeNm/9ZQpuW6mmxGDSQ=;
 b=GjRMR3uar2v6W7j23w6Yi2l+mFNIpxVmDx/4M5CNR3v1NvGimB7mg3npCbICuef/PE
 NEeB6SZ/CJEzRieOcRkSF9byWhFV+0BIjlKvJ6KZrcPvpvmvOhVFHIWbH71iJJaFtnW4
 c8k9wv3EuSYc/h9VPzMLQ7d2XTRH2n1MZD6G0MD+thqcoWr4C8HV9MfbbwaQePtYpEFq
 TAzStUmsSvDs5G6cv3ivIk4x8CUXilCYxEXuRS0LzkRujhAcwegaw2HimmHpz273AUfv
 586qiLs2ocdq7/Eg8xWUYXX+1J0w1mL39qw9aeIh4gKypuTWm7TeLXM+J41/dy6ad6pm
 3K1g==
X-Gm-Message-State: AOAM5309820eAjbPcQ8JX7PvDPjKXJAEuFUGhFOWcjUh1HltgoeUnRCx
 nRihI5uB0shl144r4lwzKqgAmA==
X-Google-Smtp-Source: ABdhPJzvChZBKKxneBZj7F/OAH8C3dXpFXvkM1HEBc6HzQZmysi6fCCEk7Sige2FV9DTtOFLlUAHBw==
X-Received: by 2002:a17:902:9683:: with SMTP id
 n3mr4453647plp.311.1592501570800; 
 Thu, 18 Jun 2020 10:32:50 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a8sm672262pga.64.2020.06.18.10.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 10:32:50 -0700 (PDT)
Subject: Re: [PATCH v7 25/42] target/arm: Implement helper_mte_check1
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-26-richard.henderson@linaro.org>
 <CAFEAcA9qwXRG8R+1QCjjx8Cqs3yCaDisWcpECTszZrVjKuJdxg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42738bcf-cce2-9621-59b7-38588e868387@linaro.org>
Date: Thu, 18 Jun 2020 10:32:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qwXRG8R+1QCjjx8Cqs3yCaDisWcpECTszZrVjKuJdxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

On 6/18/20 9:37 AM, Peter Maydell wrote:
>> +/* Return true if tbi bits mean that the access is checked.  */
>> +static inline bool tbi_check(uint32_t desc, int bit55)
>> +{
>> +    return (desc >> (R_MTEDESC_TBI_SHIFT + bit55)) & 1;
>> +}
>> +
>> +/* Return true if tcma bits mean that the access is unchecked.  */
>> +static inline bool tcma_check(uint32_t desc, int bit55, int ptr_tag)
> 
> It's a bit confusing that one of these foo_check()s returns
> "true for checked access" and the other one returns "true
> for unchecked access"...

Yes, but that's true of the hardware bits too.  I tried to reverse them but
then got confused.


r~


