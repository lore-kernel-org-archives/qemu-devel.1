Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B91C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBDF2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IObK/vTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBDF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwrz-0006Eq-5v
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 11:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jEwrN-0005ot-LY
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jEwrL-0006Wq-4k
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:13:25 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jEwrK-0006Tq-S1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:13:23 -0400
Received: by mail-lf1-x144.google.com with SMTP id x143so1913096lff.12
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/uotPJyrFZ0V5dJBIBxpoXcAAW/RZupCPGuZpTwdN+s=;
 b=IObK/vTbu2r1EwtJUxcOkt/weNgwAIs+CHTDvFgznXHZYVnCuvygzfOBa4JLbHT97b
 W9XtSA7rUSeyqs4nYmn9mTKNKjGB079S+l2sxY3DvKZFnHs93Sb1SYARR39KY1nD5L26
 /tKgb1jIfCLitehDbmJwfWQipefcZm7L02maSR1IKYDj3oB3T83NhKnIgOSh9+KEIgNl
 TKDSLoErLO8Nl1dNdDkofdlbfXby0LIXIuFEbQ7kA4LH+4gbAwq0FBa7ki43wI29SXcr
 z5XGe0X6erHAQQGBtOyfxylFoG3kI/gx/XwBTVRsH+cX4Pz5xNURnZMmaTjSAEji452K
 LLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/uotPJyrFZ0V5dJBIBxpoXcAAW/RZupCPGuZpTwdN+s=;
 b=NXstnMlTewEnV/CBPFDdyNF71/BhtP0q96/7oh0NMa0qaK+ICNc7J954eh7TqHZQQH
 7PMPZDiHalOrPfx1MMYXA0OYjGyCgS8c4Fh7EFr8CjIHcbpqQGFMjLuvmMXzknivAWgS
 mWJwRuhgrQ3UxgHE9TCbZ124n0rd317Lnls54r4YFplCgnzjztFvG9z76ZUdfAn7hrQz
 nCUyVUuPwQwlD42kw2EEKyYEngAwWIwdERJTm3F/tKSimLkodeLqK2KteKMzQkhQzvsQ
 CL9gKmVNpEqOc/XWWIcbOtUFNkUmM7pCV4sHURVnZI82khnU3sE/M3b8pupByMxcxl/S
 UvyA==
X-Gm-Message-State: ANhLgQ3KCMAQYPauuZTCDAymlPDXSEuW1Pj3SHT9EDPT9AdLm2QML3AO
 lve1jYw7yE9XB2eeXHwFbAu8uDgbttTPNZ7BqE/fHw==
X-Google-Smtp-Source: ADFU+vu1xSj2mSTjDUg4SXO/2v8/tid2EhIWeZkU86OKVTq9D1e8crqiiKiOF6X8KpVKbvzB2tB2QO5h9YFRavOMQH4=
X-Received: by 2002:ac2:4552:: with SMTP id j18mr2475295lfm.89.1584630800987; 
 Thu, 19 Mar 2020 08:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9mXE+gPnvM6HZ-w0+BhbpeuH=osFH-9NUzCLv=w-c7HQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 19 Mar 2020 16:13:09 +0100
Message-ID: <CACRpkdZtLNUwiZEMiJEoB0ojOBckyGcZeyFkR6MC69qv-ry9EA@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To: Peter Maydell <peter.maydell@linaro.org>,
 "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Theodore Ts'o <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, stable <stable@vger.kernel.org>,
 Florian Weimer <fw@deneb.enyo.de>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 12:58 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 17 Mar 2020 at 11:31, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > It was brought to my attention that this bug from 2018 was
> > still unresolved: 32 bit emulators like QEMU were given
> > 64 bit hashes when running 32 bit emulation on 64 bit systems.
> >
> > The personality(2) system call supports to let processes
> > indicate that they are 32 bit Linux to the kernel. This
> > was suggested by Teo in the original thread, so I just wired
> > it up and it solves the problem.
>
> Thanks for having a look at this. I'm not sure this is what
> QEMU needs, though. When QEMU runs, it is not a 32-bit
> process, it's a 64-bit process. Some of the syscalls
> it makes are on behalf of the guest and would need 32-bit
> semantics (including this one of wanting 32-bit hash sizes
> in directory reads). But some syscalls it makes for itself
> (either directly, or via libraries it's linked against
> including glibc and glib) -- those would still want the
> usual 64-bit semantics, I would have thought.

The "personality" thing is a largely unused facility that
a process can use to say it has this generic behaviour.
In this case we say we have the PER_LINUX32 personality
so it will make the process evoke 32bit behaviours inside
the kernel when dealing with this process.

Which I (loosely) appreciate that we want to achieve.

> > Programs that need the 32 bit hash only need to issue the
> > personality(PER_LINUX32) call and things start working.
>
> What in particular does this personality setting affect?
> My copy of the personality(2) manpage just says:
>
>        PER_LINUX32 (since Linux 2.2)
>               [To be documented.]
>
> which isn't very informative.

It's not a POSIX thing (not part of the Single Unix Specification)
so as with most Linux things it has some fuzzy semantics
defined by the community...

I usually just go to the source.

If you grep the kernel what turns up is a bunch of
architecture-specific behaviors on arm64, ia64, mips, parisc,
powerpc, s390, sparc. They are very minor.

On x86_64 the semantic effect is
none so this would work for any kind of 32bit userspace
on x86_64. It would be the first time this flag has any
effect at all on x86_64, but arguably a useful one.

I would not be surprised if running say i586 on x86_64
has the same problem, just that noone has reported
it yet. But what do I know. If they have the same problem
they can use the same solution. Hm QEMU supports
emulating i586 or even i386 ... maybe you could test?
Or tell me how to test? We might be solving a bigger
issue here.

Yours,
Linus Walleij

