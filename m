Received: from eggs.gnu.org ([2001:4830:134:3::10]:43285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMEhX-0006nY-4K
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMEhU-0007t8-2d
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:00:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMEhT-0007su-S0
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:00:00 -0500
Date: Tue, 5 Dec 2017 14:59:50 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205145950.GF31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add
 vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:
> Add the vhost-pci-net device emulation. The device uses bar 2 to expose
> the remote VM's memory to the guest. The first 4KB of the the bar area
> stores the metadata which describes the remote memory and vring info.

This device looks like the beginning of a new "vhost-pci" virtio device
type.  There are layering violations:

1. This has nothing to do with virtio-net or networking, it's purely
   vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?

2. VirtIODevice does not know about PCI.  It should work over virtio-ccw
   or virtio-mmio.  This patch talks about BARs inside a VirtIODevice so
   there is a problem here.

I'm concerned that there is no clear architecture and elements of the
virtio architecture are being mixed up with no justification.

Can you explain what you're trying to do?

Please post a specification for the vhost-pci device so the operation of
the device can be discussed and is clear to reviewers.

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJrRlAAoJEJykq7OBq3PIr8oIAL9fkM0VEJZbz2roTJ17VgcZ
hpgtTU+8d82HsSNHgalej+rdrFifJsrWKq5ToPlRedAwJGl451JJfjle+Dlg3jOx
l9QFc6pGFn+TGgb4ZyFQsBx5asH24LfEeV1qh7JYj/QuhyND90+0HEft/Ok1O2ri
9Dfc3oIuldFIV5uXnYC77XtBgCBBf9KRkHnTP6EV0nHcd/Hr2NTEC1YTVtXb+B40
56V+hGHvd/RugegV3zz0rddtYkklNiIy0gSMc256VSkXMiyJrqxkdgV+x86lTlsw
lVnKGitlyWp1cOSx59+JF0VXtvlxIVTwgFhsNCbYHX+K1x0HATP44uWgxGFPFRA=
=P5eL
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
