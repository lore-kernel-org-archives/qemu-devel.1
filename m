Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB24CC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908BC217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908BC217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZTt-0004cz-PP
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:11:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZQR-0001ai-Le
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZJm-0002J0-FT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:01:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:21721)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZJm-0002IU-6B
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:01:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 01:01:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; d="scan'208";a="164919422"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2019 01:01:13 -0700
Date: Thu, 25 Apr 2019 16:00:46 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425080046.GD24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-8-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1556170489-131927-8-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v3 07/13] tests: acpi: add
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425080046.66WRitksEYhcfnWAJQViJQl55DkYCswafWCipAUdLUM@z>

On Thu, Apr 25, 2019 at 07:34:43AM +0200, Igor Mammedov wrote:
>introduce UEFI specific counterpart to acpi_find_rsdp_address()
>that will help to find RSDP address when [OA]VMF is used as
>firmware. It requires guest firmware or other guest app to place
>1Mb aligned UefiTestSupport structure (defined in this patch)
>in RAM with UefiTestSupport::signature_guid set to
>AB87A6B1-2034-BDA0-71BD-375007757785

Just curious about where we get this signature? Randomly generated?

>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
>v3:
>  * fix checkpatch error (separate opening brace from values in AcpiTestSupportGuid initializer)
>v2:
>  * Laszlo Ersek <lersek@redhat.com>
>    - s/uefi_find_rsdp_addr/acpi_find_rsdp_address_uefi/
>    - use GUID_SIZE instead of opencodding size
>    - make AcpiTestSupportGuid const
>    - s/TCI/TCG/
>---
> tests/acpi-utils.h |  2 ++
> tests/acpi-utils.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 46 insertions(+)
>
>diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
>index 75f78f2..dcfa721 100644
>--- a/tests/acpi-utils.h
>+++ b/tests/acpi-utils.h
>@@ -46,6 +46,8 @@ typedef struct {
> 
> uint8_t acpi_calc_checksum(const uint8_t *data, int len);
> uint32_t acpi_find_rsdp_address(QTestState *qts);
>+uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
>+                                     uint64_t size);
> void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
> void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                       const uint8_t *addr_ptr, const char *sig,
>diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
>index 2dd4fe0..197af82 100644
>--- a/tests/acpi-utils.c
>+++ b/tests/acpi-utils.c
>@@ -99,3 +99,47 @@ void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>         g_assert(!acpi_calc_checksum(*aml, *aml_len));
>     }
> }
>+
>+#define GUID_SIZE 16
>+static const uint8_t AcpiTestSupportGuid[GUID_SIZE] = {
>+       0xb1, 0xa6, 0x87, 0xab,
>+       0x34, 0x20,
>+       0xa0, 0xbd,
>+       0x71, 0xbd, 0x37, 0x50, 0x07, 0x75, 0x77, 0x85 };
>+
>+typedef struct {
>+    uint8_t signature_guid[GUID_SIZE];
>+    uint64_t rsdp10;
>+    uint64_t rsdp20;
>+} __attribute__((packed)) UefiTestSupport;
>+
>+/* Wait at most 600 seconds (test is slow with TCG and --enable-debug) */
>+#define TEST_DELAY (1 * G_USEC_PER_SEC / 10)
>+#define TEST_CYCLES MAX((600 * G_USEC_PER_SEC / TEST_DELAY), 1)
>+#define MB 0x100000ULL
>+uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
>+                                     uint64_t size)
>+{
>+    int i, j;
>+    uint8_t data[GUID_SIZE];
>+
>+    for (i = 0; i < TEST_CYCLES; ++i) {
>+        for (j = 0; j < size / MB; j++) {
>+            /* look for GUID at every 1Mb block */
>+            uint64_t addr = start + j * MB;
>+
>+            qtest_memread(qts, addr, data, sizeof(data));
>+            if (!memcmp(AcpiTestSupportGuid, data, sizeof(data))) {
>+                UefiTestSupport ret;
>+
>+                qtest_memread(qts, addr, &ret, sizeof(ret));
>+                ret.rsdp10 = le64_to_cpu(ret.rsdp10);
>+                ret.rsdp20 = le64_to_cpu(ret.rsdp20);
>+                return ret.rsdp20 ? ret.rsdp20 : ret.rsdp10;
>+            }
>+        }
>+        g_usleep(TEST_DELAY);
>+    }
>+    g_assert_not_reached();
>+    return 0;
>+}
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

