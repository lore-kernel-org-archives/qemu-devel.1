Received: from eggs.gnu.org ([2001:4830:134:3::10]:34001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGT9w-0004T0-Vz
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGT9u-0000qK-Bh
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGT9u-0000pb-68
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:08:58 -0500
Date: Mon, 12 Dec 2016 16:08:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212160855.GL4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eWbcAUUbgrfSEG1c"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/11] virtio: use VRingMemoryRegionCaches
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
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--eWbcAUUbgrfSEG1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 12, 2016 at 12:18:57PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/net/virtio-net.c |  14 +++++-
>  hw/virtio/virtio.c  | 137 +++++++++++++++++++++++++++++++++++++---------------
>  2 files changed, 111 insertions(+), 40 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eWbcAUUbgrfSEG1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTsuXAAoJEJykq7OBq3PIzPAIAJ1k5jSC1nB0RonbRv/Ra+Y3
9U+n0KYpoF5z4JCDvN4nh+asE5J3Y2sOKcPnxqUQCEIWU9bPl3VLABg0uIePVXAZ
4Oe+m84JhAeT7gO9fXCdtNWZfiXUaoq2ckKrcXlCruG52dFrvrwCClgrq3xvIJMx
7oax0v1Cleab56lTrvF99elg+X0stwyiw4PeXOzCyNzyv3xdgSCRaMRHyS18RQwB
IxJFkLAKhvD0ei2gNWRqdFlFFeDRLMIaFTH7Al3bpQFRvQnJKsmFC6HBEcIWMOR7
WU3yM7i/+Cm+J1KfpIGjMFV8wb+ouMxwjBk21TBT+IdvPIPOlp3+LhVRsnREToE=
=qCtA
-----END PGP SIGNATURE-----

--eWbcAUUbgrfSEG1c--
