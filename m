Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842FC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908FA21848
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RbgcYNTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908FA21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Kbu-0000If-E7
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1i2Kaa-0007bi-SF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1i2KaY-0000I1-Mr
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:23:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1i2KaY-0000H4-Dj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:23:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d6431b70000>; Mon, 26 Aug 2019 12:23:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 26 Aug 2019 12:23:34 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 26 Aug 2019 12:23:34 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 19:23:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 19:23:34 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Aug 2019 19:23:27 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Date: Tue, 27 Aug 2019 00:25:40 +0530
Message-ID: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1566847415; bh=UBBZgH1ObB5Vb0lK5KSAJWMoxAPyZotP+g8LSxK1R1k=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 X-NVConfidentiality:MIME-Version:Content-Type;
 b=RbgcYNTKeYZTl8DCYd2cTRNHLnr/NA6S1WxJPrznWFtHL4CkGS3l1fUT2NJ83D8Uv
 xl9ULjiYTEClgSuwdVEDzs8d4FbuzuOdjcX8JOznncEcHOa4ivDVAYHI+uznsDBr9p
 FXsmp56wYtIKxiS1m+xQkKHj5gGBXT1gyMqfKnqcmALikgTmrDYTO3Nlso4ykT+koR
 KXnc/ngYXyA2dNWsKuLaK7ATowqrcugqpZ637seniBjdraehGteIigS1xA747kuT38
 nqNLkoxd+4uzB8FqjiuCW/qTSNsBEhHIuhtmInas3HznsVsM2QetkvZS8lhbKDrekK
 SbM6GkGft1TrQ==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8
X-Received-From: 216.228.121.143
Subject: [Qemu-devel] [PATCH v8 00/13] Add migration support for VFIO device
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
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add migration support for VFIO device

This Patch set include patches as below:
- Define KABI for VFIO device for migration support.
- Added save and restore functions for PCI configuration space
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
  * Added function to get dirty pages bitmap for the pages which are used by
    driver.
- Add vfio_listerner_log_sync to mark dirty pages.
- Make VFIO PCI device migration capable. If migration region is not provided by
  driver, migration is blocked.

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


Kirti Wankhede (13):
  vfio: KABI for migration interface
  vfio: Add function to unmap VFIO region
  vfio: Add vfio_get_object callback to VFIODeviceOps
  vfio: Add save and load functions for VFIO PCI devices
  vfio: Add migration region initialization and finalize function
  vfio: Add VM state change handler to know state of VM
  vfio: Add migration state change notifier
  vfio: Register SaveVMHandlers for VFIO device
  vfio: Add save state functions to SaveVMHandlers
  vfio: Add load state functions to SaveVMHandlers
  vfio: Add function to get dirty page list
  vfio: Add vfio_listener_log_sync to mark dirty pages
  vfio: Make vfio-pci device migration capable.

 hw/vfio/Makefile.objs         |   2 +-
 hw/vfio/common.c              |  55 +++
 hw/vfio/migration.c           | 848 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 191 +++++++++-
 hw/vfio/trace-events          |  19 +
 include/hw/vfio/vfio-common.h |  22 ++
 linux-headers/linux/vfio.h    | 148 ++++++++
 7 files changed, 1278 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/migration.c

-- 
2.7.0


