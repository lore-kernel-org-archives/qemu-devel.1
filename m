Received: from eggs.gnu.org ([2001:4830:134:3::10]:44764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOlj-0003U7-PS
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOli-00064b-R6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:41:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWOli-00064P-KW
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:41:50 -0500
Date: Wed, 25 Jan 2017 14:41:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125144147.GP10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-9-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nLMor0SRtNCuLS/8"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-9-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 8/8] trace: improve error reporting when
 parsing simpletrace header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>


--nLMor0SRtNCuLS/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:51AM +0000, Daniel P. Berrange wrote:
> When loading a simpletrace binary file we just report
> "Not a valid trace file!" which is not very helpful. Report
> exactly which field we found to be invalid.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/simpletrace.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nLMor0SRtNCuLS/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiLkrAAoJEJykq7OBq3PIODkH/i5Fb1+kJV5z1RiVeMoA0CHs
sisXAPudls0A42DUp6gcC6HsLdz5kZZwoaw1XcqEZHtZts43mpr/SHVbypChIoD5
KoD+HYcmhXPcWTv1n2NMGlaeuRQGJP0AitHH+JcsjZMmVF31SYJW7n99E8K7JRYb
rC61jWIcA7fuD1BxC/lqeLLk9enCqoB8XdScJW59lR3LL1Slmx7/BT1bd/rC8kXH
2HUGEYMAUNfIuZ565b+gpKKXK0VKrSJwFk+qDkTJGhYSkuuQgtMIM15BL6Qfu9cF
zbQct6CXjI/Zlfx6qVnKa8tn4geU8xym6zD1zrUnhtqrpNyaY/Zx3i/8zQH3nu0=
=lICw
-----END PGP SIGNATURE-----

--nLMor0SRtNCuLS/8--
