Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF1C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558E0207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558E0207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eZ8-0004L6-HY
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j3eYK-0003l0-NM
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j3eYI-0001aC-D9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:27:04 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:44978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j3eYH-0001YH-Da; Mon, 17 Feb 2020 06:27:02 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 152FB747DFB;
 Mon, 17 Feb 2020 12:26:59 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BD804747DFA; Mon, 17 Feb 2020 12:26:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BB676747DF8;
 Mon, 17 Feb 2020 12:26:58 +0100 (CET)
Date: Mon, 17 Feb 2020 12:26:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 0/2] Enable hardfloat for PPC
In-Reply-To: <CAFEAcA8zGoFt7TyocG-HEezdsNFoiyT=OWgZdr4qFf7JUSaLkQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002171155460.74534@zero.eik.bme.hu>
References: <cover.1581904461.git.balaton@eik.bme.hu>
 <CAFEAcA8zGoFt7TyocG-HEezdsNFoiyT=OWgZdr4qFf7JUSaLkQ@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020, Peter Maydell wrote:
> On Mon, 17 Feb 2020 at 02:43, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Hello,
>>
>> This is an RFC series to start exploring the possibility of enabling
>> hardfloat for PPC target that haven't progressed in the last two years.
>> Hopefully we can work out something now. Previously I've explored this
>> here:
>>
>> https://lists.nongnu.org/archive/html/qemu-ppc/2018-07/msg00261.html
>>
>> where some ad-hoc benchmarks using lame mp3 encoder is also explained
>> that has two versions: one using VMX and another only using FP. Both
>> are mostly floating point bounded. I've run this test on mac99 under
>> MorphOS before and after my patches, also verifying that md5sum of
>> resulting mp3 matches (this is no proof for correctness but maybe
>> shows it did not break too much at least those ops used by this
>> program).
>
>> I hope others can contribute to this by doing more testing to find out
>> what else this would break or give some ideas how this could be
>> improved.
>
> I think the ideal would be to test against a reference using
> risu to see whether this changes behaviour (FP results should
> be bit-for-bit identical; usually application level testing is
> often not sufficient to detect this). You could test either

Sure, thanks. I did not mean to claim the simple test I've done was 
sufficient but I expect others who have interest in this and more 
experienced in such testing (or even being payed to work on QEMU which I'm 
not) contribute to this so I did not try testing it more throughly than 
just showing it could be considerably faster and still work fot at least 
some workloads so it's worth working on. I'm surprised that in the two 
years since hardfloat was merged nobody even tried this (or those who did 
dropped the idea before any results without letting us know). So I tried 
to make a start with it to explore what would it take to fix this 
eventually but I don't want to do that alone. I hope this inspires others 
to help e.g. in thesting and we can reach a solution together.

> against real hardware or against the non-hardfloat QEMU.
> I'm not sure how comprehensive the coverage for ppc insns
> is but there are a fair number of fp insns covered already:
> https://git.linaro.org/people/peter.maydell/risu.git/tree/

I don't have real hardware and testing against QEMU may take longer and 
not sure how useful. There could also be preexisting bugs, although some 
fixes were made to PPC FP implementation recently. Maybe I'll have a look 
if have no better things to do but I have other ongoing QEMU related 
projects as well that I might try to make some progress as well.

> It's also worth testing any alternate/non-standard config
> modes the FPU might have (eg different default rounding modes,
> any flush-to-zero or alternate denormal handling, that kind
> of thing), and not just the default how-the-CPU-boots-up mode.

It is expected to break inexact exceptions currently until a better way 
can be found to handle those but I think hardfloat is already disabled for 
other than default rounding modes or FPU settings so maybe those should 
not break. According to:

https://git.qemu.org/?p=qemu.git;a=blob;f=fpu/softfloat.c;h=301ce3b537b6c0eee5dbbc358587b66a3a341d2a;hb=HEAD#l235

  235 static inline bool can_use_fpu(const float_status *s)
  236 {
  237     if (QEMU_NO_HARDFLOAT) {
  238         return false;
  239     }
  240     return likely(s->float_exception_flags & float_flag_inexact &&
  241                   s->float_rounding_mode == float_round_nearest_even);
  242 }
  243

and

https://git.qemu.org/?p=qemu.git;a=blob;f=fpu/softfloat.c;h=301ce3b537b6c0eee5dbbc358587b66a3a341d2a;hb=HEAD#l99

   99 /*
  100  * Hardfloat
  101  *
  102  * Fast emulation of guest FP instructions is challenging for two reasons.
  103  * First, FP instruction semantics are similar but not identical, particularly
  104  * when handling NaNs. Second, emulating at reasonable speed the guest FP
  105  * exception flags is not trivial: reading the host's flags register with a
  106  * feclearexcept & fetestexcept pair is slow [slightly slower than soft-fp],
  107  * and trapping on every FP exception is not fast nor pleasant to work with.
  108  *
  109  * We address these challenges by leveraging the host FPU for a subset of the
  110  * operations. To do this we expand on the idea presented in this paper:
  111  *
  112  * Guo, Yu-Chuan, et al. "Translating the ARM Neon and VFP instructions in a
  113  * binary translator." Software: Practice and Experience 46.12 (2016):1591-1615.
  114  *
  115  * The idea is thus to leverage the host FPU to (1) compute FP operations
  116  * and (2) identify whether FP exceptions occurred while avoiding
  117  * expensive exception flag register accesses.
  118  *
  119  * An important optimization shown in the paper is that given that exception
  120  * flags are rarely cleared by the guest, we can avoid recomputing some flags.
  121  * This is particularly useful for the inexact flag, which is very frequently
  122  * raised in floating-point workloads.
  123  *
  124  * We optimize the code further by deferring to soft-fp whenever FP exception
  125  * detection might get hairy. Two examples: (1) when at least one operand is
  126  * denormal/inf/NaN; (2) when operands are not guaranteed to lead to a 0 result
  127  * and the result is < the minimum normal.
  128  */
  129 #define GEN_INPUT_FLUSH__NOCHECK(name, soft_t)                          \
  130     static inline void name(soft_t *a, float_status *s)                 \
  131     {                                                                   \
  132         if (unlikely(soft_t ## _is_denormal(*a))) {                     \
  133             *a = soft_t ## _set_sign(soft_t ## _zero,                   \
  134                                      soft_t ## _is_neg(*a));            \
  135             s->float_exception_flags |= float_flag_input_denormal;      \
  136         }                                                               \
  137     }

Regards,
BALATON Zoltan

