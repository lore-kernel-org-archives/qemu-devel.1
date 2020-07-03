Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C88C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12FC2088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFIB5uOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12FC2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNpW-0005s8-10
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrNof-0004X1-V2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:41:29 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrNod-00027t-K6
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:41:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id y22so14206533oie.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JI0mmWI1opmX6Cii+QmjTbUs4ooas1vaApI+tH+tDzI=;
 b=lFIB5uOFpysYhnHA9mCDRJQjByHa92OEZhUF4Rqdj47p98P2h7m/kAA2GNFqyx33Aa
 4Y2DCsYDQ2VGDsGRmqv4rnQ8yhqDJ8JYdfONbOQwjpI6Mawwa/p+/y+2iYh5I6gE52Xn
 6IZlMIFIswQPh3bvHMA8wfvW7i6Kt1AR7GL9Yic/A8wi0572KlKRBDcmdeeOEsrWuTtN
 UVX2QiHuRFnA1E1UDlKlhTJt4kpfhr6pK3bB8Fa8UkNxZXhRebBnbgSoekaszsHwpAzi
 yn/PyTLI38XQtgUjGfbOFgzsXKPQC3jUh2qGeNr0ixM4bBRkTXDCX/CHg/HmImg5Aeo0
 9BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JI0mmWI1opmX6Cii+QmjTbUs4ooas1vaApI+tH+tDzI=;
 b=TGSxHkXn4MlYPYHvisE4fkffzkwMSz+CBQ0Uzsng91m2KwouYrkKM3effYtoH56QpB
 bsTkFE7ca5SYIgOESzE8ntFjFJPkJLtrzT8Q9NCTnmpF+QRqWNKfaHUTAqJ7rGZWR5gO
 w3fGAdielyXh3uY32tyL09hUwaXd1Nqy+AZB7raMbYqISPYqOgonSMNV4D5wwQoGCN42
 zCDEsGb3DAUec+9gj7EJFCGMkg/vkkLJ7xA/f2rCZ0p+4ZtDncBZOMCrXSVkSIFKcQQc
 wsbJAZrqKudfgLiRGyFUh9dbpOURr3feVodW5lXYpCLI8v/hO2qpRdfVF2d6pvXT60WM
 Hr4w==
X-Gm-Message-State: AOAM532QfGgd3b1ZgN+rlMrttaoeo+LH0biuzSDye51K+2zkD7zVNduI
 6tbC/3USItS4FpRBXEwx65aE5Hk7J1DSZ+IkJtwvnA==
X-Google-Smtp-Source: ABdhPJzULYnX3+TthN6kgbBUDiZyXMK28kbDBrUlStgQEP9skLwEMs22kfI7gLWHg53aevy0mRk2iZlH+W35YuKA/ko=
X-Received: by 2002:aca:1706:: with SMTP id j6mr968169oii.146.1593790886057;
 Fri, 03 Jul 2020 08:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200701161153.30988-1-alex.bennee@linaro.org>
 <20200701161153.30988-4-alex.bennee@linaro.org>
In-Reply-To: <20200701161153.30988-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 16:41:15 +0100
Message-ID: <CAFEAcA9DaChFe=Eznc15_dtz9xbxyKE6i3DFpbxkYab7DmBXbw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] docs/devel: add some notes on tcg-icount for
 developers
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Jul 2020 at 17:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> This attempts to bring together my understanding of the requirements
> for icount behaviour into one reference document for our developer
> notes.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Message-Id: <20200619135844.23307-1-alex.bennee@linaro.org>
>
> ---
> v2
>   - fix copyright date
>   - it's -> its
>   - drop mentioned of gen_io_end()
>   - remove and correct original conjecture
> v3
>   - include link in index
> ---
>  docs/devel/index.rst      |  1 +
>  docs/devel/tcg-icount.rst | 89 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
>  create mode 100644 docs/devel/tcg-icount.rst
>
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 4ecaea3643f..ae6eac7c9c6 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -23,6 +23,7 @@ Contents:
>     decodetree
>     secure-coding-practices
>     tcg
> +   tcg-icount
>     multi-thread-tcg
>     tcg-plugins
>     bitops
> diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
> new file mode 100644
> index 00000000000..cb51cb34dde
> --- /dev/null
> +++ b/docs/devel/tcg-icount.rst
> @@ -0,0 +1,89 @@
> +..
> +   Copyright (c) 2020, Linaro Limited
> +   Written by Alex Benn=C3=A9e
> +
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +TCG Instruction Counting
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +TCG has long supported a feature known as icount which allows for
> +instruction counting during execution. This should be confused with

