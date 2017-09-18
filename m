Received: from eggs.gnu.org ([2001:4830:134:3::10]:35154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwUO-00064K-QH
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwUN-00066I-TQ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:53:32 -0400
References: <20170912112855.24269-1-berrange@redhat.com>
	<20170912112855.24269-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7bbed5e-bda8-b96a-d308-54e1047b8768@redhat.com>
Date: Mon, 18 Sep 2017 08:53:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170912112855.24269-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2l6R1E36J9g5oFiKofbgahIorHTwR8Fpl"
Subject: Re: [Qemu-devel] [PATCH v3 2/7] crypto: expose encryption sector
 size in APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2l6R1E36J9g5oFiKofbgahIorHTwR8Fpl
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <d7bbed5e-bda8-b96a-d308-54e1047b8768@redhat.com>
Subject: Re: [PATCH v3 2/7] crypto: expose encryption sector size in APIs
References: <20170912112855.24269-1-berrange@redhat.com>
 <20170912112855.24269-3-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 06:28 AM, Daniel P. Berrange wrote:
> While current encryption schemes all have a fixed sector size of
> 512 bytes, this is not guaranteed to be the case in future. Expose
> the sector size in the APIs so the block layer can remove assumptions
> about fixed 512 byte sectors.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  crypto/block-luks.c    |  6 ++++--
>  crypto/block-qcow.c    |  1 +
>  crypto/block.c         |  6 ++++++
>  crypto/blockpriv.h     |  1 +
>  include/crypto/block.h | 15 +++++++++++++++
>  5 files changed, 27 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2l6R1E36J9g5oFiKofbgahIorHTwR8Fpl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/z9IACgkQp6FrSiUn
Q2qPdwgAnB7EX+LdQgHt0lLbJMaylt+ZzaTzXEqGfOPsXaXlB/xEx3S1O/HKlIxr
cXjlnaPn4awSNxfFwvbv48AD1NMZ+82M53qPfzFeoC+W43VoSVXo7gMKqryc4kWL
DJwuF0yBr54QCT3ogMrSkCe9GsdL706laeiAHrkdMP+y7GppG0IBGEzq43+QXj/1
7Oa6umKIAhNlDVQuNwlTq9U1ahHnfugdcY5kL8+zYBBIjz++Za9uBv+/Jk+w9QaT
jmjb/A6QSe4Fu0sOP7QgbSIsSt68mmmR2zD6xk5JZIVl3RLrDdNq0989bvDHmzYp
CZL14g+m1IzniU+A0oRJCIMj6ETs8w==
=q5Su
-----END PGP SIGNATURE-----

--2l6R1E36J9g5oFiKofbgahIorHTwR8Fpl--
