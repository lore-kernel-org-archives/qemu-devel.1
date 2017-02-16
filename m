Received: from eggs.gnu.org ([2001:4830:134:3::10]:38627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cePVF-0006E3-Mw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cePVE-0003wL-Iz
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:57 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cePVE-0003w7-CH
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:56 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so20244312wmg.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 09:05:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 17:05:34 +0000
Message-ID: <CAFEAcA9Em0dC7Bj73q+EQS0=nAZWGLGGoRjrT0nZq51XgEG-5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chad Joan <chadjoan@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 16 February 2017 at 16:30, Chad Joan <chadjoan@gmail.com> wrote:
> Hello,
>
> This is a one-line patch to the configure script that will allow QEMU to be
> built on musl-libc based Linux systems.  This problem is only noticeable
> when QEMU is built with --enable-curses.
>
> Detailed reading material if you want to know where this came from:
> https://bugs.gentoo.org/show_bug.cgi?id=609364

Thanks for the bug report and the patch. I'm a bit confused
about why it's necessary, though. We already define _GNU_SOURCE,
which the musl docs say implies _XOPEN_SOURCE:
 https://www.musl-libc.org/doc/1.0.0/manual.html
Is that not true for your musl, or is our configure script
failing to pass -D_GNU_SOURCE when building the curses test program?

If we do need an explicit define of _XOPEN_SOURCE I think we should
do it at the same place where we add -D_GNU_SOURCE to the cflags.

thanks
-- PMM
