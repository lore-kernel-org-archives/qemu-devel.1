Received: from eggs.gnu.org ([2001:4830:134:3::10]:41585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNe1z-0005GU-9k
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fNe1y-0007QJ-F8
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:15 -0400
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-10-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <db1bbbca-663d-d183-290d-9153b07c4c81@redhat.com>
Date: Tue, 29 May 2018 14:47:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180525163327.23097-10-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NcILtco6pPqxXJ2TqUjBG56xRryVU5Qn6"
Subject: Re: [Qemu-devel] [PATCH 09/14] qemu-iotests: Rewrite 207 for
 blockdev-create job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NcILtco6pPqxXJ2TqUjBG56xRryVU5Qn6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <db1bbbca-663d-d183-290d-9153b07c4c81@redhat.com>
Subject: Re: [PATCH 09/14] qemu-iotests: Rewrite 207 for blockdev-create job
References: <20180525163327.23097-1-kwolf@redhat.com>
 <20180525163327.23097-10-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-10-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-25 18:33, Kevin Wolf wrote:
> This rewrites the test case 207 to work with the new x-blockdev-create
> job rather than the old synchronous version of the command.
>=20
> Most of the test cases stay the same as before (the exception being som=
e
> improved 'size' options that allow distinguishing which command created=

> the image), but in order to be able to implement proper job handling,
> the test case is rewritten in Python.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/207        | 435 +++++++++++++++++++---------------=
--------
>  tests/qemu-iotests/207.out    |  89 +++++----
>  tests/qemu-iotests/group      |   6 +-
>  tests/qemu-iotests/iotests.py |  23 ++-
>  4 files changed, 264 insertions(+), 289 deletions(-)

[...]

> diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
> index 417deee970..299650872c 100644
> --- a/tests/qemu-iotests/207.out
> +++ b/tests/qemu-iotests/207.out

[...]

> +{'execute': 'x-blockdev-create', 'arguments': {'job_id': 'job0', 'opti=
ons': {'driver': 'ssh', 'location': {'path': 'TEST_DIR/t.img', 'host-key-=
check': {'hash': 'f3386a5742ddc4a04244118e59a1f92b', 'type': 'md5', 'mode=
': 'hash'}, 'server': {'host': '127.0.0.1', 'port': '22'}}, 'size': 83886=
08}}}

On second thought...  That hash shouldn't be here.  Well, my R-b stands
if you change it to 314620f24e31d6074e573b80887ace53. ;-)

Max


--NcILtco6pPqxXJ2TqUjBG56xRryVU5Qn6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsNS8oACgkQ9AfbAGHV
z0AXfwf7BIK5YAOpIcYL8gCKUX1/5HNONxmYgC0N52a2upojcjNj6bqc4TnWf5IT
HvQKJKu6772PqgYurM/ulTmhU0D3hZ9+1g6BjZgoeOAhsAS37jze/p6Nx1I1eZ+Z
xNLiiwcq4fY7FmHNlCtCTFc3VmupDsp6UrdSPLlTJ2lX/v6n++aihyLT6JGs+xtW
m3Yy6n/pILTe3Wx+FmAEH3FGGo7DFJGXXV5zh3dYn+jZ5FZrXW/kdz8jdkFhnENy
I3HLDNBxcb9yp6C5GjGnjznB5FMkgPQXSNAnTuxK4A2Uu6ouddUyzZUlT7Kx+B4J
/hfkFGqbb3g28A9OMn/vCFvq1EQ+nQ==
=pYxt
-----END PGP SIGNATURE-----

--NcILtco6pPqxXJ2TqUjBG56xRryVU5Qn6--
