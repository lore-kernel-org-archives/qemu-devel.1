Received: from eggs.gnu.org ([2001:4830:134:3::10]:49062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpyhE-0000F9-MK
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 12:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpygq-0003bk-OZ
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 12:30:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpygo-0003W6-E5
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 12:30:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B87B677886
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 16:30:29 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-20-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c9655bbb-6202-0068-4069-ad69e229111b@redhat.com>
Date: Wed, 15 Aug 2018 18:30:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-20-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/22] virtio: split virtio-scsi bits
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
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Notice that we can't still run tests with it disabled.  Both cdrom-test and
> drive_del-test use virtio-scsi without checking if it is enabled.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs     |  1 +
>  hw/virtio/virtio-pci.c      | 68 ---------------------------
>  hw/virtio/virtio-scsi-pci.c | 93 +++++++++++++++++++++++++++++++++++++
>  tests/Makefile.include      |  4 +-
>  4 files changed, 96 insertions(+), 70 deletions(-)
>  create mode 100644 hw/virtio/virtio-scsi-pci.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
