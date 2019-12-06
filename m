Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3D0C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BD824670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9mqd38r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BD824670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idITk-0003vv-5q
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idISU-0002by-Tn
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idIST-0006UY-FS
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:36:06 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idIST-0006QD-5h
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:36:05 -0500
Received: by mail-pg1-x544.google.com with SMTP id a33so3507423pgm.5
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d26W7hIJfJjg6MlaLQPVSD5Z6ad9XXJVgQu50dLjWug=;
 b=T9mqd38rbQ10jHo5p3I+pEh3g29Pw/gFflqiFu7eHelAoUZYJ7rFmBQPq97Od0mtnz
 HfQuHkQt2nU4G5fXdBVKoGJo2UtaG2xHfj8Tt8X6ck7zNcpnm5g0V3qw/z2mRocAvLkh
 OolzwLi3mM3kozMwp3ADeqRf+eLSXFxffAt0BlK1DxYNX8957S8b6p9QAhkGQp5O9vCo
 zNtDjDqJuAyz1B0OAVGinCGTcsIiiQwDkayEyFC9FmQ0lyoYhtytAlfZRZRt7k3nShBY
 qqpT5DmFAkPqRA5zuhpliMlH/Fe0iBtVeNtxkP5+l88SOTSOw2JZNIJFC+JER+UKZlin
 3R7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d26W7hIJfJjg6MlaLQPVSD5Z6ad9XXJVgQu50dLjWug=;
 b=m2OynZYfvuUxTO3CpTihLyYRT+GmLxVlKxq+LmqI9gKP9n2kZFGkflADFHPoeuU9T3
 w8t2FQ8VF8HmbQ5wEd7BiR8wG4+bD3yaR22BEvstJ5rl7eKbppoisMyrt3r+Wd6dT/h/
 cxrOO6Rbi4hkAMhyiluUROhy3oY3T7QkHg0WBC/Qo7YRToZmfD0yCrufRih0YOEWxQyE
 +/iskYdN3ii4U5KX3jfqbnkLgPZnm5rbtgAz3OdxC/wlnAkgiAI8L46MguOvxwbXZjCI
 PsK8Mpm62FcYLliC1BoXxBIyFuLp/tE2ifh6IbmxSITcI+mcNz8tgkjGhDYonKY9mfEe
 ed+g==
X-Gm-Message-State: APjAAAVYQGPajrlL+M/vBW6MMBAR815cyzfK4uC+LYGRqNjopNe+ga08
 PW2Tx306VlC6B6lZnbE6GVTUzw==
X-Google-Smtp-Source: APXvYqxxT1CD7JIjnPXg4DonURkZUQ2ww8/lUE5pbYbpVyyMkjHZl31h0bCLTEXMi3LLJoFv7a/S6A==
X-Received: by 2002:a63:e0f:: with SMTP id d15mr5006441pgl.255.1575657363838; 
 Fri, 06 Dec 2019 10:36:03 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h5sm4030412pjc.9.2019.12.06.10.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 10:36:03 -0800 (PST)
Subject: Re: [PATCH v4 27/40] target/arm: Add VHE system register redirection
 and aliasing
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-28-richard.henderson@linaro.org>
 <CAFEAcA8taFKOtz0pM-N3KRiQrguh43SNLSM__ZJH5xzVK5YkZg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef270139-bca6-e7d9-57b8-b5a7416bbb56@linaro.org>
Date: Fri, 6 Dec 2019 10:36:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8taFKOtz0pM-N3KRiQrguh43SNLSM__ZJH5xzVK5YkZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 9:24 AM, Peter Maydell wrote:
>> +    union {
>> +        /*
>> +         * Offsets of the secure and non-secure fields in CPUARMState for
>> +         * the register if it is banked.  These fields are only used during
>> +         * the static registration of a register.  During hashing the bank
>> +         * associated with a given security state is copied to fieldoffset
>> +         * which is used from there on out.
>> +         *
>> +         * It is expected that register definitions use either fieldoffset
>> +         * or bank_fieldoffsets in the definition but not both.  It is also
>> +         * expected that both bank offsets are set when defining a banked
>> +         * register.  This use indicates that a register is banked.
>> +         */
>> +        ptrdiff_t bank_fieldoffsets[2];
>> +
>> +        /*
>> +         * "Original" writefn and readfn.
>> +         * For ARMv8.1-VHE register aliases, we overwrite the read/write
>> +         * accessor functions of various EL1/EL0 to perform the runtime
>> +         * check for which sysreg should actually be modified, and then
>> +         * forwards the operation.  Before overwriting the accessors,
>> +         * the original function is copied here, so that accesses that
>> +         * really do go to the EL1/EL0 version proceed normally.
>> +         * (The corresponding EL2 register is linked via opaque.)
>> +         */
>> +        struct {
>> +            CPReadFn *orig_readfn;
>> +            CPWriteFn *orig_writefn;
>> +        };
> 
> Does this really need to be a union ? It's not clear to me
> why we know the two halves of it are never used at the same time.

We don't really need to use a union.  I should probably change that.  I think
AJB had the same question vs one of the previous revisions.

We know they're not used at the same time because bank_fieldoffsets is only
used *before* the structure is duplicated and added into the hash table
(overwriting .fieldoffset depending on the bank as they are duplicated), and
orig_{read,write}fn are only used *after* the structure has been added to the
hash table.

>> +static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
>> +                          uint64_t value)
>> +{
>> +    CPWriteFn *writefn;
>> +
>> +    if (redirect_for_e2h(env)) {
>> +        /* Switch to the saved EL2 version of the register.  */
>> +        ri = ri->opaque;
>> +        writefn = ri->writefn;
>> +    } else {
>> +        writefn = ri->orig_writefn;
>> +    }
>> +    if (writefn == NULL) {
>> +        writefn = raw_write;
>> +    }
>> +    writefn(env, ri, value);
>> +}
> 
> I see how this works when we have a readfn or writefn,
> but how does the redirection work where the access
> goes directly via .fieldoffset ?

When there is no .writefn, we use raw_write, which uses fieldoffset.


r~

