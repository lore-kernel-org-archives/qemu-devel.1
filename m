Received: from eggs.gnu.org ([209.51.188.92]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go8Zj-00026M-KW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1go8Zc-00038D-SY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:11:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1go8ZX-00035x-JJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:11:39 -0500
Date: Mon, 28 Jan 2019 15:11:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190128151128.GB3437@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
	<CAFEAcA9gvX_9HDadd1VaC214CLDg7w1dOdCaKXuG5PXxC+-quA@mail.gmail.com>
	<20190128145642.GA3437@redhat.com>
	<CAFEAcA9cDvq3VRaQfAgEvc-sKA4TYEC9PuFX_Vofo18bSbip=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9cDvq3VRaQfAgEvc-sKA4TYEC9PuFX_Vofo18bSbip=Q@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Adam Baxter <voltagex@voltagex.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 28, 2019 at 03:03:34PM +0000, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 14:56, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Mon, Jan 28, 2019 at 01:46:57PM +0000, Peter Maydell wrote:
> > > qemu-icon.bmp seems also to still be listed in the LINKS
> > > in configure which defines what we symlink from the source
> > > tree to the build tree (and again, the png files are not).
> >
> > Wierd, I don't understand why we need any of that LINKS stuff in
> > configure. Not having the png files listed doesn't cause any
> > obvious problem that I can see. For that matter nor does having
> > the (now deleted) qemu-icon.bmp seem to cause a failure, as we
> > silent ignore source tree files that don't exist.
>=20
> The LINKS stuff is so that you can run binaries from out of
> the build directory and have them find things like the BIOS
> blobs. In this case presumably a QEMU run from the build
> dir wouldn't find its icon (unless somebody had done a
> 'make install' on the system in the past). Though something
> doesn't seem quite right here, because the sdl2.c code is
> looking for icon files in a hicolor/ subdirectory that
> doesn't exist in the source tree.

That directory is the standard icon installation directory for
application icons. The QEMU icons are placed there by 'make install',
but in the source dir they are in a flat layotu.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
