Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CFFC0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC102087F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC102087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQvK-0007lF-6K
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hsQuc-0007Ht-Bo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hsQuZ-0001lf-4W
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:07:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hsQuY-0001kj-T0
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 673F63179173
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:07:21 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-204-67.brq.redhat.com [10.40.204.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 880535D6B0;
 Tue, 30 Jul 2019 12:07:20 +0000 (UTC)
Date: Tue, 30 Jul 2019 14:07:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190730140718.4c7dbab0@Igors-MacBook-Pro>
In-Reply-To: <20190726120542.9894-25-armbru@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-25-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 30 Jul 2019 12:07:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 24/28] Include sysemu/hostmem.h less
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 14:05:38 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Move the HostMemoryBackend typedef from sysemu/hostmem.h to
> qemu/typedefs.h.  This renders a few inclusions of sysemu/hostmem.h
> superflouous; drop them.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/nvdimm.c                 | 1 +
>  hw/virtio/virtio-pmem.c         | 1 +
>  include/hw/mem/pc-dimm.h        | 1 -
>  include/hw/virtio/virtio-pmem.h | 1 -
>  include/qemu/typedefs.h         | 1 +
>  include/sysemu/hostmem.h        | 1 -
>  6 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 6fefd65092..375f9a588a 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -30,6 +30,7 @@
>  #include "hw/mem/nvdimm.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/mem/memory-device.h"
> +#include "sysemu/hostmem.h"
>  
>  static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
>                                    void *opaque, Error **errp)
> diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
> index ff1a2ddb36..c0c9395e55 100644
> --- a/hw/virtio/virtio-pmem.c
> +++ b/hw/virtio/virtio-pmem.c
> @@ -21,6 +21,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "standard-headers/linux/virtio_ids.h"
>  #include "standard-headers/linux/virtio_pmem.h"
> +#include "sysemu/hostmem.h"
>  #include "block/aio.h"
>  #include "block/thread-pool.h"
>  
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 47b246f95c..289edc0f3d 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -17,7 +17,6 @@
>  #define QEMU_PC_DIMM_H
>  
>  #include "exec/memory.h"
> -#include "sysemu/hostmem.h"
>  #include "hw/qdev-core.h"
>  
>  #define TYPE_PC_DIMM "pc-dimm"
> diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
> index 8bf2ae780f..33f1999320 100644
> --- a/include/hw/virtio/virtio-pmem.h
> +++ b/include/hw/virtio/virtio-pmem.h
> @@ -16,7 +16,6 @@
>  
>  #include "hw/virtio/virtio.h"
>  #include "qapi/qapi-types-misc.h"
> -#include "sysemu/hostmem.h"
>  
>  #define TYPE_VIRTIO_PMEM "virtio-pmem"
>  
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 9e1283aacf..f569f5f270 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -33,6 +33,7 @@ typedef struct FWCfgEntry FWCfgEntry;
>  typedef struct FWCfgIoState FWCfgIoState;
>  typedef struct FWCfgMemState FWCfgMemState;
>  typedef struct FWCfgState FWCfgState;
> +typedef struct HostMemoryBackend HostMemoryBackend;
>  typedef struct HVFX86EmulatorState HVFX86EmulatorState;
>  typedef struct I2CBus I2CBus;
>  typedef struct I2SCodec I2SCodec;
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 92fa0e458c..afeb5db1b1 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -27,7 +27,6 @@
>  #define MEMORY_BACKEND_CLASS(klass) \
>      OBJECT_CLASS_CHECK(HostMemoryBackendClass, (klass), TYPE_MEMORY_BACKEND)
>  
> -typedef struct HostMemoryBackend HostMemoryBackend;
>  typedef struct HostMemoryBackendClass HostMemoryBackendClass;
>  
>  /**


