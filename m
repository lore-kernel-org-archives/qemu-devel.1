Received: from eggs.gnu.org ([2001:4830:134:3::10]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fL74X-0005ZT-SO
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fL74U-0001zg-NY
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:11:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fL74U-0001yz-He
	for qemu-devel@nongnu.org; Tue, 22 May 2018 09:11:22 -0400
Date: Tue, 22 May 2018 14:11:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180522131120.GM21655@stefanha-x1.localdomain>
References: <1526682016-17336-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eWmFpGZayiNrn4FL"
Content-Disposition: inline
In-Reply-To: <1526682016-17336-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-blk: turn on pre-defined RO feature
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com


--eWmFpGZayiNrn4FL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 19, 2018 at 06:20:16AM +0800, Changpeng Liu wrote:
> Read only feature shouldn't be negotiable, because if the
> backend device reported Read only feature supported, QEMU
> host driver shouldn't change backend's RO attribute.

I don't understand this patch.

Does it make *all* virtio-blk devices read-only?

Or is the idea that the vhost-user slave has to clear the read-only bit
if it is a writable device?

Stefan

--eWmFpGZayiNrn4FL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBBb3AAoJEJykq7OBq3PIIxwH/Rw2GfEl70Iw3RTz8kg//i1o
mNOzvHlV2cmqo4BLB5MhpkRKh/NGCgvbw8snMrvumygz+Ux/Ofnuj+pmHM8FuFBW
hmxpg9eGdx5Hoz9h9fWl3n6vQyR8CpLRWCxU+MigOivNWEBdhF+h0qfqyrDYVwQV
OUPfMiueHvpmHLFVJ2Og8FjLOW3iG4RCXvg3dcPQa5g5Jv73Dm3dBShqGPfPApkg
5ykvv9iwJnDrR5bF+2DVu2R47Dz9ZHQTSX7BqiKGWLSB6jGDxboV2pekDdJzjYGT
qyC8I0AqRDCeoEVv2td1M4bI650kzGcylwF0UQoLqKmomqlhh3Bnjxp6mOKLLYM=
=58bo
-----END PGP SIGNATURE-----

--eWmFpGZayiNrn4FL--
