Received: from eggs.gnu.org ([2001:4830:134:3::10]:60884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekD5O-00022M-Dh
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ekD5N-0000HY-IS
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:07:46 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a5b06ef9-df93-040b-3274-24d37bb01026@redhat.com>
Date: Fri, 9 Feb 2018 19:07:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GDzhcOjFFeDHtM7TSBJ26pR72A8ZIrFXf"
Subject: Re: [Qemu-devel] [PATCH 08/27] util: Add
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
--GDzhcOjFFeDHtM7TSBJ26pR72A8ZIrFXf
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <a5b06ef9-df93-040b-3274-24d37bb01026@redhat.com>
Subject: Re: [PATCH 08/27] util: Add qemu_opts_to_qdict_filtered()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-9-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> This allows, given a QemuOpts for a QemuOptsList that was merged from
> multiple QemuOptsList, to only consider those options that exist in one=

> specific list. Block drivers need this to separate format-layer create
> options from protocol-level options.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/option.h |  2 ++
>  util/qemu-option.c    | 37 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 34 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--GDzhcOjFFeDHtM7TSBJ26pR72A8ZIrFXf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp941kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ao3IH/2JJCwhTqTge+uWLReVkmZQiiDIrxDtZ
BxzVmBakxmjNKMKPNOkLR2g9c+jBKlF7bpJZNOnmgYeDfAikXmmdtkTQL/PBBUX6
UxUcbCEsIvehcQ5n4Buzzc7z3pF2Avcbp2WtBHCyYmjr6CNbRnBTj9PQfa+/68VR
cLAfapTb9oCAoFlhX1f6gVABlQWlzhoUJK13UMvZCqMfoHERrRckTjpFMNKvVS2M
jVr94iKSZe8dHnHFHhshR8jVeF8C9FCSakOWZgyM22L1HbI9NzSrBma5GN5fIsRi
BI53+PE9inePHfPvCn4yfY3u4tS2S39G7Mup0FGxuSnZGQO+/ieTU88=
=UHkE
-----END PGP SIGNATURE-----

--GDzhcOjFFeDHtM7TSBJ26pR72A8ZIrFXf--
