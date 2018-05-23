Received: from eggs.gnu.org ([2001:4830:134:3::10]:34330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLMAA-0004e4-Qf
	for qemu-devel@nongnu.org; Wed, 23 May 2018 01:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLMA7-00088o-Ms
	for qemu-devel@nongnu.org; Wed, 23 May 2018 01:18:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLMA7-00088g-IJ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 01:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BE0E2401EF04
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 05:18:10 +0000 (UTC)
References: <20180522195038.25280-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76154838-8b84-31d0-c1de-0d36c8259aa5@redhat.com>
Date: Wed, 23 May 2018 07:18:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180522195038.25280-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] hw: make virtio devices configurable
 via default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

On 22.05.2018 21:50, Paolo Bonzini wrote:
> This is only half of the work, because the proxy devices (virtio-*-pci,
> virtio-*-ccw, etc.) are still included unconditionally.  It is still a
> move in the right direction.
[...]
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 765d363c1f..1b2799cfd8 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -1,15 +1,17 @@
>  ifeq ($(CONFIG_VIRTIO),y)
> -common-obj-y +=3D virtio-rng.o
> -common-obj-$(CONFIG_VIRTIO_PCI) +=3D virtio-pci.o
>  common-obj-y +=3D virtio-bus.o
> -common-obj-y +=3D virtio-mmio.o
> +obj-y +=3D virtio.o

While you're at it, I think you could also remove the ifeq at the
beginning of this file, and change the virtio-bus.o and virtio.o lines
to use $(CONFIG_VIRTIO) instead of "y".
But it's just a matter of taste, so either way:

Reviewed-by: Thomas Huth <thuth@redhat.com>
