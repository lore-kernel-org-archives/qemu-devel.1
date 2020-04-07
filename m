Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980C0C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA2A206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQSq8LC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA2A206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLm0D-00083R-I4
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLlvN-0008Gj-CR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLlvL-0007WH-W4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:44 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLlvL-0007VY-JM
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:57:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id w2so1085845oic.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 03:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7/U3mxK6SZm2EBUwuKYS+1jdggV3LsY8aqLxWYH8JQA=;
 b=pQSq8LC6fheWz6vcTzqcJqeuo4HzZEGl2aSfmmzBxeGIlC27g9LGQ5lhhbyjzLgulH
 Sd4uxZfndYPKxj1aVpjZ5XjzkfNtrQUlaDDT1LhkvD6E4uh2psgtCKTrLrJFrqhNm/uK
 4ej+s4OrEa+45uaVfbV3mtVZFNQe4mPgcqIe1J6dOO9hFK1YXHyNpmQIMkrQlbRVEJCS
 8wiUTRmEC6LeCyHVmVtVBzP2noip042BfZoO7nBfuNkfz1Z51BAMOKHIrlGfG7kKjLBR
 91oQFWUeevAjOKiveh90zh2CBTWYO8lTb4W/9k23f/mW97Orx2QJUCDj5ICWWLAZ6z9N
 15Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7/U3mxK6SZm2EBUwuKYS+1jdggV3LsY8aqLxWYH8JQA=;
 b=IrOKCZBUSS+QJrYMgI0TdY9MYL3RtLIPdV1zkBKbysw6JR+M3/9oi96ZE7Vn2GE7/B
 O43KE5Dn1VArpXG7rnk0kbaYMVFfiIBe7ixMY+8JsxNnlbjC93lnB9VX6OvT2FtJitVY
 gybZ1Zy5SYWNhzhML56YzEBA/QXzOTxcQtBAy9sco+abxIlSNq5lPYTRTNGdVjXLC9FG
 zU79FcUTguGGOLmzQ8IPsPT3gVVm6Cy2LxVe+BZGZJ5BnYbgDyenx32CqzGvwYmGQlyW
 oW1OjA1HqceI8gsyiJ958YPzEFRXP+VdBytM4GlpqyB+RK6GQ86W2hYVXzZUIm+k571x
 i0Vg==
X-Gm-Message-State: AGi0Puax1A1qFb3SFMUWv4dC0h+Ni9nAZYQM5qwczUcxBbROGkWhep5/
 NKcBeUqX58gvwTI/oKt/fMga96nlG/iSY9XcuN3sjg==
X-Google-Smtp-Source: APiQypJ0+sZuvH8ApgV0JEHzrQl3/+aSN629Ac5yG1FiygKS+HCg8g8k4b69I1YUOKF+HPtC1sHs7W0qBxImw2cYFbo=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr1118405oij.48.1586257062430; 
 Tue, 07 Apr 2020 03:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <mvmftdg8wxw.fsf@suse.de>
 <216610b1-0d0f-a50b-8997-bb6aa6e20abf@vivier.eu>
In-Reply-To: <216610b1-0d0f-a50b-8997-bb6aa6e20abf@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 11:57:31 +0100
Message-ID: <CAFEAcA_zbeBM7iFd10ut4UTYDifJ=SWjMD1KYOJgKX=4OQSkmw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Use getcwd syscall directly
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Andreas Schwab <schwab@suse.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 11:37, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 06/04/2020 =C3=A0 17:18, Andreas Schwab a =C3=A9crit :
> > The glibc getcwd function returns different errors than the getcwd
> > syscall, which triggers an assertion failure in the glibc getcwd functi=
on
> > when running under the emulation.

What exactly are the differences in errors ?

> > ---

> According to the commit introducing the function, it could break fakeroot=
:
>
> commit 3b3f24add09f8ab720860d4840f9755c102121b5
> Author: Aurelien Jarno <aurelien@aurel32.net>
> Date:   Wed Apr 15 16:12:13 2009 +0000
>
>     linux-user: prefer glibc over direct syscalls
>
>     The openat/*at syscalls are incredibly common with modern coreutils,
>     calling them directly via syscalls breaks for example fakeroot. Use
>     glibc stubs whenever directly available and provide old syscall
>     calling for people still using older libc.

I don't think (based on a quick grep of the fakeroot sources) that
fakeroot intercepts 'getcwd', so this patch is probably ok on this
front. It looks like the syscalls that fakeroot cares about that
that patch was trying to improve our handling for are the
ones like fstatat which return the kind of permission/ownership
info fakeroot wants to alter (not including 'openat', despite
that being the only function named in full in the commit message...)

More generally, we rely on making direct syscalls for at least
some syscalls for signal-handling related correctness, so if
that ever comes into conflict with QEMU continuing to work under
'fakeroot' then fakeroot-compatilibity is going to lose...
('fakeroot-ng' would still work, as it intercepts syscalls
via ptrace.)

thanks
-- PMM

