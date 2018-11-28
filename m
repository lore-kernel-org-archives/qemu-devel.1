Received: from eggs.gnu.org ([2001:4830:134:3::10]:52442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6ko-0004xx-1b
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6kk-00043A-S0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:48:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS6kk-00042b-Ke
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:48:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAFE53002891
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:48:09 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-17-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c52f04d6-dced-1cb7-23b8-f301254dc366@redhat.com>
Date: Wed, 28 Nov 2018 21:48:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-17-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/16] virtio: virtio 9p really requires
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
Cc: dgilbert@redhat.com, peterx@redhat.com

On 26/11/2018 21:00, Juan Quintela wrote:
> Otherwise, it has no implementation.
> 
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

I think you should also replace "#ifdef CONFIG_VIRTFS" by "#ifdef
CONFIG_VIRTIO_9P" in:

hw/s390x/virtio-ccw.h
include/hw/xen/xen_backend.h
hw/xen/xen_backend.c

Thanks,
Laurent
