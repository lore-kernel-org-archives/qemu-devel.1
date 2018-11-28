Received: from eggs.gnu.org ([2001:4830:134:3::10]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6Ux-0006Ww-Fo
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6RZ-00020c-4m
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:28:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS6RY-0001zt-TV
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:28:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D107E307D983
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:28:19 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-11-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <547ddf30-553c-1b56-8917-246a0045f14e@redhat.com>
Date: Wed, 28 Nov 2018 21:28:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-11-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/16] virtio: split virtio scsi bits
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
> Notice that we can't still run tests with it disabled.  Both cdrom-test and
> drive_del-test use virtio-scsi without checking if it is enabled.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs     |   1 +
>  hw/virtio/virtio-pci.c      |  69 -----------------------
>  hw/virtio/virtio-pci.h      |  14 -----
>  hw/virtio/virtio-scsi-pci.c | 106 ++++++++++++++++++++++++++++++++++++
>  tests/Makefile.include      |   2 +-
>  5 files changed, 108 insertions(+), 84 deletions(-)
>  create mode 100644 hw/virtio/virtio-scsi-pci.c
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
