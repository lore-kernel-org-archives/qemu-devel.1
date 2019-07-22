Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018AC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 21:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D542421951
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 21:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D542421951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpgL0-0001AQ-T9
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 17:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33379)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yan.y.zhao@intel.com>) id 1hpgKq-0000m4-IL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 17:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1hpgKc-0006wu-Tm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 17:58:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:8050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1hpgKP-0005Me-17
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 17:58:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jul 2019 14:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,296,1559545200"; d="scan'208";a="368658495"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2019 14:56:22 -0700
Date: Mon, 22 Jul 2019 17:50:19 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190722215017.GA3937@joy-OptiPlex-7040>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-11-git-send-email-kwankhede@nvidia.com>
 <20190712025213.GH9176@joy-OptiPlex-7040>
 <a8f67428-0f42-4b18-0cfd-02a21c3d4343@nvidia.com>
 <20190722032028.GJ8912@joy-OptiPlex-7040>
 <20190722130713.2aaa0446@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722130713.2aaa0446@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
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

On Tue, Jul 23, 2019 at 03:07:13AM +0800, Alex Williamson wrote:
> On Sun, 21 Jul 2019 23:20:28 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Fri, Jul 19, 2019 at 03:00:13AM +0800, Kirti Wankhede wrote:
> > > 
> > > 
> > > On 7/12/2019 8:22 AM, Yan Zhao wrote:  
> > > > On Tue, Jul 09, 2019 at 05:49:17PM +0800, Kirti Wankhede wrote:  
> > > >> Flow during _RESUMING device state:
> > > >> - If Vendor driver defines mappable region, mmap migration region.
> > > >> - Load config state.
> > > >> - For data packet, till VFIO_MIG_FLAG_END_OF_STATE is not reached
> > > >>     - read data_size from packet, read buffer of data_size
> > > >>     - read data_offset from where QEMU should write data.
> > > >>         if region is mmaped, write data of data_size to mmaped region.
> > > >>     - write data_size.
> > > >>         In case of mmapped region, write to data_size indicates kernel
> > > >>         driver that data is written in staging buffer.
> > > >>     - if region is trapped, pwrite() data of data_size from data_offset.
> > > >> - Repeat above until VFIO_MIG_FLAG_END_OF_STATE.
> > > >> - Unmap migration region.
> > > >>
> > > >> For user, data is opaque. User should write data in the same order as
> > > >> received.
> > > >>
> > > >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > >> ---
> > > >>  hw/vfio/migration.c  | 162 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >>  hw/vfio/trace-events |   3 +
> > > >>  2 files changed, 165 insertions(+)
> > > >>
> > > >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > >> index 4e9b4cce230b..5fb4c5329ede 100644
> > > >> --- a/hw/vfio/migration.c
> > > >> +++ b/hw/vfio/migration.c
> > > >> @@ -249,6 +249,26 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
> > > >>      return qemu_file_get_error(f);
> > > >>  }
> > > >>  
> > > >> +static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> > > >> +{
> > > >> +    VFIODevice *vbasedev = opaque;
> > > >> +    uint64_t data;
> > > >> +
> > > >> +    if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
> > > >> +        vbasedev->ops->vfio_load_config(vbasedev, f);
> > > >> +    }
> > > >> +
> > > >> +    data = qemu_get_be64(f);
> > > >> +    if (data != VFIO_MIG_FLAG_END_OF_STATE) {
> > > >> +        error_report("%s: Failed loading device config space, "
> > > >> +                     "end flag incorrect 0x%"PRIx64, vbasedev->name, data);
> > > >> +        return -EINVAL;
> > > >> +    }
> > > >> +
> > > >> +    trace_vfio_load_device_config_state(vbasedev->name);
> > > >> +    return qemu_file_get_error(f);
> > > >> +}
> > > >> +
> > > >>  /* ---------------------------------------------------------------------- */
> > > >>  
> > > >>  static int vfio_save_setup(QEMUFile *f, void *opaque)
> > > >> @@ -421,12 +441,154 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
> > > >>      return ret;
> > > >>  }
> > > >>  
> > > >> +static int vfio_load_setup(QEMUFile *f, void *opaque)
> > > >> +{
> > > >> +    VFIODevice *vbasedev = opaque;
> > > >> +    VFIOMigration *migration = vbasedev->migration;
> > > >> +    int ret = 0;
> > > >> +
> > > >> +    if (migration->region.buffer.mmaps) {
> > > >> +        ret = vfio_region_mmap(&migration->region.buffer);
> > > >> +        if (ret) {
> > > >> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> > > >> +                         vbasedev->name, migration->region.index,
> > > >> +                         strerror(-ret));
> > > >> +            return ret;
> > > >> +        }
> > > >> +    }
> > > >> +
> > > >> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING);
> > > >> +    if (ret) {
> > > >> +        error_report("%s: Failed to set state RESUMING", vbasedev->name);
> > > >> +    }
> > > >> +    return ret;
> > > >> +}
> > > >> +
> > > >> +static int vfio_load_cleanup(void *opaque)
> > > >> +{
> > > >> +    vfio_save_cleanup(opaque);
> > > >> +    return 0;
> > > >> +}
> > > >> +
> > > >> +static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
> > > >> +{
> > > >> +    VFIODevice *vbasedev = opaque;
> > > >> +    VFIOMigration *migration = vbasedev->migration;
> > > >> +    int ret = 0;
> > > >> +    uint64_t data, data_size;
> > > >> +  
> > > > I think checking of version_id is still needed.
> > > >   
> > > 
> > > Checking version_id with what value?
> > >  
> > this version_id passed-in is the source VFIO software interface id.
> > need to check it with the value in target side, right?
> > 
> > Though we previously discussed the sysfs node interface to check live
> > migration version even before launching live migration, I think we still
> > need this runtime software version check in qemu to ensure software
> > interfaces in QEMU VFIO are compatible.
> 
> Do we want QEMU to interact directly with sysfs for that, which would
> require write privileges to sysfs, or do we want to suggest that vendor
> drivers should include equivalent information early in their migration
> data stream to force a migration failure as early as possible for
> incompatible data?  I think we need the latter regardless because the
> vendor driver should never trust userspace like that, but does that
> make any QEMU use of the sysfs version test itself redundant?  Thanks,
> 
> Alex

hi Alex
I think QEMU needs to check at least the code version of software interface in
QEMU, like format of migration region, details of migration protocol,
IOW, the software version QEMU interacts with vendor driver.
This information should not be known to vendor driver until migration
running to certain phase.
e.g. if saving flow or format in source qemu is changed a little as a result
of software upgrading, target qemu has to detect that from this
version_id check, as vendor driver has no knowledge of that.
Does that make sense?


Thanks
Yan

