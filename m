Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8814C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 22:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC5620857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 22:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1yefkV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC5620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3SqC-0001Hm-Mf
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 17:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jhogan@kernel.org>) id 1j3Soy-0000By-4s
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 17:55:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jhogan@kernel.org>) id 1j3Sow-00079r-Kx
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 17:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jhogan@kernel.org>)
 id 1j3Sow-00078V-Ap; Sun, 16 Feb 2020 17:55:26 -0500
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7FB03206E2;
 Sun, 16 Feb 2020 22:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581893725;
 bh=3NggaOmvOXw2MqkIt726jfs9MLPEIRM1dKQP3jT9fSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B1yefkV9poGFm8rJsCamg3txnV3Qkr2nVEwhC9Ux80NGYlzfP2EVcHymL/6fUDep1
 nbw7wKm90tR2NfWyicx4PJm90cOngqJr26ZayPgqHsPMdkppwRamRVrBVvbAgrycYs
 MyLku/prkJdKnmMUyN7nzYqJH5Jj+jY7mrdEXCoI=
Date: Sun, 16 Feb 2020 22:55:20 +0000
From: James Hogan <jhogan@kernel.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Orphan MIPS KVM CPUs
Message-ID: <20200216225520.GB145683@jamesdev>
References: <20191221155306.49221-1-jhogan@kernel.org>
 <CAAdtpL7CrEAZz5GWJoYCegchQ=-hdkcih07icgoFd-ghJ3nMBw@mail.gmail.com>
 <CAL1e-=jdpp2W-B1cERU4srRQUkPTjewM3hVrndoh4nr-vPSRGA@mail.gmail.com>
 <20200216065717.GA145683@jamesdev>
 <ba671393-7960-1234-6c40-9a8ce29e108a@redhat.com>
 <CAL1e-=hOAs3xmpcyKz2cMQhGaW1J-PntuA9RmHb94vQgc31ttg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=hOAs3xmpcyKz2cMQhGaW1J-PntuA9RmHb94vQgc31ttg@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philippe@mathieu-daude.net>,
 Paul Burton <paulburton@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 16, 2020 at 05:33:44PM +0100, Aleksandar Markovic wrote:
> OK, I will add the patch in the next MIPS queue, since I think its
> significance is more than trivial. It will be sent no later than two weeks
> from now.

Thanks Aleksandar.

> I just wanted the patch to be in the same queue when we will
> provide replacement. But, honestly, if the factual state lasted that long,
> I don't see the reason for such sudden hurry, do you?

Yes.

My main reasons for not wanting this dragged out any longer are:

1) Personally, I just want to let go of it now, and that's slightly
   harder to do when I'm still keeping an eye on whether this patch is
   merged yet, or worse, waiting for Wave to act.

2) In principle it feels wrong to delay a maintainer's name being
   removed at their own request (even if it came late!) for an
   indeterminate amount of time. This patch simply shouldn't be blocked
   waiting for Wave to make a decision I've been waiting to see if it
   would make for too long already.

3) Maybe publicly recognising the orphaned state might motivate Wave or
   others to step up and take a lead with further development.

> Of course I respect James' decision, although I am trully sorry about it.
> My only slight objection is that James should have sent this patch sooner,
> rather than just leave an impression that there is a maintainer, while in
> fact there wasn't. What did you wait?

LOL, well I doubt MIPS (as a company) was under any illusion since they
pulled the trigger :-P

Seriously though, I intended to keep an eye on things in my own time
(both on kernel & QEMU side) and just be ready to answer questions and
hand over the reigns if/when somebody from Wave got up to speed. I was
probably also wary of making MIPS look bad for closing their UK
operation (again) and "orphaning" my code (that I was probably too
emotionally invested in, LOL!).

In practice Paul took care of the MIPS arch stuff and there was
virtually no activity on the MIPS KVM front from Wave so real life
mostly pushed it off my radar. I did discuss orphaning it with Paul last
year but there was mention of Wave folk getting up to speed with it so I
held off for a bit longer.

Anyway FWIW I'm sorry for any confusion caused by my hesitation.

> But, never mind, I understand your
> hesitation. The best outcome would be that James remained in that role (I
> do remember him as an excellent, thorough engineer, that is approachable
> and very helpful to others), but what can we do now. I wish we work
> together in future, who knows? Thanks, James, for taking care of KVM for
> MIPS for number of years!

Thanks, my pleasure.

Cheers
James

