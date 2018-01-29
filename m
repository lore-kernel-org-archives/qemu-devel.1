Received: from eggs.gnu.org ([2001:4830:134:3::10]:50816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egDWj-0001j8-K0
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egDWd-0008Ji-3i
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:47:28 -0500
Received: from 14.mo1.mail-out.ovh.net ([178.32.97.215]:35501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egDWc-0008IR-JT
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:47:22 -0500
Received: from player730.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id F2E8ED2F5F
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 18:47:19 +0100 (CET)
Date: Mon, 29 Jan 2018 18:47:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180129184717.68df3b33@bahia.lan>
In-Reply-To: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
References: <1517235657-22547-1-git-send-email-ghammer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gal Hammer <ghammer@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Mon, 29 Jan 2018 16:20:55 +0200
Gal Hammer <ghammer@redhat.com> wrote:

> Using a cleanup callback function (Version 2 of this patches) in order to
> support transactions fails when the same event notifier fd was used by more
> than one Memory Region.
> 
> This time I ask the caller to do the event notifier cleanup by himself.
> 

Much better ! QEMU no longer aborts. Also I could observe a speed-up when
booting a fedora27 guest with 5 virtio-serial devices (max_ports=511), from
1m40s down to 1m10s. Impressive. :)

For all the patches in this series:

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Tested-by: Greg Kurz <groug@kaod.org>

> Gal Hammer (2):
>   virtio: remove event notifier cleanup call on de-assign
>   virtio: improve virtio devices initialization time
> 
>  hw/block/dataplane/virtio-blk.c |  2 ++
>  hw/scsi/virtio-scsi-dataplane.c |  2 ++
>  hw/virtio/vhost.c               |  2 ++
>  hw/virtio/virtio-bus.c          | 14 ++++++++++----
>  hw/virtio/virtio.c              | 22 +++++++++++++++++++++-
>  include/hw/virtio/virtio-bus.h  |  2 ++
>  6 files changed, 39 insertions(+), 5 deletions(-)
> 
