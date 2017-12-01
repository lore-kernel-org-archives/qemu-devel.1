Received: from eggs.gnu.org ([2001:4830:134:3::10]:41698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKoVa-0000O4-Hd
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKoVW-0000Ww-Iz
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:49:50 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:42332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eKoVW-0000WX-Bs
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:49:46 -0500
Received: by mail-wm0-x22c.google.com with SMTP id l141so4653621wmg.1
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 08:49:46 -0800 (PST)
Date: Fri, 1 Dec 2017 12:40:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201124051.GK23501@stefanha-x1.localdomain>
References: <cover.1511317952.git.maozy.fnst@cn.fujitsu.com>
	<2882e72d795e04cbe2120f569d551aef2467ac60.1511317952.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4wkndigzIeYF6Hbg"
Content-Disposition: inline
In-Reply-To: <2882e72d795e04cbe2120f569d551aef2467ac60.1511317952.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] hw/block/nvme: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>


--4wkndigzIeYF6Hbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 11:08:43AM +0800, Mao Zhongyi wrote:
> Convert nvme_init() to realize and rename it to nvme_realize().
>=20
> Cc: John Snow <jsnow@redhat.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
>=20
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/block/nvme.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4wkndigzIeYF6Hbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIU3TAAoJEJykq7OBq3PIMFsH/jiq6I48VwZKbJ5o2jSPoCpQ
UoAuThswci8A7IYcfWhi0oW7k4trKRwUdDKoF1U86lB81m1UWvKHX5COwIuXZ7ci
vHdcl2eTjUuMRe23rdgB2lJquwWIcXG//c17GnP9NPKUyTOWGVthJilDZys+ezrO
MZNNdBq5cQXDlwXp0O4a40W6yEAOsbH5FOptI3lYicdRc2k6IQZ4x+8rsuKKItic
6D0ICQFLF/d5TSXXCZ3O3SdmFVQz+ED8/ck5iKSyKTZ/wQ1dkrhY6bhwG78xpNht
aq7CqyzIzBkG8ncBJBIzbwNObiPa5o4LyBYi3bubRVVgsWY5Pkzbjb55JlWamnI=
=yzlt
-----END PGP SIGNATURE-----

--4wkndigzIeYF6Hbg--
