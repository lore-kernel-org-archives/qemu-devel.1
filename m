Received: from eggs.gnu.org ([2001:4830:134:3::10]:53785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNKFb-0004kZ-7o
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNKFa-00031g-9C
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:07:43 -0500
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
	<1512733868-9009-2-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08c489fc-84fa-93c6-022d-3e4d61b82ef2@redhat.com>
Date: Fri, 8 Dec 2017 09:07:31 -0600
MIME-Version: 1.0
In-Reply-To: <1512733868-9009-2-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pe3MHEONSkEtrcsGtbB6l2cdpOWCN9fWr"
Subject: Re: [Qemu-devel] [PATCH 1/2] block/iscsi: dont leave allocmap in an
 invalid state on UNMAP failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pe3MHEONSkEtrcsGtbB6l2cdpOWCN9fWr
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, mreitz@redhat.com,
 ronniesahlberg@gmail.com, pbonzini@redhat.com
Message-ID: <08c489fc-84fa-93c6-022d-3e4d61b82ef2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/iscsi: dont leave allocmap in an
 invalid state on UNMAP failure
References: <1512733868-9009-1-git-send-email-pl@kamp.de>
 <1512733868-9009-2-git-send-email-pl@kamp.de>
In-Reply-To: <1512733868-9009-2-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 05:51 AM, Peter Lieven wrote:
> we forgot to set the allocmap to invalid if an UNMAP call fails.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  block/iscsi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20

> @@ -1128,6 +1128,9 @@ retry:
>          goto retry;
>      }
> =20
> +    iscsi_allocmap_set_invalid(iscsilun, offset >> BDRV_SECTOR_BITS,
> +                               bytes >> BDRV_SECTOR_BITS);
> +

Semantic conflict with my pending patches to convert the allocmap to
byte-based:

https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg01253.html

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Pe3MHEONSkEtrcsGtbB6l2cdpOWCN9fWr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloqqrMACgkQp6FrSiUn
Q2qW8Qf+N90onrdGzZBCmoD2oGt06TEFgMHVocUF0DXGBnTKd8MlAsGl0j4D3NC7
fwGr5ydwO8xRQdU3hO3TNJFPy0pFeftJ5vMXLFiigPtc+WJYwYI2XECAz6uZ6YtA
HYiMoi2uGUNsOdhLvNfetV3H3NIBoIfKezrKEeb3bofyhQX78oIrxICwMVoZcFWu
FEAvxxzur7IJuO/cI3C0NS1BJXQ7zDOzda8KNLcMQg83TGjmK9PioKpreKzU79kO
eyzwydWFpvuFv00NiD41VA5f8x+m8nK1eZ1g2DSa0aOhQeO42czVsM3ikByuXwzr
oCAcCIXFULYz1FpptsuDmhlifDjC7g==
=t9iK
-----END PGP SIGNATURE-----

--Pe3MHEONSkEtrcsGtbB6l2cdpOWCN9fWr--
