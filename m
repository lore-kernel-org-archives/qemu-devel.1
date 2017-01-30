Received: from eggs.gnu.org ([2001:4830:134:3::10]:44091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCYT-0000rY-81
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCYO-00059Q-Ce
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:03:37 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:32841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYCYO-00058z-6Y
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:03:32 -0500
Received: by mail-wj0-x244.google.com with SMTP id un2so7909946wjb.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:03:32 -0800 (PST)
Date: Mon, 30 Jan 2017 14:03:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130140328.GD2118@stefanha-x1.localdomain>
References: <20170126033406.6433-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <20170126033406.6433-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] virtio-scsi: Implement fc_host
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 11:34:04AM +0800, Fam Zheng wrote:
> v2: Use big endian for WWNN/WWPN fields. [Paolo]
>     Clean up vm state change notifier in error/unrealize. [Stefan]
>=20
> This implements a WIP feature extention being proposed on virtio-scsi.
>=20
> We assign a set of Fibre Channel properties, WWNN and WWPN (world wide no=
de
> name and port name, respectively) to the device so the virtual device pre=
sents
> a FC transport in guest. They are useful to identify a host side virtual =
port
> on an FC host, in a NPIV (N_Port ID Virtualization) senario.
>=20
> The linux driver changes are submitted as:
>=20
> https://lkml.org/lkml/2017/1/16/439
>=20
> Fam Zheng (2):
>   manual update linux header for virtio scsi fc_host
>   virtio-scsi: Implement fc_host feature
>=20
>  hw/scsi/virtio-scsi.c                        | 72 ++++++++++++++++++++++=
+++++-
>  include/hw/virtio/virtio-scsi.h              | 10 ++++
>  include/standard-headers/linux/virtio_scsi.h |  6 +++
>  3 files changed, 86 insertions(+), 2 deletions(-)

Once the kernel changes are accepted:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0ewAAoJEJykq7OBq3PIHgQIAJyDhlYfxSY6ts+n51RiGqvJ
Wq6SZDW0F24NRNxH9o6dyo9lopdlnJZWBVHdqnTYflyFmRtBKJdSnx+h4/hYThVn
DnDL+2ghbwZNMNbOIQYgvZ/RmZFYwbc8MErbtr5m/l5HcvIcFdTAQhbRNkF5dZ3G
576Gqwccpr51ilvN+XB0fGnE6p5jUWF/7EXfRtwykh4BGOWEW29tnnAXDBscZdFK
V1qvqgQEAyGeS1lxR8rBNbQgPoeusKlR5PatP1Rsg3wEAqtTZOnXWlgYBu0cYXk+
pooSzdWtIo4VeFX6iwcHXv/IhBYZDuBWcJrnr3/pqKWIyGZ3WhYVwHLncEJRb1I=
=aTfM
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
