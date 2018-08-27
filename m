Received: from eggs.gnu.org ([2001:4830:134:3::10]:56728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuHm6-0000IP-LT
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuHm6-000466-1O
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 09:41:46 -0400
References: <20180823222249.13518-1-jsnow@redhat.com>
	<20180823222249.13518-9-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <85e02534-343b-166f-e964-7a0181693db2@redhat.com>
Date: Mon, 27 Aug 2018 15:41:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180823222249.13518-9-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n2fZFuETMI0a3hUx4OVHIX7styWL3t9j3"
Subject: Re: [Qemu-devel] [PATCH v2 08/13] tests/test-blockjob: remove exit
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n2fZFuETMI0a3hUx4OVHIX7styWL3t9j3
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <85e02534-343b-166f-e964-7a0181693db2@redhat.com>
Subject: Re: [PATCH v2 08/13] tests/test-blockjob: remove exit callback
References: <20180823222249.13518-1-jsnow@redhat.com>
 <20180823222249.13518-9-jsnow@redhat.com>
In-Reply-To: <20180823222249.13518-9-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:22, John Snow wrote:
> We remove the exit callback and the completed boolean along with it.
> We can simulate it just fine by waiting for the job to defer to the
> main loop, and then giving it one final kick to get the main loop
> portion to run.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/test-blockjob.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Hm, well, sure, but I'd think deferred_to_main_loop is an internal
attribute.  Considering this is just a test, it doesn't matter, though, s=
o:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--n2fZFuETMI0a3hUx4OVHIX7styWL3t9j3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD/4wACgkQ9AfbAGHV
z0APggf/Z8UPaPLrMRZm+++DBhVerKbOiYr0VH8TS5j4g2HOdz1RqBpP5fO+vKE8
TUB67BgDhJ0zVwS8rJawjZ3virWFikOliY4WiJsX+9VhyUBguewjpD1w0dVKNSoq
pXsnntRyRrpab1uZBBFceHhvSRkfsT5wXDeouHA3D3PyDvbk3LgEErFZ6QHS03Ql
+Ctna9olyIF1gsG5SHAuXSJHlUXXbDrlMx5iNxzYACJmwp3nyF/lK6QDOGVhkAf8
XHJwDdemkpHIfrG+umtPuEOx6yjdqv4yKtBx/w5GgeMM/qLpyGSVtKbS79Zxe8PW
hAbt2Gxy2CLrbYdHi9i6Kla6sXf+mw==
=YsNe
-----END PGP SIGNATURE-----

--n2fZFuETMI0a3hUx4OVHIX7styWL3t9j3--
