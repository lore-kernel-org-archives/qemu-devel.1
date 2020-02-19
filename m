Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C3C34052
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E696208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E696208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ROs-0002bq-QN
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j4RNq-0001cu-6c
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j4RNX-0004Vo-GQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:35:29 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:55088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j4RNV-0004SN-UC; Wed, 19 Feb 2020 10:35:11 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 04025747E01;
 Wed, 19 Feb 2020 16:35:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BC01D747DFF; Wed, 19 Feb 2020 16:35:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B9E38747DFA;
 Wed, 19 Feb 2020 16:35:07 +0100 (CET)
Date: Wed, 19 Feb 2020 16:35:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Programmingkid <programmingkidx@gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, Paul Clarke <pc@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Tue, 18 Feb 2020, Programmingkid wrote:
>> On Feb 18, 2020, at 12:10 PM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> While other targets take advantage of using host FPU to do floating
>> point computations, this was disabled for PPC target because always
>> clearing exception flags before every FP op made it slightly slower
>> than emulating everyting with softfloat. To emulate some FPSCR bits,
>> clearing of fp_status may be necessary (unless these could be handled
>> e.g. using FP exceptions on host but there's no API for that in QEMU
>> yet) but preserving at least the inexact flag makes hardfloat usable
>> and faster than softfloat. Since most clients don't actually care
>> about this flag, we can gain some speed trading some emulation
>> accuracy.
>>
>> This patch implements a simple way to keep the inexact flag set for
>> hardfloat while still allowing to revert to softfloat for workloads
>> that need more accurate albeit slower emulation. (Set hardfloat
>> property of CPU, i.e. -cpu name,hardfloat=false for that.) There may
>> still be room for further improvement but this seems to increase
>> floating point performance. Unfortunately the softfloat case is slower
>> than before this patch so this patch only makes sense if the default
>> is also set to enable hardfloat.
>>
>> Because of the above this patch at the moment is mainly for testing
>> different workloads to evaluate how viable would this be in practice.
>> Thus, RFC and not ready for merge yet.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> v2: use different approach to avoid needing if () in
>> helper_reset_fpstatus() but this does not seem to change overhead
>> much, also make it a single patch as adding the hardfloat option is
>> only a few lines; with this we can use same value at other places where
>> float_status is reset and maybe enable hardfloat for a few more places
>> for a little more performance but not too much. With this I got:
>
> <snip>
>
> Thank you for working on this. It is about time we have a better FPU.

Thank you for testing it. I think it would be great if we could come up 
with some viable approach to improve this before the next freeze.

> I applied your patch over David Gibson's ppc-for-5.0 branch. It applied cleanly and compiled easily.

I've heard some preliminary results from others that there's also a 
difference between v1 and v2 of the patch in performance where v1 may be 
faster for same cases so if you (or someone else) want and have time you 
could experiment with different versions and combinations as well to find 
the one that's best on all CPUs. Basically we have these parts:

1. Change target/ppc/fpu_helper.c::helper_reset_fpstatus() to force 
float_flag_inexact on in case hadfloat is enabled, I've tried two 
approaches for this:

a. In v1 added an if () in the function
b. In v2 used a variable from env set earlier (I've hoped this may be 
faster but maybe it's not, testing and explanation is welcome)

2. Also change places where env->fp_status is copied to a local tstat and 
then reset (I think this is done to accumulate flags from multiple FP ops 
that would individually reset env->fp_status or some other reason, maybe 
this could be avoided if we reset fp_status less often but that would need 
more understanding of the FP emulation that I don't have so I did not 
try to clean that up yet).

If v2 is really slower than v1 then I'm not sure is it because also 
changing places with tstat or because of the different approach in 
helper_reset_fpstatus() so you could try combinations of these as well.

> Tests were done on a Mac OS 10.4.3 VM. The CPU was set to G3.

What was the host CPU and OS this was tested on? Please always share CPU 
info and host OS when sharing bechmark results so they are somewhat 
comparable. It also depends on CPU features for vector instrucions at 
least so without CPU info the results could not be understood.

I think G3 does not have AltiVec/VMX so maybe testing with G4 would be 
better to also test those ops unless there's a reason to only test G3. 
I've tested with G4 both FPU only and FPU+VMX code on Linux host with 
i7-9700K CPU @ 3.60GHz as was noted in the original cover letter but may 
be I'va also forgotten some details so I list it here again.

> I did several tests and here are my results:
>
> With hard float:
> - The USB audio device does not produce any sound.

I've heard this could also be due to some other problem not directly 
related to FPU, maybe there's a problem with USB/OHCI emulation as well 
because problems with that were reported but it's interesting why you get 
different results changing FPU related stuff. I think OSX uses float 
samples so probably does use FPU for processing sound and may rely on some 
pecularity of the hardware as it was probably optimised for Apple 
hardware. It would be interesting to find out how FPU stuff is related to 
this but since it's broken anyway probably not a show stopper at the 
moment.

> - Converting a MIDI file to AAC in iTunes happens at 0.4x (faster than soft float :) ).

