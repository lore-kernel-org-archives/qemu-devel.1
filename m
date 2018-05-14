Received: from eggs.gnu.org ([2001:4830:134:3::10]:49083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIERI-0008Jm-Mg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIERF-0007sx-Hh
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:27:00 -0400
Date: Mon, 14 May 2018 15:26:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514142654.GJ5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 03/10] python: futurize -f
 libfuturize.fixes.fix_next_call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:45PM -0300, Eduardo Habkost wrote:
> Change obj.next() calls to next(obj).
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f libfuturize.fixes.fix_next_call $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/ordereddict.py            | 4 ++--
>  scripts/vmstate-static-checker.py | 4 ++--
>  tests/image-fuzzer/runner.py      | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZyuAAoJEJykq7OBq3PIotAH/3rTcUVe5TK2xEMivr3gE8KY
aj1dFddm7PiMyngKeSIluHi6P2VKu50+Flvb+Z7OXaTynL8SzxU8bBCb4/Rd7gUn
2m+5k/MRK9IuRWDzm5ATS+8tLqfpOmuGjZJn+hyYWGG3qfvFh3uWJ4J9wb4x8Qat
wGelc6wjIH3ytfNXVWilHtTNjS4PmAnHEuQUhrj8ejICXU4n6zXF3NfNbbY1tNDn
dy7VSr5z8idXzfXrcw+YkHRQALs0LTWp0Aat6aDi0gZns8zF5imxuIbY/Xq0xo5c
sLQiEwNmYm3IWvF2OxZ1TMEJfbSMxjGqh7oh/Dt+ExnWQvqSsAQlM37FfpVPKUs=
=cXl8
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
