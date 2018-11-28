Received: from eggs.gnu.org ([2001:4830:134:3::10]:40378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS698-0004r6-6B
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:09:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS692-00037F-4z
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:09:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS691-000354-SM
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:09:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1308A2CE90B
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:09:11 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-6-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <8dba0aa2-1647-c67f-3db8-1a981159f57e@redhat.com>
Date: Wed, 28 Nov 2018 21:09:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/16] virtio: split virtio balloon bits
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
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs        |  1 +
>  hw/virtio/virtio-balloon-pci.c | 94 ++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c         | 58 ---------------------
>  hw/virtio/virtio-pci.h         | 14 -----
>  tests/Makefile.include         |  2 +-
>  5 files changed, 96 insertions(+), 73 deletions(-)
>  create mode 100644 hw/virtio/virtio-balloon-pci.c
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
