Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46ECC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA8D20659
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Askna8PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA8D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUB2u-0004rQ-B6
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUB2G-0004IK-LR
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUB2F-00034I-1z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:51:20 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40688)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUB2E-000346-RH
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:51:19 -0500
Received: by mail-ot1-x341.google.com with SMTP id m15so11433548otq.7
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+HrbDuHa2Emu11NCkGhRBg30qDF8ulgWsBtJ38iCy70=;
 b=Askna8PIBPoVR4KEl53GTlYkW+logY2cGp9kSalXsbFWsrkam3jBFWu1mySrSEcjss
 IPkOBJwXWwYVpYU3VOJ1K90scPLj5znC7NDoLov479c3TQUPkenM9lFx2C4IDnIhvXew
 Fy25Kns7KdJ3k4sUHfhPMT+NQKxQy2knHWT32LHzBmySP/kLmvgFQu5Kr2ys7/Sv1Ajt
 OWQ/CSGCrg5+J6b2z+TxwOzqTcEKHw0IyCnIJL2DROVFRNWO2sotV6l3PUX5Fi3JVjvC
 RL0ePVuX0UOKsMR3E+SP5POuhToDi8T/c0KLinZ1sdfoRKqAAn/1+mQIvvng766qYdqN
 nU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+HrbDuHa2Emu11NCkGhRBg30qDF8ulgWsBtJ38iCy70=;
 b=rALUekNW7bMej4X2DKKkUviePWcCX7O0pNLcxOiCQVxM6aswU0B367ClEcHMUZzai5
 UtyOJ0vH2D3HVWLhYIqPE9Cyn/XnFIzv6pSRqUS5LCXlEzZaERB55D1MV3LZ6nylXScT
 QJrOjPN0t3pYPDXTE6qzhFVs09d68b+yGdN4zVU64i7tVoo/sBDe5MrxBCzJYWj0TsPa
 +bnE89XAY2V2ww/CjLjq7H4yqL2xvi4AHm4uJ+3nFZeGVPTyeTv5i1f05Ex9+OwnqZUF
 7Oe16AprL/b9FyvJicPFAHkW0/EoGDKA0CUymw3kDSHvKIYe9p5JLvcuwtaME0fTMYu8
 vJ1A==
X-Gm-Message-State: APjAAAWcLGl3q0edbAi7VwDBbJPdfMQHFz8SbEv8V2znuRggbHFWd6p3
 nV5I4sKwg0Rw96Va1exoI8gGKIuaS6Ta6g65vuUdfw==
X-Google-Smtp-Source: APXvYqxk89QOPIEWf4ImPWmGTSbwD8qDKsgEr43Xn65yi6cT1rfSNKaCHP/GKDFhIrdUkbTccWN0+YuD5xFyH6UYOMg=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr16955128oto.97.1573483877816; 
 Mon, 11 Nov 2019 06:51:17 -0800 (PST)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
 <87eeymx603.fsf@keithp.com>
In-Reply-To: <87eeymx603.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Nov 2019 14:51:06 +0000
Message-ID: <CAFEAcA9rSS8jwSOSFjHd7GZ0gNywEDDJPBJhJ4FxhyqqtjU6OQ@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 05:10, Keith Packard <keithp@keithp.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > I'm going to push for somebody actually writing out a
> > document and putting it somewhere that we can point to
> > and say "that's the authoritative spec", please...
> > it doesn't have to be a big formal thing, but I do
> > think you want it written down, because the whole point
> > is for multiple implementations and users to interoperate.
>
> That happened in June -- I was just looking at the wrong version of the
> spec. In the current version, which can be found here:
>
>         https://riscv.org/specifications/
>
>                    The RISC-V Instruction Set Manual
>                        Volume I: Unprivileged ISA
>                 Document Version 20190608-Base-Ratified
>
> Section 2.8 says:
>
>         Another use of EBREAK is to support =E2=80=9Csemihosting=E2=80=9D=
, where the
>         execution environment includes a debugger that can provide
>         services over an alternate system call interface built around
>         the EBREAK instruction.  Because the RISC-V base ISA does not
>         provide more than one EBREAK instruction, RISC-V semihosting
>         uses a special sequence of instructions to distinguish a
>         semihosting EBREAK from a debugger inserted EBREAK.
>
>                 slli x0, x0, 0x1f   # Entry NOP
>                 ebreak              # Break to debugger
>                 srai x0, x0, 7      # NOP encoding the semihosting call n=
umber 7
>
>         Note that these three instructions must be 32-bit-wide
>         instructions, i.e., they mustn=E2=80=99t be among the compressed =
16-bit
>         instructions described in Chapter 16.
>
>         The shift NOP instructions are still considered available for
>         use as HINTS.
>
>         Semihosting is a form of service call and would be more
>         naturally encoded as an ECALL using an existing ABI, but this
>         would require the debugger to be able to intercept ECALLs, which
>         is a newer addition to the debug standard.  We intend to move
>         over to using ECALLs with a standard ABI, in which case,
>         semihosting can share a service ABI with an existing standard.
>
>         We note that ARM processors have also moved to using SVC instead
>         of BKPT for semihosting calls in newer designs.

That defines the instruction sequence used to make a semihosting
call, but not the specification of what the calls are:
 * what call numbers perform which functions
 * how arguments are passed to the call (registers? parameter
   blocks in memory? other?)
 * the semantics of each function supported (number of arguments,
   behaviour, error handling)

That's really what I had in mind by the overall semihosting spec.

PS: the parenthetical about ARM semihosting at the bottom  of
the text you quote is wrong, incidentally. The traditional insn
for semihosting on A-profile devices has always been SWI/SVC; it
is BKPT only on M-profile devices; and the latest revision of the
semihosting spec recommends the HLT instruction for both A- and M-.

thanks
-- PMM

