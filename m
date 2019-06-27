Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E27C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6064E2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6064E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgRmb-0000xC-Mu
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50569)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hgRie-0006Fh-8y
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hgRic-0000nz-7T
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:33:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hgRiY-0000il-0q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:33:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CA0DC057F4B;
 Thu, 27 Jun 2019 10:33:15 +0000 (UTC)
Received: from work-vm (ovpn-117-111.ams2.redhat.com [10.36.117.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77ECF5D71B;
 Thu, 27 Jun 2019 10:33:03 +0000 (UTC)
Date: Thu, 27 Jun 2019 11:33:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190627103301.GD2751@work-vm>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-7-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561041461-22326-7-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 27 Jun 2019 10:33:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 06/13] vfio: Add migration state change
 notifier
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
> Added migration state change notifier to get notification on migration state
> change. These states are translated to VFIO device state and conveyed to vendor
> driver.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>

Just a general thought; be careful when following migration states;
For example 'device' and 'pre_switchover' - just be careful to think
about all the different states and how you might get a 'failed'
anywhere.

Dave
> ---
>  hw/vfio/migration.c           | 49 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |  1 +
>  2 files changed, 50 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 15af218c23d1..7f9858e6c995 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -112,6 +112,48 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
>      vbasedev->vm_running = running;
>  }
>  
> +static void vfio_migration_state_notifier(Notifier *notifier, void *data)
> +{
> +    MigrationState *s = data;
> +    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
> +    int ret;
> +
> +    switch (s->state) {
> +    case MIGRATION_STATUS_ACTIVE:
> +        if (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING) {
> +            if (vbasedev->vm_running) {
> +                ret = vfio_migration_set_state(vbasedev,
> +                          VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING);
> +                if (ret) {
> +                    error_report("Failed to set state RUNNING and SAVING");
> +                }
> +            } else {
> +                ret = vfio_migration_set_state(vbasedev,
> +                                               VFIO_DEVICE_STATE_SAVING);
> +                if (ret) {
> +                    error_report("Failed to set state STOP and SAVING");
> +                }
> +            }
> +        } else {
> +            ret = vfio_migration_set_state(vbasedev,
> +                                           VFIO_DEVICE_STATE_RESUMING);
> +            if (ret) {
> +                error_report("Failed to set state RESUMING");
> +            }
> +        }
> +        return;
> +
> +    case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_CANCELLED:
> +    case MIGRATION_STATUS_FAILED:
> +        ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RUNNING);
> +        if (ret) {
> +            error_report("Failed to set state RUNNING");
> +        }
> +        return;
> +    }
> +}
> +
>  static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
> @@ -131,6 +173,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>                                                            vbasedev);
>  
> +    vbasedev->migration_state.notify = vfio_migration_state_notifier;
> +    add_migration_state_change_notifier(&vbasedev->migration_state);
> +
>      return 0;
>  }
>  
> @@ -167,6 +212,10 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
>          return;
>      }
>  
> +    if (vbasedev->migration_state.notify) {
> +        remove_migration_state_change_notifier(&vbasedev->migration_state);
> +    }
> +
>      if (vbasedev->vm_state) {
>          qemu_del_vm_change_state_handler(vbasedev->vm_state);
>      }
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index f2392e97fa57..1d26e6be8d48 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,6 +133,7 @@ typedef struct VFIODevice {
>      uint32_t device_state;
>      VMChangeStateEntry *vm_state;
>      int vm_running;
> +    Notifier migration_state;
>  } VFIODevice;
>  
>  struct VFIODeviceOps {
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

