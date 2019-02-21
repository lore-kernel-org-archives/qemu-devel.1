Received: from eggs.gnu.org ([209.51.188.92]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsHH-0005UR-RB
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsHF-0003Td-MO
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:36:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwsHE-0003N8-3a
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:36:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so7159121wmb.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:36:47 -0800 (PST)
References: <20190221114330.17968-1-marcandre.lureau@redhat.com>
	<20190221114330.17968-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6568187-cc79-61f2-150a-07bbb5c505f7@redhat.com>
Date: Thu, 21 Feb 2019 18:36:45 +0100
MIME-Version: 1.0
In-Reply-To: <20190221114330.17968-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] virtio-gpu: remove unused qdev
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/hw/virtio/virtio-gpu.h | 1 -
>  hw/display/virtio-gpu.c        | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index c8c599f1b9..c7cb821ae3 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -97,7 +97,6 @@ typedef struct VirtIOGPU {
>      int enable;
>  
>      int config_size;
> -    DeviceState *qdev;
>  
>      QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>      QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index c6fab56f9b..a52c2aed0e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1268,7 +1268,6 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>      QTAILQ_INIT(&g->fenceq);
>  
>      g->enabled_output_bitmask = 1;
> -    g->qdev = qdev;
>  
>      for (i = 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =
> 
