Received: from eggs.gnu.org ([2001:4830:134:3::10]:41753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWaZ-0008Aa-HZ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csWaY-0002mU-Lj
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:29:47 -0400
References: <1490279788-12995-1-git-send-email-peter.maydell@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <944e013f-fb2e-99f2-f646-b1b7df6ee09b@redhat.com>
Date: Mon, 27 Mar 2017 17:29:38 +0200
MIME-Version: 1.0
In-Reply-To: <1490279788-12995-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hcULmPh4pJ09mHgW4UTvfjd2UvGWioa17"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] block/file-posix.c: Fix unused
 variable warning on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hcULmPh4pJ09mHgW4UTvfjd2UvGWioa17
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <944e013f-fb2e-99f2-f646-b1b7df6ee09b@redhat.com>
Subject: Re: [PATCH for-2.9 v2] block/file-posix.c: Fix unused variable
 warning on OpenBSD
References: <1490279788-12995-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490279788-12995-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.03.2017 15:36, Peter Maydell wrote:
> On OpenBSD none of the ioctls probe_logical_blocksize() tries
> exist, so the variable sector_size is unused. Refactor the
> code to avoid this (and reduce the duplicated code).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Jeff Cody <jcody@redhat.com>
> ---
> v2: add (int) cast to avoid compiler warnings on some
> systems when the array is empty; use 'static const'.
> ---
>  block/file-posix.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Thanks, applied to my block branch for 2.9:

https://github.com/XanClic/qemu/commits/block

Max


--hcULmPh4pJ09mHgW4UTvfjd2UvGWioa17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZL+ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aw7IIAL6PuQvu/2wjRHitvXZ9pS5piaaulE1b
iKqmXNoARSsqV9oVoyDOmIT1zdMV381DgLj6xveW5nViGlakO7Zd02JAWedikLnH
8gVUm3XPMidy8EOBvqx7jrAWWUwHe14mXFwo/D2ixrHthoGvHXcyHC9i5IeNClbo
gd+zQvcd9BlXqjCx8ULeut54WI08sNHlSjLnaBtB+S6PoAXgEEdXoKWcBNKc2E4K
14F4TF6l2GmmFbBXaq9Xez/r8dsdOIpG3ElurvHKQvy6LOih1OGt6vMZ+HKDjtTj
iPxb0QrvaN8ipLcRJq03HPJc2HZjYWlAJopkCf6my+uIeYRLpm0dM/Y=
=KRE1
-----END PGP SIGNATURE-----

--hcULmPh4pJ09mHgW4UTvfjd2UvGWioa17--
