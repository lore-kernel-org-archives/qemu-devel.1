Received: from eggs.gnu.org ([2001:4830:134:3::10]:40141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQdI-0007dK-El
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHQdE-0008NC-Fy
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:39:16 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHQdE-0008Mr-9F
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 02:39:12 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so8218547wjb.3
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 23:39:12 -0800 (PST)
Date: Thu, 15 Dec 2016 07:38:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215073808.GB26169@stefanha-x1.localdomain>
References: <20161214163035.3297-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20161214163035.3297-1-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mdroth@linux.vnet.ibm.com, stefanha@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, cornelia.huck@de.ibm.com, marcel@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 05:30:35PM +0100, Maxime Coquelin wrote:
> This patch fixes a cross-version migration regression introduced
> by commit d1b4259f ("virtio-bus: Plug devices after features are
> negotiated").
>=20
> The problem is encountered when host's vhost backend does not support
> VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
> machine with virtio-pci modern capabilities enabled to a v2.8 machine.
>=20
> In this case, modern capabilities get exposed to the guest by the source,
> whereas the target will detect version 1 is not supported so will only
> expose legacy capabilities.
>=20
> The problem is fixed by introducing a new "x-ignore-backend-features"
> property, which is set in v2.7 and prior compatibility modes. Doing this,
> v2.7 machine keeps its broken behaviour (enabling modern while version
> is not supported), and newer machines will behave correctly.
>=20
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>=20
> V3 fixes commit message with the new property name.
> V2 changes the naming as proposed by Michael T.and Cornelia, and
> fixes commit message.
>=20
>  hw/virtio/virtio-pci.c | 5 ++++-
>  hw/virtio/virtio-pci.h | 1 +
>  include/hw/compat.h    | 4 ++++
>  3 files changed, 9 insertions(+), 1 deletion(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUkhgAAoJEJykq7OBq3PIjAwH/AuHOMb6y10x2Qhbx1wZ7ne0
Z0G8Q0WOMiO/4TJ0cFeRNRHkIoLI1Rvsp7ALiugx4tSS6/o8aTFOXYPAoJE+ftFs
eBnv+XLidGeUy1Ki6wsNZCmqLzk5SXje3UaN1+EYGrr8e7VSYmtShduKsU11bUmj
llxNklcMyKZE/UPaQL9X84FTpngFDwGgUL+hGjLB1yaC8WTIjjeQHH/CqsRHv16T
LqgQT7O/LTrp0sFAYJNGG8m4Mp3+56PdWjn/aaC6ULlR0P7TSkimCyExW6rkfX57
O4BwJR+161IjFj/6BN5BMZC7BIrbetId0NRbVW65eSppARO2rvCJe3B6eAGif/Y=
=SJFb
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
