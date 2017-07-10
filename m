Received: from eggs.gnu.org ([2001:4830:134:3::10]:47527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaHR-00022v-Q2
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaHQ-0001B7-Mt
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:07:21 -0400
Date: Mon, 10 Jul 2017 16:07:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710150707.GK14195@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0P/MvzTfyTu5j9Q"
Content-Disposition: inline
In-Reply-To: <20170705133635.11850-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] block: Introduce bdrv_dma_map and
 bdrv_dma_unmap
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


--/0P/MvzTfyTu5j9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
> Allow block driver to map and unmap a buffer for later I/O, as a performance
> hint.

The name blk_dma_map() is confusing since other "dma" APIs like
dma_addr_t and dma_blk_io() deal with guest physical addresses instead
of host addresses.  They are about DMA to/from guest RAM.

Have you considered hiding this cached mapping in block/nvme.c so that
it isn't exposed?  block/nvme.c could keep the last buffer mapped and
callers would get the performance benefit without a new blk_dma_map()
API.

--/0P/MvzTfyTu5j9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY5gbAAoJEJykq7OBq3PIHs4H/1Vec7uR0jjk7rE5nE4I7iHn
MpjFLHoM5O6pNOpoIMFRZQ9hW6JmE/KXAyq6mSyl+fpi74ZbzYpsHcTC8xReYcwZ
zhrm8hJfmR0rxCbh91FzO/fKv6o2tOCJrSKxJwijZVJJcD/5EIJzUxxkwjlRW5Ir
2kRplL3uUUXzZ1JHYlHr+bgCXFdhX2KXuQztDNuGJ+cawu5wXO0bPVpB2tbsL8FX
j67q3i6s0+Xd0eQuslxS8VTgkzhF7VwPDyPY4HvLmPqIHp67o2Kc7lGiwNLu+xvD
Yuu3TyniQiuweWEwN/knEq2FDnOLW2tPuwSoipzN7zZlOrsl47wuOWPpN6WK4ek=
=T6ek
-----END PGP SIGNATURE-----

--/0P/MvzTfyTu5j9Q--
