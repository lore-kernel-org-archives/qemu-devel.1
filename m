Received: from eggs.gnu.org ([2001:4830:134:3::10]:48054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxr1-0002Sz-Gf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxqy-0007C4-AW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVxqy-0007Bj-3c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:44 -0400
Date: Fri, 14 Jul 2017 11:29:39 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714102939.GE27446@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-6-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-6-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/8] virtio-blk: use virtqueue_error for
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


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:02:34PM +0200, Ladi Prosek wrote:
> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/block/virtio-blk.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaJ0TAAoJEJykq7OBq3PInR0H/2LgaCq4GRogklTfaDLtY+/f
PGVp1cBQ9FVO4J8m+uBHWxuNInEJXNWOfMg7swem7TDqAOyLcNNU5VYDOtySI1M0
uVP/S6iYWn33nOvH3Ymk7VZCr1Z/u03me6kRV5n/U+ves1iLNASb2d69kGk/hVhw
jUQTwnMu+5lfRzGBJt/Ok3yz5wCifrsUu3rJA/wczcHx8OPgDvgE3YsmRyKDKEAY
H/wnUJf6om4Um58lXqY2EpHf+CkIe4k3njlUUI+Xw3e2DxO7c8429PqVivim5j6K
l1UHqRxITyuB7w31/6y/l9nrEMXx3qvW4fO/85rpNh7vknqG8XHwvUWybeVk9gI=
=u0Cu
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
