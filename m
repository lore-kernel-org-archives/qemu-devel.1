Received: from eggs.gnu.org ([2001:4830:134:3::10]:46540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6V7-0007P1-HY
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS6V6-0004xz-Qn
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:32:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS6V6-0004xS-JU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 15:32:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE8D9C0703B0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 20:31:59 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-12-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <08d99d00-8f08-f0fe-770c-6d4ff39a7ea7@redhat.com>
Date: Wed, 28 Nov 2018 21:31:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-12-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/16] virtio: split virtio blk bits rom
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

On 26/11/2018 21:00, Juan Quintela wrote:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs    |  1 +
>  hw/virtio/virtio-blk-pci.c | 97 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c     | 59 -----------------------
>  hw/virtio/virtio-pci.h     | 14 ------
>  tests/Makefile.include     |  5 +-
>  5 files changed, 100 insertions(+), 76 deletions(-)
>  create mode 100644 hw/virtio/virtio-blk-pci.c
> 

> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 9b3e7d7403..36d95fe913 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -147,8 +147,7 @@ check-qtest-virtioserial-y += tests/virtio-console-test$(EXESUF)
>  
>  check-qtest-virtio-y += tests/virtio-net-test$(EXESUF)
>  check-qtest-virtio-$(CONFIG_VIRTIO_BALLOON) += tests/virtio-balloon-test$(EXESUF)
> -check-qtest-virtio-y += tests/virtio-blk-test$(EXESUF)
> -check-qtest-virtio-y += tests/virtio-rng-test$(EXESUF)

This one (virtio-rng-test) should be part of PATCH 04/16

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
