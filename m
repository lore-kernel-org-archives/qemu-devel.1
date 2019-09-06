Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F4C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0AE20842
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0AE20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69i7-0003py-6q
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1i69gP-00020k-Vr
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1i69gO-0005cU-Av
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:33:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51110 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1i69gI-0005WN-TR; Fri, 06 Sep 2019 04:33:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9E2F6B0146111930E6C7;
 Fri,  6 Sep 2019 16:33:15 +0800 (CST)
Received: from HGHY1z004218071.china.huawei.com (10.177.29.32) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 16:33:09 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <lersek@redhat.com>,
 <james.morse@arm.com>, <gengdongjiu@huawei.com>, <mtosatti@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <jonathan.cameron@huawei.com>,
 <xuwei5@huawei.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Date: Fri, 6 Sep 2019 16:31:48 +0800
Message-ID: <20190906083152.25716-3-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
In-Reply-To: <20190906083152.25716-1-zhengxiang9@huawei.com>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [PATCH v18 2/6] docs: APEI GHES generation and CPER
 record description
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
Cc: wanghaibin.wang@huawei.com, zhengxiang9@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

Add APEI/GHES detailed design document

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 docs/specs/acpi_hest_ghes.txt | 88 +++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 docs/specs/acpi_hest_ghes.txt

diff --git a/docs/specs/acpi_hest_ghes.txt b/docs/specs/acpi_hest_ghes.txt
new file mode 100644
index 0000000000..690d4b2bd0
--- /dev/null
+++ b/docs/specs/acpi_hest_ghes.txt
@@ -0,0 +1,88 @@
+APEI tables generating and CPER record
+=============================
+
+Copyright (C) 2019 Huawei Corporation.
+
+Design Details:
+-------------------
+
+       etc/acpi/tables                                 etc/hardware_errors
+    ====================                      ==========================================
++ +--------------------------+            +-----------------------+
+| | HEST                     |            |    address            |            +--------------+
+| +--------------------------+            |    registers          |            | Error Status |
+| | GHES1                    |            | +---------------------+            | Data Block 1 |
+| +--------------------------+ +--------->| |error_block_address1 |----------->| +------------+
+| | .................        | |          | +---------------------+            | |  CPER      |
+| | error_status_address-----+-+ +------->| |error_block_address2 |--------+   | |  CPER      |
+| | .................        |   |        | +---------------------+        |   | |  ....      |
+| | read_ack_register--------+-+ |        | |    ..............   |        |   | |  CPER      |
+| | read_ack_preserve        | | |        +-----------------------+        |   | +------------+
+| | read_ack_write           | | | +----->| |error_block_addressN |------+ |   | Error Status |
++ +--------------------------+ | | |      | +---------------------+      | |   | Data Block 2 |
+| | GHES2                    | +-+-+----->| |read_ack_register1   |      | +-->| +------------+
++ +--------------------------+   | |      | +---------------------+      |     | |  CPER      |
+| | .................        |   | | +--->| |read_ack_register2   |      |     | |  CPER      |
+| | error_status_address-----+---+ | |    | +---------------------+      |     | |  ....      |
+| | .................        |     | |    | |  .............      |      |     | |  CPER      |
+| | read_ack_register--------+-----+-+    | +---------------------+      |     +-+------------+
+| | read_ack_preserve        |     |   +->| |read_ack_registerN   |      |     | |..........  |
+| | read_ack_write           |     |   |  | +---------------------+      |     | +------------+
++ +--------------------------|     |   |                                 |     | Error Status |
+| | ...............          |     |   |                                 |     | Data Block N |
++ +--------------------------+     |   |                                 +---->| +------------+
+| | GHESN                    |     |   |                                       | |  CPER      |
++ +--------------------------+     |   |                                       | |  CPER      |
+| | .................        |     |   |                                       | |  ....      |
+| | error_status_address-----+-----+   |                                       | |  CPER      |
+| | .................        |         |                                       +-+------------+
+| | read_ack_register--------+---------+
+| | read_ack_preserve        |
+| | read_ack_write           |
++ +--------------------------+
+
+(1) QEMU generates the ACPI HEST table. This table goes in the current
+    "etc/acpi/tables" fw_cfg blob. Each error source has different
+    notification types.
+
+(2) A new fw_cfg blob called "etc/hardware_errors" is introduced. QEMU
+    also need to populate this blob. The "etc/hardwre_errors" fw_cfg blob
+    contains an address registers table and an Error Status Data Block table.
+
+(3) The address registers table contains N Error Block Address entries
+    and N Read Ack Register entries, the size for each entry is 8-byte.
+    The Error Status Data Block table contains N Error Status Data Block
+    entries, the size for each entry is 4096(0x1000) bytes. The total size
+    for "etc/hardware_errors" fw_cfg blob is (N * 8 * 2 + N * 4096) bytes.
+    N is the kinds of hardware error sources.
+
+(4) QEMU generates the ACPI linker/loader script for the firmware, the
+    firmware pre-allocates memory for "etc/acpi/tables", "etc/hardware_errors"
+    and copies blobs content there.
+
+(5) QEMU generates N ADD_POINTER commands, which patch address in the
+    "error_status_address" fields of the HEST table with a pointer to the
+    corresponding "address registers" in "etc/hardware_errors" blob.
+
+(6) QEMU generates N ADD_POINTER commands, which patch address in the
+    "read_ack_register" fields of the HEST table with a pointer to the
+    corresponding "address registers" in "etc/hardware_errors" blob.
+
+(7) QEMU generates N ADD_POINTER commands for the firmware, which patch
+    address in the " error_block_address" fields with a pointer to the
+    respective "Error Status Data Block" in "etc/hardware_errors" blob.
+
+(8) QEMU defines a third and write-only fw_cfg blob which is called
+    "etc/hardware_errors_addr". Through that blob, the firmware can send back
+    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
+    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER commands
+    for the firmware, the firmware will write back the start address of
+    "etc/hardware_errors" blob to fw_cfg file "etc/hardware_errors_addr".
+
+(9) When QEMU gets SIGBUS from the kernel, QEMU formats the CPER right into
+    guest memory, and then injects whatever interrupt (or assert whatever GPIO
+    line) as a notification which is necessary for notifying the guest.
+
+(10) This notification (in virtual hardware) will be handled by guest kernel,
+    guest APEI driver will read the CPER which is recorded by QEMU and do the
+    recovery.
-- 
2.19.1



