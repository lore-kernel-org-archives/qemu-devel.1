Received: from eggs.gnu.org ([2001:4830:134:3::10]:43165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpPOM-0001vj-FC
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 22:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpPOJ-0003iD-EJ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 22:49:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpPOJ-0003i3-9g
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 22:49:03 -0400
Date: Tue, 14 Aug 2018 10:48:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180814024858.GF7549@lemon.usersys.redhat.com>
References: <20180808195235.5843-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808195235.5843-1-gedwards@ddn.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] expose VIRTIO_SCSI_F_T10_PI for
 vhost-scsi and vhost-user-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Edwards <gedwards@ddn.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>, Felipe Franciosi <felipe@nutanix.com>

On Wed, 08/08 13:52, Greg Edwards wrote:
> Unify the get_features functions for vhost-scsi and vhost-user-scsi, including
> their use of host_features, and expose a new 't10_pi' property to enable
> negotiation of the VIRTIO_SCSI_F_T10_PI feature bit with the backend.
> 
> Greg Edwards (3):
>   vhost-user-scsi: move host_features into VHostSCSICommon
>   vhost-scsi: unify vhost-scsi get_features implementations
>   vhost-scsi: expose 't10_pi' property for VIRTIO_SCSI_F_T10_PI
> 
>  hw/scsi/vhost-scsi-common.c           |  3 +++
>  hw/scsi/vhost-scsi.c                  |  3 +++
>  hw/scsi/vhost-user-scsi.c             | 28 ++++++++++-----------------
>  include/hw/virtio/vhost-scsi-common.h |  1 +
>  include/hw/virtio/vhost-user-scsi.h   |  1 -
>  5 files changed, 17 insertions(+), 19 deletions(-)


Reviewed-by: Fam Zheng <famz@redhat.com>
