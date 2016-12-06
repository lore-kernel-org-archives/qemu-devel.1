Received: from eggs.gnu.org ([2001:4830:134:3::10]:54430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMPA-0005xj-9h
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMP6-0007FY-BD
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:32:00 -0500
Date: Tue, 6 Dec 2016 20:30:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206203052.GG2521@stefanha-x1.localdomain>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206213023-mutt-send-email-mst@kernel.org>
	<20161206193349.GF4027@thinpad.lan.raisama.net>
	<20161206213545-mutt-send-email-mst@kernel.org>
	<20161206194029.GG4027@thinpad.lan.raisama.net>
	<20161206214217-mutt-send-email-mst@kernel.org>
	<20161206194800.GH4027@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20161206194800.GH4027@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 05:48:00PM -0200, Eduardo Habkost wrote:
> On Tue, Dec 06, 2016 at 09:44:11PM +0200, Michael S. Tsirkin wrote:
> > On Tue, Dec 06, 2016 at 05:40:29PM -0200, Eduardo Habkost wrote:
> > > On Tue, Dec 06, 2016 at 09:36:07PM +0200, Michael S. Tsirkin wrote:
> > > > On Tue, Dec 06, 2016 at 05:33:49PM -0200, Eduardo Habkost wrote:
> > > > > On Tue, Dec 06, 2016 at 09:31:43PM +0200, Michael S. Tsirkin wrot=
e:
> > > > > > On Tue, Dec 06, 2016 at 06:50:47PM +0100, Greg Kurz wrote:
> > > > > > > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviou=
r", passing
> > > > > > > -device virtio-blk-pci.disable-modern=3Doff has no effect on =
2.6 machine
> > > > > > > types because the internal virtio-pci.disable-modern=3Don com=
pat property
> > > > > > > always prevail.
> > > > > > >=20
> > > > > > > This should ideally be fixed in the qdev properties core code=
, but it is
> > > > > > > too late in the QEMU 2.8 schedule. So this patch fixes the is=
sue by setting
> > > > > > > the compat properties for every virtio-*-pci subtypes instead=
 of the base
> > > > > > > virtio-pci type.
> > > > > > >=20
> > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > >=20
> > > > > > What's the rush? Either the issue is or isn't 2.8 material. If =
it is,
> > > > > > let's fix it in qdev core now. If it isn't no need for quick fi=
xes,
> > > > > > just wait a bit and merge qdev core fix after 2.8 is out.
> > > > >=20
> > > > > Because it is a regression,
> > > >=20
> > > > Regression in 2.7 though, isn't it?
> > >=20
> > > Yes. Does that mean we don't mind leaving a regression unfixed in
> > > 2.8 because it was introduced in 2.7?
> >=20
> > Not necessarily, it's a judgement call.  But there will always be
> > another release.  I would say don't rush it.
>=20
> My judgement is that it won't hurt to include the HW_COMPAT_* fix
> for virtio-pci (this patch, after including the missing classes I
> pointed out), because it is simple and obvious.
>=20
> But I agree that this means we don't need the more complex hack I
> just sent as RFC.

This has missed QEMU 2.8.0-rc3 (the deadline was 19:00 UTC December
6th).

This doesn't seem like a release blocker anyway since it's not a 2.8
regression, it can be fixed in a -stable release.

Stefan

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRx/8AAoJEJykq7OBq3PIYDsH/2NTt4Adk5QcH/Xgn8V2mf7s
4aV8fXXoaae7i5873lwAJqudSYH9G/WSy6XmI4HuzZEVETJSXuT7H0PjWCR2kvAW
b+k8Vtg97YhB++pH4rB4qriiUGYYNVwbMPPHOXxN+LGgL30a2mmvoM9yJsuNzPeN
faEUqjiSOYZCscbMuab+DdYC3T2/fL83ZnYJC0WsJL46AsDr56CPjWZEopnbRDQE
RKNiHm4q099e3O031ERRPjwjno2+33q074F5A8FSHoud9VBye1BksvaGdZIMF+mw
IkRCs8bjxfjIZBFzEpHBe6MGVUfjRxjWMPbXE5uHLNjuYGZus5MWsEUTaYlfF0w=
=AChA
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
