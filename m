Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cHTKK-0003Q6-Vg
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cHTKH-0008PY-S6
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:31:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cHTKH-0008Om-KA
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 05:31:49 -0500
Date: Thu, 15 Dec 2016 10:31:45 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161215103145.GG2762@stefanha-x1.localdomain>
References: <20161214163035.3297-1-maxime.coquelin@redhat.com>
	<20161215073808.GB26169@stefanha-x1.localdomain>
	<20161215092656.2e1244c0.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <20161215092656.2e1244c0.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 15, 2016 at 09:26:56AM +0100, Cornelia Huck wrote:
> On Thu, 15 Dec 2016 07:38:09 +0000
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> > On Wed, Dec 14, 2016 at 05:30:35PM +0100, Maxime Coquelin wrote:
> > > This patch fixes a cross-version migration regression introduced
> > > by commit d1b4259f ("virtio-bus: Plug devices after features are
> > > negotiated").
> > >=20
> > > The problem is encountered when host's vhost backend does not support
> > > VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
> > > machine with virtio-pci modern capabilities enabled to a v2.8 machine.
> > >=20
> > > In this case, modern capabilities get exposed to the guest by the sou=
rce,
> > > whereas the target will detect version 1 is not supported so will only
> > > expose legacy capabilities.
> > >=20
> > > The problem is fixed by introducing a new "x-ignore-backend-features"
> > > property, which is set in v2.7 and prior compatibility modes. Doing t=
his,
> > > v2.7 machine keeps its broken behaviour (enabling modern while version
> > > is not supported), and newer machines will behave correctly.
> > >=20
> > > Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > ---
> > >=20
> > > V3 fixes commit message with the new property name.
> > > V2 changes the naming as proposed by Michael T.and Cornelia, and
> > > fixes commit message.
> > >=20
> > >  hw/virtio/virtio-pci.c | 5 ++++-
> > >  hw/virtio/virtio-pci.h | 1 +
> > >  include/hw/compat.h    | 4 ++++
> > >  3 files changed, 9 insertions(+), 1 deletion(-)
> >=20
> > Thanks, applied to my staging tree:
> > https://github.com/stefanha/qemu/commits/staging
> >=20
> > Stefan
>=20
> Hm, missing my R-b I gave for v2... feel free to add
>=20
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>=20
> if you still want to change it.

Sorry, the R-b didn't make it into v2.8.0-rc4.

The patch management scripts I use apply all R-b for a single email
thread.  They do not look at previous revisions (it would be hard to
tell which R-b still stand and which do not).  The usual solution is for
the patch author to include previous R-b in new revisions as long as
code changes aren't substantial.

Stefan

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUnERAAoJEJykq7OBq3PICwkH/0dJRD7cqolZvcmE/Xfm7W0V
LnIvV185bRKrYPqLzqUP6szgQTtopKo48b5WQfDtI4F8FpLpBwoFEwaX2He4vbCR
p/oG3oHgb+E8v5qiHdwI5suXKgDx1BtXfbuXsZtecnnVsi5hAPS3QcxfswTnGy0C
z9qy3IEBAsFTJwQ4mK6M/UJNAfJEOf0pbsHBGqvQEJAm0CS/JN/XmSe4w82IOPcN
O4Ok3LZTi/ZAPMN0DZnk0pNTQqTMUXUTylbUP5cNIRNymNrQxycWo5M4GvyKsReo
2RHUbeDCRkURI+WRNxUbTAdQ0O1HeSGPwjM7564Th27bzoWy60EfAYLWy6MASv4=
=06yy
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
