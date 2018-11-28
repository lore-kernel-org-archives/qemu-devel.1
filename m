Received: from eggs.gnu.org ([2001:4830:134:3::10]:46417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6V5-0007Kq-7b
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6P9-0008NS-IM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:25:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS6P9-0008My-AW
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:25:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C1703001E4A
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:25:50 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-10-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <2f20560e-747b-0214-3b75-dc37025bd0e8@redhat.com>
Date: Wed, 28 Nov 2018 21:25:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-10-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/16] virtio: split vhost scsi bits
 from virtio-pci
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs    |  1 +
>  hw/virtio/vhost-scsi-pci.c | 95 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c     | 59 -----------------------
>  hw/virtio/virtio-pci.h     | 19 --------
>  4 files changed, 96 insertions(+), 78 deletions(-)
>  create mode 100644 hw/virtio/vhost-scsi-pci.c
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
