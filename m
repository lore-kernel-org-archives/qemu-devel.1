Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E45AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7000A2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/yNBx9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7000A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVg7h-0000WR-N7
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 14:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVg6q-0008Cm-RA
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:46:32 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:44608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVg6p-0003ZD-HM
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:46:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id p25so5955256pfn.11
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8YGbZnUF1EQmYNd5GlYIqTx9qYh32rMxCFppLmIPJPw=;
 b=W/yNBx9DYUtqozt8YOh5yLJ7J1ebvgiHBgEEd4ENvApvsWykLBNsDONuDb/azw1XUY
 hA6f7Ol/82e2msQ5y/MSrC+0aPfdUeF0n8F1VmDFqGfTud75kb3bVtnfLNPxhyXdjAJT
 g+hL6s3cwQ4fUDckUF61v+/WcXO23Zg6SIwuenJpCUEr4jSMBr7W0WO1f7cYzjAF0pz3
 CvPLy3kY1I7kC2bWGhhG5SZCz/hkitTShdmJzmdEPMwlVFjGxAqatZ3jKqH8JE7kWNks
 RLNz6EFGVQStpdHIMmL6Eeg1yrqURitffn3lR/MUZ/mOLA/bjwtigXsH/0XpSguEAxlw
 2KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8YGbZnUF1EQmYNd5GlYIqTx9qYh32rMxCFppLmIPJPw=;
 b=aSiRxr/3/W6kFcv7EqNjA15mg7gro8GIQ3tSz2O6EYot919DS7V9qcnhG6WvFpI5I0
 Av3l9OYhPVnnwBG4pgtVYu5yD0fiRUgvzzOmMa/LVkjNufWAYRvhXHfH+sOXJYx1iY/D
 cdIAav+zj3lVkHCkL4fDXHTqtnKoX2aqdhmc+8jiVG4soE3AEYcbWH27OMUoM5Sbrcu2
 dzcGrBYps6mrlRa/VPyZgo/tm64xyIfBC1mMSRJX03VdYh9vRoHauVPoB/K9dePg3Eq/
 EVuqGWO0grJjzJ8M24xSubjZnlFwIsY2dqVLMh6x8p0BbB1N3zgM0IjN3eGBXDMXhX7A
 YGoA==
X-Gm-Message-State: AGi0PubNuyPTYdMTSRGijRCdxLIivFE7Soou6eGofKTkCejWqhEqajLS
 elu7JifuZXXWKmYb7Y5a4hCtKtZ9z30=
X-Google-Smtp-Source: APiQypJVdYBtNmngi8W3mjCsFnHrQxd0zVNv2xIRJDBFLJiWpdwIyl5ZrZu3LJZC5Mz1VAb9kg9JLA==
X-Received: by 2002:a62:b611:: with SMTP id j17mr18510620pff.214.1588617989258; 
 Mon, 04 May 2020 11:46:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d203sm9332891pfd.79.2020.05.04.11.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 11:46:28 -0700 (PDT)
Subject: Re: An first try to improve PPC float simulation, not even compiled.
 Just ask question.
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
 <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
 <alpine.BSF.2.22.395.2005040128330.7227@zero.eik.bme.hu>
 <CAE2XoE93HqZVvFkZzfuC1VsF-Vw88ggSYMU2t7QjPUPWSU-4-Q@mail.gmail.com>
 <e93bda1e-ae5f-00f9-0655-f4bb72597ab5@linaro.org>
 <alpine.BSF.2.22.395.2005042024450.36499@zero.eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbeeeefc-c208-6549-225e-b3d0ef025679@linaro.org>
Date: Mon, 4 May 2020 11:46:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2005042024450.36499@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 luoyonggang@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 11:30 AM, BALATON Zoltan wrote:
> On Mon, 4 May 2020, Richard Henderson wrote:
>> On 5/3/20 5:41 PM, 罗勇刚(Yonggang Luo) wrote:
>>> On Mon, May 4, 2020 at 7:40 AM BALATON Zoltan <balaton@eik.bme.hu
>>> <mailto:balaton@eik.bme.hu>> wrote:
>>>
>>>     Hello,
>>>
>>>     On Mon, 4 May 2020, 罗勇刚(Yonggang Luo) wrote:
>>>    > Hello Richard, Can you have a look at the following patch, and was that
>>> are
>>>    > the right direction?
>>>
>>>     Formatting of the patch is broken by your mailer, try sending it with
>>>     something that does not change it otherwise it's a bit hard to read.
>>>
>>>     Richard suggested to add an assert to check the fp_status is correctly
>>>     cleared in place of helper_reset_fpstatus first for debugging so you could
>>>     change the helper accordingly before deleting it and run a few tests to
>>>     verify it still works. You'll need get some tests and benchmarks working
>>>     to be able to verify your changes that's why I've said that would be step
>>>     0. If you checked that it still produces the same results and the assert
>>>     does not trigger then you can remove the helper.
>>>
>>> That's what I need help,
>>> 1. How to write a assert to replace helper_reset_fpstatus .
>>>   just directly assert? or something else
>>
>> You can't place the assert where helper_reset_fpstatus was.  You need to place
>> it in each of the helpers, like helper_fadd, that previously has a call to
>> helper_reset_fpstatus preceeding it.
> 
> Why? If we want to verify that clearing fp_status after flags are processed is
> equivalent to clearing flags before fp ops then verifying that the fp_status is
> already cleared when the current helper_reset_fpstatus is called should be
> enough to check that nothing has set the flags in between so the current reset
> helper would be no op. Therefore I thought you could put the assert there for
> checking this. This assert is for debugging and checking the change only and
> not meant to be left there otherwise we lose all the performance gain so it's
> easier to put in the current helper before removing it for this than in every
> fp op helper. What am I missing?

I'm not sure what you are suggesting.

If you are suggesting

 void helper_reset_fpstatus(CPUPPCState *env)
 {
-    set_float_exception_flags(0, &env->fp_status);
+    assert(get_float_exception_flags(&env->fp_status) == 0);
 }

then, sure, that works.  But we also want to remove that call, so in order to
retain the check for debugging, we need to move the assert into the other helpers.


r~

