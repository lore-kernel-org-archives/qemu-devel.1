Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D347DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A03F20773
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JImYE0b/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A03F20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVLD-0002Jb-S0
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joVH1-0004wa-4O
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:02:51 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joVGz-0000SO-52
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:02:50 -0400
Received: by mail-pj1-x1042.google.com with SMTP id i4so3529066pjd.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3K3jGMzF0K32dMSMc4Kpk989o87ObLTOHIDmhk3ktSk=;
 b=JImYE0b/jn5XFAyjwvR4Ws6RS+GDA523ktI60arGEj686eYIraA87ZJFirVbfzlzqX
 EDl7LQSq2axZfkeGsu9X2a6gxUBkrvNmK5Ix77c9MUwux8e8Q+WV5lish1kHUbTGOULz
 SWijR4dYidl/Th9p9k4hfik1F4QwaRhwKePwHGjWxcmOft+EJuuoNqILvQL+XyeA0b1O
 jcZVeE/HOAFhWO4SoSi/5g3uIVKq8iCsAeDBlsgrHdDLsphI8ZT4tvQkNnEr3OFVbcaD
 200uoXxGwZIf7qYOa4qqmBX7qg/eOifm27xwGy46ngxswuKIOtm2gTGXZ3K1JwK43kwR
 kdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3K3jGMzF0K32dMSMc4Kpk989o87ObLTOHIDmhk3ktSk=;
 b=esZD/DA4IXOoNp3gnVchx7yIdkNFp/RLYisgkeYWFd7+QMV9B06YCl9abeE2sj+Ddq
 9WT/ZRTxL+s912J/8fJdkEDJ/5al6m9PPEec1mhfwYRG6MIufgGP+gZ8fVH6pd9q+HwY
 dlCwNNKrvziOna3x8LlTn29PQ1xlFefNhbsmdrh0g00Pw+6D/u+Db72/af+x3CuoKIEn
 IbngsV/nS2ronNqVQEcbUEnESrkUljkgt4dheWwHiYjT6ummstflKNc+npN4CnOkj6J9
 K0hVwZ9cKleI3pUlkolrRAQXIEX4aREy2GuDJmBvmEvbO1E1K8oazgAQpC1BObGhL0xH
 eUQg==
X-Gm-Message-State: AOAM532yiFsEqWPrtHVxeNIabeCQu8seZbnge159zF0xpwHEaJ4vIlSe
 RzcDksH5PPLZJscE29BoSthN3w==
X-Google-Smtp-Source: ABdhPJwNHB2JX1YaHU8BhLuRy+9i5dkiXeG04hKhlqk+JOzCgiuwMhG531NgK01jUqDXl07HqiDbjg==
X-Received: by 2002:a17:902:9346:: with SMTP id
 g6mr33016935plp.19.1593104567550; 
 Thu, 25 Jun 2020 10:02:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b13sm2131641pjl.7.2020.06.25.10.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 10:02:46 -0700 (PDT)
Subject: Re: [PATCH v8 44/45] target/arm: Add allocation tag storage for
 system mode
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-45-richard.henderson@linaro.org>
 <CAFEAcA_svDHEDP5g3aaEL6_b-8hy0AB8oRBWj=y6G1K_r6E9nQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f15d6bf6-03ef-70fe-2f40-0665d49b0851@linaro.org>
Date: Thu, 25 Jun 2020 10:02:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_svDHEDP5g3aaEL6_b-8hy0AB8oRBWj=y6G1K_r6E9nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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

On 6/25/20 6:03 AM, Peter Maydell wrote:
> On Tue, 23 Jun 2020 at 20:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Look up the physical address for the given virtual address,
>> convert that to a tag physical address, and finally return
>> the host address that backs it.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/mte_helper.c | 126 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 126 insertions(+)
>>
> 
>> +    /* If not normal memory, there is no tag storage: access unchecked. */
>> +    if (unlikely(flags & TLB_MMIO)) {
> 
> Comment says we're checking a memory attribute, but the code
> is checking for TLB_MMIO, which isn't the same thing.

Comment is not trying to allude to Normal vs Device, but "ram" vs "mmio" in the
qemu sense.


r~

