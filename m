Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F0EC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8EC20756
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kwFWx8+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8EC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY1P9-0000TW-Qn
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 02:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kY1NU-0008O6-Mc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 02:25:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kY1NR-0005nJ-Rl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 02:25:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f9a60640000>; Wed, 28 Oct 2020 23:25:40 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 06:25:33 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 29 Oct 2020 06:25:31 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>
Subject: [PATCH v1] docs/devel: Add VFIO device migration documentation
Date: Thu, 29 Oct 2020 11:23:11 +0530
Message-ID: <1603950791-27236-1-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603952740; bh=31fOGHJD4jhVEFNZH0XgVy7Vfn6lxXxYD3o9bsS9sZA=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
 MIME-Version:Content-Type;
 b=kwFWx8+GOQx5IKIxXWvkNQ2uB95kNL9oQKn0xwlOleGxhK0UySHlsEtwiVPwV8h1Y
 3C41JG8CVc32hbsYxBDeDCURwtdszCajUB+k5SupniVlbX/XNUt5/XzT3LP0DrDfbi
 92Q9SYJn8UOSwjKoS9uotIqUyS/rhjwseTLti0Nb9lUqJxY2JDlYLBuaHT9izXHojr
 tzLp5Lk1WQD3P/hGFU96VC+HtE6ky07FozcS8tQgcXUgTaYPO+OxnhC0DppqUK6jj4
 INODhdZv+WIZGx85xlnphCiQy5f1aDO+rK9YXeUP1NxaHupCCg7w8G1MVYoBBjx+3a
 psA27bypFFJAQ==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 02:25:34
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mcrossley@nvidia.com, cjia@nvidia.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Kirti
 Wankhede <kwankhede@nvidia.com>, dnigam@nvidia.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document interfaces used for VFIO device migration. Added flow of state
