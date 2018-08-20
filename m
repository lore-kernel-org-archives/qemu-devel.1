Received: from eggs.gnu.org ([2001:4830:134:3::10]:48671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlBx-00042r-Qk
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1frlBu-00046Y-Gq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:30:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1frlBs-00043g-Hf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:29:57 -0400
References: <20180808195235.5843-1-gedwards@ddn.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af3b8ef4-d017-d9a8-3f80-32a34c4d06d9@redhat.com>
Date: Mon, 20 Aug 2018 16:29:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180808195235.5843-1-gedwards@ddn.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Greg Edwards <gedwards@ddn.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Nicholas A. Bellinger" <nab@linux-iscsi.org>, Felipe Franciosi <felipe@nutanix.com>

On 08/08/2018 21:52, Greg Edwards wrote:
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
> 

Queued, thanks.

Paolo
