Received: from eggs.gnu.org ([2001:4830:134:3::10]:56094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPU7a-0007dt-Nj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPU7Z-0006pU-Ry
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:32:06 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPU7Z-0006ov-KY
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 09:32:05 -0400
Received: by mail-wr0-x231.google.com with SMTP id 77so144822762wrb.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 06:32:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
References: <1496414138-7622-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 14:31:43 +0100
Message-ID: <CAFEAcA8t=9xjo-+UBraSRQt51CvSVudJ_iNWkES6dZbJ=rkM2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Define NCURSES_WIDECHAR if
 we're using curses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chad Joan <chadjoan@gmail.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Rainer_M=C3=BCller?= <raimue@codingfarm.de>, "patches@linaro.org" <patches@linaro.org>

On 2 June 2017 at 15:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> We want the wide character functions from the ncurses header.
> Unfortunately it doesn't provide them by default, but only
> if either:
>  * NCURSES_WIDECHAR is defined (for ncurses 20111030 and up)
>  * _XOPEN_SOURCE/_XOPEN_SOURCE_EXTENDED are suitably defined
>
> So far we have been implicitly relying on the latter, because
> for GNU libc when we define _GNU_SOURCE this causes libc
> to define the _XOPEN_SOURCE macros for us. Unfortunately
> this doesn't work on all libcs, because some (like OSX and
> musl libc) do not define _XOPEN_SOURCE when _GNU_SOURCE
> is defined.
>
> We can't fix this by defining _XOPEN_SOURCE ourselves, because
> that also means "and don't provide any functions that aren't in
> that standard", and not all libcs provide any way to override
> that to also get the non-standard functions. In particular
> FreeBSD has no such mechanism, and OSX's _DARWIN_C_SOURCE
> doesn't reenable everything (for instance getpagesize()
> is still not prototyped if _DARWIN_C_SOURCE and _XOPEN_SOURCE
> are both defined).
>
> So we have to define NCURSES_WIDECHAR. (This will only work
> if your ncurses is at least 20111030, as older versions
> don't honour this macro.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Applied, thanks.

-- PMM
