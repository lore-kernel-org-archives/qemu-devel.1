Received: from eggs.gnu.org ([209.51.188.92]:35533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbcv-0006VK-Hm
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbcu-0002d7-IN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:25:13 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbcu-0002cW-Ds
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:25:12 -0500
Received: by mail-oi1-x242.google.com with SMTP id v6so6281990oif.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-10-peter.maydell@linaro.org>
	<87r2crv5um.fsf@zen.linaroharston>
In-Reply-To: <87r2crv5um.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 16:25:00 +0000
Message-ID: <CAFEAcA-VehQaTNt=2Q1zGmBNyWhATs6JAak5TskKTBA4Or0xtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Fri, 1 Feb 2019 at 16:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> It reports:
>
>   Documentation     no
>
> But then proceeds to barf:
>
>   https://travis-ci.org/stsquad/qemu/jobs/487512292#L1395
>
> with:
>
>   /bin/sh: 1: sphinx-build: not found
>   Makefile:871: recipe for target 'docs/devel/index.html' failed
>   make: *** [docs/devel/index.html] Error 127

Oops, yes. We shouldn't be adding the sphinxdocs target to
the all: list (or the sphinxdocs-install target to install:)
unless BUILD_DOCS is defined.

(Assuming we take this we should probably also add sphinx
to the set of deps we install for Travis, but a no-sphinx
build shouldn't break.)

thanks
-- PMM
