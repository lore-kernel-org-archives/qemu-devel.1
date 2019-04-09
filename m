Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8788DC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482F42084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cse.mrt.ac.lk header.i=@cse.mrt.ac.lk header.b="XCQH+Zi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482F42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cse.mrt.ac.lk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtz1-0005Vi-KO
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:52:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtyD-0005CY-1U
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtyB-0005Z1-Fa
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:51:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDtyB-0005YL-5P
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:51:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id h18so4158265wml.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cse.mrt.ac.lk; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=utSakDnHBza1vNblMwJKHIgfAMO7KSjE6Rsldr6W6FI=;
	b=XCQH+Zi754WhJRYYXAbgDQ0AHwP+Vp2W2MzUyQwj83UzDaoLfJ7y0MlYgMqQT2DmZw
	kbYF1OHAqIaoUVlZeu/qbJBopbGO/sOnmNGZofV/tUXOUaSgQL8oVlUII4sgLFxQVHUb
	6gPUOud9yOHy//FUqrl44cVG3GjBMNofJBfSDHKZn9LbD6lJw3FWMAjOEZYDa3zsT/Wj
	ZvBpx6slExRsr5bvsMObOiEywslZLNwX+my70pFqg+cltsWaXGGxHenIYPrhFmH4TT54
	8f90v3C052/tPrR6o//D/F83M1bPUop6UX03b/O9lGiLjWIwDBL1L4wzKn1p0BS6Tik8
	wNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=utSakDnHBza1vNblMwJKHIgfAMO7KSjE6Rsldr6W6FI=;
	b=YXiohvDSCsp8NXcutACjfk6QimJh0r2VyHlAYl0J/v4A2B0DfHzGW88wCpO0GyDc+V
	gvMrZ+oR3ZlFZhbvflgLLhUUEwzBoRT0zGISgl0p9Uepj8jPzifiYP2C+ncPnSDO+IHS
	DLn25KkIlVqiHYMLb916eWJFLmSrj+6DS00JzRKUSqmX9Zga3L6fXNLo33PBI85OjKtm
	XDM4C11FBy9d0rxfymigdAgaXzvdkmP3MiNHB+xapuoUFuHqVLBQ4wRBxbiLms4VAkND
	C+sAhT8M/IMvvjFtkAPRmUXiH4QkkFbTalsEdlm4uniz8/9/0oll1IxNsPg6JkUGu30R
	+nMw==
X-Gm-Message-State: APjAAAU5Y5VIfx8fa1g2H3VCDZ6B2k14Z6wFQTTQ7Qr8a/gBxP1e+wGJ
	3sEHrzwPBQ4hx5JNuzR3lnkWa4gfkgN4ASuy5jCL8w==
X-Google-Smtp-Source: APXvYqwzXqLHGXFHthBSyJrvCMa71/7f0S52R8kCUVtkD9+DJBBlRDLy9fM9ilx6Zfmgv5cVCMamf84PiNrDhjOSWrY=
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr21551844wmi.138.1554828693167;
	Tue, 09 Apr 2019 09:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
	<CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
	<CAFEAcA9DSaZE-dsKV4321meT2hBEJRLmWBLF0U5o0jG=mzcmRA@mail.gmail.com>
In-Reply-To: <CAFEAcA9DSaZE-dsKV4321meT2hBEJRLmWBLF0U5o0jG=mzcmRA@mail.gmail.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue, 9 Apr 2019 22:21:21 +0530
Message-ID:
 <CAH95U0jVP2SXr9+t+NQ4xoWODMJgMxpSgdMM4RiTSKcEX9v6ZQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409165121.n61dFKDXeoJAnEdfGfgOeZ4SVwJowywSm5RL0hMjd14@z>

Ok, thanks

On Tue, Apr 9, 2019 at 10:20 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 9 Apr 2019 at 17:42, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >
> > Yeah this is a stand alone patch.
>
> OK, thanks -- just wanted to check there wasn't a missing
> bit. I think this could go in via the qemu-trivial tree
> so I have cc'd them.
>
> We're in the middle of a release at the moment, but we
> should reopen for development in a couple of weeks. If
> this patch still hasn't gone anywhere by a week or so after
> that then please follow up with a 'ping' to check it hasn't
> been forgotten by accident.
>
> > On Tue, Apr 9, 2019 at 10:10 PM, Peter Maydell <peter.maydell@linaro.or=
g>
> wrote:
> >> On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >> >
> >> > Removed unwanted includes from cpu-common.h
> >> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> >> >
> >> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >> >
> >> > ---
> >> >  include/exec/cpu-common.h | 2 --
> >> >  1 file changed, 2 deletions(-)
> >> >
> >> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> >> > index cef8b88a2a..a3594f3f50 100644
> >> > --- a/include/exec/cpu-common.h
> >> > +++ b/include/exec/cpu-common.h
> >> > @@ -7,8 +7,6 @@
> >> >  #include "exec/hwaddr.h"
> >> >  #endif
> >> >
> >> > -#include "qemu/bswap.h"
> >> > -#include "qemu/queue.h"
> >> >  #include "qemu/fprintf-fn.h"
> >> >
> >>
> >> I was surprised that no .c files are implicitly relying
> >> on these includes, but apparently none are, so we can
> >> safely remove them.
> >>
> >> A couple of notes:
> >>  * this doesn't need to go to qemu-stable as it's just a
> >>    code cleanup
> >>  * did something go wrong with your sending of this patch?
> >>    Its subject is "PATCH 0/4" which would usually indicate
> >>    a cover letter for a four-patch series, but this seems
> >>    to be a stand-alone patch.
> >>
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>
--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
