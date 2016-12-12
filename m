Received: from eggs.gnu.org ([2001:4830:134:3::10]:35935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGTBy-0005Ym-0D
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGTBv-0002CX-Bt
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:11:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGTBv-0002BI-6e
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:11:03 -0500
Date: Mon, 12 Dec 2016 16:11:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212161100.GM4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nj4mAaUCx+wbOcQD"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] speedup vring processing with
 MemoryRegionCaches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--Nj4mAaUCx+wbOcQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:46PM +0100, Paolo Bonzini wrote:
> It is known that virtio's usage of ld_*_phys and st_*_phys functions
> wastes time in address_space_translate, visiting the
> AddressSpaceDispatch's radix tree.
>=20
> This series introduces a small cache that changes these functions
> to a simple range check and memory access.  The effect is a bit
> underwhelming, because the improvement is only 1-2Kiops/second.
> Nevertheless I'm throwing out the patches so that for example they
> can be tested on s390.
>=20
> Things to fix: handle address_space_cache_init failures
> in virtio_init_region_cache.  Also, once virtio breaks free of
> address_space_memoory, we'll need to handle invalidation in IOMMU regions.
> For the latter, maybe it's worth introducing a new abstraction that
> is higher-level than MemoryListener and covers both regular and IOMMU
> memory regions.

I think this new API will be important for getting the best
performance in emulated devices.

Stefan

--Nj4mAaUCx+wbOcQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTswUAAoJEJykq7OBq3PIKnQH/2rF82L+q2mkZ3iH6ButQ0zD
rkB+Eb9p0nqkMwQJAKvy6UzyMPUaERjEjD9Ku/WBne84iu24sO5G3mopm2mmYbJn
zGWn676MacIkQALH5wlTCOl9S3SitOs1dAGlI40LfqQvs2m73IdbQqtbdjr7TJr7
mvffw9K7Clyc8rO2sdTbUDZHTtB7qKFaPYR4a2C4y5JBhAAEWRTdxb8ISIolpi59
sShITy23a53sMcNGznQWqYSBeeNyCT+62tB2fd+4xV0aG+Zmi/zs81hKED6gDXYK
x4g2P1VkDBoUe5twIyE+5NoK9LSiCYwSGENUatiD3DboOXGG1w9uZyFCOmWkQLc=
=+6Nu
-----END PGP SIGNATURE-----

--Nj4mAaUCx+wbOcQD--
