Received: from eggs.gnu.org ([209.51.188.92]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hDQ8a-00067X-Jh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hDQ8Z-0002lq-Hc
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:00:20 -0400
Date: Mon, 8 Apr 2019 10:00:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190408090013.GJ15001@stefanha-x1.localdomain>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
In-Reply-To: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block/io.c: fix for the allocation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 05:24:04PM +0300, Andrey Shinkevich wrote:
> On a file system used by the customer, fallocate() returns an error
> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
> fails. We can handle that case the same way as it is done for the
> unsupported cases, namely, call to bdrv_driver_pwritev() that writes
> zeroes to an image for the unaligned chunk of the block.
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block-next tree for QEMU 4.1:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcqw2dAAoJEJykq7OBq3PIfVQH/RDkGhJfcMi4ewcbpIreJvHg
N7MwBnaAMhGaQfIVmTfxsOAvbfe3X+j/biQDRp38g5E2YV15yKT8T4qgOzVeUemg
bVm6i4pZS+m2z/V53FERIS1FOPYyMMFHQF5ttC8uicKJmpkk4tMhOmZtVj9PyLb/
Q7d9yWXFrXxERmpJ+SY3vuCX5f48Nt48hYqCLIENypFa1jFg24S8z/w8Qq22zFzk
DlafQoTLQENSVoBuLjriLQRWVjmuq+kpVxARGYxf9++iBScG2kET46swNbVIfU8y
aijI1NdxKhBR2f748po7JPiOennTWefHbo010PwdJ7kPbpeBBaqwkDkJ/0H5Euw=
=nhUx
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--
