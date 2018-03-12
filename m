Received: from eggs.gnu.org ([2001:4830:134:3::10]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evUtc-00077z-H4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evUtb-0008M5-OM
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:22:16 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-6-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6268add-f6cd-d7aa-ff05-c7f0a561ca8e@redhat.com>
Date: Mon, 12 Mar 2018 22:22:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k0ZhK2LaGk1pC9TIq3BeQlnmSaexPvz26"
Subject: Re: [Qemu-devel] [PATCH 5/7] vdi: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k0ZhK2LaGk1pC9TIq3BeQlnmSaexPvz26
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <e6268add-f6cd-d7aa-ff05-c7f0a561ca8e@redhat.com>
Subject: Re: [PATCH 5/7] vdi: Support .bdrv_co_create
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-6-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 22:46, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to vdi, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  21 ++++++-
>  block/vdi.c          | 169 ++++++++++++++++++++++++++++++++++++++-----=
--------
>  2 files changed, 148 insertions(+), 42 deletions(-)

As I said on IRC, I'd prefer cluster-size not to be exposed over QAPI,
seeing it is not supported by default (and you can't enable it through
configure, you can only enable it by modifying vdi.c), and that it is
explicitly untested.

Max


--k0ZhK2LaGk1pC9TIq3BeQlnmSaexPvz26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqm734SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ax0wIAMP++AZMqLBVUbvTfG/OmM3FDcMLHWc5
hu53npa7pZBil2s6n0HNpoa4V14mMSb7aLqgDnyq2PxvSvcKjg8QhVW6wve7EEr8
lNMWiv4gZAEzy0TqxfFxdvLZdkIDl8hjBT5QA+KekNEmS5knveS0YpPr7GZI3b5W
Ww1HrCSyVMl2TQDPKP7UKFyC9sFvyjhTOTrlhlZkhqpcjgpvtKEafN7svpqge2ky
ssusqQGEuIo9DRVwd8Bg3y1QDxwDwYbLW7sWzmg2l3pSFfu0WL8YZJRCUPY6DEBz
m1PNI5jzknEh2UEw+iSxG/GRQzghlCHE0q2d1uSrjq30bd34FnpN/3o=
=+C0W
-----END PGP SIGNATURE-----

--k0ZhK2LaGk1pC9TIq3BeQlnmSaexPvz26--
