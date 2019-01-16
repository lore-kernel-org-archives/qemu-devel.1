Received: from eggs.gnu.org ([209.51.188.92]:46406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjnRL-0005FR-1u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjnRK-0006wW-1t
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:49:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjnRJ-0006w8-SI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:49:13 -0500
Date: Wed, 16 Jan 2019 15:48:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116154857.GC20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
	<20181211105329.GE921@redhat.com>
	<52c43506-ef39-6d08-7db4-ad3c0f96dd1f@samsung.com>
	<20181212064936.ubnv3yif34e7ga5j@sirius.home.kraxel.org>
	<20190116153027.GC14807@habkost.net>
	<856c189d-937e-2471-c3c1-77e4d1e61ed6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <856c189d-937e-2471-c3c1-77e4d1e61ed6@samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Wed, Jan 16, 2019 at 06:46:39PM +0300, Ilya Maximets wrote:
>=20
>=20
> On 16.01.2019 18:30, Eduardo Habkost wrote:
> > On Wed, Dec 12, 2018 at 07:49:36AM +0100, Gerd Hoffmann wrote:
> >> On Tue, Dec 11, 2018 at 02:09:11PM +0300, Ilya Maximets wrote:
> >>> On 11.12.2018 13:53, Daniel P. Berrang=C3=A9 wrote:
> >>>>>
> >>>>> Let's restrict memfd backend to systems with sealing support.
> >>>>
> >>>> I don't think we need todo that - sealing is optional in the QEMU =
code,
> >>>> we simply have it set to the wrong default when sealing is not ava=
ilable.
> >>>
> >>> That was literally what I've fixed in v1:
> >>>     https://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg054=
83.html
> >>>
> >>> but 2 people suggested me to disable memfd entirely for this case.
> >>> Do you think I need to get patch from v1 back ?
> >>>
> >>> Gerd, Marc-Andr=C3=A9, what do you think?
> >>
> >> I still think it makes sense to require sealing support.  Sealing is
> >> very useful, and there are only a few kernel versions with memfd but
> >> without sealing.  So finding such kernels in the wild will become mo=
re
> >> rare over time.  I wouldn't worry too much about them.
> >=20
> > -object memory-backend-memfd,id=3Dmem,size=3D2M,seal=3Doff still
> > works on those systems, doesn't it?  What's the rationale for
> > breaking a working configuration without following the
> > deprecation policy?
> >=20
>=20
> See the commit message.
> '.seal' property is not registered if sealing is not supported.
> So, there is no way to disable sealing on the system that does not supp=
ort it.

As I pointed out a few lines up, this is simply because QEMU has a bug
setting seal=3Dtrue as the built-in default value even when it isn't
supported.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
