Received: from eggs.gnu.org ([2001:4830:134:3::10]:50804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS48w-0006hH-LG
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS48s-00042W-Rv
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:00:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36219)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS48s-0003zr-KF
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:00:54 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5B59308FC5A
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 18:00:53 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-3-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5fc8385c-6943-dc08-805e-9e9718cc8926@redhat.com>
Date: Wed, 28 Nov 2018 19:00:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/16] virtio: split virtio input host
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

On 26/11/2018 20:59, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/virtio.mak        |  1 +
>  hw/virtio/Makefile.objs           |  1 +
>  hw/virtio/virtio-input-host-pci.c | 45 +++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c            | 20 --------------
>  hw/virtio/virtio-pci.h            | 14 ----------
>  5 files changed, 47 insertions(+), 34 deletions(-)
>  create mode 100644 hw/virtio/virtio-input-host-pci.c
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

You should add a note in the commit message you have renamed
virtio_host_initfn and virtio_host_pci_info to virtio_input_host_initfn
and virtio_input_host_info.

Thanks,
Laurent
