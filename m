Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4E4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D8E20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D8E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVftn-0007hJ-Na
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 14:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVfrV-0005hz-GO; Mon, 04 May 2020 14:30:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:33319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVfrR-0006Fv-1A; Mon, 04 May 2020 14:30:40 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id F31A3746351;
 Mon,  4 May 2020 20:30:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 72B6C746342; Mon,  4 May 2020 20:30:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 70C74746324;
 Mon,  4 May 2020 20:30:18 +0200 (CEST)
Date: Mon, 4 May 2020 20:30:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: An first try to improve PPC float simulation, not even compiled.
 Just ask question.
In-Reply-To: <e93bda1e-ae5f-00f9-0655-f4bb72597ab5@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2005042024450.36499@zero.eik.bme.hu>
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
 <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
 <alpine.BSF.2.22.395.2005040128330.7227@zero.eik.bme.hu>
 <CAE2XoE93HqZVvFkZzfuC1VsF-Vw88ggSYMU2t7QjPUPWSU-4-Q@mail.gmail.com>
 <e93bda1e-ae5f-00f9-0655-f4bb72597ab5@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-585507572-1588617018=:36499"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 luoyonggang@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-585507572-1588617018=:36499
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 4 May 2020, Richard Henderson wrote:
> On 5/3/20 5:41 PM, 罗勇刚(Yonggang Luo) wrote:
>> On Mon, May 4, 2020 at 7:40 AM BALATON Zoltan <balaton@eik.bme.hu
>> <mailto:balaton@eik.bme.hu>> wrote:
>>
>>     Hello,
>>
>>     On Mon, 4 May 2020, 罗勇刚(Yonggang Luo) wrote:
>>    > Hello Richard, Can you have a look at the following patch, and was that are
>>    > the right direction?
>>
>>     Formatting of the patch is broken by your mailer, try sending it with
>>     something that does not change it otherwise it's a bit hard to read.
>>
>>     Richard suggested to add an assert to check the fp_status is correctly
>>     cleared in place of helper_reset_fpstatus first for debugging so you could
>>     change the helper accordingly before deleting it and run a few tests to
>>     verify it still works. You'll need get some tests and benchmarks working
>>     to be able to verify your changes that's why I've said that would be step
>>     0. If you checked that it still produces the same results and the assert
>>     does not trigger then you can remove the helper.
>>
>> That's what I need help,
>> 1. How to write a assert to replace helper_reset_fpstatus .
>>   just directly assert? or something else
>
> You can't place the assert where helper_reset_fpstatus was.  You need to place
> it in each of the helpers, like helper_fadd, that previously has a call to
> helper_reset_fpstatus preceeding it.

Why? If we want to verify that clearing fp_status after flags are 
processed is equivalent to clearing flags before fp ops then verifying 
that the fp_status is already cleared when the current 
helper_reset_fpstatus is called should be enough to check that nothing has 
set the flags inbetween so the current reset helper would be no op. 
Therefore I thought you could put the assert there for checking this. This 
assert is for debugging and checking the change only and not meant to be 
left there otherwise we lose all the performance gain so it's easier to 
put in the current helper before removing it for this than in every fp op 
helper. What am I missing?

Regards,
BALATON Zoltan

> The assert should be placed before the first floatN_op call that uses
> env->fp_status.  E.g.
>
> float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
> {
>    float64 ret;
>    int status;
>
>    status = get_float_exception_flags(&env->fp_status);
>    assert(status == 0);
>    ret = float64_add(arg1, arg2, &env->fp_status);
>    status = get_float_exception_flags(&env->fp_status);
>
>    if (unlikely(status & float_flag_invalid)) {
>        float_invalid_op_addsub(env, 1, GETPC(),
>                                float64_classify(arg1) |
>                                float64_classify(arg2));
>    }
>
>    return ret;
> }
>
>
> r~
>
>
--3866299591-585507572-1588617018=:36499--

