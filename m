Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A04C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED43A2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQ2EBCl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED43A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhH3p-0003Ux-8a
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhH3I-0002sF-Fg
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:26:48 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:33288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhH3E-0006jC-O7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:26:47 -0400
Received: by mail-pg1-x52a.google.com with SMTP id s10so5625152pgm.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SYrJs/+//Wu4pD9zHLzYZFtCspDQ7FpiocKVhzp8yUw=;
 b=oQ2EBCl29w09hl7GZAkFrdCizgQ7z/oqnl9nszfY3xq9wFjyH6g/EPEdMvov1QENOT
 v8zyBOLSckkW6pXPwBQX1o/F9bTOblCtmUzwPEovilWJCRMWoQdOr2dh/OPS0VmD5IS3
 eaLKDeoOYERwd2T7ODE3nfJ6B7Te8vy44zWraSGP9uw5UHtfPVa/ybHy8QRN4JKKEqEp
 yBI84W/gMoj/sjt8EM6meZ8rZU+c786blHvJD7MTiAYCvOOBSyQlW5s66p1KQSmgJ/Jm
 vuiqit1yTJW/EwasslIgPZzzI7poyAFrl3NNToIrQGOYt/SXpHAgl/IQ+KCHnJ7icX7n
 KaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SYrJs/+//Wu4pD9zHLzYZFtCspDQ7FpiocKVhzp8yUw=;
 b=GS9Z19/5lETWSNG/OrUNEqGkcosfAQ1XdsFKKPbQA+gdSfzb3iJ/f7cxhHUhTXHupl
 OMBNAlZrc6x3P6OJ2ULPm9bnX0pyIcVjQ8T3kMk1iTMxZUVnzGXjDXpAZ09dDuMFlGnp
 c58vtG1/FIjQPgPq3BLYFBTUVXuCewBe9AQYVEIf27zEGZ//3B6vbLVRxlBefHl1mpBj
 FWrPnPYTFoa9lZZksJTBHr8/0r5xL4Iztv+B0MAxWjKfwbEdBZ5RVNTpjSBqGzu8cXiz
 HburqIuVh+1QZwsjvNNbq57XJnu8EvEKnzj+5Dor+bMaTMNcxQ1+yd6i74bBoeJrcl7k
 w4jg==
X-Gm-Message-State: AOAM5322O94of2+td0UrbHb6LVzMbkrCoba1RSHQJc1PDe9clWDXUIiK
 hv9kmRRK/1xkIDWD3AnQUzSnN9Peb8U=
X-Google-Smtp-Source: ABdhPJw3UrWqgw2MiGux1UYlx93VO+S3EzBePmyZy/Eaxlo3GzIulLRcWS8vfy7F5g4s+eOoam6taA==
X-Received: by 2002:a62:7a4a:: with SMTP id v71mr11296649pfc.35.1591381602951; 
 Fri, 05 Jun 2020 11:26:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h3sm210993pgk.67.2020.06.05.11.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 11:26:42 -0700 (PDT)
Subject: Re: [PULL v2 05/13] accel/tcg: Relax va restrictions on 64-bit guests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
 <20200515144405.20580-6-alex.bennee@linaro.org>
 <843d72a9-22a7-b0b5-0a92-edf1dcd290d2@vivier.eu> <87zh9i4u1f.fsf@linaro.org>
 <87h7vp4n6w.fsf@linaro.org>
 <f8c9afba-4c7c-a410-f42c-c63aa2128ef6@twiddle.net>
 <8736794d8p.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa425ea9-e6da-79bf-310c-b976d48732ea@linaro.org>
Date: Fri, 5 Jun 2020 11:26:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8736794d8p.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 10:46 AM, Alex Bennée wrote:
> 
> Richard Henderson <rth@twiddle.net> writes:
> 
>> On 6/5/20 7:11 AM, Alex Bennée wrote:
>>> @@ -467,7 +467,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>>>           * It can fail only on 64-bit host with 32-bit target.
>>>           * On any other target/host host mmap() handles this error correctly.
>>>           */
>>> -        if (!guest_range_valid(start, len)) {
>>> +        if (end < start || !guest_range_valid(start, len)) {
>>>              errno = ENOMEM;
>>>              goto fail;
>>>          }
>>
>> Interesting.  I was adjusting guest_range_valid tagged pointers yesterday, and
>> thought that it looked buggy.
> 
> Should be picking this up in guest_range_valid?

I think so.  How can a range really be considered valid if it wraps?


r~

