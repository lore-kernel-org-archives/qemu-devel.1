Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A771C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240252147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7dPzJmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240252147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48645 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLUeJ-000503-38
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 11:26:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLUdV-0004Oh-Lh
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLUdU-0007mM-Ow
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:25:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLUdU-0007kq-IF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:25:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id n2so6976684pgg.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=JbusFQ1XmzNpK7zNiSc77NkcTe/v0+D54JpVz6aqwD4=;
	b=Y7dPzJmxAzK/HtGrxzdXX8H5F+1oWdMo5W+AYm75UInT83FwRrHTUbatImV1cqjxI9
	+Zq52xMHyKjhhiZZy+Ox5B715jcP/FsrcouKE3AGrDthn9RfS7KqoqobspFgfSai8uSo
	d42kC2tYLR8XC/siwfi3qR23franrAYCKjdZOrZL5aOwGTMNYZ6QV44ME8bqjKUoWRCD
	FfiMU9CGbWlDi75ryxQh5lustu6WBoMlgIMv5T3nEEL0DY/oW/N20gGu3k4suwee8KeN
	w7VxYSu9kYm0fZuhfbZSdWZVKlvxarIswS5UqgBQsUMM+7bS7BxHrns8dC0wx80+N6gQ
	vw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=JbusFQ1XmzNpK7zNiSc77NkcTe/v0+D54JpVz6aqwD4=;
	b=XR+UaR25wtSriHLZZF0xvWBFd0VyR99nv1oxOve+yJEVGmqVbbf/rtF5VmV4BOlb6h
	7rCR40LnQ3bKQ8ydvMWY+01dFHVTH2nZqzE8ageZPXFwXZkDKmOUaEq8oUMtpOu2oDOJ
	DpHUJ6wiw2vucG5K3z1yPIEISF6TcIXvoG5vHrtBqG5NbEir4lpSLB6l8/dIRkmwqsim
	bg+g2V+e4x4KD1HA+tv0sZ1WQ/xrqtePiaWDs2Pbi/HznGRa+8ku8/KKQUprYBN/9hSh
	jPlBH3Qzcr/fGoJYWGer/YD2rVa8EqCzFdY+LLVy1e+UhxcVwivly2EO12EN/u5Gb1E0
	Dd8A==
X-Gm-Message-State: APjAAAXuzTcOSWgsnUH47lro9nHuyGk6KvWka01Iqbt2jwoqjRUGCPx9
	cf00rLqXp408ti/9abO2z3DK1A==
X-Google-Smtp-Source: APXvYqx1AxF9vFHWklZeAR/hN3E5vKbYxqSMvVCpvkwmOdQXcipX6ifo8PHQj/fHhYMCVhQkdqj6hA==
X-Received: by 2002:a65:65c6:: with SMTP id y6mr28500083pgv.7.1556637934708;
	Tue, 30 Apr 2019 08:25:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	e8sm67067984pfc.47.2019.04.30.08.25.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 08:25:33 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-3-richard.henderson@linaro.org>
	<CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
	<920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
	<CAFEAcA-=JyNF94OTq+rJRVxbfhJ_B6=fLm93s+y0ScX9Uyfngw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <257d3eea-409c-6d2e-2384-d56f93f8d393@linaro.org>
Date: Tue, 30 Apr 2019 08:25:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=JyNF94OTq+rJRVxbfhJ_B6=fLm93s+y0ScX9Uyfngw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v4 2/4] linux-user: Set PAGE_TARGET_1 for
 TARGET_PROT_BTI
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430152528.vqSiQytaRXIcOXEIZtTmJlaSl226URzk-Mw-KvvrIAY@z>

On 4/30/19 3:40 AM, Peter Maydell wrote:
> On Mon, 29 Apr 2019 at 21:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 4/29/19 9:21 AM, Peter Maydell wrote:
>>> This looks ok code-wise, but we'd need to hide it behind
>>> a defaults-to-off x-something property if we wanted to
>>> commit it before the kernel ABI is fixed.
>>
>> I'm not intending to change the user-level abi, only the
>> internal abi within qemu, for handling of the elf notes.
> 
> You're changing target_mmap(), which is used by the
> guest mmap syscall, though, right?

Yes, but it's also used by elfload.c to map the executable.

> I think that we shouldn't allow guest binaries written
> to the ad-hoc TARGET_PROT_BTI ABI to work without an
> explicit x-something command line argument to QEMU...

The guest binary is not written to an ad-hoc abi.

It is written to the finalized ELF note abi, which
I am trying to implement with a *private* QEMU abi.


r~

