Received: from eggs.gnu.org ([2001:4830:134:3::10]:60610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqCeL-00068Q-SV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqCeI-0008U0-On
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:24:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqCeI-0008Tw-JL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 03:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AD83818A6B0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:24:50 +0000 (UTC)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-23-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c563a524-6803-f3dd-c2af-4453d16fce15@redhat.com>
Date: Thu, 16 Aug 2018 09:24:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-23-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/22] virtio: split virtio-serial bits
 rom virtio-pci
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
>  hw/virtio/Makefile.objs       |  1 +
>  hw/virtio/virtio-pci.c        | 74 --------------------------
>  hw/virtio/virtio-serial-pci.c | 97 +++++++++++++++++++++++++++++++++++
>  tests/Makefile.include        | 12 ++---
>  4 files changed, 104 insertions(+), 80 deletions(-)
>  create mode 100644 hw/virtio/virtio-serial-pci.c
[...]
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index a1352ccefb..8666206ea4 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -143,7 +143,7 @@ check-unit-y += tests/test-crypto-secret$(EXESUF)
>  check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlscredsx509$(EXESUF)
>  check-unit-$(CONFIG_GNUTLS) += tests/test-crypto-tlssession$(EXESUF)
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
> -check-unit-$(CONFIG_LINUX) += tests/test-qga$(EXESUF)
> +check-unit-$(land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) += tests/test-qga$(EXESUF)

Maybe mention qga's dependency in the patch description?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>
