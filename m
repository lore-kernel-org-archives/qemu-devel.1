Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAA1C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 04:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E782072B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 04:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E782072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYMux-0001se-1m
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 00:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jYJHk-0002UD-Fw
 for qemu-devel@nongnu.org; Mon, 11 May 2020 21:00:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:46290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jYJHh-0004SA-8P
 for qemu-devel@nongnu.org; Mon, 11 May 2020 21:00:39 -0400
IronPort-SDR: 5QqLayY4u/C88h5KRHkyl3oPD3R5jKTkGSR+gFr8lue144KBYhtw1YIv9atLC9+hcjOW7KNl69
 x7Mvr4XUf8Wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 18:00:26 -0700
IronPort-SDR: jB34r3FKCEwqxO0KiWH9w9rZf7/RXIX5ifDI1VvabThwnDCVU/zGspH+Ia1ooKD9jfFrs/YqPc
 47AaZu2i4uHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="436891403"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005.jf.intel.com with ESMTP; 11 May 2020 18:00:21 -0700
Date: Mon, 11 May 2020 20:50:33 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 09/16] vfio: Add save state functions to
 SaveVMHandlers
Message-ID: <20200512005033.GA27524@joy-OptiPlex-7040>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-10-git-send-email-kwankhede@nvidia.com>
 <20200509053131.GC26056@joy-OptiPlex-7040>
 <7653e660-1360-7c2b-c4c7-3b53081f14e3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7653e660-1360-7c2b-c4c7-3b53081f14e3@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=yan.y.zhao@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 21:00:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 May 2020 00:52:43 -0400
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 06:22:47PM +0800, Kirti Wankhede wrote:
> 
> 
> On 5/9/2020 11:01 AM, Yan Zhao wrote:
> > On Wed, Mar 25, 2020 at 05:09:07AM +0800, Kirti Wankhede wrote:
> >> Added .save_live_pending, .save_live_iterate and .save_live_complete_precopy
> >> functions. These functions handles pre-copy and stop-and-copy phase.
> >>
> >> In _SAVING|_RUNNING device state or pre-copy phase:
> >> - read pending_bytes. If pending_bytes > 0, go through below steps.
> >> - read data_offset - indicates kernel driver to write data to staging
> >>    buffer.
> >> - read data_size - amount of data in bytes written by vendor driver in
> >>    migration region.
> > I think we should change the sequence of reading data_size and
> > data_offset. see the next comment below.
> > 
> >> - read data_size bytes of data from data_offset in the migration region.
> >> - Write data packet to file stream as below:
> >> {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data,
> >> VFIO_MIG_FLAG_END_OF_STATE }
> >>
> >> In _SAVING device state or stop-and-copy phase
> >> a. read config space of device and save to migration file stream. This
> >>     doesn't need to be from vendor driver. Any other special config state
> >>     from driver can be saved as data in following iteration.
> >> b. read pending_bytes. If pending_bytes > 0, go through below steps.
> >> c. read data_offset - indicates kernel driver to write data to staging
> >>     buffer.
> >> d. read data_size - amount of data in bytes written by vendor driver in
> >>     migration region.
> >> e. read data_size bytes of data from data_offset in the migration region.
> >> f. Write data packet as below:
> >>     {VFIO_MIG_FLAG_DEV_DATA_STATE, data_size, actual data}
> >> g. iterate through steps b to f while (pending_bytes > 0)
> >> h. Write {VFIO_MIG_FLAG_END_OF_STATE}
> >>
> >> When data region is mapped, its user's responsibility to read data from
> >> data_offset of data_size before moving to next steps.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   hw/vfio/migration.c           | 245 +++++++++++++++++++++++++++++++++++++++++-
> >>   hw/vfio/trace-events          |   6 ++
> >>   include/hw/vfio/vfio-common.h |   1 +
> >>   3 files changed, 251 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index 033f76526e49..ecbeed5182c2 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -138,6 +138,137 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> >>       return 0;
> >>   }
> >>   
> >> +static void *find_data_region(VFIORegion *region,
> >> +                              uint64_t data_offset,
> >> +                              uint64_t data_size)
> >> +{
> >> +    void *ptr = NULL;
> >> +    int i;
> >> +
> >> +    for (i = 0; i < region->nr_mmaps; i++) {
> >> +        if ((data_offset >= region->mmaps[i].offset) &&
> >> +            (data_offset < region->mmaps[i].offset + region->mmaps[i].size) &&
> >> +            (data_size <= region->mmaps[i].size)) {
> >> +            ptr = region->mmaps[i].mmap + (data_offset -
> >> +                                           region->mmaps[i].offset);
> >> +            break;
> >> +        }
> >> +    }
> >> +    return ptr;
> >> +}
> >> +
> >> +static int vfio_save_buffer(QEMUFile *f, VFIODevice *vbasedev)
> >> +{
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    VFIORegion *region = &migration->region;
> >> +    uint64_t data_offset = 0, data_size = 0;
> >> +    int ret;
> >> +
> >> +    ret = pread(vbasedev->fd, &data_offset, sizeof(data_offset),
> >> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> >> +                                             data_offset));
> >> +    if (ret != sizeof(data_offset)) {
> >> +        error_report("%s: Failed to get migration buffer data offset %d",
> >> +                     vbasedev->name, ret);
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    ret = pread(vbasedev->fd, &data_size, sizeof(data_size),
> >> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> >> +                                             data_size));
> >> +    if (ret != sizeof(data_size)) {
> >> +        error_report("%s: Failed to get migration buffer data size %d",
> >> +                     vbasedev->name, ret);
> >> +        return -EINVAL;
> >> +    }
> > data_size should be read first, and if it's 0, data_offset will not
> > be read further.
> > 
> > the reasons are below:
> > 1. if there's no data region provided by vendor driver, there's no
> > reason to get a valid data_offset, so reading/writing of data_offset
> > should fail. And this should not be treated as a migration error.
> > 
> > 2. even if pending_bytes is 0, vfio_save_iterate() is still possible to be
> > called and therefore vfio_save_buffer() is called.
> > 
> 
> As I mentioned in reply to Alex in:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg02476.html
> 
> With that, vfio_save_iterate() will read pending_bytes if its 0 and then 
> if pending_bytes is not 0 then call vfio_save_buffer(). With that your 
> above concerns should get resolved.
>
what if pending_bytes is not 0, but vendor driver just does not want to
send data in this iteration? isn't it right to get data_size first before
getting data_offset?

Thanks
Yan

