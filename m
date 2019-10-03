Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F82EC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 391EB2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMDrk/Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391EB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0nC-00054S-BN
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 09:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iG0ly-00046k-F3
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iG0lw-0000uR-E6
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:03:58 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iG0lr-0000pV-RZ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:03:53 -0400
Received: by mail-ot1-x343.google.com with SMTP id o44so2156281ota.10
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 06:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ipghaSDRH3YnZXK1nkRDDiCycPJ/rQxJ3f4sjT7herY=;
 b=nMDrk/AuwiorZpFQW/VJN4lPDP3F8E04MZlm4T3Tipjf8H4p8r8U1HdnVbFxjSxPFB
 DHHUKHVM70tMzNywW1W7hO5URlWvqWu25rxPmtPW25QgSwxBaSIi3pUJj2cMdtX8vhcp
 /OfgrMGADawAX3ztzna35maOtiawZTbNggTfEvWyzky6RuzudZCnpwME23AV2qwD9zX4
 aHcqr/yXIjkZPES8PUsvt9I7c/IStMKfiiMXL/jz7ofMJSCTeIwoSyzRfPgYU9CquZGX
 od3n6Waj8EFj0JspcTmDOgfN+Y1H344H28fZyAT2nORsh2SqH6n2pLz9XPTkGKJeGuMs
 /uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ipghaSDRH3YnZXK1nkRDDiCycPJ/rQxJ3f4sjT7herY=;
 b=UpvD946uhJ6/gZN7pQSPlcMjyOcfYGYOGYub38k6g7INqbxe9xxiKMClFIF88WWKno
 yHY5lKVDmnurxuWLbznnAuPRASWgwf+XFAXRGYDmJZibAwzfxWQ9skbcuv2rpL3lc0kH
 +B2BmfocIM0TSTG8HY2wPgvRfdb4bME/pTcOA21xqYx2yUk7UHaSmQ3LjTQjYAdZ55RN
 Cw9SS9FHcZZjA1gEgOYm6kQ7mgLrH9PkS9f5ceLkfZ9yLAKLroVsUIXa7i64iCZekMsK
 4Scx1K8Nz6DAUSxLc+3FB6FtOWX+dvsGArYEH65WkqLTNYCIrYNuYq175tvv3C+FFq5K
 5FSw==
X-Gm-Message-State: APjAAAVz9SQ58udiEvZ4pV3U0bSdckIMtg+CFoXRaz0oodIeI7YSU5FY
 +JJ+82TlY4JUHRG2OeJAev56aja5vF7769+Fh6EyEXkd0/s=
X-Google-Smtp-Source: APXvYqxO5Wzft4nIjec+vUoP6tXA/o5iAru/G7hppGwN2pbYBDVpe7ybD7FKZ2HJ8jUODWDTrgXgbSFaRKwucqEz0+g=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr6670747otq.91.1570107830223; 
 Thu, 03 Oct 2019 06:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190916141544.17540-1-peter.maydell@linaro.org>
In-Reply-To: <20190916141544.17540-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2019 14:03:38 +0100
Message-ID: <CAFEAcA_deKRqVfn+P5HBQrTcHFjdSnHdcuzvFJsQC3jUP=dFww@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] target/arm: Implement semihosting v2.0
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please?

thanks
-- PMM

On Mon, 16 Sep 2019 at 15:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset implements support in QEMU for v2.0 of the
> Arm semihosting specification:
>  https://developer.arm.com/docs/100863/latest/preface
>
> Specifically, v2.0 has:
>  * a mechanism for detection of optional extra features,
>    which works by allowing the guest to open a magic file
>    named ":semihosting-features" and read some feature
>    flags from it
>  * two defined extensions:
>   - STDOUT_STDERR lets the guest separately open stdout and
>     stderr via the ":tt" magic filename (v1.0 only allowed
>     access to stdout)
>   - EXIT_EXTENDED lets A32/T32 guests exit with a specified
>     exit status (otherwise only available to A64 guests).
>     This is something that people have been complaining
>     about for a long time.
>
> (Technically some of the things we already support, like
> having an A64 semihosting interface at all, are also part of
> the v2.0 spec.)
>
> This patchset:
>  * fixes some bugs relating to errnos in some cases
>  * makes semihosting hand out its own filedescriptors rather
>    than just passing out host fd numbers
>  * abstracts out the fd-related semihosting calls so they
>    indirect via a function table based on the type of the fd
>  * adds a new type of fd representing the magic file
>    ":semihosting-features" which is used for feature-detection
>  * implements both of the extensions defined by the v2.0 spec
>
> I've tested this by improving my semihosting test suite:
>  https://git.linaro.org/people/peter.maydell/semihosting-tests.git/
> (if people have other guest binaries that make much use of
> semihosting then testing would certainly be welcome.)
>
> Changes v1->v2:
>  * Added a patch which corrects misunderstanding in a FIXME
>    comment about the when the callback function is called
>    for arm_gdb_syscall()
>  * in patch 4, if the SYS_open is going via the gdbstub, we
>    must do the associate_guestfd() work in the gdbstub callback
>    function. This is because in softmmu mode the callback will
>    not be called until after do_arm_semihosting() returns.
>    (The v1 series effectively broke SYS_open in the gdbstub
>    + softmmu config)
>  * Pass CPUARMState* to set_swi_errno(), rather than creating
>    an odd local-to-this-file typedef of TaskState for the
>    softmmu compilation
>  * New patch: avoid ifdeffery in gdb callback fns by
>    using set_swi_errno() rather than doing it by-hand
>  * The various 'factor out SYS_foo' patches are basically
>    unchanged, but all the functions no longer need to take
>    a TaskState*. This seemed kind of borderline as to whether
>    to retain Alex's reviewed-by tags, so I dropped them.
>  * Since we need 'env' for set_swi_errno(), we don't need
>    to put the variable declaration inside ifdefs any more
>    in the host_readfn() etc.
>
> I do plan to have a go at fixing the odd FIXME surrounding
> arm_gdb_syscall() which patch 3 clarifies/states in a comment.
> But I thought it better to not tangle that up with this
> patchset, which is already pretty long.
>
> thanks
> -- PMM
>
>
> Peter Maydell (15):
>   target/arm/arm-semi: Capture errno in softmmu version of
>     set_swi_errno()
>   target/arm/arm-semi: Always set some kind of errno for failed calls
>   target/arm/arm-semi: Correct comment about gdb syscall races
>   target/arm/arm-semi: Make semihosting code hand out its own file
>     descriptors
>   target/arm/arm-semi: Restrict use of TaskState*
>   target/arm/arm-semi: Use set_swi_errno() in gdbstub callback functions
>   target/arm/arm-semi: Factor out implementation of SYS_CLOSE
>   target/arm/arm-semi: Factor out implementation of SYS_WRITE
>   target/arm/arm-semi: Factor out implementation of SYS_READ
>   target/arm/arm-semi: Factor out implementation of SYS_ISTTY
>   target/arm/arm-semi: Factor out implementation of SYS_SEEK
>   target/arm/arm-semi: Factor out implementation of SYS_FLEN
>   target/arm/arm-semi: Implement support for semihosting feature
>     detection
>   target/arm/arm-semi: Implement SH_EXT_EXIT_EXTENDED extension
>   target/arm/arm-semi: Implement SH_EXT_STDOUT_STDERR extension
>
>  target/arm/arm-semi.c | 707 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 577 insertions(+), 130 deletions(-)
>
> --
> 2.20.1

