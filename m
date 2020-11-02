Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ED3C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4074820706
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJcyFPuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4074820706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWtr-0003Ne-7M
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZWdO-0007nL-Uw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:00:19 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZWdK-0002C8-Qj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:00:16 -0500
Received: by mail-wr1-x441.google.com with SMTP id g12so13788687wrp.10
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VXcdbHryCKfOmvF7bPo+U2fnt8UIY92DQGOuPw5QX3E=;
 b=NJcyFPuF1K8skzHuVL3dPxPgSkaDZk+Jw/IrqEwJeY6aVU2lO6Y8/tP8XEishTM8m3
 QqXY45LRVVc4N/J7gsfCY8Kmp9Zi0JJaevnNAA4cDncD+YOW1Z1klPbmyQ8kxogAxtPj
 kzJRGqc6e1ogPcpitD4G8RQ+3u7A3Vl5Ogpy/KsEV9Wk/XWXbG04I7GFnq5gbeEYwbAG
 Cvk1sUfutULb1StUApqUVgkjSzWASPpqhgsi7MaZIjbvUJLQfBFbTLFyf/QQpgPBf9q0
 GLvydCjlZ5g4dgjgjE9xcsCWxpMHFe1NDD8I4S9beci50yLsFpTtAIb9SLRrdR9nLx/5
 ARHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VXcdbHryCKfOmvF7bPo+U2fnt8UIY92DQGOuPw5QX3E=;
 b=UU2Rh6pJurLkfkTywb/paE/9nVHtAXEH+gRTw6TSUkGJLMUN1KU7Zvcxozlt41nBjX
 ioa5AunGJf22AawVdveMGw3r/BGZvLB4gnFyRQNq9vXFwXJ2EoKKhJfbwJBOn/ASj9z1
 OVWqPaHSsIDIT79kY+Fi+JRnEAzoIWC4xx1bRjX9nrUFRk3CfN9ySLxvW/LdnVXmhPJX
 WCKKWhf2Pz63Pb3VOA0Cnccn3NBbzdHDUwBgiLiEprRsEF4i2Wm0bwtDtxU4HuYEDdEQ
 XWkqoVEER9sYDlUlWkZeHByU3JwSczHBUIDBOy30XuGr5r2lRKPOmsDlORdhOGe2NoxQ
 nR+g==
X-Gm-Message-State: AOAM533NOQp8YD93Ttw9VE3NKnYMqGbjnjGlF89Q0xP75mNGsM95WuY2
 Tvw12oUl9SaiHvHfiC2EREw=
X-Google-Smtp-Source: ABdhPJwmxNQ1136QYkc9PA3muYgnR4p2qL5tLzKXL3lm576ULSXTsbWX7IBpIKH9M8f/1LW+Ilc4Kg==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr19023608wrn.265.1604311211088; 
 Mon, 02 Nov 2020 02:00:11 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b63sm15649221wme.9.2020.11.02.02.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 02:00:10 -0800 (PST)
Subject: target/mips: Deprecate nanoMIPS ISA?
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Fortune <matthew.fortune@mips.com>,
 Paul Burton <paulburton@kernel.org>,
 Stefan Markovic <Stefan.Markovic@mips.com>,
 Robert Suchanek <Robert.Suchanek@mips.com>
References: <CA+Lzsy=o9yshAAAacuTwcs3Hfr4MfWiX-SiUf5A2Fds3vGOrAQ@mail.gmail.com>
 <CAFEAcA9ap=c=1XZ6wpphiE=FYtCU+vdNCX8THW-m-hUp_XyGmg@mail.gmail.com>
 <b384912c-0e62-604d-df0b-b5181c2e7f3d@linaro.org>
 <05afa227-3db0-4b11-d541-7fce7139729d@amsat.org>
Message-ID: <38441531-1509-724f-4643-2ff2db253e3f@amsat.org>
Date: Mon, 2 Nov 2020 11:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <05afa227-3db0-4b11-d541-7fce7139729d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: James Hogan <jhogan@kernel.org>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 zou xu <iwatchnima@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

Cc'ing developers who introduced nanoMIPS.

