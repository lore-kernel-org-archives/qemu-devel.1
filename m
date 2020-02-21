Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEDDC35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B422067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B422067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AoR-0005X2-8k
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j5Amy-0003jJ-Dy
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j5Amu-0004BW-Q5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:04:27 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:18289)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j5Amu-00048s-Hp; Fri, 21 Feb 2020 11:04:24 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0A0B0747DF7;
 Fri, 21 Feb 2020 17:04:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D56DA74637E; Fri, 21 Feb 2020 17:04:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D3720745953;
 Fri, 21 Feb 2020 17:04:21 +0100 (CET)
Date: Fri, 21 Feb 2020 17:04:21 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>,
 qemu-ppc@nongnu.org, Paul Clarke <pc@us.ibm.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020, Richard Henderson wrote:
> On 2/18/20 9:10 AM, BALATON Zoltan wrote:
>>  void helper_reset_fpstatus(CPUPPCState *env)
>>  {
>> -    set_float_exception_flags(0, &env->fp_status);
>> +    set_float_exception_flags(env->default_fp_excpt_flags, &env->fp_status);
>>  }
>
> What I don't like is the forced setting of inexact.  I don't mind leaving it
> set if it is already set, which corresponds to the normal accumulation of
> exceptions.

In a previous reply I've explained this (apart from just trying to get it 
work the simplest way for testing first):

On Wed, 19 Feb 2020, BALATON Zoltan wrote:
> Some of the problems with inexact may be fixed by not always forcing the 
> flag on but just not clearing it. As I undersood other targets do that 
> so it starts with softfloat but the first time the inexact flag is set 
> it will start using hardfloat as long as the guest does not clear this 
> flag. Probably this is done to automatically detect code that needs the 
> flag and assume it's not used when it's not touched. Since PPC also has 
> an inexact flag just for previous FP op (the FI bit) apart from the 
> usual cumulative flag, the client could read that instead of clearing 
> the cumulative flag so we can't detect guest usage this way, therefore 
> we might as well break inexact completely to always use hardfloat and 
> need to manually enable it for guests that we know need it. I'm not sure 
> however if forcing the inexact flag would lead to unwanted FP exceptions 
> as well so this may also need to be made conditional on the 
> enabled/disabled status of inexact FP exceptions. Does anyone have more 
> info on this?

So I know this should be improved but not sure how. I would not worry 
about setting the bit from the start due to the above but exceptions are 
likely wrong this way as you say.

> In addition, if the inexact exception is unmasked, I would expect a signal to
> be delivered only when an inexact exception happens.  Whereas this patch would
> deliver a signal for every fp operation.
>
> It should be just as easy to do
>
>    flags = get_float_exception_flags(status);
>    flags &= env->save_fp_exception_flags;
>    set_float_exception_flags(flags, status);

I'm not sure I get this. Can you please explain a bit more? Where would 
save_flags be set and where would the above masking with it be done? 
Currently we reset flags before every FP op as far as I understand and 
detecting of exceptions rely on this and test fp_status bits. Probably we 
should not reset the flags and change this to keep one fp_status 
accumulating flags and only reset if softfloat is forced but that would 
need rewriting exception handling that I'm not sure yet how to do. Any 
idea? Maybe if we could just unbreak inexact exceptions when enabled with 
current patch then this rewrite of exception handling could be done later.

>> +    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, true),
>
> I would also prefer a different name here -- perhaps x-no-fp-fi.

What's wrong with hardfloat? That's how the code refers to this so if 
anyone searches what it does would turn up some meaningful results. Your 
proposed property name is very cryptic and nobody would be able to guess 
what is it for. If you insist not to use hardfloat maybe we could invert 
it to softfloat or try x-use-fpu maybe. I specificaly don't want to tie it 
to the FI but as there's at least another non-sticky bit in FPSCR (don't 
remember which now) that might also need to be broken for best hardfloat 
results.

Regards,
BALATON Zoltan

