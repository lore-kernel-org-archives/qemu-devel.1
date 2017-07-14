Received: from eggs.gnu.org ([2001:4830:134:3::10]:52900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8U-0007Gu-Mr
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs8T-0002V7-N3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:23:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8cc501aa-5551-ad6f-e81b-83153b327e9b@amsat.org>
Date: Fri, 14 Jul 2017 01:23:17 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 14/29] virtio-gpu: use
 DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>

On 07/13/2017 01:32 PM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/display/virtio-gpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0506d2c1b0..669f36f8bb 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -408,7 +408,7 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
>       }
>   
>       format = pixman_image_get_format(res->image);
> -    bpp = (PIXMAN_FORMAT_BPP(format) + 7) / 8;
> +    bpp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>       stride = pixman_image_get_stride(res->image);
>   
>       if (t2d.offset || t2d.r.x || t2d.r.y ||
> @@ -570,7 +570,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>       scanout = &g->scanout[ss.scanout_id];
>   
>       format = pixman_image_get_format(res->image);
> -    bpp = (PIXMAN_FORMAT_BPP(format) + 7) / 8;
> +    bpp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>       offset = (ss.r.x * bpp) + ss.r.y * pixman_image_get_stride(res->image);
>       if (!scanout->ds || surface_data(scanout->ds)
>           != ((uint8_t *)pixman_image_get_data(res->image) + offset) ||
> 
