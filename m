Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA3C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682AE208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682AE208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVaN-0001TR-M2
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:27:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQVVX-0005zf-Ve
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQVVW-0002C1-NH
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:22:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33848 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
	id 1hQVVT-00024O-CY; Tue, 14 May 2019 07:22:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 3F83D18CFD8C6B38241D;
	Tue, 14 May 2019 19:22:00 +0800 (CST)
Received: from ros.huawei.com (10.143.28.118) by
	DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server
	id 14.3.439.0; Tue, 14 May 2019 19:21:50 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
	<shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
	<lersek@redhat.com>, 
	<james.morse@arm.com>, <gengdongjiu@huawei.com>, <mtosatti@redhat.com>, 
	<rth@twiddle.net>, <ehabkost@redhat.com>, <zhengxiang9@huawei.com>,
	<jonathan.cameron@huawei.com>, <xuwei5@huawei.com>, <kvm@vger.kernel.org>, 
	<qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Date: Tue, 14 May 2019 04:18:15 -0700
Message-ID: <1557832703-42620-3-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.118]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: [Qemu-devel] [PATCH v17 02/10] ACPI: add some GHES structures and
 macros definition
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Generic Error Status Block structures and some macros
definitions, which is referred to the ACPI 4.0 or ACPI 6.2. The
HEST table generation and CPER record will use them.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 include/hw/acpi/acpi-defs.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index f9aa4bd..d1996fb 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -224,6 +224,25 @@ typedef struct AcpiMultipleApicTable AcpiMultipleApicTable;
 #define ACPI_APIC_RESERVED              16   /* 16 and greater are reserved */
 
 /*
+ * Values for Hardware Error Notification Type field
+ */
+enum AcpiHestNotifyType {
+    ACPI_HEST_NOTIFY_POLLED = 0,
+    ACPI_HEST_NOTIFY_EXTERNAL = 1,
+    ACPI_HEST_NOTIFY_LOCAL = 2,
+    ACPI_HEST_NOTIFY_SCI = 3,
+    ACPI_HEST_NOTIFY_NMI = 4,
+    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0: 18.3.2.7, Table 18-290 */
+    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0: 18.3.2.7, Table 18-290 */
+    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0: 18.3.2.7, Table 18-332 */
+    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1: 18.3.2.9, Table 18-345 */
+    ACPI_HEST_NOTIFY_SEI = 9,   /* ACPI 6.1: 18.3.2.9, Table 18-345 */
+    ACPI_HEST_NOTIFY_GSIV = 10, /* ACPI 6.1: 18.3.2.9, Table 18-345 */
+    ACPI_HEST_NOTIFY_SDEI = 11, /* ACPI 6.2: 18.3.2.9, Table 18-383 */
+    ACPI_HEST_NOTIFY_RESERVED = 12 /* 12 and greater are reserved */
+};
+
+/*
  * MADT sub-structures (Follow MULTIPLE_APIC_DESCRIPTION_TABLE)
  */
 #define ACPI_SUB_HEADER_DEF   /* Common ACPI sub-structure header */\
@@ -400,6 +419,39 @@ struct AcpiSystemResourceAffinityTable {
 } QEMU_PACKED;
 typedef struct AcpiSystemResourceAffinityTable AcpiSystemResourceAffinityTable;
 
+/*
+ * Generic Error Status Block
+ */
+struct AcpiGenericErrorStatus {
+    /* It is a bitmask composed of ACPI_GEBS_xxx macros */
+    uint32_t block_status;
+    uint32_t raw_data_offset;
+    uint32_t raw_data_length;
+    uint32_t data_length;
+    uint32_t error_severity;
+} QEMU_PACKED;
+typedef struct AcpiGenericErrorStatus AcpiGenericErrorStatus;
+
+/*
+ * Masks for block_status flags above
+ */
+#define ACPI_GEBS_UNCORRECTABLE         1
+
+/*
+ * Values for error_severity field above
+ */
+enum AcpiGenericErrorSeverity {
+    ACPI_CPER_SEV_RECOVERABLE,
+    ACPI_CPER_SEV_FATAL,
+    ACPI_CPER_SEV_CORRECTED,
+    ACPI_CPER_SEV_NONE,
+};
+
+/*
+ * Generic Hardware Error Source version 2
+ */
+#define ACPI_HEST_SOURCE_GENERIC_ERROR_V2    10
+
 #define ACPI_SRAT_PROCESSOR_APIC     0
 #define ACPI_SRAT_MEMORY             1
 #define ACPI_SRAT_PROCESSOR_x2APIC   2
-- 
1.8.3.1


