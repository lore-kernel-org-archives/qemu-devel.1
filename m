Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39418C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8352076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8352076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFhT-00016B-2F
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 16:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUFdG-0006TS-CI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUFd4-0003d3-67
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:18:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:24657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jUFd0-0003Sy-Fx; Thu, 30 Apr 2020 16:17:53 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A9329746351;
 Thu, 30 Apr 2020 22:17:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 77B29746344; Thu, 30 Apr 2020 22:17:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7628774633E;
 Thu, 30 Apr 2020 22:17:45 +0200 (CEST)
Date: Thu, 30 Apr 2020 22:17:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: About hardfloat in ppc
In-Reply-To: <87d07okdfh.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2004302158330.13881@zero.eik.bme.hu>
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004301648440.29315@zero.eik.bme.hu>
 <87d07okdfh.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-968743997-1588277865=:13881"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 16:17:46
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: luoyonggang@gmail.com, "Emilio G . Cota" <cota@braap.org>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-968743997-1588277865=:13881
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 30 Apr 2020, Alex Bennée wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> On Tue, 28 Apr 2020, Alex Bennée wrote:
>>> 罗勇刚(Yonggang Luo) <luoyonggang@gmail.com> writes:
>>>> I am confusing why only  inexact  are set then we can use hard-float.
>>>
>>> The inexact behaviour of the host hardware may be different from the
>>> guest architecture we are trying to emulate and the host hardware may
>>> not be configurable to emulate the guest mode.
>>>
>>> Have a look in softfloat.c and see all the places where
>>> float_flag_inexact is set. Can you convince yourself that the host
>>> hardware will do the same?
>>
>> Can you convince me that it won't? This all seems to be guessing
>> without evidence so I think what we need first is some tests to prove
>> it either way. Such tests could then also be used at runtime to decide
>> if the host and guest FPU are compatible enough to enable hardfloat.
>> Are such tests available somewhere or what would need to be done to
>> implement them?
>
> I seem to recall it comes down to the various approaches that FPUs can
> take when dealing with tiny numbers when rounding. Emilio did the
> original work so I've CC'd him. The original paper is referenced in the
> hardfloat commentary:
>
> Guo, Yu-Chuan, et al. "Translating the ARM Neon and VFP instructions in a
> binary translator." Software: Practice and Experience 46.12 (2016):1591-1615.
>
> which is worth a read if you can get hold of it.
>
> Running tests on start up is not without precedent. We have a
> softfloat_init which checks for a broken FMA implementation. However I'd
> caution about adding too many checks in there.

Sure the runtime check should be quick so likely the approach would be to 
write detailed tests to profile different FPU implementations then only 
include one quick check to tell at runtime if we're running on a known 
good host. Maybe if someone knows the different FPUs can tell this without 
tests but I don't know and finding out from docs seems more work than 
determining it empirically by testing. Does someone have some hints on 
what operations should be tested to check for different inexact handling 
in different FPUs?

>> This may not solve the problem with PPC target with non-cumulative
>> status bits but could improve hardfloat performance at least for some
>> host-guest combinations. To see if it worth the effort we should run
>> such test on common combinations (say x86_64. ARM and PPC hosts with
>> at least these guests).
>
> We already enable hardfloat for all hosts apart from PPC and FAST_MATHS.

Only if inexact is set which may be common but still not using softfloat 
ar all if host's implementation is good for guest could be even faster.

>>>> And PPC always clearing inexact  flag before calling to soft-float
>>>> funcitons. so we can not
>>>> optimize it with hard-float.
>>>> I need some resouces about ineact flag and why always clearing inexcat in
>>>> PPC FP simualtion.
>>>
>>> Because that is the behaviour of the PPC floating point unit. The
>>> inexact flag will represent the last operation done.
>>
>> More precisely additional to the usual cumulative (or sticky) bits
>> there are two non-sticky bits for inexact and rounded (latter of which
>> is not emulated) that currently need clearing FP status before every
>> FP op.
>
> Thanks for the clarification.
>
>> I wonder if we can know when the guest reads these and rerun
>> the last FP op in softfloat to compute them only if these are read,
>> then it's enough to remember the last FP op. This could be relatively
>> simple and may be used even if we don't detect accessing the bits
>> within FPSCR just accessing the FPSCR as likely most guest code does
>> not check that and any cross-platform code won't check PPC specific
>> non-sticky bits so I'd exepect most guest code to be fine with
>> hardfloat.
>
> You could go further if you know nothing in a block can fault you can
> skip the calculation overhead of the per-op flags for all but the last
> op in the block.

I think that's an additional optimisation that could be done once the 
simple case of just rerunning last op if flags are accessed works. Just to 
keep complexity low first then try more complex solution. (Although I'm 
not planning to try to do this so whatever complexity can be handled by 
whom will implement it is fine but less complexity means less bugs so I'd 
go for simple first.)

>> Although what about FP exceptions? We also need to revert
>> to softfloat it FP exceptions are enabled so maybe using host FP
>> exception for managing status bits could be the way to go to let
>> hardware manage this and we don't need to implement everything in
>> software.
>
> Well for all apart from inexact handling (which would fault as soon as
> set) all other exception types are detected before we pass them to
> hardfloat anyway. Given the range of NaN types we would have to post
> process and hardfloat operation anyway to give the right NaN.

Is checking for those exceptions beforehand really needed? Wouldn't it be 
easier to install an exception handler and let the hardware do those 
checks? It this is again done because of FPU implemenation differences but 
inexact is determined by looking at the FP status (that's why it's cleared 
on PPC) then that means that we always use the hosts inexact semantics and 
don't emulate guest correctly anyway, so we can skip the tests above. Then 
why can't we install an exception handler and set guest bits whenever 
that's raised?

Regards,
BALATON Zoltan
--3866299591-968743997-1588277865=:13881--

