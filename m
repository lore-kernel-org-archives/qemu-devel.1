Received: from eggs.gnu.org ([2001:4830:134:3::10]:56023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfEs-00035i-Ua
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVfEo-0001lS-UA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:37:10 -0400
References: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da746ef9-1d03-5054-7ce5-7f7193b0894d@redhat.com>
Date: Thu, 13 Jul 2017 09:37:03 -0500
MIME-Version: 1.0
In-Reply-To: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jwFCwkCXBVOnGVjaw0AVfCIrV4KNdgxVJ"
Subject: Re: [Qemu-devel] [PATCH] configure: Drop ancient Solaris 9 and
 earlier support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jwFCwkCXBVOnGVjaw0AVfCIrV4KNdgxVJ
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: patches@linaro.org
Message-ID: <da746ef9-1d03-5054-7ce5-7f7193b0894d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Drop ancient Solaris 9 and
 earlier support
References: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499955697-28045-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/13/2017 09:21 AM, Peter Maydell wrote:
> Solaris 9 was released in 2002, its successor Solaris 10 was
> released in 2005, and Solaris 9 was end-of-lifed in 2014.
> Nobody has stepped forward to express interest in supporting
> Solaris of any flavour, so removing support for the ancient
> versions seems uncontroversial.
>=20
> In particular, this allows us to remove a use of 'uname'
> in configure that won't work if you're cross-compiling.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not a big thing, but it's a start on cleaning out some
> of the untested and untestable cruft from configure...

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jwFCwkCXBVOnGVjaw0AVfCIrV4KNdgxVJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZ4WQAAoJEKeha0olJ0NqMjIIAJ+6uyISgomOALlQpyx/P/Wv
cLnx98RYz13gaJlN5mNS7pomiOsw4CDqAzTNGLUmdmHb5oYTPlvdXvilgVWJPvd0
pXOuNYINZ92NUipWCiH1ud9EcIxak/yAC9cHwCDvJ5XJEh9KjRUCAghWUz23mAA/
+v2e4DIXqYZMoQU8iG6rH97agDpLDRPwEbgndeLfM9n7l9FI4vnxZhAR/iSanvOV
Y8WJ2kG9CVxehHxJTrYM7bqE+plRSDSm23Dq3go3OPxp5R3iA8ck7dDGCAijznfk
sVKUIskUzwNrmmMP8Yzv2AgHP2K8rgm2EtIcFWQfX3LbQqKVF2VcFgRBozBvMrM=
=P1ks
-----END PGP SIGNATURE-----

--jwFCwkCXBVOnGVjaw0AVfCIrV4KNdgxVJ--
