Received: from eggs.gnu.org ([209.51.188.92]:53772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hArqT-0003eL-Ao
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hArqS-00020m-CR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:59:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hArqR-0001w5-6o
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:59:03 -0400
Received: by mail-oi1-x244.google.com with SMTP id x188so6446162oia.13
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 00:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-10-peter.maydell@linaro.org>
	<92ffba93-e486-647a-01ef-86180fb2cbb2@redhat.com>
In-Reply-To: <92ffba93-e486-647a-01ef-86180fb2cbb2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Apr 2019 07:58:45 +0000
Message-ID: <CAFEAcA8U1o7JZmAP4nhsiY+riFtZmxHBQCkOu0zmR++K70gnQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 09/12] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, "Richard W.M. Jones" <rjones@redhat.com>

On Sat, 30 Mar 2019 at 22:05, Eric Blake <eblake@redhat.com> wrote:
> Rich told me that qemu-nbd.8 was not being built, and I confirmed that
> it failed to build for me. git bisect points to this commit as the
> reason that 'touch qemu-nbd.texi; make' no longer rebuilds qemu-nbd.8
> automatically. Is it merely because I don't have enough stuff installed,
> or is it an actual broken dependency?
>
> /me goes and runs 'dnf install "*/sphinx-build"...
>
> Nope, even with that installed, qemu-nbd.8 is still not getting built by
> 'make'; but 'make qemu-nbd.8' is working. We lost a dependency :(

I just did a test build from clean and I get a qemu-nbd.8 in the
build directory. I also  checked that 'touch qemu-nbd.texi; make -C build V=1'
rebuilds the manpage, and it does:

[snip other stuff]
perl -Ww -- /home/pm215/qemu/scripts/texi2pod.pl -I docs -I
/home/pm215/qemu -I . "-DVERSION=3.1.91"
/home/pm215/qemu/qemu-nbd.texi qemu-nbd.8.pod && pod2man --utf8
--section=8 --center=" " --release=" " qemu-nbd.8.pod > qemu-nbd.8
[...]

You will need sphinx-build in order to build
the docs now, and without that we won't build the manpage, but
if you have sphinx-build installed then it should work.
Can you check that your config-host.mak has BUILD_DOCS=yes ?
Did you definitely rerun configure after installing sphinx?

thanks
-- PMM
