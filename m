Received: from eggs.gnu.org ([209.51.188.92]:41622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz0TI-0004xU-Q2
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gz0TH-0008LS-U5
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:46:08 -0500
Date: Wed, 27 Feb 2019 14:44:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190227144430.GC22539@stefanha-x1.localdomain>
References: <20190225161831.20103-1-stefanha@redhat.com>
	<20190226084959.GA4598@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline
In-Reply-To: <20190226084959.GA4598@linux.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] iotests: use -M
 accel=qtest in 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 09:49:59AM +0100, Kevin Wolf wrote:
> Am 25.02.2019 um 17:18 hat Stefan Hajnoczi geschrieben:
> > Test 238 does not require the kvm accelerator.  tcg and qtest work too.
> >=20
> > Use qtest since it's always built in while kvm and tcg are not.
> >=20
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/qemu-iotests/238 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
> > index f81ee1112f..c7f8d9422b 100755
> > --- a/tests/qemu-iotests/238
> > +++ b/tests/qemu-iotests/238
> > @@ -33,7 +33,7 @@ else:
> >      virtio_scsi_device =3D 'virtio-scsi-pci'
> > =20
> >  vm =3D QEMUMachine(iotests.qemu_prog)
> > -vm.add_args('-machine', 'accel=3Dkvm')
> > +vm.add_args('-machine', 'accel=3Dqtest')
> >  vm.launch()
>=20
> Why not use iotests.VM? This would be a qtest machine automatically.

Good idea, will fix in v4.

Stefan

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdqJOAAoJEJykq7OBq3PIohYH/1KXn82EiTO1+B3tkbCvcSzj
ArF7WQNoBUOhQeFKLHtIKI0o8OGOCyk8eWFne1g58aBeqfOr1iroBxWT+kyOF+Lj
4vzwiu7c1hS+OzPhkzYwea3ZjWgh5BYxqRCPTZS1OSkNms/1NoVLF7mdnLsW4uZZ
uySntfb1IgkpP1gSEsFw/7/nKM9QM9uIYuxWQbM5ixXH050WWDLUkCcp36uP5BvH
F32U7V1fZiWdWEzvx7q4bx2n6Zp0D+wXhpoHMx9YQocD4++WHf2BlUeqj2V1LA7E
6OUyKfCxxfRPzXOpoopokzCllpk86//FQIvRjMuE13e7DsFcLfBtRFinrMsvET8=
=NTDw
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
