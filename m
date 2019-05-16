Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF470C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F7220815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F7220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFgM-0001cs-WD
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:40:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNU-0001kY-15
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNR-0002sv-0I
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNQ-0002sg-Sw
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id a17so3587805qth.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=hEsXMM3fe/H6yVSyLHohC20f3iE9o4Y2zwy8WMEIegM=;
	b=F6j4h3g4HIYkD2Ed8q6TsYNmVeFFCy8S2MZ1m9jpMg+E9M8cTCZnKchrlwdHsm6N8G
	oLIlRse4c1/JlS+ohZE361ZaXD2ht186otUMF0aCuyIhLz4Cvq7MOThcZA8YkJHN1CMO
	5rFnRqhIL4ZbPvVkfMHQyrqnmqHkp/w1qLjYBbYvPLte9/H4vkaMwEdI8WVy3Epb+Od0
	sc6ecjyxTU9u6YmClBipOg8a5EtGuv5uzfxdp04LPl44dxlJ2XD1pi0xinLo951QG3rD
	6tEiNNXF6uqLteTgfi4/HGk4UAhpc5scEe4geUytV0nIWj+KFyroY+Dvn+4hsbS2xUHi
	XGZA==
X-Gm-Message-State: APjAAAX2apPMk/4n/KGB8lP1DnmVnhzmqoxBINJrzK7HX/d9rWdPcvH8
	FewF2jf2WdprNcnLZd/c+Wop2bGGMFY=
X-Google-Smtp-Source: APXvYqz81CAgH31PCYxKNOstmkrfH4Rt1UF2F1CTntXZi3/YqhLnrJzaP8EQWeuaD37Nzx2/ha8NAQ==
X-Received: by 2002:ac8:2ab2:: with SMTP id b47mr42521491qta.175.1558009248124;
	Thu, 16 May 2019 05:20:48 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	m18sm2524901qki.21.2019.05.16.05.20.45
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:47 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-9-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL 30/37] tests: acpi: add
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
Message-ID: <20190516122044.z3sYAU9XNS4nug4UetlTCRup7XLy140GC_rsGhK-rDo@z>

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
index 1da6c100a4..52c529e1b0 100644
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


