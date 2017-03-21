Received: from eggs.gnu.org ([2001:4830:134:3::10]:60829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqSdE-0008NW-Vx
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqSdA-00060p-68
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqSd9-00060i-TD
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 18:51:56 -0400
References: <20170321223151.12984-1-Andrew.Baumann@microsoft.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <158d19e3-feaf-84fb-6d7b-22f6204858fd@redhat.com>
Date: Tue, 21 Mar 2017 17:51:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170321223151.12984-1-Andrew.Baumann@microsoft.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QsheEMHevKBRRp25sC2GQpIPNmOM6Mph3"
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring_align() on 64-bit win32
 platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QsheEMHevKBRRp25sC2GQpIPNmOM6Mph3
From: Eric Blake <eblake@redhat.com>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <158d19e3-feaf-84fb-6d7b-22f6204858fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring_align() on 64-bit win32
 platforms
References: <20170321223151.12984-1-Andrew.Baumann@microsoft.com>
In-Reply-To: <20170321223151.12984-1-Andrew.Baumann@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 05:31 PM, Andrew Baumann wrote:
> "long" is 32-bits on win32, but we need to promote it to a 64-bit hwadd=
r
> before negating, or else the top half of the address is truncated
>=20
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
>  include/hw/virtio/virtio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 15efcf2..a0a8543 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -34,7 +34,7 @@ struct VirtQueue;
>  static inline hwaddr vring_align(hwaddr addr,
>                                               unsigned long align)
>  {
> -    return (addr + align - 1) & ~(align - 1);
> +    return (addr + align - 1) & ~(hwaddr)(align - 1);

Why not just use the QEMU_ALIGN_DOWN macro, instead of open-coding it?

(Hmm - a good BiteSized task might be to come up with a Coccinelle
script to help replace all open-coded rounding functions with
appropriate macro calls instead)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QsheEMHevKBRRp25sC2GQpIPNmOM6Mph3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0a6HAAoJEKeha0olJ0NqpFcH/j6dkbzIkq4NDuVIlgVxyVug
DvYrWMRdTzGBv/pYJorUwnS0paiStstH0C9Q+azXAMSLwA31gdCiHWhr/T6gxywj
unMzd5c6HYck9PqV/lxQR5k/h2U8AiEQI8wRqzOWs7ziDSnDqGf1lKDSfdn7w7z5
FbsgGAr2bfQcw74tmmHHKcQ8jEL83XMhk2rmV59AK+V2BduLo9HjWIv3hhpoTD26
sSE/aHMIQw8rBeVCY8/SvAvuLKBLAyfvxSATTzPTow0rY+IYI1M99GkYouJ3iNWW
07SsVw/mxF4MUvekRdq8u37/tAVQX+gcrs7LUmjaD1HMfyJk+qX/qvVVcHF4Pjs=
=Trs4
-----END PGP SIGNATURE-----

--QsheEMHevKBRRp25sC2GQpIPNmOM6Mph3--
