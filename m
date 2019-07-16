Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FB2C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EE7206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EE7206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnV8T-0007Ww-LO
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hnV8I-00075x-1z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hnV8G-0000Xc-KW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:37:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hnV8G-0000X3-CY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:37:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AD2B309174E;
 Tue, 16 Jul 2019 21:37:07 +0000 (UTC)
Received: from x1.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2843A5D721;
 Tue, 16 Jul 2019 21:37:06 +0000 (UTC)
Date: Tue, 16 Jul 2019 15:37:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190716153705.599be852@x1.home>
In-Reply-To: <1562665760-26158-6-git-send-email-kwankhede@nvidia.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-6-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 16 Jul 2019 21:37:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 05/13] vfio: Add migration region
 initialization and finalize function
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 15:19:12 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Migration functions are implemented for VFIO_DEVICE_TYPE_PCI device in this
>   patch series.
> - VFIO device supports migration or not is decided based of migration region
>   query. If migration region query is successful and migration region
>   initialization is successful then migration is supported else migration is
>   blocked.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/migration.c           | 145 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |   3 +
>  include/hw/vfio/vfio-common.h |  14 ++++
>  4 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 hw/vfio/migration.c
> 
> diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
> index abad8b818c9b..36033d1437c5 100644
> --- a/hw/vfio/Makefile.objs
> +++ b/hw/vfio/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += common.o spapr.o
> +obj-y += common.o spapr.o migration.o
>  obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
>  obj-$(CONFIG_VFIO_CCW) += ccw.o
>  obj-$(CONFIG_VFIO_PLATFORM) += platform.o
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> new file mode 100644
> index 000000000000..a2cfbd5af2e1
> --- /dev/null
> +++ b/hw/vfio/migration.c
> @@ -0,0 +1,145 @@
> +/*
> + * Migration support for VFIO devices
> + *
> + * Copyright NVIDIA, Inc. 2019
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vfio.h>
> +
> +#include "hw/vfio/vfio-common.h"
> +#include "cpu.h"
> +#include "migration/migration.h"
> +#include "migration/qemu-file.h"
> +#include "migration/register.h"
> +#include "migration/blocker.h"
> +#include "migration/misc.h"
> +#include "qapi/error.h"
> +#include "exec/ramlist.h"
> +#include "exec/ram_addr.h"
> +#include "pci.h"
> +#include "trace.h"
> +
> +static void vfio_migration_region_exit(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (!migration) {
> +        return;
> +    }
> +
> +    if (migration->region.buffer.size) {

Having a VFIORegion named buffer within a struct named region is
unnecessarily confusing.  Please fix.

> +        vfio_region_exit(&migration->region.buffer);
> +        vfio_region_finalize(&migration->region.buffer);
> +    }
> +}
> +
> +static int vfio_migration_region_init(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    Object *obj = NULL;
> +    int ret = -EINVAL;
> +
> +    if (!migration) {
> +        return ret;
> +    }
> +
> +    if (!vbasedev->ops || !vbasedev->ops->vfio_get_object) {
> +        return ret;
> +    }
> +
> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> +    if (!obj) {
> +        return ret;
> +    }
> +
> +    ret = vfio_region_setup(obj, vbasedev, &migration->region.buffer,
> +                            migration->region.index, "migration");
> +    if (ret) {
> +        error_report("%s: Failed to setup VFIO migration region %d: %s",
> +                     vbasedev->name, migration->region.index, strerror(-ret));
> +        goto err;
> +    }
> +
> +    if (!migration->region.buffer.size) {
> +        ret = -EINVAL;
> +        error_report("%s: Invalid region size of VFIO migration region %d: %s",
> +                     vbasedev->name, migration->region.index, strerror(-ret));
> +        goto err;
> +    }
> +
> +    return 0;
> +
> +err:
> +    vfio_migration_region_exit(vbasedev);
> +    return ret;
> +}
> +
> +static int vfio_migration_init(VFIODevice *vbasedev,
> +                               struct vfio_region_info *info)
> +{
> +    int ret;
> +
> +    vbasedev->migration = g_new0(VFIOMigration, 1);
> +    vbasedev->migration->region.index = info->index;

VFIORegion already caches the region index, VFIORegion.nr.

> +
> +    ret = vfio_migration_region_init(vbasedev);
> +    if (ret) {
> +        error_report("%s: Failed to initialise migration region",
> +                     vbasedev->name);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/* ---------------------------------------------------------------------- */
> +
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_region_info *info;
> +    Error *local_err = NULL;
> +    int ret;
> +
> +    ret = vfio_get_dev_region_info(vbasedev, VFIO_REGION_TYPE_MIGRATION,
> +                                   VFIO_REGION_SUBTYPE_MIGRATION, &info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    ret = vfio_migration_init(vbasedev, info);
> +    if (ret) {
> +        goto add_blocker;
> +    }
> +
> +    trace_vfio_migration_probe(vbasedev->name, info->index);
> +    return 0;
> +
> +add_blocker:
> +    error_setg(&vbasedev->migration_blocker,
> +               "VFIO device doesn't support migration"); 
> +    ret = migrate_add_blocker(vbasedev->migration_blocker, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_free(vbasedev->migration_blocker);
> +    }
> +    return ret;
> +}
> +
> +void vfio_migration_finalize(VFIODevice *vbasedev)
> +{
> +    if (!vbasedev->migration) {
> +        return;

Don't we allocate migration_blocker even for this case?  Thanks,

Alex

> +    }
> +
> +    if (vbasedev->migration_blocker) {
> +        migrate_del_blocker(vbasedev->migration_blocker);
> +        error_free(vbasedev->migration_blocker);
> +    }
> +
> +    vfio_migration_region_exit(vbasedev);
> +    g_free(vbasedev->migration);
> +}
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 8cdc27946cb8..191a726a1312 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -143,3 +143,6 @@ vfio_display_edid_link_up(void) ""
>  vfio_display_edid_link_down(void) ""
>  vfio_display_edid_update(uint32_t prefx, uint32_t prefy) "%ux%u"
>  vfio_display_edid_write_error(void) ""
> +
> +# migration.c
> +vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ee72bd984a36..152da3f8d6f3 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -57,6 +57,15 @@ typedef struct VFIORegion {
>      uint8_t nr; /* cache the region number for debug */
>  } VFIORegion;
>  
> +typedef struct VFIOMigration {
> +    struct {
> +        VFIORegion buffer;
> +        uint32_t index;
> +    } region;
> +    uint64_t pending_bytes;
> +    QemuMutex lock;
> +} VFIOMigration;
> +
>  typedef struct VFIOAddressSpace {
>      AddressSpace *as;
>      QLIST_HEAD(, VFIOContainer) containers;
> @@ -113,6 +122,8 @@ typedef struct VFIODevice {
>      unsigned int num_irqs;
>      unsigned int num_regions;
>      unsigned int flags;
> +    VFIOMigration *migration;
> +    Error *migration_blocker;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> @@ -204,4 +215,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
>  
> +int vfio_migration_probe(VFIODevice *vbasedev, Error **errp);
> +void vfio_migration_finalize(VFIODevice *vbasedev);
> +
>  #endif /* HW_VFIO_VFIO_COMMON_H */


