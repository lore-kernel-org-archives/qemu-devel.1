Received: from eggs.gnu.org ([2001:4830:134:3::10]:43649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS3xT-0000wS-84
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS3iR-0003Xh-Jm
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:33:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS3iR-0003WX-Bq
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:33:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD9F330001D7
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 17:33:34 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-2-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <33ef6dd6-a444-b275-6cdc-ec8eed4f4f4c@redhat.com>
Date: Wed, 28 Nov 2018 18:33:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/16] virtio: split vhost vsock bits
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

On 26/11/2018 20:59, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> 
> Updated copyright info
> Also split virtio-pci.h bits
> ---
>  hw/virtio/Makefile.objs     |  2 +-
>  hw/virtio/vhost-vsock-pci.c | 82 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c      | 51 -----------------------
>  hw/virtio/virtio-pci.h      | 18 --------
>  4 files changed, 83 insertions(+), 70 deletions(-)
>  create mode 100644 hw/virtio/vhost-vsock-pci.c
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
