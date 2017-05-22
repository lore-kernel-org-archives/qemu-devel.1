Received: from eggs.gnu.org ([2001:4830:134:3::10]:47856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCtan-0000py-9p
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCtam-0002UD-7o
	for qemu-devel@nongnu.org; Mon, 22 May 2017 16:06:13 -0400
References: <20170522195217.12991-1-mreitz@redhat.com>
	<20170522195217.12991-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8792c1f3-b079-2f0f-bf35-b3f3843da5c7@redhat.com>
Date: Mon, 22 May 2017 15:06:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170522195217.12991-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LXI2tjVfpLLjjCKW4m6BcFtcsu59OTeJh"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] iotests: Add test for colon handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LXI2tjVfpLLjjCKW4m6BcFtcsu59OTeJh
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8792c1f3-b079-2f0f-bf35-b3f3843da5c7@redhat.com>
Subject: Re: [PATCH v2 3/3] iotests: Add test for colon handling
References: <20170522195217.12991-1-mreitz@redhat.com>
 <20170522195217.12991-4-mreitz@redhat.com>
In-Reply-To: <20170522195217.12991-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 02:52 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/126     | 105 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/126.out |  23 ++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 129 insertions(+)
>  create mode 100755 tests/qemu-iotests/126
>  create mode 100644 tests/qemu-iotests/126.out
>=20

> +# Note that we could also do the same test with BASE_IMG=3Dfile:image:=
base.$IMGFMT
> +# -- but behavior for that case is a bit strange. Protocol-prefixed pa=
ths are
> +# in a sense always absolute paths, so such paths will never be combin=
ed with
> +# the path of the overlay. But since "image:base.$IMGFMT" is actually =
a
> +# relative path, it will always be evaluated relative to qemu's CWD (b=
ut not
> +# relative to the overlay!). While this is more or less intended, it i=
s still
> +# pretty strange and thus not something that is tested here.
> +# (The root of the issue is to use a relative path with a protocol pre=
fix. This

s/to/the/

> +#  may always give you weird results because in one sense, qemu consid=
ers such
> +#  paths absolute, whereas in another, they are still relative.)

Should we tighten qemu to forbid the use of a protocol prefix with a
non-absolute path?  But that can be a subsequent patch, I don't see it
as a reason to hold up this one.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LXI2tjVfpLLjjCKW4m6BcFtcsu59OTeJh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZI0SpAAoJEKeha0olJ0NqGsIIAK+721nFOeaBNsdp5RyEyJ42
QH8zuSv/9drnGWefQhDAHGEM2LO6nZTwGM9k0XWN0DxR8h7jDegvIq8v1+/jfYWt
tN3QeVjn4OH/o7b7mLrjD+doxdZ4Gnqn0BJZeFTmo3ekfWIgCBUJ/knE/TxbF2cn
pIWrfETPRrDng2uWPrui76/pDSslsr2yiizlSWhjXrta9Ek2zqm8LE6fYrID0Nps
cJcOR+y3uBBvyMLamtQJu8mx3GqbXoYQ8Sxh4rHWhQ5OTcMYP4Ocmpcs2oc+3L1o
BQ60HDazGfK+A0XlSb9YqqFvOvMSlQfDIUUjMvfbBo7RqKErh1kViEQ3k2vQdls=
=OwNC
-----END PGP SIGNATURE-----

--LXI2tjVfpLLjjCKW4m6BcFtcsu59OTeJh--
