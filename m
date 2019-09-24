Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8437BC4320D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7DD21841
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 16:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7DD21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCo8I-0001Ow-Qe
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 12:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iCnra-0002u0-MN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iCnrZ-0004Bt-23
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iCnrY-0004BS-Nf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 12:40:28 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA2FE87638
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 16:40:27 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so288822wmd.9
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eS+CIoFof7zcv8exRAEa/0As+ciSjYoFHaD79dw/+EU=;
 b=qpGiIM9Mb3KQ8GfRE7sybZ3nvQMYX2MhAJBwCA/NPYnal5ta7exCWIi7F+8jiTMipR
 jZnqCmARNLyCEm9EiKR9CO+Vegw9bqGVdVMriSjuENiMIApqfdfEr1/habjgMWC6wzrE
 UM63iralBqIaPyC/jGq6UdohfdniK/5nGoEimQK26UK7D+5Z7r70ct22v2GS7Wf0xc9f
 NLvveTRJdrwguNAWRBBkiwylktwk2vNZllBsz3bCJSIVlE2Q2wiR6IfMK8nLVztVkqaF
 XTCVoytfulkZvqOmQatsXDxT636KHB4b0/0q0L1z9QUsiyplffsSddtlvdTh7G+XM+ZI
 aQxA==
X-Gm-Message-State: APjAAAVBcAASoOxTRKkRXRWaCe+219p5dCnQifvBFwkhDvaEM3HZTqVF
 AO5+w+w0QiFH7vorejoMQwlpfRTsuiLJNz6TpV1cx5k8AMNQuSA7kMWsDnxrBkGDECCCAN2dgh4
 xABvT/1hYaUZLajw=
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr3375035wrb.233.1569343226299; 
 Tue, 24 Sep 2019 09:40:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3XAWrTal+QH2Gj16vKQrlrCqCOekmPDl6uxf0ahMcbnneBUT1mNyfZyVE/28zKcIT2/YbOQ==
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr3375007wrb.233.1569343225987; 
 Tue, 24 Sep 2019 09:40:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id z1sm2939953wre.40.2019.09.24.09.40.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 09:40:25 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] vfio: Turn the container error into an Error handle
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 alex.williamson@redhat.com, peterx@redhat.com, aik@ozlabs.ru,
 david@gibson.dropbear.id.au
References: <20190924082517.13724-1-eric.auger@redhat.com>
 <20190924082517.13724-2-eric.auger@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2068b2a4-768f-ef66-2b30-58b3ad203164@redhat.com>
