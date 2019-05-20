Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6B0C04E87
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EDD216FD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 12:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDRwy3oN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EDD216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hShXc-0006TI-KG
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 08:37:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hShW2-0005I8-W9
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hShW1-0007qt-Bq
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:35:42 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hShW1-0007ot-5e
	for qemu-devel@nongnu.org; Mon, 20 May 2019 08:35:41 -0400
Received: by mail-ot1-x341.google.com with SMTP id i2so7425339otr.9
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=i6/gwCq5cQhTWhm9SP8esc5pJWj7TzyVU42WW0EvQPg=;
	b=eDRwy3oNOHiG+gCQwnrzknAaBEvgjJkdKOVNgVA2Pg89ujYQHMWnkHarVaD+/PbE+q
	yik7AjKsPmrq1/GXclmlvi7KsowJyXOf4NXoZoumIvBaS28tYqM7vI/UDIvlVojBVDcV
	wIh8qyrplcYjTHgt0T/p3C47BS0ZYL2R0zauT4qcApQEJVRmXiyCRJ9AYG8zuEyTkD1f
	/ry88F7PXSB+pYovZQashIvpm1B2us3tsAZgkBlaipsK6IhdcTU4EJiXs6o0PJ26cydg
	3AN6QjgDfkdUbwO093l7VqxB+ciSYweblttoAu8fuU21Fe9OW9kxkNF9vEekjaa+KEKR
	qZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=i6/gwCq5cQhTWhm9SP8esc5pJWj7TzyVU42WW0EvQPg=;
	b=chB5e/Wn7D1G/Va/YIzARtH0BymOrOA+4vlYWJosaOIKDsf5jnnPM1np9+3biFAg/O
	E03Ahgrp5gPc/iM+KS0cVyR6UC/gWsA6M3e2iXQsHt5K/ssvvyrhm6FB+rTCLQKd5a75
	6gaZTD9sYreHR9+3JtH6DVycE3Z/WaA+vSPoZqIAoe+J8WXNRAaw1c9k+USsrlIomyaP
	twrXFA4imAr8Dh3kSfiv/SS1fHNDnh+FwhszavpfZAKXU/PLUBxvC2464QmDjJvQ+Rvb
	uGAgbkyBIuzTzCghpJoaFWEczelgZ93nmNKgN+drSzF3BISM0n1YvJ50wx38eMaLzo/8
	mxCg==
X-Gm-Message-State: APjAAAXkXW3zOgqoWisjptAGX3IP/ogHD73Wh2kbkh2dR2y9gQiQ4/JJ
	3lNzoxK952xRfOO401DKxZtE2hDiEVY6QEzWWPDxfg==
X-Google-Smtp-Source: APXvYqy4e3CcJY2q9viOxQlyaHjyWSDInfbAz5MJKXwN9Vndm+kqNktj9YgCP3MjYfD1Z1qKMW2wE3p9gxkN3GhcWlA=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr2825otm.64.1558355735854;
	Mon, 20 May 2019 05:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 05:35:35
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 05:35:35
	-0700 (PDT)
In-Reply-To: <CAFEAcA842fq=CG+y_qGySWV3i_JNPEk0iQwCJxed6cQcCMidWA@mail.gmail.com>
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA842fq=CG+y_qGySWV3i_JNPEk0iQwCJxed6cQcCMidWA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 14:35:35 +0200
Message-ID: <CAL1e-=i91f-vgyFJOJhN51JaUoTZgdhby_F_YyeTr_KYWBsZeA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 20, 2019 2:11 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On Sun, 19 May 2019 at 11:52, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
> >
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > The following changes since commit
1b46b4daa6fbf45eddcf77877379a0afac341df9:
> >
> >   Merge remote-tracking branch
'remotes/kraxel/tags/ui-20190517-pull-request' into staging (2019-05-17
17:25:19 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/AMarkovic/qemu tags/mips-queue-may-19-2019
> >
> > for you to fetch changes up to 71074d1d2fae9a0c8dab87c5bb5271a71d6cb7ab:
> >
> >   mips: Decide to map PAGE_EXEC in map_address (2019-05-19 12:11:46
+0200)
> >
> > ----------------------------------------------------------------
> >
> > MIPS queue for May 19th, 2019
> >
> >   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
> >   * A set of fixes for emulation of MSA ASE on big endian hosts
> >   * Improved usage of object_initialize() and object_initialize_child()
> >   * Better handling of 'div by zero' cases in MSA ASE
> >
> > ----------------------------------------------------------------
>
> Hi -- I'm afraid this fails to build with clang:
> /home/petmay01/linaro/qemu-for-merges/target/mips/op_helper.c:4536:20:
> error: unused function 'ensure_writable_pages'
> [-Werror,-Wunused-function]
> static inline void ensure_writable_pages(CPUMIPSState *env,
>                    ^
> 1 error generated.
>
> It looks like "target/mips: Fix MSA instructions ST.<B|H|W|D>
> on big endian host" removed the last use of this function
> but didn't remove the now-unused definition.
>
> (clang is pickier than gcc about not allowing unused 'static
> inline' functions -- gcc ignores them anywhere, clang only if
> they're in .h files.)
>

Ughhh... Sorry. I should have had a script for this. I'll send v2 in few
days.

Regards,
Aleksandar

> thanks
> -- PMm
>
