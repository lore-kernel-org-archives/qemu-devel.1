Received: from eggs.gnu.org ([2001:4830:134:3::10]:58226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXjNA-0003Iv-7i
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gXjN7-0006u1-2k
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:03:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gXjN6-0006tP-Qf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:03:01 -0500
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-17-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bbc94ab0-ea80-97d6-bc1b-7404d9d102a9@redhat.com>
Date: Fri, 14 Dec 2018 10:02:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181213210057.3676-17-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 16/16] virtio: virtio 9p really requires
 CONFIG_VIRTFS to work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Greg Kurz <groug@kaod.org>

On 2018-12-13 22:00, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/virtio.mak | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
> index 5ae4a61018..ecb4420e74 100644
> --- a/default-configs/virtio.mak
> +++ b/default-configs/virtio.mak
> @@ -1,7 +1,7 @@
>  CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>  CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>  CONFIG_VIRTIO=y
> -CONFIG_VIRTIO_9P=y
> +CONFIG_VIRTIO_9P=$(CONFIG_VIRTFS)
>  CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_BLK=y
>  CONFIG_VIRTIO_CRYPTO=y
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
