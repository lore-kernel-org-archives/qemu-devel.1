Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B7C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 19:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D079C2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 19:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+c+14fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D079C2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1y4U-0004ZL-Vm
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 14:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1y3v-000488-Ln
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1y3u-0005wQ-KK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:52:43 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:40743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1y3u-0005uL-DZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 14:52:42 -0500
Received: by mail-pj1-x1041.google.com with SMTP id 12so1327692pjb.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H5IV7B0IbQTgV19nWCo0n2HMQNpzH7M7m1oTyDs0liM=;
 b=Y+c+14fm5bc3m1Zenswn/gWhd0VOcUosfOXTc8EqsX+firT2+tyG9urPNxWP62DsqU
 qpeeKts4yqz4Kiu8D5C7bBcnHB7CVOhWJygYIFXIKsXZG7bq4o5Z0n0zh9m1TTDN8nuq
 YPt4Pf2B4rU8kRYWhMIaNGsaPiCVU/p61wEaSCIpP641pFxQpWkMXMrBZrhwlSq3rD95
 XW90H6f9PW2MqVmk2UdIAWALaPmIK2WLcg2e+wkh9a4AanfK0qq28fQwW1KiRJpF70Ol
 p+wB0Jcq9XPY9Eau0DD0eUl5C2W3u3djF5NVTarhgkcSmLyL28AbkdsIbFrFKcryOZGB
 fHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H5IV7B0IbQTgV19nWCo0n2HMQNpzH7M7m1oTyDs0liM=;
 b=ZqFw/Xwi9CcJUxjV223ZNQMzYZRzJu7mZzKoXuiGcFqe6IhruwoYx76uQaQj9w41Gs
 RTWNrMmjKx1Xfu56o+jpg8Mee5u5iYyF66dPxAlu0ELVmxe2Y0BKEfRL2/0Wm2jCLXK0
 SGH2/n8vHCuXs6JJ17ZcB/FfAGF8pkrwTvLRrHWnu8m97G+BH0dxiC8WUeoOSMHOBv12
 BhNy4F8ddAMKiWnsThPFWO2KMJCyFy8BWhJfUU3c805ot6SHJRz2a6ERFKb4QoZx57+7
 rvB75A+0FLCi29qMJBNY7cwTtkgdTYX/j1U/1EM6tzacP0kuCs+EzWtnI9frMv5il1+0
 BVzQ==
X-Gm-Message-State: APjAAAUsMdf4suB0Kbf7ejSjlfgfbbPqF+JhAko1uiGV61ywBUaZHFiF
 /6+Y6K7ZxVp+rlfgz39FZ5KQ4g==
X-Google-Smtp-Source: APXvYqx72i/G1QKTwNls/XeTXOKwHjPrXCSJZALpLiYWmUiqpotw/0s0I6RCV0cE9p/cEwXHuG40pA==
X-Received: by 2002:a17:90b:243:: with SMTP id fz3mr791775pjb.29.1581537161199; 
 Wed, 12 Feb 2020 11:52:41 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t11sm1334743pgi.15.2020.02.12.11.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 11:52:40 -0800 (PST)
Subject: Re: [PATCH 2/2] target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200212025145.24300-1-richard.henderson@linaro.org>
 <20200212025145.24300-3-richard.henderson@linaro.org>
 <87h7zwxenx.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <125be513-4309-a44f-0551-8864cccb25b6@linaro.org>
Date: Wed, 12 Feb 2020 11:52:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87h7zwxenx.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, tsimpson@quicinc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 2:50 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Now that we can pass 7 parameters, do not encode register
>> operands within simd_data.
> 
> What defines the upper limit? Is it the ABI of the backend or just the
> efficiency of implementing the prologue for the call?

The current upper limit is from the lifetime tracking data.  Which gives us 14
arguments within the bits of the uint16_t.  Which gives us 7 uint64_t arguments
on a 32-bit host.


r~

