Received: from eggs.gnu.org ([209.51.188.92]:46781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBhde-0001Et-2g
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBhdc-000347-4y
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:17:18 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBhdb-0002op-LS
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 11:17:16 -0400
Received: by mail-ot1-x341.google.com with SMTP id u15so15697234otq.10
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 08:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124948.GA14129@ls3530.dellerweb.de>
	<CAFEAcA8qyunxOtqrWLPsr34fUt5t2kCrXa8hOMti0bYYbZDpyA@mail.gmail.com>
In-Reply-To: <CAFEAcA8qyunxOtqrWLPsr34fUt5t2kCrXa8hOMti0bYYbZDpyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Apr 2019 22:17:01 +0700
Message-ID: <CAFEAcA91KBoxtAdjpsVZ3wE_9YaaeMHYEy=VHPNAKspjjH7UDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Relax check for libseccomp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 3 Apr 2019 at 22:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 3 Apr 2019 at 19:51, Helge Deller <deller@gmx.de> wrote:
>
> [cc'ing Eduardo as the seccomp submaintainer]
>
> > On a non-release architecture, the configure program aborts if the
> > --enable-seccomp flag was given (with no way to work around it on the
> > command line):
> >
> > ERROR: User requested feature libseccomp
> >         configure was not able to find it.
> >         libseccomp is not supported for host cpu parisc64

> What particular host arch are you using?

Doh, just noticed that the error message has the answer to this!

thanks
- PMM
