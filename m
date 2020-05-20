Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DDDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 03:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B992F20578
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 03:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B992F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbF3C-0005ON-Uh
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 23:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jbF2c-0004tE-7d
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:05:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:57929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jbF2Z-00013j-Qd
 for qemu-devel@nongnu.org; Tue, 19 May 2020 23:05:09 -0400
IronPort-SDR: urGnr6pyWykN5JbyI4w+UJyB8CI5W7K4yyJCACTHaibJQwMa8/R33EHIqUzgo5jtbJVwlDPJqu
 fF6SCvIIRwUw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2020 20:04:56 -0700
IronPort-SDR: z0awaPsaTmUS/inaEkWt6+KRAMaKZiJbZAtY5rfO+27ZAk0XWBVoV2B2zcPQ0kSL+C2rrWDvGG
 z0eXz0C/Az6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; d="scan'208";a="466220160"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 19 May 2020 20:04:51 -0700
Date: Tue, 19 May 2020 22:55:01 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH Kernel v22 0/8] Add UAPIs to support migration for VFIO
 devices
Message-ID: <20200520025500.GA10369@joy-OptiPlex-7040>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <20200519105804.02f3cae8@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519105804.02f3cae8@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yan.y.zhao@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 23:04:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 10:58:04AM -0600, Alex Williamson wrote:
> Hi folks,
> 
> My impression is that we're getting pretty close to a workable
> implementation here with v22 plus respins of patches 5, 6, and 8.  We
> also have a matching QEMU series and a proposal for a new i40e
> consumer, as well as I assume GVT-g updates happening internally at
> Intel.  I expect all of the latter needs further review and discussion,
> but we should be at the point where we can validate these proposed
> kernel interfaces.  Therefore I'd like to make a call for reviews so
> that we can get this wrapped up for the v5.8 merge window.  I know
> Connie has some outstanding documentation comments and I'd like to make
> sure everyone has an opportunity to check that their comments have been
> addressed and we don't discover any new blocking issues.  Please send
> your Acked-by/Reviewed-by/Tested-by tags if you're satisfied with this
> interface and implementation.  Thanks!
> 
hi Alex and Kirti,
after porting to qemu v22 and kernel v22, it is found out that
it can not even pass basic live migration test with error like

"Failed to get dirty bitmap for iova: 0xca000 size: 0x3000 err: 22"

Thanks
Yan

