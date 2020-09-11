Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85A0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1485A2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wb6qvGAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1485A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmMP-00077Z-0M
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 12:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGmLK-0006dt-8z
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:56:10 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGmLF-0004QB-0H
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 12:56:09 -0400
Received: by mail-pg1-x542.google.com with SMTP id 34so7036575pgo.13
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mf6Y+QtinNuhqMxIoYaU/jIfaaDnMrYpAcDwSlwHGLY=;
 b=wb6qvGAmIoGXKwZzJfyJ0I03hVlCqbMsPSAPzyYpE43F1y7CkJE1zGlHgSVZwCFYux
 52UaXdqvC0bkdF01Fn/HyxiKBqDc7TiOQspgICZxDJrJuLborxw+kKAiUZxUPmRrFUmJ
 hwMcTXsDlFcQfSuAaUntOFU0JaapYTwWtP0Q/co3yZQ5QJVKv8lhRX5sY2GIEURHqWg9
 nSFZY/2rwuzEY/SC82YaFCZehXH9Pu/eMtM1Udn0v00q1KDhWl7LpXT76vaCTvZIp6fr
 cXa3xD6GfLSTX7wL1EiHyujo98sTcbCOSRlgpXYrnqgJaYoyJ+OSMM9i0o3GG6YqvVLC
 +iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mf6Y+QtinNuhqMxIoYaU/jIfaaDnMrYpAcDwSlwHGLY=;
 b=J0+bEAB+fhsqGVSC378G3RrarmGJx9eiFulujSzL2rkW+RX5PWoaA7Cxqp6V7vQ8v+
 nlegIQ7P1An30G7kdLOB0pSFDpv31MTV8iyQ73hwtECf7axUe5kjJfysgvfqlIUR6beu
 fI+jJv9OeKxauCtQ+iuTsy7fLeOkXvKviVjE4W3Tvz6v0UTzG6Rq1gmO/w2srtl6Z5Be
 +vSUuRKjArwS9Keh4vj9yCVUQ4XeKhyM50nyKGTG2HdVSQGR5+NaW903tYVO0xIl0Yf2
 2Pz3zao9OZCebjwZTcDLkX+w+9tM2k1pU7owPjT2yR+CwL2SYcRcGDT5wOmCfvrkuT2N
 oGbA==
X-Gm-Message-State: AOAM530iEojv/r3eRdgp47PSEsMyknzZu+18USr70sdOSrYH7PcPp+ue
 eGO0BEd3yOscQHMnBK8iTDzro7aF3kHUEQ==
X-Google-Smtp-Source: ABdhPJy9gZt5R5HbZ3XXw4roNDJWoVxqCa62sxOCvyIsgPCmklXZF/lEc52ZUV4M5mkKU1i1DtMunQ==
X-Received: by 2002:a65:66c6:: with SMTP id c6mr2350449pgw.206.1599843362366; 
 Fri, 11 Sep 2020 09:56:02 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm2852778pfi.38.2020.09.11.09.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 09:56:01 -0700 (PDT)
Subject: Re: [PATCH 1/1] accel/tcg/user-exec: support computing is_write for
 mips32
To: Peter Maydell <peter.maydell@linaro.org>, zou xu <iwatchnima@gmail.com>
References: <CA+Lzsy=o9yshAAAacuTwcs3Hfr4MfWiX-SiUf5A2Fds3vGOrAQ@mail.gmail.com>
 <CAFEAcA9ap=c=1XZ6wpphiE=FYtCU+vdNCX8THW-m-hUp_XyGmg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b384912c-0e62-604d-df0b-b5181c2e7f3d@linaro.org>
Date: Fri, 11 Sep 2020 09:55:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ap=c=1XZ6wpphiE=FYtCU+vdNCX8THW-m-hUp_XyGmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 3:41 AM, Peter Maydell wrote:
>> +    /* Detect store by reading the instruction at the program counter. */
>> +    uint32_t insn = *(uint32_t *)pc;
>> +    switch(insn>>29) {
>> +    case 0x5:
>> +        switch((insn>>26) & 0x7) {
> 
> Here we mask to get a 3-bit field...
> 
>> +        case 0x0: /* SB */
>> +        case 0x1: /* SH */
>> +        case 0x2: /* SWL */
>> +        case 0x3: /* SW */
>> +        case 0x4: /* SDL */
>> +        case 0x5: /* SDR */
>> +        case 0x6: /* SWR */
>> +        case 0x7: /* CACHE */
>> +            is_write = 1;
> 
> ...but here all 8 cases are handled identically.
> Is there a typo/logic error here, or should this
> really just be
> 
>     case 0x5:
>         /* SB, SH, SWL, SW, SDL, SDR, SWR, CACHE */
>         is_write = 1;
> 
> ?
> 
> Is CACHE really a write insn ?

Indeed not.  However, it's also illegal for user-mode, so we cannot arrive here
with SIGSEGV by executing it.  So we could ignore that case and not decode this
field.

>> +    case 0x7:
>> +        switch((insn>>26) & 0x7) {
>> +        case 0x0: /* SC */
>> +        case 0x1: /* SWC1 */
>> +        case 0x2: /* SWC2 */
>> +        case 0x4: /* SCD */
>> +        case 0x5: /* SDC1 */
>> +        case 0x6: /* SDC2 */
>> +        case 0x7: /* SD */
>> +            is_write = 1;

Well, the unconditional check of SWC2/SDC2 is not quite right. MIPS64R6 removes
them and replaces them with some compact branches.  That's easy enough to
include here, using

#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
    case 2: /* SWC2 */
    case 6: /* SDC2 */
#endif

We should also add

#if defined(__mips16) || defined(__mips_micromips)
# error "Unsupported encoding"
#endif

I see no upstream compiler support for nanomips at all, so there's no point in
checking for that encoding.  (Indeed, I wonder at the code in target/mips...
how could it be tested?)


r~

