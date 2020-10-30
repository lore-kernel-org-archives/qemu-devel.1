Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA1C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DF620739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RBn4VI2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DF620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKFM-0007hu-Eo
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDo-0005ch-BP; Thu, 29 Oct 2020 22:32:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDk-0006bi-KS; Thu, 29 Oct 2020 22:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604025172; x=1635561172;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pt++w6kwyoSrYCu89Spq3Alu69ZefGTgOx99qpbFFjk=;
 b=RBn4VI2AE8WixzOiyOiP/thegjfXLyghEFG+5vNBQcvI1ddbIy83siKe
 SceYn/vrAGCnhE0XCodv68GX+Jk0LBujrgrVrGy6wNKu4WoZGtVJ611F8
 3Pnq7tl5ZzvAb2TxMIrBjLRdmlWxoMTVtMJnhmBvyO7jAWeNGtWKJC7bm
 wGi/IVmw3e/W/XkNEV5D0tRyoddifc6VXtEScdl1JPHcaTxJDejQBDJe4
 iFRkS9+HsYUSHHe5xZi4XLQ3phCPd8PdcwiRPhn4stXfejfxA3IMaSLe+
 VhAdSAg2ydc2IOqap9nehAzLZT/cR9vMCi2+DzAPN3iQyvomezG2raIxS w==;
IronPort-SDR: 0TvqczD6q4SrRLz290focuSUh+SfvdMPK1vzxbDDSeuuZnajoRTPo4znNjEu5QVt4DsJ1ZzF9p
 yidf7KOfKIZ5VlIy3biMEC1FUiSASQOmyJMLrgpxwkOpyJ0AZeQ4mPWV5PA/iVLc0nQLNvUScO
 oXlJJJlfFqen2cYA84Yb/sQNPQu3QavVi/hleDsiUqvLtQl52f6N2UjOId7yUy5n8BrETF4f15
 +/EXKV739sKbITgo1RF4dLRRVnUGXeqnlRAtX9V6JEuNZU2X4vrVZavVGudYdxOJHEjedd4084
 sVM=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155748048"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 10:32:48 +0800
IronPort-SDR: W9THSjeZZkOxxJx0UmWcVYtWNaLXR86V8PTeyFHtkzZgP787Q4bUSGshYEmR9bDcguIa+XOn/c
 ks7CmSzL+SEX7j6XczAY+qZLFr/BixsDzDiCfyoP1mIezSfmpDjupAnk0uBGXTo4kZkV1WeQL+
 r9vwR+95PEKzs5cL6Qq+gj0vMNEkyZoFaDzbjkne+gespwJ8xxfD4RK1B1ka+8dNZUiTWtW7Hh
 pFliJ25tXw8Gun/BMQPcEi9F+CYG5kq02g0Kqm3mshaHPpFlPEEDpgOLaW30V//VvSJkKdAzIL
 uxeY1zVTFsX+os0FaIIEOPoR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:17:52 -0700
IronPort-SDR: AjFjVVI5ccrqDY3C8enfryL+pyVbIGUAAZNPPjMBYhXthWqaMXyhA/EPmjv7IZ4OQ8y+Wird0h
 sCtp3ii3xy5u8FmQBBvyw5BkSABA7pjyreHDuWUcgLI/c1jhjucXln4HHG9k1rsobh32A8k59u
 ETpOXA22PvOE6BJGfZpbErVK+tfi9k31VK/z1Wm1IExyxpeGg7pQmiR1AxW/cvfKj81vtZw8H1
 bR/DWiiyIv5rEjYDZ2nGP8TOREyoFPXesRiwit8a/cCIqDrWUFAHw3XzZQZvUXx2FhvLlrJcjF
 L5A=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 19:32:47 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v8 00/11] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Date: Fri, 30 Oct 2020 11:32:31 +0900
