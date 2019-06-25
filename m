Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB63C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24092214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24092214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiiz-0003Ye-9l
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38368)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hfiiP-00032D-RG
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hfiiO-0003oq-3E
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56270)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hfiiL-0003kE-VM
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:30:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 899CE7FD6C;
 Tue, 25 Jun 2019 10:30:02 +0000 (UTC)
Received: from work-vm (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD07019936;
 Tue, 25 Jun 2019 10:29:47 +0000 (UTC)
Date: Tue, 25 Jun 2019 11:29:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190625102945.GI3226@work-vm>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-6-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561041461-22326-6-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 25 Jun 2019 10:30:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 05/13] vfio: Add VM state change handler
 to know state of VM
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 yulei.zhang@intel.com, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, alex.williamson@redhat.com,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 yan.y.zhao@intel.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> VM state change handler gets called on change in VM's state. This is used to set
> VFIO device state to _RUNNING.
> VM state change handler, migration state change handler and log_sync listener
> are called asynchronously, which sometimes lead to data corruption in migration
> region. Initialised mutex that is used to serialize operations on migration data
> region during saving state.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>


> ---
>  hw/vfio/migration.c           | 45 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  4 ++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ba58d9253d26..15af218c23d1 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -77,6 +77,41 @@ err:
>      return ret;
>  }
>  
> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region.buffer;
> +    int ret = 0;
> +
> +    ret = pwrite(vbasedev->fd, &state, sizeof(state),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              device_state));
> +    if (ret < 0) {
> +        error_report("Failed to set migration state %d %s",
> +                     ret, strerror(errno));

Please include the device name/id in errors; it just makes it easier to
figure out the cause when someone sends me a log.

Other than that;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +        return ret;
> +    }
> +
> +    vbasedev->device_state = state;
> +    return 0;
> +}
> +
> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if ((vbasedev->vm_running != running) && running) {
> +        int ret;
> +
> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        if (ret) {
> +            error_report("Failed to set state RUNNING");
> +        }
> +    }
> +
> +    vbasedev->vm_running = running;
> +}
> +
>  static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
> @@ -91,6 +126,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
>  
> +    qemu_mutex_init(&vbasedev->migration->lock);
> +
> +    vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> +                                                          vbasedev);
> +
>      return 0;
>  }
>  
> @@ -127,11 +167,16 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
>          return;
>      }
>  
> +    if (vbasedev->vm_state) {
> +        qemu_del_vm_change_state_handler(vbasedev->vm_state);
> +    }
> +
>      if (vbasedev->migration_blocker) {
>          migrate_del_blocker(vbasedev->migration_blocker);
>          error_free(vbasedev->migration_blocker);
>      }
>  
> +    qemu_mutex_destroy(&vbasedev->migration->lock);
>      vfio_migration_region_exit(vbasedev);
>      g_free(vbasedev->migration);
>  }
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1374a03470d8..f2392e97fa57 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -29,6 +29,7 @@
>  #ifdef CONFIG_LINUX
>  #include <linux/vfio.h>
>  #endif
> +#include "sysemu/sysemu.h"
>  
>  #define VFIO_MSG_PREFIX "vfio %s: "
>  
> @@ -129,6 +130,9 @@ typedef struct VFIODevice {
>      unsigned int flags;
>      VFIOMigration *migration;
>      Error *migration_blocker;
> +    uint32_t device_state;
> +    VMChangeStateEntry *vm_state;
> +    int vm_running;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

