Received: from eggs.gnu.org ([2001:4830:134:3::10]:47870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxqH-0001bd-Hu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVxqG-0006lO-ST
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dVxqG-0006ks-MS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:29:00 -0400
Date: Fri, 14 Jul 2017 11:28:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714102855.GC27446@stefanha-x1.localdomain>
References: <20170713110237.6712-1-lprosek@redhat.com>
	<20170713110237.6712-4-lprosek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20170713110237.6712-4-lprosek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] virtio: introduce virtqueue_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 01:02:32PM +0200, Ladi Prosek wrote:
> Most virtio error output pertains to a specific virtqueue so it makes
> sense to include the queue index in error messages. This commit makes
> all error output in virtio.c use the newly introduced virtqueue_error.
>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/virtio/virtio.c         | 98 ++++++++++++++++++++++++++++------------=
------
>  include/hw/virtio/virtio.h |  1 +
>  2 files changed, 60 insertions(+), 39 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaJznAAoJEJykq7OBq3PImAwH/iF1lXOhIXzSa7VhPhoyqpdc
Exjvx1/tqDImulcBMdBwhUWv5JHveo3adZLPKbVLY2UOzQkcjlJ/ulf0VD9CicUA
9H9KzBQij3o7U0kLLmMGNRSGgmfjrINwPGTSK7W4J2+75Bq96ZHdHravEQooUZMj
fZz3ocNMHhrE4Hkt+opKkpA62ZH4MhWWanz60vOuqmrpZmlBdgMRvfmr53Ff4Xu+
gP2O3cqftB/STEt5sZPDJ76WuYLhQp3NoA2m7Xh0IAsp6tMD3VNw6hbM2Z1RcvDf
KGpsTJZ/TcG8A+fmyovC4z7PzRbaqtLIAJ/EXQMdPR/1yY8sn6Toci2fufCrTI8=
=JI6Y
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
