Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D4DC1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9CB420722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 20:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CB420722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG7Uw-0008J3-Ug
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 16:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jG7U0-0007Ry-R3
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jG7Tz-0006rr-3K
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:46:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:49216)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jG7Ty-0006qD-Te
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 16:46:07 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 40300747DF7;
 Sun, 22 Mar 2020 21:46:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1E732747DCF; Sun, 22 Mar 2020 21:46:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1CDB87476D5;
 Sun, 22 Mar 2020 21:46:03 +0100 (CET)
Date: Sun, 22 Mar 2020 21:46:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2003222134560.60771@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
 <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
 <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
 <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 22 Mar 2020, Peter Maydell wrote:
> On Sun, 22 Mar 2020 at 19:52, Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>> If an end-user feature works only in in-tree builds (so,
>> explitely said: not in out-of-tree builds), this is not
>> a build-time stuff, but user-facing feature issue.
>
> gprof is a developer feature, not an end-user-facing
> feature. By the latter I mean "some feature that users
> who have installed a built binary might be using":
> command line stuff, actual functionality in the QEMU
> binary, QMP protocol, that kind of thing.
>
>> If someone is keen on removing any feature (as is truly in this case), I expect at least some moderate investigation being done on what could be affected (prior to announcing deprecation), rather than attitude "ok, let's announce deprecation, see if someone start clamoring, and, if not, we are good to go with removing". For me, this slightly disappointing.
>
> Before you told me about the gprof issue, the *only* thing

Was that gprof or gcov?

> I was aware of that might break was the coverity scan build,
> which is a purely project internal bit of infrastructure.

Plus potentially any scripts people might use to build stuff and distro 
packagers that might use in-tree build. They would suddently find their 
previously working scripts are now broken and they need to adapt. While 
making sure running configure; make; make install in source tree even if 
it actually does a build in a new build dir it creates automatically would 
be less annoying change than having to manually manage out-of-tree build 
dirs by those who did not do that so far.

Is it really that difficult to add a CI job to do a git clone then 
configure; make; make install in it to make sure it breaks less often? And 
to make sure this still works after in-tree builds are deprecated and 
removed? I think we can't check every distro packager or don't know what 
users do but supporting the usual way of building packages used by many 
may worth the little extra effort to not annoy users/developers 
unnecessarily.

Regards,
BALATON Zoltan

