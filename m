Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F55C04A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 01:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F879214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 01:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eL/zdR9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F879214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46219 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOYGU-0004sJ-9b
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 21:54:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOYFh-0004ai-EA
	for qemu-devel@nongnu.org; Wed, 08 May 2019 21:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOYFf-0004BC-Iz
	for qemu-devel@nongnu.org; Wed, 08 May 2019 21:53:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOYFe-00046M-Ip
	for qemu-devel@nongnu.org; Wed, 08 May 2019 21:53:39 -0400
Received: by mail-pf1-x441.google.com with SMTP id y11so392023pfm.13
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 18:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=FpDZJIMjRox1/8AqNpyrB7A6+dloBg3h1rFrIk9lbqc=;
	b=eL/zdR9ckeS62JZUcMaQEn7x65kPNGa7BBqe+XxIJroQ6x4j6wCKhrMtZeN3bUr7KK
	hEB1xrHIvUKnoWdR3DDk1HjnFdzNitvpnLSDDV/OcX1rCKFxHFEL3smxEKHZW6hhTfTt
	pzTK3uqtDDlzkJ4BUQO4+wPoQT/fD/rWGDT9ob9pbMXVcX/3VjsQpBT9MDWWvLL+2lZz
	g9C4rJ8BJHKI84Psv29WuDXMeddqc0pgnmE94j0XLSKSMkFpJWKefrkm/UCk22iEbyZn
	Nov5Hb6p1maBTUExDHF1lCXNvdWDMt9BidDhqkuFoqIS8i9I4F20ALTiyQuCB6f3XCDr
	4nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FpDZJIMjRox1/8AqNpyrB7A6+dloBg3h1rFrIk9lbqc=;
	b=JgIH7Er4yaABVQh82I2/wMUlLxGbKIW4YtqN3yKYZiT0qyAnz+xI8aIVShoUXtN71g
	3vCgYJ7ia7hkpo71xbWIEwHqQWwI6lue/uCnt+eFLtWEriJJSQAc/8VcjXk4sLS0ckPN
	pSkpGImKcfDiqtenSxljXu5SMSw1Wf3bAP3FVJSk/Z8UUQKsq65cU6NwyYzvMAM96UDp
	o2MYyA4h+AWo8xFwzF5mZixexBoTiLPlPTULRjNK4ZqwFmjS4H4knYkq+kICfJwYt7v5
	DVxqD3k5X1uO0r857ubKJDItyeRVvePgmaDNplFeSZ1no5XGL8a0CoGQjEoEYP/zPgJN
	fBxw==
X-Gm-Message-State: APjAAAXUjVkYj9WiPKJEVoXQ8fLw+KNbJgW4FS+pb7QdtxUJzQJZxlHA
	nbgN4ZejlyYUBaMoq1jtw5SmQg==
X-Google-Smtp-Source: APXvYqxkxYOhtnnT8P9BpFOZmmGTEEXdCGPI3VuHuwN5rJJtmUp0jg0rewZIadeqDocX6n7owdfr3A==
X-Received: by 2002:a63:d908:: with SMTP id r8mr2042950pgg.268.1557366816303; 
	Wed, 08 May 2019 18:53:36 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	q87sm638013pfa.133.2019.05.08.18.53.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 18:53:35 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-18-richard.henderson@linaro.org>
	<fbf79534-7e95-6999-ecd3-f142086c349a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0cb3646b-30c3-7dd3-6729-40a4c4e87ed1@linaro.org>
Date: Wed, 8 May 2019 18:53:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fbf79534-7e95-6999-ecd3-f142086c349a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 17/26] target/s390x: Convert to
 CPUClass::tlb_fill
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/19 4:17 AM, David Hildenbrand wrote:
>> +    /*
>> +     * Note that handle_mmu_fault sets ilen to either 2 (for code)
> This comment no longer matches.
> 
>> +     * or AUTO (for data).  We can resolve AUTO now, as if it was
>> +     * set to UNWIND -- that will have been done via assignment
>> +     * in cpu_restore_state.  Otherwise re-examine access_type.
>> +     */
>> +    if (access_type == MMU_INST_FETCH) {
>> +        CPUS390XState *env = cs->env_ptr;
>> +        env->int_pgm_ilen = 2;
>> +    }

Indeed it doesn't.  It's also confusingly written.
I've tried again as

    /*
     * The ILC value for code accesses is undefined.  The important
     * thing here is to *not* leave env->int_pgm_ilen set to ILEN_AUTO,
     * which would cause do_program_interrupt to attempt to read from
     * env->psw.addr again.  C.f. the condition in trigger_page_fault,
     * but is not universally applied.
     *
     * ??? If we remove ILEN_AUTO, by moving the computation of ILEN
     * into cpu_restore_state, then we may remove this entirely.
     */
    if (access_type == MMU_INST_FETCH) {
        env->int_pgm_ilen = 2;
    }

I'll just note in passing that the ??? part of the comment alludes to

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00063.html

to which I ought to return at some point.


r~

