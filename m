Received: from eggs.gnu.org ([209.51.188.92]:54281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1sml-0001m8-9O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:10:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1smj-00074C-0e
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:10:07 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1smi-00073u-O4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:10:04 -0500
Received: by mail-ot1-x343.google.com with SMTP id t7so13984823otk.8
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 05:10:04 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
In-Reply-To: <a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 13:09:52 +0000
Message-ID: <CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Thu, 7 Mar 2019 at 12:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> In any case, this wouldn't change; as you suggest below, configure could
> remain as a front-end (well, in-srcdir builds are not supported by
> Meson, so "../configure && ninja" perhaps).

As an aside, it might be a nice idea to drop the in-srcdir
build altogether for QEMU anyway -- it's not really a very
good idea and it means our build system has to cope with two
different ways of working to no particularly useful end.

> > I suspect needing Python 3.5 means it will take a while before all our
> > build hosts will have it.
>
> Which ones don't?  (This is the information I might be missing and why I
> have started the thread). RHEL7 has it in software collections, OS X in
> Homebrew.   RHEL6 is not a supported host anymore.

Of the various hosts I do builds on:
 * OSX is 2.7 only
 * the ppc64 box in the gcc compile farm is 2.7 and 3.4
   ("Centos 7.5.1804")
 * the aarch64 box in the gcc compile farm is 2.7 and 3.4
   ("Ubuntu 14.04.5 LTS", aka trusty)

I haven't checked the BSD VM images.

thanks
-- PMM
