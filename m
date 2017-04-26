Received: from eggs.gnu.org ([2001:4830:134:3::10]:44398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3OhN-0001K1-TB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3OhK-0005wH-Mz
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3OhK-0005w4-DH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:17:42 -0400
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170426144645.12476-5-farman@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e917804b-95d8-dbba-03f8-4ec31c438705@redhat.com>
Date: Wed, 26 Apr 2017 10:17:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170426144645.12476-5-farman@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kjkv1N0vO6KuA13nO4Bw2vXjd3sRiGOnS"
Subject: Re: [Qemu-devel] [RFC PATCH v1 4/5] pc-bios/s390-ccw: Break up
 virtio-scsi read into multiples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kjkv1N0vO6KuA13nO4Bw2vXjd3sRiGOnS
From: Eric Blake <eblake@redhat.com>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e917804b-95d8-dbba-03f8-4ec31c438705@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 4/5] pc-bios/s390-ccw: Break up
 virtio-scsi read into multiples
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
 <20170426144645.12476-5-farman@linux.vnet.ibm.com>
In-Reply-To: <20170426144645.12476-5-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 09:46 AM, Eric Farman wrote:
> A virtio-scsi request that goes through the host sd driver and
> exceeds the maximum transfer size is automatically broken up
> for us. But the equivalent request going to the sg driver
> presumes that any length requirements have already been honored.
> Let's use the max_sectors field from the device and break up
> all virtio-scsi requests (both sd and sg) to avoid problem from
> the host drivers.
>=20
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/s390-ccw.h    |  4 ++++
>  pc-bios/s390-ccw/virtio-scsi.c | 19 ++++++++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index ded67bc..e1f3751 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -42,6 +42,10 @@ typedef unsigned long long __u64;
>  #ifndef NULL
>  #define NULL    0
>  #endif
> +#ifndef MIN
> +#define MIN(a, b) (((a) < (b)) ? (a) : (b));
> +#endif

osdep.h defines MIN() for ALL files, so this hunk is spurious.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kjkv1N0vO6KuA13nO4Bw2vXjd3sRiGOnS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZALoRAAoJEKeha0olJ0NqOhMH/i1gHFG74UdY2eiuF7x4QAyM
ZHYJpwuCSdTqNy04PFjyHxHAbqKH5x5HXIDiG9ktkJD8gIgoi3CY+asYvYby/bCe
cNxKglt41OREWNGgcDm+1EhrB1AsnxFCDxzsshewdmL1xSlQRbJ2AjTycBFSxCys
neb8J+7ybsXeSfB7EBN5IW/WVkN6tG/WeDtjIXLuLYhfx8pPnGquNfVYWjIKTFqz
0QdMrVXgjjyJZoC5dalIFiXrp6hZrHX7R49NaaaodMX7VzCqf6uIeWPVS3Ir/lv0
0FmnAPVB8ohjMA+QEil7/hnKL+5fmmvqf9QoID5Iag4OcY0YTmyaNa08KLLdenc=
=Rg/Q
-----END PGP SIGNATURE-----

--kjkv1N0vO6KuA13nO4Bw2vXjd3sRiGOnS--
