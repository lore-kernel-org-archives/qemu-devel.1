Received: from eggs.gnu.org ([2001:4830:134:3::10]:46477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6VA-0007Nd-MY
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6Mj-0006Bq-4f
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:23:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS6Mi-0006BZ-TJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:23:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 493E4C00F1F9
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:23:20 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-9-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <8c7c4324-0e1f-bc51-aa2e-8b97d469d770@redhat.com>
Date: Wed, 28 Nov 2018 21:23:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-9-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/16] virtio: split vhost user scsi
 bits from virtio-pci
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
>  hw/virtio/Makefile.objs         |   1 +
>  hw/virtio/vhost-user-scsi-pci.c | 101 ++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c          |  58 ------------------
>  hw/virtio/virtio-pci.h          |  11 ----
>  4 files changed, 102 insertions(+), 69 deletions(-)
>  create mode 100644 hw/virtio/vhost-user-scsi-pci.c
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