changes during live migration with VFIO device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 MAINTAINERS                   |   1 +
 docs/devel/vfio-migration.rst | 119 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 docs/devel/vfio-migration.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a197bd358d6..6f3fcffc6b3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1728,6 +1728,7 @@ M: Alex Williamson <alex.williamson@redhat.com>
 S: Supported
 F: hw/vfio/*
 F: include/hw/vfio/
+F: docs/devel/vfio-migration.rst
 
 vfio-ccw
 M: Cornelia Huck <cohuck@redhat.com>
diff --git a/docs/devel/vfio-migration.rst b/docs/devel/vfio-migration.rst
new file mode 100644
index 000000000000..dab9127825e4
--- /dev/null
+++ b/docs/devel/vfio-migration.rst
@@ -0,0 +1,119 @@
+=====================
+VFIO device Migration
+=====================
+
+VFIO devices use iterative approach for migration because certain VFIO devices
+(e.g. GPU) have large amount of data to be transfered. The iterative pre-copy
+phase of migration allows for the guest to continue whilst the VFIO device state
+is transferred to destination, this helps to reduce the total downtime of the
+VM. VFIO devices can choose to skip the pre-copy phase of migration by returning
+pending_bytes as zero during pre-copy phase.
+
+Detailed description of UAPI for VFIO device for migration is in the comment
+above ``vfio_device_migration_info`` structure definition in header file
+linux-headers/linux/vfio.h.
+
+VFIO device hooks for iterative approach:
+-  A ``save_setup`` function that setup migration region, sets _SAVING flag in
+VFIO device state and inform VFIO IOMMU module to start dirty page tracking.
+
+- A ``load_setup`` function that setup migration region on the destination and
+sets _RESUMING flag in VFIO device state.
+
+- A ``save_live_pending`` function that reads pending_bytes from vendor driver
+that indicate how much more data the vendor driver yet to save for the VFIO
+device.
+
+- A ``save_live_iterate`` function that reads VFIO device's data from vendor
+driver through migration region during iterative phase.
+
+- A ``save_live_complete_precopy`` function that resets _RUNNING flag from VFIO
+device state, saves device config space, if any, and iteratively copies
+remaining data for VFIO device till pending_bytes returned by vendor driver
+is zero.
+
+- A ``load_state`` function loads config section and data sections generated by
+above save functions.
+
+- ``cleanup`` functions for both save and load that unmap migration region.
+
+VM state change handler is registered to change VFIO device state based on VM
+state change.
+
+Similarly, a migration state change notifier is added to get a notification on
+migration state change. These states are translated to VFIO device state and
+conveyed to vendor driver.
+
+System memory dirty pages tracking
+----------------------------------
+
+A ``log_sync`` memory listener callback is added to mark system memory pages
+as dirty which are used for DMA by VFIO device. Dirty pages bitmap is queried
+per container. All pages pinned by vendor driver through vfio_pin_pages()
+external API have to be marked as dirty during migration. When there are CPU
+writes, CPU dirty page tracking can identify dirtied pages, but any page pinned
+by vendor driver can also be written by device. There is currently no device
+which has hardware support for dirty page tracking. So all pages which are
+pinned by vendor driver are considered as dirty.
+Dirty pages are tracked when device is in stop-and-copy phase because if pages
+are marked dirty during pre-copy phase and content is transfered from source to
+destination, there is no way to know newly dirtied pages from the point they
+were copied earlier until device stops. To avoid repeated copy of same content,
+pinned pages are marked dirty only during stop-and-copy phase.
+
+System memory dirty pages tracking when vIOMMU is enabled
+---------------------------------------------------------
+With vIOMMU, IO virtual address range can get unmapped while in pre-copy phase
+of migration. In that case, unmap ioctl returns pages pinned in that range and
+QEMU reports corresponding guest physical pages dirty.
+During stop-and-copy phase, an IOMMU notifier is used to get a callback for
+mapped pages and then dirty pages bitmap is fetched from VFIO IOMMU modules for
+those mapped ranges.
+
+Flow of state changes during Live migration
+===========================================
+Below is the flow of state change during live migration where states in brackets
+represent VM state, migration state and VFIO device state as:
+                (VM state, MIGRATION_STATUS, VFIO_DEVICE_STATE)
+
+Live migration save path
+------------------------
+                        QEMU normal running state
+                        (RUNNING, _NONE, _RUNNING)
+                                    |
+                       migrate_init spawns migration_thread
+                Migration thread then calls each device's .save_setup()
+                        (RUNNING, _SETUP, _RUNNING|_SAVING)
+                                    |
+                        (RUNNING, _ACTIVE, _RUNNING|_SAVING)
+            If device is active, get pending_bytes by .save_live_pending()
+         if total pending_bytes >= threshold_size, call .save_live_iterate()
+                  Data of VFIO device for pre-copy phase is copied
+     Iterate till total pending bytes converge and are less than threshold
+                                    |
+   On migration completion, vCPUs stops and calls .save_live_complete_precopy
+   for each active device. VFIO device is then transitioned in _SAVING state
+                    (FINISH_MIGRATE, _DEVICE, _SAVING)
+                                    |
+For VFIO device, iterate in .save_live_complete_precopy until pending data is 0
+                    (FINISH_MIGRATE, _DEVICE, _STOPPED)
+                                    |
+                    (FINISH_MIGRATE, _COMPLETED, _STOPPED)
+                Migraton thread schedule cleanup bottom half and exit
+
+Live migration resume path
+--------------------------
+
+             Incoming migration calls .load_setup for each device
+                        (RESTORE_VM, _ACTIVE, _STOPPED)
+                                    |
+    For each device, .load_state is called for that device section data
+                        (RESTORE_VM, _ACTIVE, _RESUMING)
+                                    |
+    At the end, called .load_cleanup for each device and vCPUs are started                        |
+                        (RUNNING, _NONE, _RUNNING)
+
+
+Postcopy
+========
+Postcopy migration is not supported for VFIO devices.
-- 
2.7.0


