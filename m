Received: from eggs.gnu.org ([209.51.188.92]:51534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1qPZ-0005RE-T7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1qPU-0005My-0z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:38:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1qPT-0005Me-QV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:37:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id l12so349657wrp.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 02:37:55 -0800 (PST)
References: <20190307080244.9011-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20956849-7110-c94c-ab2b-1e2b1e2994c0@redhat.com>
Date: Thu, 7 Mar 2019 11:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190307080244.9011-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/3] virtio-gpu: fix reset.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 3/7/19 9:02 AM, Gerd Hoffmann wrote:
> Gerd Hoffmann (3):
>   virtio: add class_size to VirtioPCIDeviceTypeInfo
>   virtio-vga: fix reset.
>   virtio-gpu: make virtio_gpu_reset static
> 
>  hw/virtio/virtio-pci.h         |  1 +
>  include/hw/virtio/virtio-gpu.h |  1 -
>  hw/display/virtio-gpu.c        |  2 +-
>  hw/display/virtio-vga.c        | 17 +++++++++++++++--
>  hw/virtio/virtio-pci.c         |  1 +
>  5 files changed, 18 insertions(+), 4 deletions(-)

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
