Received: from eggs.gnu.org ([2001:4830:134:3::10]:35735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f48gR-0006SO-9z
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f48gQ-0004rT-Gt
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:28:23 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f48gQ-0004r5-C3
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:28:22 -0400
Received: by mail-ot0-x243.google.com with SMTP id h55-v6so26597940ote.9
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 10:28:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
References: <OF802C7AAD.A9501847-ON0625823D.000350FE-0625823D.0003998B@ddci.com>
	<CAFEAcA9hNNT_ooL+YKsU-V8X_FKT9x-ca+ae03DtybV13s7GoA@mail.gmail.com>
	<OF03E560EC.20D03DEC-ON88258258.001D166A-86258258.001E50AC@ddci.com>
	<CAFEAcA-PXNDUfj7b6awd5KjtGuQd3F4Diy1tkEmYa9gBoxUjiA@mail.gmail.com>
	<OF28E56C94.CBE4DE9D-ON88258266.005BC5B3-86258266.005BFAF5@ddci.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 18:28:01 +0100
Message-ID: <CAFEAcA8KrrzDacQXsiW-UxKsy4sodCteUWgAHu6ZdyMG4u7riQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] -icount changes physical address assignments in
 QEMU 2.10/2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 April 2018 at 17:44,  <alarson@ddci.com> wrote:
> "Peter Maydell" <peter.maydell@linaro.org> wrote on 04/05/2018 09:05:53
> AM:
>> I've just tried your attached test image ...
>
> Curious.  I just downloaded qemu-2.12.0-rc2.tar.xz and built it using
> Cygwin (a version from about a month ago) using mingw compilers
> (mingw64-i686-gcc-g++ 6.4.0), and I still see the issue when the
> resulting QEMU binary is run using -icount 2 against my test binary,
> but not when run without -icount.  Here are the commands used:
>
> ../qemu-2.12.0-rc2/configure --python=/usr/bin/python \
>    '--with-pkgversion=DDCI QEMU 2.12.0-rc2' \
>    --prefix=/usr/local/qemu \
>    --enable-sdl --with-sdlabi=2.0 \
>    '--target-list=aarch64-softmmu ppc64-softmmu x86_64-softmmu' \
>    --cross-prefix=i686-w64-mingw32-
> /usr/bin/make -Otarget -j 8
>
> Any suggestions of things to try?

Can you reproduce the problem on a Linux host? It would
be interesting to identify if this is a Windows-host
specific issue somehow.

thanks
-- PMM
