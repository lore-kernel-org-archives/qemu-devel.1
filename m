Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C4C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECF220722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECF220722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CfX-0003ly-RY
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j5Cet-0003FE-CB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j5Cer-0006dh-HU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:04:14 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:18447)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j5Ceo-0006c4-Tp; Fri, 21 Feb 2020 13:04:13 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6A1E0747DF8;
 Fri, 21 Feb 2020 19:04:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D75C7747DF7; Fri, 21 Feb 2020 19:04:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D52DA74637E;
 Fri, 21 Feb 2020 19:04:07 +0100 (CET)
Date: Fri, 21 Feb 2020 19:04:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002211807380.69986@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
 <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
 <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020, Peter Maydell wrote:
> On Fri, 21 Feb 2020 at 16:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Thu, 20 Feb 2020, Richard Henderson wrote:
>>> On 2/18/20 9:10 AM, BALATON Zoltan wrote:
>>>> +    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, true),
>>>
>>> I would also prefer a different name here -- perhaps x-no-fp-fi.
>>
>> What's wrong with hardfloat? That's how the code refers to this so if
>> anyone searches what it does would turn up some meaningful results.
>
> This prompted me to check what you're using the property for.
> The cover letter says:
>> This patch implements a simple way to keep the inexact flag set for
>> hardfloat while still allowing to revert to softfloat for workloads
>> that need more accurate albeit slower emulation. (Set hardfloat
>> property of CPU, i.e. -cpu name,hardfloat=false for that.)
>
> I think that is the wrong approach. Enabling use of the host
> FPU should not affect the accuracy of the emulation, which
> should remain bitwise-correct. We should only be using the
> host FPU to the extent that we can do that without discarding
> accuracy. As far as I'm aware that's how the hardfloat support
> for other guest CPUs that use it works.

I don't know of a better approach. Please see section 4.2.2 Floating-Point 
Status and Control Register on page 124 in this document:

https://openpowerfoundation.org/?resource_lib=power-isa-version-3-0

especially the definition of the FR and FI bits and tell me how can we 
emulate these accurately and use host FPU. Not using the FPU even when 
these bits are not needed (which seems to be the case for all workloads 
we've tested so far) seriously limits the emulation speed so spending time 
to emulate obscure and unused part of an architecture when not actually 
needed just to keep emulation accurate but unusably slow does not seem to 
be the right approach. In an ideal world of course this should be both 
fast and accurate but we don't seem to have anyone who could achieve that 
in past two years so maybe we could give up some accuracy now to get 
usable speed and worry about emulating obscure features when we come 
across some workload that actually needs it (but we have the option to 
revert to accurate but slow emulation for that until a better way can be 
devised that's both fast and accurate). Insisting on accuracy without any 
solution to current state just hinders making any progress with this.

Other PowerPC emulators also seem to not bother or have similar 
optimisation. I've quickly checked three that I know about:

https://github.com/mamedev/mame/blob/master/src/devices/cpu/powerpc/ppcdrc.cpp#L1893
https://github.com/mamedev/mame/blob/master/src/devices/cpu/powerpc/ppcdrc.cpp#L3503
there's also something here but no mention of FI bit I could notice:
https://github.com/mamedev/mame/blob/master/src/devices/cpu/powerpc/ppccom.cpp#L2023

https://github.com/xenia-project/xenia/blob/master/src/xenia/cpu/ppc/ppc_hir_builder.cc#L428

https://github.com/dolphin-emu/dolphin/blob/master/Source/Core/Core/PowerPC/Jit64/Jit_FloatingPoint.cpp

But I'm not sure I understand all of the above so hope this makes more 
sense to someone and can advise.

Regards,
BALATON Zoltan

