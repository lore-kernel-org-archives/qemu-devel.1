Received: from eggs.gnu.org ([2001:4830:134:3::10]:48554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB1RN-0003mA-Pn
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dB1RK-0007F1-N0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dB1RK-0007E9-F5
	for qemu-devel@nongnu.org; Wed, 17 May 2017 12:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48BA98123F
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 16:04:40 +0000 (UTC)
Date: Wed, 17 May 2017 17:04:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170517160434.GC2196@work-vm>
References: <20170517154756.22079-1-quintela@redhat.com>
	<20170517154756.22079-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517154756.22079-10-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] migration: migration.h was not needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> This files don't use any function from migration.h, so drop it.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  block/qed.c             | 1 -
>  hw/i386/pc_q35.c        | 1 -
>  hw/virtio/vhost-user.c  | 1 -
>  hw/virtio/vhost-vsock.c | 1 -
>  hw/virtio/virtio.c      | 1 -
>  monitor.c               | 1 -
>  6 files changed, 6 deletions(-)
> 
> diff --git a/block/qed.c b/block/qed.c
> index fd76817..8d899fd 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -19,7 +19,6 @@
>  #include "trace.h"
>  #include "qed.h"
>  #include "qapi/qmp/qerror.h"
> -#include "migration/migration.h"
>  #include "sysemu/block-backend.h"
>  
>  static const AIOCBInfo qed_aiocb_info = {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 66303a7..a58785b 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -46,7 +46,6 @@
>  #include "hw/ide/ahci.h"
>  #include "hw/usb.h"
>  #include "qemu/error-report.h"
> -#include "migration/migration.h"
>  #include "sysemu/numa.h"
>  
>  /* ICH9 AHCI has 6 ports */
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 9334a8a..ebc8ccf 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -17,7 +17,6 @@
>  #include "sysemu/kvm.h"
>  #include "qemu/error-report.h"
>  #include "qemu/sockets.h"
> -#include "migration/migration.h"
>  
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
> diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
> index b481562..49e0022 100644
> --- a/hw/virtio/vhost-vsock.c
> +++ b/hw/virtio/vhost-vsock.c
> @@ -17,7 +17,6 @@
>  #include "qapi/error.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
> -#include "migration/migration.h"
>  #include "qemu/error-report.h"
>  #include "hw/virtio/vhost-vsock.h"
>  #include "qemu/iov.h"
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 03592c5..2d2b6bf 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -21,7 +21,6 @@
>  #include "hw/virtio/virtio.h"
>  #include "qemu/atomic.h"
>  #include "hw/virtio/virtio-bus.h"
> -#include "migration/migration.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "sysemu/dma.h"
>  
> diff --git a/monitor.c b/monitor.c
> index 078cba5..fa295c4 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -49,7 +49,6 @@
>  #include "disas/disas.h"
>  #include "sysemu/balloon.h"
>  #include "qemu/timer.h"
> -#include "migration/migration.h"
>  #include "sysemu/hw_accel.h"
>  #include "qemu/acl.h"
>  #include "sysemu/tpm.h"
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
