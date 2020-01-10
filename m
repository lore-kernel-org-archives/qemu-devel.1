Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED307C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C35206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtCDNI9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C35206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipxOa-0002PL-LM
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipxNn-0001qP-GF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipxNl-00010P-T9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:43:35 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipxNl-0000wm-Mm
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:43:33 -0500
Received: by mail-oi1-x244.google.com with SMTP id c77so2376982oib.7
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tvUq7rk3imw9BQMNFw8laJjG/wxZ8iX8SXdhlCPhGKY=;
 b=qtCDNI9GRQ9QHEzb9I57NprIEKyLLHWeepbBGL6wyXnS0MwUSoi2FfSbV9s7rFMsVa
 SYfnm1aDRSrf8H5FYPi1uwtivYCVwOVjtL9W6Zm8rx1ODtRWP0bQw4oP3y0liGbEtSRC
 VRb/5dXEkaFjg2Ie20sMYLj78k5apXgGhOvvPgSCMD+Qdj6DtP5qAz7q51dPtv9iXZAh
 LSPwoMyGTTvNFO3SWkX0MsQTyQvCB3x23MMZBfh95t1pNY3Io5NOLCKCGLCSUpFAewGO
 gL29CnGNlyt98lmAt3lwBzCWV2KC9odcBothOcIZwf1Adwyrlo74B4YvXM1gMBYgoriE
 dDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tvUq7rk3imw9BQMNFw8laJjG/wxZ8iX8SXdhlCPhGKY=;
 b=nEGGS8NyBDaakySUbXPiuQS6UYvKy+8/kqxc3NYvjdDwz3n9YmOzmRO9fFeiigxmop
 iJ+196HX0e/FUkiaXAreVQB8VcmR7l6hMY7e2bufpPe45uIhOuGFxyFNmg9BBM8uhQv7
 B1jFfs1t73TSeMb1JnvYNteF43u47ryn4LrNSOMh/x2+bIvW+oXklkEhvwH5ZlBv5CAB
 IiM7QoH/osrgkezMlBQv5Fbo5qVoOlMrBb/oFa7HJ04iHLxXtK2/vR8Q9DygAetQfSLr
 YjWrFYDvpEAlRdgPAZjUJ6gWVYGrD3IS7/tm28kw3yP74A9QFNBDbeT8QYmaansG4Mu2
 b6YA==
X-Gm-Message-State: APjAAAWx5MyfP+/Z0y2DYTXbdQwDCBS8/eDzuGgepnDKPnpZxbPQVB4A
 kBUDiyJlkIMgPSCz/bfhFiUscgV+9adva+UHNHPLuQ==
X-Google-Smtp-Source: APXvYqw7tGwE1DOuB3n/x7zg0EpauvZ5TGbTHmCa6IANJ6V1e8wm8bPzMcotxCAxGvZWXy3KLxfQM3N9Vt5kfcz+O40=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr2969518oig.163.1578674612428; 
 Fri, 10 Jan 2020 08:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20200108042338.9082-1-richard.henderson@linaro.org>
 <CAFEAcA-AYKxnTW6w1xnbP0sbk-_8pV3UdfOotPmSHqNmj_Kjkg@mail.gmail.com>
In-Reply-To: <CAFEAcA-AYKxnTW6w1xnbP0sbk-_8pV3UdfOotPmSHqNmj_Kjkg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 16:43:21 +0000
Message-ID: <CAFEAcA-bfPwnt8LRWHagdySbU2KnQbyacxX-ieB7btW+s0vrzw@mail.gmail.com>
Subject: Re: [PULL 0/3] capstone update
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 16:07, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 8 Jan 2020 at 04:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b=
4e7f:
> >
> >   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-r=
equest' into staging (2020-01-07 17:08:21 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/rth7680/qemu.git tags/pull-cap-20200108
> >
> > for you to fetch changes up to 7cc3836eac04a3e358b2496fbca704b3ee5197ae=
:
> >
> >   capstone: Add skipdata hook for s390x (2020-01-08 14:53:54 +1100)
> >
> > ----------------------------------------------------------------
> > Update capstone to next
> >
> > ----------------------------------------------------------------
> > Richard Henderson (3):
> >       capstone: Update to next
> >       capstone: Enable disassembly for s390x
> >       capstone: Add skipdata hook for s390x
>
> Build failures:
>
>   CC      aarch64-linux-user/disas.o
> In file included from
> /home/ubuntu/qemu/capstone/include/capstone/capstone.h:302:0,
>                  from /home/ubuntu/qemu/include/disas/capstone.h:6,
>                  from /home/ubuntu/qemu/disas.c:9:
> /home/ubuntu/qemu/capstone/include/capstone/riscv.h:16:10: fatal
> error: capstone/platform.h: No such file or directory
>  #include "capstone/platform.h"
>           ^~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> (same on most hosts)
>
> aarch64 host had this complaint instead:
>
> /home/pm/qemu/disas.c:187:1: error: expected =E2=80=98=3D=E2=80=99, =E2=
=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
> =E2=80=98__attribute__=E2=80=99 before =E2=80=98cap_skipdata_s390x_cb=E2=
=80=99
>  cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
>  ^~~~~~~~~~~~~~~~~~~~~
> /home/pm/qemu/disas.c:211:17: error: =E2=80=98cap_skipdata_s390x_cb=E2=80=
=99
> undeclared here (not in a function); did you mean
> =E2=80=98cap_skipdata_s390x=E2=80=99?
>      .callback =3D cap_skipdata_s390x_cb
>                  ^~~~~~~~~~~~~~~~~~~~~
>                  cap_skipdata_s390x

...and applying this merge also did something that broke the
build directories such that rolling back to before the merge
to current trunk then failed to build with errors about
missing 'capstone.h'. I had to blow away the build trees and
recreate them.

thanks
-- PMM

