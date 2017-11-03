Received: from eggs.gnu.org ([2001:4830:134:3::10]:54111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAdBy-0007rW-7S
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAdBx-0000KU-A6
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:43:30 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:44895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAdBx-0000Ju-0k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 10:43:29 -0400
Received: by mail-wm0-x241.google.com with SMTP id n74so3124523wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 07:43:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171102090906.30391-1-danielhb@linux.vnet.ibm.com>
References: <20171102090906.30391-1-danielhb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 14:43:07 +0000
Message-ID: <CAFEAcA-L4MWw_ES21svL27O6X5dhpjjx6kdp9BW3w4Qei74kjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5] configure: check $CC available before
 verifying host CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 2 November 2017 at 09:09, Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com> wrote:
> When executing 'configure' in a fresh QEMU clone, in a fresh
> OS install running in a ppc64le host, this is the error
> shown:
>
> -----
>
> ../configure --enable-trace-backend=simple --enable-debug
>     --target-list=ppc64-softmmu
>
> ERROR: Unsupported CPU = ppc64le, try --enable-tcg-interpreter
>
> -----
>
> This isn't true, ppc64le host CPU is supported. This happens because,
> in a fresh install, we don't have a C compiler to autodetect
> the $cpu variable to "ppc64".
>
> This patch moves the CC available check up a bit, just before verifying
> the host CPU. This ensures that we bail out with a $CC not available
> error instead of unsupported CPU (the host CPU detection without
> the compiler wouldn't work properly anyway). It also allows --help to
> keep working without a C compiler. With this patch, in the same ppc64le
> host without gcc:
>
> $ ../configure --enable-trace-backend=simple --enable-debug
>     --target-list=ppc64-softmmu
>
> ERROR: "cc" either does not exist or does not work
>
> $ ../configure --help
>
> Usage: configure [options]
> Options: [defaults in brackets after descriptions]
>
> Standard options:
>   --help                   print this message
>   --prefix=PREFIX          install in PREFIX [/usr/local]
>   --interp-prefix=PREFIX   where to find shared libraries, etc.
> (...)
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---
>  configure | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

ccing qemu-trivial since that seems like a plausible tree for this.

thanks
-- PMM
