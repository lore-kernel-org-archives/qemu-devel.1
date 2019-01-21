Received: from eggs.gnu.org ([209.51.188.92]:48468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1glfT8-0001Yp-Nc
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1glfT8-00069r-3g
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:42:50 -0500
References: <20190121181335.3326-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1ccb74f8-12f2-e2d1-aef0-30eb93ea5f60@vivier.eu>
Date: Mon, 21 Jan 2019 20:42:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190121181335.3326-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] virtio-net: Fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>

On 21/01/2019 19:13, Philippe Mathieu-Daudé wrote:
> Fixes: 2974e916df8
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/virtio/virtio-net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index c7ec1a755f..756eee8af0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -94,7 +94,7 @@ typedef struct VirtioNetRscUnit {
>      uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
>  } VirtioNetRscUnit;
>  
> -/* Coalesced segmant */
> +/* Coalesced segment */
>  typedef struct VirtioNetRscSeg {
>      QTAILQ_ENTRY(VirtioNetRscSeg) next;
>      void *buf;
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