Message-Id: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=56530b5a8=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 22:32:49
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v7 -> v8:

 - Move refactoring commits to the front of the series.

 - Remove "attached" and "fill_pattern" device properties.

 - Only close open zones upon subsystem shutdown, not when CC.EN flag
   is set to 0. Avoid looping through all zones by iterating through
   lists of open and closed zones.

 - Improve bulk processing of zones aka zoned operations with "all"
   flag set. Avoid looping through the entire zone array for all zone
   operations except Offline Zone.

 - Prefix ZNS-related property names with "zoned.". The "zoned" Boolean
   property is retained to turn on zoned command set as it is much more
   intuitive and user-friendly compared to setting a magic number value
   to csi property.

 - Address review comments.

 - Remove unused trace events.

v6 -> v7:

 - Introduce ns->iocs initialization function earlier in the series,
   in CSE Log patch.

 - Set NVM iocs for zoned namespaces when CC.CSS is set to
   NVME_CC_CSS_NVM.

 - Clean up code in CSE log handler.
 
v5 -> v6:

 - Remove zoned state persistence code. Replace position-independent
   zone lists with QTAILQs.

 - Close all open zones upon clearing of the controller. This is
   a similar procedure to the one previously performed upon powering
   up with zone persistence. 

 - Squash NS Types and ZNS triplets of commits to keep definitions
   and trace event definitions together with the implementation code.

 - Move namespace UUID generation to a separate patch. Add the new
   "uuid" property as suggested by Klaus.

 - Rework Commands and Effects patch to make sure that the log is
   always in sync with the actual set of commands supported.

 - Add two refactoring commits at the end of the series to
   optimize read and write i/o path.

- Incorporate feedback from Keith, Klaus and Niklas:

  * fix rebase errors in nvme_identify_ns_descr_list()
  * remove unnecessary code from nvme_write_bar()
  * move csi to NvmeNamespace and use it from the beginning in NSTypes
    patch
  * change zone read processing to cover all corner cases with RAZB=1
  * sync w_ptr and d.wp in case of a i/o error at the preceding zone
  * reword the commit message in active/inactive patch with the new
    text from Niklas
  * correct dlfeat reporting depending on the fill pattern set
  * add more checks for "attached" n/s parameter to prevent i/o and
    get/set features on inactive namespaces
  * Use DEFINE_PROP_SIZE and DEFINE_PROP_SIZE32 for zone size/capacity
    and ZASL respectively
  * Improve zone size and capacity validation
  * Correctly report NSZE

v4 -> v5:

 - Rebase to the current qemu-nvme.

 - Use HostMemoryBackendFile as the backing storage for persistent
   zone metadata.

 - Fix the issue with filling the valid data in the next zone if RAZB
   is enabled.

v3 -> v4:

 - Fix bugs introduced in v2/v3 for QD > 1 operation. Now, all writes
   to a zone happen at the new write pointer variable, zone->w_ptr,
   that is advanced right after submitting the backend i/o. The existing
   zone->d.wp variable is updated upon the successful write completion
   and it is used for zone reporting. Some code has been split from
   nvme_finalize_zoned_write() function to a new function,
   nvme_advance_zone_wp().

 - Make the code compile under mingw. Switch to using QEMU API for
   mmap/msync, i.e. memory_region...(). Since mmap is not available in
   mingw (even though there is mman-win32 library available on Github),
   conditional compilation is added around these calls to avoid
   undefined symbols under mingw. A better fix would be to add stub
   functions to softmmu/memory.c for the case when CONFIG_POSIX is not
   defined, but such change is beyond the scope of this patchset and it
   can be made in a separate patch.

 - Correct permission mask used to open zone metadata file.

 - Fold "Define 64 bit cqe.result" patch into ZNS commit.

 - Use clz64/clz32 instead of defining nvme_ilog2() function.

 - Simplify rpt_empty_id_struct() code, move nvme_fill_data() back
   to ZNS patch.

 - Fix a power-on processing bug.

 - Rename NVME_CMD_ZONE_APND to NVME_CMD_ZONE_APPEND.

 - Make the list of review comments addressed in v2 of the series
   (see below).

v2 -> v3:

 - Moved nvme_fill_data() function to the NSTypes patch as it is
   now used there to output empty namespace identify structs.
 - Fixed typo in Maxim's email address.

