Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F1AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5089322242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoImGANc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5089322242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUufz-000160-84
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUuSb-0002e1-0U
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUuSV-0007bs-MO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603211153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrwutcZjdleYUH/m4Q/XzbDqHVGY42CIZ3t5X3tvPoE=;
 b=KoImGANckGgq0iz3c8jwe2V1IMXMasqIg1Lbj1iGol5RNsUtUn9Vjut4JRZIaSWPsw31a/
 TWzQo3bQDeHMFzM/MtNyESNJzj2bMc9YQGEcQxU5NHMh9bbJsT5h2PrXCvn4Z+/CNouAPS
 b9jamKdWQsm8vS3zxw6+T512XmaND4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-CKYHyv7tO1ylex36dlCJoQ-1; Tue, 20 Oct 2020 12:25:49 -0400
X-MC-Unique: CKYHyv7tO1ylex36dlCJoQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63E461084C87;
 Tue, 20 Oct 2020 16:25:47 +0000 (UTC)
Received: from gondolin (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7E2527CC8;
 Tue, 20 Oct 2020 16:25:35 +0000 (UTC)
Date: Tue, 20 Oct 2020 18:25:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 09/17] vfio: Add load state functions to SaveVMHandlers
Message-ID: <20201020182532.76b544b6.cohuck@redhat.com>
In-Reply-To: <5ca09cd6-efd6-ed8d-277f-5a1b42b5835c@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-10-git-send-email-kwankhede@nvidia.com>
 <20201001120730.36eb76dd.cohuck@redhat.com>
 <5ca09cd6-efd6-ed8d-277f-5a1b42b5835c@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 02:17:43 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 10/1/2020 3:37 PM, Cornelia Huck wrote:
> > On Wed, 23 Sep 2020 04:54:11 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> Sequence  during _RESUMING device state:
> >> While data for this device is available, repeat below steps:
> >> a. read data_offset from where user application should write data.
> >> b. write data of data_size to migration region from data_offset.
> >> c. write data_size which indicates vendor driver that data is written in
> >>     staging buffer.
> >>
> >> For user, data is opaque. User should write data in the same order as
> >> received.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> ---
> >>   hw/vfio/migration.c  | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   hw/vfio/trace-events |   3 +
> >>   2 files changed, 173 insertions(+)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index 4611bb972228..ffd70282dd0e 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -328,6 +328,33 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> >>       return qemu_file_get_error(f);
> >>   }
> >>   
> >> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +    uint64_t data;
> >> +
> >> +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
> >> +        int ret;
> >> +
> >> +        ret = vbasedev->ops->vfio_load_config(vbasedev, f);
> >> +        if (ret) {
> >> +            error_report("%s: Failed to load device config space",
> >> +                         vbasedev->name);
> >> +            return ret;
> >> +        }
> >> +    }
> >> +
> >> +    data = qemu_get_be64(f);
> >> +    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
> >> +        error_report("%s: Failed loading device config space, "
> >> +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);  
> > 
> > I'm confused here: If we don't have a vfio_load_config callback, or if
> > that callback did not read everything, we also might end up with a
> > value that's not END_OF_STATE... in that case, the problem is not with
> > the stream, but rather with the consumer?  
> 
> Right, hence "end flag incorrect" is reported.

Yes, but that's what I find confusing... a missing or incorrect
vfio_load_config callback does not have anything to do with incorrect
end flags as present in the stream, but with the consumer not reading
things correctly. If I got this error, I would go looking whether
there's anything wrong with the stream and the code that produced it,
and that's the wrong direction.

(...)

