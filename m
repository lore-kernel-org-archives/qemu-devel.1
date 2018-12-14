Received: from eggs.gnu.org ([2001:4830:134:3::10]:40220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXiqW-0007Vy-Ma
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXiqT-0007lK-F0
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:29:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXiqT-0007l2-6z
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:29:17 -0500
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-3-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac6aa09d-def9-d334-f7f8-68958f67736e@redhat.com>
Date: Fri, 14 Dec 2018 09:29:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181213210057.3676-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/16] virtio: split virtio input host
 bits from virtio-pci
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
> For consistency with other devices, rename
> virtio_host_{initfn,pci_info} to virtio_input_host_{initfn,info}.
> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/virtio.mak        |  1 +
>  hw/virtio/Makefile.objs           |  1 +
>  hw/virtio/virtio-input-host-pci.c | 45 +++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c            | 20 --------------
>  hw/virtio/virtio-pci.h            | 14 ----------
>  5 files changed, 47 insertions(+), 34 deletions(-)
>  create mode 100644 hw/virtio/virtio-input-host-pci.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