Date: Tue, 24 Sep 2019 18:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924082517.13724-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/19 10:25, Eric Auger wrote:
> The container error integer field is currently used to store
> the first error potentially encountered during any
> vfio_listener_region_add() call. However this fails to propagate
> detailed error messages up to the vfio_connect_container caller.
> Instead of using an integer, let's use an Error handle.
> 
> Messages are slightly reworded to accomodate the propagation.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - remove ret useless assignments and restore hw_error()
> - remove mr local variable
> - trace [start, end] instead of [start, size] and improve
>   the message for overalp with existing DMA host window
> ---
>  hw/vfio/common.c              | 43 +++++++++++++++++++++++------------
>  hw/vfio/spapr.c               |  4 +++-
>  include/hw/vfio/vfio-common.h |  2 +-
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 3e03c495d8..cebbb1c28a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -509,6 +509,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      int ret;
>      VFIOHostDMAWindow *hostwin;
>      bool hostwin_found;
> +    Error *err = NULL;
>  
>      if (vfio_listener_skipped_section(section)) {
>          trace_vfio_listener_region_add_skip(
> @@ -543,13 +544,20 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                                 hostwin->max_iova - hostwin->min_iova + 1,
>                                 section->offset_within_address_space,
>                                 int128_get64(section->size))) {
> -                ret = -1;
> +                error_setg(&err,
> +                    "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
> +                    "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
> +                    section->offset_within_address_space,
> +                    section->offset_within_address_space +
> +                        int128_get64(section->size) - 1,
> +                    hostwin->min_iova, hostwin->max_iova);
>                  goto fail;
>              }
>          }
>  
>          ret = vfio_spapr_create_window(container, section, &pgsize);
>          if (ret) {
> +            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
>              goto fail;
>          }
>  
> @@ -594,10 +602,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      }
>  
>      if (!hostwin_found) {
> -        error_report("vfio: IOMMU container %p can't map guest IOVA region"
> -                     " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx,
> -                     container, iova, end);
> -        ret = -EFAULT;
> +        error_setg(&err, "Container %p can't map guest IOVA region"
> +                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
>          goto fail;
>      }
>  
> @@ -664,11 +670,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
>      ret = vfio_dma_map(container, iova, int128_get64(llsize),
>                         vaddr, section->readonly);
>      if (ret) {
> -        error_report("vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
> -                     "0x%"HWADDR_PRIx", %p) = %d (%m)",
> -                     container, iova, int128_get64(llsize), vaddr, ret);
> +        error_setg(&err, "vfio_dma_map(%p, 0x%"HWADDR_PRIx", "
> +                   "0x%"HWADDR_PRIx", %p) = %d (%m)",
> +                   container, iova, int128_get64(llsize), vaddr, ret);
>          if (memory_region_is_ram_device(section->mr)) {
>              /* Allow unexpected mappings not to be fatal for RAM devices */
> +            error_report_err(err);
>              return;
>          }
>          goto fail;
> @@ -688,9 +695,14 @@ fail:
>       */
>      if (!container->initialized) {
>          if (!container->error) {
> -            container->error = ret;
> +            error_propagate_prepend(&container->error, err,
> +                                    "Region %s: ",
> +                                    memory_region_name(section->mr));
> +        } else {
> +            error_free(err);
>          }
>      } else {
> +        error_report_err(err);
>          hw_error("vfio: DMA mapping failed, unable to continue");
>      }
>  }
> @@ -1251,6 +1263,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      container = g_malloc0(sizeof(*container));
>      container->space = space;
>      container->fd = fd;
> +    container->error = NULL;
>      QLIST_INIT(&container->giommu_list);
>      QLIST_INIT(&container->hostwin_list);
>  
> @@ -1308,9 +1321,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                       &address_space_memory);
>              if (container->error) {
>                  memory_listener_unregister(&container->prereg_listener);
> -                ret = container->error;
> -                error_setg(errp,
> -                    "RAM memory listener initialization failed for container");
> +                ret = -1;
> +                error_propagate_prepend(errp, container->error,
> +                    "RAM memory listener initialization failed: ");
>                  goto free_container_exit;
>              }
>          }
> @@ -1365,9 +1378,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      memory_listener_register(&container->listener, container->space->as);
>  
>      if (container->error) {
> -        ret = container->error;
> -        error_setg_errno(errp, -ret,
> -                         "memory listener initialization failed for container");
> +        ret = -1;
> +        error_propagate_prepend(errp, container->error,
> +            "memory listener initialization failed: ");
>          goto listener_release_exit;
>      }
>  
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 96c0ad9d9b..e853eebe11 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -17,6 +17,7 @@
>  #include "hw/hw.h"
>  #include "exec/ram_addr.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
>  #include "trace.h"
>  
>  static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
> @@ -85,7 +86,8 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
>           */
>          if (!container->initialized) {
>              if (!container->error) {
> -                container->error = ret;
> +                error_setg_errno(&container->error, -ret,
> +                                 "Memory registering failed");
>              }
>          } else {
>              hw_error("vfio: Memory registering failed, unable to continue");
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9107bd41c0..fd564209ac 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -71,7 +71,7 @@ typedef struct VFIOContainer {
>      MemoryListener listener;
>      MemoryListener prereg_listener;
>      unsigned iommu_type;
> -    int error;
> +    Error *error;
>      bool initialized;
>      unsigned long pgsizes;
>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