Shurely "should not be confused" :-)

> +cycle accurate emulation - QEMU does not attempt to emulate how long
> +an instruction would take on real hardware. That is a job for other
> +more detailed (and slower) tools that simulate the rest of a
> +micro-architecture.
> +
> +This feature is only available for system emulation and is
> +incompatible with multi-threaded TCG. It can be used to better align
> +execution time with wall-clock time so a "slow" device doesn't run too
> +fast on modern hardware. It can also provides for a degree of
> +deterministic execution and is an essential part of the record/replay
> +support in QEMU.
> +
> +Core Concepts
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +At its heart icount is simply a count of executed instructions which
> +is stored in the TimersState of QEMU's timer sub-system. The number of
> +executed instructions can then be used to calculate QEMU_CLOCK_VIRTUAL
> +which represents the amount of elapsed time in the system since
> +execution started. Depending on the icount mode this may either be a
> +fixed number of ns per instructions or adjusted as execution continues

"per instruction"

> +to keep wall clock time and virtual time in sync.
> +
> +To be able to calculate the number of executed instructions the
> +translator starts by allocating a budget of instructions to be
> +executed. The budget of instructions is limited by how long it will be
> +until the next timer will expire. We store this budget as part of a
> +vCPU icount_decr field which shared with the machinery for handling
> +cpu_exit(). The whole field is checked at the start of every
> +translated block and will cause a return to the outer loop to deal
> +with whatever caused the exit.
> +
> +In the case of icount before the flag is checked we subtract the

"of icount, "

> +number of instructions the translation block would execute. If this
> +would cause the instruction budget to got negative we exit the main

"to go negative"

> +loop and regenerate a new translation block with exactly the right
> +number of instructions to take the budget to 0 meaning whatever timer

"to 0. This means that whatever timer"

> +was due to expire will expire exactly when we exit the main run loop.
> +
> +Dealing with MMIO
> +-----------------
> +
> +While we can adjust the instruction budget for known events like timer
> +expiry we can not do the same for MMIO. Every load/store we execute

"cannot"

> +might potentially trigger an I/O event at which point we will need an

"event, at which point"

> +up to date and accurate reading of the icount number.
> +
> +To deal with this case when an I/O access is made we:

"this case, when"

> +
> +  - restore un-executed instructions to the icount budget
> +  - re-compile a single [1]_ instruction block for the current PC
> +  - exit the cpu loop and execute the re-compiled block
> +
> +The new block is created with the CF_LAST_IO compile flag which
> +ensures the final instruction translation starts with a call to
> +gen_io_start() so we don't enter a perpetual loop constantly
> +recompiling a single instruction block. For translators using the
> +common translator_loop this is done automatically.
> +
> +.. [1] sometimes two instructions if dealing with delay slots
> +
> +Other I/O operations
> +--------------------
> +
> +MMIO isn't the only type of operation for which we might need a
> +correct and accurate clock. IO port instructions and accesses to
> +system registers are the common examples here. These instructions have
> +to be handled by the individual translators which have the knowledge
> +of which operations are I/O operations.
> +
> +.. warning:: Any instruction that eventually causes an access to
> +             QEMU_CLOCK_VIRTUAL needs to be preceded by a
> +             gen_io_start() and must also be the last instruction
> +             translated in the block.

I think I would prefer some text phrased in a way that more
explicitly states what the frontend code has to do, like:

=3D=3D=3D=3D=3D=3D
When the translator is handling an instruction of this kind:
 * it must call gen_io_start() if icount is enabled, at some
   point before the generation of the code which actually does
   the I/O, using a code fragment similar to:
        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
            gen_io_start();
        }
 * it must end the TB immediately after this instruction

Note that some older front-ends call a "gen_io_end()" function:
this is obsolete and should not be used.
=3D=3D=3D=3D=3D=3D

thanks
-- PMM

