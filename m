Received: from eggs.gnu.org ([2001:4830:134:3::10]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cb7Si-0007Zk-VS
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cb7Sf-0005Tw-SO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:13:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cb7Sf-0005Si-Mj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:13:41 -0500
Date: Tue, 7 Feb 2017 15:13:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170207151338.GG8583@stefanha-x1.localdomain>
References: <20170206112953.16993-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <20170206112953.16993-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] rules: don't try to create missing include
 dirs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 11:29:53AM +0000, Daniel P. Berrange wrote:
> In
>=20
>   commit ba78db44f6532d66a1e704bd44613e841baa2fc5
>   Author: Daniel P. Berrange <berrange@redhat.com>
>   Date:   Wed Jan 25 16:14:10 2017 +0000
>=20
>   make: move top level dir to end of include search path
>=20
> The dir $(BUILD_DIR)/$(@D) was added to the include
> path. This would sometimes point to a non-existant
> directory, if the sub-dir in question did not contain
> any target-independant files (eg tcg/). To deal with
> this the rules.mak attempted to create the directory.
>=20
> While this was succesful, it also caused accidental
> creation of files in the parent of the build dir.
> e.g. when building common source files into target
> specific output files.
>=20
> Rather than trying to workaround this, just revert
> the code that attempted to mkdir the missing include
> directories. Instead just turn off the compiler warning
> in question as the missing dir is expected & harmless
> in general.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  configure | 2 +-
>  rules.mak | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYmeQiAAoJEJykq7OBq3PIm/AH/jNQczcJ3aNAvW/mGoZDSqWb
l0Hlr3JJQCAPHX8oh+IfV7p+uhVUWDHHquxFb2CztIlDKjc2PrZM53Q6S20TJnuT
mQzFm/oOvaGnN1WIPNP6p0xVCM2+FOH8vXX/JYQP+hj56gsnGnkU4XQmmDkQ02Q+
M09NrzCI/D1CWoe80kPBiHWRYJTvIvf1YsNeLyEFuJb3TV3PanmDkjqKZZ6qNwCd
VxN8ESGsReZuTk7DzoIY9l5kXkvTcJoQtRUhPlKy/mvVZNkXumlyKzjkcZxCSuTk
QgVQJVnX1BkOcsEp/B0nc2InoB4CJixZ121CujPebsdAZjSQEkQJqnmsg2wwrO4=
=AgjQ
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
