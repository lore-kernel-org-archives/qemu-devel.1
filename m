Received: from eggs.gnu.org ([2001:4830:134:3::10]:47944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxqn-0002F5-Aj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxqk-00074a-5i
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVxqj-000743-VK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:30 -0400
Date: Fri, 14 Jul 2017 11:29:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714102924.GD27446@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-5-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-5-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/8] virtio-9p: use virtqueue_error for
 errors with queue context
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


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:02:33PM +0200, Ladi Prosek wrote:
> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/9pfs/virtio-9p-device.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaJ0EAAoJEJykq7OBq3PIc7wH/2jet5dJY8kmxndqUsSXTcep
aU8VTp6ab0Xg3FklOygIV2XnKSpR399KADePhvEN5MM5+yJPAY/HM72x2sme7KJv
nXAXmm6aolfoiGzakKUo0R+vsID0VpK+QEvssLoIPdWf3MiJl8LkWJGmvTxBSznz
YRfE3om7kSDCpdTX4qdeh4Bw2XqNwg2a1i1YRYM1fgt+bs4MkvZE85v0Zc+Pne6R
my4fT8556/r2nX0grgHcdmFKZDuqNuuhMjRPNcftpUeC/YctCU7q5fuReSKmdJrp
QV76oZ1R7AzooMePLlP5DHnPuy2p+Fqz04nTQzxnEgtsCUTNog3Ada/Y7UU0+6Q=
=QoKV
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
