Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03CCC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61832075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61832075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDID-0008I0-0O
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:06:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4C-000562-RC
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4B-0002na-OE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4B-0002nE-G6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF8C0C05B1CD;
	Thu,  2 May 2019 14:52:06 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 408367DA23;
	Thu,  2 May 2019 14:52:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:51:52 +0200
Message-Id: <1556808723-226478-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 02 May 2019 14:52:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 04/15] tests: acpi: make pointer to RSDP
 64bit
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
Message-ID: <20190502145152.BGKl-QGjUc_pNFzjy1m0AsS-B7mYpHWqllLwKl_bQ8Y@z>

In case of UEFI, RSDP doesn't have to be located in lowmem,
it could be placed at any address. Make sure that test won't
break if it is placed above the first 4Gb of address space.

PS:
While at it cleanup some local variables as we don't really
need them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v4:
 - move acpi_fetch_rsdp_table(s/uint32_t addr/uint64_t addr/) to
   this patch where it belongs from
   "tests: acpi: make RSDT test routine handle XSDT"
   (Wei Yang <richardw.yang@linux.intel.com>)
v2:
  - s/In case of UEFI/In case of UEFI,/ (Laszlo Ersek <lersek@redhat.com>=
)
---
 tests/acpi-utils.h       |  2 +-
 tests/acpi-utils.c       |  2 +-
 tests/bios-tables-test.c | 10 ++++------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
index f55ccf9..1da6c10 100644
--- a/tests/acpi-utils.h
+++ b/tests/acpi-utils.h
@@ -46,7 +46,7 @@ typedef struct {
=20
 uint8_t acpi_calc_checksum(const uint8_t *data, int len);
 uint32_t acpi_find_rsdp_address(QTestState *qts);
-void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table);
+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp=
_table);
 void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
                       const uint8_t *addr_ptr, int addr_size, const char=
 *sig,
                       bool verify_checksum);
diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
index a0d49c4..c216b9e 100644
--- a/tests/acpi-utils.c
+++ b/tests/acpi-utils.c
@@ -51,7 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
     return off;
 }
=20
-void acpi_fetch_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp=
_table)
+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp=
_table)
 {
     uint8_t revision;
=20
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d6ab121..a164d27 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -26,7 +26,7 @@
 typedef struct {
     const char *machine;
     const char *variant;
-    uint32_t rsdp_addr;
+    uint64_t rsdp_addr;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
     GArray *tables;
     uint32_t smbios_ep_addr;
@@ -86,13 +86,11 @@ static void test_acpi_rsdp_address(test_data *data)
=20
 static void test_acpi_rsdp_table(test_data *data)
 {
-    uint8_t *rsdp_table =3D data->rsdp_table, revision;
-    uint32_t addr =3D data->rsdp_addr;
+    uint8_t *rsdp_table =3D data->rsdp_table;
=20
-    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
-    revision =3D rsdp_table[15 /* Revision offset */];
+    acpi_fetch_rsdp_table(data->qts, data->rsdp_addr, rsdp_table);
=20
-    switch (revision) {
+    switch (rsdp_table[15 /* Revision offset */]) {
     case 0: /* ACPI 1.0 RSDP */
         /* With rev 1, checksum is only for the first 20 bytes */
         g_assert(!acpi_calc_checksum(rsdp_table,  20));
--=20
2.7.4


