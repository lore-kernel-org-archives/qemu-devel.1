Received: from eggs.gnu.org ([2001:4830:134:3::10]:59452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctvqv-0001g6-5Q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctvqu-0004On-3M
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:40:29 -0400
References: <20170330223645.349-1-eblake@redhat.com>
	<20170330223645.349-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e1b589e9-2859-fe55-0986-15d162879f47@redhat.com>
Date: Fri, 31 Mar 2017 14:40:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170330223645.349-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JfIAh9FjmdMc8d4IXW1jbSfjTAq2QTrV8"
Subject: Re: [Qemu-devel] [PATCH v7 2/3] iotests: Improve image-clear tests
 on non-aligned image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JfIAh9FjmdMc8d4IXW1jbSfjTAq2QTrV8
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <e1b589e9-2859-fe55-0986-15d162879f47@redhat.com>
Subject: Re: [PATCH v7 2/3] iotests: Improve image-clear tests on non-aligned
 image
References: <20170330223645.349-1-eblake@redhat.com>
 <20170330223645.349-3-eblake@redhat.com>
In-Reply-To: <20170330223645.349-3-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 00:36, Eric Blake wrote:
> Tweak 097 and 176 to operate on an image that is not cluster-aligned,
> to give further coverage of clearing out an entire image.
>=20
> Tested for qcow (97) and qcow2 (97 and 176).
>=20
> The fact that there is a subtle difference between the expected
> outputs of 97 and 176 on pass 0 is evidence that we still don't
> always clear out the full image in qcow2.  Commit a3e1505 fixed
> the case of clusters stranded at the 2G mark, but did not fix
> stranding an unaligned tail.  That will be the next patch, kept
> separate to make it easier to see the impact.

I'm not sure I like this very much. The reference output should always
be what we actually expect it to be. Therefore, usually the issue is
fixed first and the test is added only afterwards.

If I want to see the impact I can just do what I always do in those
cases: Go to the base commit, compile qemu, step forward to commits to
the test, run the test, see it fail, compile qemu again, run the test,
see it pass.

So would it be possible to switch this and patch 3?

(Apart from that, this patch looks good.)

Max

> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v7: also write data in the unaligned cluster, and document bug it expos=
es
> v6: new patch
> ---
>  tests/qemu-iotests/097     | 17 +++++++++-----
>  tests/qemu-iotests/097.out | 55 ++++++++++++++++++++++++++++++++++++--=
--------
>  tests/qemu-iotests/176     | 17 +++++++++-----
>  tests/qemu-iotests/176.out | 55 ++++++++++++++++++++++++++++++++++++--=
--------
>  4 files changed, 108 insertions(+), 36 deletions(-)


--JfIAh9FjmdMc8d4IXW1jbSfjTAq2QTrV8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeTjISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALSgIALQLtVJ1lLRxpZrlB7cBlS/sf1vpjsTf
QOgHNg1nfh74FjkAwXqJ33sUlgzdJHnd6/NAO4PDxV6Lhmq2QlJFo16VuHEAVrWQ
SCuQtpmK0LfdLrX4cPhs4RfBsVMNxREbQezTOdV2fL5/QXb4459j5ksbrNqu/evz
9gXuDNhVsj9gkZPVoz2CsS2Mht5S+aABxZ5yl0CxTFOsx3xKPSsw1qyMMOcbObiQ
SlrXEDKYExww6/g9QJByGZzkP89Aw5aZiqnoPvUbT7EigyLXY7LR4dj1jLk0MwXs
jAz3DW3kZ5YZ1gtmjAj8yCLSBwPbXYRoW8VYJVqtzSRqxCd44OmMVwA=
=orJl
-----END PGP SIGNATURE-----

--JfIAh9FjmdMc8d4IXW1jbSfjTAq2QTrV8--
