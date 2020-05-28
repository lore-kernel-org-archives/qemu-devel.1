Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69261C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B4520721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B4520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeRDf-0006Rt-5q
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeR75-000444-4p
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:34:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:41313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeR73-0007z6-IE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:34:58 -0400
IronPort-SDR: 1JtdQTfw2ooQYeEnDEN/moc9a0NiJxaPufoMIjlnW4O2NldkonOIG6h0nSa4IrsSCG/3pF6Tmr
 3x/DLaFJzylA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:34:55 -0700
IronPort-SDR: LSOLIQeCs2IU+RHnLqESUzWfRpFGeXkfjFh8bOqtvsCX7mW6VVkFc60c9RJHPfIIhPWuuXJ/RO
 X4qTqR6mJ82w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; d="scan'208";a="256314850"
Received: from vverma7-mobl4.lm.intel.com ([10.251.139.189])
 by orsmga007.jf.intel.com with ESMTP; 28 May 2020 15:34:54 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v4 3/3] tests/acpi: update expected SRAT files
Date: Thu, 28 May 2020 16:34:37 -0600
Message-Id: <20200528223437.12568-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528223437.12568-1-vishal.l.verma@intel.com>
References: <20200528223437.12568-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=vishal.l.verma@intel.com; helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:34:49
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Update expected SRAT files for the change to account for NVDIMM NUMA
nodes in the SRAT.

AML diffs:

tests/data/acpi/pc/SRAT.dimmpxm:
--- /tmp/asl-3P2IL0.dsl	2020-05-28 15:11:02.326439263 -0600
+++ /tmp/asl-1N4IL0.dsl	2020-05-28 15:11:02.325439280 -0600
@@ -3,7 +3,7 @@
  * AML/ASL+ Disassembler version 20190509 (64-bit version)
  * Copyright (c) 2000 - 2019 Intel Corporation
  *
- * Disassembly of tests/data/acpi/pc/SRAT.dimmpxm, Thu May 28 15:11:02 2020
+ * Disassembly of /tmp/aml-4D4IL0, Thu May 28 15:11:02 2020
  *
  * ACPI Data Table [SRAT]
  *
@@ -13,7 +13,7 @@
 [000h 0000   4]                    Signature : "SRAT"    [System Resource Affinity Table]
 [004h 0004   4]                 Table Length : 00000188
 [008h 0008   1]                     Revision : 01
-[009h 0009   1]                     Checksum : 80
+[009h 0009   1]                     Checksum : 68
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPCSRAT"
 [018h 0024   4]                 Oem Revision : 00000001
@@ -140,15 +140,15 @@
 [138h 0312   1]                Subtable Type : 01 [Memory Affinity]
 [139h 0313   1]                       Length : 28

-[13Ah 0314   4]             Proximity Domain : 00000000
+[13Ah 0314   4]             Proximity Domain : 00000002
 [13Eh 0318   2]                    Reserved1 : 0000
-[140h 0320   8]                 Base Address : 0000000000000000
-[148h 0328   8]               Address Length : 0000000000000000
+[140h 0320   8]                 Base Address : 0000000108000000
+[148h 0328   8]               Address Length : 0000000008000000
 [150h 0336   4]                    Reserved2 : 00000000
-[154h 0340   4]        Flags (decoded below) : 00000000
-                                     Enabled : 0
+[154h 0340   4]        Flags (decoded below) : 00000005
+                                     Enabled : 1
                                Hot Pluggable : 0
-                                Non-Volatile : 0
+                                Non-Volatile : 1
 [158h 0344   8]                    Reserved3 : 0000000000000000

 [160h 0352   1]                Subtable Type : 01 [Memory Affinity]

tests/data/acpi/q35/SRAT.dimmpxm:
--- /tmp/asl-HW2LL0.dsl	2020-05-28 15:11:05.446384514 -0600
+++ /tmp/asl-8MYLL0.dsl	2020-05-28 15:11:05.445384532 -0600
@@ -3,7 +3,7 @@
  * AML/ASL+ Disassembler version 20190509 (64-bit version)
  * Copyright (c) 2000 - 2019 Intel Corporation
  *
- * Disassembly of tests/data/acpi/q35/SRAT.dimmpxm, Thu May 28 15:11:05 2020
+ * Disassembly of /tmp/aml-2CYLL0, Thu May 28 15:11:05 2020
  *
  * ACPI Data Table [SRAT]
  *
@@ -13,7 +13,7 @@
 [000h 0000   4]                    Signature : "SRAT"    [System Resource Affinity Table]
 [004h 0004   4]                 Table Length : 00000188
 [008h 0008   1]                     Revision : 01
-[009h 0009   1]                     Checksum : 80
+[009h 0009   1]                     Checksum : 68
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPCSRAT"
 [018h 0024   4]                 Oem Revision : 00000001
@@ -140,15 +140,15 @@
 [138h 0312   1]                Subtable Type : 01 [Memory Affinity]
 [139h 0313   1]                       Length : 28

-[13Ah 0314   4]             Proximity Domain : 00000000
+[13Ah 0314   4]             Proximity Domain : 00000002
 [13Eh 0318   2]                    Reserved1 : 0000
-[140h 0320   8]                 Base Address : 0000000000000000
-[148h 0328   8]               Address Length : 0000000000000000
+[140h 0320   8]                 Base Address : 0000000108000000
+[148h 0328   8]               Address Length : 0000000008000000
 [150h 0336   4]                    Reserved2 : 00000000
