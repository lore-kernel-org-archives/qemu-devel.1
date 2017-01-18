Received: from eggs.gnu.org ([2001:4830:134:3::10]:43485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTszj-0000lV-SW
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTszj-0000DC-1v
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:21:55 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:33707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTszi-0000Cl-Tf
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:21:54 -0500
Received: by mail-ua0-x22b.google.com with SMTP id i68so13052103uad.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 08:21:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118150235.23850-2-bobby.prani@gmail.com>
References: <20170118150235.23850-1-bobby.prani@gmail.com>
	<20170118150235.23850-2-bobby.prani@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Jan 2017 16:21:34 +0000
Message-ID: <CAFEAcA-KFb6SAdBpuMHZVHDKQdFM3cWJNRuB-oaY8gsRv0Th=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: fix tcg/mmap test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 18 January 2017 at 15:02, Pranith Kumar <bobby.prani@gmail.com> wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> tests/tcg/mmap test fails with values other than default target page
> size. When creating a map beyond EOF, extra anonymous pages are added up
> to the target page boundary. Currently, this operation is performed only
> when qemu_real_host_page_size < TARGET_PAGE_SIZE, but it should be
> performed if the configured page size (qemu -p) is larger than
> qemu_real_host_page_size too.
>
> (also fixes some style issues to please checkpatch)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

This got reviewed-by with caveats from two people when
it was last sent but you have neither included the R-by
tags nor addressed the minor tweaks they asked you to
address.

thanks
-- PMM
