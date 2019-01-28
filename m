Received: from eggs.gnu.org ([209.51.188.92]:53280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8d3-0004tJ-Vl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go8d3-00046I-Bo
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:15:17 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go8d3-00045x-7R
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:15:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id k98so14909425otk.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 07:15:16 -0800 (PST)
MIME-Version: 1.0
References: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
	<CAFEAcA9gvX_9HDadd1VaC214CLDg7w1dOdCaKXuG5PXxC+-quA@mail.gmail.com>
	<20190128145642.GA3437@redhat.com>
	<CAFEAcA9cDvq3VRaQfAgEvc-sKA4TYEC9PuFX_Vofo18bSbip=Q@mail.gmail.com>
	<20190128151128.GB3437@redhat.com>
In-Reply-To: <20190128151128.GB3437@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 15:15:04 +0000
Message-ID: <CAFEAcA_ZKNPd+m695jueEjoHUWLv88U_NcpVZwqiCD2HmUHsbg@mail.gmail.com>
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

On Mon, 28 Jan 2019 at 15:11, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Jan 28, 2019 at 03:03:34PM +0000, Peter Maydell wrote:
> > Though something
> > doesn't seem quite right here, because the sdl2.c code is
> > looking for icon files in a hicolor/ subdirectory that
> > doesn't exist in the source tree.
>
> That directory is the standard icon installation directory for
> application icons. The QEMU icons are placed there by 'make install',
> but in the source dir they are in a flat layotu.

There doesn't seem to be any code to handle the flat layout,
though. (Contrast os_find_datadir() which looks in several
places for any particular file.)

thanks
-- PMM
