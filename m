Received: from eggs.gnu.org ([209.51.188.92]:50910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gpV2f-0004bz-TD
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:23:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gpV2d-0000dc-QZ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:23:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gpV2d-0000dL-9n
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:23:19 -0500
Date: Fri, 1 Feb 2019 09:23:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190201092313.GB12005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190129113921.21599-1-berrange@redhat.com>
	<90a3688e-12f9-3209-e0b5-618b1029e1a1@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90a3688e-12f9-3209-e0b5-618b1029e1a1@weilnetz.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] misc fixes to deal with icon location
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, Adam Baxter <voltagex@voltagex.org>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Feb 01, 2019 at 08:52:25AM +0100, Stefan Weil wrote:
> On 29.01.19 12:39, Daniel P. Berrang=C3=A9 wrote:
> > This is a few misc fixes identified after the icon location changes
> > were merged. Most importantly it deals with the nsis installer file
> > manifest.
> >=20
> > Daniel P. Berrang=C3=A9 (5):
> >   nsis: don't install files into /tmp
> >   make: don't insert a '/' after $(DESTDIR)
> >   nsis: ensure we always pass -W64 flag to nsis installer script
> >   nsis: fix location of icons to be bundled in the installer
> >   configure: stop trying to link non-existant bmp file from bios dir
> >=20
> >  Makefile  | 23 +++++++++++++----------
> >  configure |  1 -
> >  qemu.nsi  |  4 ++--
> >  3 files changed, 15 insertions(+), 13 deletions(-)
> >=20
>=20
> There was also a file rename which needs to be handled,
> otherwise NSIS still fails:
>=20
> File: "/tmp/qemu-nsis\qemu_logo_no_text.svg" -> no files found.

I don't see that prolem - NSIS builds successfully for me, and I can't
find any reference to .svg files in the qemu.nsi=20

> The new qemu.svg still includes the old file name. That could be fixed,=
 too.

Oh, in its metadata I see.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
