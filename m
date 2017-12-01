Received: from eggs.gnu.org ([2001:4830:134:3::10]:58794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKndl-0007H3-Bh
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKnd7-0007zJ-Hf
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:54:13 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eKnd6-0007vu-R2
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:53:33 -0500
Received: by mail-wr0-x241.google.com with SMTP id k61so10580038wrc.4
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 07:53:29 -0800 (PST)
Date: Fri, 1 Dec 2017 12:50:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201125011.GL23501@stefanha-x1.localdomain>
References: <cover.1511317952.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lR6P3/j+HGelbRkf"
Content-Disposition: inline
In-Reply-To: <cover.1511317952.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Convert to realize and improve
 error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--lR6P3/j+HGelbRkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 11:08:42AM +0800, Mao Zhongyi wrote:
> This series mainly implements the conversions of ide, floppy and nvme
> device to realize. Add some error handling messages and remove the local
> variable local_err, use errp to propagate the error directly. Also
> fix the unusual function name.
>=20
> v4:
>   -rebased it on top of block-next branch
>=20
> v3:
>   -patch1: update the test output in 051  [John Snow]
>   -patch2: update the test putput in 172  [John Snow]
>=20
> v2:
>   -use bool as the return type instead of int. [Markus Armbruster & Stefa=
n Hajnoczi]
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
>=20
> Mao Zhongyi (4):
>   hw/block/nvme: Convert to realize
>   hw/block: Fix the return type
>   hw/block: Use errp directly rather than local_err
>   dev-storage: Fix the unusual function name
>=20
>  hw/block/block.c                | 15 +++++++++------
>  hw/block/dataplane/virtio-blk.c | 12 +++++++-----
>  hw/block/dataplane/virtio-blk.h |  2 +-
>  hw/block/fdc.c                  | 17 ++++++-----------
>  hw/block/nvme.c                 | 23 +++++++++++------------
>  hw/block/virtio-blk.c           | 18 ++++++------------
>  hw/ide/qdev.c                   | 12 ++++--------
>  hw/scsi/scsi-disk.c             | 13 ++++---------
>  hw/usb/dev-storage.c            | 29 +++++++++++++----------------
>  include/hw/block/block.h        |  4 ++--
>  10 files changed, 63 insertions(+), 82 deletions(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--lR6P3/j+HGelbRkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIVADAAoJEJykq7OBq3PIx3gH/3my0PBWVQfiOrsndXtZ+7vO
xHfjbw6oVmzwranZzpaNxRJkUISjkPoNDo3xD5usBkq5F6R9ltsiVKgPSDq1YJTg
YTUmL0AhKmvcZ0GAaKQcQ3MlrU9KJdpGFPjLOTMRFYvzDqIfUAY+g8OQVuX2o8YN
OD+JO/zQW98D9+PriedlFCVnh2L5o1gkdxEh3xW7zsNgCfPWMsrgyf3JwTVNooHz
O6sxb98cZPOkKCqRb0zVSFhHOytf+4lkh3PLoYvg0sryiZnU4yfzwp+3WzXLFxP8
hwe+rVw+9ulmIn5SkrYWeHGOvAaZDQ5yep08IOKd+iPy8VbNZNFTpNR8hz7CHsI=
=Pg0k
-----END PGP SIGNATURE-----

--lR6P3/j+HGelbRkf--
