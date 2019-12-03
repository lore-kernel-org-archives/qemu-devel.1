Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D4CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9895206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 15:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5BgjaTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9895206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icAF9-0003UU-3i
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 10:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ic9op-0002P4-6W
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ic9oi-000162-5Z
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:10:23 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ic9oC-0007cR-Np
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 10:10:20 -0500
Received: by mail-pl1-x641.google.com with SMTP id ay6so1820561plb.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dwqjuWSNcNr2c2ServoaUGYVWGdUe1z+kLXm78sBdfk=;
 b=c5BgjaTasi0oSrcjSWP7J9FOVQ0GIuVXSDMcnNXLXMCTXGBk7oqgN1fiZ+LKDvepsR
 xG42xzqD4fdhMxLS9tGabMJ8+t48+0hhao7GVhH22ocU1YiKDZJTmlrak+LiL2JplFmF
 hyAEsJMq5XvCzBn0OfmA3+e7cu2y7Llcu9Ojffb4ktxFedt5KlFVsAjbeZTLSZnNKXJv
 6unAuE/PYgSnaqm20q0hj1ap+PwpiCnw93laBN8Zr0gGQINs5/h0YnZioP+NvZdqSUoD
 YwznEaXQLGL7lDMkJH+m9OVIdDWavWkyx4AbHVFg1+9wYSu4ZMkKHqFIjVC8jqVfVBv8
 TV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dwqjuWSNcNr2c2ServoaUGYVWGdUe1z+kLXm78sBdfk=;
 b=DMh+bn8dSNLQacBl9wFThmrDjzuqOtr5rfsB3F+076Kf+aqHIlUvoSgsr7TFJcvgdC
 vt6opdt150e5/gTTRNeaaZu05n1pPXTLwj4FRV0fyWT8/i5/gfeC7UFF41K6GePU1PPO
 M4Yx2eOQtZvmEISq8LxHFPkAy061NIlSp43cIvw9lLVn1onl8BqDuB0yA7zDiAZ19fOp
 ViBnlB7Vd7yjqUzY9XwgPz+sDOAIoojAZZLOfy5hgm3wyNlrb1lXzRD9zrfSymP2gQoY
 WU/V87pmAR7GiUaonOep3USNbB7cZhlUABhvicyuccBeKJ3t997Q9cxRQFBeFXTz7bXm
 OFEA==
X-Gm-Message-State: APjAAAWHFn0GklihGXgW/5yynhiRsSoO1jKSax25kHYKbjlx6P7sLyAe
 tIqcDeX2V6TgWVIWOBf0hzezGQ==
X-Google-Smtp-Source: APXvYqwE9al6I//QLmdV7vIDw7dWoZmsH8w8QgfFs5T4V3Gdr0Jp/5VTsRmdOX+jg+XVNBH4tzL+Cw==
X-Received: by 2002:a17:90a:5d17:: with SMTP id
 s23mr5683766pji.55.1575385784330; 
 Tue, 03 Dec 2019 07:09:44 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id ce22sm3291383pjb.17.2019.12.03.07.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 07:09:43 -0800 (PST)
Subject: Re: [PATCH v5 02/22] target/arm: Add regime_has_2_ranges
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-3-richard.henderson@linaro.org>
 <CAFEAcA_Ob3_fGNo3n9hgB6oa-y9abSbtN7Y1u3jpY9uaXNwbSQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2687022d-9165-1059-233d-7b42f4f733ef@linaro.org>
Date: Tue, 3 Dec 2019 07:09:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Ob3_fGNo3n9hgB6oa-y9abSbtN7Y1u3jpY9uaXNwbSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 11:01 AM, Peter Maydell wrote:
>> +/* Return true if this address translation regime has two ranges.  */
>> +static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
>> +{
>> +    switch (mmu_idx) {
>> +    case ARMMMUIdx_S12NSE0:
>> +    case ARMMMUIdx_S12NSE1:
>> +    case ARMMMUIdx_S1NSE0:
>> +    case ARMMMUIdx_S1NSE1:
>> +        return true;
> 
> Don't S1SE0 and S1SE1 also need to be here?

Whoops, yes.  I'll need to fix that in the VHE patch set too.


r~

