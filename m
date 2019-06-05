Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE86C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EFC2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js6vr9Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EFC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47946 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYaBc-0004sE-Pl
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 13:58:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hYaAc-0004RY-Qc
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hYaAb-0000EJ-1K
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:57:54 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:40769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hYaAa-0000By-Sk
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 13:57:52 -0400
Received: by mail-qt1-x843.google.com with SMTP id a15so4535385qtn.7
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=XyH0yxy5zTvePzTnQoOM/IWLMoO3wbM8atRdve0vBkE=;
	b=js6vr9ZpWp9kE0bN0hQKsY7gost0W79IleE6M+eXwQ+ynzcTkvIxYBTmrkgWLkfXWv
	PUYGVGMXcTmykdNe4b7qin7QlFbJYMPsbwbe51E+ASD+mNvzMexrhTCj3TOY+6BSTgYN
	mDwFFfS7jE6sCd5SeJ6PlIXXOjidOGuw9vw2ApsQeNdBHf3wl3tEvghEV9ihIuJD6MQS
	dvjAL8OzMgmZ8JTRNDt+UODJI1MYx48oGsz9+kEMeRuCJJlurFKU26BNGvSC64ZbobsC
	vkqqJMd8p/WepLeH2427+nCna38/KbYsjpiDyQVEk+wN21SS7f5qbsGwXSLWpDrBbw3z
	GeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=XyH0yxy5zTvePzTnQoOM/IWLMoO3wbM8atRdve0vBkE=;
	b=iQb/ynSyYsxwGNxe6ugYQTu6cWNSFwkK51vUfl3hhuQiP7zeE9AeCaVjwe54/9oc+s
	pBc74oF5smaXmGuDxympcZQexZ0JkFAuIzaEJcC7uSw58T3q5zYXmcypjW5/QmbXdYdq
	ZfQq9r6CoPc49iX8rYA1hx3KXPKyal7N/u5GHCzpyUExK/2qIE9qeW5V2dz0Kq0GM5Wn
	jxfi7Flksy7g15DV+d9y1fEJFfiYqo8l2Q2aYt8UoeyIfiVO+0e80Di7OkrVudct/kJc
	tdRXEckINTXumYZzBsY7uvZfpJu+/zjM+pzS/nXkS7ue2klIU6xW7t83eiNQMEll3PJv
	ou/g==
X-Gm-Message-State: APjAAAVIdAnm+1/PppPGSlUCRsvNxFZwwS+3rkaburSTPB2PTIKkaBFw
	fS/k3zb6c7KtS6UwkvyVJA6DIgIHU7E4POvnaHw=
X-Google-Smtp-Source: APXvYqxFVNi47eCrrRAWFcTfdiCaNWzUQUiQBtclC9CqyaF2oTJf6qyq5FVpmPnvPwYxbdliQEb0exTbaseFU2TIVzM=
X-Received: by 2002:a0c:bf4a:: with SMTP id b10mr33452368qvj.120.1559757471563;
	Wed, 05 Jun 2019 10:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-4-mrolnik@gmail.com>
	<402ba0b2-e2e0-6b7a-1862-4588e5f83357@linaro.org>
	<CAK4993iXV9oRr_VfabJHg4fCYEppW49i_PE9R0X_TBqk7TDkrQ@mail.gmail.com>
	<9e2acbbe-7ede-c45d-5e9f-bb269aa25fcc@linaro.org>
	<CAK4993hXTOSoW5FFjeur+pLzT18c-C=vwao-904ASyqMsT5eMQ@mail.gmail.com>
	<3bc0d426-bd59-055d-a010-b136cba555bf@linaro.org>
	<CAK4993j5JXgV9CYDckt99kwgQaG6w-GN-Tka7r2nahoh33rheQ@mail.gmail.com>
	<CAK4993jWViasj8PKUCHcbMh-9SPJmELqua9eSbFvwL7gpm2e5A@mail.gmail.com>
	<7b0c5e07-5b99-3344-7f80-847880f85b5b@linaro.org>
	<CAK4993jPs_j9qvv8v2sfZ=npGkbkMAv3HaWSYRiSqFthkvfmdA@mail.gmail.com>
	<87o93crp23.fsf@zen.linaroharston>