v1 -> v2:

 - Rebased on top of qemu-nvme/next branch.
 - Incorporated feedback from Klaus and Alistair.
    * Allow a subset of CSE log to be read, not the entire log
    * Assign admin command entries in CSE log to ACS fields
    * Set LPA bit 1 to indicate support of CSE log page
    * Rename CC.CSS value CSS_ALL_NSTYPES (110b) to CSS_CSI
    * Move the code to assign lbaf.ds to a separate patch
    * Remove the change in firmware revision
    * Change "driver" to "device" in comments and annotations
    * Rename ZAMDS to ZASL
    * Correct a few format expressions and some wording in
      trace event definitions
    * Remove validation code to return NVME_CAP_EXCEEDED error
    * Make ZASL to be equal to MDTS if "zone_append_size_limit"
      module parameter is not set
    * Clean up nvme_zoned_init_ctrl() to make size calculations
      less confusing
    * Avoid changing module parameters, use separate n/s variables
      if additional calculations are necessary to convert parameters
      to running values
    * Use NVME_DEFAULT_ZONE_SIZE to assign the default zone size value
    * Use default 0 for zone capacity meaning that zone capacity will
      be equal to zone size by default
    * Issue warnings if user MAR/MOR values are too large and have
      to be adjusted
    * Use unsigned values for MAR/MOR
 - Dropped "Simulate Zone Active excursions" patch.
   Excursion behavior may depend on the internal controller
   architecture and therefore be vendor-specific.
 - Dropped support for Zone Attributes and zoned AENs for now.
   These features can be added in a future series.
 - NS Types support is extended to handle active/inactive namespaces.
 - Update the write pointer after backing storage I/O completion, not
   before. This makes the emulation to run correctly in case of
   backing device failures.
 - Avoid division in the I/O path if the device zone size is
   a power of two (the most common case). Zone index then can be
   calculated by using bit shift.
 - A few reported bugs have been fixed.
 - Indentation in function definitions has been changed to make it
   the same as the rest of the code.

Zoned Namespace (ZNS) Command Set is a newly introduced command set
published by the NVM Express, Inc. organization as TP 4053. The main
design goals of ZNS are to provide hardware designers the means to
reduce NVMe controller complexity and to allow achieving a better I/O
latency and throughput. SSDs that implement this interface are
commonly known as ZNS SSDs.

This command set is implementing a zoned storage model, similarly to
ZAC/ZBC. As such, there is already support in Linux, allowing one to
perform the majority of tasks needed for managing ZNS SSDs.

The Zoned Namespace Command Set relies on another TP, known as
Namespace Types (NVMe TP 4056), which introduces support for having
multiple command sets per namespace.

Both ZNS and Namespace Types specifications can be downloaded by
visiting the following link -

https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip

This patch series adds Namespace Types support and zoned namespace
emulation capability to the existing NVMe PCI device.


Based-on: <20201013174826.GA1049145@dhcp-10-100-145-180.wdl.wdc.com>

Dmitry Fomichev (9):
  hw/block/nvme: Add Commands Supported and Effects log
  hw/block/nvme: Generate namespace UUIDs
  hw/block/nvme: Separate read and write handlers
  hw/block/nvme: Merge nvme_write_zeroes() with nvme_write()
  hw/block/nvme: Support Zoned Namespace Command Set
  hw/block/nvme: Introduce max active and open zone limits
  hw/block/nvme: Support Zone Descriptor Extensions
  hw/block/nvme: Add injection of Offline/Read-Only zones
  hw/block/nvme: Document zoned parameters in usage text

Niklas Cassel (2):
  hw/block/nvme: Add support for Namespace Types
  hw/block/nvme: Support allocated CNS command variants

 block/nvme.c          |    2 +-
 hw/block/nvme-ns.c    |  276 +++++++
 hw/block/nvme-ns.h    |  109 +++
 hw/block/nvme.c       | 1615 ++++++++++++++++++++++++++++++++++++++---
 hw/block/nvme.h       |    8 +
 hw/block/trace-events |   32 +-
 include/block/nvme.h  |  204 +++++-
 7 files changed, 2113 insertions(+), 133 deletions(-)

-- 
2.21.0


