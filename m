Received: from eggs.gnu.org ([209.51.188.92]:47919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghFCA-0005Bt-0F
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghFC9-0000wF-8s
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:51:01 -0500
Date: Wed, 9 Jan 2019 14:50:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190109145056.GA21547@stefanha-x1.localdomain>
References: <20190109142850.27727-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20190109142850.27727-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] block: Acquire the AioContext in
 guess_disk_lchs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 04:28:50PM +0200, Alberto Garcia wrote:
> This fixes the following crash:
>=20
> { "execute": "blockdev-add",
>   "arguments": {"driver": "null-co", "node-name": "hd0"}}
> { "execute": "object-add",
>   "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> { "execute": "x-blockdev-set-iothread",
>   "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
> { "execute": "device_add",
>   "arguments": {"id": "virtio0", "driver": "virtio-blk-pci",
>                 "drive": "hd0"}}
> qemu: qemu_mutex_unlock_impl: Operation not permitted
> Aborted
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  hw/block/hd-geometry.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNgpQAAoJEJykq7OBq3PIZ74H/j9epTseD+Okje6n1EOxt6iu
ygYbSlNtjrbv7SKbCrBsxB+BhtE6V2EHYgQTxhN+OHSWZfj37kv5BrDIiCNHwTV9
UZ0ks0VDD0BJMI/H2r4gdOT/G0RV/NbGZI8YZG6ST7fk/YmmySczpZQxPylpDioL
iCFFvcb7RreNA2T08O3vcE+HMqUZFE4Rp44xFnkxuN7f+idKI3vfFcVmlViDxW+o
vUlXbnY1z73HQjRJrGF1Qaaz+GdUApubviQRGMv5gs/4zn039C7c9PqqW+UI781e
rLfjq+DapmNqmwW/dL0r08XeWKammKFJRplZ985BqLa560q1Rs2cdu/XMTJHRKo=
=j3/R
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
