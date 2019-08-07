Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79553C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44FD0219BE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqHzF1HB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FD0219BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQeB-0000yl-Gh
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38824)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvQdS-0008WU-51
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvQdR-0000ju-6E
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:26:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvQdQ-0000az-Ug
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:26:05 -0400
Received: by mail-pl1-x644.google.com with SMTP id b7so42084355pls.6
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=O6ZVVVnFK8gMP42dZaFj7U87HAGu+ffS7XGWfusThcY=;
 b=kqHzF1HB/XqXehEyAGwHuWapyLBzqxoUwslq9VHFHjepNTexylmqXBrOrsDI0j8R+q
 MhDVlTqbMcNZMwOdM9cThzY1WIDKKbNDN/nDAoM75sUjnIEMhJMjrUeZLcok/qE4qzDs
 5a746AGfupRavS08skbNZZxSwywYJnCg6MW3o1BO8RtSo8rxhYn1ozye3G1lLBErFdYo
 jPFxn0fMcK4r1Wl/RZQh/eH4a4nf7a0kJPkza1jNnLb1ZTqJt2S4ztABGqVnbfxIT8C1
 uEqHYGpvGg9fg7w+UVe4acEmbsGXyMBe/5z7WU4s/kPi44IOTtyrIvloef3RSr9K7JJg
 0xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O6ZVVVnFK8gMP42dZaFj7U87HAGu+ffS7XGWfusThcY=;
 b=gN+266HEc3S45QFdr1MwU0bPsl4+En+l3s0AMMwH1mm7d32N4im0ZskoJ1Em3oO6lW
 ErLmDwTmKe0KBueEHgymLEyYfj0bWgT4/JVn+fgZfJBwaht0hFM/73H+Rlqd9YxfW4Fs
 RLp2YduB4pX9ovgx+IFQyJef0pXi8Zy2c7UOmXC52EmWb1r8+9SccG/3WC3Or6u6Th8d
 HzsF8QzJTgQjWFn6pZHmjRz6d6oYsP+NT5QEzsAxlwk6nj2x24X5mr3W9OZ3K/PjjK7r
 awgeM19ZbpRlSlnOQ3rBcWWjAW5IHItiMvdIwDOLtSxa+3xlZaMkkCLQKiL+9ROdKBAg
 A0KQ==
X-Gm-Message-State: APjAAAWMrKa7UMDnqvBVEMnpfglLTgOhaSu8jk2ZphouiVm8el6ttAq3
 +pn7nF76vctbsqt4NnNlXCk+xw==
X-Google-Smtp-Source: APXvYqyejmRMvJIKXeq/VCoXVFO/2uOzSeVPNLOfkOlZaQk2RRXhvA3MAQbShkrPuu6ScpNmd4VrYw==
X-Received: by 2002:a63:4a04:: with SMTP id x4mr1628068pga.411.1565202361099; 
 Wed, 07 Aug 2019 11:26:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b68sm113296790pfb.149.2019.08.07.11.26.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 11:26:00 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190807045335.1361-1-richard.henderson@linaro.org>
 <20190807045335.1361-4-richard.henderson@linaro.org>
 <CAFEAcA_MFg1_gpaT5+X71s8r5SYZFTizdXs2vQ_6mLooP7E+kg@mail.gmail.com>
 <061145be-4cd4-b8e6-ae5c-562a59e8088f@linaro.org>
 <CAFEAcA8fCL4VTJYdWGbDySzT9zkgmjcMGqBj0fo9gN4x4B-WcQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5bcd1a92-d8a7-0dac-bc25-a0db23bb2eaf@linaro.org>
Date: Wed, 7 Aug 2019 11:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8fCL4VTJYdWGbDySzT9zkgmjcMGqBj0fo9gN4x4B-WcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH 03/11] target/arm: Introduce read_pc
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

On 8/7/19 11:16 AM, Peter Maydell wrote:
> How about we add this to the commit message?
> 
> This changes the behaviour for load_reg() and load_reg_var()
> when called with reg==15 from a 32-bit Thumb instruction:
> previously they would have returned the incorrect value
> of pc_curr + 6, and now they will return the architecturally
> correct value of PC, which is pc_curr + 4. This will not
> affect well-behaved guest software, because all of the places
> we call these functions from T32 code are instructions where
> using r15 is UNPREDICTABLE. Using the architectural PC value
> here is more consistent with the T16 and A32 behaviour.

Looks good to me.


r~

