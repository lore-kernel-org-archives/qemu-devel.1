Received: from eggs.gnu.org ([2001:4830:134:3::10]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxsk-0003xj-Ob
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxsh-0007om-KN
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVxsh-0007oS-De
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:31:31 -0400
Date: Fri, 14 Jul 2017 11:31:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714103126.GH27446@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-9-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-9-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] virtio-crypto: use virtqueue_error
 for errors with queue context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:02:37PM +0200, Ladi Prosek wrote:
> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio-crypto.c | 56 ++++++++++++++++++++++++-----------------=
------
>  1 file changed, 29 insertions(+), 27 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaJ1+AAoJEJykq7OBq3PITtcIAJ2C5ZNYO+RJjV1KtwMQ5B97
1DvWldk4H7yX//BYY9gkFp3C5pTNRYkNcOFTeocbR8/Ko9vDZQg9cWLnh4thD+pA
P0+K/mdtL+Ps1QhOgNXad/lGXq9J6b/GwvVmvWleGD8elAzKBr02L2hwlIACfjt+
KGkTK7PGeBMxd0x69rhLCdtUx7XEgtLKvsSktfwcygVI+UybD7LvmycbKGKPgg59
SUE75tAJ9J72xe08lYqdhJXogqdB1AzpB1vJM9rKkmpQcg80t0Lv2qSQo3/zyoTQ
0PYrEmDHBRpq0mYZ+VFPwMaaDO+YQtV3dHXEbP8bbei6khxYN5CnUa9KXBkrlls=
=8LGi
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