Does resulting file match? As a simple test I've verified md5sum of the 
resulting mp3 with the lame benchmark I've tried just to find any big 
errors. Even if it does not prove that nothing broke, it shuold detect if 
something breaks badly. However that was WAV->MP3 where results were same, 
although the VMX build did produce different result than FPU only but did 
so consistently for multiple runs. With MIDI there might be slight timing 
difference that could cause different audio results so you should first 
verify if doing the conversion multiple times does produce the same result 
at all without any patch first.

> For my FPSCR test program, 21 tests failed. The high number is because 
> the inexact exception is being set for situations it should not be set 
> for.

Since we force the inexact flag to be set to enable hardfloat this is 
expected. More interesting is if apart from this are there any difference 
in the results compared to the soffloat case (that may also be host CPU 
dependent I think). Do you have more detailed info on the errors and 
differences found?

Some of the problems with inexact may be fixed by not always forcing the 
flag on but just not clearing it. As I undersood other targets do that so 
it starts with softfloat but the first time the inexact flag is set it 
will start using hardfloat as long as the guest does not clear this flag. 
Probably this is done to automatically detect code that needs the flag and 
assume it's not used when it's not touched. Since PPC also has an inexact 
flag just for previous FP op (the FI bit) apart from the usual cumulative 
flag, the client could read that instead of clearing the cumulative flag 
so we can't detect guest usage this way, teherefore we might as well break 
inexact completely to always use hardfloat and need to manually enable it 
for guests that we know need it. I'm not sure however if forcing the 
inexact flag would lead to unwanted FP exceptions as well so this may also 
need to be made conditional on the enabled/disabled status of inexact FP 
exceptions. Does anyone have more info on this?

> With soft float: - Some sound can be heard from the USB audio device. It 
> isn't good sounding. I had to force quit Quicktime player because it 
> stopped working.
> - Converting a MIDI file to AAC in iTunes happens at 0.3x (slower than hard float).
> - 13 tests failed with my FPSCR test program.
>
> This patch is a good start. I'm not worried about the Floating Point 
> Status and Control Register flags being wrong since hardly any software 
> bothers to check them. I think more optimizations can happen by

I don't know if guest code checks fpscr and what flags it cares about. 
Also don't know if it's a fact that these are not used but maybe if we 
test with more guest codes we can find out. That's why I'd like to at 
least have an option to test with hardfloat. Unfortunately enabling 
hardfloat without also making it default would make it slower so if we go 
this way we should make sure we can also enable hardfloat as default.

> simplifying the FPU. As it is now it makes a lot of calls per operation.

Question is if those calls are really needed to emulate PPC FPU or if not 
why would they be there? If the FPU is really that much different so all 
these calls are needed then there's not much to simplify (but maybe there 
could be some optimisations possible). This would need someone to 
understand the current code in full first that probably we don't currently 
(ar least I don't for sure so can't really make changes either). Another 
more viable approach is to pick a small part and follow through with that 
and try to clean up and optimise that small part only. The exception and 
fpscr handling is one such part, another could be round_canonical() that 
seems to be high on profiles I've taken. Maybe this could be done by 
reading and understading docs only on the small part picked that may be 
easier than getting everything first. I wonder if such smaller tasks could 
be defined and given out as GSoC or other volunteer projects?

Regards,
BALATON Zoltan

