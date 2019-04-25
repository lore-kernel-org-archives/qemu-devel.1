Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F41C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 05:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A122217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 05:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyQIYV4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A122217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJWll-0000MS-8N
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 01:18:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJWkq-0008SI-R3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJWkp-0005yj-VA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:17:04 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:46406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJWkp-0005wS-OE
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 01:17:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id 9so10494284pfj.13
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 22:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ZKURaLeNgBOzj1amxwM2BTMUcr6ImtlWOy5zQpEOH0c=;
	b=iyQIYV4s+s6ebjTYDE4bB1+J4uKJ8yG7vsTPatoMYioMTXRfkbEmfWG+KaM7fT2ljc
	pB2ICHRzyIDjzQfBPASvExqd9NJ7zO9+iubb+BnSs6zuNorzRix/nH41ZnblWVkkNCqu
	SgbSDcbLRidX77othLz160BA6B0JhVslIKMHfVJuJGcbJ2qzf8SYS6oHOWhorKOMatjS
	YC6TAd7euMCnK7Jbcs53ixck4wdrUje2Lpjj7gMs5ue5MB3Mi0HxWH4bolnSRoiYwEpR
	JvHQrfrZ10ZDED/kB2nOzcr8LLiRuxtF/5Evw2rK45+SVQVwZHlIeXuhS6AFF1slZ5ep
	l9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZKURaLeNgBOzj1amxwM2BTMUcr6ImtlWOy5zQpEOH0c=;
	b=M8wnkkJP9hVFHN4DuD/Lsh56rnRUgr3WuS3M/obVB+qbUxNTFjCzgGMuCFBaJ1k2i9
	WH9vMj+CvXOah8dzNovDafvHkXCIyrlvEo4I1UF/VBAYXnZRERFZHdGGJwl/8z9HF/C3
	fKLivvPRhq1fhA5TyjqE4g8DZ3/wQ+PdcFSAyfFYimliAvR1BIdnL1riR2CikfAte2jS
	dYLpKQGh8lBHbqf4mx0osw+YtdIMtSZDaZN3Y1Yoy/uplKecctrQo9XrPeEwE2Etuyrn
	2UnRMsGfT1nPyn+r3yGTFFlEEcj8qyUoeiGTRKSccOCOwelxDXSLCjnNVapCLQ4DITQQ
	rNBQ==
X-Gm-Message-State: APjAAAVav9Avmho0UJ1WUQCxUKMlFlNxN2/aHTkMJ4nuVU9W0TOp20FF
	doYFRikfDUg8Ps5fAza7Ql/ldQ==
X-Google-Smtp-Source: APXvYqw5Nj5S+jR+gmWfTdpR5uaqFlMAudKh4G6KPj8Q4MHxeaazDHk5e+SGFj4Z4fmiSoIfZF03kA==
X-Received: by 2002:a63:7d03:: with SMTP id y3mr33776591pgc.8.1556169421522;
	Wed, 24 Apr 2019 22:17:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	j67sm42895171pfc.72.2019.04.24.22.17.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 22:17:00 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <mhng-4fc40e41-5464-469e-9334-1edc4f8294e3@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <73a7ce8a-1d73-95f7-84a6-f0960a397c22@linaro.org>
Date: Wed, 24 Apr 2019 22:16:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-4fc40e41-5464-469e-9334-1edc4f8294e3@palmer-si-x1e>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::430
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/8] target/riscv: Name the
 argument sets for all of insn32 formats
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425051658.aHsEDgEHOAx1Az6PoupxhwQ5PJX2L7-y0rmADKdAPgM@z>

On 4/24/19 8:31 PM, Palmer Dabbelt wrote:
>>  # Argument sets:
>> +&empty
> 
> If I understand decodetree correctly, this isn't used until patch 5.
> Otherwise,
> 

I think it's used as early as patch 3, but I haven't looked in detail to be sure.


r~

