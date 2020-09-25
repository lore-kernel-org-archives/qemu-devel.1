Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51287C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB77A2068D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TspD3TjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB77A2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvj8-00076A-3U
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLvh1-0004E2-Ge
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLvgz-00063U-EO
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:55:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601070948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFP3LfzBncddxEYuxCiLsEPEPUjxaAXMHPE08X4pWAA=;
 b=TspD3TjAdKWd0UXH+bWoHq7IqXOvPW7qhdWE/Nn/lDcSa+V0wb0Gu4ay86QyUhRpk3NzjW
 LEZkJY8ZK0OAijY9zBxUYM75o33nLfkYLzASM9qZfGEdXCzB/LhyUF+uYg1U5qZ4MCAiuM
 tE4EiERcBp4aka+7APyTgnxl0p/hkFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-49mbhddUOPu4S3MGnf5NNQ-1; Fri, 25 Sep 2020 17:55:43 -0400
X-MC-Unique: 49mbhddUOPu4S3MGnf5NNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECCC71084C9C;
 Fri, 25 Sep 2020 21:55:40 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CAAF5C1BB;
 Fri, 25 Sep 2020 21:55:36 +0000 (UTC)
Date: Fri, 25 Sep 2020 14:20:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 07/17] vfio: Register SaveVMHandlers for VFIO device
Message-ID: <20200925142046.7c9eca89@x1.home>
In-Reply-To: <1600817059-26721-8-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-8-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 04:54:09 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Define flags to be used as delimeter in migration file stream.
> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> region from these functions at source during saving or pre-copy phase.
> Set VFIO device state depending on VM's state. During live migration, VM is
> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |  2 ++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f650fe9fc3c8..8e8adaa25779 100644
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
> @@ -25,6 +28,17 @@
>  #include "trace.h"
>  #include "hw/hw.h"
>  
> +/*
> + * Flags used as delimiter:
> + * 0xffffffff => MSB 32-bit all 1s
> + * 0xef10     => emulated (virtual) function IO
> + * 0x0000     => 16-bits reserved for flags
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +
>  static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
>                                    off_t off, bool iswrite)
>  {
> @@ -166,6 +180,65 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>      return 0;
>  }
>  
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
> +        qemu_mutex_lock_iothread();
> +        ret = vfio_region_mmap(&migration->region);
> +        qemu_mutex_unlock_iothread();

Please add a comment identifying why the iothread mutex lock is
necessary here.

> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> +                         vbasedev->name, migration->region.nr,

We don't support multiple migration regions, is it useful to include
the region index here?

> +                         strerror(-ret));
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

Again, doesn't match the function semantics that success only means the
device is in a non-error state, maybe the one that was asked for.

> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);

What's the overall purpose of writing these markers into the migration
stream?  vfio_load_state() doesn't do anything with this other than
validate that the end-of-state immediately follows.  Is this a
placeholder for something in the future?

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
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (migration->region.mmaps) {
> +        vfio_region_unmap(&migration->region);
> +    }
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
> @@ -225,6 +298,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
>      int ret = -EINVAL;
> +    char id[256] = "";
> +    Object *obj;
>  
>      if (!vbasedev->ops->vfio_get_object) {
>          return ret;
> @@ -241,6 +316,22 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
>  
> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> +
> +    if (obj) {
> +        DeviceState *dev = DEVICE(obj);
> +        char *oid = vmstate_if_get_id(VMSTATE_IF(dev));
> +
> +        if (oid) {
> +            pstrcpy(id, sizeof(id), oid);
> +            pstrcat(id, sizeof(id), "/");
> +            g_free(oid);
> +        }
> +    }

Here's where vfio_migration_init() starts using vfio_get_object() as I
referenced back on patch 04.  We might as well get the object before
calling vfio_migration_region_init() and then pass the object.  The
conditional branch to handle obj is strange here too, it's fatal if
vfio_migration_region_init() doesn't find an object, why do we handle
it as optional here?  Also, what is this doing?  Comments would be
nice...  Thanks,

Alex

> +    pstrcat(id, sizeof(id), "vfio");
> +
> +    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
> +                         vbasedev);
>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>                                                            vbasedev);
>      vbasedev->migration_state.notify = vfio_migration_state_notifier;
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index bcb3fa7314d7..982d8dccb219 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -152,3 +152,5 @@ vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
>  vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
>  vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>  vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
> +vfio_save_setup(const char *name) " (%s)"
> +vfio_save_cleanup(const char *name) " (%s)"


