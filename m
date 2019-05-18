Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DFC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 14:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0B420675
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0B420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34757 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS0Bf-0000xa-0H
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 10:19:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hS0Ac-0000RD-Ob
	for qemu-devel@nongnu.org; Sat, 18 May 2019 10:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hS0AY-0006B1-Rg
	for qemu-devel@nongnu.org; Sat, 18 May 2019 10:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hS0AY-00069r-Lr; Sat, 18 May 2019 10:18:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A86930821A3;
	Sat, 18 May 2019 14:18:35 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B85955C231;
	Sat, 18 May 2019 14:18:30 +0000 (UTC)
Date: Sat, 18 May 2019 08:18:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Li Qiang <liq3ea@163.com>
Message-ID: <20190518081830.5adab426@x1.home>
In-Reply-To: <20190518032811.60341-1-liq3ea@163.com>
References: <20190518032811.60341-1-liq3ea@163.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Sat, 18 May 2019 14:18:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] vfio: pci: make "vfio-pci-nohotplug"
 as MACRO
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, qemu-trivial@nongnu.org, liq3ea@gmail.com,
	qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 20:28:08 -0700
Li Qiang <liq3ea@163.com> wrote:

Why?  (No commit message, nor cover letter)

> CC: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/vfio/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 8cecb53d5c..08729e5875 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -40,6 +40,8 @@
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
>  
> +#define TYPE_VIFO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
> +
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>  
> @@ -3304,8 +3306,8 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo vfio_pci_nohotplug_dev_info = {
> -    .name = "vfio-pci-nohotplug",
> -    .parent = "vfio-pci",
> +    .name = TYPE_VIFO_PCI_NOHOTPLUG,
> +    .parent = TYPE_VFIO_PCI,
>      .instance_size = sizeof(VFIOPCIDevice),
>      .class_init = vfio_pci_nohotplug_dev_class_init,
>  };


