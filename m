Received: from eggs.gnu.org ([2001:4830:134:3::10]:45286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaAD-0007Ik-EO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaAC-0005Wu-Rc
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:59:53 -0400
Date: Mon, 10 Jul 2017 15:59:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710145943.GI14195@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
In-Reply-To: <20170705133635.11850-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/6] block/nvme: Implement .bdrv_dma_map
 and .bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>


--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2017 at 09:36:33PM +0800, Fam Zheng wrote:
> +static void nvme_dma_map(BlockDriverState *bs, void *host, size_t size)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +
> +    nvme_vfio_dma_map(s->vfio, host, size, false, NULL);

Since temporary=false repeated calls to map/unmap will run out of space
and stop working after some time?

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY5ZfAAoJEJykq7OBq3PIkx0IAI5c+lcBJ58rofTrIV4fucfh
nBvIUyMqh6NqR29bt6n1gPDqw0awqDcRP4AO+tA2FNjYqJofKsvjF/kTqDEYhDKa
jyTHMQh80xtBQJVG/y4kjx2+QoDt3MFoxczNx5KG+qonxDiVo3/LYLWpah44TQZt
6E11Nab/ytWt0yRbVjAdUTrO00vVNmp2vxb3YDUcapubQ/5ah7jK1EnhLvENy++m
03MfLu1ToVhblaoEDfqe5OCH7RdgDT9RReSzmQjc2q0Sv0aMuAXz5KDSBWMq3iai
M05eizCO6LPSIzENMh4V+on0K75VGwpprEiBRPWrQQYeb7z2mqBi6ORh5flJXeQ=
=pHRL
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--
