Received: from eggs.gnu.org ([2001:4830:134:3::10]:40286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eoyyE-0003Zj-IR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eoyyD-00086P-NS
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:04:06 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <623b5a9b-6a89-3eb3-28ae-6b92d71ec9a4@redhat.com>
Date: Thu, 22 Feb 2018 23:03:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ytdz1Kd4RKXpcQ9QJD8fOu6rATXGEG136"
Subject: Re: [Qemu-devel] [PATCH v2 08/36] util: Add
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ytdz1Kd4RKXpcQ9QJD8fOu6rATXGEG136
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <623b5a9b-6a89-3eb3-28ae-6b92d71ec9a4@redhat.com>
Subject: Re: [PATCH v2 08/36] util: Add qemu_opts_to_qdict_filtered()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-9-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> This allows, given a QemuOpts for a QemuOptsList that was merged from
> multiple QemuOptsList, to only consider those options that exist in one=

> specific list. Block drivers need this to separate format-layer create
> options from protocol-level options.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/option.h |  2 ++
>  util/qemu-option.c    | 42 +++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 39 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Ytdz1Kd4RKXpcQ9QJD8fOu6rATXGEG136
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPPksSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcawH/3hb+s6EfsMz+vKcOY1TeWQ0pJPEXoI0
nEobslECWJtAMobxrDJNz+slueQA37m9jCsaca0NHJjeLGSjlcAqi89B5jHaBcy4
EuUEaL34E69CFKLAECMmGDzrKo7vyp0kLxiIaywP8ACduQDyEddRJSNBnq8q7L3r
krMa4LibF0xACqRb264RNNNm/Q2ikZtr7MJTOH/5XaT4k2Jb3NqpY10+begwT0Z1
DFqfG7VbwczC1KQap/VafIcpDW2M53pnELjr2Q8ycL24vdPsxaFxzMvFRl4o6OuF
0bX4nBwhhHWClsKRsWAqwCrK7q8IoMoxJPNBSUp4jwyZ8lQ+AFaY0SY=
=UbGl
-----END PGP SIGNATURE-----

--Ytdz1Kd4RKXpcQ9QJD8fOu6rATXGEG136--
