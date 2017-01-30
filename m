Received: from eggs.gnu.org ([2001:4830:134:3::10]:58387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYF6U-0007xq-Pq
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYF6R-0006Jc-Ma
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYF6R-0006JJ-Et
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 11:46:51 -0500
References: <20170128035929.10168-3-nirsof@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5efd1f74-f5fb-fbe6-b2e0-7a293c096665@redhat.com>
Date: Mon, 30 Jan 2017 10:46:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170128035929.10168-3-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nnHCaMSmMhQQpIOaNdSCHr5SkvVhnseNn"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] qemu-io: Fix tests expecting the
 wrong output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nnHCaMSmMhQQpIOaNdSCHr5SkvVhnseNn
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Message-ID: <5efd1f74-f5fb-fbe6-b2e0-7a293c096665@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] qemu-io: Fix tests expecting the
 wrong output
References: <20170128035929.10168-3-nirsof@gmail.com>
In-Reply-To: <20170128035929.10168-3-nirsof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/27/2017 09:59 PM, Nir Soffer wrote:
> From: Nir Soffer <nsoffer@redhat.com>
>=20
> Many tests expected the wrong behavior when qemu-io call into the
> command with after failing to open the file, writing this error:
>=20
>     no file open, try 'help open'
>=20
> Now that we fail immediately when opening a file fails, this error does=

> not exist in the output; remove it from tests output.

Ideally, this should be squashed into the patch that changes the output
(so that a git bisect landing on the change in behavior does not hit
unnecessarily-broken tests).

>=20
> Tested using:
>=20
> ./check 059 -vmdk (unrelated failure)
> ./check 070 -vhdx
> ./check 075 -cloop
> ./check 076 -parallels
> ./check 078 -bochs
> ./check 080 -qcow2
> ./check 083 -nbd
> ./check 088 -vpc
> ./check 092 -qcow
> ./check 116 -qed
> ./check 131 -parallels
> ./check 140 -raw
> ./check 140 -qcow2
> ./check -raw
> ./check -qcow2
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---
>  tests/qemu-iotests/059.out |  3 ---
>  tests/qemu-iotests/070.out |  1 -
>  tests/qemu-iotests/075.out |  7 -------
>  tests/qemu-iotests/076.out |  3 ---
>  tests/qemu-iotests/078.out |  6 ------
>  tests/qemu-iotests/080.out | 18 ------------------
>  tests/qemu-iotests/083.out | 17 -----------------
>  tests/qemu-iotests/088.out |  6 ------
>  tests/qemu-iotests/092.out | 12 ------------
>  tests/qemu-iotests/116.out |  7 -------
>  tests/qemu-iotests/131.out |  1 -
>  tests/qemu-iotests/140.out |  1 -
>  12 files changed, 82 deletions(-)
>=20

The changes look reasonable, once squashed in to the right place;
looking forward to v4.


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nnHCaMSmMhQQpIOaNdSCHr5SkvVhnseNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj234AAoJEKeha0olJ0Nqga4H/34wLv5Cj23Wi0817DynzaJu
YXdngcbJvFFCYSPEJLiQ4diFZ0iawsstStvP5gnPwH3w9A7e+XtBI4paskQvv50s
ZW4vGeQlwnrONoCRD/XzcBvB98JDO2GVTgxKPgs3KG2U2rUdgibwEXoYzbQRZdvL
x2iae4qv5o6lX2Rcr1tW4E02+4UAObDWeYLg7uRdS0k+mbYAq+gnHrsyAOogl5D5
08qrXrGd1h2bmcrX0hnRC7YpGaF6TV/EhTWcre3d1FBhqh+NqGSvVWJKQY37Pv/r
YUpHB41VZZ186gXzhExrG26/vJ/TsnNDqKjlk3mITbWTzLUpIzvoowHfM/rFjKI=
=refn
-----END PGP SIGNATURE-----

--nnHCaMSmMhQQpIOaNdSCHr5SkvVhnseNn--
