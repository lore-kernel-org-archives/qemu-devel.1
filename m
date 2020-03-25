Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E9DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 22:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9555720658
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 22:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FeH1XFYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9555720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHEep-0000zt-PG
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 18:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jHEeB-0000av-6k
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 18:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jHEe5-0001Iv-Ll
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 18:37:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jHEe5-0001H6-Fd
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 18:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585175828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf+pdESrnrcgeQRXWaN2cqN9qgJ+5Ip41c1789mp0z8=;
 b=FeH1XFYMUEL8l3xPx09YF4MQRg+o//J+jP0QCwAJFiRDMMw6peAjMg3ffTpYZPgBON4Xn+
 oKvrqbzqhFGprGHkUhgYIYC8oXLm3/yag9gDIEESxU3S+hnd4/OSG2uEAMOTK1szwpxSFj
 ZWL/0umCBe930h1wubbYx+vvOxfirPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-tR_R8STlPcOgG5eU8bFDEA-1; Wed, 25 Mar 2020 18:37:03 -0400
X-MC-Unique: tR_R8STlPcOgG5eU8bFDEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2325477;
 Wed, 25 Mar 2020 22:37:00 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEF4090A13;
 Wed, 25 Mar 2020 22:36:58 +0000 (UTC)
Date: Wed, 25 Mar 2020 16:36:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 10/16] vfio: Add load state functions to
 SaveVMHandlers
Message-ID: <20200325163658.71e88cb8@w520.home>
In-Reply-To: <1585084154-29461-11-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-11-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Wed, 25 Mar 2020 02:39:08 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Sequence  during _RESUMING device state:
> While data for this device is available, repeat below steps:
> a. read data_offset from where user application should write data.
> b. write data of data_size to migration region from data_offset.
> c. write data_size which indicates vendor driver that data is written in
>    staging buffer.
> 
> For user, data is opaque. User should write data in the same order as
> received.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c  | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |   3 +
>  2 files changed, 182 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ecbeed5182c2..ab295d25620e 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -269,6 +269,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
>      return qemu_file_get_error(f);
>  }
>  
> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    uint64_t data;
> +
> +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
> +        int ret;
> +
> +        ret = vbasedev->ops->vfio_load_config(vbasedev, f);
> +        if (ret) {
> +            error_report("%s: Failed to load device config space",
> +                         vbasedev->name);
> +            return ret;
> +        }
> +    }
> +
> +    data = qemu_get_be64(f);
> +    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
> +        error_report("%s: Failed loading device config space, "
> +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
> +        return -EINVAL;
> +    }
> +
> +    trace_vfio_load_device_config_state(vbasedev->name);
> +    return qemu_file_get_error(f);
> +}
> +
>  /* ---------------------------------------------------------------------- */
>  
>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> @@ -434,12 +461,164 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>      return ret;
>  }
>  
> +static int vfio_load_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret = 0;
> +
> +    if (migration->region.mmaps) {
> +        ret = vfio_region_mmap(&migration->region);
> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> +                         vbasedev->name, migration->region.nr,
> +                         strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_RESUMING);

This seems very prone to making an invalid state, like _RUNNING |
_RESUMING.  Why wouldn't we use ~VFIO_DEVICE_STATE_MASK here?

> +    if (ret) {
> +        error_report("%s: Failed to set state RESUMING", vbasedev->name);
> +    }
> +    return ret;
> +}
> +
> +static int vfio_load_cleanup(void *opaque)
> +{
> +    vfio_save_cleanup(opaque);
> +    return 0;
> +}
> +
> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret = 0;
> +    uint64_t data, data_size;
> +
> +    data = qemu_get_be64(f);
> +    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
> +
> +        trace_vfio_load_state(vbasedev->name, data);
> +
> +        switch (data) {
> +        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
> +        {
> +            ret = vfio_load_device_config_state(f, opaque);
> +            if (ret) {
> +                return ret;
> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> +        {
> +            uint64_t region_size = qemu_get_be64(f);
> +
> +            if (migration->region.size < region_size) {
> +                error_report("%s: SETUP STATE: migration region too small, "
> +                             "0x%"PRIx64 " < 0x%"PRIx64, vbasedev->name,
> +                             migration->region.size, region_size);
> +                return -EINVAL;
> +            }
> +
> +            data = qemu_get_be64(f);
> +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
> +                return ret;
> +            } else {
> +                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
> +                             vbasedev->name, data);
> +                return -EINVAL;
> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
> +        {
> +            VFIORegion *region = &migration->region;
> +            void *buf = NULL;
> +            bool buffer_mmaped = false;
> +            uint64_t data_offset = 0;
> +
> +            data_size = qemu_get_be64(f);
> +            if (data_size == 0) {
> +                break;
> +            }
> +
> +            ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> +                        region->fd_offset +
> +                        offsetof(struct vfio_device_migration_info,
> +                        data_offset));
> +            if (ret != sizeof(data_offset)) {
> +                error_report("%s:Failed to get migration buffer data offset %d",
> +                             vbasedev->name, ret);
> +                return -EINVAL;
> +            }
> +
> +            if (region->mmaps) {
> +                buf = find_data_region(region, data_offset, data_size);
> +            }
> +
> +            buffer_mmaped = (buf != NULL) ? true : false;
> +
> +            if (!buffer_mmaped) {
> +                buf = g_try_malloc0(data_size);
> +                if (!buf) {
> +                    error_report("%s: Error allocating buffer ", __func__);
> +                    return -ENOMEM;
> +                }
> +            }
> +
> +            qemu_get_buffer(f, buf, data_size);
> +
> +            if (!buffer_mmaped) {
> +                ret = pwrite(vbasedev->fd, buf, data_size,
> +                             region->fd_offset + data_offset);
> +                g_free(buf);
> +
> +                if (ret != data_size) {
> +                    error_report("%s: Failed to set migration buffer %d",
> +                                 vbasedev->name, ret);
> +                    return -EINVAL;
> +                }
> +            }
> +
> +            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
> +                         region->fd_offset +
> +                       offsetof(struct vfio_device_migration_info, data_size));
> +            if (ret != sizeof(data_size)) {
> +                error_report("%s: Failed to set migration buffer data size %d",
> +                             vbasedev->name, ret);
> +                if (!buffer_mmaped) {
> +                    g_free(buf);
> +                }
> +                return -EINVAL;
> +            }
> +
> +            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
> +                                              data_size);
> +            break;
> +        }
> +        }
> +
> +        ret = qemu_file_get_error(f);
> +        if (ret) {
> +            return ret;
> +        }
> +        data = qemu_get_be64(f);
> +    }
> +
> +    return ret;
> +}
> +
>  static SaveVMHandlers savevm_vfio_handlers = {
>      .save_setup = vfio_save_setup,
>      .save_cleanup = vfio_save_cleanup,
>      .save_live_pending = vfio_save_pending,
>      .save_live_iterate = vfio_save_iterate,
>      .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .load_setup = vfio_load_setup,
> +    .load_cleanup = vfio_load_cleanup,
> +    .load_state = vfio_load_state,
>  };
>  
>  /* ---------------------------------------------------------------------- */
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index bdf40ba368c7..ac065b559f4e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -157,3 +157,6 @@ vfio_save_device_config_state(char *name) " (%s)"
>  vfio_save_pending(char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
>  vfio_save_iterate(char *name, int data_size) " (%s) data_size %d"
>  vfio_save_complete_precopy(char *name) " (%s)"
> +vfio_load_device_config_state(char *name) " (%s)"
> +vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
> +vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64


