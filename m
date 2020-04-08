Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B7EC2BA16
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229F7206BE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 15:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBfisIzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229F7206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMCij-0000ij-7i
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 11:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMChf-0008Ba-Fu
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMChd-0001Ad-Ka
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:33:23 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMChc-00019N-0y
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 11:33:21 -0400
Received: by mail-pf1-x444.google.com with SMTP id b8so705013pfp.8
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=at27kPjEKg5tDoL1IDuMQIn8HA8ie5wRiCvGPVXwxzk=;
 b=UBfisIzMqC6Bhhogoh8xGSRa3o8/64d/T8nWwFQnrAXOp5JkepySTHNp5SnmAhTk5M
 Y5cZD7pXs/npllyfzaBbjL3+5j/kYIYpEmotun0WFfQfdetpfgYuSwosfcKzTcbQAbe9
 haYy2bP96pyGc8r71gF0ADm8MEdPKRCqbYQOY+WcxVfAnjmGBSByUO5TmnxnleEc5qGQ
 xlPr+ex+SA9hu6SL/eQaHRLOeoOw+BcS3BGXCztEcDFbwEXgK3YDyJjDfYrEvCRoMB9k
 dwT7BWJHsP8RSPZ/0Z9lPJgoaylw6+OBXoM5Wo2nPcRiUnpU/0JoWYf2WRaQZhFHp26/
 r4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=at27kPjEKg5tDoL1IDuMQIn8HA8ie5wRiCvGPVXwxzk=;
 b=gLql99NJM4tXryIhpaLmMFipxZsFOM8ulwNssIySChsT8kcKM44c9LLUgD0p7NBK0v
 JX+n0V1ThBllHDxKjgxX8oNfdLVZniFrOv3MjQ0BvfUn4ep/BQHtzHZ45864N+ey/uvw
 aUm3Nm/K1EUwoJrU5FWaFk0x9plmvQ3OBSGVfAVgXsCLEbZ4IETNCzxg9WRjD+kYhYWG
 VQw/C5SrSl1jDoSvoVeFF0XNsXaXgLMrIkuLy491xdBvIImq72HxFB0szRd6LOyasHuG
 44z1jFbqGIlMoadIzciOeNR13C2TKBY/iikAt+UMCUWJTqpcfZCQopTGgOmFMUKP6yuy
 VVfg==
X-Gm-Message-State: AGi0PubcClNQtD3pbqQ8rZpBpVSZI4zCLBPZPhafAsjoC9HUY2NvSoHt
 Z9ktuikSE0M0d7CTw/44OPVH/M8Dx0Y=
X-Google-Smtp-Source: APiQypJUd08X+WISSSRDgUy5zpmtNhZIGpybmmdyhbWxYCR58yk7T/KgZMKtn0I8yARpm1u+XE4R/w==
X-Received: by 2002:a62:64c9:: with SMTP id y192mr8344175pfb.26.1586359998309; 
 Wed, 08 Apr 2020 08:33:18 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id e23sm2198421pff.192.2020.04.08.08.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2020 08:33:17 -0700 (PDT)
Subject: Re: [PATCH for-5.0? v2] target/xtensa: Statically allocate
 xtensa_insnbufs in DisasContext
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200408153057.31794-1-richard.henderson@linaro.org>
 <20200408153057.31794-3-richard.henderson@linaro.org>
Message-ID: <548a9755-b18b-9e78-8f48-8afd5fdccbba@linaro.org>
Date: Wed, 8 Apr 2020 08:33:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408153057.31794-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/8/20 8:30 AM, Richard Henderson wrote:
> From: Max Filippov <jcmvbkbc@gmail.com>
> 
> Rather than dynamically allocate, and risk failing to free
> when we longjmp out of the translator, allocate the maximum
> buffer size from any of the supported cpus.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> [rth: Merged the fixup in Max's reply to his original]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Oops.  Leftover file in my to-mail directory.
Not part of the rx pull, obviously.


r~

