Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2218AC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:24:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC592082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC592082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUB3K-0006gw-3D
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUAyu-0005JC-G9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jUAvV-0004uf-Pk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:20:07 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:17637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jUAvV-0004ry-AF; Thu, 30 Apr 2020 11:16:37 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BA11E746351;
 Thu, 30 Apr 2020 17:16:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 96589746344; Thu, 30 Apr 2020 17:16:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 94DC474633F;
 Thu, 30 Apr 2020 17:16:23 +0200 (CEST)
Date: Thu, 30 Apr 2020 17:16:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: About hardfloat in ppc
In-Reply-To: <87ftcoknvu.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2004301648440.29315@zero.eik.bme.hu>
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1425488018-1588259783=:29315"
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
Cc: luoyonggang@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1425488018-1588259783=:29315
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Apr 2020, Alex Bennée wrote:
> 罗勇刚(Yonggang Luo) <luoyonggang@gmail.com> writes:
>> I am confusing why only  inexact  are set then we can use hard-float.
>
> The inexact behaviour of the host hardware may be different from the
> guest architecture we are trying to emulate and the host hardware may
> not be configurable to emulate the guest mode.
>
> Have a look in softfloat.c and see all the places where
> float_flag_inexact is set. Can you convince yourself that the host
> hardware will do the same?

Can you convince me that it won't? This all seems to be guessing without 
evidence so I think what we need first is some tests to prove it either 
way. Such tests could then also be used at runtime to decide if the host 
and guest FPU are compatible enough to enable hardfloat. Are such tests 
available somewhere or what would need to be done to implement them?

This may not solve the problem with PPC target with non-cumulative status 
bits but could improve hardfloat performance at least for some host-guest 
combinations. To see if it worth the effort we should run such test on 
common combinations (say x86_64. ARM and PPC hosts with at least these 
guests).

>> And PPC always clearing inexact  flag before calling to soft-float
>> funcitons. so we can not
>> optimize it with hard-float.
>> I need some resouces about ineact flag and why always clearing inexcat in
>> PPC FP simualtion.
>
> Because that is the behaviour of the PPC floating point unit. The
> inexact flag will represent the last operation done.

More precisely additional to the usual cumulative (or sticky) bits there 
are two non-sticky bits for inexact and rounded (latter of which is not 
emulated) that currently need clearing FP status before every FP op. I 
wonder if we can know when the guest reads these and rerun the last FP op 
in softfloat to compute them only if these are read, then it's enough to 
remember the last FP op. This could be relatively simple and may be used 
even if we don't detect accessing the bits within FPSCR just accessing the 
FPSCR as likely most guest code does not check that and any cross-platform 
code won't check PPC specific non-sticky bits so I'd exepect most guest 
code to be fine with hardfloat. Although what about FP exceptions? We also 
need to revert to softfloat it FP exceptions are enabled so maybe using 
host FP exception for managing status bits could be the way to go to let 
hardware manage this and we don't need to implement everything in 
software.

Regards,
BALATON Zoltan
--3866299591-1425488018-1588259783=:29315--

