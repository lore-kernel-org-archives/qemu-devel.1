Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D5CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12B521582
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Jp084s/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12B521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igxOx-0000ST-AG
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 15:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1igxK4-00026O-HL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1igxK2-00079d-Iz
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:50:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1igxK2-000794-B2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:50:30 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df7ee0b0000>; Mon, 16 Dec 2019 12:50:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 16 Dec 2019 12:50:27 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 12:50:27 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 20:50:27 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 16 Dec 2019 20:50:20 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v10 Kernel 0/5] KABIs to support migration for VFIO devices 
Date: Tue, 17 Dec 2019 01:51:35 +0530
Message-ID: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576529419; bh=BgOwv2o4CTCcQspt5FGClKR4D3uCDj92wKjF5nLknrg=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:Content-Type;
 b=Jp084s/EeFOzyAT6SoeUUude2Rd7H/e1Ds++cHv+SAHcIUlCgh/y7nQFL5/RF7v0K
 HlCKpeXmJWRV4zzP7FSMXKNvucYDLTw6d0IRuq0qHD9sDi/43KgQgmnPMlvHYsUHDv
 faF8j0475HTsr2TSjR1gqTa0w3tS12ROgv/DjU8aWtpAcfv9nChKsMJmu5/CJ96lQz
 sVh0OQcszBZcsMrqiA7oY1bqaMjXhtcohDM5J5+T5v/s8zluvZdBAjfjHvdEKOrTC1
 dp3STCZHSWnJeV5E44PyVzSlDqrotFGezUb0xshxgHYVSRZPFm+2ohPbWxHd2QLuIv
 3WzUu2uCMseHQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This patch set adds:
* New IOCTL VFIO_IOMMU_DIRTY_PAGES to get dirty pages bitmap with
  respect to IOMMU container rather than per device. All pages pinned by
  vendor driver through vfio_pin_pages external API has to be marked as
  dirty during  migration. When IOMMU capable device is present in the
  container and all pages are pinned and mapped, then all pages are marked
  dirty.
  When there are CPU writes, CPU dirty page tracking can identify dirtied
  pages, but any page pinned by vendor driver can also be written by
  device. As of now there is no device which has hardware support for
  dirty page tracking. So all pages which are pinned should be considered
  as dirty.
  This ioctl is also used to start dirty pages tracking for unpinned pages
  while migration is active and device is running. These tracked unpinned
  pages information is cleaned on dirty bitmap read from VFIO application
  or if migration is failed or cancelled and unpinned pages tracking is
  stopped.
* Updated IOCTL VFIO_IOMMU_UNMAP_DMA to get dirty pages bitmap before
  unmapping IO virtual address range.
  With vIOMMU, during pre-copy phase of migration, while CPUs are still
  running, IO virtual address unmap can happen while device still keeping
  reference of guest pfns. Those pages should be reported as dirty before
  unmap, so that VFIO user space application can copy content of those
  pages from source to destination.

Yet TODO:
Since there is no device which has hardware support for system memmory
dirty bitmap tracking, right now there is no other API from vendor driver
to VFIO IOMMU module to report dirty pages. In future, when such hardware
support will be implemented, an API will be required such that vendor
driver could report dirty pages to VFIO module during migration phases.

If IOMMU capable device is present in the container, then all pages are
marked dirty. Need to think smart way to know if IOMMU capable device's
driver is smart to report pages to be marked dirty by pinning those pages
externally.

Adding revision history from previous QEMU patch set to understand KABI
changes done till now

v9 -> v10:
- Updated existing VFIO_IOMMU_UNMAP_DMA ioctl to get dirty pages bitmap
  during unmap while migration is active
- Added flag in VFIO_IOMMU_GET_INFO to indicate driver support dirty page
  tracking.
- If iommu_mapped, mark all pages dirty.
- Added unpinned pages tracking while migration is active.
- Updated comments for migration device state structure with bit
  combination table and state transition details.

v8 -> v9:
- Split patch set in 2 sets, Kernel and QEMU.
- Dirty pages bitmap is queried from IOMMU container rather than from
  vendor driver for per device. Added 2 ioctls to achieve this.

v7 -> v8:
- Updated comments for KABI
- Added BAR address validation check during PCI device's config space load
  as suggested by Dr. David Alan Gilbert.
- Changed vfio_migration_set_state() to set or clear device state flags.
- Some nit fixes.

v6 -> v7:
- Fix build failures.

v5 -> v6:
- Fix build failure.

v4 -> v5:
- Added decriptive comment about the sequence of access of members of
  structure vfio_device_migration_info to be followed based on Alex's
  suggestion
- Updated get dirty pages sequence.
- As per Cornelia Huck's suggestion, added callbacks to VFIODeviceOps to
  get_object, save_config and load_config.
- Fixed multiple nit picks.
- Tested live migration with multiple vfio device assigned to a VM.

v3 -> v4:
- Added one more bit for _RESUMING flag to be set explicitly.
- data_offset field is read-only for user space application.
- data_size is read for every iteration before reading data from migration,
  that is removed assumption that data will be till end of migration
  region.
- If vendor driver supports mappable sparsed region, map those region
  during setup state of save/load, similarly unmap those from cleanup
  routines.
- Handles race condition that causes data corruption in migration region
  during save device state by adding mutex and serialiaing save_buffer and
  get_dirty_pages routines.
- Skip called get_dirty_pages routine for mapped MMIO region of device.
- Added trace events.
- Split into multiple functional patches.

v2 -> v3:
- Removed enum of VFIO device states. Defined VFIO device state with 2
  bits.
- Re-structured vfio_device_migration_info to keep it minimal and defined
  action on read and write access on its members.

v1 -> v2:
- Defined MIGRATION region type and sub-type which should be used with
  region type capability.
- Re-structured vfio_device_migration_info. This structure will be placed
  at 0th offset of migration region.
- Replaced ioctl with read/write for trapped part of migration region.
- Added both type of access support, trapped or mmapped, for data section
  of the region.
- Moved PCI device functions to pci file.
- Added iteration to get dirty page bitmap until bitmap for all requested
  pages are copied.

Thanks,
Kirti



Kirti Wankhede (5):
  vfio: KABI for migration interface for device state
  vfio iommu: Adds flag to indicate dirty pages tracking capability
    support
  vfio iommu: Add ioctl defination for dirty pages tracking.
  vfio iommu: Implementation of ioctl to for dirty pages tracking.
  vfio iommu: Update UNMAP_DMA ioctl to get dirty bitmap before unmap

 drivers/vfio/vfio_iommu_type1.c | 276 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/vfio.h       | 240 +++++++++++++++++++++++++++++++++-
 2 files changed, 499 insertions(+), 17 deletions(-)

-- 
2.7.0


