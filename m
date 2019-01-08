Received: from eggs.gnu.org ([209.51.188.92]:47256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggnbO-0004Td-UX
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggnbO-000841-57
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:23:14 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:41423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ggnbN-0007za-Uu
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:23:14 -0500
Received: from player732.ha.ovh.net (unknown [10.109.160.217])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id B8AA610BBF9
	for <qemu-devel@nongnu.org>; Tue,  8 Jan 2019 10:23:11 +0100 (CET)
Date: Tue, 8 Jan 2019 10:23:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190108102303.3665dde1@bahia.lan>
In-Reply-To: <20190103141013.18019-17-quintela@redhat.com>
References: <20190103141013.18019-1-quintela@redhat.com>
	<20190103141013.18019-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 16/16] virtio: virtio 9p really requires
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
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu,  3 Jan 2019 15:10:13 +0100
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
