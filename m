Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40631C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158EA20661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158EA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBFY-0003AI-3Y
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUBEK-00023m-MZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUBEH-0007vq-Pd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:36:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:47403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jUBEH-0007v8-9T; Thu, 30 Apr 2020 11:36:01 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 03714746351;
 Thu, 30 Apr 2020 17:35:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C7012746344; Thu, 30 Apr 2020 17:35:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C585374633F;
 Thu, 30 Apr 2020 17:35:55 +0200 (CEST)
Date: Thu, 30 Apr 2020 17:35:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?GB2312?Q?=C2=DE=D3=C2=B8=D5=28Yonggang_Luo=29?= <luoyonggang@gmail.com>
Subject: Re: R: R: About hardfloat in ppc
In-Reply-To: <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2004301721420.29315@zero.eik.bme.hu>
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87sggmjgit.fsf@linaro.org>
 <CAE2XoE8wFK1nOq3YXhB=iqTvqSDQk7Zzd35Tjzdd==v8ouMijA@mail.gmail.com>
 <43ac337c-752a-7151-1e88-de01949571de@linaro.org>
 <CAE2XoE-f_rkcnpQO1cHPUgdaWNAOvBRyUX1aj27UePd0Hkr=KQ@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1869358469-1588260955=:29315"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Dino Papararo <skizzato73@msn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1869358469-1588260955=:29315
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 30 Apr 2020, 罗勇刚(Yonggang Luo) wrote:
> I propose a new way to computing the float flags,
> We preserve a  float computing cash
> typedef struct FpRecord {
>  uint8_t op;
>  float32 A;
>  float32 B;
> }  FpRecord;
> FpRecord fp_cache[1024];
> int fp_cache_length;
> uint32_t fp_exceptions;
>
> 1. For each new fp operation we push it to the  fp_cache,
> 2. Once we read the fp_exceptions , then we re-compute
> the fp_exceptions by re-running the fp FpRecord sequence.
> and clear  fp_cache_length.
> 3. If we clear the fp_exceptions , then we set fp_cache_length to 0 and
> clear  fp_exceptions.
> 4. If the  fp_cache are full, then we re-compute
> the fp_exceptions by re-running the fp FpRecord sequence.
>
> Would this be a general method to use hard-float?
> The consued time should be  2*hard_float.
> Considerating read fp_exceptions are rare, then the amortized time
> complexity
> would be 1 * hard_float.

It's hard to guess what the hit rate of such cache would be and if it's 
low then managing the cache is probably more expensive than running with 
softfloat. So to evaluate any proposed patch we also need some benchmarks 
which we can experiment with to tell if the results are good or not 
otherwise we're just guessing. Are there some existing tests and 
benchmarks that we can use? Alex mentioned fp-bench I think and to 
evaluate the correctness of the FP implementation I've seen this other 
conversation:

https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg05107.html
https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg05126.html

Is that something we can use for PPC as well to check the correctness?

So I think before implementing any potential solution that came up in this 
brainstorming the first step would be to get and compile (or write if not 
available) some tests and benchmarks:

1. testing host behaviour for inexact and compare that for different archs
2. some FP tests that can be used to compare results with QEMU and real 
CPU to check correctness of emulation (if these check for inexact 
differences then could be used instead of 1.)
3. some benchmarks to evaluate QEMU performance (these could be same as FP 
tests or some real world FP heavy applications).

Then we can see if the proposed solution is faster and still correct.

Regards,
BALATON Zoltan
--3866299591-1869358469-1588260955=:29315--

