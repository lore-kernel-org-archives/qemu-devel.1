Received: from eggs.gnu.org ([209.51.188.92]:52786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMFo-0006YV-6B
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMFh-0006M0-3O
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:00:56 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMFa-0006E9-Oz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:00:49 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so12407544otl.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<CAFEAcA89HnCL11_N9oXqwQZf=TFJdHzONg6jxy9FORNwK85OZA@mail.gmail.com>
	<CAMxuvax=wO+dGTcgxV5L0CLf9nOozgNCM7TdqPeyj09=th0Jgw@mail.gmail.com>
	<CAFEAcA9m9CgfOsE5hVcQpWFvX7Pq9wVWiC3jf2Yr0SrXQPnTKg@mail.gmail.com>
	<95b82190-43f4-7b41-c1ee-10192f06b996@redhat.com>
In-Reply-To: <95b82190-43f4-7b41-c1ee-10192f06b996@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:00:31 +0000
Message-ID: <CAFEAcA9ASDzOHcsv_4gOi5ap=5UfcQnqK8PuDxvZi1=ngs+OPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/11] Enable build and install of our rST
 docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Thu, 14 Feb 2019 at 18:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/02/19 16:24, Peter Maydell wrote:
> > It does check, but I forgot to make the makefiles pay attention
> > to the check.
> >
> > That's very irritating that Fedora is using a weird filename for
> > the tool -- what is their justification for doing that?
> > I suppose we'll have to make configure cope :-(
>
> They do have sphinx-build but it uses Python 2.  If you only install the
> Python 3 version, you get sphinx-build-3

OK, so we could just make configure require "sphinx-build"
and fall back to "no docs if you don't have the tool";
that's not so bad.

thanks
-- PMM
