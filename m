Received: from eggs.gnu.org ([2001:4830:134:3::10]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUJL-0005u0-Te
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfUJH-0002oT-2l
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:58:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfUJG-0002nr-Q8
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:58:19 -0400
Date: Wed, 9 Aug 2017 19:58:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170809195747-mutt-send-email-mst@kernel.org>
References: <1502359951-29160-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502359951-29160-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] *** Introduce a new vhost-user-blk
 host device to Qemu ***
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On Thu, Aug 10, 2017 at 06:12:27PM +0800, Changpeng Liu wrote:
> Althrough virtio scsi specification was designed as a replacement for virtio_blk,
> there are still many users using virtio_blk. Qemu 2.9 introduced a new device
> vhost user scsi which can process I/O in user space for virtio_scsi, this commit
> introduces a new vhost user block host device, which can support virtio_blk in
> Guest OS, and I/O processing in another I/O target.
> 
> Due to the limitation for virtio_blk specification, virtio_blk device cannot get
> block information such as capacity, block size etc via the specification, several
> new vhost user messages were added to support deliver virtio config space
> information between Qemu and I/O target, VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG
> messages used for get/set config space from/to I/O target, VHOST_USER_SET_CONFIG_FD
> was added for event notifier in case the change of virtio config space. Also, those
> messages can be used for vhost device live migration as well.

As we are busy wrapping up a QEMU release, please remember to repost after the
release.

> Changpeng Liu (4):
>   vhost-user: add new vhost user messages to support virtio config space
>   vhost-user-blk: introduce a new vhost-user-blk host device
>   contrib/libvhost-user: enable virtio config space messages
>   contrib/vhost-user-blk: introduce a vhost-user-blk sample application
> 
>  .gitignore                              |   1 +
>  Makefile                                |   3 +
>  Makefile.objs                           |   2 +
>  configure                               |  11 +
>  contrib/libvhost-user/libvhost-user.c   |  51 +++
>  contrib/libvhost-user/libvhost-user.h   |  14 +
>  contrib/vhost-user-blk/Makefile.objs    |   1 +
>  contrib/vhost-user-blk/vhost-user-blk.c | 735 ++++++++++++++++++++++++++++++++
>  docs/interop/vhost-user.txt             |  31 ++
>  hw/block/Makefile.objs                  |   3 +
>  hw/block/vhost-user-blk.c               | 360 ++++++++++++++++
>  hw/virtio/vhost-user.c                  |  86 ++++
>  hw/virtio/vhost.c                       |  63 +++
>  hw/virtio/virtio-pci.c                  |  55 +++
>  hw/virtio/virtio-pci.h                  |  18 +
>  include/hw/virtio/vhost-backend.h       |   8 +
>  include/hw/virtio/vhost-user-blk.h      |  40 ++
>  include/hw/virtio/vhost.h               |  16 +
>  18 files changed, 1498 insertions(+)
>  create mode 100644 contrib/vhost-user-blk/Makefile.objs
>  create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
>  create mode 100644 hw/block/vhost-user-blk.c
>  create mode 100644 include/hw/virtio/vhost-user-blk.h
> 
> -- 
> 1.9.3
