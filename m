Received: from eggs.gnu.org ([2001:4830:134:3::10]:60793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyED-0003xH-9q
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cqyEA-00046T-8M
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:36:17 -0400
Date: Thu, 23 Mar 2017 08:34:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323083416.GG16717@stefanha-x1.localdomain>
References: <20170320173828.3874-1-sauravsachidanand@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Content-Disposition: inline
In-Reply-To: <20170320173828.3874-1-sauravsachidanand@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v5] util: Use
 g_malloc/g_free in envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Saurav Sachidanand <sauravsachidanand@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, laurent@vivier.eu


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 05:38:28PM +0000, Saurav Sachidanand wrote:
> Change malloc/strdup/free to g_malloc/g_strdup/g_free in
> util/envlist.c.
>=20
> Remove NULL checks for pointers returned from g_malloc and g_strdup
> as they exit in case of failure. Also, update calls to envlist_create
> to reflect this.
>=20
> Free array and array contents returned by envlist_to_environ using
> g_free in bsd-user/main.c and linux-user/main.c.
>=20
> Update comments to reflect change in semantics.
>=20
> Signed-off-by: Saurav Sachidanand <sauravsachidanand@gmail.com>
> ---
>  bsd-user/main.c   | 14 ++++----------
>  linux-user/main.c |  9 +++------
>  util/envlist.c    | 47 +++++++++++++++++++----------------------------
>  3 files changed, 26 insertions(+), 44 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY04iIAAoJEJykq7OBq3PIRhcIAIPatmn/Mg9hIjSs/0pbpsNy
Ef/Nna6HkzIAHDi6MEhgrjW3izT8ZckjZ8j/Vv+VXQULLSG0nO6cmeV9KUrblisZ
5Vc7pJLSxhehRpDudkNOqrOQ4d4B7YO9oJjKNrGfmutjqYHQLEywRee5a8CT10A3
UtMQ5bRUb7/GZgSKzYSdklLG8tBkxGF3cLRVSSJwjf2bU1wMeVtE1irkXolZAgB5
B9ZZUhIzTZA4DuYWwxxhCwqPepX6pPIYiglF06/96aLzO5hUOSSQlBZLHWdEK6Hx
0dJ8cm2g4UyT37vwy4lWLEDkgik2ebuucD9iPEvtNG/9v/1nYEFzpzVK3YYo0Ag=
=dmfl
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--
