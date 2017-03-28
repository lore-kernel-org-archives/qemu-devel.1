Received: from eggs.gnu.org ([2001:4830:134:3::10]:33534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csw0w-00058i-FT
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1csw0t-00045y-Ch
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:38:42 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:40550
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1csw0t-00045a-5g
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:38:39 -0400
References: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <bb0868d1-5c56-45e5-8b6c-ee08e77dfeaa@weilnetz.de>
Date: Tue, 28 Mar 2017 20:38:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170324231943.18768-1-Andrew.Baumann@microsoft.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9?] virtio: fix vring_align() on
 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Am 25.03.2017 um 00:19 schrieb Andrew Baumann:
> long is 32-bits on 64-bit windows, which caused the top half of the
> address to be truncated; this patch changes it to use the
> QEMU_ALIGN_UP macro which does not suffer the same problem
>
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/hw/virtio/virtio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 15efcf2..7b6edba 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -34,7 +34,7 @@ struct VirtQueue;
>  static inline hwaddr vring_align(hwaddr addr,
>                                               unsigned long align)
>  {
> -    return (addr + align - 1) & ~(align - 1);
> +    return QEMU_ALIGN_UP(addr, align);
>  }
>
>  typedef struct VirtQueue VirtQueue;
>

Eric added "for-2.9" to the subject line of v2, but now it was
missing again for v3.

Is this needed for 2.9? I wonder why I never before noticed
a problem or got a bug report for this issue.

Regards
Stefan
