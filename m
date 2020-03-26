Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827BAC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 01:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4738420719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 01:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1rIfzY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4738420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHHMh-0008M3-Fm
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 21:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHHLt-0007rr-6q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHHLr-0003pM-Ub
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:30:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHHLr-0003pE-OH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 21:30:31 -0400
Received: by mail-pg1-x544.google.com with SMTP id b22so2057138pgb.6
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CVNLZ1mdGy/IHiGD40hf4U1pzDtYVCLC5S0KT3HY9Uw=;
 b=m1rIfzY+k+TRMwbG/pokah2GWh3JgTFybEo3y4DPj8OY1ZV52AZVUBJUUGPXPG2B0S
 F3YQooifCS+atKvKLeaNW694z0tCzhm18PAArnyBqb6RASVIIB4PblnktO5ag/TwMqrk
 deUINP281bdWNTfGdaLnczYALl3bfsuryAkpvUHnXAqJrdcgPy8FvNmQlY+As5ft5Xyk
 Cfvmm0PEzGyRXbbAqNEnRWgfB1HW3rdRsWazHxoVGf6GJOX69Bm8lu/47oSEk/4YXxs0
 U69gMtn/jLMtBIZzOZqHJh+1Yx8O2WjeM9qGtDNqtVJ/xw5XY26cg0CASDLzwfa0e6zn
 oF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CVNLZ1mdGy/IHiGD40hf4U1pzDtYVCLC5S0KT3HY9Uw=;
 b=MwRcuVJItGcZr13Et761ZTfElWDXcC+FkRNXY25bynApLxAzkDzOmebCexQ6Fe+GkR
 QqBoU/lTkUghcyXQQhbToqxrjcsQ6IpCADu8YAvcqr02B+rmxrJagAG5AfMLOloHlt7w
 Eo6PIdOshtNlAvSGheIzTq8HbdyIVls3pF8dGcIn1L1qQP26KtwCIB1feux4YkwuWuQO
 Mwqbe1vkIviZR8VztdvM8L7yEdmC+wFPmmeO4z+/PykifUNRD+sQly6U0RZCYYI1yw2E
 aB/sl7PWlfwTbRSWxKhyETsCvGwPOCbPiCgl7GKBJ9drdJZXv5UXM4k0zpy3nlnyoOGV
 uMyQ==
X-Gm-Message-State: ANhLgQ2yTShfjguC/PahDsyEmRfyCalkqOKyZBeOOGfhj6SDddQ8/R18
 ypBAmK8tWhfpCBssvbnZUyn0ew==
X-Google-Smtp-Source: ADFU+vv5uAEXE2171phqzardSHop6cBInxfVdeWRngfEIryOhfE6SRiEiC+VcV/1tD+TG4EMQ/DP+Q==
X-Received: by 2002:a65:428a:: with SMTP id j10mr5861454pgp.272.1585186230226; 
 Wed, 25 Mar 2020 18:30:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id mg20sm398748pjb.12.2020.03.25.18.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 18:30:29 -0700 (PDT)
Subject: Re: [PATCH for-5.0, v1] target/mips: Fix loongson multimedia condition
 instructions
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
 <aa622b1d-e28a-c3f1-d18a-73e8a67c8ccf@linaro.org>
 <CAHiYmc7R_Y7s5DaVHf=0rkxf7N2qTSLXdTdL_vy6mH+hVdwLqA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef2899be-3abf-4f15-1d7c-796994e1ecdd@linaro.org>
Date: Wed, 25 Mar 2020 18:30:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7R_Y7s5DaVHf=0rkxf7N2qTSLXdTdL_vy6mH+hVdwLqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: aurelien@aurel32.net, aleksandar.rikalo@rt-rk.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/25/20 3:44 AM, Aleksandar Markovic wrote:
> May I ask you, Richard, to select this patch for your next TCG-for-5.0 queue,
> so that I don't go through a MIPS queue process for just a single patch?
> 

I suppose I could, but at present I have nothing in the tcg queue, so it would
be just the single patch.


r~

