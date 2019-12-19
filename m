Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF4C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DD0227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7m8dzSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DD0227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0EE-00035E-QN
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihzx4-0003yv-P0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihzx3-000500-Lj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:51:06 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihzx3-0004td-9G
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:51:05 -0500
Received: by mail-pg1-x541.google.com with SMTP id b9so3481899pgk.12
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4r1dJHdQo0OjsGUYx+/2Vrzn84OYJujOtfe17Ka8aVE=;
 b=R7m8dzSXDXUEWY8YDLMUipwCYPic6/eXVvFpCcf+FFwBSwrjL/GH3xJrXv8E+nq6C9
 xxrPvYbL8zbsWC9TijBP5toRPx7yXUKrnYuPRJsAG5rfGquefKqCs4QSLE7kiR5h0Zgv
 +Hq88OpkYenBEYgaoOh3dTkb488LL/wKRgOO+vwhUO5DFBYp73iaqHDLoVIJxKKl/fP5
 RSJDFbSmqXTzKWsfeGHvuAAyovmTfTBm2HfrLu1zKwuDZ6OQBhdN+aycelVE/0L3fsgj
 EXOgBIKOkkBQBMR8qHfo/Zp9y5dbfqPp+C0x+sV5+/HHz9xmwR81jhqSDOofnV9paz89
 SVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4r1dJHdQo0OjsGUYx+/2Vrzn84OYJujOtfe17Ka8aVE=;
 b=uX9JWe/FsqNLKwrQOx1w5/K6CasARVOY8eKvuNvJdkIUJFA/5UOpQCoEAiDVV9KA0+
 2vm/gUzeVOHI9PUw+SMXAgbPjGW31EMgoYK6MZpcyO9xJcZFGx4nWxngnTgCdLapnwZ4
 BaVuZ3PpO5BuI1KQR9LrKwsI8MjibaaSFRi1qfQ+fhU/f1FahGYHuTcf2W6+gLuE6m5h
 SDMoGNylcpl6/8HdTbJmsDoTDrcEonIIuyljaP0xmywLfvlv7C8iV9uPx/PvjJg9CUjS
 w7lFVxinRBLzleCGVlTc+VPP/4fc9Yl4BTssyNZy/UQfFL6oLW6o6H7RpNP4mSxPpHUt
 aVCA==
X-Gm-Message-State: APjAAAXLKhj3rPNZKz0aqlFep8mdO8LvW9sOAjNv0De888J2c+fBkmEB
 UAVwElKD/JaLNLjzt6CWMRk/hQ==
X-Google-Smtp-Source: APXvYqy8h6VOJ/GQhC0URqg5jF1nyaMRXxNe5Kj9AWDZBeTP2bQJINRIN6Mxve2qOXc9j8iqfPuViQ==
X-Received: by 2002:a63:4d4c:: with SMTP id n12mr10509796pgl.212.1576777863828; 
 Thu, 19 Dec 2019 09:51:03 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:9de9:bce2:6ae3:53c4?
 ([2605:e000:c74f:dc00:9de9:bce2:6ae3:53c4])
 by smtp.gmail.com with ESMTPSA id r1sm8091054pgp.15.2019.12.19.09.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2019 09:51:03 -0800 (PST)
Subject: Re: [PATCH] target/arm: fix IL bit for data abort exceptions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191217210230.99559-1-jeff.kubascik@dornerworks.com>
 <7a274247-e593-5828-73f8-2042971e8633@linaro.org>
 <CAFEAcA8Egy=Jkw8yKSumkeX=+Qxi8bPy-0fJjopHR6gCmz3FLQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <64d31889-6269-1f6d-6aad-8e863310cf79@linaro.org>
Date: Thu, 19 Dec 2019 07:50:59 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Egy=Jkw8yKSumkeX=+Qxi8bPy-0fJjopHR6gCmz3FLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jeff Kubascik <jeff.kubascik@dornerworks.com>,
 Jarvis Roach <Jarvis.Roach@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 2:43 AM, Peter Maydell wrote:
> I think this is a regression introduced in commit 46beb58efbb8a2a32
> when we converted the Thumb decoder over to decodetree. Before that
> 16 bit Thumb insns were in a different place in the old decoder and
> the 16-bit Thumb path passed ISSIs16Bit in with its issflags.
> (We should cc: qemu-stable@nongnu.org on the fix for this.)

Oops, yes, that would be my fault.

>>>      /* ISS not valid if writeback */
>>>      if (p && !w) {
>>> -        ret = rd;
>>> +        ret = rd | (s->is_16bit ? ISSIs16Bit : 0);
>>>      } else {
>>>          ret = ISSInvalid;
>>>      }
> 
> Rather than setting an is_16bit flag, we could just use
> "dc->base.pc_next - dc->pc_curr == 2", couldn't we?

We could, yes.


r~

