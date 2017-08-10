Received: from eggs.gnu.org ([2001:4830:134:3::10]:49259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfnfD-0001mX-2B
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dfnfB-0006eT-RQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 09:38:15 -0400
Date: Thu, 10 Aug 2017 14:38:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170810133803.GB23806@stefanha-x1.localdomain>
References: <20170808122251.29815-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <20170808122251.29815-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-blk: handle blk_getlength() errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 01:22:51PM +0100, Stefan Hajnoczi wrote:
> If blk_getlength() fails in virtio_blk_update_config() consider the disk
> image length to be 0 bytes.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/virtio-blk.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZjGG7AAoJEJykq7OBq3PIgZQIAKv1PWePyuMFCurOSwJO59wf
FDCRrso33pxwlYvCuP3+lNI90+6lSVz0GpvLpH2dkdwSUfIyHnVpKzmJuRpcyzaR
LDiTJrc1fRofDE8NrYHWbf8dzTRwcY8qZ5k0zwJg/huJuVO9xdUgw8jsm6iNsMpO
6F5kPMaYe9lKyU9q9VMOYS1rDG8uIKSA+zCbvV5AP9hP5UJ23davNGbb6QI8VlkI
B+/mEkAkzhB+TPCfyAVw//X5ooYzkRrpf6TnCza3WnTRsDy2LBDCkKMa4i8o4VO5
Hh5VQmnYdxIUM4B5MI/221lbUyyJFqiCBqrTVaAuuCnoZW6Vi5+T1B2biNcdQ9Y=
=Q1GL
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
