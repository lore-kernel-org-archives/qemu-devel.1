Received: from eggs.gnu.org ([2001:4830:134:3::10]:52018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXj8N-0003x1-J8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXj8N-0002TP-0a
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:47:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXj8M-0002T5-Ow
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:47:46 -0500
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-4-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <887d3e10-100a-1b31-93c0-ac7ebc44c97e@redhat.com>
Date: Fri, 14 Dec 2018 09:47:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181213210057.3676-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/16] virtio: split virtio input bits
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
> ---
>  hw/virtio/Makefile.objs      |   1 +
>  hw/virtio/virtio-input-pci.c | 154 +++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c       | 113 -------------------------
>  hw/virtio/virtio-pci.h       |  22 -----
>  4 files changed, 155 insertions(+), 135 deletions(-)
>  create mode 100644 hw/virtio/virtio-input-pci.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
