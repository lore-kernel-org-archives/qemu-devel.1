Received: from eggs.gnu.org ([2001:4830:134:3::10]:48199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJMB-0000ZS-Ef
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEJMA-0001vx-Eh
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:21:15 -0500
References: <20171113152424.25381-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a66cb82-1441-d594-17cf-424e8f5fb6c1@redhat.com>
Date: Mon, 13 Nov 2017 12:21:04 -0600
MIME-Version: 1.0
In-Reply-To: <20171113152424.25381-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XoPsTJo3Lmf8iUee5VpBScPdAE6xi2fUV"
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, qemu-stable@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XoPsTJo3Lmf8iUee5VpBScPdAE6xi2fUV
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com,
 qemu-stable@nongnu.org, qemu-block@nongnu.org
Message-ID: <9a66cb82-1441-d594-17cf-424e8f5fb6c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] nbd/client: Use error_prepend()
 correctly
References: <20171113152424.25381-1-eblake@redhat.com>
In-Reply-To: <20171113152424.25381-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/13/2017 09:24 AM, Eric Blake wrote:
> When using error prepend(), it is necessary to end with a space
> in the format string; otherwise, messages come out incorrectly,
> such as when connecting to a socket that hangs up immediately:
>=20
> can't open device nbd://localhost:10809/: Failed to read dataUnexpected=
 end-of-file before all bytes were read
>=20
> Originally botched in commit e44ed99d, then several more instances
> added in the meantime.
>=20
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  nbd/client.c | 50 ++++++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)

Queued on my NBD tree; will be in 2.11 (I may do another pull request
prior to -rc1, otherwise it will be -rc2).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XoPsTJo3Lmf8iUee5VpBScPdAE6xi2fUV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloJ4pAACgkQp6FrSiUn
Q2pODwf/TKBh0em/BWhbST3h3Te4eVQPpw3/FFB8HvPrxZM6rI4AlnUmuRpflYEA
qAcUnzHli2lR0ChmO4DVoHWXkBvsakrZlV8pGwhCVIXBZJPNGAYxZLBTKGZjqLCx
rR/ETy1rL1vgxGj+UBBb7dF/N1gOYf/cc1G/7ilc05z8GxPoGobXeN4ndPCH+Q2d
CQxgI25CIIp5XamNN3YBD8cYLyYDNMySc2bDdilAWiuCZbcW5wooh2Dqx+qNKq/z
x6jaP1jfgQEGZjYeQHoLKn+BjPvehW6fk8dzuBRF+ODXBO0ZESs4QwsIaFfJ8Gmn
34rcAaZrKJ3aBcAdfJ/GBgRs0vOYSg==
=3yp7
-----END PGP SIGNATURE-----

--XoPsTJo3Lmf8iUee5VpBScPdAE6xi2fUV--
