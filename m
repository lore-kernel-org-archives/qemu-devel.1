Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2600C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 20:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBA620739
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 20:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OlDcnOph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBA620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkWl-0004jG-Is
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 16:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkVl-0003ew-Nx
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:54:49 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jmkVi-00008i-JH
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 16:54:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eee773a0000>; Sat, 20 Jun 2020 13:53:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Sat, 20 Jun 2020 13:54:43 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Sat, 20 Jun 2020 13:54:43 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 20 Jun
 2020 20:54:33 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
 Frontend Transport; Sat, 20 Jun 2020 20:54:25 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH QEMU v25 00/17] Add migration support for VFIO devices
Date: Sun, 21 Jun 2020 01:51:09 +0530
Message-ID: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592686394; bh=jlm5wymFmUwulvq1Ynrtt5tXsNXbl8B1hLwn1zhrxGE=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:Content-Type;
 b=OlDcnOphnFdwvFa9iwNEOOi7MCxHAItfLRvlPE0fx7lDo360fY9AB8lPsmvIijN47
 I/s3pLgJeNf/iWRNQifFjKHK0Q7oI/euo4Pzok+Ib2PltWYpDnUCyAzadPbt7OMx7+
 s2hWs4zpR0xG7TggazRJzvotitoK8Fo/rJgGpYKYdVlqx/T1f1u8QIBZO/wHwmI+ji
 ipzI6lvJuu55mhAhjEaGZaNZa1E077fMjXQbTqXiLKwKtnal4fv1fevlrjVAoGPlqf
 iCoPTISdxrnm9bBrZTOJlNz+c1YTriRUfMaYqMaaLnMc3fnVN+Fj1468JCoZdfETil
 a9svqySc6oKJg==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 16:54:43
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Sorry for little delay for this iteration. I had adresses most of the concerns
raised in v16, v18 and v23 versions. More details about changes below.

This Patch set adds migration support for VFIO devices in QEMU.

This Patch set include patches as below:
Patch 1-2:
- Few code refactor

Patch 3:
- Added save and restore functions for PCI configuration space. Used
  pci_device_save() and pci_device_load() so that config space cache is saved
  and restored. Similarly, to keep emulated_config_bits cache and
  vdev->pdev.wmask in sync after migration, these are also saved and restored.

Patch 4-9:
- Generic migration functionality for VFIO device.
  * This patch set adds functionality only for PCI devices, but can be
    extended to other VFIO devices.
  * Added all the basic functions required for pre-copy, stop-and-copy and
    resume phases of migration.
  * Added state change notifier and from that notifier function, VFIO
    device's state changed is conveyed to VFIO device driver.
  * During save setup phase and resume/load setup phase, migration region
    is queried and is used to read/write VFIO device data.
  * .save_live_pending and .save_live_iterate are implemented to use QEMU's
    functionality of iteration during pre-copy phase.
  * In .save_live_complete_precopy, that is in stop-and-copy phase,
    iteration to read data from VFIO device driver is implemented till pending
    bytes returned by driver are not zero.

Patch 10
- Set DIRTY_MEMORY_MIGRATION flag in dirty log mask for migration with vIOMMU
  enabled.

Patch 11:
- Get migration capability from kernel module.

Patch 12-14:
- Add function to start and stop dirty pages tracking.
- Add vfio_listerner_log_sync to mark dirty pages. Dirty pages bitmap is queried
  per container. All pages pinned by vendor driver through vfio_pin_pages
  external API has to be marked as dirty during  migration.
  When there are CPU writes, CPU dirty page tracking can identify dirtied
  pages, but any page pinned by vendor driver can also be written by
  device. As of now there is no device which has hardware support for
  dirty page tracking. So all pages which are pinned by vendor driver
  should be considered as dirty.
  In Qemu, marking pages dirty is only done when device is in stop-and-copy
  phase because if pages are marked dirty during pre-copy phase and content is
  transfered from source to distination, there is no way to know newly dirtied
  pages from the point they were copied earlier until device stops. To avoid
  repeated copy of same content, pinned pages are marked dirty only during
  stop-and-copy phase.

