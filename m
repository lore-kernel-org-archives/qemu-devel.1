Received: from eggs.gnu.org ([2001:4830:134:3::10]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQjBb-0004Rw-Ri
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQjBY-0002GM-OL
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:17:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQjBY-0002GG-Ib
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:17:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85BE961B8F
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 23:17:04 +0000 (UTC)
Date: Tue, 10 Jan 2017 01:17:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110011529-mutt-send-email-mst@kernel.org>
References: <1483970138-20360-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483970138-20360-1-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: tag as not hotpluggable
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

On Mon, Jan 09, 2017 at 02:55:38PM +0100, Gerd Hoffmann wrote:
> qemu can't hotplug display devices.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/display/virtio-gpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index ca88cf4..f410a3e 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1282,6 +1282,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
>  
>      dc->props = virtio_gpu_properties;
>      dc->vmsd = &vmstate_virtio_gpu;
> +    dc->hotpluggable = false;
>  }
>  
>  static const TypeInfo virtio_gpu_info = {
> -- 
> 1.8.3.1
