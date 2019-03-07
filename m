Received: from eggs.gnu.org ([209.51.188.92]:58302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1uh1-000844-HH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h1uh0-0003NN-OO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:12:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h1uh0-0003Ls-Ii
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:12:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so9178090qkb.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:12:17 -0800 (PST)
Date: Thu, 7 Mar 2019 10:12:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190307101152-mutt-send-email-mst@kernel.org>
References: <20190307080244.9011-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307080244.9011-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] virtio-gpu: fix reset.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Mar 07, 2019 at 09:02:41AM +0100, Gerd Hoffmann wrote:
> 
> 
> Gerd Hoffmann (3):
>   virtio: add class_size to VirtioPCIDeviceTypeInfo
>   virtio-vga: fix reset.
>   virtio-gpu: make virtio_gpu_reset static


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge.

>  hw/virtio/virtio-pci.h         |  1 +
>  include/hw/virtio/virtio-gpu.h |  1 -
>  hw/display/virtio-gpu.c        |  2 +-
>  hw/display/virtio-vga.c        | 17 +++++++++++++++--
>  hw/virtio/virtio-pci.c         |  1 +
>  5 files changed, 18 insertions(+), 4 deletions(-)
> 
> -- 
> 2.18.1
