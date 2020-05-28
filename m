Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CACC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6066C2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6066C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeLJY-0004GG-Ju
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 12:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeLGo-0000ay-Ni
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:20:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:35636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeLGn-00010J-6Y
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:20:38 -0400
IronPort-SDR: BvME6kfgkO5R/KvlW3gpqmg0MZWYdZHHXSL+9EQTGc1xmpbJ5yv//kMzyrXUIMNDWQDKxRY4t5
 /TgRDifFQ+Ag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 09:20:32 -0700
IronPort-SDR: QARvJ+XIxoDrn6Op4HgKYOq6pnIMwnSCoTlNi+9yCLPQJElRq6lqq8rIwui1xau7bfvmG4izwF
 dbVW6Eu1iitw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; d="scan'208";a="270903783"
Received: from vverma7-mobl4.lm.intel.com ([10.251.139.189])
 by orsmga006.jf.intel.com with ESMTP; 28 May 2020 09:20:31 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 3/3] tests/acpi: update expected SRAT files
Date: Thu, 28 May 2020 10:20:11 -0600
Message-Id: <20200528162011.16258-4-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200528162011.16258-1-vishal.l.verma@intel.com>
References: <20200528162011.16258-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=vishal.l.verma@intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 12:20:29
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

Update the expected SRAT files for the change to account for NVDIMM numa
nodes in the SRAT.

AML Diff:
  --- /tmp/asl-V49YJ0.dsl	2020-04-27 18:50:52.680043327 -0600
  +++ /tmp/asl-48AZJ0.dsl	2020-04-27 18:50:52.679043344 -0600
  @@ -3,7 +3,7 @@
    * AML/ASL+ Disassembler version 20190509 (64-bit version)
    * Copyright (c) 2000 - 2019 Intel Corporation
    *
  - * Disassembly of tests/data/acpi/pc/SRAT.dimmpxm, Mon Apr 27 18:50:52 2020
  + * Disassembly of /tmp/aml-U3BZJ0, Mon Apr 27 18:50:52 2020
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
  @@ -167,7 +167,7 @@

   Raw Table Data: Length 392 (0x188)

  -    0000: 53 52 41 54 88 01 00 00 01 80 42 4F 43 48 53 20  // SRAT......BOCHS
  +    0000: 53 52 41 54 88 01 00 00 01 68 42 4F 43 48 53 20  // SRAT.....hBOCHS
       0010: 42 58 50 43 53 52 41 54 01 00 00 00 42 58 50 43  // BXPCSRAT....BXPC
       0020: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
       0030: 00 10 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
  @@ -186,9 +186,9 @@
       0100: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
       0110: 01 28 03 00 00 00 00 00 00 00 00 06 00 00 00 00  // .(..............
       0120: 00 00 00 02 00 00 00 00 00 00 00 00 01 00 00 00  // ................
  -    0130: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
  -    0140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
  -    0150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
  +    0130: 00 00 00 00 00 00 00 00 01 28 02 00 00 00 00 00  // .........(......
  +    0140: 00 00 00 08 01 00 00 00 00 00 00 08 00 00 00 00  // ................
  +    0150: 00 00 00 00 05 00 00 00 00 00 00 00 00 00 00 00  // ................
       0160: 01 28 03 00 00 00 00 00 00 00 00 00 01 00 00 00  // .(..............
       0170: 00 00 00 F8 00 00 00 00 00 00 00 00 03 00 00 00  // ................
       0180: 00 00 00 00 00 00 00 00                          // ........

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tests/data/acpi/pc/SRAT.dimmpxm             | Bin 392 -> 392 bytes
 tests/data/acpi/q35/SRAT.dimmpxm            | Bin 392 -> 392 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 3 files changed, 1 deletion(-)

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

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 83d3ea5032..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/SRAT.dimmpxm",
-- 
2.26.2


