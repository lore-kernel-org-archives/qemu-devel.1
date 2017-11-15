Received: from eggs.gnu.org ([2001:4830:134:3::10]:49410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEzVJ-0000lz-6A
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEzVF-0007vZ-08
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:21:29 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a58bf1a3-d1e1-0c36-85f2-32c89ecc0d12@redhat.com>
Date: Wed, 15 Nov 2017 16:21:11 +0100
MIME-Version: 1.0
In-Reply-To: <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qRQKEoOK5W2043pMaWRMXXa1i0PaqCKxE"
Subject: Re: [Qemu-devel] [PATCH 1/5] qcow2: reject unaligned offsets in
 write compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qRQKEoOK5W2043pMaWRMXXa1i0PaqCKxE
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com
Message-ID: <a58bf1a3-d1e1-0c36-85f2-32c89ecc0d12@redhat.com>
Subject: Re: [PATCH 1/5] qcow2: reject unaligned offsets in write compressed
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1510654613-47868-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 11:16, Anton Nefedov wrote:
> Misaligned compressed write is not supported.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied to my block branch for 2.11:

https://github.com/XanClic/qemu/commits/block

Max


--qRQKEoOK5W2043pMaWRMXXa1i0PaqCKxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMW2cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACgUIAJIoH8CqG0zoojyxFrNXxw61T0qZeq+P
pJMW63FjruYVE85eIyVjCskw4TkkbaozJe/FAVA76DneOPqqhTujIw19/vg0miH/
ryVLzyA5/3BoXy8FYYBbHvRjFo7Ie78tdaMc8cW2nqdL70qsliIj/3ehWWeML6Ls
Lpyc5II9ZzDTQaGZ/i1w/P1j5usjUekErkJhvl1yucEuwwaQxPQ36wXdLjwEPuPf
6LceNfSDBxEgq4IbgAgdH53f97HBC24IZEoqelTXgSU/67136UZWxTNqMSWVGqcj
E54tGX4oc7aqk6lukhZR16fKzkZ3G5+gndEnOvuxvDa7Rp4UrhqvETw=
=m8nH
-----END PGP SIGNATURE-----

--qRQKEoOK5W2043pMaWRMXXa1i0PaqCKxE--
