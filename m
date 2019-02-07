Received: from eggs.gnu.org ([209.51.188.92]:39608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grksz-0007np-U9
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grkso-0004VC-Io
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:42:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grksk-0004TA-HL
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:42:28 -0500
Date: Thu, 7 Feb 2019 14:42:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190207144210.GM19438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
	<20190207132935.ijtfsiafpfggugiz@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190207132935.ijtfsiafpfggugiz@function>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv3 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Feb 07, 2019 at 03:29:35PM +0200, Samuel Thibault wrote:
> Peter Maydell, le jeu. 07 f=C3=A9vr. 2019 11:46:23 +0000, a ecrit:
> > On Tue, 5 Feb 2019 at 18:28, Samuel Thibault
> > <samuel.thibault@ens-lyon.org> wrote:
> > >
> > > The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a=
356e159d:
> > >
> > >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pul=
l-request' into staging (2019-02-05 14:01:29 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibaul=
t
> > >
> > > for you to fetch changes up to 1e924479dce65a26a7432bf5920f89c1bf95=
7d74:
> > >
> > >   slirp: API is extern C (2019-02-05 20:27:27 +0200)
> > >
> > > ----------------------------------------------------------------
> > > More work towards libslirp
> > >
> >=20
> > Format string issues for the Windows build:
>=20
> Oh, I am not getting these errors with make docker-test-mingw@fedora,
> perhaps something would need to be fixed there to test as much as you d=
o?

You're seeing a difference due to the version of glib2 that's built.

Previously the GLIB_*_FORMAT macros would contain the win32 platform
specific formats, and the g_critical function would be annotated
with 'printf'.

Now GLib2's  GLIB_*_FORMAT macros will contain the GNU compatible=20
formats, and the g_critical function would be annotated 'gnu_printf'.

So your Fedora build test used the gnu_printf based glib2 and so
didn't trigger the warnings.

Peter's build probably uses an older glib.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
