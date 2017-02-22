Received: from eggs.gnu.org ([2001:4830:134:3::10]:51573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgYbk-0001gA-EL
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgYbj-0002jP-Ng
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:13:32 -0500
Date: Wed, 22 Feb 2017 15:13:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170222151327.GD10201@stefanha-x1.localdomain>
References: <20170217194028.8398-1-pbonzini@redhat.com>
	<20170217194028.8398-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline
In-Reply-To: <20170217194028.8398-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] curl: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, qemu-block@nongnu.org


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 08:40:26PM +0100, Paolo Bonzini wrote:
> Now that all bottom halves and callbacks take care of taking the
> AioContext lock, we can migrate some users away from it and to a
> specific QemuMutex or CoMutex.
>=20
> Protect BDRVCURLState access with a QemuMutex.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYraqXAAoJEJykq7OBq3PIoUEH/2QLxUyZvvmOWaq//cbAyzI2
4MQu7X+CNqmG1AWtM+lRokh1akzJCdu22nt65Vpwlh6wfQ4fLVJJ4p0UB0SNqfCD
iUdfQupLS4EW3NXnbbFFbe/iBTTSv9+JFgza2flpjJIqOzDN9X9G0si8MShKX9og
Bj+PYwQU9PYSMCNKJ0KCu7Onr9PKYDqIjHRtiZosB3TQrFN0yEL7GaqTCT/r3F2z
tHhtbwEDnSEah39D8fowWH0oORRYaX5p6t2sJ0nHIZbDaUVZiM9xVwxD1tkNumdQ
RqWnVIWUEHZD/cEd0wbs6qS+FM50S+M1wBik/nD/tnLTVQKXHJUkv5JmSSm9iHI=
=sQaz
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--
