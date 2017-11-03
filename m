Received: from eggs.gnu.org ([2001:4830:134:3::10]:46595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAbAz-00076b-Ow
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAbAw-0000Jw-K1
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAbAw-0000Jj-E6
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:34:18 -0400
Message-ID: <1509712454.31823.24.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 13:34:14 +0100
In-Reply-To: <CAFEAcA9J+uQ4xRSddJJPFC_Dk_j9+ESG1NY4B7qxkzasN86qFw@mail.gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
	<1509705342.31823.16.camel@redhat.com>
	<CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
	<1509706872.31823.20.camel@redhat.com>
	<CAFEAcA9kLX19tWACRLEGSd6iuRahTkBrORJqt1GSBSAA4bwr6g@mail.gmail.com>
	<1509710857.31823.22.camel@redhat.com>
	<CAFEAcA9J+uQ4xRSddJJPFC_Dk_j9+ESG1NY4B7qxkzasN86qFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/7] sdl2: Only accept the hotkeys on the
 main window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 2017-11-03 at 12:10 +0000, Peter Maydell wrote:
> On 3 November 2017 at 12:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > =C2=A0 Hi,
> >=20
> > > I don't think we have the same grab semantics exactly on all
> > > UI frontends either, so I dunno that that "doesn't grab on
> > > tablet"
> > > is true either.
> >=20
> > Well, there are pointer grabs and keyboard grabs.
> >=20
> > Pointer grabs happen in relative mouse mode only, and I'm pretty
> > sure
> > we are consistent here.
>=20
> Looking at the cocoa code, we grab the mouse even for absolute.
> Commit f61c387ea627079b3 says we did that to align with SDL.

That seems to be a *keyboard* grab ...

cheers,
  Gerd
