Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF6FC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E371B21D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE1fPU4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E371B21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLwe5-0005jt-3n
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLwdT-0005Jr-Ui
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLwdR-0004UP-EL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:56:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601074571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbVRcMww6nX5ibuWMzN+5rXuddI4POdL1RmkX8fIlRE=;
 b=AE1fPU4JDmSaM1LI4OP2aBP1GMxRvof7qFZEqbQG+F4kKqCEQ1H0l6lycs4X1U3I1AqO91
 FxENe7PSoHmztTluKsxkpRKhquwZuNSG1VruOQD5cXquc+uhpCgVjxGk2DOK/RDuieiCCY
 FdWFGjxk2+JKrrxzYphuyXH8L0t7gyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-eCtvzbxOObK8QxznVbMrjA-1; Fri, 25 Sep 2020 18:56:05 -0400
X-MC-Unique: eCtvzbxOObK8QxznVbMrjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 708911084D76;
 Fri, 25 Sep 2020 22:56:02 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 912951002C24;
 Fri, 25 Sep 2020 22:55:57 +0000 (UTC)
Date: Fri, 25 Sep 2020 16:55:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 17/17] qapi: Add VFIO devices migration stats in
 Migration stats
Message-ID: <20200925165556.4aa09aff@x1.home>
In-Reply-To: <1600817059-26721-18-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-18-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
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

On Wed, 23 Sep 2020 04:54:19 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Added amount of bytes transferred to the target VM by all VFIO devices
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> ---
> 
> Note: Comments from v25 for this patch are not addressed yet.
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg715620.html
> 
> Alex, need more pointer on documentation part raised Markus Armbruster.

I'm not sure what you're asking of me here.  Are we being asked to
justify that a vfio device has state that needs to be migrated and the
ability to dirty pages?
 
> 
>  hw/vfio/common.c            | 20 ++++++++++++++++++++
>  hw/vfio/migration.c         | 10 ++++++++++
>  include/qemu/vfio-helpers.h |  3 +++
>  migration/migration.c       | 14 ++++++++++++++
>  monitor/hmp-cmds.c          |  6 ++++++
>  qapi/migration.json         | 17 +++++++++++++++++
>  6 files changed, 70 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7eeaa368187a..286cdaac8674 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -39,6 +39,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/migration.h"
> +#include "qemu/vfio-helpers.h"
>  
>  VFIOGroupList vfio_group_list =
>      QLIST_HEAD_INITIALIZER(vfio_group_list);
> @@ -292,6 +293,25 @@ const MemoryRegionOps vfio_region_ops = {
>   * Device state interfaces
>   */
>  
> +bool vfio_mig_active(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    if (QLIST_EMPTY(&vfio_group_list)) {
> +        return false;
> +    }
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if (vbasedev->migration_blocker) {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
>  static bool vfio_devices_all_stopped_and_saving(VFIOContainer *container)
>  {
>      VFIOGroup *group;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 822b68b4e015..c4226fa8b183 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -28,6 +28,7 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "hw/hw.h"
> +#include "qemu/vfio-helpers.h"
>  
>  /*
>   * Flags used as delimiter:
> @@ -40,6 +41,8 @@
>  #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
>  #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
>  
> +static int64_t bytes_transferred;
> +
>  static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
>                                    off_t off, bool iswrite)
>  {
> @@ -289,6 +292,7 @@ static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev, uint64_t *size)
>          *size = data_size;
>      }
>  
> +    bytes_transferred += data_size;
>      return ret;
>  }
>  
> @@ -770,6 +774,7 @@ static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>          }
>  
>          vfio_set_dirty_page_tracking(vbasedev, false);
> +        bytes_transferred = 0;
>      }
>  }
>  
> @@ -820,6 +825,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>  
>  /* ---------------------------------------------------------------------- */
>  
> +int64_t vfio_mig_bytes_transferred(void)
> +{
> +    return bytes_transferred;
> +}
> +
>  int vfio_migration_probe(VFIODevice *vbasedev, Error **errp)
>  {
>      VFIOContainer *container = vbasedev->group->container;
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 1f057c2b9e40..26a7df0767b1 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -29,4 +29,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>  int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>                             int irq_type, Error **errp);
>  
> +bool vfio_mig_active(void);
> +int64_t vfio_mig_bytes_transferred(void);
> +
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 58a5452471f9..b204bb1f6cd9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -56,6 +56,7 @@
>  #include "net/announce.h"
>  #include "qemu/queue.h"
>  #include "multifd.h"
> +#include "qemu/vfio-helpers.h"
>  
>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>  
> @@ -996,6 +997,17 @@ static void populate_disk_info(MigrationInfo *info)
>      }
>  }
>  
> +static void populate_vfio_info(MigrationInfo *info)
> +{
> +#ifdef CONFIG_LINUX
> +    if (vfio_mig_active()) {
> +        info->has_vfio = true;
> +        info->vfio = g_malloc0(sizeof(*info->vfio));
> +        info->vfio->transferred = vfio_mig_bytes_transferred();
> +    }
> +#endif
> +}
> +
>  static void fill_source_migration_info(MigrationInfo *info)
>  {
>      MigrationState *s = migrate_get_current();
> @@ -1020,6 +1032,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
>          populate_disk_info(info);
> +        populate_vfio_info(info);
>          break;
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
> @@ -1028,6 +1041,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_COMPLETED:
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
> +        populate_vfio_info(info);
>          break;
>      case MIGRATION_STATUS_FAILED:
>          info->has_status = true;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 7711726fd222..40d60d6a6651 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -355,6 +355,12 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          }
>          monitor_printf(mon, "]\n");
>      }
> +
> +    if (info->has_vfio) {
> +        monitor_printf(mon, "vfio device transferred: %" PRIu64 " kbytes\n",
> +                       info->vfio->transferred >> 10);
> +    }
> +
>      qapi_free_MigrationInfo(info);
>  }
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 675f70bb6734..3535977123d3 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -147,6 +147,18 @@
>              'active', 'postcopy-active', 'postcopy-paused',
>              'postcopy-recover', 'completed', 'failed', 'colo',
>              'pre-switchover', 'device', 'wait-unplug' ] }
> +##
> +# @VfioStats:
> +#
> +# Detailed VFIO devices migration statistics
> +#
> +# @transferred: amount of bytes transferred to the target VM by VFIO devices
> +#
> +# Since: 5.1
> +#
> +##
> +{ 'struct': 'VfioStats',
> +  'data': {'transferred': 'int' } }
>  
>  ##
>  # @MigrationInfo:
> @@ -208,11 +220,16 @@
>  #
>  # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
>  #
> +# @vfio: @VfioStats containing detailed VFIO devices migration statistics,
> +#        only returned if VFIO device is present, migration is supported by all
> +#         VFIO devices and status is 'active' or 'completed' (since 5.1)

This could be clarified a little:

...only returned if all VFIO devices attached to a VM support migration
and migration status is 'active' or 'completed' (since 5.2)

Is that accurate?  Thanks,

Alex

> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationInfo',
>    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
>             '*disk': 'MigrationStats',
> +           '*vfio': 'VfioStats',
>             '*xbzrle-cache': 'XBZRLECacheStats',
>             '*total-time': 'int',
>             '*expected-downtime': 'int',


