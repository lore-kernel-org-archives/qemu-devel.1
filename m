Received: from eggs.gnu.org ([2001:4830:134:3::10]:36237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVCF1-0003wU-Dp
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVCEw-0003jj-9A
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:16:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gVCEv-0003jR-UU
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:16:06 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-16-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <512311a0-6198-2677-9a9f-53a24b3dc273@redhat.com>
Date: Fri, 7 Dec 2018 10:16:01 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-16-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/71] tests/libqos: introduce
 virtio_start_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 2018-12-03 16:32, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> This function is intended to group all the qvirtio_* functions that
> start the qvirtio devices.
> Applied in all tests using this combination of functions.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/libqos/virtio.c    |  7 +++++++
>  tests/libqos/virtio.h    |  1 +
>  tests/vhost-user-test.c  |  4 +---
>  tests/virtio-9p-test.c   |  4 +---
>  tests/virtio-blk-test.c  | 10 +++-------
>  tests/virtio-net-test.c  |  4 +---
>  tests/virtio-scsi-test.c |  4 +---
>  7 files changed, 15 insertions(+), 19 deletions(-)
[...]
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index 04c6087..f97c158 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -116,10 +116,7 @@ static QVirtioPCIDevice *virtio_blk_pci_init(QPCIBus *bus, int slot)
>      g_assert_cmphex(dev->pdev->devfn, ==, ((slot << 3) | PCI_FN));
>  
>      qvirtio_pci_device_enable(dev);
> -    qvirtio_reset(&dev->vdev);
> -    qvirtio_set_acknowledge(&dev->vdev);
> -    qvirtio_set_driver(&dev->vdev);
> -
> +    qvirtio_start_device(&dev->vdev);
>      return dev;
>  }
>  
> @@ -333,6 +330,7 @@ static void pci_indirect(void)
>      qvirtio_set_features(&dev->vdev, features);
>  
>      vqpci = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
> +
>      qvirtio_set_driver_ok(&dev->vdev);

Unnecessary white-space change. Apart from that nit:

Reviewed-by: Thomas Huth <thuth@redhat.com>
