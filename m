Received: from eggs.gnu.org ([209.51.188.92]:51395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8X7-0008IU-31
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8S5-0005hi-TM
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:03:59 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go8S0-0005ef-9w
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:03:54 -0500
Received: by mail-oi1-x243.google.com with SMTP id r62so13296534oie.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:03:46 -0800 (PST)
MIME-Version: 1.0
References: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
	<CAFEAcA9gvX_9HDadd1VaC214CLDg7w1dOdCaKXuG5PXxC+-quA@mail.gmail.com>
	<20190128145642.GA3437@redhat.com>
In-Reply-To: <20190128145642.GA3437@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 15:03:34 +0000
Message-ID: <CAFEAcA9cDvq3VRaQfAgEvc-sKA4TYEC9PuFX_Vofo18bSbip=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Building nsis installer - cross compile for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Adam Baxter <voltagex@voltagex.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 28 Jan 2019 at 14:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Jan 28, 2019 at 01:46:57PM +0000, Peter Maydell wrote:
> > qemu-icon.bmp seems also to still be listed in the LINKS
> > in configure which defines what we symlink from the source
> > tree to the build tree (and again, the png files are not).
>
> Wierd, I don't understand why we need any of that LINKS stuff in
> configure. Not having the png files listed doesn't cause any
> obvious problem that I can see. For that matter nor does having
> the (now deleted) qemu-icon.bmp seem to cause a failure, as we
> silent ignore source tree files that don't exist.

The LINKS stuff is so that you can run binaries from out of
the build directory and have them find things like the BIOS
blobs. In this case presumably a QEMU run from the build
dir wouldn't find its icon (unless somebody had done a
'make install' on the system in the past). Though something
doesn't seem quite right here, because the sdl2.c code is
looking for icon files in a hicolor/ subdirectory that
doesn't exist in the source tree.

thanks
-- PMM
