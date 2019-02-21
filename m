Received: from eggs.gnu.org ([209.51.188.92]:35718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsI1-0005zt-Ij
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsHz-0003qJ-Cz
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:37:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwsHv-0003nP-M7
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:37:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so10008542wmg.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:37:31 -0800 (PST)
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
	<20190221114330.17968-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7d633bd-1d79-2932-a212-6bd1c4489fdc@redhat.com>
Date: Thu, 21 Feb 2019 18:37:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190221114330.17968-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] virtio-gpu: remove unused config_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 2/21/19 12:43 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/virtio/virtio-gpu.h | 2 --
>  hw/display/virtio-gpu.c        | 3 +--
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index c7cb821ae3..a1cecd1df8 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -96,8 +96,6 @@ typedef struct VirtIOGPU {
>  
>      int enable;
>  
> -    int config_size;
> -
>      QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>      QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
>      QTAILQ_HEAD(, virtio_gpu_ctrl_command) fenceq;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index a52c2aed0e..8f4351420b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1238,10 +1238,9 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>          }
>      }
>  
> -    g->config_size = sizeof(struct virtio_gpu_config);
>      g->virtio_config.num_scanouts = cpu_to_le32(g->conf.max_outputs);
>      virtio_init(VIRTIO_DEVICE(g), "virtio-gpu", VIRTIO_ID_GPU,
> -                g->config_size);

Well, it is "used" but we can simplify.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +                sizeof(struct virtio_gpu_config));
>  
>      g->req_state[0].width = g->conf.xres;
>      g->req_state[0].height = g->conf.yres;
> 
