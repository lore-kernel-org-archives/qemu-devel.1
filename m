Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F4C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 11:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8AA214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 11:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8AA214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWHiu-0005HZ-9u
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 07:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWHi4-0004qP-4E
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:27:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:35471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kWHi0-0001My-Vk
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 07:27:43 -0400
IronPort-SDR: IjCBYKg5TzCwp0ZPFpshlBVJpisqQvcj831+HvSR1OmqSVrp+OaswZcVEWqJm6lskezbPtbC2Y
 JOjwdEj9tYmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9783"; a="185479382"
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="185479382"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 04:27:35 -0700
IronPort-SDR: rPCaKrH2VW+dCMRLHZ/HZ/e2v2CpnXVLZtSIgZsoV60Nfftm0OAu4SmotcXuiSeKkwivrIpMMQ
 CTuNzTvqN5cQ==
X-IronPort-AV: E=Sophos;i="5.77,412,1596524400"; d="scan'208";a="534737120"
Received: from joy-optiplex-7040.sh.intel.com (HELO yzhao56-desk)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2020 04:27:29 -0700
Date: Sat, 24 Oct 2020 19:26:11 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v28 07/17] vfio: Register SaveVMHandlers for VFIO device
Message-ID: <20201024112609.GA11598@yzhao56-desk>
References: <1603449643-12851-1-git-send-email-kwankhede@nvidia.com>
 <1603449643-12851-8-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603449643-12851-8-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.88; envelope-from=yan.y.zhao@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 07:27:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 04:10:33PM +0530, Kirti Wankhede wrote:
> Define flags to be used as delimiter in migration stream for VFIO devices.
> Added .save_setup and .save_cleanup functions. Map & unmap migration
> region from these functions at source during saving or pre-copy phase.
> 
> Set VFIO device state depending on VM's state. During live migration, VM is
> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c  | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |   2 +
>  2 files changed, 104 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index a0f0e79b9b73..94d2bdae5c54 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -8,12 +8,15 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/cutils.h"
>  #include <linux/vfio.h>
>  
>  #include "sysemu/runstate.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "cpu.h"
>  #include "migration/migration.h"
> +#include "migration/vmstate.h"
>  #include "migration/qemu-file.h"
>  #include "migration/register.h"
>  #include "migration/blocker.h"
> @@ -25,6 +28,22 @@
>  #include "trace.h"
>  #include "hw/hw.h"
>  
> +/*
> + * Flags to be used as unique delimiters for VFIO devices in the migration
> + * stream. These flags are composed as:
> + * 0xffffffff => MSB 32-bit all 1s
> + * 0xef10     => Magic ID, represents emulated (virtual) function IO
> + * 0x0000     => 16-bits reserved for flags
> + *
> + * The beginning of state information is marked by _DEV_CONFIG_STATE,
> + * _DEV_SETUP_STATE, or _DEV_DATA_STATE, respectively. The end of a
> + * certain state information is marked by _END_OF_STATE.
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +
>  static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
>                                    off_t off, bool iswrite)
>  {
> @@ -129,6 +148,75 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>      return 0;
>  }
>  
> +static void vfio_migration_cleanup(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (migration->region.mmaps) {
> +        vfio_region_unmap(&migration->region);
> +    }
> +}
> +
> +/* ---------------------------------------------------------------------- */
> +
> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    trace_vfio_save_setup(vbasedev->name);
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> +
> +    if (migration->region.mmaps) {
> +        /*
> +         * Calling vfio_region_mmap() from migration thread. Memory API called
> +         * from this function require locking the iothread when called from
> +         * outside the main loop thread.
> +         */
> +        qemu_mutex_lock_iothread();
> +        ret = vfio_region_mmap(&migration->region);
> +        qemu_mutex_unlock_iothread();
> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region: %s",
> +                         vbasedev->name, strerror(-ret));
> +            error_report("%s: Falling back to slow path", vbasedev->name);
> +        }
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_MASK,
> +                                   VFIO_DEVICE_STATE_SAVING);
> +    if (ret) {
> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> +        return ret;
> +    }
> +

is it possible to call vfio_update_pending() and vfio_save_buffer() here?
so that vendor driver has a chance to hook compatibility checking string
early in save_setup stage and can avoid to hook the string in both
precopy iteration stage and stop and copy stage.

But I think it's ok if we agree to add this later.

Besides that,
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static void vfio_save_cleanup(void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    vfio_migration_cleanup(vbasedev);
> +    trace_vfio_save_cleanup(vbasedev->name);
> +}
> +
> +static SaveVMHandlers savevm_vfio_handlers = {
> +    .save_setup = vfio_save_setup,
> +    .save_cleanup = vfio_save_cleanup,
> +};
> +
> +/* ---------------------------------------------------------------------- */
> +
>  static void vfio_vmstate_change(void *opaque, int running, RunState state)
>  {
>      VFIODevice *vbasedev = opaque;
> @@ -217,6 +305,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>      int ret;
>      Object *obj;
>      VFIOMigration *migration;
> +    char id[256] = "";
> +    g_autofree char *path = NULL, *oid = NULL;
>  
>      if (!vbasedev->ops->vfio_get_object) {
>          return -EINVAL;
> @@ -247,6 +337,18 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>      }
>  
>      migration->vbasedev = vbasedev;
> +
> +    oid = vmstate_if_get_id(VMSTATE_IF(DEVICE(obj)));
> +    if (oid) {
> +        path = g_strdup_printf("%s/vfio", oid);
> +    } else {
> +        path = g_strdup("vfio");
> +    }
> +    strpadcpy(id, sizeof(id), path, '\0');
> +
> +    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
> +                         vbasedev);
> +
>      migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>                                                             vbasedev);
>      migration->migration_state.notify = vfio_migration_state_notifier;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 78d7d83b5ef8..f148b5e828c1 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -151,3 +151,5 @@ vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
>  vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
>  vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>  vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
> +vfio_save_setup(const char *name) " (%s)"
> +vfio_save_cleanup(const char *name) " (%s)"
> -- 
> 2.7.0
> 

