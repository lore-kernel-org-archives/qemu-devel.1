Received: from eggs.gnu.org ([2001:4830:134:3::10]:42926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6Ff-0000jw-H0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6FZ-00077H-QU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:16:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS6FS-0006q7-53
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:15:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95E25356CD
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:15:48 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-7-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <217e09f2-f374-9d26-561d-e6d660d52320@redhat.com>
Date: Wed, 28 Nov 2018 21:15:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-7-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/16] virtio: split virtio 9p bits from
 virtio-pci
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

On 26/11/2018 20:59, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs   |  1 +
>  hw/virtio/virtio-9p-pci.c | 86 +++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c    | 52 -----------------------
>  hw/virtio/virtio-pci.h    | 20 ---------
>  4 files changed, 87 insertions(+), 72 deletions(-)
>  create mode 100644 hw/virtio/virtio-9p-pci.c
> 

And what about tests/virtio-9p-test ?

except that:

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
