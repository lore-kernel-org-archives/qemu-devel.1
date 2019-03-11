Received: from eggs.gnu.org ([209.51.188.92]:55328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3Lns-0000Sm-Kf
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h3Lha-0002ak-Ho
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h3LhZ-0002UK-Pi
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:14:50 -0400
Date: Mon, 11 Mar 2019 14:14:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190311141437.GA12393@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CGME20181127135037eucas1p18867a9ae8b1f2731ad4ce8d79fddae33@eucas1p1.samsung.com>
	<20181127135030.1671-1-i.maximets@samsung.com>
	<1fa60eac-9718-ee9d-e21c-3331c3bd60ff@samsung.com>
	<CAJ+F1CKBJZ504S5sPvgXfcJvLkG1XpzJ499H54hT4cLffdm+Og@mail.gmail.com>
	<20190311125614.GV12393@redhat.com>
	<20190311141229.GK8899@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190311141229.GK8899@habkost.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] memfd fixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Ilya Maximets <i.maximets@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Mon, Mar 11, 2019 at 11:12:29AM -0300, Eduardo Habkost wrote:
> On Mon, Mar 11, 2019 at 12:56:14PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Mon, Mar 11, 2019 at 01:50:37PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi
> > >=20
> > > On Mon, Mar 11, 2019 at 1:35 PM Ilya Maximets <i.maximets@samsung.c=
om> wrote:
> > > >
> > > > Hi.
> > > >
> > > > I'm trying to figure out the state of this patch set.
> > > > Is there any chance for it to be accepted?
> > > >
> > > > The first patch needs minor rebase. I could send a new version.
> > >=20
> > > Please do,
> > >=20
> > > I prefer the solution proposed in v2: do not register hostmem-memfd=
 if
> > > sealing isn't supported (keep sealing=3Dtrue the default - it's one=
 of
> > > the main purpose of memfd imho).
> > >=20
> > > Daniel, Eduardo: are you ok with this series for 4.0?
> >=20
> > I prefer the more flexible approach, but I won't object to tieing mem=
fd
> > to sealing support.
>=20
> Daniel, Marc-Andr=C3=A9: do you know if the libvirt QEMU capability
> cache is invalidated when the host kernel version changes?

Yes kernl version is one of the many invalidation criteria:

https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dsrc/qemu/qemu_capab=
ilities.c;h=3Dc9700193fd0c404c16dd6f334b80255a4d1ba605;hb=3DHEAD#l4072

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
