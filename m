Received: from eggs.gnu.org ([209.51.188.92]:33985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1pf3-0003TH-Pm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1pf2-0004x0-S9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:49:57 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:46848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1pf2-0004wh-Hg
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:49:56 -0500
Received: by mail-oi1-x22d.google.com with SMTP id j10so12379665oij.13
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 01:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-9-peter.maydell@linaro.org>
	<20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
In-Reply-To: <20190307014028.hggeogcxuwldc5ms@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 09:49:44 +0000
Message-ID: <CAFEAcA8jcshKLW8+fQJ30Y02LTmqxrwpShZKDP7NNOOGSwaY3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 08/12] docs: Provide separate conf.py
 for each manual we want
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 7 Mar 2019 at 01:40, Cleber Rosa <crosa@redhat.com> wrote:
> I have the impression that this can be simplified by making use of
> "only" tags:
>
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-only
>
> So, conf.py could detect if it's being run on readthedocs.org:
>
>   ON_RTD = os.environ.get('READTHEDOCS', None) == 'True'
>
> And manipulate the "tags" variable accordingly:
>
>   if ON_RTD:
>      tags.add('devel')
>      tags.add('interop')
>
> Then, on an index.rst, it could be a simple matter of:
>
> .. only:: devel
> ================
> Developers Guide
> ================
> .. toctree::
>    docs/devel
>
> .. only:: interop
> =============
> Interop Guide
> =============
> .. toctree::
>    docs/interop
>
> .. only:: devel and interop
> ===============
> QEMU Full Guide
> ===============
> .. toctree::
>    docs/devel
>    docs/interop

Thanks for pointing out the tags functionality. That said,
this won't do what we want, will it?
 * building the docs gives all the docs in the build tree
 * but we only install via 'make install' the ones the user wants

thanks
-- PMM
