Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28BD221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJZlxrbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28BD221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmmM-0002ox-TY
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGmld-0002O6-QF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:23:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGmlc-0008E2-1S
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:23:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id a65so5106721wme.5
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tvOXSAcUB8OM5//eDhNm/+0+ZT0pClrbhBFgATFRJ8k=;
 b=VJZlxrbWHJzs33/RN03aXwYGZzG2tKT9afst+cihyLme1PIiRHR+ULMRwom8KXbjT2
 LHYnyxoaeuF8T48bpQd2UsNQ3/bjnEn635xRvs3Hfhywy2b3lJ/jpyuIB2vCItyJRyt8
 rZTWsvbnsY25lAAKDKYV22EF5gyKYtA/6CHqlO7etzPutIimW2TiX0I1dJTokO0CJAe9
 DuZfQ1ngoOlNslku9Z3PDhPCM2fgD1FJ3cFPzCUsVL4XRchcJ3i2dmD9dKSDINqKPJqx
 Lm5/+Sz6vP+XAXG04UQzk8K/D4SUNTH3SwnkAdP/oUlQSMcVquExxrgVbJADqhLNYUzh
 5gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tvOXSAcUB8OM5//eDhNm/+0+ZT0pClrbhBFgATFRJ8k=;
 b=GZFhzmajfRyiers/QcKAEDfxA1Rvtwo49z56PyjV2k3SL7WKcg5YAzG0AB7jTMmsv8
 66+mxBJegGvLcil9cdXlD7ucrFdfw4mmaFcada5bIlYl5EIVIKSGx+kh5ExhDQ7PmXOl
 hPSw+tRDopVUG7OXkXuIUeYmJzS49bGNV2Ush/72SOCdbbInklGXM95XpAgA7E09121a
 px33VUZfHBZM0Lx4WLbUuS9jeeeKHBvKxCwSXlS2NywSm0ba24M/Y32xzSSx0ahtWMfd
 T9YMGjPbZR2O0lhsuPELhoX3i9Ld2/XdtKVDfcoGhbx0N9kjgGJfOGocS79s1Bs7iMo2
 w1ig==
X-Gm-Message-State: AOAM530zplHHL2GLXh+XnlOJo9DujyqoJjptgl2TpdvtA1ND++7j5PIa
 IXx7RvSFj2DEKbbyhhzSpCXPEZBQL1I=
X-Google-Smtp-Source: ABdhPJxluOhOKlYhFrki2ZP3DkjL13XYVHdFG0EHH6mLgv1C5eZ7ZlouhlUz196/z1IEPKWxOYwbpA==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr3276031wmj.16.1599844998208; 
 Fri, 11 Sep 2020 10:23:18 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l15sm5669194wrt.81.2020.09.11.10.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 10:23:17 -0700 (PDT)
Subject: Re: [PATCH 1/1] accel/tcg/user-exec: support computing is_write for
 mips32
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, zou xu <iwatchnima@gmail.com>
References: <CA+Lzsy=o9yshAAAacuTwcs3Hfr4MfWiX-SiUf5A2Fds3vGOrAQ@mail.gmail.com>
 <CAFEAcA9ap=c=1XZ6wpphiE=FYtCU+vdNCX8THW-m-hUp_XyGmg@mail.gmail.com>
 <b384912c-0e62-604d-df0b-b5181c2e7f3d@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <05afa227-3db0-4b11-d541-7fce7139729d@amsat.org>
Date: Fri, 11 Sep 2020 19:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b384912c-0e62-604d-df0b-b5181c2e7f3d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
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

On 9/11/20 6:55 PM, Richard Henderson wrote:
> On 9/11/20 3:41 AM, Peter Maydell wrote:
>>> +    /* Detect store by reading the instruction at the program counter. */
>>> +    uint32_t insn = *(uint32_t *)pc;
>>> +    switch(insn>>29) {
>>> +    case 0x5:
>>> +        switch((insn>>26) & 0x7) {
>>
>> Here we mask to get a 3-bit field...
>>
>>> +        case 0x0: /* SB */
>>> +        case 0x1: /* SH */
>>> +        case 0x2: /* SWL */
>>> +        case 0x3: /* SW */
>>> +        case 0x4: /* SDL */
>>> +        case 0x5: /* SDR */
>>> +        case 0x6: /* SWR */
>>> +        case 0x7: /* CACHE */
>>> +            is_write = 1;
>>
>> ...but here all 8 cases are handled identically.
>> Is there a typo/logic error here, or should this
>> really just be
>>
>>     case 0x5:
>>         /* SB, SH, SWL, SW, SDL, SDR, SWR, CACHE */
>>         is_write = 1;
>>
>> ?
>>
>> Is CACHE really a write insn ?
> 
> Indeed not.  However, it's also illegal for user-mode, so we cannot arrive here
> with SIGSEGV by executing it.  So we could ignore that case and not decode this
> field.
> 
>>> +    case 0x7:
>>> +        switch((insn>>26) & 0x7) {
>>> +        case 0x0: /* SC */
>>> +        case 0x1: /* SWC1 */
>>> +        case 0x2: /* SWC2 */
>>> +        case 0x4: /* SCD */
>>> +        case 0x5: /* SDC1 */
>>> +        case 0x6: /* SDC2 */
>>> +        case 0x7: /* SD */
>>> +            is_write = 1;
> 
> Well, the unconditional check of SWC2/SDC2 is not quite right. MIPS64R6 removes
> them and replaces them with some compact branches.  That's easy enough to
> include here, using
> 
> #if !defined(__mips_isa_rev) || __mips_isa_rev < 6
>     case 2: /* SWC2 */
>     case 6: /* SDC2 */
> #endif
> 
> We should also add
> 
> #if defined(__mips16) || defined(__mips_micromips)
> # error "Unsupported encoding"
> #endif
> 
> I see no upstream compiler support for nanomips at all, so there's no point in
> checking for that encoding.  (Indeed, I wonder at the code in target/mips...
> how could it be tested?)

I took the information from commit f7d257cb4a1
("qemu-doc: Add nanoMIPS ISA information") to add
the tests in  f375ad6a0d6 ("BootLinuxConsoleTest:
Test nanoMIPS kernels on the I7200 CPU"), but I
haven't tried to recompile these files myself.

Regards,

Phil.

