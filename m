Received: from eggs.gnu.org ([2001:4830:134:3::10]:34769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXiRA-0005ty-0c
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXiR6-000632-K1
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:03:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXiR6-0005xV-Bd
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:03:04 -0500
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-2-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c4900e48-c39d-dfe2-8a45-b4a53ff04da5@redhat.com>
Date: Fri, 14 Dec 2018 09:02:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181213210057.3676-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/16] virtio: split vhost vsock bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>

On 2018-12-13 22:00, Juan Quintela wrote:
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> 
> Updated copyright info
> Also split virtio-pci.h bits
> ---
>  hw/virtio/Makefile.objs     |  3 ++
>  hw/virtio/vhost-vsock-pci.c | 82 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c      | 51 -----------------------
>  hw/virtio/virtio-pci.h      | 18 --------
>  4 files changed, 85 insertions(+), 69 deletions(-)
>  create mode 100644 hw/virtio/vhost-vsock-pci.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
