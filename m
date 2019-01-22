Received: from eggs.gnu.org ([209.51.188.92]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm44C-0006st-G6
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm44B-0002K6-JP
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:58:44 -0500
References: <20190122121926.25554-1-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0fd0b346-2b04-a936-682c-dc9e21d1cb2b@redhat.com>
Date: Tue, 22 Jan 2019 15:58:19 -0600
MIME-Version: 1.0
In-Reply-To: <20190122121926.25554-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TR9Xf4IOPgZi0hMlvCRZWQlKH6OI8bmHk"
Subject: Re: [Qemu-devel] [PATCH] block: Apply auto-read-only for
 ro-whitelist drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TR9Xf4IOPgZi0hMlvCRZWQlKH6OI8bmHk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <0fd0b346-2b04-a936-682c-dc9e21d1cb2b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Apply auto-read-only for ro-whitelist
 drivers
References: <20190122121926.25554-1-kwolf@redhat.com>
In-Reply-To: <20190122121926.25554-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/22/19 6:19 AM, Kevin Wolf wrote:
> If QEMU was configured with a driver in --block-drv-ro-whitelist, tryin=
g
> to use that driver read-write resulted in an error message even if
> auto-read-only=3Don was set.
>=20
> Consider auto-read-only=3Don for the whitelist checking and use it to
> automatically degrade to read-only for block drivers on the read-only
> whitelist.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--TR9Xf4IOPgZi0hMlvCRZWQlKH6OI8bmHk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHkfsACgkQp6FrSiUn
Q2oiJQgAoWC8z+Rlt++b5rXKD/cUBg/Ob90EA1tJCkJkJyjnoHctV0UsBlbIPvUL
BeHvZFcXS12lI3zRVQULJwwYvUMYE3W70MkFtlQG5I3qV67tBcBqr5QqoINayb9G
figtueeA/50euwINwkhf7grc1/vUvcNzcYCLZj416B3crc1cFTnbSnKHlx213FC9
OLFf78Q0vFnv63+/kblzSsYdIqr/P/CwNMkuR6TTpmxUpUpFVn8KSsvmM1/z3GV/
KYyMCQpASGQVJPHBJa8Nw10EzA6QUwLKMqo6jFW4na04ebuaCn74MGXDJpmX9lHL
II64vQBBU04LoO2WQCJue6rj0opxeA==
=zXc6
-----END PGP SIGNATURE-----

--TR9Xf4IOPgZi0hMlvCRZWQlKH6OI8bmHk--
