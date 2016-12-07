Received: from eggs.gnu.org ([2001:4830:134:3::10]:41241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEXih-0006rt-LT
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEXie-0002At-Ey
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:36:55 -0500
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:57711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cEXie-0002AS-8j
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:36:52 -0500
Received: from player690.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id DEEC0672D7
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 09:36:49 +0100 (CET)
Date: Wed, 7 Dec 2016 09:36:37 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161207093637.5b2e3d34@bahia>
In-Reply-To: <20161206203052.GG2521@stefanha-x1.localdomain>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206213023-mutt-send-email-mst@kernel.org>
	<20161206193349.GF4027@thinpad.lan.raisama.net>
	<20161206213545-mutt-send-email-mst@kernel.org>
	<20161206194029.GG4027@thinpad.lan.raisama.net>
	<20161206214217-mutt-send-email-mst@kernel.org>
	<20161206194800.GH4027@thinpad.lan.raisama.net>
	<20161206203052.GG2521@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qUGN2LWkRb_BHYXP+UxGjdQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] virtio: fix HW_COMPAT_2_6 macro for
 virtio-*-pci drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/qUGN2LWkRb_BHYXP+UxGjdQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Dec 2016 20:30:52 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Dec 06, 2016 at 05:48:00PM -0200, Eduardo Habkost wrote:
> > On Tue, Dec 06, 2016 at 09:44:11PM +0200, Michael S. Tsirkin wrote: =20
> > > On Tue, Dec 06, 2016 at 05:40:29PM -0200, Eduardo Habkost wrote: =20
> > > > On Tue, Dec 06, 2016 at 09:36:07PM +0200, Michael S. Tsirkin wrote:=
 =20
> > > > > On Tue, Dec 06, 2016 at 05:33:49PM -0200, Eduardo Habkost wrote: =
=20
> > > > > > On Tue, Dec 06, 2016 at 09:31:43PM +0200, Michael S. Tsirkin wr=
ote: =20
> > > > > > > On Tue, Dec 06, 2016 at 06:50:47PM +0100, Greg Kurz wrote: =20
> > > > > > > > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behavi=
our", passing
> > > > > > > > -device virtio-blk-pci.disable-modern=3Doff has no effect o=
n 2.6 machine
> > > > > > > > types because the internal virtio-pci.disable-modern=3Don c=
ompat property
> > > > > > > > always prevail.
> > > > > > > >=20
> > > > > > > > This should ideally be fixed in the qdev properties core co=
de, but it is
> > > > > > > > too late in the QEMU 2.8 schedule. So this patch fixes the =
issue by setting
> > > > > > > > the compat properties for every virtio-*-pci subtypes inste=
ad of the base
> > > > > > > > virtio-pci type.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> > > > > > >=20
> > > > > > > What's the rush? Either the issue is or isn't 2.8 material. I=
f it is,
> > > > > > > let's fix it in qdev core now. If it isn't no need for quick =
fixes,
> > > > > > > just wait a bit and merge qdev core fix after 2.8 is out. =20
> > > > > >=20
> > > > > > Because it is a regression, =20
> > > > >=20
> > > > > Regression in 2.7 though, isn't it? =20
> > > >=20
> > > > Yes. Does that mean we don't mind leaving a regression unfixed in
> > > > 2.8 because it was introduced in 2.7? =20
> > >=20
> > > Not necessarily, it's a judgement call.  But there will always be
> > > another release.  I would say don't rush it. =20
> >=20
> > My judgement is that it won't hurt to include the HW_COMPAT_* fix
> > for virtio-pci (this patch, after including the missing classes I
> > pointed out), because it is simple and obvious.
> >=20
> > But I agree that this means we don't need the more complex hack I
> > just sent as RFC. =20
>=20
> This has missed QEMU 2.8.0-rc3 (the deadline was 19:00 UTC December
> 6th).
>=20
> This doesn't seem like a release blocker anyway since it's not a 2.8
> regression, it can be fixed in a -stable release.
>=20
> Stefan

Sure. There were suggestions to handle the issue in an appropriate
manner. Fixes can be applied downstream if needed.

Thanks everyone!

--
Greg

--Sig_/qUGN2LWkRb_BHYXP+UxGjdQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhHyhUACgkQAvw66wEB28KVaQCdH9JctB8YQpS++bKBpPymjA1C
GcoAn35wElkarQ4fYCrijlzz/H7sHEgh
=ZB9y
-----END PGP SIGNATURE-----

--Sig_/qUGN2LWkRb_BHYXP+UxGjdQ--
