Received: from eggs.gnu.org ([2001:4830:134:3::10]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egG4H-0005sW-Cd
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egG4G-0001DB-IT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 15:30:17 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-10-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <86bf0a7a-0226-fab2-9fc0-792f167662d8@redhat.com>
Date: Mon, 29 Jan 2018 21:30:05 +0100
MIME-Version: 1.0
In-Reply-To: <1516297747-107232-10-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TvrP1jaMkaJrlISBpsLDkXUiZa0A7vBwL"
Subject: Re: [Qemu-devel] [PATCH v7 9/9] iotest 134: test cluster-misaligned
 encrypted write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TvrP1jaMkaJrlISBpsLDkXUiZa0A7vBwL
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <86bf0a7a-0226-fab2-9fc0-792f167662d8@redhat.com>
Subject: Re: [PATCH v7 9/9] iotest 134: test cluster-misaligned encrypted
 write
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-10-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516297747-107232-10-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-18 18:49, Anton Nefedov wrote:
> COW (even empty/zero) areas require encryption too
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/134     |  9 +++++++++
>  tests/qemu-iotests/134.out | 10 ++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--TvrP1jaMkaJrlISBpsLDkXUiZa0A7vBwL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvhE0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0AoH/1w3Ub+BHmCy90lNWBL1u2xL8Rz1tKsx
uCzmmYPetfmXC9D0kb+6T5V6QnNI2u1LTYRrdjQiZG1YVE9XQsXKcdrZNsg8YjqA
ZcbKEu7MltkLNV1LIDA02iJxY86RBksXqdDAteTC9xLwimkXe7ulD2CRZ5mLJT/O
GkIcize+yAZ12H6cceiI8TaT3BQGeiENGcwjtgfezb8lxXWgTRpUodSYkOUfK7dk
B5SYAjD99PQMQxNueSaQxwiT6dP65XKtHwo5Wy6lLU6OkMmbQ00g5nH94OJOM99f
qv5AzAN0IHPl/1PXxau1zQup7nCFszHEhlaq4fWnoWzyJ25JxWatoF0=
=/0hh
-----END PGP SIGNATURE-----

--TvrP1jaMkaJrlISBpsLDkXUiZa0A7vBwL--