-[154h 0340   4]        Flags (decoded below) : 00000000
-                                     Enabled : 0
+[154h 0340   4]        Flags (decoded below) : 00000005
+                                     Enabled : 1
                                Hot Pluggable : 0
-                                Non-Volatile : 0
+                                Non-Volatile : 1
 [158h 0344   8]                    Reserved3 : 0000000000000000

 [160h 0352   1]                Subtable Type : 01 [Memory Affinity]

tests/data/acpi/virt/SRAT.memhp:
--- /tmp/asl-E32WL0.dsl	2020-05-28 15:19:56.976095582 -0600
+++ /tmp/asl-Y69WL0.dsl	2020-05-28 15:19:56.974095617 -0600
@@ -3,7 +3,7 @@
  * AML/ASL+ Disassembler version 20190509 (64-bit version)
  * Copyright (c) 2000 - 2019 Intel Corporation
  *
- * Disassembly of tests/data/acpi/virt/SRAT.memhp, Thu May 28 15:19:56 2020
+ * Disassembly of /tmp/aml-2CCXL0, Thu May 28 15:19:56 2020
  *
  * ACPI Data Table [SRAT]
  *
@@ -11,9 +11,9 @@
  */

 [000h 0000   4]                    Signature : "SRAT"    [System Resource Affinity Table]
-[004h 0004   4]                 Table Length : 000000BA
+[004h 0004   4]                 Table Length : 000000E2
 [008h 0008   1]                     Revision : 03
-[009h 0009   1]                     Checksum : 43
+[009h 0009   1]                     Checksum : 5C
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPCSRAT"
 [018h 0024   4]                 Oem Revision : 00000001
@@ -65,18 +65,32 @@

 [094h 0148   4]             Proximity Domain : 00000001
 [098h 0152   2]                    Reserved1 : 0000
-[09Ah 0154   8]                 Base Address : 0000000080000000
-[0A2h 0162   8]               Address Length : 00000000F0000000
+[09Ah 0154   8]                 Base Address : 0000000088000000
+[0A2h 0162   8]               Address Length : 0000000008000000
 [0AAh 0170   4]                    Reserved2 : 00000000
-[0AEh 0174   4]        Flags (decoded below) : 00000003
+[0AEh 0174   4]        Flags (decoded below) : 00000005
+                                     Enabled : 1
+                               Hot Pluggable : 0
+                                Non-Volatile : 1
+[0B2h 0178   8]                    Reserved3 : 0000000000000000
+
+[0BAh 0186   1]                Subtable Type : 01 [Memory Affinity]
+[0BBh 0187   1]                       Length : 28
+
+[0BCh 0188   4]             Proximity Domain : 00000001
+[0C0h 0192   2]                    Reserved1 : 0000
+[0C2h 0194   8]                 Base Address : 0000000080000000
+[0CAh 0202   8]               Address Length : 00000000F0000000
+[0D2h 0210   4]                    Reserved2 : 00000000
+[0D6h 0214   4]        Flags (decoded below) : 00000003
                                      Enabled : 1
                                Hot Pluggable : 1
                                 Non-Volatile : 0
-[0B2h 0178   8]                    Reserved3 : 0000000000000000
+[0DAh 0218   8]                    Reserved3 : 0000000000000000

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tests/data/acpi/pc/SRAT.dimmpxm             | Bin 392 -> 392 bytes
 tests/data/acpi/q35/SRAT.dimmpxm            | Bin 392 -> 392 bytes
 tests/data/acpi/virt/SRAT.memhp             | Bin 186 -> 226 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/pc/SRAT.dimmpxm b/tests/data/acpi/pc/SRAT.dimmpxm
index f5c0267ea24bb404b6b4e687390140378fbdc3f1..5a13c61b9041c6045c29643bf93a111fb1c0c76a 100644
GIT binary patch
delta 51
scmeBR?qKE$4ss0XU}Rum%-G0fz$nec00kUCF%aN@Pz(&LlS3Je0lmQmhyVZp

delta 51
icmeBR?qKE$4ss0XU}RumY}m+Uz$ndt8%z#mGzI{_tp$hx

diff --git a/tests/data/acpi/q35/SRAT.dimmpxm b/tests/data/acpi/q35/SRAT.dimmpxm
index f5c0267ea24bb404b6b4e687390140378fbdc3f1..5a13c61b9041c6045c29643bf93a111fb1c0c76a 100644
GIT binary patch
delta 51
scmeBR?qKE$4ss0XU}Rum%-G0fz$nec00kUCF%aN@Pz(&LlS3Je0lmQmhyVZp

delta 51
icmeBR?qKE$4ss0XU}RumY}m+Uz$ndt8%z#mGzI{_tp$hx

diff --git a/tests/data/acpi/virt/SRAT.memhp b/tests/data/acpi/virt/SRAT.memhp
index 1b57db2072e7f7e2085c4a427aa31c7383851b71..9a35adb40c6f7cd822e5af37abba8aad033617cb 100644
GIT binary patch
delta 43
rcmdnR_=u4!ILI;N5d#AQbIe4p$wD1K76@=aC<X@BiSc3+=gI;A(y0ha

delta 21
dcmaFFxQmf1ILI+%7Xt$Wv-3o*$rF#t0suzv27~|r

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index e8f2766a63..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/SRAT.dimmpxm",
-"tests/data/acpi/q35/SRAT.dimmpxm",
-"tests/data/acpi/virt/SRAT.memhp",
-- 
2.26.2


