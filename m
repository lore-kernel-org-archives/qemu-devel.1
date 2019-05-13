Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF8C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB62E208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaDXf4i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB62E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQFlk-0006a8-4e
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 14:33:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQFjY-0005Ky-3i
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQFjX-0001mW-67
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:31:32 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:46139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQFjW-0001ld-SI
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:31:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id y11so7623448pfm.13
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=xb2WBROopJ6wexUXZZHUN0JJtLxExXrH+yhRAr3GUuY=;
	b=UaDXf4i1tJOOAPIbuzmFrK3xERze9I6dyyuNScD5+M+7gdvI3/WOIc259lt+4+/8C4
	vDtA3HHzv+SaFE3qe5JVNiTg3FI6LLNjLHuJxh3GPeLRuZ4AaXxxnAsqbTcgCZHCPNKn
	/b5NZyp6+0upv9akWf4cRH/kBAW0tSsXwnRIAHadhUVNQmrxORD8j5pQKUJofgMS7yVt
	OSSANfZm87Crg5Mv6DFcYtfR8rJaGJRLLKW87eV7eScGYGQEVH+JGSTwQkJ8z4mmVgj8
	JlwFUv+NDIC8nww0paFKkoyqJ+OAuX+YKd4iniY+2y7bYQl0/UAoiY80Z33gMiwtdPS7
	D5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xb2WBROopJ6wexUXZZHUN0JJtLxExXrH+yhRAr3GUuY=;
	b=bLDvx6UZgxTAXztGiP2HNQ8viJaVtiI8ayIeuQc4++noE9RuUYFf/TPykSmQsK+AkL
	b1aGS1n2dbCqnmaQ4eqTlGTrmYc+ax9C2k1P0qUSSNbjMDr+qbH0wHZMjf1uydHDih5u
	jHWajHiANdBv0AKkI8eQQVTR09Iy8g+zymbjN8XIRmPlFH9rOUtni+RfImbMGgXtyFtD
	8wxMZrG4Prc7huVBM05ssnJRuoIPr4vTGj1EruxdPJ0My3blf0CqGMJkP0sv9uzT7dhM
	FSmREUAk4FDcCzHCXIwSyfRRo9bFllM1I8iHoewDfIJWBnkGGBfdZN80+KQAjVpO4ij7
	uOgA==
X-Gm-Message-State: APjAAAUoN9OvGDb2lpOuHlzrFJY6Mmxkvl2zTCC+hpzVxA/c08gzWvwC
	pYvhmXPU7wYq3TRk16DqpT0qgw==
X-Google-Smtp-Source: APXvYqxwpzIvhEdABMcaogDbt70BjGIJn8JMPJPOxYazEhMtn5w4y7bLMqA9B0aiKBBPUbdw4U7BPA==
X-Received: by 2002:a62:5ec2:: with SMTP id s185mr36494250pfb.16.1557772289275;
	Mon, 13 May 2019 11:31:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	n27sm24000524pfb.129.2019.05.13.11.31.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 11:31:28 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-6-drjones@redhat.com>
	<20190513123110.GE28398@e103592.cambridge.arm.com>
	<e35ba07e-2844-fe2d-ca4a-0f795a1485b1@linaro.org>
	<20190513181421.g25e2zqlkks7ntxb@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9ac95348-54c0-3213-e971-959136241ac7@linaro.org>
Date: Mon, 13 May 2019 11:31:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513181421.g25e2zqlkks7ntxb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42c
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
	"armbru@redhat.com" <armbru@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"abologna@redhat.com" <abologna@redhat.com>,
	"alex.bennee@linaro.org" <alex.bennee@linaro.org>,
	Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 11:14 AM, Andrew Jones wrote:
>> Indeed, to me this seems to be the wrong kind of swabbing here.  Exactly what
>> format is KVM expecting?  Surely it should be the one used by the unpredicated
>> LDR/STR instructions.  Anything else would seem to be working against the
>> architecture.
>>
>> If so, the format is, architecturally, a stream of bytes in index order, which
>> corresponds to a little-endian stream of words.  So the loop I'd expect to see
>> here is
>>
>>     for (i = 0, n = cpu->sve_max_vq; i < n; ++i) {
>>         d[i] = bswap64(q[i]);
>>     }
> 
> That's the opposite of what we do for fpsimd registers though. I'm
> fine with doing whatever KVM/TCG needs, but so far I was just following
> the same pattern we already have.

The behaviour of the hardware is different for LDR of fpsimd registers.

FP&SIMD LDR operates on datasize (8, 16, 32, 64, 128 bits).
SVE LDR always operates on bytes.


r~

