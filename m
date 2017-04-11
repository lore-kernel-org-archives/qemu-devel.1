Received: from eggs.gnu.org ([2001:4830:134:3::10]:47423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxxxB-00019K-Q8
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cxxx8-0002h5-JM
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cxxx8-0002fj-8c
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:43:34 -0400
Date: Tue, 11 Apr 2017 16:43:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170411154331.GD5940@stefanha-x1.localdomain>
References: <20170411095654.18383-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline
In-Reply-To: <20170411095654.18383-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] simpletrace: document Analyzer method
 signatures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2017 at 10:56:54AM +0100, Stefan Hajnoczi wrote:
> Users can inherit from the simpletrace.Analyzer class and receive
> callbacks when events of interest occur in a trace file.  The method
> signature is a little magic because the timestamp and pid arguments are
> optional.  Document this.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/simpletrace.py | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY7PmjAAoJEJykq7OBq3PIUcwH/A9CCF/0NLsjBon5BRXdiWbz
fGLwBOUvp6cixzEZm2ou3TakTusEM1m/owCw7wWyN3kMw5z+CEViM9PYN2/gmWN2
LRzSyN4KxKatmZTAdlJlG9Tej7f5LMwfDnXXsOrnKxFlamWRQCO1nxFGYQPR0W2q
mvZgoSF+ncJzq+hKj6q1U4s1sHfWrdmA3RV4RECQuNJJqLcvuijM4H5xdbA3PZGB
hbDukNLW014rcvauQsIJFk6Me/xFDEuYaYuW0ksEBl6Fch/hPdGctOq2y3yJHpPR
qncHxux5bUdUk7P9FjcRG18ft/OZXKSxm0ovyzcIb8zCbEgulVmGW1FMMHezOu8=
=7XWm
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
