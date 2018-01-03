Received: from eggs.gnu.org ([2001:4830:134:3::10]:33356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eWn3C-0005Zh-Ot
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eWn3B-0007sX-Tv
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:42:02 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eWn3B-0007s0-MW
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:42:01 -0500
Received: by mail-wm0-x232.google.com with SMTP id a79so3985172wma.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 09:42:01 -0800 (PST)
Date: Wed, 3 Jan 2018 17:41:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180103174158.GD21894@stefanha-x1.localdomain>
References: <20180103021456.22526-1-peterx@redhat.com>
	<20180103021456.22526-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
In-Reply-To: <20180103021456.22526-3-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] chardev: let g_idle_add() be with
 chardev gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 10:14:55AM +0800, Peter Xu wrote:
> The idle task will be attached to main gcontext even if the chardev
> backend is running in another gcontext.  Fix the only caller by
> extending the g_idle_add() logic into the more powerful
> g_source_attach().  It's basically g_idle_add_full() implementation, but
> with the chardev's gcontext passed in.
>=20
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-pty.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTRXmAAoJEJykq7OBq3PISTwH/3bgwNY1Q0c5P58wdhwRr4YU
SydDua9ZXXtH0CFu9dM2wR7III9XFth5/xM436NDZdw4rXCmGyWipVB6fHHkTud8
gmio7gTa/1zSVXpjHenf2B+R+HFupxLt9dON2WzhBNt1+inrt23slK6AjFmtG9sK
3uTAA43i1zHOidyjnXl3u45i4UmL+Quhc5DisTSmKSvLYOgVssxG62dDgouvb0eN
+zfh+LvWleEfdiUEyDU6AwREiKbOyQcz6YsBW/dQCLfANIFtb2OcodEfPVNu2OgY
uarEpMCMeQzVgD91lkJVZvoN00kM97l2rxcrz3kpus6sY341qgjuMO+63XNXBZo=
=xR7A
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
