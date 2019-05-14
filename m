Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E04C04AB7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E690208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E690208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVXo-0007VE-Gu
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:24:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQVVZ-00061S-AY
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQVVY-0002E6-5Q
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:22:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2214 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
	id 1hQVVU-00024W-NK; Tue, 14 May 2019 07:22:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 62B9D52063AC7E564E84;
	Tue, 14 May 2019 19:22:00 +0800 (CST)
Received: from ros.huawei.com (10.143.28.118) by
	DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server
	id 14.3.439.0; Tue, 14 May 2019 19:21:52 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
	<shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
	<lersek@redhat.com>, 
	<james.morse@arm.com>, <gengdongjiu@huawei.com>, <mtosatti@redhat.com>, 
	<rth@twiddle.net>, <ehabkost@redhat.com>, <zhengxiang9@huawei.com>,
	<jonathan.cameron@huawei.com>, <xuwei5@huawei.com>, <kvm@vger.kernel.org>, 
	<qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Date: Tue, 14 May 2019 04:18:17 -0700
Message-ID: <1557832703-42620-5-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
References: <1557832703-42620-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.118]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH v17 04/10] acpi: add
 build_append_ghes_generic_data() helper for Generic Error Data Entry
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

It will help to add Generic Error Data Entry to ACPI tables
without using packed C structures and avoid endianness
issues as API doesn't need explicit conversion.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 hw/acpi/aml-build.c         | 32 ++++++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index fb53f21..102a288 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -296,6 +296,38 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
         build_append_int_noprefix(table, error_threshold_window, 4);
 }
 
+/* Generic Error Data Entry
+ * ACPI 4.0: 17.3.2.6.1 Generic Error Data
+ */
+void build_append_ghes_generic_data(GArray *table, const char *section_type,
+                                    uint32_t error_severity, uint16_t revision,
+                                    uint8_t validation_bits, uint8_t flags,
+                                    uint32_t error_data_length, uint8_t *fru_id,
+                                    uint8_t *fru_text, uint64_t time_stamp)
+{
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        build_append_int_noprefix(table, section_type[i], 1);
+    }
+
+    build_append_int_noprefix(table, error_severity, 4);
+    build_append_int_noprefix(table, revision, 2);
+    build_append_int_noprefix(table, validation_bits, 1);
+    build_append_int_noprefix(table, flags, 1);
+    build_append_int_noprefix(table, error_data_length, 4);
+
+    for (i = 0; i < 16; i++) {
+        build_append_int_noprefix(table, fru_id[i], 1);
+    }
+
+    for (i = 0; i < 20; i++) {
+        build_append_int_noprefix(table, fru_text[i], 1);
+    }
+
+    build_append_int_noprefix(table, time_stamp, 8);
+}
+
 /*
  * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a dword,
  * and return the offset to 0x00000000 for runtime patching.
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 90c8ef8..a71db2f 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -419,6 +419,12 @@ void build_append_ghes_notify(GArray *table, const uint8_t type,
                               uint32_t error_threshold_value,
                               uint32_t error_threshold_window);
 
+void build_append_ghes_generic_data(GArray *table, const char *section_type,
+                                    uint32_t error_severity, uint16_t revision,
+                                    uint8_t validation_bits, uint8_t flags,
+                                    uint32_t error_data_length, uint8_t *fru_id,
+                                    uint8_t *fru_text, uint64_t time_stamp);
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-- 
1.8.3.1


