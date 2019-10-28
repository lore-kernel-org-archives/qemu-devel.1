Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A022CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DAA720650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAA720650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOztq-0000ax-SJ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iOzpI-0000Qb-Tw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iOzpG-0002of-Ag
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:52:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:47953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iOzpG-0002mJ-28
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Oct 2019 00:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,239,1569308400"; d="scan'208";a="224558699"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 00:52:23 -0700
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
Subject: [PATCH v14 00/11] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Date: Mon, 28 Oct 2019 15:52:09 +0800
Message-Id: <20191028075220.25673-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series of patches will build Heterogeneous Memory Attribute Table (HMAT)
according to the command line. The ACPI HMAT describes the memory attributes,
such as memory side cache attributes and bandwidth and latency details,
related to the Memory Proximity Domain.
The software is expected to use HMAT information as hint for optimization.

In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
the platform's HMAT tables.

The V13 patches link:
https://patchwork.kernel.org/cover/11200909/

Changelog:
v14:
    - Reuse the codes of do_strtosz to build qemu_strtotime_ns
      (Eduardo)
    - Squash patch v13 01/12 and 02/12 together (Daniel and Eduardo)
    - Drop time unit picosecond (Eric)
    - Use qemu ctz64 and clz64 instead of builtin function
v13:
    - Modify some text description
    - Drop "initiator_valid" field in struct NodeInfo
    - Reuse Garray to store the raw bandwidth and bandwidth data
    - Calculate common base unit using range bitmap
    - Add a patch to alculate hmat latency and bandwidth entry list
    - Drop the total_levels option and use readable cache size
    - Remove the unnecessary head file
    - Use decimal notation with appropriate suffix for cache size
v12:
    - Fix a bug that a memory-only node without initiator setting
      doesn't report error. (reported by Danmei Wei)
    - Fix a bug that if HMAT is enabled and without hmat-lb setting,
      QEMU will crash. (reported by Danmei Wei)
v11:
    - Move numa option patches forward.
    - Add num_initiator in Numa_state to record the number of
    initiators.
    - Simplify struct HMAT_LB_Info, use uint64_t array to store data.
    - Drop hmat_get_base().
    - Calculate base in build_hmat_lb().
v10:
    - Add qemu_strtotime_ps() to convert strings with time suffixes
    to numbers, and add some tests for it.
    - Add qapi buildin type time, and add some tests for it.
    - Add machine oprion properties "-machine hmat=on|off" for
	  enabling or disabling HMAT in QEMU.

Liu Jingqi (5):
  numa: Extend CLI to provide memory latency and bandwidth information
  numa: Extend CLI to provide memory side cache information
  hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
  hmat acpi: Build System Locality Latency and Bandwidth Information
    Structure(s)
  hmat acpi: Build Memory Side Cache Information Structure(s)

Tao Xu (6):
  util/cutils: Add qemu_strtotime_ns()
  qapi: Add builtin type time
  tests: Add test for QAPI builtin type time
  numa: Extend CLI to provide initiator information for numa nodes
  numa: Calculate hmat latency and bandwidth entry list
  tests/bios-tables-test: add test cases for ACPI HMAT

 hw/acpi/Kconfig                    |   7 +-
 hw/acpi/Makefile.objs              |   1 +
 hw/acpi/hmat.c                     | 263 ++++++++++++++++++++++++++
 hw/acpi/hmat.h                     |  42 +++++
 hw/core/machine.c                  |  64 +++++++
 hw/core/numa.c                     | 284 ++++++++++++++++++++++++++++-
 hw/i386/acpi-build.c               |   5 +
 include/qapi/visitor-impl.h        |   4 +
 include/qapi/visitor.h             |   8 +
 include/qemu/cutils.h              |   1 +
 include/sysemu/numa.h              | 104 +++++++++++
 qapi/machine.json                  | 178 +++++++++++++++++-
 qapi/opts-visitor.c                |  22 +++
 qapi/qapi-visit-core.c             |  12 ++
 qapi/qobject-input-visitor.c       |  18 ++
 qapi/trace-events                  |   1 +
 qemu-options.hx                    |  96 +++++++++-
 scripts/qapi/schema.py             |   1 +
 tests/bios-tables-test.c           |  44 +++++
 tests/test-cutils.c                | 204 +++++++++++++++++++++
 tests/test-keyval.c                | 122 +++++++++++++
 tests/test-qobject-input-visitor.c |  29 +++
 util/cutils.c                      |  89 +++++----
 23 files changed, 1555 insertions(+), 44 deletions(-)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

-- 
2.20.1


