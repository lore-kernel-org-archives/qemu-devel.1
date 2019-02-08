Received: from eggs.gnu.org ([209.51.188.92]:56425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs8Pv-0007Fb-8x
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gs8Pu-0004I5-HX
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:50:15 -0500
References: <20190208154453.25602-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02a830c6-ab3a-2d74-6165-1362d58ad6ac@redhat.com>
Date: Fri, 8 Feb 2019 09:50:05 -0600
MIME-Version: 1.0
In-Reply-To: <20190208154453.25602-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KbTdSADYEsXLhoG0yeMLTmI0jsPRAzeBM"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Assert that L2 table offsets fit in
 the L1 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KbTdSADYEsXLhoG0yeMLTmI0jsPRAzeBM
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <02a830c6-ab3a-2d74-6165-1362d58ad6ac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Assert that L2 table offsets fit in
 the L1 table
References: <20190208154453.25602-1-berto@igalia.com>
In-Reply-To: <20190208154453.25602-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/8/19 9:44 AM, Alberto Garcia wrote:
> L1 table entries have a field to store the offset of an L2 table.
> The rest of the bits of the entry are currently reserved except from
> bit 63, which stores the COPIED flag.
>=20
> The offset is always taken from the entry using L1E_OFFSET_MASK to
> ensure that we only use the bits that belong to that field.
>=20
> While that mask is used every time we read from the L1 table, it is
> never used when we write to it. Due to the limits set elsewhere in the
> code QEMU can never produce L2 table offsets that don't fit in that
> field so any such offset when allocating an L2 table would indicate a
> bug in QEMU.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KbTdSADYEsXLhoG0yeMLTmI0jsPRAzeBM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxdpS0ACgkQp6FrSiUn
Q2oUewf/UH4Olq7xmTa+U93pRI14rT+Nk+giDF4LM3xI9bZ+lOjPFk+yM1NhfXl1
NoIz07WX5fHe5OmVZ4MA59gGCd2Oq5t/1OYmTwf5eyxVadE9cJ/wSsvwI/ocRuv2
BWmOUmv/LmogCwqf9gM8jhdsbRcbrSpgtlrKDx9Sg5xO124ezw5LULr9bm/LhLJH
OLYWUnHa6cbIsSckAWBPHnzuUz0napYl1sgoCmVeIGsX8Dsp7kAEm/07UHBJoupe
JrEASauTnpHCpvoSEgy+UR+4aEgKR7vydGYo4aZkkkcJGYUJC9QNJ+HKMorh4KN1
iYEgAzuozp35KAQCrXCzVnDFq3ZiMg==
=0bFk
-----END PGP SIGNATURE-----

--KbTdSADYEsXLhoG0yeMLTmI0jsPRAzeBM--
