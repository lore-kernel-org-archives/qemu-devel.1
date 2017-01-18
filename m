Received: from eggs.gnu.org ([2001:4830:134:3::10]:34996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsZH-0004pt-M7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsZC-0003RK-Q8
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:54:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsZC-0003R1-K6
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:54:30 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 881B13B716
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:54:30 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:54:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118155427.GM30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-13-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/16] block: explicitly acquire aiocontext
 in bottom halves that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 02:17:27PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  async.c               |  4 ++--
>  block/archipelago.c   |  3 +++
>  block/blkdebug.c      |  9 +--------
>  block/blkreplay.c     |  2 +-
>  block/block-backend.c |  6 ++++++
>  block/curl.c          | 26 ++++++++++++++++++--------
>  block/gluster.c       |  9 +--------
>  block/io.c            |  6 +++++-
>  block/iscsi.c         |  6 +++++-
>  block/linux-aio.c     | 15 +++++++++------
>  block/nfs.c           |  3 ++-
>  block/null.c          |  4 ++++
>  block/qed.c           |  3 +++
>  block/rbd.c           |  4 ++++
>  dma-helpers.c         |  2 ++
>  hw/block/virtio-blk.c |  2 ++
>  hw/scsi/scsi-bus.c    |  2 ++
>  thread-pool.c         |  2 ++
>  18 files changed, 72 insertions(+), 36 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf4+zAAoJEJykq7OBq3PIlb4H/0GopDCiFEktQTSIZIBB9LQO
0fAQBzkUDzxOkH/9dXWF06d37jsyCvXujvXPYdbYJ3QRZMYyieQmFU4lgvpBTvC7
xDpwZkESUwXUlXbqFPeaFn+eZJdAIlTS5KQHlPmaRwk2J+y0IAz34nCDgHogKvHk
zql4VXVKK08/lRMTjJZ6qT7lc21VLFe9l7diywj1nIwt19u+8vpofAgDjAyV8yke
10F87KJndZf/WKY1W2SczoPedU36cLUWpfQtoBZ52DKzV544KL04OyOoIS7yQ9lm
QXYJqotI4WuLUQG0gLo9XE5zcJssfr7KsOZ+BqCK2pirdgQvwf5zLl6rLds72JI=
=9CyR
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--
