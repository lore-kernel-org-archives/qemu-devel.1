Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753FFC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487F920675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487F920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDMY-0004XA-BW
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:11:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4Y-0005P4-1X
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4W-0002xA-2m
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4U-0002vk-3X
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F4883151C42;
	Thu,  2 May 2019 14:52:24 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 05AEA71C80;
	Thu,  2 May 2019 14:52:15 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:51:56 +0200
Message-Id: <1556808723-226478-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 02 May 2019 14:52:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 08/15] tests: acpi: add
 acpi_find_rsdp_address_uefi() helper
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
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502145156.ob9kVIqokRBy92WdEOU0NE1wPpCvdF3-72Vm8N46zsQ@z>

introduce UEFI specific counterpart to acpi_find_rsdp_address()
that will help to find RSDP address when [OA]VMF is used as
firmware. It requires guest firmware or other guest app to place
1Mb aligned UefiTestSupport structure (defined in this patch)
in RAM with UefiTestSupport::signature_guid set to
AB87A6B1-2034-BDA0-71BD-375007757785
For test app details see commit
  (09a274d82f tests: introduce "uefi-test-tools" with the BiosTablesTest UEFI app)

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
---
v4:
  * update commit message to point to commit which introduced
   signature_guid value.
v3:
  * fix checkpatch error (separate opening brace from values in AcpiTestSupportGuid initializer)
v2:
  * Laszlo Ersek <lersek@redhat.com>
    - s/uefi_find_rsdp_addr/acpi_find_rsdp_address_uefi/
    - use GUID_SIZE instead of opencodding size
    - make AcpiTestSupportGuid const
    - s/TCI/TCG/
---
 tests/acpi-utils.h |  2 ++
 tests/acpi-utils.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 1da6c10..52c529e 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -46,6 +46,8 @@ typedef struct {
 
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
+uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
+                                     uint64_t size);
 void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, int addr_size, const char *sig,
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index c216b9e..d2a202e 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -101,3 +101,47 @@ void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
         g_assert(!acpi_calc_checksum(*aml, *aml_len));
     }
 }
+
+#define GUID_SIZE 16
+static const uint8_t AcpiTestSupportGuid[GUID_SIZE] = {
+       0xb1, 0xa6, 0x87, 0xab,
+       0x34, 0x20,
+       0xa0, 0xbd,
+       0x71, 0xbd, 0x37, 0x50, 0x07, 0x75, 0x77, 0x85 };
+
+typedef struct {
+    uint8_t signature_guid[GUID_SIZE];
+    uint64_t rsdp10;
+    uint64_t rsdp20;
+} __attribute__((packed)) UefiTestSupport;
+
+/* Wait at most 600 seconds (test is slow with TCG and --enable-debug) */
+#define TEST_DELAY (1 * G_USEC_PER_SEC / 10)
+#define TEST_CYCLES MAX((600 * G_USEC_PER_SEC / TEST_DELAY), 1)
+#define MB 0x100000ULL
+uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
+                                     uint64_t size)
+{
+    int i, j;
+    uint8_t data[GUID_SIZE];
+
+    for (i = 0; i < TEST_CYCLES; ++i) {
+        for (j = 0; j < size / MB; j++) {
+            /* look for GUID at every 1Mb block */
+            uint64_t addr = start + j * MB;
+
+            qtest_memread(qts, addr, data, sizeof(data));
+            if (!memcmp(AcpiTestSupportGuid, data, sizeof(data))) {
+                UefiTestSupport ret;
+
+                qtest_memread(qts, addr, &ret, sizeof(ret));
+                ret.rsdp10 = le64_to_cpu(ret.rsdp10);
+                ret.rsdp20 = le64_to_cpu(ret.rsdp20);
+                return ret.rsdp20 ? ret.rsdp20 : ret.rsdp10;
+            }
+        }
+        g_usleep(TEST_DELAY);
+    }
+    g_assert_not_reached();
+    return 0;
+}
-- 
2.7.4


