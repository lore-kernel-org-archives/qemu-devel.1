Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01EDC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4152074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGg3e+mA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4152074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD070-0001Is-OH
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD05y-0000lS-DB
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD05x-0006ZZ-GM
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:16:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD05x-0006VD-9U
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:16:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id t3so5329298plz.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RXd6q5N66ycEsK6jlABtLluIjfbC4JRFNNdfj/T1fSY=;
 b=IGg3e+mAtAFxlbephNBT2MscvTqfP01FFfSD7SIV5EqTfl9KfaN/12U1ULbv4oSHKf
 afrCcETPNzUu7U/W6WmhK93Z5AH6tU/ZH2+klRud7Kv3BYHcvtUwFcm402TSWBvFB4HV
 B7l3kyICpEIH5yO3U0Ma5Rl09OFwe56foz330xQDpp6DzKeeR3RLa7fEwZhFrMIezkbU
 AgeFCdUUv3alAH+dQvTv4f+U+c0ru45LhvXExUW1djn2kudEQQeWrsdRoXKKRHAnIMzA
 eFOj+ugc4HN0LCyafpljMlFBYorQfyfLvTg9fCNsEKXNBdYPVZPm3kJKR9W2OjFKo08W
 8U2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RXd6q5N66ycEsK6jlABtLluIjfbC4JRFNNdfj/T1fSY=;
 b=DEC++OR6NNBGDG4VQkOxptm+IjczRVKjdrllDfY/t5wNRdBCP1w17IhkotNdDSkviP
 uhHBXKkgNAlGVkAKz5KIh2fA9jWt0TjtxBp3aq0NHl6GCkj8JfiYT1rjdQAKJ5TStWs/
 uocZ7Bc4J5boX3gX+6KHuILovUsEqrHzAGBPMmTV1GmbswcZsMFto6u57wi/qyx+48Tj
 Tz+vresZ/AzICM/N1JdphYN5+Ngh1jlXMIP77Nder7GQdkaIB88gKZgKjPToU4QWZC9F
 o61nUlri/Ey/Fvzw87Ych+1wZ/TkyNYuENGCheqgmNg1XLhXOlMq8eatCx3Rcqta84uP
 5/HA==
X-Gm-Message-State: ANhLgQ2QFUGUtl1vBz00xxeWCRFM6heEsGOUCWtFZm+s8TBUHNvcGB7M
 r8/ZqUpdCKT5vBllja1K5ka7Jg==
X-Google-Smtp-Source: ADFU+vtoPlBDdivDklbnEIkxB3cOVsg0uL9OCnrOrhRy7Szn7KKlEu/GgoPlxi4o5LyJ/VdP4JEPeA==
X-Received: by 2002:a17:902:864c:: with SMTP id
 y12mr16556248plt.8.1584166579570; 
 Fri, 13 Mar 2020 23:16:19 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x197sm11301927pfc.99.2020.03.13.23.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 23:16:18 -0700 (PDT)
Subject: Re: [PATCH v5 11/60] target/riscv: vector integer add-with-carry /
 subtract-with-borrow instructions
From: Richard Henderson <richard.henderson@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-12-zhiwei_liu@c-sky.com>
 <77fcc875-ba5e-ea18-1228-6a1e7989491b@linaro.org>
Message-ID: <6de2ad7d-c83a-a3a0-622c-51aaf28c36a7@linaro.org>
Date: Fri, 13 Mar 2020 23:16:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <77fcc875-ba5e-ea18-1228-6a1e7989491b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

On 3/13/20 10:58 PM, Richard Henderson wrote:
>     C ? N + M <= N : N + M < N

Ho hum.  N + M + 1 <= N.
I'm sure you saw the typo...


r~

