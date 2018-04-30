Received: from eggs.gnu.org ([2001:4830:134:3::10]:38436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD79E-0003DP-Dy
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD79D-0007VK-1b
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:39:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fD79C-0007V5-TY
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:39:10 -0400
Date: Mon, 30 Apr 2018 12:39:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180430113905.GJ4002@stefanha-x1.localdomain>
References: <20180427215314.23168-1-ross.zwisler@linux.intel.com>
	<20180427215314.23168-3-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <20180427215314.23168-3-ross.zwisler@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] nvdimm: platform capabilities command
 line option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, linux-nvdimm <linux-nvdimm@lists.01.org>


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 03:53:14PM -0600, Ross Zwisler wrote:
> Add a device command line option to allow the user to control the Platform
> Capabilities Structure in the virtualized NFIT.
>=20
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> ---
>  docs/nvdimm.txt         | 22 ++++++++++++++++++++++
>  hw/acpi/nvdimm.c        | 29 +++++++++++++++++++++++++----
>  hw/mem/nvdimm.c         | 28 ++++++++++++++++++++++++++++
>  include/hw/mem/nvdimm.h |  6 ++++++
>  4 files changed, 81 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5wBZAAoJEJykq7OBq3PIgSwH/jdArigadKjwVEC8XJJFB+vs
9mBMvZiLjolxAy/hCJfna2CrYBtR/RxTUT3aSGWufp2LtRNUG5VnEXFHtMW4Yxqx
arW1W6fgq9K7w42+3fSbZf/mq+9yXbhq2V6I/4W2WDuW3+upDpTnNkR2tkf9LebB
If808A9CdGSTBg9i5kwyy3ALz7exE5iMdBHBpDoBs5/+Bkn9LU0jZvWw5qMwqfL3
ZHkcB5XWu5pQbHYyLAV3dDrvd1vZCd6XcZMa0Mg4RzufzBYdmOLMudF5zXbQDGFt
duxbvaHm/CImLlF1p2kaOvyzMa0DEmZu/ggibXjXMR2EBqE8vX6gnkpJji6T7hA=
=JkUR
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
