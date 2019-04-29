Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7698C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A131020673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rachQwpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A131020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8Ha-0008LC-UC
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:33:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8Gd-0007k0-Qy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8Ga-0002ca-FE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:32:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL8Ga-0002US-7A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:32:28 -0400
Received: by mail-pl1-x641.google.com with SMTP id d9so5237666pls.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tNT1f55oknG/sd10ahdmAPYtemhMntqX6l4Vc9Ze8dA=;
	b=rachQwpI78nnSNRN0JH8ETHUzcK+/7jGlIcAuvphllAaTPfWkXrx6g4wctLT7PcSYj
	Y3r/p1CrGOowWb3Ftb4kvKy3Aky1x8OCGft8BxGthmTK9VEVIinglPPVuLoznVM9TuL9
	yMUUpd6sVsolkY1HGOTRfS9moXRJDJh/9t5CSXZRohkHJwfWs9ubeSlw04MeRkyons0t
	txUBu4EFMzvkMoi2//eRKt5Ot+nOQF2fioALfXF03ZHs9mkRFT39CzE5Y9ivvo2QxqIv
	EApjP9dP9dap+JpIuu9stEwRDZo5FUJNmDvNHJ3Wf+nH1vMcDqd6A8UyPm+b+S3MqrC1
	pBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tNT1f55oknG/sd10ahdmAPYtemhMntqX6l4Vc9Ze8dA=;
	b=iRplBOP4hGUZR3+L++pzqPYPN+rWIlaPH2wN8Y7aYcmVesU04QzaKAD+jyChwt+xpt
	UEWNuO3dVIDUOuso5BUOXiHGACUbspjaevGk32lWloU1sznUecOut9NiwWrNTPWNeDjf
	HbVWEJUK0yGmRLOs/i4pUWM5X1Zx/5wUbjSu45XZfMVzfdRIqTOzJgcNTADlYf8Pl0fA
	IqacQlHgxAoBEyw4oZXemwr2/ibcNuVIW0Dy/gh2yDy1P/die2KbHye8spIxvNitgT0i
	pqtqmmTn7oaN2ZC2DAGWsgL56EtOlic4wxbluTI+yFKhL/k0khDC1IgyHaaT1vMJU//j
	9D4w==
X-Gm-Message-State: APjAAAUVtBSNgM35lXs81iFhD/oqmreiHQ6gSBsj7ysVpWBFQhH7mxnR
	aGIvkjqGu2IGoXVIOTyKz3goY2pujgU=
X-Google-Smtp-Source: APXvYqzGDHJ++mV48Cffa91CL6Gs+fT1eGNhuwJh9bVamScXqU0X52HksC8sd9G/e9PqI8ipVlQ4Ug==
X-Received: by 2002:a17:902:2702:: with SMTP id
	c2mr62445420plb.37.1556551946368; 
	Mon, 29 Apr 2019 08:32:26 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id n67sm150325pfn.22.2019.04.29.08.32.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 08:32:25 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-33-richard.henderson@linaro.org>
	<CAFEAcA-uRsaN7zPSWO5Ga8UnYHEbF5MdEKmnbt07N9nDoOXZ8A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <23ce5069-3f36-5f18-c815-275bf9dfc83f@linaro.org>
Date: Mon, 29 Apr 2019 08:32:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-uRsaN7zPSWO5Ga8UnYHEbF5MdEKmnbt07N9nDoOXZ8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 32/36] cpu: Move icount_decr to
 CPUNegativeOffsetState
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
Message-ID: <20190429153220.tIwNSC1_3mXv2W4lgItCmlneOvgmW4hWqKJXlICyiQk@z>

On 4/29/19 7:48 AM, Peter Maydell wrote:
>> -static void align_clocks(SyncClocks *sc, const CPUState *cpu)
>> +static void align_clocks(SyncClocks *sc, CPUState *cpu)
>>  {
>>      int64_t cpu_icount;
>>
>> @@ -62,7 +62,7 @@ static void align_clocks(SyncClocks *sc, const CPUState *cpu)
>>          return;
>>      }
>>
>> -    cpu_icount = cpu->icount_extra + cpu->icount_decr.u16.low;
>> +    cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
>>      sc->diff_clk += cpu_icount_to_ns(sc->last_cpu_icount - cpu_icount);
>>      sc->last_cpu_icount = cpu_icount;
> 
> Why does this require that we remove the 'const' from the cpu
> argument to the function ?

Because

  CPUNegativeOffsetState *cpu_neg(CPUState *);

and this isn't c++ so we can't overload with another

  const CPUNegativeOffsetState *cpu_neg(const CPUState *);

and it doesn't seem worthwhile to preserve constness here.

>> @@ -265,7 +265,7 @@ static void cpu_common_reset(CPUState *cpu)
>>      cpu->mem_io_pc = 0;
>>      cpu->mem_io_vaddr = 0;
>>      cpu->icount_extra = 0;
>> -    atomic_set(&cpu->icount_decr.u32, 0);
>> +    atomic_set(&cpu->icount_decr_ptr->u32, 0);
>>      cpu->can_do_io = 1;
>>      cpu->exception_index = -1;
>>      cpu->crash_occurred = false;
> 
> What determines when we need to access the icount fields
> via icount_decr_ptr versus when we can just directly
> access icount_decr ?

NEED_CPU_H.  To access the field directly you need ArchCPU defined.


r~

