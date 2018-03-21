Received: from eggs.gnu.org ([2001:4830:134:3::10]:53688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyfoh-0005FU-R6
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eyfoe-0003DH-LL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:38:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eyfoe-0003Ct-GZ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:38:16 -0400
Date: Wed, 21 Mar 2018 15:38:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180321153809.GT8551@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1521645545-247351-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521645545-247351-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/2] rdma: fix up include
 directives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>

On Wed, Mar 21, 2018 at 05:22:07PM +0200, Michael S. Tsirkin wrote:
> Our rule right now is to use <> for external headers only.
> RDMA code violates that, fix it up.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/rdma/rdma_backend.h        |  2 +-
>  hw/rdma/rdma_backend_defs.h   |  2 +-
>  hw/rdma/rdma_rm.h             |  2 +-
>  hw/rdma/rdma_utils.h          |  6 +++---
>  hw/rdma/vmw/pvrdma.h          |  8 ++++----
>  hw/rdma/vmw/pvrdma_dev_ring.h |  2 +-
>  hw/rdma/rdma_backend.c        |  6 +++---
>  hw/rdma/rdma_rm.c             |  6 +++---
>  hw/rdma/vmw/pvrdma_cmd.c      |  8 ++++----
>  hw/rdma/vmw/pvrdma_dev_ring.c |  8 ++++----
>  hw/rdma/vmw/pvrdma_main.c     | 24 ++++++++++++------------
>  hw/rdma/vmw/pvrdma_qp_ops.c   |  4 ++--
>  12 files changed, 39 insertions(+), 39 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


I'm assuming these were detected by build failures caused by the 2nd
patch in this series, so other areas of the codebase are all correct
already.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
