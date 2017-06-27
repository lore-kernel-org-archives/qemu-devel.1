Received: from eggs.gnu.org ([2001:4830:134:3::10]:47054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPff9-0001vV-Aw
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPff6-0002xB-8y
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:51:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPff5-0002wp-WA
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 21:51:28 -0400
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <031ae7b1-9e6a-955e-2d6a-13ed62eb9bd9@redhat.com>
Date: Mon, 26 Jun 2017 20:51:23 -0500
MIME-Version: 1.0
In-Reply-To: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="srfggEEAU562FwKWJxsNQR7f48QR9c4Uc"
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio-net: enable configurable tx
 queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, stefanha@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--srfggEEAU562FwKWJxsNQR7f48QR9c4Uc
From: Eric Blake <eblake@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>, mst@redhat.com, jasowang@redhat.com,
 virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, jan.scheurich@ericsson.com,
 marcandre.lureau@gmail.com, stefanha@gmail.com
Message-ID: <031ae7b1-9e6a-955e-2d6a-13ed62eb9bd9@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio-net: enable configurable tx queue size
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/22/2017 09:32 PM, Wei Wang wrote:
> This patch enables the virtio-net tx queue size to be configurable
> between 256 (the default queue size) and 1024 by the user when the
> vhost-user backend is used.

When sending a multi-patch series, don't forget the 0/2 cover letter.

>=20
> Currently, the maximum tx queue size for other backends is 512 due
> to the following limitations:
> - QEMU backend: the QEMU backend implementation in some cases may
> send 1024+1 iovs to writev.
> - Vhost_net backend: there are possibilities that the guest sends
> a vring_desc of memory which corsses a MemoryRegion thereby

s/corsses/crosses/

> generating more than 1024 iovs after translattion from guest-physical

s/translattion/translation/

> address in the backend.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  hw/net/virtio-net.c            | 45 +++++++++++++++++++++++++++++++++-=
--------
>  include/hw/virtio/virtio-net.h |  1 +
>  2 files changed, 37 insertions(+), 9 deletions(-)
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--srfggEEAU562FwKWJxsNQR7f48QR9c4Uc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUbobAAoJEKeha0olJ0Nq+iEH/3Eq7jjMXl0RBO/Q/ZnLtd93
vlelg0PiEZGJCSoh84wqUQjBk3losVXy/0LrzmG13rRj3ZdWMF84NxV0YdRUQW+Z
EEGNISDhCbP5613j4ww6ZD3Mycj0ZBQvhEbAr5InaTXczmzKtxtXcOBBOTUf9Odh
Dx0naKXP8Bppf+cjrXTAc4kVPOOzFYeS64J5S11/IKvRLIgntkNOfm9j3RIsqNSv
SinUuk43lwiFRUZKPYHrafjQUR/+a/W9SeVGdxH0sEJToZJPnmIt8HEiFmhmN+xn
2Xsw77oppB6YQG6OFKl0y+vfbs5NqZBVoDQhwF3B69iZDh/1iR5Ip+WxYWMFg/s=
=yJgC
-----END PGP SIGNATURE-----

--srfggEEAU562FwKWJxsNQR7f48QR9c4Uc--
