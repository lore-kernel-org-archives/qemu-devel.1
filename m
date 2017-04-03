Received: from eggs.gnu.org ([2001:4830:134:3::10]:48034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv15f-0002gV-Fo
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv15c-0002FO-4Q
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:28:11 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170403114044.15762-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ef70b4ab-f71a-8235-dc63-ae34097436af@amsat.org>
Date: Mon, 3 Apr 2017 09:28:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170403114044.15762-1-lvivier@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: replace PIXMAN_* by PIXMAN_BE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 04/03/2017 08:40 AM, Laurent Vivier wrote:
> This avoids a "#ifdef HOST_WORDS_BIGENDIAN" and this is the purpose
> of PIXMAN_BE_* macros.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/virtio-gpu.c | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 9b530ab..7befcef 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -258,41 +258,22 @@ void virtio_gpu_get_display_info(VirtIOGPU *g,
>  static pixman_format_code_t get_pixman_format(uint32_t virtio_gpu_format)
>  {
>      switch (virtio_gpu_format) {
> -#ifdef HOST_WORDS_BIGENDIAN
>      case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> -        return PIXMAN_b8g8r8x8;
> +        return PIXMAN_BE_b8g8r8x8;
>      case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
> -        return PIXMAN_b8g8r8a8;
> +        return PIXMAN_BE_b8g8r8a8;
>      case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
> -        return PIXMAN_x8r8g8b8;
> +        return PIXMAN_BE_x8r8g8b8;
>      case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
> -        return PIXMAN_a8r8g8b8;
> +        return PIXMAN_BE_a8r8g8b8;
>      case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
> -        return PIXMAN_r8g8b8x8;
> +        return PIXMAN_BE_r8g8b8x8;
>      case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
> -        return PIXMAN_r8g8b8a8;
> +        return PIXMAN_BE_r8g8b8a8;
>      case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
> -        return PIXMAN_x8b8g8r8;
> +        return PIXMAN_BE_x8b8g8r8;
>      case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
> -        return PIXMAN_a8b8g8r8;
> -#else
> -    case VIRTIO_GPU_FORMAT_B8G8R8X8_UNORM:
> -        return PIXMAN_x8r8g8b8;
> -    case VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM:
> -        return PIXMAN_a8r8g8b8;
> -    case VIRTIO_GPU_FORMAT_X8R8G8B8_UNORM:
> -        return PIXMAN_b8g8r8x8;
> -    case VIRTIO_GPU_FORMAT_A8R8G8B8_UNORM:
> -        return PIXMAN_b8g8r8a8;
> -    case VIRTIO_GPU_FORMAT_R8G8B8X8_UNORM:
> -        return PIXMAN_x8b8g8r8;
> -    case VIRTIO_GPU_FORMAT_R8G8B8A8_UNORM:
> -        return PIXMAN_a8b8g8r8;
> -    case VIRTIO_GPU_FORMAT_X8B8G8R8_UNORM:
> -        return PIXMAN_r8g8b8x8;
> -    case VIRTIO_GPU_FORMAT_A8B8G8R8_UNORM:
> -        return PIXMAN_r8g8b8a8;
> -#endif
> +        return PIXMAN_BE_a8b8g8r8;
>      default:
>          return 0;
>      }
>
