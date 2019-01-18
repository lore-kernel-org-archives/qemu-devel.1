Received: from eggs.gnu.org ([209.51.188.92]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkSc0-0001BK-VV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gkSbw-0001Jz-0d
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:47:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gkSbv-0001H0-MD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:46:55 -0500
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-2-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8caf272f-f229-c890-89e8-9e76882eb1e0@redhat.com>
Date: Fri, 18 Jan 2019 12:46:44 +0100
MIME-Version: 1.0
In-Reply-To: <1547576349-13337-2-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/libqos: introduce
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
Cc: lvivier@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

On 2019-01-15 19:19, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> This function is intended to group all the qvirtio_* functions that
> start the qvirtio devices.
> Applied in all tests using this combination of functions.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[..]
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

Still unnecessary white-space change.

Apart from that nit, still:

Reviewed-by: Thomas Huth <thuth@redhat.com>
