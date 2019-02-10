Received: from eggs.gnu.org ([209.51.188.92]:53896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswlY-0003bW-Hb
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gswlX-0004xk-R9
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:35:56 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gswlU-0004uw-QA
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:35:54 -0500
Received: by mail-ot1-x344.google.com with SMTP id i5so3880477oto.9
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 13:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190208181122.23393-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Feb 2019 21:35:37 +0000
Message-ID: <CAFEAcA-P_vVy8dbti83Afm6CMNZBmr5FUzMeztCwp=NRXwn5qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH slirp 0/5] Make it a standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Fri, 8 Feb 2019 at 20:58, <marcandre.lureau@redhat.com> wrote:
> As discussed earlier in "[PATCH for-3.2 00/41] RFC: slirp: make it
> again a standalone project" and other threads, it would be useful to
> make slirp a separate project (the submodule approach was discarded)
> for various projects to share.

> The following patches add meson build system (if necessary for older
> distros, autotools could be added - however I believe python & ninja
> are generally available on the QEMU supported platforms)

Do you really need to make QEMU add an extra build dependency
just to use a different build system? From my end that seems like
just unnecessary pain for us (we're going to need to ship libslirp
as a submodule for a while until it's been around long enough to
be in stable distros, so its build dependencies will get added
to QEMU's build deps).

Is the standalone project going to provide a shared library
or just a .a static library? (ie are you confident enough in
the long-term stability of your API and ABI to do the shared
library yet? the prudent approach might be to start with just
the .a...)

thanks
-- PMM
