Received: from eggs.gnu.org ([209.51.188.92]:54451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gswoS-0004rg-1J
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gswoP-0006OD-Mw
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:38:55 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:53858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gswoI-0006K2-D4
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 16:38:48 -0500
Date: Sun, 10 Feb 2019 22:38:39 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190210213839.vfocl3mv2ivgz5h2@function>
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
	<CAFEAcA-P_vVy8dbti83Afm6CMNZBmr5FUzMeztCwp=NRXwn5qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-P_vVy8dbti83Afm6CMNZBmr5FUzMeztCwp=NRXwn5qw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH slirp 0/5] Make it a standalone project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hello,

Peter Maydell, le dim. 10 f=C3=A9vr. 2019 21:35:37 +0000, a ecrit:
> On Fri, 8 Feb 2019 at 20:58, <marcandre.lureau@redhat.com> wrote:
> > As discussed earlier in "[PATCH for-3.2 00/41] RFC: slirp: make it
> > again a standalone project" and other threads, it would be useful to
> > make slirp a separate project (the submodule approach was discarded)
> > for various projects to share.
>=20
> > The following patches add meson build system (if necessary for older
> > distros, autotools could be added - however I believe python & ninja
> > are generally available on the QEMU supported platforms)
>=20
> Do you really need to make QEMU add an extra build dependency
> just to use a different build system?

AIUI, this patches series is meant for the slirp repository, not the
QEMU repository. I.e. just to show how it'll look like, until a project
it settled somewhere and the discussion can happen there.

Samuel
