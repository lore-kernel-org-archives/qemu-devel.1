Received: from eggs.gnu.org ([209.51.188.92]:37832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzlGa-0000ah-Lh
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzlGa-0005U0-00
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:44:08 -0500
Date: Fri, 1 Mar 2019 16:44:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190301164405.GD18260@stefanha-x1.localdomain>
References: <63559cf027d4ebd95a844b73b1f20444fb72fb2c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <63559cf027d4ebd95a844b73b1f20444fb72fb2c.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] trivial fix of malloc to g_new in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Julia Suvorova <jusual@mail.ru>, eblake@redhat.com


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 10:16:57PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Note that since thunking occurs throughout the lifetime of the QEMU
> instance, there is no matching 'free' to correct.
>=20
> ---

Hi Aarushi,
The following formatting is commonly used:

  Subject: [PATCH v3] thunk: fix of malloc to g_new

  Note that since thunking occurs throughout the lifetime of the QEMU
  instance, there is no matching 'free' to correct.

  Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
  Reviewed-by: Eric Blake <eblake@redhat.com>

I changed the subject to include the prefix of the component being
modified.  You can look up the preferred prefix using "git log thunk.c"
to see what other commits have used.

The Signed-off-by: goes at the bottom of the commit description.

Don't worry if it takes a few tries to get the formatting conventions.
There is scripts/checkpatch.pl for scanning patches for coding style
violations but I think it wouldn't have detected these things.

The code change itself looks good:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJceWFVAAoJEJykq7OBq3PIXL0IAKzztJnOQH0wMHMkHZmbGxyJ
TCYFOyxYS5w0fSTv9m14e2n4CsRwvh5XAsUGqtP638FnNcWuwv+gh9FF64NS0G7v
mOzqvCzOULi5NIHmejF4x8Zt7VOMmaB5m5a4Ujaxb6VUzdiFcHiAfqZoIHx3/2U7
9g6nZdnKA31PlCMXxTUSydAJP56OuQC6IW8bGLCMEBSchaTV3pz9UFWZAI4J0vRK
/AljZkBn5zAa5AuB/z5fGSOf2o4+7LUYtVWrP1mongeXvsnP6oKBgtmd+OGnlQiU
J1iYuftoz6FzFAVVNz0GFwVV8qt55ZbPuhOjgW/zhWL3yuLk/PxF6N/S9cQQD6E=
=7B5C
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