In-Reply-To: <87o93crp23.fsf@zen.linaroharston>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 5 Jun 2019 20:57:10 +0300
Message-ID: <CAK4993hUtq72tfdzM8hTPRZkBL-Djcs6x6=SVQtHLizkciHhaA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::843
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH RFC v20 3/8] target/avr: Add mechanism to
 check for active debugger connection
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just ran the test with simavr, once it hit BREAK, gdb stopped

On Wed, Jun 5, 2019 at 7:12 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:

>
> Michael Rolnik <mrolnik@gmail.com> writes:
>
> > Richard.
> >
> > We use break instruction for testing. (Here
> > https://github.com/seharris/qemu-avr-tests/tree/master/instruction-test=
s
> ).
> > Each test is a big list of small tests with a break between them. We ru=
n
> > the tests on HW and on QEMU then compare register after each break.
>
> This is exactly the same process RISU uses for testing. But it works
> with a) linux-user and b) some architecturally defined illegal
> instruction that will cause a SIGILL.
>
> > If we
> > don't implement break the way Sarah suggested we have no way of
> > testing.
>
> So this is the behaviour of AVR simulator when gdb is attached?
>
> > What do you suggest?
> >
> > Sent from my cell phone, please ignore typos
> >
> > On Wed, Jun 5, 2019, 5:37 PM Richard Henderson <
> richard.henderson@linaro.org>
> > wrote:
> >
> >> On 6/5/19 2:20 AM, Michael Rolnik wrote:
> >> > Hi Richard.
> >> >
> >> > I am still struggling with this one.
> >> >
> >> > The spec says.
> >> > The BREAK instruction is used by the On-chip Debug system, and is
> >> normally not
> >> > used in the application software.
> >> > When the BREAK instruction is executed, the AVR CPU is set in the
> >> Stopped Mode.
> >> > This gives the On-chip Debugger access to internal resources.
> >> > If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are
> >> unprogrammed,
> >> > the CPU will treat the BREAK instruction as a NOP and will not enter
> the
> >> > Stopped mode.
> >>
> >> Yep.
> >>
> >> > I read is as follows
> >> > - If user has an intention of using debugger, BREAK should be
> translated
> >> to
> >> > QEMU debug breakpoint
> >> > - If user has no intention of using debugger, BREAK should be
> translated
> >> into NOP.
> >>
> >> I do not read it that way.  The spec is talking about a specific
> >> implementation
> >> of debugging -- fuses, jtag and all.  We do not need to implement
> >> breakpoints
> >> using any of those mechanisms, because we can insert breakpoints via
> >> on-the-side data structures and re-translation.
> >>
> >>
> >> r~
> >>
> >
> > On Wed, Jun 5, 2019, 5:37 PM Richard Henderson <
> richard.henderson@linaro.org>
> > wrote:
> >
> >> On 6/5/19 2:20 AM, Michael Rolnik wrote:
> >> > Hi Richard.
> >> >
> >> > I am still struggling with this one.
> >> >
> >> > The spec says.
> >> > The BREAK instruction is used by the On-chip Debug system, and is
> >> normally not
> >> > used in the application software.
> >> > When the BREAK instruction is executed, the AVR CPU is set in the
> >> Stopped Mode.
> >> > This gives the On-chip Debugger access to internal resources.
> >> > If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are
> >> unprogrammed,
> >> > the CPU will treat the BREAK instruction as a NOP and will not enter
> the
> >> > Stopped mode.
> >>
> >> Yep.
> >>
> >> > I read is as follows
> >> > - If user has an intention of using debugger, BREAK should be
> translated
> >> to
> >> > QEMU debug breakpoint
> >> > - If user has no intention of using debugger, BREAK should be
> translated
> >> into NOP.
> >>
> >> I do not read it that way.  The spec is talking about a specific
> >> implementation
> >> of debugging -- fuses, jtag and all.  We do not need to implement
> >> breakpoints
> >> using any of those mechanisms, because we can insert breakpoints via
> >> on-the-side data structures and re-translation.
> >>
> >>
> >> r~
> >>
>
>
> --
> Alex Benn=C3=A9e
>
>

--=20
Best Regards,
Michael Rolnik
