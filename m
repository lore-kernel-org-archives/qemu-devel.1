Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC592C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AACA20728
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 02:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ES4FF1oE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AACA20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaVQo-0000sz-E3
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 21:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPM-0007RE-Mg; Wed, 04 Nov 2020 21:53:53 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=571894d84=dmitry.fomichev@wdc.com>)
 id 1kaVPJ-0002ZQ-Jf; Wed, 04 Nov 2020 21:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604544829; x=1636080829;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AoiTBnlJD+ipED0rBW3DfW2P3Li1+UhMMH2O4oJguyM=;
 b=ES4FF1oEwW4QhReZVQmR+Ya1PYzjgkZq5aOn97jD1zhoRIRFAamWaYOY
 56zficOe0/7H4uZ1AsiLK6a+z+fRku41fs5Vgtt6CnsHDVJ+vMzAyACk7
 IpdeAELwJIPqWsLsPDVFzAFFJa6VBLoZg2Rl6xdHeQADj7jWBympLSDz2
 ZCZtgcWBnA5axT3fb9ljKrp4NhRCcKnRYYbpR0b4OJ7zmFk/uVwY5i8Gr
 9HG8pKss7eGincFDzyF5tFXH7Zb6igq1fgqqpl+rx5Q+4GzEEqqGbw3Pk
 g+xVKTFez/HYZ2tNg71i2K9a2LSXG8hncms3yBI6hFe5So5xRDLAPHWqf g==;
IronPort-SDR: Ti/WFS4pEPCWHu5AYmV8/FNdVIsM9D3Gp+kpQr39mQt7bgjW0YXko9t/Vwt4MOeR/4TBRttO3w
 5qPrXbgBWyS9hqReBGSkXT2x7hYXuKT7gi2FFJqZK0zr/FpYF3cFtGjpCXDFC/bnrQ9HLHsZw3
 R2KlPHmTEpKTpFhr5ouXPtyC08UyjOQiCTdy+sXNFneEpt9yni5osyLl+LJNz9TWiXWi8AkI2K
 sdGz3ApDOTOz5JrN2up+HmEnyjOiLSdRAWBMdXyAFOO3SoIP0LI4iu0pDT0yXyZVNe/y2Ed0ye
 omo=
X-IronPort-AV: E=Sophos;i="5.77,452,1596470400"; d="scan'208";a="156335122"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 10:53:45 +0800
IronPort-SDR: t799sfJOIbAtXW/K8y/xUJR460RYEC/ICNBCJadaZCSRITGncQyTigZP+L9BIhSrhjeMkEHeCT
 DOzQoULYAnYEWq/G1c9YSbjOSFZ44WTftD4qNL4ucgnbuSJvObeHS5TMKu1DpP5ZunXWxsGDz1
 hMtfmn4BQFhVPHKfEXRL3OXrhz9cjIditWWGJVPYe0s6BJ2YDvUOUVqgZJSOzNw4BxwmH7e6LM
 BlNLcvySkOmztnpPGr3NUYoclm0Wmf/orqc+wv5nAd8aZhRRBbMXTSEM2TqIX3ak/BMmwRKw6W
 p1FjQPt1MoEkMov2a4fWv40l
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2020 18:39:52 -0800
IronPort-SDR: VtCxpzeeAAuiztg9aS3E+ap6PfcbQePzi41PxP8phcS1P6zr5BnLMYB5dZWBe6hgSoBNHtPetO
 89gBSuIRkqU+WA7Gmnwr+QOuy0k4N6VSeEjfmqpkTVcUINfsUG+d8LMEIzAESHz6edUsY/PWJi
 8SWpuWVRYAYV3iayq1f+9XirTyaYldXHGzFsMOpdSwXI3wjugMq0cl2MC7HUhmGtHiCdoy6MJZ
 IJk5PRZaO4O2TgT7xjp4PFryb/SKG73QlyhCcMd70Ws5hGfMVKkJ4YqsMeonihgKXrRMPAfVcI
 m+g=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 18:53:44 -0800
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v9 00/12] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Date: Thu,  5 Nov 2020 11:53:30 +0900
Message-Id: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=571894d84=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 21:53:45
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

v8 -> v9:

 - Move the modifications to "include/block/nvme.h" made to
   introduce ZNS-related definitions into a separate patch.

 - Add a new struct, NvmeZonedResult, along the same lines as the
   existing NvmeAerResult, to carry Zone Append LBA returned to
   the host. Now, there is no need to modify NvmeCqe struct except
   renaming DW1 field from "rsvd" to "dw1".

 - Add check for MDTS in Zone Management Receive handler.

 - Remove checks for ns->attached since the value of this flag
   is always true for now.

 - Rebase to the current quemu-nvme/nvme-next branch.

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

Based-on: <20201104102248.32168-1-its@irrelevant.dk>

Dmitry Fomichev (10):
  hw/block/nvme: Add Commands Supported and Effects log
  hw/block/nvme: Generate namespace UUIDs
  hw/block/nvme: Separate read and write handlers
  hw/block/nvme: Merge nvme_write_zeroes() with nvme_write()
  block/nvme: Make ZNS-related definitions
  hw/block/nvme: Support Zoned Namespace Command Set
  hw/block/nvme: Introduce max active and open zone limits
  hw/block/nvme: Support Zone Descriptor Extensions
  hw/block/nvme: Add injection of Offline/Read-Only zones
  hw/block/nvme: Document zoned parameters in usage text

Niklas Cassel (2):
  hw/block/nvme: Add support for Namespace Types
  hw/block/nvme: Support allocated CNS command variants

 hw/block/nvme-ns.h    |  109 +++
 hw/block/nvme.h       |    8 +
 include/block/nvme.h  |  205 +++++-
 hw/block/nvme-ns.c    |  276 +++++++
 hw/block/nvme.c       | 1590 ++++++++++++++++++++++++++++++++++++++---
 hw/block/trace-events |   32 +-
 6 files changed, 2095 insertions(+), 125 deletions(-)

-- 
2.21.0


