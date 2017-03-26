Received: from eggs.gnu.org ([2001:4830:134:3::10]:34136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cs7jl-00016n-SN
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 08:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cs7jk-0002KC-Q5
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 08:57:37 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cs7jk-0002Jt-K7
	for qemu-devel@nongnu.org; Sun, 26 Mar 2017 08:57:36 -0400
Received: by mail-wr0-x232.google.com with SMTP id l43so20349171wre.1
	for <qemu-devel@nongnu.org>; Sun, 26 Mar 2017 05:57:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
References: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Mar 2017 13:57:14 +0100
Message-ID: <CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Problems with native Mingw-w64 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On 26 March 2017 at 11:30, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> In order to do some testing on a Windows box, I've spent a bit of time
> this weekend setting up a mingw-w64 build environment on Windows 10
> using http://wiki.qemu-project.org/Hosts/W32 as a guideline.

I think most people prefer to use the cross-compile.
Stefan might do native compiles.

> 2) glib-compat mkdtemp() error

> This one seems to be a genuine bug since the wiki above mentions that
> 64-bit builds cannot use versions of glib > 2.22 due to a change in the
> way global symbols are managed. Since g_dir_make_tmp() only appears in
> glib 2.30 and later, we end up using the fallback code which fails
> because mkdtemp() isn't available on Windows.

Since 2.7 the minimum version of glib has been 2.30 for Windows
(documented in http://wiki.qemu-project.org/ChangeLog/2.7),
because of this g_dir_make_tmp() dependency. Unfortunately
it looks like we forgot to update configure (we didn't for 2.7
because we noticed the issue quite late in the release cycle).

thanks
-- PMM