On 9/11/20 7:23 PM, Philippe Mathieu-Daudé wrote:
> On 9/11/20 6:55 PM, Richard Henderson wrote:
>> On 9/11/20 3:41 AM, Peter Maydell wrote:
>>>> +    /* Detect store by reading the instruction at the program counter. */
>>>> +    uint32_t insn = *(uint32_t *)pc;
>>>> +    switch(insn>>29) {
>>>> +    case 0x5:
>>>> +        switch((insn>>26) & 0x7) {
>>>
>>> Here we mask to get a 3-bit field...
>>>
>>>> +        case 0x0: /* SB */
>>>> +        case 0x1: /* SH */
>>>> +        case 0x2: /* SWL */
>>>> +        case 0x3: /* SW */
>>>> +        case 0x4: /* SDL */
>>>> +        case 0x5: /* SDR */
>>>> +        case 0x6: /* SWR */
>>>> +        case 0x7: /* CACHE */
>>>> +            is_write = 1;
>>>
>>> ...but here all 8 cases are handled identically.
>>> Is there a typo/logic error here, or should this
>>> really just be
>>>
>>>     case 0x5:
>>>         /* SB, SH, SWL, SW, SDL, SDR, SWR, CACHE */
>>>         is_write = 1;
>>>
>>> ?
>>>
>>> Is CACHE really a write insn ?
>>
>> Indeed not.  However, it's also illegal for user-mode, so we cannot arrive here
>> with SIGSEGV by executing it.  So we could ignore that case and not decode this
>> field.
>>
>>>> +    case 0x7:
>>>> +        switch((insn>>26) & 0x7) {
>>>> +        case 0x0: /* SC */
>>>> +        case 0x1: /* SWC1 */
>>>> +        case 0x2: /* SWC2 */
>>>> +        case 0x4: /* SCD */
>>>> +        case 0x5: /* SDC1 */
>>>> +        case 0x6: /* SDC2 */
>>>> +        case 0x7: /* SD */
>>>> +            is_write = 1;
>>
>> Well, the unconditional check of SWC2/SDC2 is not quite right. MIPS64R6 removes
>> them and replaces them with some compact branches.  That's easy enough to
>> include here, using
>>
>> #if !defined(__mips_isa_rev) || __mips_isa_rev < 6
>>     case 2: /* SWC2 */
>>     case 6: /* SDC2 */
>> #endif
>>
>> We should also add
>>
>> #if defined(__mips16) || defined(__mips_micromips)
>> # error "Unsupported encoding"
>> #endif
>>
>> I see no upstream compiler support for nanomips at all, so there's no point in
>> checking for that encoding.  (Indeed, I wonder at the code in target/mips...
>> how could it be tested?)
> 
> I took the information from commit f7d257cb4a1
> ("qemu-doc: Add nanoMIPS ISA information") to add
> the tests in  f375ad6a0d6 ("BootLinuxConsoleTest:
> Test nanoMIPS kernels on the I7200 CPU"), but I
> haven't tried to recompile these files myself.

I checked the various nanoMIPS announcements:
GCC:   https://gcc.gnu.org/legacy-ml/gcc/2018-05/msg00012.html
Linux: https://lwn.net/Articles/753605/
QEMU:  https://www.mail-archive.com/qemu-devel@nongnu.org/msg530721.html

Unfortunately www.mips.com doesn't work anymore.

From this Wayback machine link:
https://web.archive.org/web/20180904044530/https://www.mips.com/develop/tools/compilers/

I found this working web (the toolchain is a later release than the
one referenced in the announcement mails):
http://codescape.mips.com/components/toolchain/nanomips/2018.04-02/downloads.html

The toolchain page mention LLVM but simply links http://llvm.org/
where I couldn't find any reference on nanoMIPS.

The only reference in the GCC mailing list, is the nanoMIPS
announcement: https://gcc.gnu.org/pipermail/gcc/2018-May.txt


It looks safe for QEMU to declare nanoMIPS deprecated (it has no
maintainer), to give time to interested parties to finish upstreaming
process and step in to maintain it.
Thoughts?

Regards,

Phil.

