Received: from eggs.gnu.org ([2001:4830:134:3::10]:44920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfmrx-0005LN-U6
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cfmrw-0001Ah-JZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:15:05 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:32833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cfmrw-0001Ab-Cb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:15:04 -0500
Received: by mail-wr0-x22e.google.com with SMTP id 35so22648578wrw.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:15:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170219200231.30672-1-laurent@vivier.eu>
References: <20170219200231.30672-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 12:14:42 +0000
Message-ID: <CAFEAcA-wewMTE0qP1VB1VSTk=mNhZKxpQfrC79twv7iFk+Nedg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] risu-m68k: update fpregs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 February 2017 at 20:02, Laurent Vivier <laurent@vivier.eu> wrote:
> f_fpregs is a 2d array, not 1d:
>
>  typedef struct fpregset
>  {
>    int f_pcr;
>    int f_psr;
>    int f_fpiaddr;
>  #ifdef __mcoldfire__
>    int f_fpregs[8][2];
>  #else
>    int f_fpregs[8][3];
>  #endif
>  } fpregset_t;
>
> For the moment, we don't manage ColdFire case, only 680x0.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Thanks; applied to target-arm.next.

I've also pushed out support for building risu into a separate
build directory, and a 'build-all-archs' script that will
build every target CPU arch that you have a cross compiler
installed for (Debian and Ubuntu package cross compilers for
everything, helpfully).

thanks
-- PMM
