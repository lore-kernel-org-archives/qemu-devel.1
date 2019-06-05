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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3D7C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A49B2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi51aB0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A49B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44395 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXi7-0002P7-Fk
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:20:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hYXhA-00026K-5g
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hYXh8-000486-Hx
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:19:20 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hYXh8-00047A-Do
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:19:18 -0400
Received: by mail-qk1-x742.google.com with SMTP id c70so5355410qkg.7
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=LROlq/CnUShw/aJ9eLHb3kjKzLMl3nhEXcP1KyAgM3U=;
	b=Oi51aB0PEER17ka78Z4c947jP5jn9JiJ7ZGknq1BondbMV5pepLjpiCthzXSRBQnvm
	3bla5fSmMu3eGIXfUL2IzECvs6zTgKNU7A/UcTPEJYaNOpjyVjDwTQ5gOhCLJgi/lr20
	ghyHifLkMU3tZikqAcIkFANnSwKwClQn2Hrjj1c/qbu6+Lx8CUy+kJirLTtrDUC89Nr6
	l/sNoyHpndp7FksO9jsJbUeTxy/ulQ2tGHpb9hpvBMsy53ZlRR0jHqn/ie2sxO6Wwmce
	1RLMyuD3d0+Ni80UobvmUz/R7NskT3s5pj8M9uyBx+OteeIU+z9ACUWSGbJS1OYdQz+B
	bSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=LROlq/CnUShw/aJ9eLHb3kjKzLMl3nhEXcP1KyAgM3U=;
	b=LhAI7iHPkGQYppbCRTkPHgs0TT84JDUX08NXRGu7RbcfLitX/2dT1/8eucmXXLbT5L
	z3x/5Sd62QklSeI5gb6XBIsk+OaULoxLfUHjqtn11tL3YNyTBehhKRlfiwClFTqYiQX2
	fRJM7r+q93NEgUdLf9DXxojRjZVNTC3QMhpWrhZWMlQgMumecbPxO+0p56qALnm7kQcZ
	hqoGqe31uC2K4/Huf98Wh5225SfypRzLbnc/TJ+yR2o3u5B+8mIumX82eMh5c2QnlKRd
	+piFriY/jiQortVBO6wCb7vpHlLevlJW0TAgqb6u85c7OBvP/AmjNuiYFeZ95R/NIelM
	wS2A==
X-Gm-Message-State: APjAAAVto/zxC93zPfz3QiwIG3gdF2q5dVn2NHhuGrPssNeu2m4hVrjf
	aG4EKZjdaHaUDis0ZM1natEHvjbjI8wVWI3EY5w=
X-Google-Smtp-Source: APXvYqwwO7TAUbiNcbUNuPwostUOGidx2Jhv4zCu0+Sh/sMPn9u5tVQlR+JZLXp1d14Wj3UyHv03rx7c9P2UTwu0DzY=
X-Received: by 2002:a37:b8c5:: with SMTP id i188mr14015188qkf.7.1559747956834; 
	Wed, 05 Jun 2019 08:19:16 -0700 (PDT)
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
In-Reply-To: <7b0c5e07-5b99-3344-7f80-847880f85b5b@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 5 Jun 2019 18:19:02 +0300
Message-ID: <CAK4993jPs_j9qvv8v2sfZ=npGkbkMAv3HaWSYRiSqFthkvfmdA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::742
Content-Type: text/plain; charset="UTF-8"
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
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Richard.

We use break instruction for testing. (Here
https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests).
Each test is a big list of small tests with a break between them. We run
the tests on HW and on QEMU then compare register after each break. If we
don't implement break the way Sarah suggested we have no way of testing.
What do you suggest?

Sent from my cell phone, please ignore typos

On Wed, Jun 5, 2019, 5:37 PM Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 6/5/19 2:20 AM, Michael Rolnik wrote:
> > Hi Richard.
> >
> > I am still struggling with this one.
> >
> > The spec says.
> > The BREAK instruction is used by the On-chip Debug system, and is
> normally not
> > used in the application software.
> > When the BREAK instruction is executed, the AVR CPU is set in the
> Stopped Mode.
> > This gives the On-chip Debugger access to internal resources.
> > If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are
> unprogrammed,
> > the CPU will treat the BREAK instruction as a NOP and will not enter the
> > Stopped mode.
>
> Yep.
>
> > I read is as follows
> > - If user has an intention of using debugger, BREAK should be translated
> to
> > QEMU debug breakpoint
> > - If user has no intention of using debugger, BREAK should be translated
> into NOP.
>
> I do not read it that way.  The spec is talking about a specific
> implementation
> of debugging -- fuses, jtag and all.  We do not need to implement
> breakpoints
> using any of those mechanisms, because we can insert breakpoints via
> on-the-side data structures and re-translation.
>
>
> r~
>

On Wed, Jun 5, 2019, 5:37 PM Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 6/5/19 2:20 AM, Michael Rolnik wrote:
> > Hi Richard.
> >
> > I am still struggling with this one.
> >
> > The spec says.
> > The BREAK instruction is used by the On-chip Debug system, and is
> normally not
> > used in the application software.
> > When the BREAK instruction is executed, the AVR CPU is set in the
> Stopped Mode.
> > This gives the On-chip Debugger access to internal resources.
> > If any Lock bits are set, or either the JTAGEN or OCDEN Fuses are
> unprogrammed,
> > the CPU will treat the BREAK instruction as a NOP and will not enter the
> > Stopped mode.
>
> Yep.
>
> > I read is as follows
> > - If user has an intention of using debugger, BREAK should be translated
> to
> > QEMU debug breakpoint
> > - If user has no intention of using debugger, BREAK should be translated
> into NOP.
>
> I do not read it that way.  The spec is talking about a specific
> implementation
> of debugging -- fuses, jtag and all.  We do not need to implement
> breakpoints
> using any of those mechanisms, because we can insert breakpoints via
> on-the-side data structures and re-translation.
>
>
> r~
>
