Received: from eggs.gnu.org ([2001:4830:134:3::10]:56963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZYhc-0001F1-Db
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZYhW-0001b2-QJ
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:03:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZYhU-0001Ze-R5
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:03:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 37AE4356F8
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:03:35 +0000 (UTC)
Date: Wed, 19 Dec 2018 10:03:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181219100325.GC20465@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181218142629.15943-1-berrange@redhat.com>
	<20181218142629.15943-2-berrange@redhat.com>
	<20181219072023.2hbaoqrfp6r2ihog@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219072023.2hbaoqrfp6r2ihog@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] ui: install logo icons to
 $prefix/share/icons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Dec 19, 2018 at 08:20:23AM +0100, Gerd Hoffmann wrote:
> On Tue, Dec 18, 2018 at 02:26:27PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > QEMU currently installs loogs to $prefix/share/qemu/ which means no G=
UI
> > toolkit or applications can find them by default.
> >=20
> > The accepted standards for desktop applications declare that applicat=
ion
> > logos / icons should be installed under $prefix/share/icons, so use t=
his
> > directory location.
> >=20
> > Pre-rendered icons are provided at the standard sizes expected for GU=
I
> > applications, along with the scalable SVG, to ensure maximum portabil=
ity.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  Makefile                                       |  13 ++++++++++++-
> >  configure                                      |   2 ++
> >  ui/gtk.c                                       |  17 +++++----------=
--
> >  .../qemu_logo_no_text.svg =3D> ui/icons/qemu.svg |   0
> >  ui/icons/qemu_128x128.png                      | Bin 0 -> 7761 bytes
> >  ui/icons/qemu_16x16.png                        | Bin 0 -> 751 bytes
> >  ui/icons/qemu_24x24.png                        | Bin 0 -> 1167 bytes
> >  ui/icons/qemu_256x256.png                      | Bin 0 -> 16216 byte=
s
> >  .../qemu-icon.bmp =3D> ui/icons/qemu_32x32.bmp   | Bin
> >  ui/icons/qemu_32x32.png                        | Bin 0 -> 1656 bytes
> >  ui/icons/qemu_48x48.png                        | Bin 0 -> 2604 bytes
> >  ui/icons/qemu_512x512.png                      | Bin 0 -> 34609 byte=
s
> >  ui/icons/qemu_64x64.png                        | Bin 0 -> 3588 bytes
>=20
> How did you create the png files?
> Can you drop a script or Makefile for that into the ui/icons directory?

I used GIMP so that it created high quality antialiased pngs.

> Should we commit them to git, or generate at build time?
> Is the tool used something we can expect to be installed?

I tried using ImageMagick to convert SVG to PNG but the results
were really poor compared to GIMP - very fuzzy. Running with
-verbose I can see it is invoking inkscape to atually do the
conversion, and it tells inkscape to export a small image which
it then resizes, hence the quality loss. Also I think InkScape
is getting a bit unreasonable for a standard QEMU developer
install.

The icons are small enough that we shouldn't really worry about
having pre-rendered icons in GIT IMHO. They're not ever going to
change unless we replace our logo again.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
