Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF1C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 19:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27E021955
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 19:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27E021955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpdei-0001D5-Ml
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 15:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1hpdeY-0000op-MT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1hpdeX-0005K4-8o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:07:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1hpdeX-0005Ja-0R
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:07:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31B14307D844;
 Mon, 22 Jul 2019 19:07:15 +0000 (UTC)
Received: from x1.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3B619C6A;
 Mon, 22 Jul 2019 19:07:13 +0000 (UTC)
Date: Mon, 22 Jul 2019 13:07:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190722130713.2aaa0446@x1.home>
In-Reply-To: <20190722032028.GJ8912@joy-OptiPlex-7040>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-11-git-send-email-kwankhede@nvidia.com>
 <20190712025213.GH9176@joy-OptiPlex-7040>
 <a8f67428-0f42-4b18-0cfd-02a21c3d4343@nvidia.com>
 <20190722032028.GJ8912@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 22 Jul 2019 19:07:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 10/13] vfio: Add load state functions to
 SaveVMHandlers
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "Liu, 
 Changpeng" <changpeng.liu@intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 21 Jul 2019 23:20:28 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Fri, Jul 19, 2019 at 03:00:13AM +0800, Kirti Wankhede wrote:
> > 
> > 
> > On 7/12/2019 8:22 AM, Yan Zhao wrote:  
> > > On Tue, Jul 09, 2019 at 05:49:17PM +0800, Kirti Wankhede wrote:  
> > >> Flow during _RESUMING device state:
> > >> - If Vendor driver defines mappable region, mmap migration region.
> > >> - Load config state.
> > >> - For data packet, till VFIO_MIG_FLAG_END_OF_STATE is not reached
> > >>     - read data_size from packet, read buffer of data_size
> > >>     - read data_offset from where QEMU should write data.
> > >>         if region is mmaped, write data of data_size to mmaped region.
> > >>     - write data_size.
> > >>         In case of mmapped region, write to data_size indicates kernel
> > >>         driver that data is written in staging buffer.
> > >>     - if region is trapped, pwrite() data of data_size from data_offset.
> > >> - Repeat above until VFIO_MIG_FLAG_END_OF_STATE.
> > >> - Unmap migration region.
> > >>
> > >> For user, data is opaque. User should write data in the same order as
> > >> received.
> > >>
> > >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > >> ---
> > >>  hw/vfio/migration.c  | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >>  hw/vfio/trace-events |   3 +
> > >>  2 files changed, 165 insertions(+)
> > >>
> > >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > >> index 4e9b4cce230b..5fb4c5329ede 100644
> > >> --- a/hw/vfio/migration.c
> > >> +++ b/hw/vfio/migration.c
> > >> @@ -249,6 +249,26 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> > >>      return qemu_file_get_error(f);
> > >>  }
> > >>  
> > >> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> > >> +{
> > >> +    VFIODevice *vbasedev = opaque;
> > >> +    uint64_t data;
> > >> +
> > >> +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
> > >> +        vbasedev->ops->vfio_load_config(vbasedev, f);
> > >> +    }
> > >> +
> > >> +    data = qemu_get_be64(f);
> > >> +    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
> > >> +        error_report("%s: Failed loading device config space, "
> > >> +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
> > >> +        return -EINVAL;
> > >> +    }
> > >> +
> > >> +    trace_vfio_load_device_config_state(vbasedev->name);
> > >> +    return qemu_file_get_error(f);
> > >> +}
> > >> +
> > >>  /* ---------------------------------------------------------------------- */
> > >>  
> > >>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> > >> @@ -421,12 +441,154 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> > >>      return ret;
> > >>  }
> > >>  
> > >> +static int vfio_load_setup(QEMUFile *f, void *opaque)
> > >> +{
> > >> +    VFIODevice *vbasedev = opaque;
> > >> +    VFIOMigration *migration = vbasedev->migration;
> > >> +    int ret = 0;
> > >> +
> > >> +    if (migration->region.buffer.mmaps) {
> > >> +        ret = vfio_region_mmap(&migration->region.buffer);
> > >> +        if (ret) {
> > >> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> > >> +                         vbasedev->name, migration->region.index,
> > >> +                         strerror(-ret));
> > >> +            return ret;
> > >> +        }
> > >> +    }
> > >> +
> > >> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING);
> > >> +    if (ret) {
> > >> +        error_report("%s: Failed to set state RESUMING", vbasedev->name);
> > >> +    }
> > >> +    return ret;
> > >> +}
> > >> +
> > >> +static int vfio_load_cleanup(void *opaque)
> > >> +{
> > >> +    vfio_save_cleanup(opaque);
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> > >> +{
> > >> +    VFIODevice *vbasedev = opaque;
> > >> +    VFIOMigration *migration = vbasedev->migration;
> > >> +    int ret = 0;
> > >> +    uint64_t data, data_size;
> > >> +  
> > > I think checking of version_id is still needed.
> > >   
> > 
> > Checking version_id with what value?
> >  
> this version_id passed-in is the source VFIO software interface id.
> need to check it with the value in target side, right?
> 
> Though we previously discussed the sysfs node interface to check live
> migration version even before launching live migration, I think we still
> need this runtime software version check in qemu to ensure software
> interfaces in QEMU VFIO are compatible.

Do we want QEMU to interact directly with sysfs for that, which would
require write privileges to sysfs, or do we want to suggest that vendor
drivers should include equivalent information early in their migration
data stream to force a migration failure as early as possible for
incompatible data?  I think we need the latter regardless because the
vendor driver should never trust userspace like that, but does that
make any QEMU use of the sysfs version test itself redundant?  Thanks,

Alex

