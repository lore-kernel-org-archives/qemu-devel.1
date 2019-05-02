Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FCCC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6192081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6192081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDFE-0005eU-9b
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:03:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD3t-0004rY-5q
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD3r-0002ee-Il
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:51:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD3r-0002eC-Ao
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:51:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8ACCD37EEA;
	Thu,  2 May 2019 14:51:46 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C417871C80;
	Thu,  2 May 2019 14:51:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:51:49 +0200
Message-Id: <1556808723-226478-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 02 May 2019 14:51:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 01/15] tests: acpi: rename
 acpi_parse_rsdp_table() into acpi_fetch_rsdp_table()
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
Message-ID: <20190502145149.8SYrOkxoli2SzIxCOfmU2TJk_UTmh6DSvEqgi0o-ABI@z>

so name would reflect what the function does

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
---
v4:
 * make it as the first patch in series
---
 tests/acpi-utils.h       | 2 +-
 tests/acpi-utils.c       | 2 +-
 tests/bios-tables-test.c | 2 +-
 tests/vmgenid-test.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index ef388bb..4cd5553 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -47,7 +47,7 @@ typedef struct {
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
 uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table);
+void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, const char *sig,
                       bool verify_checksum);
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index cc33b46..633d8f5 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -63,7 +63,7 @@ uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
     return le64_to_cpu(xsdt_physical_address);
 }
=20
-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table)
+void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table)
 {
     uint8_t revision;
=20
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a506dcb..6a678bf 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -89,7 +89,7 @@ static void test_acpi_rsdp_table(test_data *data)
     uint8_t *rsdp_table =3D data->rsdp_table, revision;
     uint32_t addr =3D data->rsdp_addr;
=20
-    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);
+    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
     revision =3D rsdp_table[15 /* Revision offset */];
=20
     switch (revision) {
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index ae38ee5..f400184 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
=20
=20
-    acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
+    acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
     acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddres=
s */],
                      "RSDT", true);
=20
--=20
2.7.4