Patch 15:
- With vIOMMU, IO virtual address range can get unmapped while in pre-copy
  phase of migration. In that case, unmap ioctl should return pages pinned
  in that range and QEMU should report corresponding guest physical pages
  dirty.

Patch 16:
- Make VFIO PCI device migration capable. If migration region is not provided by
  driver, migration is blocked.

Patch 17:
- Added VFIO device stats to MigrationInfo

Yet TODO:
Since there is no device which has hardware support for system memmory
dirty bitmap tracking, right now there is no other API from vendor driver
to VFIO IOMMU module to report dirty pages. In future, when such hardware
support will be implemented, an API will be required in kernel such that
vendor driver could report dirty pages to VFIO module during migration phases.

Below is the flow of state change for live migration where states in brackets
represent VM state, migration state and VFIO device state as:
    (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)

Live migration save path:
        QEMU normal running state
        (RUNNING, _NONE, _RUNNING)
                        |
    migrate_init spawns migration_thread.
    (RUNNING, _SETUP, _RUNNING|_SAVING)
    Migration thread then calls each device's .save_setup()
                        |
    (RUNNING, _ACTIVE, _RUNNING|_SAVING)
    If device is active, get pending bytes by .save_live_pending()
    if pending bytes >= threshold_size,  call save_live_iterate()
    Data of VFIO device for pre-copy phase is copied.
    Iterate till pending bytes converge and are less than threshold
                        |
    On migration completion, vCPUs stops and calls .save_live_complete_precopy
    for each active device. VFIO device is then transitioned in
     _SAVING state.
    (FINISH_MIGRATE, _DEVICE, _SAVING)
    For VFIO device, iterate in  .save_live_complete_precopy  until
    pending data is 0.
    (FINISH_MIGRATE, _DEVICE, _STOPPED)
                        |
    (FINISH_MIGRATE, _COMPLETED, STOPPED)
    Migraton thread schedule cleanup bottom half and exit

Live migration resume path:
    Incomming migration calls .load_setup for each device
    (RESTORE_VM, _ACTIVE, STOPPED)
                        |
    For each device, .load_state is called for that device section data
                        |
    At the end, called .load_cleanup for each device and vCPUs are started.
                        |
        (RUNNING, _NONE, _RUNNING)

Note that:
- Migration post copy is not supported.

v23 -> 25
- Updated config space save and load to save config cache, emulated bits cache
  and wmask cache.
- Created idr string as suggested by Dr Dave that includes bus path.
- Updated save and load function to read/write data to mixed regions, mapped or
  trapped.
- When vIOMMU is enabled, created mapped iova range list which also keeps
  translated address. This list is used to mark dirty pages. This reduces
  downtime significantly with vIOMMU enabled than migration patches from
   previous version. 
- Removed get_address_limit() function from v23 patch as this not required now.

v22 -> v23
-- Fixed issue reported by Yan
https://lore.kernel.org/kvm/97977ede-3c5b-c5a5-7858-7eecd7dd531c@nvidia.com/
- Sending this version to test v23 kernel version patches:
https://lore.kernel.org/kvm/1589998088-3250-1-git-send-email-kwankhede@nvidia.com/

v18 -> v22
- Few fixes from v18 review. But not yet fixed all concerns. I'll address those
  concerns in subsequent iterations.
- Sending this version to test v22 kernel version patches:
https://lore.kernel.org/kvm/1589781397-28368-1-git-send-email-kwankhede@nvidia.com/

v16 -> v18
- Nit fixes
- Get migration capability flags from container
- Added VFIO stats to MigrationInfo
- Fixed bug reported by Yan
    https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00004.html

v9 -> v16
- KABI almost finalised on kernel patches.
- Added support for migration with vIOMMU enabled.

