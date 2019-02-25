Received: from eggs.gnu.org ([209.51.188.92]:57835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyJ7t-0006AN-GO
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyJ7s-0006TY-OM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:29:09 -0500
Date: Mon, 25 Feb 2019 16:19:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190225161908.GC379@stefanha-x1.localdomain>
References: <20190221101139.2224-1-stefanha@redhat.com>
	<c620cfea-6f3c-f9b6-1dce-52eae2d905d7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <c620cfea-6f3c-f9b6-1dce-52eae2d905d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: drop unnecessary accel=kvm in
 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 11:24:12AM +0100, Thomas Huth wrote:
> On 21/02/2019 11.11, Stefan Hajnoczi wrote:
> > Test 238 does not require the kvm accelerator.  TCG works fine.
> >=20
> > Use the default accelerator instead of requiring kvm.
> >=20
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Vladimir, I have dropped the 235 change because I don't have time to
> > figure out the kvm/tcg vs qtest differences or add a skip function.
> > Sorry!
> >=20
> >  tests/qemu-iotests/238 | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
> > index f81ee1112f..e490bb4298 100755
> > --- a/tests/qemu-iotests/238
> > +++ b/tests/qemu-iotests/238
> > @@ -33,7 +33,6 @@ else:
> >      virtio_scsi_device =3D 'virtio-scsi-pci'
> > =20
> >  vm =3D QEMUMachine(iotests.qemu_prog)
> > -vm.add_args('-machine', 'accel=3Dkvm')
>=20
> Would it be feasible to change it into "accel=3Dqtest" instead? ... then
> this test would also work when QEMU has been compiled with --disable-tcg
> and when KVM is not available...

Sure.  I have tested that qtest still triggered the bug when the fix was
merged.

Will fix in v3.

Stefan

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdBV8AAoJEJykq7OBq3PIcooIAKgZrMlJPVkeRWV1GWYCcTzp
/CupLU+7lMPKP4E7V3UIEBLcD7TxRqXvkFyY2rPWzUMBqUAwL9iFff2jIlE5hshN
x4HEuufGc9ReJRaK1qdKzwTJjSFSyq8QY5ZyIFK0NhvdkuPOEKm1/P5KOm9w3+Mb
WGxRIFK5VydDNWvqu1McOqD/osoHWpEnHjidGTQw97PNpR+/FJxDeJUt0CC8xVuA
PE8GLMCuH1MhGxSRWyTkKG3zQrG3T8oc8LZUToUElJvfUSv/KGi+h4SEoZgCTiTa
1wM1SZA47lscl02islT5LVaw+0rLeo4r97D/dZk7/TJR6hUwItgmyPLvWNvxHIE=
=lN4z
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
