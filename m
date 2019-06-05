Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A5DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5280A2075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpu2qSUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45673 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYVc-0007CL-K0
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:11:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYUl-0006XT-5n
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYUc-0007ut-Oj
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:10:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYYUW-0007WG-If
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:10:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so11823147wrn.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=5iIwwRtZyY8GtXdUlmi/OW8fRJ8i+4Uh0oU6LQn+Hug=;
	b=jpu2qSUhGLdMn4V79gDU+LJXfQup1j3J/I3bZyPxZw7qPCuQD1j2gy3RGCP4zznXp8
	brlhA32VeuJpS/jKaANbNiI9us2v/IfmqUowvLXABSMRFI0JMmAPwVhWlERXA9Zukddu
	llC9SOA2BmfTk7kAQDkf3zfqFpcMmzKf0ciYO+SZMb0Xa5/BXx4Zc/ev/7E4MNvcMh6B
	W+PzFdEt0bvMf0ZXUUTAJYOnmgIrtndgI+FTI9Bnfmt+NXcNAnShEoCH0boSaXSRUm57
	os2CQIKijhpq98EP3NIog9qXlZhwR/NK1d4b/dqti5V/cxr1xvk5dxra4EyZVSvKiUlu
	8e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=5iIwwRtZyY8GtXdUlmi/OW8fRJ8i+4Uh0oU6LQn+Hug=;
	b=pDqikuBlNww2LZ5EwBM51PpgvWLnr3JyZotuoyosd/m5M8+K09ZPz0bpKE/oTm8azM
	U/lWz/EpkztGSwPQssGcS0abmG7WaitE243Y4CAJKPNyRezBAZ6YmkXYQFvTI6Ngg6c+
	2J6Z4pQCxoMfnIc3oPQQMsrkC1/00xgJD1NJO8nUjJWdmYhjwpidJ0I4fXoyZTuJ0n56
	Be4Z3rexqCxOPDjbzy35BDuoDBsYPD7gyk5r3WaN/QmRl/ny3hVKtpMDQ00g021uil2N
	eH7meu/Yo2BIS5d9lW2iAXw1KpRm0lklJBQUWA9+RPwgytNJQTxiEWjuQGYKU1hODKb5
	NI5Q==
X-Gm-Message-State: APjAAAUyZc7cunlWyuDNrUPXLUkgGW/m2oKiqoznuCA8NhGNUkcR0/jw
	4nEcR1VNuU0U52hNVGys0/YB5Q==
X-Google-Smtp-Source: APXvYqx81uxrGOrEfijKo8LncVeK7+3i2w1+sNQblFHQYxPuNHHpEeU3+RDYuAy5df5zA1pEl1QbrQ==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr27306053wrn.258.1559751013519; 
	Wed, 05 Jun 2019 09:10:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	f2sm21670430wrq.48.2019.06.05.09.10.12
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 09:10:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 664B21FF87;
	Wed,  5 Jun 2019 17:10:12 +0100 (BST)
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
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <CAK4993jPs_j9qvv8v2sfZ=npGkbkMAv3HaWSYRiSqFthkvfmdA@mail.gmail.com>
Date: Wed, 05 Jun 2019 17:10:12 +0100
Message-ID: <87o93crp23.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
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
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Michael Rolnik <mrolnik@gmail.com> writes:

> Richard.
>
> We use break instruction for testing. (Here
> https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests).
> Each test is a big list of small tests with a break between them. We run
> the tests on HW and on QEMU then compare register after each break.

This is exactly the same process RISU uses for testing. But it works
with a) linux-user and b) some architecturally defined illegal
instruction that will cause a SIGILL.

> If we
> don't implement break the way Sarah suggested we have no way of
> testing.

So this is the behaviour of AVR simulator when gdb is attached?

> What do you suggest?
>
> Sent from my cell phone, please ignore typos
>
> On Wed, Jun 5, 2019, 5:37 PM Richard Henderson <richard.henderson@linaro.=
org>
> wrote:
>
>> On 6/5/19 2:20 AM, Michael Rolnik wrote:
>> > Hi Richard.
>> >
>> > I am still struggling with this one.
>> >
>> > The spec says.
>> > The BREAK instruction is used by the On-chip Debug system, and is
>> normally not
>> > used in the application software.
>> > When the BREAK instruction is executed, the AVR CPU is set in the
>> Stopped Mode.
>> > This gives the On-chip Debugger access to internal resources.
>> > If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are
>> unprogrammed,
>> > the CPU will treat the BREAK instruction as a NOP and will not enter t=
he
>> > Stopped mode.
>>
>> Yep.
>>
>> > I read is as follows
>> > - If user has an intention of using debugger, BREAK should be translat=
ed
>> to
>> > QEMU debug breakpoint
>> > - If user has no intention of using debugger, BREAK should be translat=
ed
>> into NOP.
>>
>> I do not read it that way.  The spec is talking about a specific
>> implementation
>> of debugging -- fuses, jtag and all.  We do not need to implement
>> breakpoints
>> using any of those mechanisms, because we can insert breakpoints via
>> on-the-side data structures and re-translation.
>>
>>
>> r~
>>
>
> On Wed, Jun 5, 2019, 5:37 PM Richard Henderson <richard.henderson@linaro.=
org>
> wrote:
>
>> On 6/5/19 2:20 AM, Michael Rolnik wrote:
>> > Hi Richard.
>> >
>> > I am still struggling with this one.
>> >
>> > The spec says.
>> > The BREAK instruction is used by the On-chip Debug system, and is
>> normally not
>> > used in the application software.
>> > When the BREAK instruction is executed, the AVR CPU is set in the
>> Stopped Mode.
>> > This gives the On-chip Debugger access to internal resources.
>> > If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are
>> unprogrammed,
>> > the CPU will treat the BREAK instruction as a NOP and will not enter t=
he
>> > Stopped mode.
>>
>> Yep.
>>
>> > I read is as follows
>> > - If user has an intention of using debugger, BREAK should be translat=
ed
>> to
>> > QEMU debug breakpoint
>> > - If user has no intention of using debugger, BREAK should be translat=
ed
>> into NOP.
>>
>> I do not read it that way.  The spec is talking about a specific
>> implementation
>> of debugging -- fuses, jtag and all.  We do not need to implement
>> breakpoints
>> using any of those mechanisms, because we can insert breakpoints via
>> on-the-side data structures and re-translation.
>>
>>
>> r~
>>


--
Alex Benn=C3=A9e

