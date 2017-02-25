Received: from eggs.gnu.org ([2001:4830:134:3::10]:58047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chbU7-0001UC-NP
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chbU6-00073J-VQ
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:29:59 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-41-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a5cfa643-5ffa-2a17-2754-5946c1f16fc7@redhat.com>
Date: Sat, 25 Feb 2017 13:29:50 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-41-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o03o0QBahHltognm1213BIbMipRc7cID5"
Subject: Re: [Qemu-devel] [PATCH 40/54] block: BdrvChildRole.attach/detach()
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o03o0QBahHltognm1213BIbMipRc7cID5
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <a5cfa643-5ffa-2a17-2754-5946c1f16fc7@redhat.com>
Subject: Re: [PATCH 40/54] block: BdrvChildRole.attach/detach() callbacks
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-41-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-41-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Backing files are somewhat special compared to other kinds of children
> because they are attached and detached using bdrv_set_backing_hd()
> rather than the normal set of functions, which does a few more things
> like setting backing blockers, toggling the BDRV_O_NO_BACKING flag,
> setting parent_bs->backing_file, etc.
>=20
> These special features are a reason why change_parent_backing_link()
> can't handle backing files yet. With abstracting the additional feature=
s
> into .attach/.detach callbacks, we get a step closer to a function that=

> can actually deal with this.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 94 +++++++++++++++++++++++++++++----------=
--------
>  include/block/block_int.h |  3 ++
>  2 files changed, 62 insertions(+), 35 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--o03o0QBahHltognm1213BIbMipRc7cID5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixeL4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcqsH/07lZ34jtfUAAo0jW01e3O1OS81t5Xy8
XP468Jz4CgsMmXjI19nrNdS9pyACAseWqDuEnCDQ2q7v1A1Q7Bu1OQCEHEo6lW52
W4l3d03MzYMItBSlIBpU20AEfwjXEWhCurdEX9flw0DpKxYfX0ubJqrrQEXPZKRq
FJWecnfgJqi9E9ErSNkLzYstSAgaZHklLX0JsviV+IV1N89oHuM+kzHy7CZurHVP
F0uTRFA32a06p6s2EHN662lUDVl/UzQ14RXWqUi/OYlTjUPCCt/hLCUPZ3SdAvqC
eKhGTKgnfFANc9pMY1j/Z0U/y5koy02L9ScPeVbIGBEbPP+0uW8h0Is=
=Pijm
-----END PGP SIGNATURE-----

--o03o0QBahHltognm1213BIbMipRc7cID5--