> 
> On Mon, 18 May 2020 11:26:29 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > Hi,
> > 
> > This patch set adds:
> > * IOCTL VFIO_IOMMU_DIRTY_PAGES to get dirty pages bitmap with
> >   respect to IOMMU container rather than per device. All pages pinned by
> >   vendor driver through vfio_pin_pages external API has to be marked as
> >   dirty during  migration. When IOMMU capable device is present in the
> >   container and all pages are pinned and mapped, then all pages are marked
> >   dirty.
> >   When there are CPU writes, CPU dirty page tracking can identify dirtied
> >   pages, but any page pinned by vendor driver can also be written by
> >   device. As of now there is no device which has hardware support for
> >   dirty page tracking. So all pages which are pinned should be considered
> >   as dirty.
> >   This ioctl is also used to start/stop dirty pages tracking for pinned and
> >   unpinned pages while migration is active.
> > 
> > * Updated IOCTL VFIO_IOMMU_UNMAP_DMA to get dirty pages bitmap before
> >   unmapping IO virtual address range.
> >   With vIOMMU, during pre-copy phase of migration, while CPUs are still
> >   running, IO virtual address unmap can happen while device still keeping
> >   reference of guest pfns. Those pages should be reported as dirty before
> >   unmap, so that VFIO user space application can copy content of those
> >   pages from source to destination.
> > 
> > * Patch 8 detect if IOMMU capable device driver is smart to report pages
> >   to be marked dirty by pinning pages using vfio_pin_pages() API.
> > 
> > 
> > Yet TODO:
> > Since there is no device which has hardware support for system memmory
> > dirty bitmap tracking, right now there is no other API from vendor driver
> > to VFIO IOMMU module to report dirty pages. In future, when such hardware
> > support will be implemented, an API will be required such that vendor
> > driver could report dirty pages to VFIO module during migration phases.
> > 
> > Adding revision history from previous QEMU patch set to understand KABI
> > changes done till now
> > 
> > v21 -> v22
> > - Fixed issue raised by Alex :
> > https://lore.kernel.org/kvm/20200515163307.72951dd2@w520.home/
> > 
> > v20 -> v21
> > - Added checkin for GET_BITMAP ioctl for vfio_dma boundaries.
> > - Updated unmap ioctl function - as suggested by Alex.
> > - Updated comments in DIRTY_TRACKING ioctl definition - as suggested by
> >   Cornelia.
> > 
> > v19 -> v20
> > - Fixed ioctl to get dirty bitmap to get bitmap of multiple vfio_dmas
> > - Fixed unmap ioctl to get dirty bitmap of multiple vfio_dmas.
> > - Removed flag definition from migration capability.
> > 
> > v18 -> v19
> > - Updated migration capability with supported page sizes bitmap for dirty
> >   page tracking and  maximum bitmap size supported by kernel module.
> > - Added patch to calculate and cache pgsize_bitmap when iommu->domain_list
> >   is updated.
> > - Removed extra buffers added in previous version for bitmap manipulation
> >   and optimised the code.
> > 
> > v17 -> v18
> > - Add migration capability to the capability chain for VFIO_IOMMU_GET_INFO
> >   ioctl
> > - Updated UMAP_DMA ioctl to return bitmap of multiple vfio_dma
> > 
> > v16 -> v17
> > - Fixed errors reported by kbuild test robot <lkp@intel.com> on i386
> > 
> > v15 -> v16
> > - Minor edits and nit picks (Auger Eric)
> > - On copying bitmap to user, re-populated bitmap only for pinned pages,
> >   excluding unmapped pages and CPU dirtied pages.
> > - Patches are on tag: next-20200318 and 1-3 patches from Yan's series
> >   https://lkml.org/lkml/2020/3/12/1255
> > 
> > v14 -> v15
> > - Minor edits and nit picks.
> > - In the verification of user allocated bitmap memory, added check of
> >    maximum size.
> > - Patches are on tag: next-20200318 and 1-3 patches from Yan's series
> >   https://lkml.org/lkml/2020/3/12/1255
> > 
> > v13 -> v14
> > - Added struct vfio_bitmap to kabi. updated structure
> >   vfio_iommu_type1_dirty_bitmap_get and vfio_iommu_type1_dma_unmap.
> > - All small changes suggested by Alex.
> > - Patches are on tag: next-20200318 and 1-3 patches from Yan's series
> >   https://lkml.org/lkml/2020/3/12/1255
> > 
> > v12 -> v13
> > - Changed bitmap allocation in vfio_iommu_type1 to per vfio_dma
> > - Changed VFIO_IOMMU_DIRTY_PAGES ioctl behaviour to be per vfio_dma range.
> > - Changed vfio_iommu_type1_dirty_bitmap structure to have separate data
> >   field.
> > 
> > v11 -> v12
> > - Changed bitmap allocation in vfio_iommu_type1.
> > - Remove atomicity of ref_count.
> > - Updated comments for migration device state structure about error
> >   reporting.
> > - Nit picks from v11 reviews
> > 
> > v10 -> v11
> > - Fix pin pages API to free vpfn if it is marked as unpinned tracking page.
> > - Added proposal to detect if IOMMU capable device calls external pin pages
> >   API to mark pages dirty.
> > - Nit picks from v10 reviews
> > 
> > v9 -> v10:
> > - Updated existing VFIO_IOMMU_UNMAP_DMA ioctl to get dirty pages bitmap
> >   during unmap while migration is active
> > - Added flag in VFIO_IOMMU_GET_INFO to indicate driver support dirty page
> >   tracking.
> > - If iommu_mapped, mark all pages dirty.
> > - Added unpinned pages tracking while migration is active.
> > - Updated comments for migration device state structure with bit
> >   combination table and state transition details.
> > 
> > v8 -> v9:
> > - Split patch set in 2 sets, Kernel and QEMU.
> > - Dirty pages bitmap is queried from IOMMU container rather than from
> >   vendor driver for per device. Added 2 ioctls to achieve this.
> > 
> > v7 -> v8:
> > - Updated comments for KABI
> > - Added BAR address validation check during PCI device's config space load
> >   as suggested by Dr. David Alan Gilbert.
> > - Changed vfio_migration_set_state() to set or clear device state flags.
> > - Some nit fixes.
> > 
> > v6 -> v7:
> > - Fix build failures.
> > 
> > v5 -> v6:
> > - Fix build failure.
> > 
> > v4 -> v5:
> > - Added decriptive comment about the sequence of access of members of
> >   structure vfio_device_migration_info to be followed based on Alex's
> >   suggestion
> > - Updated get dirty pages sequence.
> > - As per Cornelia Huck's suggestion, added callbacks to VFIODeviceOps to
> >   get_object, save_config and load_config.
> > - Fixed multiple nit picks.
> > - Tested live migration with multiple vfio device assigned to a VM.
> > 
> > v3 -> v4:
> > - Added one more bit for _RESUMING flag to be set explicitly.
> > - data_offset field is read-only for user space application.
> > - data_size is read for every iteration before reading data from migration,
> >   that is removed assumption that data will be till end of migration
> >   region.
> > - If vendor driver supports mappable sparsed region, map those region
> >   during setup state of save/load, similarly unmap those from cleanup
> >   routines.
> > - Handles race condition that causes data corruption in migration region
> >   during save device state by adding mutex and serialiaing save_buffer and
> >   get_dirty_pages routines.
> > - Skip called get_dirty_pages routine for mapped MMIO region of device.
> > - Added trace events.
> > - Split into multiple functional patches.
> > 
> > v2 -> v3:
> > - Removed enum of VFIO device states. Defined VFIO device state with 2
> >   bits.
> > - Re-structured vfio_device_migration_info to keep it minimal and defined
> >   action on read and write access on its members.
> > 
> > v1 -> v2:
> > - Defined MIGRATION region type and sub-type which should be used with
> >   region type capability.
> > - Re-structured vfio_device_migration_info. This structure will be placed
> >   at 0th offset of migration region.
> > - Replaced ioctl with read/write for trapped part of migration region.
> > - Added both type of access support, trapped or mmapped, for data section
> >   of the region.
> > - Moved PCI device functions to pci file.
> > - Added iteration to get dirty page bitmap until bitmap for all requested
> >   pages are copied.
> > 
> > Thanks,
> > Kirti
> > 
> > 
> > 
> > 
> > Kirti Wankhede (8):
> >   vfio: UAPI for migration interface for device state
> >   vfio iommu: Remove atomicity of ref_count of pinned pages
> >   vfio iommu: Cache pgsize_bitmap in struct vfio_iommu
> >   vfio iommu: Add ioctl definition for dirty pages tracking
> >   vfio iommu: Implementation of ioctl for dirty pages tracking
> >   vfio iommu: Update UNMAP_DMA ioctl to get dirty bitmap before unmap
> >   vfio iommu: Add migration capability to report supported features
> >   vfio: Selective dirty page tracking if IOMMU backed device pins pages
> > 
> >  drivers/vfio/vfio.c             |  13 +-
> >  drivers/vfio/vfio_iommu_type1.c | 576 ++++++++++++++++++++++++++++++++++++----
> >  include/linux/vfio.h            |   4 +-
> >  include/uapi/linux/vfio.h       | 315 ++++++++++++++++++++++
> >  4 files changed, 849 insertions(+), 59 deletions(-)
> > 
> 

