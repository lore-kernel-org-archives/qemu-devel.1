Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 00:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB75206DB
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 00:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB75206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhMQ5-0007tN-AC
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 20:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jhMOu-0005g6-MZ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 20:09:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:45980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jhMOs-0006I0-PO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 20:09:28 -0400
IronPort-SDR: VvsDP6WlTcBgKEaONbxOLCJ/tKHrx5V8dubFCN1Sk77Ulbb5tfx9H0J/TTIaHbPKOVxQrWeg7w
 lcWOxaDI256A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 17:09:20 -0700
IronPort-SDR: uflJW9EVAxMGMSPgzff8JQUfEqLY5seialgwVl4U1yNmr5XAg+Bk0Yf4l5Y10+jFh/BDicp8tg
 HQRPnmxwqZWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,478,1583222400"; d="scan'208";a="294853310"
Received: from vverma7-mobl4.lm.intel.com ([10.254.185.105])
 by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2020 17:09:19 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v5 0/3] account for NVDIMM nodes during SRAT generation
Date: Fri,  5 Jun 2020 18:09:08 -0600
Message-Id: <20200606000911.9896-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=vishal.l.verma@intel.com; helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 20:09:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jingqi.liu@intel.com,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v4 (no code changes):
- Change the commit message in patch 2 to use memdev= instead of mem=
   which is deprecated (Igor)
- Add Igor's Reviewed-by

Changes since v3:
- Add the SRAT augmentation for ARM's virt-acpi-build as well (Igor)
- Update patches 1 and 3 for the test binaries to include ARM tests.

Changes since v2:
- Change a repetitive OBJECT(dev) to a stored 'Object' (Igor)
- No need to return 'numamem' back to build_srat (Igor)

Changes since v1:
- Use error_abort for getters (Igor)
- Free the device list (Igor)
- Refactor the NVDIMM related portion into hw/acpi/nvdimm.c (Igor)
- Rebase onto latest master
- Add Jingqi's Reviewed-by

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
  hw/acpi/nvdimm: add a helper to augment SRAT generation
  tests/acpi: update expected SRAT files

 hw/acpi/nvdimm.c                 |  23 +++++++++++++++++++++++
 hw/arm/virt-acpi-build.c         |   4 ++++
 hw/i386/acpi-build.c             |   5 +++++
 include/hw/mem/nvdimm.h          |   1 +
 tests/data/acpi/pc/SRAT.dimmpxm  | Bin 392 -> 392 bytes
 tests/data/acpi/q35/SRAT.dimmpxm | Bin 392 -> 392 bytes
 tests/data/acpi/virt/SRAT.memhp  | Bin 186 -> 226 bytes
 7 files changed, 33 insertions(+)

-- 
2.26.2


