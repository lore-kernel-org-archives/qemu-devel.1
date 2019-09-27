Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2783FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EBE20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PP3nc+RW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EBE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDuS7-0000s1-VZ
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuR0-0008Le-BR
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuQy-00079E-UX
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:53:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDuQy-00077c-Fd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:53:36 -0400
Received: by mail-pf1-x443.google.com with SMTP id q5so1982745pfg.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mtqj6XjR77FGB/2lmnWGkD6fBdEnoZDtg9W++umi9WM=;
 b=PP3nc+RWhFnhezJV3IGo2lKvdbWw0SIdPhto3AC1hnW6wGUq9gP/nUnAHM51BF8Pxv
 Iye4Xt+dfDOzyvnOx+IS9fF35Kcvk9pXQUXeCmRmergG9mh6xO1wZv9nhybMmx4xcICU
 4x1nf0Ih8WQbFhdm2RLsD2v9ckdm3BkD40e6oN6yuqMwOGoJB9xa4yTXRE3G4ptfCd44
 I/g+68H5vq6/VG0cJAE8j6RAN5RftMLvjbDavF8u8OPnRACajky0iWMrgHOVaERzHjB1
 FR+9F5azMa0wVVdbqbmnwIs8xT/fw22vKoCqv3CFvm3r1S/lGYZwYggiTklg9WBQU+V9
 Uh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mtqj6XjR77FGB/2lmnWGkD6fBdEnoZDtg9W++umi9WM=;
 b=LVlnsiEtROE48le8zSQjDF0gptmiLw4efgCE7YaI2mN+vcPqSkzsYF2x5QuXd3X2i3
 DtdZc+mjkcuH0wJj22CsIZatN6rCDa9J4UvrsV6nH5+UgYVi5ijSMkXIhoPS9xnKmGkV
 JonrPZ+UIAZJcUma7zQ7qbFxU6Eqx8PBiF8XdIYGlCJKwwOErolAAFjnGSv9w+Yv9L7R
 C9FBp+5GvFegVdNWA1XAEhCPvSykcII3htbM6ZVezq7tIihSjDwvYBhoSfPPIBTqr27t
 DkyOvAxMead3ZOge2+/ajV8hmG17QpyEtzA8YhILivR990l30++3Lgfk6Royucsjqulz
 AY8Q==
X-Gm-Message-State: APjAAAUVM4EKLxXLx9BDTyYhr7/nzR/ZqbwH0fulqT/gpAmPr1GSYuW/
 y2dh+cGNmZZ9Es6zlRxIRSFvng==
X-Google-Smtp-Source: APXvYqyp5pWxRwDIHkdiZwskJdsI3b7BpiqwKwZ9Tfl6WTsT49pDaTKkRNzC79fNOqheVQNM/2y5LQ==
X-Received: by 2002:a17:90a:6c90:: with SMTP id
 y16mr11884264pjj.58.1569606814892; 
 Fri, 27 Sep 2019 10:53:34 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id b69sm3357794pfb.132.2019.09.27.10.53.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 10:53:34 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] target/riscv: Print CPU and privledge in disas
To: Alistair Francis <alistair23@gmail.com>
References: <ab8f108eceb973aaee565bb1fe347fcf8c788f5b.1569545120.git.alistair.francis@wdc.com>
 <960d9622-8241-efe7-cee6-1d4a1307fbc0@linaro.org>
 <CAKmqyKP90UDcS4moAYvLVN2q+aZ_cqGwY2fEgfX8dCjsHW1Tfg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8248daee-d5d0-0576-ee89-bd1400ddf947@linaro.org>
Date: Fri, 27 Sep 2019 10:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP90UDcS4moAYvLVN2q+aZ_cqGwY2fEgfX8dCjsHW1Tfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 10:23 AM, Alistair Francis wrote:
>> I'm curious about the motivation here.
>>
>> In particular, what difference does it make what cpu the TB is generated for?
>> It would seem like the more relevant place to look for this is with -d cpu or
>> -d exec where the TB is actually executed, which could well be multiple cpus.
> 
> The main reason is that the sifive_u machine now has two RISC-V
> clusters so it's useful to see what is happening on each CPU. -d cpu
> and -d exec are much more difficult to comprehend so aren't always as
> useful.

Hmm.  I wonder if it might be time to find a way to be able to optionally split
the qemu_log output on a per-cpu basis.  It wouldn't necessarily always be
helpful, because we'd still have the case of a given TB being translated by one
cpu and executed on another, but it could make some things easier to follow.


r~

