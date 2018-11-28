Received: from eggs.gnu.org ([2001:4830:134:3::10]:33152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS4S4-0007CG-VI
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gS4S1-0003EM-TV
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gS4S1-0003AD-Kn
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 13:20:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4D2230C582B
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 18:20:40 +0000 (UTC)
References: <20181126200009.862-1-quintela@redhat.com>
	<20181126200009.862-4-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f264cb8c-e235-7153-e687-a2540ebd2c21@redhat.com>
Date: Wed, 28 Nov 2018 19:20:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181126200009.862-4-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/16] virtio: split virtio input bits
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
Cc: dgilbert@redhat.com, peterx@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On 26/11/2018 20:59, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs      |   1 +
>  hw/virtio/virtio-input-pci.c | 154 +++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c       | 113 -------------------------
>  hw/virtio/virtio-pci.h       |  22 -----
>  4 files changed, 155 insertions(+), 135 deletions(-)
>  create mode 100644 hw/virtio/virtio-input-pci.c
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

CC: Gerd
