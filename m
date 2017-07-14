Received: from eggs.gnu.org ([2001:4830:134:3::10]:48270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxrV-0002x1-6D
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxrS-0007RL-0a
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVxrR-0007Qa-Qf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:30:13 -0400
Date: Fri, 14 Jul 2017 11:30:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714103006.GF27446@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-7-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-7-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] virtio-net: use virtqueue_error for
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


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:02:35PM +0200, Ladi Prosek wrote:
> virtqueue_error includes queue index in the error output and is preferred
> for errors that pertain to a virtqueue rather than to the device as a who=
le.
>=20
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/net/virtio-net.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaJ0uAAoJEJykq7OBq3PIHt0H/1gbNtCJhhab8/bqz2G86iDp
LYNgvjPszA1Vld8SftKD3eslOvtdC0L6G+GGXrn8Af2idJqN5ElekrgAcjjQ+Cbn
XFV40GnlgGcWsoCm5r48DMywgsVZ/toEmVi+6bthTwFc6+AmWbybdErdJEFgHQVe
MbwgeKIB8CD+xKGAVxuacgDaAyOzlEtdbiNVv3jYlf1IJff7g7Hz+0psjoydqIzi
3wbpBoJ1gqVZg+llvfO7hTiis2yYM8fHD7ZrWEs600iENV2s31FS3XpVdmin9DVy
0VAC5W8wtjaZ4bMQLYB5AhwrU/p8UKYPyf3Nw7R81YzIhWt54kD23z2+kAR0JKA=
=McNX
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
