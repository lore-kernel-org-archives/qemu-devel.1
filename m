Received: from eggs.gnu.org ([2001:4830:134:3::10]:60158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fq0ay-0001re-SY
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fq0au-00053k-JC
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:32:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpxuu-0006gS-0c
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:41:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15511402316D
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 15:40:54 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-16-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7156cc7c-ae64-1958-3e6d-09ebb6ab1f72@redhat.com>
Date: Wed, 15 Aug 2018 17:40:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-16-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/22] virtio: split 9p bits from
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
>  hw/virtio/Makefile.objs   |  1 +
>  hw/virtio/virtio-9p-pci.c | 74 +++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c    | 52 ---------------------------
>  3 files changed, 75 insertions(+), 52 deletions(-)
>  create mode 100644 hw/virtio/virtio-9p-pci.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
