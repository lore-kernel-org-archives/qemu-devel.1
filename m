Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0FCC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DE02083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DE02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgRHA-0003bE-8j
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43778)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hgREs-00036w-Pu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hgREr-0002oj-Dn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:02:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hgREr-0002gQ-4O
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C360213AAE;
 Thu, 27 Jun 2019 10:02:14 +0000 (UTC)
Received: from work-vm (ovpn-117-111.ams2.redhat.com [10.36.117.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77D175C237;
 Thu, 27 Jun 2019 10:01:59 +0000 (UTC)
Date: Thu, 27 Jun 2019 11:01:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190627100157.GC2751@work-vm>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-8-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561041461-22326-8-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 27 Jun 2019 10:02:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 07/13] vfio: Register SaveVMHandlers for
 VFIO device
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
>  hw/vfio/migration.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 7f9858e6c995..fe0887c27664 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -22,6 +22,17 @@
>  #include "exec/ram_addr.h"
>  #include "pci.h"
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
>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
> @@ -96,6 +107,69 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t state)
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
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> +
> +    if (migration->region.buffer.mmaps) {
> +        qemu_mutex_lock_iothread();
> +        ret = vfio_region_mmap(&migration->region.buffer);
> +        qemu_mutex_unlock_iothread();
> +        if (ret) {
> +            error_report("Failed to mmap VFIO migration region %d: %s",
> +                         migration->region.index, strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    if (vbasedev->vm_running) {
> +        ret = vfio_migration_set_state(vbasedev,
> +                         VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
> +        if (ret) {
> +            error_report("Failed to set state RUNNING and SAVING");
> +            return ret;
> +        }
> +    } else {
> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING);
> +        if (ret) {
> +            error_report("Failed to set state STOP and SAVING");
> +            return ret;
> +        }
> +    }
> +
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
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (migration->region.buffer.mmaps) {
> +        vfio_region_unmap(&migration->region.buffer);
> +    }
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
> @@ -169,7 +243,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>      }
>  
>      qemu_mutex_init(&vbasedev->migration->lock);
> -
> +    register_savevm_live(NULL, "vfio", -1, 1, &savevm_vfio_handlers, vbasedev);

Does this work OK with multiple devices?
I think I'd expected you to pass a DeviceState as the first parameter
for a real device like vfio.
'ram' and 'block' don't need to because they iterate over all RAM
devices inside their save_setup's and similar handlers;  for vfio I'd
expect it to be per-device.

Dave

>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>                                                            vbasedev);
>  
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

