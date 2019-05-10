Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3353BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:28:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13BF208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyQOGMsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13BF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8NN-0007k9-5I
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:28:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP8D0-0004o9-Bg
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP8Cz-0000jh-Dw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:17:18 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP8Cz-0000if-6l
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:17:17 -0400
Received: by mail-pl1-x641.google.com with SMTP id f12so1036269plt.8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=1yWDOpNYnn7RE5roKzHhAppICNQzXylMOJNgQpdiiZ4=;
	b=FyQOGMsvbXacwPKUHKnds0NIL6d0EUPIoOnk58AZjwgxkLOXJQCZxhjftrgEGnAzou
	GeBHjV4mWCqCDTC52mtk9CcB0lT49jZg3UE+SL2CPcu9jIVNGkgt/JcckH0c3e0+bnXp
	9X4rXPDMVigipASwOOBf12+2ZVnRNGrKJ3+G+Ned30CYy7C/TelqK19G4zBApECd3d38
	4nj1TkSSD5AQrz1av6PPz3dKOr1VOBypbHndMnEe587waws9Hob6b4bYykz8BcFqcQ1z
	wivli62EMKRMHL5ty0RHZk2+Q0V1b5r5oi5QwXSezx8pWl65cy1GdqUxAtELdnUMFxWu
	9xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=1yWDOpNYnn7RE5roKzHhAppICNQzXylMOJNgQpdiiZ4=;
	b=HCO7M+bqMHin2m3xqXg5skfdvS23tmLgp896Pw1DQ3eQFIM73HHAyqI6U/qohW20Xr
	rBUQufXhum9sblKDRkLBbLARkUKlaXmDA/vq2Ad5lWSSjKGt+rd2sTF3NKg1lYgBCVqO
	uyKKellVN99c0Mk7b6i/z9NUwlQQWAqdgpSrZjUHcE6ZYIthjRAiFxB72CjsTpe2p8f5
	8u1alqc3t1hZ/HSWztCDC+iLHulOA4hvFimusG+C4F7mmRsJCaoWvlu1dCetLQc2P0+h
	lAIQGeEKUEEdxl+73POp8ZIP7t+DxMVFrE6vtke8gQ+NsYk1h73lr/WaSk3zazRig2XD
	W/pQ==
X-Gm-Message-State: APjAAAUpoIMpI8fP46GKG5BodmK/lNhCBGBn39/wm14eJqk6HTj5/kDU
	Y4v+dblz+sMz8bSLJxc5l4QbCQ==
X-Google-Smtp-Source: APXvYqwHb6QPsXfhwixY8A5zRJVeMNKbxwFODP7DpBOo8oCWOWIPwu/J0ObokpsOdEPMic0Z/g2Xdg==
X-Received: by 2002:a17:902:8698:: with SMTP id
	g24mr14755195plo.151.1557505035983; 
	Fri, 10 May 2019 09:17:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	m2sm7993808pfi.24.2019.05.10.09.17.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 09:17:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190510012458.22706-1-richard.henderson@linaro.org>
	<20190510012458.22706-23-richard.henderson@linaro.org>
	<CAFEAcA9uwaev+Q=BgLBz+fgO6C7VGmw4Nxcozg2vm6TOm+LJww@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dd180f6d-27e8-2f2b-a7ac-ed1d8bbc9498@linaro.org>
Date: Fri, 10 May 2019 09:17:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9uwaev+Q=BgLBz+fgO6C7VGmw4Nxcozg2vm6TOm+LJww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v5 22/24] target/arm: Implement ARMv8.5-RNG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/19 9:01 AM, Peter Maydell wrote:
> On Fri, 10 May 2019 at 02:25, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Cc: qemu-arm@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> v3: Log errors with -d unimp, for lack of a better flag.
>> ---
>>  target/arm/cpu.h    |  5 +++++
>>  target/arm/cpu64.c  |  1 +
>>  target/arm/helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 50 insertions(+)
> 
>> +/* We do not support re-seeding, so the two registers operate the same.  */
>> +static const ARMCPRegInfo rndr_reginfo[] = {
>> +    { .name = "RNDR", .state = ARM_CP_STATE_AA64,
>> +      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
>> +      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 0,
>> +      .access = PL0_R, .readfn = rndr_readfn },
>> +    { .name = "RNDRRS", .state = ARM_CP_STATE_AA64,
>> +      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
>> +      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 1,
>> +      .access = PL0_R, .readfn = rndr_readfn },
> 
> Don't these need to be marked ARM_CP_IO for the benefit
> of -icount ?

I don't think so.  There's no lock taken, as for mmio devices.  It's not not
related to time, virtual or otherwise.  There are no possible exceptions.  I
can't think of anything that would make icount care.

Have I missed something?


r~