v8 -> v9:
- Split patch set in 2 sets, Kernel and QEMU sets.
- Dirty pages bitmap is queried from IOMMU container rather than from
  vendor driver for per device. Added 2 ioctls to achieve this.

v7 -> v8:
- Updated comments for KABI
- Added BAR address validation check during PCI device's config space load as
  suggested by Dr. David Alan Gilbert.
- Changed vfio_migration_set_state() to set or clear device state flags.
- Some nit fixes.

v6 -> v7:
- Fix build failures.

v5 -> v6:
- Fix build failure.

v4 -> v5:
- Added decriptive comment about the sequence of access of members of structure
  vfio_device_migration_info to be followed based on Alex's suggestion
- Updated get dirty pages sequence.
- As per Cornelia Huck's suggestion, added callbacks to VFIODeviceOps to
  get_object, save_config and load_config.
- Fixed multiple nit picks.
- Tested live migration with multiple vfio device assigned to a VM.

v3 -> v4:
- Added one more bit for _RESUMING flag to be set explicitly.
- data_offset field is read-only for user space application.
- data_size is read for every iteration before reading data from migration, that
  is removed assumption that data will be till end of migration region.
- If vendor driver supports mappable sparsed region, map those region during
  setup state of save/load, similarly unmap those from cleanup routines.
- Handles race condition that causes data corruption in migration region during
  save device state by adding mutex and serialiaing save_buffer and
  get_dirty_pages routines.
- Skip called get_dirty_pages routine for mapped MMIO region of device.
- Added trace events.
- Splitted into multiple functional patches.

v2 -> v3:
- Removed enum of VFIO device states. Defined VFIO device state with 2 bits.
- Re-structured vfio_device_migration_info to keep it minimal and defined action
  on read and write access on its members.

v1 -> v2:
- Defined MIGRATION region type and sub-type which should be used with region
  type capability.
- Re-structured vfio_device_migration_info. This structure will be placed at 0th
  offset of migration region.
- Replaced ioctl with read/write for trapped part of migration region.
- Added both type of access support, trapped or mmapped, for data section of the
  region.
- Moved PCI device functions to pci file.
- Added iteration to get dirty page bitmap until bitmap for all requested pages
  are copied.

Thanks,
Kirti




Kirti Wankhede (17):
  vfio: Add function to unmap VFIO region
  vfio: Add vfio_get_object callback to VFIODeviceOps
  vfio: Add save and load functions for VFIO PCI devices
  vfio: Add migration region initialization and finalize function
  vfio: Add VM state change handler to know state of VM
  vfio: Add migration state change notifier
  vfio: Register SaveVMHandlers for VFIO device
  vfio: Add save state functions to SaveVMHandlers
  vfio: Add load state functions to SaveVMHandlers
  memory: Set DIRTY_MEMORY_MIGRATION when IOMMU is enabled
  vfio: Get migration capability flags for container
  vfio: Add function to start and stop dirty pages tracking
  vfio: create mapped iova list when vIOMMU is enabled
  vfio: Add vfio_listener_log_sync to mark dirty pages
  vfio: Add ioctl to get dirty pages bitmap during dma unmap.
  vfio: Make vfio-pci device migration capable
  qapi: Add VFIO devices migration stats in Migration stats

 hw/vfio/Makefile.objs         |   2 +-
 hw/vfio/common.c              | 416 ++++++++++++++++++--
 hw/vfio/migration.c           | 855 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 135 +++++--
 hw/vfio/pci.h                 |   1 -
 hw/vfio/trace-events          |  19 +
 include/hw/vfio/vfio-common.h |  30 ++
 include/qemu/vfio-helpers.h   |   3 +
 memory.c                      |   2 +-
 migration/migration.c         |  14 +
 monitor/hmp-cmds.c            |   6 +
 qapi/migration.json           |  17 +
 12 files changed, 1454 insertions(+), 46 deletions(-)
 create mode 100644 hw/vfio/migration.c

-- 
2.7.0


