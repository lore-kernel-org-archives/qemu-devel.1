Received: from eggs.gnu.org ([2001:4830:134:3::10]:57047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0mN0-0006Y5-Ol
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d0mMz-0004YA-Op
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:57:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1d0mMz-0004Xp-Jk
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:57:53 -0400
Date: Wed, 19 Apr 2017 10:57:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170419095748.GE3343@stefanha-x1.localdomain>
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 06:38:11AM +0000, Wang, Wei W wrote:
> We made some design changes to the original vhost-pci design, and want to=
 open
> a discussion about the latest design (labelled 2.0) and its extension (2.=
1).
> 2.0 design: One VM shares the entire memory of another VM
> 2.1 design: One VM uses an intermediate memory shared with another VM for
>                      packet transmission.

Hi,
Can you talk a bit about the motivation for the 2.x design and major
changes compared to 1.x?

What is the relationship between 2.0 and 2.1?  Do you plan to upstream
both?

> For the convenience of discussion, I have some pictures presented at this=
 link:
> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-=
rfc2.0.pdf
>=20
> Fig. 1 shows the common driver frame that we want use to build the 2.0 an=
d 2.1

What does "frame" mean in this context?  "Framework" or "design".

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9zScAAoJEJykq7OBq3PIKPUIAJ2MqFikTCDReXSJORws9KFg
zIGgv6S8kcNIwVNPbH/SzrEwpn01O5I0STpQQbVFJRSpBeo2TuGR/9ObDCBSQet+
eJoKLs9eaYlSfWhrsZvMI+lIi8bLJIbrr7hKotjZS8GEQF62yVi1bW31X7EYc6G8
BK3s3PnxQ9ajsAtASwtav2JTHYV1XeDqXL8f4CTbXHeuSKnvHOC1lrD1WdRDkxIZ
+f+arFWyVdOv+QguIfElN9tSnLJ5Npl1wfP8lx6U8DCW48k23PDR5YqH89LzrLJI
Xc7dA9FoOv9LC3Y2TxU2imBPlxMVqfXV4uUtT+Bf2G/jSssl6j3Tri7+JXlYEs4=
=GRLv
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
