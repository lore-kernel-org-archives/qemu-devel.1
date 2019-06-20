Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D1C48BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D8552084A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8552084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51532 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he0oo-0007QG-ES
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 13:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50977)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.williamson@redhat.com>) id 1he0j0-00031S-MV
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1he0iw-0007PW-Ch
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:19:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1he0iu-0007FL-97
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 13:19:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B8D081F1B;
 Thu, 20 Jun 2019 17:19:00 +0000 (UTC)
Received: from x1.home (ovpn-117-35.phx2.redhat.com [10.3.117.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 167115C1A1;
 Thu, 20 Jun 2019 17:18:49 +0000 (UTC)
Date: Thu, 20 Jun 2019 11:18:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <20190620111848.1bf70e99@x1.home>
In-Reply-To: <1561041461-22326-2-git-send-email-kwankhede@nvidia.com>
References: <1561041461-22326-1-git-send-email-kwankhede@nvidia.com>
 <1561041461-22326-2-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 17:19:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 01/13] vfio: KABI for migration interface
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
 pasic@linux.ibm.com, aik@ozlabs.ru, yulei.zhang@intel.com, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, yan.y.zhao@intel.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Jun 2019 20:07:29 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Defined MIGRATION region type and sub-type.
> - Used 3 bits to define VFIO device states.
>     Bit 0 => _RUNNING
>     Bit 1 => _SAVING
>     Bit 2 => _RESUMING
>     Combination of these bits defines VFIO device's state during migration
>     _STOPPED => All bits 0 indicates VFIO device stopped.
>     _RUNNING => Normal VFIO device running state.
>     _SAVING | _RUNNING => vCPUs are running, VFIO device is running but start
>                           saving state of device i.e. pre-copy state
>     _SAVING  => vCPUs are stoppped, VFIO device should be stopped, and
>                           save device state,i.e. stop-n-copy state
>     _RESUMING => VFIO device resuming state.
>     _SAVING | _RESUMING => Invalid state if _SAVING and _RESUMING bits are set
> - Defined vfio_device_migration_info structure which will be placed at 0th
>   offset of migration region to get/set VFIO device related information.
>   Defined members of structure and usage on read/write access:
>     * device_state: (read/write)
>         To convey VFIO device state to be transitioned to. Only 3 bits are used
>         as of now.
>     * pending bytes: (read only)
>         To get pending bytes yet to be migrated for VFIO device.
>     * data_offset: (read only)
>         To get data offset in migration from where data exist during _SAVING
>         and from where data should be written by user space application during
>          _RESUMING state
>     * data_size: (read/write)
>         To get and set size of data copied in migration region during _SAVING
>         and _RESUMING state.
>     * start_pfn, page_size, total_pfns: (write only)
>         To get bitmap of dirty pages from vendor driver from given
>         start address for total_pfns.
>     * copied_pfns: (read only)
>         To get number of pfns bitmap copied in migration region.
>         Vendor driver should copy the bitmap with bits set only for
>         pages to be marked dirty in migration region. Vendor driver
>         should return 0 if there are 0 pages dirty in requested
>         range. Vendor driver should return -1 to mark all pages in the section
>         as dirty
> 
> Migration region looks like:
>  ------------------------------------------------------------------
> |vfio_device_migration_info|    data section                      |
> |                          |     ///////////////////////////////  |
>  ------------------------------------------------------------------
>  ^                              ^                              ^
>  offset 0-trapped part        data_offset                 data_size
> 
> Data section is always followed by vfio_device_migration_info
> structure in the region, so data_offset will always be none-0.
> Offset from where data is copied is decided by kernel driver, data
> section can be trapped or mapped depending on how kernel driver
> defines data section. If mmapped, then data_offset should be page
> aligned, where as initial section which contain
> vfio_device_migration_info structure might not end at offset which
> is page aligned.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  linux-headers/linux/vfio.h | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 24f505199f83..274ec477eb82 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -372,6 +372,77 @@ struct vfio_region_gfx_edid {
>   */
>  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
>  
> +/* Migration region type and sub-type */
> +#define VFIO_REGION_TYPE_MIGRATION	        (2)
> +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
> +
> +/**
> + * Structure vfio_device_migration_info is placed at 0th offset of
> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
> + * information. Field accesses from this structure are only supported at their
> + * native width and alignment, otherwise should return error.
> + *
> + * device_state: (read/write)
> + *      To indicate vendor driver the state VFIO device should be transitioned
> + *      to. If device state transition fails, write to this field return error.
> + *      It consists of 3 bits:
> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
> + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
> + *        device before write returns.
> + *      - If bit 1 set, indicates _SAVING state.
> + *      - If bit 2 set, indicates _RESUMING state.
> + *
> + * pending bytes: (read only)
> + *      Read pending bytes yet to be migrated from vendor driver
> + *
> + * data_offset: (read only)
> + *      User application should read data_offset in migration region from where
> + *      user application should read data during _SAVING state or write data
> + *      during _RESUMING state.
> + *
> + * data_size: (read/write)
> + *      User application should read data_size to know data copied in migration
> + *      region during _SAVING state and write size of data copied in migration
> + *      region during _RESUMING state.
> + *
> + * start_pfn: (write only)
> + *      Start address pfn to get bitmap of dirty pages from vendor driver duing
> + *      _SAVING state.
> + *
> + * page_size: (write only)
> + *      User application should write the page_size of pfn.
> + *
> + * total_pfns: (write only)
> + *      Total pfn count from start_pfn for which dirty bitmap is requested.
> + *
> + * copied_pfns: (read only)
> + *      pfn count for which dirty bitmap is copied to migration region.
> + *      Vendor driver should copy the bitmap with bits set only for pages to be
> + *      marked dirty in migration region.
> + *      Vendor driver should return 0 if there are 0 pages dirty in requested
> + *      range.
> + *      Vendor driver should return -1 to mark all pages in the section as
> + *      dirty.

Is the protocol that the user writes start_pfn/page_size/total_pfns in
any order and then the read of copied_pfns is what triggers the
snapshot?  Are start_pfn/page_size/total_pfns sticky such that a user
can write them once and get repeated refreshes of the dirty bitmap by
re-reading copied_pfns?  What's the advantage to returning -1 versus
returning copied_pfns == total_pfns?

If the user then wants to switch back to reading device migration
state, is it a read of data_size that switches the data area back to
making that address space available?  In each case, is it the user's
responsibility to consume all the data provided before triggering the
next data area?  For example, if I ask for a range of dirty bitmap, the
vendor driver will provide that range and and clear it, such that the
pages are considered clean regardless of whether the user consumed the
data area.  Likewise if the user asks for data_size, that would be
deducted from pending_bytes regardless of the user reading the data
area.  Are there any read side-effects to pending_bytes?  Are there
read side-effects to the data area on SAVING?  Are there write
side-effects on RESUMING, or is it only the write of data_size that
triggers the buffer to be consumed?  Is it the user's responsibility to
write only full "packets" on RESUMING?  For example if the SAVING side
provides data_size X, that full data_size X must be written to the
RESUMING side, the user cannot write half of it to the data area on the
RESUMING side, write data_size with X/2, write the second half, and
again write X/2.  IOW, the data_size "packet" is indivisible at the
point of resuming.

What are the ordering requirements?  Must the user write data_size
packets in the same order that they're read, or is it the vendor
driver's responsibility to include sequence information and allow
restore in any order?

> + */
> +
> +struct vfio_device_migration_info {
> +        __u32 device_state;         /* VFIO device state */
> +#define VFIO_DEVICE_STATE_STOPPED   (0)

We need to be careful with how this is used if we want to leave the
possibility of using the remaining 29 bits of this register.  Maybe we
want to define VFIO_DEVICE_STATE_MASK and be sure that we only do
read-modify-write ops within the mask (ex. set_bit and clear_bit
helpers).  Also, above we define STOPPED to indicate simply
not-RUNNING, but here it seems STOPPED means not-RUNNING, not-SAVING,
and not-RESUMING.

> +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
> +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
> +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
> +#define VFIO_DEVICE_STATE_INVALID   (VFIO_DEVICE_STATE_SAVING | \
> +                                     VFIO_DEVICE_STATE_RESUMING)
> +        __u32 reserved;
> +        __u64 pending_bytes;
> +        __u64 data_offset;

Placing the data more than 4GB into the region seems a bit absurd, so
this could probably be a __u32 and take the place of the reserved field.

> +        __u64 data_size;
> +        __u64 start_pfn;
> +        __u64 page_size;
> +        __u64 total_pfns;
> +        __s64 copied_pfns;

If this is signed so that we can get -1 then the user could
theoretically specify total_pfns that we can't represent in
copied_pfns.  Probably best to use unsigned and specify ~0 rather than
-1.

Overall this looks like a good interface, but we need to more
thoroughly define the protocol with the data area and set expectations
we're placing on the user and vendor driver.  There should be no usage
assumptions, it should all be spelled out.  Thanks,

Alex

> +} __attribute__((packed));
> +
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within


