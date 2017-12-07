Received: from eggs.gnu.org ([2001:4830:134:3::10]:37901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4kk-0000EL-0e
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:34:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eN4kj-00011S-7x
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 17:34:50 -0500
References: <20171207201320.19284-1-stefanha@redhat.com>
	<20171207201320.19284-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9439826a-348c-bd6d-dfe9-cfbdb786c098@redhat.com>
Date: Thu, 7 Dec 2017 16:34:38 -0600
MIME-Version: 1.0
In-Reply-To: <20171207201320.19284-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wNMjvm1Oq30hoWK1oQtpK1uSXohGlU5XQ"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] docs: mark nested AioContext
 locking as a legacy API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wNMjvm1Oq30hoWK1oQtpK1uSXohGlU5XQ
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9439826a-348c-bd6d-dfe9-cfbdb786c098@redhat.com>
Subject: Re: [PATCH v2 2/6] docs: mark nested AioContext locking as a legacy
 API
References: <20171207201320.19284-1-stefanha@redhat.com>
 <20171207201320.19284-3-stefanha@redhat.com>
In-Reply-To: <20171207201320.19284-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 02:13 PM, Stefan Hajnoczi wrote:
> See the patch for why nested AioContext locking is no longer allowed.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/multiple-iothreads.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wNMjvm1Oq30hoWK1oQtpK1uSXohGlU5XQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopwf4ACgkQp6FrSiUn
Q2pvPgf+LsTIwQuBVfOvA1JPpmvEbf1wn8ryrhe1Brj1Jlezr3zBboGM9xkON0uD
8TUlT9L5dp/ui7PyqGwRbkQNc8zi6FZuqDCW1VjpkjDm03V7bULWDi91DKxtxTxr
NbV1ioIl6ZKndxRldMAWlSljoJgxQNasPzOVmnMhhwMz7pNXNPuxnZgb2qETooqn
vEKxn/XMrJaaP4ciP8gtM5O1H5vTyCqyLFszIm24f23NeHxNuger1ffQvL4D+Z2j
M4Z59AQdHLvcwEioQyP4tksoyyplhxTKOg2LmBmbkz0fseN+LoNfoZEXbS69VK4K
dgypHZ/j4Dw7fc+XxYf8D2VR3wpXYQ==
=QCss
-----END PGP SIGNATURE-----

--wNMjvm1Oq30hoWK1oQtpK1uSXohGlU5XQ--
