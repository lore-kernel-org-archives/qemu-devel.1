Received: from eggs.gnu.org ([2001:4830:134:3::10]:59035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1dabsy-0003Kx-8Z
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1dabsx-0000zF-B8
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:03:00 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::5]:22035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1dabsx-0000vm-12
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 02:02:59 -0400
Date: Thu, 27 Jul 2017 08:02:41 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20170727060241.GA9327@aepfle.de>
References: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
	<1498601083-11799-1-git-send-email-sstabellini@kernel.org>
	<1498601083-11799-3-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <1498601083-11799-3-git-send-email-sstabellini@kernel.org>
Subject: Re: [Qemu-devel] [Xen-devel] [PULL 3/3] xen-disk: add support for
 multi-page shared rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: peter.maydell@linaro.org, stefanha@gmail.com, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jun 27, Stefano Stabellini wrote:

> From: Paul Durrant <paul.durrant@citrix.com>
> The blkif protocol has had provision for negotiation of multi-page shared
> rings for some time now and many guest OS have support in their frontend
> drivers.

> +++ b/hw/block/xen_disk.c

> +    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));

According to [1] g_malloc0_n requires at least glib-2.24. As a result
compilation of qemu-2.10 fails in SLE11, which has just glib-2.22.

Olaf

[1] https://developer.gnome.org/glib/stable/glib-Memory-Allocation.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWXmB/QAKCRBdQqD6ppg2
fp29AKDwU7sUOwkM050CJ0QZPo1ubH6NsQCfS3ZqWRXGFCy8b+CUS+biou9cnJ4=
=aLJ1
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
