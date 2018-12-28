Received: from eggs.gnu.org ([208.118.235.92]:42756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gcujW-0008Du-EY
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 11:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gcuhz-0007Ly-Kx
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 11:10:02 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:59503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gcuhz-0007KB-EW
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 11:09:59 -0500
Received: from player755.ha.ovh.net (unknown [10.109.143.225])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 0858010B370
	for <qemu-devel@nongnu.org>; Fri, 28 Dec 2018 17:09:56 +0100 (CET)
Date: Fri, 28 Dec 2018 17:09:50 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181228170950.21b47426@bahia.lan>
In-Reply-To: <20181213210057.3676-17-quintela@redhat.com>
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

On Thu, 13 Dec 2018 22:00:57 +0100
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

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
