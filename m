Received: from eggs.gnu.org ([2001:4830:134:3::10]:58606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqCSY-0006a9-NW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqCSV-0000t5-I6
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:12:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqCSV-0000rS-CX
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:12:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D02CC72645
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:12:38 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-21-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30f3b07a-d4d9-05f3-52db-b480baf18226@redhat.com>
Date: Thu, 16 Aug 2018 09:12:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-21-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 20/22] virtio: split virtio-blk bits rom
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
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs    |  1 +
>  hw/virtio/virtio-blk-pci.c | 82 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c     | 58 ---------------------------
>  tests/Makefile.include     |  4 +-
>  4 files changed, 85 insertions(+), 60 deletions(-)
>  create mode 100644 hw/virtio/virtio-blk-pci.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