> >> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    int ret = 0;
> >> +    uint64_t data, data_size;
> >> +
> >> +    data = qemu_get_be64(f);
> >> +    while (data != VFIO_MIG_FLAG_END_OF_STATE) {
> >> +
> >> +        trace_vfio_load_state(vbasedev->name, data);
> >> +
> >> +        switch (data) {
> >> +        case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
> >> +        {
> >> +            ret = vfio_load_device_config_state(f, opaque);
> >> +            if (ret) {
> >> +                return ret;
> >> +            }
> >> +            break;
> >> +        }
> >> +        case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> >> +        {
> >> +            data = qemu_get_be64(f);
> >> +            if (data == VFIO_MIG_FLAG_END_OF_STATE) {
> >> +                return ret;
> >> +            } else {
> >> +                error_report("%s: SETUP STATE: EOS not found 0x%"PRIx64,
> >> +                             vbasedev->name, data);
> >> +                return -EINVAL;
> >> +            }
> >> +            break;
> >> +        }
> >> +        case VFIO_MIG_FLAG_DEV_DATA_STATE:
> >> +        {
> >> +            VFIORegion *region = &migration->region;
> >> +            uint64_t data_offset = 0, size;  
> > 
> > I think this function would benefit from splitting this off into a
> > function handling DEV_DATA_STATE. It is quite hard to follow through
> > all the checks and find out when we continue, and when we break off.
> >   
> 
> Each switch case has a break, we break off on success cases, where as we 
> return error if we encounter any case where (ret < 0)

Of course, but I don't find it easy to follow when the errors are
happening.

> 
> 
> > Some documentation about the markers would also be really helpful.  
> 
> Sure adding it in patch 07, where these are defined.
> 
> > The logic seems to be:
> > - DEV_CONFIG_STATE has config data and must be ended by END_OF_STATE  
> Right
> 
> > - DEV_SETUP_STATE has only END_OF_STATE, no data  
> Right now there is no data, but this is provision to add data if 
> required in future.
> 
> > - DEV_DATA_STATE has... data; if there's any END_OF_STATE, it's buried
> >    far down in the called functions
> >  
> 
> This is not correct, END_OF_STATE is after data. Moved data buffer 
> loading logic to function vfio_load_buffer(), so DEV_DATA_STATE looks 
> simplified as below. Hope this helps.
> 
>          case VFIO_MIG_FLAG_DEV_DATA_STATE:
>          {
>              uint64_t data_size;
> 
>              data_size = qemu_get_be64(f);
>              if (data_size == 0) {
>                  break;
>              }
> 
>              ret = vfio_load_buffer(f, vbasedev, data_size);
>              if (ret < 0) {
>                  return ret;
>              }
>              break;
>          }

Hm.

What I find not that easy to follow is the structure here:

while (!end_marker) {
    switch (data) {
    case config_state:
        if (load_config)
            return error;
        break;
    case setup_state:
        read_next_value();
        if (end_marker)
            return 0;
        else
            return error;
        break;
    case data_state:
        size = read_next_value();
        if (!size)
            break;
        if (vfio_load_buffer())
            return error;
        break;
    default:
        return error;
    }
    read_next_value();
    if (qemu_file_get_error())
        return error;
}

So, what I don't understand is:
- Why do we call qemu_file_get_error() only after we went through the
  whole switch? This means it is never called for the
  setup_state/end_marker pair.
- If we look for an end marker for config_state and data_state, it's
  buried in the called functions. How can we be sure they actually do
  look for it? That needs at least a comment.
- If we find a valid setup_state section, we return success
  immediately. If we find valid config_state or data_state sections, we
  keep looking for more sections. Why? This also needs at least a
  comment.

> 
> Also handling the case if data_size is greater than the data section of 
> migration region at destination in vfio_load_buffer()in my next version.
> 
> Thanks,
> Kirti
> 
> >   
> >> +
> >> +            data_size = size = qemu_get_be64(f);
> >> +            if (data_size == 0) {
> >> +                break;
> >> +            }
> >> +
> >> +            ret = vfio_mig_read(vbasedev, &data_offset, sizeof(data_offset),
> >> +                                region->fd_offset +
> >> +                                offsetof(struct vfio_device_migration_info,
> >> +                                         data_offset));
> >> +            if (ret < 0) {
> >> +                return ret;
> >> +            }
> >> +
> >> +            trace_vfio_load_state_device_data(vbasedev->name, data_offset,
> >> +                                              data_size);
> >> +
> >> +            while (size) {
> >> +                void *buf = NULL;
> >> +                uint64_t sec_size;
> >> +                bool buf_alloc = false;
> >> +
> >> +                buf = get_data_section_size(region, data_offset, size,
> >> +                                            &sec_size);
> >> +
> >> +                if (!buf) {
> >> +                    buf = g_try_malloc(sec_size);
> >> +                    if (!buf) {
> >> +                        error_report("%s: Error allocating buffer ", __func__);
> >> +                        return -ENOMEM;
> >> +                    }
> >> +                    buf_alloc = true;
> >> +                }
> >> +
> >> +                qemu_get_buffer(f, buf, sec_size);
> >> +
> >> +                if (buf_alloc) {
> >> +                    ret = vfio_mig_write(vbasedev, buf, sec_size,
> >> +                                         region->fd_offset + data_offset);
> >> +                    g_free(buf);
> >> +
> >> +                    if (ret < 0) {
> >> +                        return ret;
> >> +                    }
> >> +                }
> >> +                size -= sec_size;
> >> +                data_offset += sec_size;
> >> +            }
> >> +
> >> +            ret = vfio_mig_write(vbasedev, &data_size, sizeof(data_size),
> >> +                                 region->fd_offset +
> >> +                       offsetof(struct vfio_device_migration_info, data_size));
> >> +            if (ret < 0) {
> >> +                return ret;
> >> +            }
> >> +            break;
> >> +        }
> >> +
> >> +        default:
> >> +            error_report("%s: Unknown tag 0x%"PRIx64, vbasedev->name, data);
> >> +            return -EINVAL;
> >> +        }
> >> +
> >> +        data = qemu_get_be64(f);
> >> +        ret = qemu_file_get_error(f);
> >> +        if (ret) {
> >> +            return ret;
> >> +        }
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +


