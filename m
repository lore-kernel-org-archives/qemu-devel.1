Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B6EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88F620836
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8ZyZH/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88F620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joAfv-0006jO-U0
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAc8-0000WA-S3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1joAc6-0004F3-QA
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 14:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593025154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cGSJn7xLfgbAPmxylpqu35ue26irq8u+DNThBF0BAm4=;
 b=C8ZyZH/lJQ9ew6aYmlsBvMaxKt1vQzEaH174vIBrTUglTQ7DJJsGk8NJDulBsUP8K3o95H
 4umK02fvl6vUNx9hmbauqZ9N5VzR5OgbcE7Y4CDD5PiPeohJGclDU9WCd9tHqlCJqv/ur2
 mAX+jq5V7mvy1fqItSXNw0rwqXG/hs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-1ZGyoQXVNrKkh4pjq0_R6w-1; Wed, 24 Jun 2020 14:59:05 -0400
X-MC-Unique: 1ZGyoQXVNrKkh4pjq0_R6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BCC7107ACCA;
 Wed, 24 Jun 2020 18:59:03 +0000 (UTC)
Received: from x1.home (ovpn-112-156.phx2.redhat.com [10.3.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EDD460F8A;
 Wed, 24 Jun 2020 18:59:01 +0000 (UTC)
Date: Wed, 24 Jun 2020 12:54:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 09/17] vfio: Add load state functions to
 SaveVMHandlers
Message-ID: <20200624125437.664869ce@x1.home>
In-Reply-To: <1592684486-18511-10-git-send-email-kwankhede@nvidia.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-10-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Sun, 21 Jun 2020 01:51:18 +0530
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
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/vfio/migration.c  | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |   3 +
>  2 files changed, 180 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index ef1150c1ff02..faacea5327cb 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -302,6 +302,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
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
> @@ -472,12 +499,162 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
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


Not fatal.


> +        }
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, ~VFIO_DEVICE_STATE_MASK,
> +                                   VFIO_DEVICE_STATE_RESUMING);
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
> +            data = qemu_get_be64(f);
> +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
> +                return ret;
> +            } else {
> +                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
> +                             vbasedev->name, data);
> +                return -EINVAL;

This is essentially just a compatibility failure, right?  For instance
some future version of QEMU might include additional data between these
markers that we don't understand and therefore we fail the migration.
Thanks,

Alex

> +            }
> +            break;
> +        }
> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
> +        {
> +            VFIORegion *region = &migration->region;
> +            uint64_t data_offset = 0, size;
> +
> +            data_size = size = qemu_get_be64(f);
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
> +            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
> +                                              data_size);
> +
> +            while (size) {
> +                void *buf = NULL;
> +                uint64_t sec_size;
> +                bool buffer_mmaped;
> +
> +                buf = get_data_section_size(region, data_offset, size,
> +                                            &sec_size);
> +
> +                buffer_mmaped = (buf != NULL);
> +
> +                if (!buffer_mmaped) {
> +                    buf = g_try_malloc(sec_size);
> +                    if (!buf) {
> +                        error_report("%s: Error allocating buffer ", __func__);
> +                        return -ENOMEM;
> +                    }
> +                }
> +
> +                qemu_get_buffer(f, buf, sec_size);
> +
> +                if (!buffer_mmaped) {
> +                    ret = pwrite(vbasedev->fd, buf, sec_size,
> +                                 region->fd_offset + data_offset);
> +                    g_free(buf);
> +
> +                    if (ret != sec_size) {
> +                        error_report("%s: Failed to set migration buffer %d",
> +                                vbasedev->name, ret);
> +                        return -EINVAL;
> +                    }
> +                }
> +                size -= sec_size;
> +                data_offset += sec_size;
> +            }
> +
> +            ret = pwrite(vbasedev->fd, &data_size, sizeof(data_size),
> +                         region->fd_offset +
> +                       offsetof(struct vfio_device_migration_info, data_size));
> +            if (ret != sizeof(data_size)) {
> +                error_report("%s: Failed to set migration buffer data size %d",
> +                             vbasedev->name, ret);
> +                return -EINVAL;
> +            }
> +            break;
> +        }
> +
> +        default:
> +            error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
> +            return -EINVAL;
> +        }
> +
> +        data = qemu_get_be64(f);
> +        ret = qemu_file_get_error(f);
> +        if (ret) {
> +            return ret;
> +        }
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
> index 9a1c5e17d97f..4a4bd3ba9a2a 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -157,3 +157,6 @@ vfio_save_device_config_state(const char *name) " (%s)"
>  vfio_save_pending(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t compatible) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" compatible 0x%"PRIx64
>  vfio_save_iterate(const char *name, int data_size) " (%s) data_size %d"
>  vfio_save_complete_precopy(const char *name) " (%s)"
> +vfio_load_device_config_state(const char *name) " (%s)"
> +vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
> +vfio_load_state_device_data(const char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64


