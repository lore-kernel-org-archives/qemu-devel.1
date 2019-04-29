Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A087C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D467E2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FH3tsPSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D467E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLCfB-0007ON-2b
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 16:14:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCeJ-000737-NT
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCeG-000054-Bk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:13:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLCeC-0008Tt-VU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:13:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id b3so5888460pfd.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=agP0JAe/1SalvrM8Hz9cA86krK6jtIPxmLJeNcu7hUk=;
	b=FH3tsPSEQG5to1PlwMI1QS9s1CXqyYPE6D+WeCdUwVqFYQDRGF8cTG6NrW8WjcVLRK
	tuF7yUKzZqJcve84S9dn1VRs42MMERgDzLFwsXmaZPaGfM0XAqG1GstFNxNLv3IgoebT
	WWBm85iGYbxC0HHAMzh6hsiA05LCyZoaUF86/tbwzgGyHNo8FNcg57cS3sT+mxtv3Bku
	Td+agq9tK1FJEIZq1tUY3T8LQQwaoeQc9UqeZIiSvLXChraD/oBGymPEnJ8foXwtfs4n
	fKxiwYLEobbQVTzUhIquHYfYQm95N9QM3HnY/6j7IRzerk7NtQWuVLmFvbXJY/3CJU21
	/soQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=agP0JAe/1SalvrM8Hz9cA86krK6jtIPxmLJeNcu7hUk=;
	b=ulAChGDwC+Mo18E08sNm/wXwLlc3rBHldRSgnFIL60zFxQO5tILYcynR7Z8K8sAkxz
	6EgXDitmT6TOGpFJAuX0yi9pOkMfcm6RqQckNEW6qSncE2D20MkAVgREyRdsn3xv6iyi
	1+7eDGDxIW1X6A2zyzYRevoo8lIT9C64XMaWP2DEIcnlUnc6IBQVwqvM728rxrGBU3kc
	ETp7dT5vWUUAfcLsFz3WGuAVWA71M9qdVD9Kg6twr5kXEaaxYadCXSQho7Mi1LR0RoUS
	+ey7M5f2vKWptLhM1A3yNWKFWqceK1JkCXScYnyH6lJxPnhgWQEAc0bnuRdmfjVx5POc
	7vqw==
X-Gm-Message-State: APjAAAVhOkZ+Xl4oJFZjvHrmCBbdimWncC3D4AAk82kZjKPjHVpHhBA9
	udHqj5ODLQUZy0HxqT5qK69EzQ==
X-Google-Smtp-Source: APXvYqw1kOOqeQdOAm73tBJLFHr0OokXjzQNUmCxMZNq/nluIrqDzvn4RiEa0e+nuCF9vf3O9Pwbfg==
X-Received: by 2002:a62:5915:: with SMTP id n21mr10019448pfb.180.1556568784979;
	Mon, 29 Apr 2019 13:13:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	j22sm18538187pfi.139.2019.04.29.13.13.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 13:13:04 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-3-richard.henderson@linaro.org>
	<CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
Date: Mon, 29 Apr 2019 13:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Message-ID: <20190429201259.ss3VUJuEUNm6ZtsWoeN4WoGjCUtfuX0A2aYSAUBaaoM@z>

On 4/29/19 9:21 AM, Peter Maydell wrote:
> This looks ok code-wise, but we'd need to hide it behind
> a defaults-to-off x-something property if we wanted to
> commit it before the kernel ABI is fixed.

I'm not intending to change the user-level abi, only the
internal abi within qemu, for handling of the elf notes.

You think this should be done differently, so that there's
zero possibility of a user-level setting the relevant bit?

> Do we also need to handle this in mprotect() ?

Not until there's a kernel abi.


r~

