Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE44AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748102051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uA+nAZVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748102051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRgm-0006QM-HY
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRfe-0005n0-4X
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRfd-0008SE-78
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:45887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGRfc-0008Ru-W4
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:19:29 -0400
Received: by mail-pf1-x435.google.com with SMTP id j10so7876019pfi.12
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EBAFoBhXznmQ+S7TFlWHG/ogli1SNKvySHKPWaJo7II=;
 b=uA+nAZVAJ/cl1r283UcBtAhQn+rW4kKoJp6crIe2210G3T4jlkPZwvS9nGzM2ySTiH
 dSTqJy3BX7IxU3oMmvJiumENabIvHpQq0qOpStSIkOS9LLrfyTVCV+DxPn1MGk4hcw1r
 0rzyEDK0HYle73YSoGCdFanHkrhvdTRFy9lJC4O4A5qcbIeWGsaNYoQZDoVuYzIDqUjE
 Z1QunlTS8LuR9yhvTTQWweTxcT2wdg+utFtbbdKQPvDUovfzD8f/dVclVsbLJIVK2Buh
 mo7q6PO5J9mMc1cqW/GP8gTP3aW6FwcBPC/eyt/EgqJXWjDuym1qOtabkuzxIdJGea0l
 8JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EBAFoBhXznmQ+S7TFlWHG/ogli1SNKvySHKPWaJo7II=;
 b=cGSqybZ9bgQMKFKkT0DNvpC5iRfZHG239GtsXJcBf3cD8CEvu02J+/kjkhw/lqpURE
 F2kKfdPwAJbkyyuBJreiu/uJkX0ZMX+oFQ1R4ZTal6WSvwbqUFMSpdAOl6D+lYBmk9i/
 a7GutzdDwkAKT4Eyz7vTQfbFJ9Ur0crHPfrD0QRLznpphAgKdj/lg7zqXqn1KFPwpOMc
 R2BNbuBOBwUginbhKaVCIekknI0QNMzadPF6l+aToT1Ey7DKjclx7x07VAZfJ9wc2ksp
 VMTUPDkXNwoqx6q7Aeq91IEAlIUIwRKIMHkH4aVeqk2CBdBNN38Dlo0SiQV3/Kn4xjI3
 MAqg==
X-Gm-Message-State: ANhLgQ3P97eu6G8bGWL95llQgN7izlsUH8J7aKBXDcmr6vAPWqIRDoUh
 plAPiwgOaYB1xAl3dDvHBoL+0Q==
X-Google-Smtp-Source: ADFU+vswzrs4tV1UsCKKW4Hpp/AvjlzgNjIgAh59cKOaunigUQr5zSW9gCoux+y/h2I26z7VFxE1vA==
X-Received: by 2002:a63:7505:: with SMTP id q5mr18437364pgc.429.1584987567787; 
 Mon, 23 Mar 2020 11:19:27 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 m9sm10367568pff.93.2020.03.23.11.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 11:19:27 -0700 (PDT)
Subject: Re: [PATCH v1 07/11] tests/docker: Keep package list sorted
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <55dea9ec-eb5f-7f71-45b5-4cb3bc2c2153@linaro.org>
Date: Mon, 23 Mar 2020 11:19:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 9:15 AM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Keep package list sorted, this eases rebase/cherry-pick.
> 
> Fixes: 3a6784813
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20200322120104.21267-2-philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/centos7.docker | 6 ++++--
>  tests/docker/dockerfiles/fedora.docker  | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

