Received: from eggs.gnu.org ([2001:4830:134:3::10]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNYG-0007D5-Qf
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cZNYD-0007YX-Mz
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:00:16 -0500
References: <20170202195601.11286-1-sw@weilnetz.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bdfbc0e6-e630-a1ac-5132-24b6a2dd6122@redhat.com>
Date: Thu, 2 Feb 2017 14:00:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170202195601.11286-1-sw@weilnetz.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ir4hejV0fCl6x3XU3XhwhB8W55HPtKpEs"
Subject: Re: [Qemu-devel] [PATCH] tci: Remove invalid assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ir4hejV0fCl6x3XU3XhwhB8W55HPtKpEs
From: Eric Blake <eblake@redhat.com>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Message-ID: <bdfbc0e6-e630-a1ac-5132-24b6a2dd6122@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tci: Remove invalid assertions
References: <20170202195601.11286-1-sw@weilnetz.de>
In-Reply-To: <20170202195601.11286-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2017 01:56 PM, Stefan Weil wrote:
> tb_jmp_insn_offset and tb_jmp_reset_offset are pointers
> and cannot be used with ARRAY_SIZE.
>=20
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  tcg/tci/tcg-target.inc.c | 2 --
>  1 file changed, 2 deletions(-)

mst posted an alternative patch:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00551.html

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ir4hejV0fCl6x3XU3XhwhB8W55HPtKpEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYk4/HAAoJEKeha0olJ0Nq0joIAIn6iU8NQPMA8ZKwQAz+BrO4
TGfS61oRHA5fiDeh9un0HH8NtSXDCug2AX7tLprvoam5QaFhtJTP2j02yg7R0/r/
Wtf2tlw5ejX/z/Wa5TSe0m3uxeJ5Q3/gAbwzaqTf0vDNlrw5RfoZp6MEjN+XqHj2
EKUpi+yoi4qafhW0ExZDW31kkUcetvXYCm9jkAxNX2FbqoAuewjrNN3doK0ay96c
p3HF0fdhSKvRZFGtn/UpftvameZce+Ofaeo1FcU2Q3USa5RmbnVxfBqCibJ+76S3
9UH+LT2t8bTxs8nLTFl8LUxns7nToyz7gyuTMOxNtggNf/mwVbAg1OV42QzkraU=
=JT3f
-----END PGP SIGNATURE-----

--ir4hejV0fCl6x3XU3XhwhB8W55HPtKpEs--
