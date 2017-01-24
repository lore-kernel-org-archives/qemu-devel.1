Received: from eggs.gnu.org ([2001:4830:134:3::10]:56077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0M5-00059y-Uj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cW0M1-0002Pu-2i
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:37:45 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cW0M0-0002PW-Pb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:37:40 -0500
Received: by mail-lf0-x241.google.com with SMTP id h65so17038735lfi.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 04:37:40 -0800 (PST)
Date: Tue, 24 Jan 2017 12:37:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170124123737.GE17221@stefanha-x1.localdomain>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/7] virtio: add MemoryListener to cache
 ring translations
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


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2017 at 06:07:55PM +0100, Paolo Bonzini wrote:
> +static void virtio_init_region_cache(VirtIODevice *vdev, int n)
> +{
> +    VirtQueue *vq = &vdev->vq[n];
> +    VRingMemoryRegionCaches *old = vq->vring.caches;
> +    VRingMemoryRegionCaches *new = g_new0(VRingMemoryRegionCaches, 1);
> +    hwaddr addr, size;
> +    int event_size;
> +
> +    event_size = virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +
> +    addr = vq->vring.desc;
> +    if (!addr) {
> +        return;

new is leaked.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYh0qRAAoJEJykq7OBq3PIUC8H/jpH6IEL5kNbIb+/LWWDolD+
FdkS8SBnV65bJ6CjwcPaiWbVsQfmnxnFofQfXaBNd3WY/SAz8kibX8dvNnGPMMxa
I2cFGRnhyRULbb6zIgM/OxEzr0/IoMa9GKaAhs9VAkyzG3aTwgZevZmyI/PPA0AF
fMJ1aNV9pqB9PLRrmG6q8loY09WZZVU23o5xKH356Yc5aRYcfKzqSG/5U8o7RpmA
AESxG7eiS6obtaslLglemgExV6wCWjh774nCUvp3VyVIwMAl834QQ5ceTOm8HyI2
Hobyw6MhyUZ9KBCH6DnmPQGRRBLtQn+/zLxXgPB1tgIW+ALx74ij3pgu1fn6MCs=
=tgdm
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
