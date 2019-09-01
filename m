Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388FDC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F4822CE9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 14:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F4822CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4QmU-0006Hw-CW
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 10:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i4QjV-0004UO-Dq
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i4QjU-0004ew-6K
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:16707)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1i4QjT-0004Tv-Uq
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 10:21:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Sep 2019 07:21:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,455,1559545200"; d="scan'208";a="211453058"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2019 07:21:22 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  1 Sep 2019 22:21:08 +0800
Message-Id: <20190901142119.20482-1-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: [Qemu-devel] [PATCH v10 00/11] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
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
 qemu-devel@nongnu.org, daniel@linux.ibm.com, jonathan.cameron@huawei.com,
 dan.j.williams@intel.com
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

These patches depend on:
https://patchwork.kernel.org/project/qemu-devel/list/?series=166701

The V9 patches link:
https://patchwork.kernel.org/cover/11085475/

Changelog:
v10:
    - Add qemu_strtotime_ps() to convert strings with time suffixes
    to numbers, and add some tests for it.
    - Add qapi buildin type time, and add some tests for it.
    - Add machine oprion properties "-machine hmat=on|off" for
	  enabling or disabling HMAT in QEMU.
v9:
    - change the CLI input way, make it more user firendly (Daniel Black)
    use latency=NUM[p|n|u]s and bandwidth=NUM[M|G|P](B/s) as input and drop
    the base-lat and base-bw input.
v8:
    - rebase to upstream
    - Add check if numa->numa_state is NULL in pxb_dev_realize_common
    - Use nb_nodes in spapr_populate_memory() (RESEND to fix) (Igor)

Liu Jingqi (5):
  hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
  hmat acpi: Build System Locality Latency and Bandwidth Information
    Structure(s)
  hmat acpi: Build Memory Side Cache Information Structure(s)
  numa: Extend CLI to provide memory latency and bandwidth information
  numa: Extend CLI to provide memory side cache information

Tao Xu (6):
  util/cutils: Add qemu_strtotime_ps()
  tests/cutils: Add test for qemu_strtotime_ps()
  qapi: Add builtin type time
  tests: Add test for QAPI builtin type time
  numa: Extend CLI to provide initiator information for numa nodes
  tests/bios-tables-test: add test cases for ACPI HMAT

 hw/acpi/Kconfig                    |   5 +
 hw/acpi/Makefile.objs              |   1 +
 hw/acpi/hmat.c                     | 256 +++++++++++++++++++++++++++++
 hw/acpi/hmat.h                     | 103 ++++++++++++
 hw/core/machine.c                  |  72 ++++++++
 hw/core/numa.c                     | 242 +++++++++++++++++++++++++++
 hw/i386/acpi-build.c               |   3 +
 include/qapi/visitor-impl.h        |   4 +
 include/qapi/visitor.h             |   9 +
 include/qemu/cutils.h              |   1 +
 include/qemu/typedefs.h            |   2 +
 include/sysemu/numa.h              |  39 +++++
 qapi/machine.json                  | 182 +++++++++++++++++++-
 qapi/opts-visitor.c                |  22 +++
 qapi/qapi-visit-core.c             |  12 ++
 qapi/qobject-input-visitor.c       |  18 ++
 qapi/trace-events                  |   1 +
 qemu-options.hx                    |  96 ++++++++++-
 scripts/qapi/common.py             |   2 +
 tests/bios-tables-test.c           |  44 +++++
 tests/test-cutils.c                | 199 ++++++++++++++++++++++
 tests/test-keyval.c                | 125 ++++++++++++++
 tests/test-qobject-input-visitor.c |  29 ++++
 util/cutils.c                      |  82 +++++++++
 24 files changed, 1540 insertions(+), 9 deletions(-)
 create mode 100644 hw/acpi/hmat.c
 create mode 100644 hw/acpi/hmat.h

-- 
2.20.1


