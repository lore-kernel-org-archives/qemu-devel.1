Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73633C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4505320575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4505320575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT178-0000Yg-Ac
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jT164-0007ed-Bh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jT162-00054F-Iq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:34:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:17993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jT15y-0004pQ-V6; Mon, 27 Apr 2020 06:34:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B391874632B;
 Mon, 27 Apr 2020 12:34:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8B844746307; Mon, 27 Apr 2020 12:34:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A0DE74633E;
 Mon, 27 Apr 2020 12:34:28 +0200 (CEST)
Date: Mon, 27 Apr 2020 12:34:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: About hardfloat in ppc
In-Reply-To: <87lfmhl0xa.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-446172340-1587982415=:94232"
Content-ID: <alpine.BSF.2.22.395.2004271213480.94232@zero.eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 06:34:29
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
Cc: luoyonggang@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-446172340-1587982415=:94232
Content-Type: text/plain; CHARSET=GB2312; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.BSF.2.22.395.2004271213481.94232@zero.eik.bme.hu>

On Mon, 27 Apr 2020, Alex Benn¨¦e wrote:
> ÂÞÓÂ¸Õ(Yonggang Luo) <luoyonggang@gmail.com> writes:
>> Because ppc fpu-helper are always clearing float_flag_inexact,
>> So is that possible to optimize the performance when  float_flag_inexact
>> are cleared?
>
> There was some discussion about this in the last thread about enabling
> hardfloat for PPC. See the thread:
>
>  Subject: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
>  Date: Tue, 18 Feb 2020 18:10:16 +0100
>  Message-Id: <20200218171702.979F074637D@zero.eik.bme.hu>

I've answered this already with link to that thread here:

On Fri, 10 Apr 2020, BALATON Zoltan wrote:
: Date: Fri, 10 Apr 2020 20:04:53 +0200 (CEST)
: From: BALATON Zoltan <balaton@eik.bme.hu>
: To: "ÂÞÓÂ¸Õ(Yonggang Luo)" <luoyonggang@gmail.com>
: Cc: qemu-devel@nongnu.org, Mark Cave-Ayland, John Arbuckle, qemu-ppc@nongnu.org, Paul Clarke, Howard Spoelstra, David Gibson
: Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
:
: On Fri, 10 Apr 2020, ÂÞÓÂ¸Õ(Yonggang Luo) wrote:
:> Are this stable now? I'd like to see hard float to be landed:)
:
: If you want to see hardfloat for PPC then you should read the replies to 
: this patch which can be found here:
:
: http://patchwork.ozlabs.org/patch/1240235/
:
: to understand what's needed then try to implement the solution with FP 
: exceptions cached in a global that maybe could work. I won't be able to 
: do that as said here:
:
: https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00006.html
:
: because I don't have time to learn all the details needed. I think 
: others are in the same situation so unless somebody puts in the 
: necessary effort this won't change.

Which also had a proposed solution to the problem that you could try to 
implement, in particular see this message:

http://patchwork.ozlabs.org/project/qemu-devel/patch/20200218171702.979F074637D@zero.eik.bme.hu/#2375124

amd Richard's reply immediately below that. In short to optimise FPU 
emulation we would either find a way to compute inexact flag quickly 
without reading the FPU status (this may not be possible) or somehow get 
status from the FPU but the obvious way of claring the flag and reading 
them after each operation is too slow. So maybe using exceptions and only 
clearing when actually there's a change could be faster.

As to how to use exceptions see this message in above thread:

https://lists.nongnu.org/archive/html/qemu-ppc/2020-03/msg00005.html

But that's only to show how to hook in an exception handler what it does 
needs to be implemented. Then tested and benchmarked.

I still don't know where are the extensive PPC floating point tests to use 
for checking results though as that was never answered.

> However in short the problem is if the float_flag_inexact is clear you
> must use softfloat so you can properly calculate the inexact status. We
> can't take advantage of the inexact stickiness without loosing the
> fidelity of the calculation.

I still don't get why can't we use hardware via exception handler to 
detect flags for us and why do we only use hardfloat in some corner cases. 
If reading the status is too costly then we could mirror it in a global 
which is set by an FP exception handler. Shouldn't that be faster? Is 
there a reason that can't work?

Regards,
BALATON Zoltan
--3866299591-446172340-1587982415=:94232--

