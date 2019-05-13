Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07CC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599E72084E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOrrFFKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599E72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQE16-00063x-Id
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 12:41:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQE0C-0005d2-30
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:40:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQE0B-0006yQ-4i
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:40:36 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQE0A-0006xN-TQ
	for qemu-devel@nongnu.org; Mon, 13 May 2019 12:40:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id z3so7044549pgp.8
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=9emRe7+SQWHfpiOONHat52ULNuh6E+wMqmRqVatJvPg=;
	b=jOrrFFKVbrFhFs9mhivPp/tHHCJPMqi7iJ/yk+u+YInvHU0ZTLiKoDbE55rHelZHUP
	mH3V/2me9vDUytT0DCABn1oeyNZ3rrAPj0i+g4kRqiz+jj+TBugiR6QSBv9TLOsHzFRU
	cCUX6Y1HluAbzShlsLkNAZZcV+YExMLUh3LcZzS0Buw8zSJREZPfqElkDWHtbcinSLPu
	zo53Yu8icM3cdD1TNoBcJwa2khCWFkV8TM2JuED0ngSBlmuPJA3o42yRetVyNiUKUo9/
	FgEbEXVdcfoi4x4u7/W/2NZuDB7jG8rnnxYrWsVIvSDvTOFPwEu1RuOHPZkEiIA+a0XU
	B3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9emRe7+SQWHfpiOONHat52ULNuh6E+wMqmRqVatJvPg=;
	b=J4oHdcrs1EBu+8e3IjcSCauB6u7htfgUfBBO69tSE8PH1GR3jxwyggA27ewCTwrCch
	gNxPBiEn7fcz3lw+9oAnZdb0PjB18tpBuu7jjLqhdUQ1H301V24EE0nhmUb0+ZqzYZBK
	fBAKUzWvq2eavBrTbq5HbugcDvT4IEArsK230/5Ty80lh2evIY1GbdZfWEV7Ko1R4+Yi
	eo6CScrg3J5S8eLfFO8qZEpq4VoDt8qmNJsmOkg8pnGHMlyc8GJ+zLcAMOlul0CjTy8q
	bWnV1iGouQBqzgcGSr+INuZ9PFfNtY31UO90Yfb9DIetgCYtBJGqJbZ+bGjb7FHoUxgd
	GZZA==
X-Gm-Message-State: APjAAAVG4d9eueGgClDjbn36EsnNyA1ja4MwbElGrKtYgfpCfRgZTNL6
	cznp1vgbgOnR27h9G+kYNWYD1g==
X-Google-Smtp-Source: APXvYqxJyB2o2w7xR7AQfxdrxQnvD5Mf72IuIvvADwPnOKN/uXcJxStjd3ufP7T6U2ARb5Ghbzl1Ng==
X-Received: by 2002:a63:90c7:: with SMTP id a190mr33206956pge.23.1557765632636;
	Mon, 13 May 2019 09:40:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	17sm21449966pfw.65.2019.05.13.09.40.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 09:40:31 -0700 (PDT)
To: Dave Martin <Dave.Martin@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513123110.GE28398@e103592.cambridge.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e35ba07e-2844-fe2d-ca4a-0f795a1485b1@linaro.org>
Date: Mon, 13 May 2019 09:40:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513123110.GE28398@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 05/13] target/arm/kvm: Add
 kvm_arch_get/put_sve
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 5:31 AM, Dave Martin wrote:
> On Sun, May 12, 2019 at 09:36:16AM +0100, Andrew Jones wrote:
>> These are the SVE equivalents to kvm_arch_get/put_fpsimd.
>>
>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>> ---
>>  target/arm/kvm64.c | 127 +++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 123 insertions(+), 4 deletions(-)
> 
> [...]
> 
>> +static int kvm_arch_put_sve(CPUState *cs)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(cs);
>> +    CPUARMState *env = &cpu->env;
>> +    struct kvm_one_reg reg;
>> +    int n, ret;
>> +
>> +    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; n++) {
>> +        uint64_t *q = aa64_vfp_qreg(env, n);
>> +#ifdef HOST_WORDS_BIGENDIAN
>> +        uint64_t d[ARM_MAX_VQ * 2];
>> +        int i;
>> +        for (i = 0; i < cpu->sve_max_vq * 2; i++) {
>> +            d[i] = q[cpu->sve_max_vq * 2 - 1 - i];
>> +        }
> 
> Out of interest, why do all this swabbing?  It seems expensive.

Indeed, to me this seems to be the wrong kind of swabbing here.  Exactly what
format is KVM expecting?  Surely it should be the one used by the unpredicated
LDR/STR instructions.  Anything else would seem to be working against the
architecture.

If so, the format is, architecturally, a stream of bytes in index order, which
corresponds to a little-endian stream of words.  So the loop I'd expect to see
here is

    for (i = 0, n = cpu->sve_max_vq; i < n; ++i) {
        d[i] = bswap64(q[i]);
    }


r~

