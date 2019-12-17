Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDB5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 07:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13652067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 07:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13652067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih7Bc-0000It-UX
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 02:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1ih7Ay-0008Kd-RO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1ih7Aw-0004dY-Kh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:21:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:62206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1ih7Aw-0004LE-AO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 02:21:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Dec 2019 23:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,324,1571727600"; d="scan'208";a="266493368"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by FMSMGA003.fm.intel.com with ESMTP; 16 Dec 2019 23:21:02 -0800
Date: Tue, 17 Dec 2019 02:12:48 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v10 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20191217071248.GG21868@joy-OptiPlex-7040>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-2-git-send-email-kwankhede@nvidia.com>
 <20191216154406.023f912b@x1.home>
 <f773a92a-acbd-874d-34ba-36c1e9ffe442@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f773a92a-acbd-874d-34ba-36c1e9ffe442@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 17, 2019 at 02:28:44PM +0800, Kirti Wankhede wrote:
> 
> 
> On 12/17/2019 4:14 AM, Alex Williamson wrote:
> > On Tue, 17 Dec 2019 01:51:36 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > 
> >> - Defined MIGRATION region type and sub-type.
> >>
> >> - Defined vfio_device_migration_info structure which will be placed at 0th
> >>    offset of migration region to get/set VFIO device related information.
> >>    Defined members of structure and usage on read/write access.
> >>
> >> - Defined device states and added state transition details in the comment.
> >>
> >> - Added sequence to be followed while saving and resuming VFIO device state
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   include/uapi/linux/vfio.h | 180 ++++++++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 180 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index 9e843a147ead..a0817ba267c1 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -305,6 +305,7 @@ struct vfio_region_info_cap_type {
> >>   #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
> >>   #define VFIO_REGION_TYPE_GFX                    (1)
> >>   #define VFIO_REGION_TYPE_CCW			(2)
> >> +#define VFIO_REGION_TYPE_MIGRATION              (3)
> >>   
> >>   /* sub-types for VFIO_REGION_TYPE_PCI_* */
> >>   
> >> @@ -379,6 +380,185 @@ struct vfio_region_gfx_edid {
> >>   /* sub-types for VFIO_REGION_TYPE_CCW */
> >>   #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
> >>   
> >> +/* sub-types for VFIO_REGION_TYPE_MIGRATION */
> >> +#define VFIO_REGION_SUBTYPE_MIGRATION           (1)
> >> +
> >> +/*
> >> + * Structure vfio_device_migration_info is placed at 0th offset of
> >> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
> >> + * information. Field accesses from this structure are only supported at their
> >> + * native width and alignment, otherwise the result is undefined and vendor
> >> + * drivers should return an error.
> >> + *
> >> + * device_state: (read/write)
> >> + *      To indicate vendor driver the state VFIO device should be transitioned
> >> + *      to. If device state transition fails, write on this field return error.
> >> + *      It consists of 3 bits:
> >> + *      - If bit 0 set, indicates _RUNNING state. When its clear, that indicates
> > 
> > s/its/it's/
> > 
> >> + *        _STOP state. When device is changed to _STOP, driver should stop
> >> + *        device before write() returns.
> >> + *      - If bit 1 set, indicates _SAVING state. When set, that indicates driver
> >> + *        should start gathering device state information which will be provided
> >> + *        to VFIO user space application to save device's state.
> >> + *      - If bit 2 set, indicates _RESUMING state. When set, that indicates
> >> + *        prepare to resume device, data provided through migration region
> >> + *        should be used to resume device.
> >> + *      Bits 3 - 31 are reserved for future use. User should perform
> >> + *      read-modify-write operation on this field.
> >> + *
> >> + *  +------- _RESUMING
> >> + *  |+------ _SAVING
> >> + *  ||+----- _RUNNING
> >> + *  |||
> >> + *  000b => Device Stopped, not saving or resuming
> >> + *  001b => Device running state, default state
> >> + *  010b => Stop Device & save device state, stop-and-copy state
> >> + *  011b => Device running and save device state, pre-copy state
> >> + *  100b => Device stopped and device state is resuming
> >> + *  101b => Invalid state
> > 
> > Eventually this would be intended for post-copy, if supported by the
> > device, right?
> > 
> 
> No, as per Yan mentioned in earlier version, _RESUMING + _RUNNING can't 
> be used for post-copy. New flag will be required for post-copy.
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg658768.html

sorry, I didn't mean _RESUMING + _RUNNING can't be used for post-copy.
I just mean another POSCOPY state needs to be introduced. But I'm not
sure what _RESUMING state is for.
actually, we do nothing in response to _RESUMING state, no matter precopy
or poscopy.
If in your side_RESUMING state means it is allowed to restore device data,
then I think _RESUMING + _RUNNING is a valid state for postcopy.

Thanks
Yan

