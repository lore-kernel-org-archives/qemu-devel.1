Received: from eggs.gnu.org ([2001:4830:134:3::10]:57078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpxpE-0003p8-M4
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpxnV-0002SL-JN
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:33:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpxnK-0002Hs-Fm
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:33:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92E9540216F2
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 15:33:01 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-15-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8ddae865-229c-d29b-94cd-02a780a02237@redhat.com>
Date: Wed, 15 Aug 2018 17:32:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-15-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/22] virtio: split balloon bits from
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
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 08/08/2018 01:48 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs        |  1 +
>  hw/virtio/virtio-balloon-pci.c | 82 ++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c         | 57 -----------------------
>  tests/Makefile.include         |  4 +-
>  4 files changed, 85 insertions(+), 59 deletions(-)
>  create mode 100644 hw/virtio/virtio-balloon-pci.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
