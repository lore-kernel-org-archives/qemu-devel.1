Received: from eggs.gnu.org ([2001:4830:134:3::10]:40660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMwLp-0001Vk-L3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gMwLk-0008KJ-It
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 09:41:05 -0500
Date: Wed, 14 Nov 2018 14:40:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181114144044.GC3103@stefanha-x1.localdomain>
References: <1541520556-8334-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <1541520556-8334-1-git-send-email-dongli.zhang@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: rename iov to out_iov in
 virtio_blk_handle_request()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com, kwolf@redhat.com, mreitz@redhat.com


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 12:09:16AM +0800, Dongli Zhang wrote:
> In virtio_blk_handle_request(), in_iov is used for input header while iov
> is used for output header. Rename iov to out_iov to pair output header's
> name with in_iov to avoid confusing people when reading source code.
>=20
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/block/virtio-blk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb7DPsAAoJEJykq7OBq3PIn20IAIa5wLeWN8/Yde/d2rqwokae
nzUJ480KrriPMH3MvAkB+3o6E6wUBpt2dL9NldGL/M4sy+X9MLhyftztiJHCM3J/
DDCoRTjqr/Gmrj4WhRViD4RRJXW/mO4zIOO1V0FimtzTEj/RrKQeY1q+NN8yby7v
GEP0aEwB0vjUPzzRYDrrpI8WfKprRbSX5Qs0x75bdeGNmmAONO+ksTc3146NJs+l
oyHY6tZnuo2+tOzsBsdfUpo24bmVVklx26GB7Lc/0vqfqnPWYu1haN/nRGhsNWGI
johuSqyN/HuYd3nM5Vk4UAwQ0Dhqag1T4sebFYH+bOoa3tIIg4dFyWrN6Z3mTDA=
=nAbR
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
