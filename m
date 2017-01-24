Received: from eggs.gnu.org ([2001:4830:134:3::10]:57198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0R4-0000tl-W1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0R0-0003hy-3s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:42:55 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cW0Qz-0003ht-Rf
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:42:50 -0500
Received: by mail-lf0-x244.google.com with SMTP id v186so17156388lfa.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:42:49 -0800 (PST)
Date: Tue, 24 Jan 2017 12:42:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124124245.GG17221@stefanha-x1.localdomain>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 7/7] virtio: use VRingMemoryRegionCaches
 for avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 06:07:57PM +0100, Paolo Bonzini wrote:
> The virtio-net change is necessary because it uses virtqueue_fill
> and virtqueue_flush instead of the more convenient virtqueue_push.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/net/virtio-net.c |  14 +++++-
>  hw/virtio/virtio.c  | 138 +++++++++++++++++++++++++++++++++++++---------=
------
>  2 files changed, 112 insertions(+), 40 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh0vFAAoJEJykq7OBq3PI2aMH/jdxjOYQJf2as7H7u/HonJmL
qN0DybwZ9PedN5Hj1BrKs/rDwYUsR7eUkbzJ0C/RPQ5qTDFVVFfJb3gSlP16DqiS
+U5M8PfXpecVxZgvIOIOGxXmxdCANgU5+wMQfxBSP77Jp5wPJLzhs40A1c74hMMY
hfY02sYaLJqvqLRpK9qvEPD+cnC4FipzNraCm4VjcIMJaRlCgH3gpiv2d1MFzGEW
w7OXRo//muwNX/oNOsd10RqSqBPBkzSKjKHPcnW4f+j2RkRVRwyBkFHfDc7qViYg
OEXlKjPmigyqmOcvUuRZHXhhCkNDl/YbDCrFmNCG2290F3DsDoMs2xjjHNDIZwo=
=VlVb
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
