Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA5CC83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 01:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E341A2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 01:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E341A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTF47-0000Yt-1u
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 21:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTF3A-0007Rb-CD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTF39-0005V1-4C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:49890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jTF38-0005U4-Ia
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:38 -0400
IronPort-SDR: OmUSBQRCNdqXcq85Crqvb8nWFm3z7Du3Rp54vdJ9c1ltxPjkkDI4DMYelvhwId/o2HLon78Xf2
 WqyQU2EcTwmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 18:28:29 -0700
IronPort-SDR: FXLZHDG85QGnDOr7PKBZ8Bn1nxqG3GafoBbEOIWpr0E52Oy7Jqrjtb3x3R571qpgLGbFMNUN2C
 o2NLF4qXht5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="249040061"
Received: from vverma7-mobl4.lm.intel.com ([10.254.191.96])
 by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2020 18:28:28 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/3] diffs-allowed: add the SRAT AML to diffs-allowed
Date: Mon, 27 Apr 2020 19:28:08 -0600
Message-Id: <20200428012810.10877-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428012810.10877-1-vishal.l.verma@intel.com>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
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

In anticipation of a change to the SRAT generation in qemu, add the AML
file to diffs-allowed.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..83d3ea5032 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/SRAT.dimmpxm",
-- 
2.25.4


