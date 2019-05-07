Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A8C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3362120675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 05:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjhMcbct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3362120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNsHI-0004mW-4U
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 01:04:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNsGV-0004Ve-FC
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNsGU-0003J9-D0
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:03:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNsGU-0003II-5m
	for qemu-devel@nongnu.org; Tue, 07 May 2019 01:03:42 -0400
Received: by mail-pf1-x442.google.com with SMTP id u17so7986462pfn.7
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 22:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=+Nxc5/xoRFeHcvON3Y2lmUgXIqEq3zVCR3EQAdvL80g=;
	b=IjhMcbcti1eAT8zKIaL723GJXjWVRQadd4rb+I2ChzcfgEcbLWsRJnYnXwIzoyQQXK
	jxpYNFKN1rs+aGv3BuLPa1FXOgLp32GSpGLE1D5ZlOMUD4HeNgtAMGY7LYvBiO9ewzFu
	42HAuNYoUTuJ7VXB5POlGbdz0YqkKA9oVfu0kJBAhxcJMDhgW4Cx/il1qqdZKUzySc/V
	K+DoTRZJne5wR3BE4pc/fOQp9aYuX8fE2s/axx43KPl4AL8SfrCKgddrud4CepShXiGq
	XbJbOJI178RUGij+vwvlHxtCtJT2U2L1O3uj5mZM4OxJEVCnxSdGtvvsksEn63LHak+b
	sJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+Nxc5/xoRFeHcvON3Y2lmUgXIqEq3zVCR3EQAdvL80g=;
	b=fn8Yc7gK2myG2pC31U4dHJEEW3I/jG+Wgf1bgPhIjSiO6p74gibYibI5YcP9moG2T7
	PtL3KK0fdZNkXCk4a6lN9AY5qwzRMtvMwinjlYxC12lzsxEqcJxOLFYhaFuB8hsy/jbx
	QkObfnQpbj8o7D5QBE/J4BN3piDShnUmg7FGkcjU7w1JoZvdcZKBxGnN0Z79U4CVN3lw
	V02ouEwnG2eG12vXvtQ7houraBDwhgkBA1bBeTuibl3lLW9BNcWe2XL76/gTJ0Dk8W+D
	7WadYQYCX8W+Qx7DhLshdBV+hg7dNvERbpKgk/JdaACqRbDyJU46BfXDQBMTYA45M+l8
	/nmw==
X-Gm-Message-State: APjAAAUm1XGancpSPD0utSYU5RuCLt+h9EMOInZAB0rYirppdjL+4FcA
	QYG5mo8o7JczBJ1eQgC4mNIO+lVyXPE=
X-Google-Smtp-Source: APXvYqynZfA+qKlqGpAiaWPfkMbfekAFcDvbIiY7jp8jFEE6zS3FCEnVOZGVvEYSVCP6pjYFOIYMbw==
X-Received: by 2002:a62:70c6:: with SMTP id
	l189mr38850526pfc.139.1557205420341; 
	Mon, 06 May 2019 22:03:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	v64sm16440403pfv.106.2019.05.06.22.03.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 22:03:39 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-31-richard.henderson@linaro.org>
	<CAFEAcA_0wTL0K8nJw+LQK4-y6_qJ+Lj7nEL=xuU6vXQPW4YEqg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8380e4d3-b0db-effd-c5b2-8976ba63a35e@linaro.org>
Date: Mon, 6 May 2019 22:03:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0wTL0K8nJw+LQK4-y6_qJ+Lj7nEL=xuU6vXQPW4YEqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 30/36] cpu: Introduce
 cpu_set_cpustate_pointers
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/19 7:40 AM, Peter Maydell wrote:
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 698dd9cb82..790670ebeb 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -282,17 +282,18 @@ static void s390_cpu_initfn(Object *obj)
>>  {
>>      CPUState *cs = CPU(obj);
>>      S390CPU *cpu = S390_CPU(obj);
>> -    CPUS390XState *env = &cpu->env;
>>
>> -    cs->env_ptr = env;
>> +    cpu_set_cpustate_pointers(cpu);
>>      cs->halted = 1;
>>      cs->exception_index = EXCP_HLT;
>>      object_property_add(obj, "crash-information", "GuestPanicInformation",
>>                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
>>      s390_cpu_model_register_props(obj);
>>  #if !defined(CONFIG_USER_ONLY)
>> -    env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
>> -    env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>> +    cpu->env.tod_timer =
>> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
>> +    cpu->env.cpu_timer =
>> +        timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
>>      s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
>>  #endif
> 
> I would have left the local variable so that we didn't
> need to change these lines, but whatever.

Then the variable is unused for CONFIG_USER_ONLY.
It's easier to suppress the warning by propagating.


r~

