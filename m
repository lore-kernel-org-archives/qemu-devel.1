Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3204CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ABC2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCJDfaRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ABC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMayZ-0003GN-00
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaxi-00026m-1y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaxf-0000hU-RI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:55:17 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMaxe-0000ga-1i
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:55:15 -0400
Received: by mail-oi1-x243.google.com with SMTP id i16so11654847oie.4
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7e3x4NcIlvvdpfGfx0iNx+0/nSUIjShHWCcCaRMNY+o=;
 b=MCJDfaRqo2tDtzQNu5+aUw7fCXE1C1h9svnlFfaAEx/jPDp66BltSs2at3XZarSn/2
 kO9Pkdr2fasV1FbtPbCGXxz5taH5c98Nw2k+8E1i/b6R5BrFqYKDHZM3DjS6TBESDGpZ
 p6GweFFhB4Ww+i1mxjiBjDLboy+yG/Mv5W1BOJJwLl1ESr5vG0431Mz4q89TgCIiGjcW
 JX+mw4CJwgh5Z/mxoE3jz9qsiYIDo9HC6cIPEUFqAN1ppw3aA+wU67nM5ni4hPxn09gJ
 mKvxMI6b4r+N9bpmjqtAZ6kI5XTdbM0LfKlenelz5Xi0lDdMikstuMpqfmwcH6NgU16w
 9LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7e3x4NcIlvvdpfGfx0iNx+0/nSUIjShHWCcCaRMNY+o=;
 b=NLuFeglYF3i8PhhKdmRQYeqODPm+CFJFpgCYOnufMv+ojhHaCsbZJaMD0CHm6PituM
 GWF9q4s9CJfm28QjaskzHXDR/e7O7faIMIhUh058HY1E6o8L63DxwOUY/vslrMtEJ9D4
 TECzC+TXcOH8yf7ANntmV19NCwqJudsQYVgJCzP9HDsWKg4pd9wxjJWdtQ5W8E2YbFyL
 Pl6JB1/kZ6gdk5RWO+Wst04fAjR7/nm+QQ3FRLoTfhLRNFZM/USjKRBZMCvNrHZpgXpk
 1xVIV9G3Y5HRsPyLchZtmPyyK7uoz9XU+tYzyXuZ4rCGzcgeeaz98r8cuosh1ZncZxRJ
 G98w==
X-Gm-Message-State: APjAAAUQtwIxkKBCiqS0MlezR4DLX1sKOvLLTYxNtvbhQE9MLHUulTFj
 m9YiGotQkWLyR1wyJYqBf7xzV+GW0ovlgvY2dAc+Lg==
X-Google-Smtp-Source: APXvYqzqn0MZ+uaCPJvhBG9ZsAwNAlJWZAQwU9xs1RG6RWWRLS8O0cbqzYtDU+24zIyWxsrg1mYbeBGFAcnUw3UxZQM=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr19160176oik.146.1571676912674; 
 Mon, 21 Oct 2019 09:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <CAFEAcA_PO7vaxGVpfW2bqRvB9XtDA8uk_6Tw7SauwrbHfJOjxw@mail.gmail.com>
 <20191021164611.GT4336@redhat.com>
In-Reply-To: <20191021164611.GT4336@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 17:55:01 +0100
Message-ID: <CAFEAcA8O8vb9Rauo99Dfqg3X63VEANcqjAqwJeXUEvAy3wHXGA@mail.gmail.com>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Claudio Fontana <claudio.fontana@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 17:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Oct 21, 2019 at 05:36:49PM +0100, Peter Maydell wrote:
> > On Mon, 21 Oct 2019 at 15:58, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > > Since 2008 the tcg/LICENSE file has not changed: it claims that
> > > everything under tcg/ is BSD-licensed.
> > >
> > > This is not true and hasn't been true for years: in 2013 we
> > > accepted the tcg/aarch64 target code under a GPLv2-or-later
> > > license statement. We don't really consider the tcg
> > > subdirectory to be a distinct part of QEMU anyway.
> >
> > This commit message misses the other not-BSD bits of code in tcg/:
> > tcg/tci.c is GPL-2-or-later
> > tcg/tcg-gvec-desc.h, tcg/tcg-op-gvec.[ch], tcg-op-vec.c are LGPL2.1-or-=
later
> >
> > Horse has clearly bolted further from the stable than
> > I had first thought.
>
> No matter what text we put in the top LICENSE file is always going to be
> rather vague because of the many different licenses scattered across the
> codebase.

There's two parts to this:
 (1) is what we say in LICENSE what we actually have in practice?
 (answer: clearly "no")
 (2) as a policy, do we want to be stricter about the license
 for code contributed to tcg/ than to the rest of the codebase?
 (which is what this patch is trying to flush out answers to)

> We really ought to make an effort to add SPDX tags to every file in the
> source tree & have checkpatch.pl enforce that all new files come with
> SPDX tags too. Identifying licenses for code then becomes a trivial grep.

My take on SPDX is still the same as it was last year:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04151.html

thanks
-- PMM

