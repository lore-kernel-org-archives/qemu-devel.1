Received: from eggs.gnu.org ([2001:4830:134:3::10]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBiuh-0006d5-2k
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBiud-0001mg-2o
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:34:27 -0400
Date: Thu, 26 Apr 2018 16:34:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180426153416.GI30991@stefanha-x1.localdomain>
References: <20180418030424.28980-1-famz@redhat.com>
	<20180418030424.28980-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline
In-Reply-To: <20180418030424.28980-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH v2 3/7] qcow2: Implement
 copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 18, 2018 at 11:04:20AM +0800, Fam Zheng wrote:
> +static int qcow2_co_copy_range_to(BlockDriverState *bs,
> +                                  BdrvChild *src, uint64_t src_offset,
> +                                  BdrvChild *dst, uint64_t dst_offset,
> +                                  uint64_t bytes, BdrvRequestFlags flags)
> +{

In theory this could increment the refcount if src == dst.  It's not
necessary to go down to leaf nodes if the sharing can be handled at the
qcow2 L2 table level.

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4fF4AAoJEJykq7OBq3PI7TAIAKS7z+fwRSlLB18JX2tjWoYV
kFjRZgyieb+C3X/p8Cr6sbh2naoFEn0wy6x5yM6uy9t8/pfkQIkYqRnnkb0m0HMd
bOUd2q3bPPsuFHE9wu7+gF2GUx3lWToFPVmcbzOKKaj1TdayBt+3DSu0CFRwLrkP
JhqSbnD7imXgVbTwEV705MDAqQ0tnFSRc4njwVDpP/PBKKzgXI/sx5o1d3prTNTy
H5zZEox7zrq9bHgI/c9VKX2WOopi96xM4RiFm8waI9TzRdAf8V2chKFpLoUJ8oj6
7nomPxVV8M6xCN7jLLGdL0XPcKNyn8J3fuAmYp/0aH0hX/sxi0Rw7uYi+qkfEUI=
=GGS6
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
