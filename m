Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECMB-0001nU-2c
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECM7-0006O8-Tc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:48:15 -0500
Date: Tue, 6 Dec 2016 09:47:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206094708.GE12630@stefanha-x1.localdomain>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
In-Reply-To: <148095126363.31351.4484514300033863622.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 04:21:22PM +0100, Greg Kurz wrote:
> The current code recursively applies global properties from child up to
> parent. So, if you have:
>=20
> -global virtio-pci.disable-modern=3Don
> -global virtio-blk-pci.disable-modern=3Doff
>=20
> Then the default value of disable-modern for a virtio-blk-pci device is o=
n,
> which looks wrong from an OOP perspective.
>=20
> This patch reverses the logic, so that a child property always prevail.
>=20
> This fixes a subtle bug that got introduced in 2.7 with commit "9a4c0e220=
d8a
> hw/virtio-pci: fix virtio behaviour" for older (< 2.7) machine types: the
> HW_COMPAT_2_6 macro contains global virtio-pci.disable-* properties which
> would silently override global properties passed on the command line for
> virtio subtypes.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandlin=
e>
> tag to pass global properties to QEMU. This patch ensures that XML files
> used with older machine types remain valid with newer versions of QEMU.
>=20
> FWIW I guess it could help to have this fix in 2.8, and also probably in
> 2.7.1.

Hi Greg,
I won't merge this for QEMU 2.8 because this 2.7 issue is not a 2.8
release blocker and it's too risky (good points have been raised in this
thread).

Please target -stable when consensus has been reached.

Thanks,
Stefan

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRokcAAoJEJykq7OBq3PINrkIAJpuhul03M8N3kV/4JcXZNyG
vHDJ44E83u8yRNr2U2BbfvGrZ5wXAgJ3uDJ67DmcCNwmbA+jnKzV9d9gjKlR1LQY
RPQykTADuVEXoG4pKnksF4EvTppj7Jrf7IPt88CMvjOOd2uS/z8iAZMj/QW0OCso
TyI799Wl7T5fZYEDe0jnsY0s1sQ7tdtCdoHj0fZdEraJxt3pkbxRKZfBRqmvzxpb
ZZ25eVEwYgUHiUQ67qj63fkQFuU/opsL0j7cbcdVBhmLg+yWhW7VYaXOuKNbG2OB
s2t2UOyWQFgSrqXadpZrxJtOU5anNz+4hypGy/oiXVGBtaiVfd7XQUPnVaf7DbQ=
=NcCl
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
