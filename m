Received: from eggs.gnu.org ([2001:4830:134:3::10]:52804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiIN-0002ir-27
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiIM-0003yH-3x
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:41:31 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-6-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31d7d85c-6410-c5ef-634d-c43523ad68cd@redhat.com>
Date: Mon, 24 Jul 2017 13:41:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-6-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LjHdJXaFmTWkqanbhDGVk1XiK8lBxMs7s"
Subject: Re: [Qemu-devel] [PATCH for 2.10 05/35] nbd: fix memory leak in
 nbd_opt_go()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LjHdJXaFmTWkqanbhDGVk1XiK8lBxMs7s
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org
Message-ID: <31d7d85c-6410-c5ef-634d-c43523ad68cd@redhat.com>
Subject: Re: [PATCH for 2.10 05/35] nbd: fix memory leak in nbd_opt_go()
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-6-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> nbd/client.c:385:12: warning: Potential leak of memory pointed to by 'b=
uf'
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  nbd/client.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I plan to take this through the NBD tree for 2.10, if no one else picks
up the entire series first.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LjHdJXaFmTWkqanbhDGVk1XiK8lBxMs7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2P00ACgkQp6FrSiUn
Q2pkWgf/aUDuTsUJH2iEl9EsTrNoo1CCxF/WEtB66UxEBZOO1eIxLGnh0YV4OidP
y6teejM9FcIwTapI5KSmXTiApHwR8Sz7kHdSfBsR90K2h3olQnO0cUSkN0jfYp5h
ugmV3VSTJCRldH6mLDO0hv7N6z0ixDb7eadXPao1kH/ol5PnazrsCIcjfhKD5khJ
8cjLvK6iiljdsLd4ivyuGgt7AIYM8Ha/dzrElRiaZkUP5UyaIgSec/HlEQN7DN1M
wmG5+BgL3++eJcHT9bqDweNEUQThteV/iI5zsJiTFFZr8eMKTlDGZp97cms6BU1t
bvM14Oyt81TlnrehAtxVs3c+O68ClA==
=TN43
-----END PGP SIGNATURE-----

--LjHdJXaFmTWkqanbhDGVk1XiK8lBxMs7s--
