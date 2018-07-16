Received: from eggs.gnu.org ([2001:4830:134:3::10]:50673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fezny-0002EH-0i
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1feznu-0002DV-RI
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:28:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54738 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1feznu-0002DK-MS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:28:26 -0400
Date: Mon, 16 Jul 2018 11:28:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180716112823.0b8925d0@redhat.com>
In-Reply-To: <20180716083732.3347-1-stefanha@redhat.com>
References: <20180716083732.3347-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] virtio-scsi: fix hotplug ->reset()
 vs event race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 16 Jul 2018 09:37:30 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> v2:
>  * Drop Error **errp argument to post_plug() handler [Paolo]
>  * Move post_plug() call outside if (dev->hotplugged)
> 
> The virtio-scsi command virtqueues run during hotplug.  This creates the
> possibility of race conditions since the guest can submit commands while the
> monitor is performing hotplug.
> 
> See Patch 2 for a fix for the ->reset() vs event race condition that Zhengui Li
> encountered.
> 
> Stefan Hajnoczi (2):
>   qdev: add HotplugHandler->post_plug() callback
>   virtio-scsi: fix hotplug ->reset() vs event race
> 
>  include/hw/hotplug.h  | 11 +++++++++++
>  hw/core/hotplug.c     | 10 ++++++++++
>  hw/core/qdev.c        |  4 ++++
>  hw/scsi/virtio-scsi.c | 11 ++++++++++-
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
