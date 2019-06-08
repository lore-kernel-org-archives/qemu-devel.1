Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39C2C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC282166E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3ezc+yY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC282166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhD2-0008SP-GU
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh1A-0006X7-G3
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh19-00073v-L3
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:44 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh19-00073b-H5
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:28:43 -0400
Received: by mail-oi1-x242.google.com with SMTP id e189so3696148oib.11
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JoR1SjWnwESl+oE1fv6KVo2bguHNcd7Kf704UAmfTZQ=;
 b=T3ezc+yYs3zZjk1UzhnINZWIhJ2WrzxKamCiwg9Y4RZCspJXl6/0I8BFz/IMb57SWq
 A5q5YT+qAotIagV1RxCDJpRKhn4zFQ2okPIqCDfTJqw+3rBoZD9ce9HWk2IlQ0Yz4X0F
 Q0pudbyUC90rjUUc+9BGkapfwOuIBYWseazRz0lP/fSbsJJAPK4WL0xQ5TTEuOkVoHZ6
 e6SiStoQud379XGXxmwlzwnQTcOBTX8fpn4ymS1UsizFWUrIGUIQEOnOQmAebB3aA1k6
 H3IDMBMXln9E2djKqSVULF5ewCkm8lcHT8zTnmqefejNVngGYhwRw20SlWQYTAv0ZXYS
 bCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JoR1SjWnwESl+oE1fv6KVo2bguHNcd7Kf704UAmfTZQ=;
 b=WXa5MCI3P9YEww1Fnm9y8XLw8rMZDQjQ0wBjeltFO69bfZRIhQ7RPAiP7kH6t68EUT
 a2l6V9Fm8xqfHBLNG8orzeqD0LshiOadBLI0VPS+L6pscHWiyfun3MvgdJvAiBaluYvQ
 c07dC88a8Wv2z6njFN5P3skGjy+JJ+ygmnNnBvP5fstRcbHodOXvXONagyiPIseXw4IF
 OGy3tlpY8Jk0JPk+Ril5xljwXW3Jgi9VL5UmehMJPAsQgoZHr1ODEKZSzyXOnQx3Krz6
 3Eqq0HlyN4ex7iSS2+4WVS9MWiTXwUpPSTj8FsXEX+9X77y3MgLbEBMLUvtN0CK+lKvd
 dPvQ==
X-Gm-Message-State: APjAAAWvTCUBlFKIvYUT3UvC9Mt6W+649lSF3L3R0x0p2hAogUqUk9Ew
 ZDO+sAGR4CUAnp/jOMObf3CHptAlKrzspQ==
X-Google-Smtp-Source: APXvYqzUH6rlO2OOrLelBnalm0YGFhhRB8lhu1MDDzkRWoz9tzd1Dzdt9YXC3gd4PjZGPS0Ht1uRZg==
X-Received: by 2002:aca:7507:: with SMTP id q7mr7840925oic.87.1560022122570;
 Sat, 08 Jun 2019 12:28:42 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id 37sm2562333oti.45.2019.06.08.12.28.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:28:42 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-27-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <24d3e75f-bf63-beeb-c06c-79b11ad917de@linaro.org>
Date: Sat, 8 Jun 2019 13:31:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-27-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 26/42] target/arm: Convert VDIV to
 decodetree
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VDIV instruction to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 10 ++++++++++
>  target/arm/translate.c         | 21 +--------------------
>  target/arm/vfp.decode          |  5 +++++
>  3 files changed, 16 insertions(+), 20 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


