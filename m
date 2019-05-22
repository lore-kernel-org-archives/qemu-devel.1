Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4251C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519CE2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 21:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDukSJ1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519CE2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51530 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTYX8-0000xu-CQ
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 17:12:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTYWL-0000cN-TD
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTYWK-0006e6-1W
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:11:33 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTYWJ-0006cc-Pm
	for qemu-devel@nongnu.org; Wed, 22 May 2019 17:11:31 -0400
Received: by mail-oi1-x241.google.com with SMTP id u64so2763492oib.1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 14:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=X34nfF2/o2hgK0QQHwuDuWV3fypz8ERlJSXBq8CS/L8=;
	b=rDukSJ1++tz2pyWRyg9Fwdys2PakdsUyEtMi1x+nKNqjCUllDuFb0MLZFEGv9zt1CY
	qgdRQa95oXtyHk/uGiHFNsBXl2uJJ75KcOPNunRKH4wG2k4XGTkQMuvkyBIzGJUn1dOW
	1JgUW3ZndJws632/0iaxEoIgE0Uwn4LBU+YPPruuGb9CKyRiWZLIxEAAP9ss5X7ydGZ9
	cDFWhKxaWkqVKMdEFS7TWm7q/93+bY7oxFySvwCJ+AfxdjBUcVQ5jpwojT6Uc8IrYROF
	fNlsHbmv40dc2zz5487JRbGVtSebFGspt7Qx0ifVkXMfbU/GW/s5s+nj7gqSk0hjGlvG
	zuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=X34nfF2/o2hgK0QQHwuDuWV3fypz8ERlJSXBq8CS/L8=;
	b=RfFb6oKaWnjiFVyZeymlO/vNbR6aapOcrvKym7lDkORRmbvzbHO55jh9a4n1qK5UOQ
	G+lqWTrT9wjS6eEVksPD6DH47Qz41CsOXsh9P8qYFyYxQNZpzPBKlelhV2euuSHRzzRa
	6njhMMeCqi8jgbE97wQC6Nhj2K5sg1W0bQPIy730oKPzlXxFt/WB0PF2QzGAaPVOQIi7
	YFO+x7QtP/hp3x5YGNIehlLFtK5cX8BUIOCoXkEMyijcyeQBrudo6in+sjaIzEKTjCfO
	943rbkHFFBBIJm1vPsgxps+nfbDuXp5QK62YqZbTZ2eDfGhCErYzUMYn0W7TCi2BS1RJ
	dgmQ==
X-Gm-Message-State: APjAAAUb1YDq0K2K8yKG/2AspSAWpQHYYp/bjZ796pDaXfb7LNTp1aNP
	YxXFb41h2McCWHlou/7C+zvBNTczVv4MVuZibWQwuQ==
X-Google-Smtp-Source: APXvYqzf74S/ZZDEEi8hDdFeT0uQT2xhNBkCsIj1gqSdPPyCWvNZ1IIAcUu9qz8cWTa3Zg7jBzm1OKopf65inCSjK8E=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr497054oif.98.1558559488606; 
	Wed, 22 May 2019 14:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190521200657.5377-1-jsnow@redhat.com>
	<20190521200657.5377-2-jsnow@redhat.com>
	<CAFEAcA9mEHvQ9TBGpvfVoDx-pKB9Cyc-JWeUUh2Hc0Uxb1GjuQ@mail.gmail.com>
	<4005ff30-2df3-c615-7fed-fd9d5de56e95@redhat.com>
In-Reply-To: <4005ff30-2df3-c615-7fed-fd9d5de56e95@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 May 2019 22:11:17 +0100
Message-ID: <CAFEAcA-o7oh3FqynmveJJA7aC+Jk2_Wdg0m-tYJW=981+ODdcg@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 1/2] sphinx: add qmp_lexer
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
Cc: Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 20:02, John Snow <jsnow@redhat.com> wrote:
>
>
>
> On 5/22/19 4:49 AM, Peter Maydell wrote:
> > On Tue, 21 May 2019 at 21:07, John Snow <jsnow@redhat.com> wrote:
> >>
> >> Sphinx, through Pygments, does not like annotated json examples very
> >> much. In some versions of Sphinx (1.7), it will render the non-json
> >> portions of code blocks in red, but in newer versions (2.0) it will
> >> throw an exception and not highlight the block at all. Though we can
> >> suppress this warning, it doesn't bring back highlighting on non-strict
> >> json blocks.
> >>
> >> We can alleviate this by creating a custom lexer for QMP examples that
> >> allows us to properly highlight these examples in a robust way, keeping
> >> our directionality notations.
> >
> >> diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py
> >> new file mode 100644
> >> index 0000000000..f619f11139
> >> --- /dev/null
> >> +++ b/docs/sphinx/qmp_lexer.py
> >> @@ -0,0 +1,34 @@
> >> +# QEMU Monitor Protocol Lexer Extension
> >> +#
> >> +# Copyright (C) 2019, Red Hat Inc.
> >> +#
> >> +# Authors:
> >> +#  Eduardo Habkost <ehabkost@redhat.com>
> >> +#  John Snow <jsnow@redhat.com>
> >> +#
> >> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> >> +# the COPYING file in the top-level directory.
> >
> > Did you definitely mean 2-only and not 2-or-later ?

> Copy-paste pulled from another Python script. 2 or later is fine by me;
> I can resend if desired (or, I'd be fine with anyone touching it up in
> post.)

Our default-preference as a project is 2-or-later, so if
you're both happy with that I think we should use that.

thanks
-- PMM

