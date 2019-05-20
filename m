Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7C0C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B429A20862
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B429A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43557 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrgH-0003cg-Q6
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:26:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRJ-0007qg-Gg
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRH-0008LF-OQ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRH-0008Kx-HH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so9868001qkb.13
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=oqgPjJcQ1nCdql2NZY/7MbpSZ2gcOK+EeLFrLtle5nY=;
	b=SL9dUDJ1ONRxSap4HohaqnDErBUKbMvj+Bm9WGiVDP8aflai4wyvUtDrnKvnSMPQn1
	Pzti5BeskiiOGmQBkPv1tIBZuOSZC55TQHtxe0hp9YkxDEdsF/QrJojyBc9HclC6wgWt
	oap4g0MgW6kzxqEpCikyHRbIZJBtY7kVJ+ZaW/UlNNLL1yxgb4jBORcsQUYEdEoPQ7e0
	xPiv9bLWY9HImPY2yxxP6l1f0Zuzkd59jM60WIn3yrW7rq71lp5ILmzUK8AAhrrKMBVx
	I3kUVPSdfSKseYD/nCaAXDKeCTZQU32QWGuaSjaUKQaKRPZFlzUBYtB1nHquuXA0GdaN
	iMiQ==
X-Gm-Message-State: APjAAAU1azmkXyqtDzQaTLolt7O0miPOtWlCpmgwqpV4gBInORZjcTAd
	oC8t1I+g+O8XJKaxRaLhxShsQhPkzKw=
X-Google-Smtp-Source: APXvYqyul6NlkLOrAb4Lk0/1QJsAL5ic7GAsWP3p1i5C74jIv7wrQRFm6kXXKuHllzinarrLP67xbg==
X-Received: by 2002:a05:620a:133c:: with SMTP id
	p28mr59471251qkj.165.1558393886811; 
	Mon, 20 May 2019 16:11:26 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	t58sm10680313qtj.4.2019.05.20.16.11.25
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:26 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-9-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.194
Subject: [Qemu-devel] [PULL v2 29/36] tests: acpi: add
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231125.mhqFZPx7xwrp7cvkqy0UxyYWutaPDUp4H3zXP2zBdqA@z>

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <1556808723-226478-9-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acpi-utils.h |  2 ++
 tests/acpi-utils.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index 0ceb499469..0c86780689 100644
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
index c216b9e0e9..d2a202efca 100644
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
MST


