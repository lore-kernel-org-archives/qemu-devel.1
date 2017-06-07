Received: from eggs.gnu.org ([2001:4830:134:3::10]:40145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcu8-0007uv-IK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIcu5-00033A-6l
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:52 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dIcu4-00032p-V6
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:29:49 -0400
Received: by mail-wm0-x243.google.com with SMTP id 70so3112099wme.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:29:48 -0700 (PDT)
Date: Wed, 7 Jun 2017 16:29:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170607152945.GG21990@stefanha-x1.localdomain>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-5-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4eRLI4hEmsdu6Npr"
Content-Disposition: inline
In-Reply-To: <20170606072229.9302-5-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] util/mmap-alloc: account for DAX
 device in qemu_fd_getpagesize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>


--4eRLI4hEmsdu6Npr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2017 at 03:22:29PM +0800, Haozhong Zhang wrote:
> A DAX device may require a page size different than getpagesize().
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  include/qemu/osdep.h | 10 ++++++++++
>  util/mmap-alloc.c    |  6 ++++++
>  util/osdep.c         | 23 +++++++++++++++++++++++
>  3 files changed, 39 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4eRLI4hEmsdu6Npr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOBvpAAoJEJykq7OBq3PIJDQH/iyz4/MvYOvBhmFklVzulbiV
mlrYlxpVUs9UsLRKJCbJFAOyU8mfHtMj+W7fI38WgDIDBN3PxLiJI5HJ/yjLO8oZ
aLbS83VfD7jDutLFsCGgJnOpm4uHPCEcjMBCC/TUkD5hmxXxiy9hiHtZxvXbh5i9
NNjXHp59svc91B3EqsAoPS/XsGqYvhicczb4/xJ0tOc/tbQ2dEVQkhE/aXASzhLu
5uiySbYQflfBs7c44foyNmsiLIFkULRXzqq2Qc6iUzSiTA6djjE6GAqZhmIV1tFD
vHp8c7GT6DIj7ry+zq44UQhrHFS190gacmYuPPHAmZeXTV+5goj+4yXU7wKixvM=
=hRZm
-----END PGP SIGNATURE-----

--4eRLI4hEmsdu6Npr--
