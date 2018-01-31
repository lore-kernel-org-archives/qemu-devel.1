Received: from eggs.gnu.org ([2001:4830:134:3::10]:34528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egsiL-00079U-K6
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egsiG-0008SP-2I
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:46:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1egsiF-0008Pl-QA
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:46:07 -0500
Date: Wed, 31 Jan 2018 13:45:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180131134556.GA23336@stefanha-x1.localdomain>
References: <20180131032800.25578-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20180131032800.25578-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, thuth@redhat.com, berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, mreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org, armbru@redhat.com


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 11:28:00AM +0800, Fam Zheng wrote:
> To make our efforts on QEMU testing easier to consume by contributors,
> let's add a document. For example, Patchew reports build errors on
> patches that should be relatively easy to reproduce with a few steps, and
> it is much nicer if there is such a documentation that it can refer to.
>=20
> This focuses on how to run existing tests and how to write new test
> cases, without going into the frameworks themselves.
>=20
> The VM based testing section is moved from tests/vm/README which now
> is a single line pointing to the new doc.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v2: Fix spelling errors and improve wordings. [Stefan, Eric, Thomas]
>     Example test name "test-foo -> foo-test". The mass renaming will be
>     done in another series. [Thomas, Eric]
>     Document how to debug unit tests and qtests. [Eric]
>     Document group permission setup for docker, and the privilege risks.
>     [Alex]
>     Update tests/vm/README.
> ---
>  docs/devel/testing.rst | 486 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/vm/README        |  90 +--------
>  2 files changed, 487 insertions(+), 89 deletions(-)
>  create mode 100644 docs/devel/testing.rst

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacciTAAoJEJykq7OBq3PIIwcIAL2fxfnioGzXyMfuGs7yZpkU
1SCm5bNDF9fDnYclcdXm/YYX7M2RiMHIdSXYleMK3A8gMFrxFmkp2xLtWRJhfnbk
xrpCg8vtPo9DFDHMed2a8H7TBtDjMt+BzlClVXhyJPWe0hExKZs9rzQgziIDPArL
2JUk+4LPBSEdAi0mieDLZuXJO+MvRcM/qmr5X4dIX2L7xODVLmv3+b2Y1cAFT//9
8ooZXGBfIfBIVl5JV0e1nOcvsYQnyHaMuUFCggV79s2XP82yfe3toLwjdw/wKHES
tUSCmpFlcznbavGXFhxocNNa/xk9UnvWDd1YrJ+qkW0lb/W7eAurHIUYAQoMfmI=
=77tT
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
