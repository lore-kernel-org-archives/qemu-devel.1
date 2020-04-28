Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056AEC83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 01:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB566206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 01:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB566206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTF46-0000dk-R4
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 21:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTF3A-0007Rc-CL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTF39-0005V9-6Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:49886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jTF38-0005Tt-J2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:38 -0400
IronPort-SDR: 4JZ5K4SPPeZLgmhbnQFXriuRoReV2fbXSTuRjEu+vvMRALZ72/SFiAS4CaKpi6kHjnGLiC4jV/
 C7Sw9zCqDHEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 18:28:27 -0700
IronPort-SDR: Thr4S/4uKIuWuMY90jDxh4rJaxPOq5zlaeyg7TcSBjMYh+esz5lVLGGV5Emv9ersoQWH1MiwOf
 /H7+lcp0O8+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="249040056"
Received: from vverma7-mobl4.lm.intel.com ([10.254.191.96])
 by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2020 18:28:27 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 0/3] account for NVDIMM nodes during SRAT generation
Date: Mon, 27 Apr 2020 19:28:07 -0600
Message-Id: <20200428012810.10877-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=vishal.l.verma@intel.com; helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 21:28:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.136
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
Cc: jingqi.liu@intel.com, Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On the command line, one can specify a NUMA node for NVDIMM devices. If
we set up the topology to give NVDIMMs their own nodes, i.e. not
containing any CPUs or regular memory, qemu doesn't populate SRAT memory
affinity structures for these nodes. However the NFIT does reference
those proximity domains.

As a result, Linux, while parsing the SRAT, fails to initialize node
related structures for these nodes, and they never end up in the
nodes_possible map. When these are onlined at a later point (via
hotplug), this causes problems.

I've followed the instructions in bios-tables-test.c to update the
expected SRAT binary, and the tests (make check) pass. Patches 1 and 3
are the relevant ones for the binary update.

Patch 2 is the main patch which changes SRAT generation.

Vishal Verma (3):
  diffs-allowed: add the SRAT AML to diffs-allowed
  hw/acpi-build: account for NVDIMM numa nodes in SRAT
  tests/acpi: update expected SRAT files

 hw/i386/acpi-build.c             |  20 ++++++++++++++++++++
 tests/data/acpi/pc/SRAT.dimmpxm  | Bin 392 -> 392 bytes
 tests/data/acpi/q35/SRAT.dimmpxm | Bin 392 -> 392 bytes
 3 files changed, 20 insertions(+)

-- 
2.25.4


