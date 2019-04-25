Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C401DC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D10217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D10217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53545 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZRq-0002WL-EM
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:09:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJZQO-0001ek-Bu
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJZQN-0007Fx-3S
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJZQM-0007FS-Rl
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:08:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E70E52DA9B2;
	Thu, 25 Apr 2019 08:08:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 373C3600C1;
	Thu, 25 Apr 2019 08:07:57 +0000 (UTC)
Date: Thu, 25 Apr 2019 10:07:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190425100751.11ac20bf@redhat.com>
In-Reply-To: <20190425072256.GA24344@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-2-git-send-email-imammedo@redhat.com>
	<20190425072256.GA24344@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 25 Apr 2019 08:08:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 01/13] tests: acpi: make RSDT test
 routine handle XSDT
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
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425080751.7hvDtT38cn6UE_y4cZ0HF5_3h1vzZ8I93fWLEuiG5gA@z>

On Thu, 25 Apr 2019 15:22:56 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Thu, Apr 25, 2019 at 07:34:37AM +0200, Igor Mammedov wrote:
> >If RSDP revision is more than 0 fetch table pointed by XSDT
> >and fallback to legacy RSDT table otherwise.
> >
> >While at it drop unused acpi_get_xsdt_address().  
> 
> Would it be proper to split this into another patch?

it should be fine to remove code that's being replaced by new one
which substitutes the former within the same patch.
but if you insist I can split it into another patch.

> >
> >Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >---
> >PS:
> > it doesn't affect existing pc/q35 machines as they use RSDP.revision == 0
> > but it will be used by followup patch to enable testing arm/virt
> > board which uses provides XSDT table.
> >---
> > tests/acpi-utils.h       |  3 +--
> > tests/acpi-utils.c       | 14 +-------------
> > tests/bios-tables-test.c | 18 +++++++++++++-----
> > 3 files changed, 15 insertions(+), 20 deletions(-)
> >
> >diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
> >index ef388bb..8c68201 100644
> >--- a/tests/acpi-utils.h
> >+++ b/tests/acpi-utils.h
> >@@ -46,8 +46,7 @@ typedef struct {
> > 
> > uint8_t acpi_calc_checksum(const uint8_t *data, int len);
> > uint32_t acpi_find_rsdp_address(QTestState *qts);
> >-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table);
> >-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table);
> >+void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);  
> 
> Would you mind giving some hint of this change?
thanks for spotting it. IT certainly doesn't belong to this patch.
I'll need to recheck if supporting 64bit address fields is done properly
and find another place where to move this hunk.

> 
> > void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
> >                       const uint8_t *addr_ptr, const char *sig,
> >                       bool verify_checksum);
> >diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> >index cc33b46..9a6d1d3 100644
> >--- a/tests/acpi-utils.c
> >+++ b/tests/acpi-utils.c
> >@@ -51,19 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
> >     return off;
> > }
> > 
> >-uint64_t acpi_get_xsdt_address(uint8_t *rsdp_table)
> >-{
> >-    uint64_t xsdt_physical_address;
> >-    uint8_t revision = rsdp_table[15 /* Revision offset */];
> >-
> >-    /* We must have revision 2 if we're looking for an XSDT pointer */
> >-    g_assert(revision == 2);
> >-
> >-    memcpy(&xsdt_physical_address, &rsdp_table[24 /* XsdtAddress offset */], 8);
> >-    return le64_to_cpu(xsdt_physical_address);
> >-}
> >-
> >-void acpi_parse_rsdp_table(QTestState *qts, uint32_t addr, uint8_t *rsdp_table)
> >+void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
> > {
> >     uint8_t revision;
> > 
> >diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> >index a506dcb..24bd102 100644
> >--- a/tests/bios-tables-test.c
> >+++ b/tests/bios-tables-test.c
> >@@ -107,17 +107,25 @@ static void test_acpi_rsdp_table(test_data *data)
> >     }
> > }
> > 
> >-static void test_acpi_rsdt_table(test_data *data)
> >+static void test_acpi_rxsdt_table(test_data *data)
> > {
> >+    const char *sig = "RSDT";
> >     AcpiSdtTable rsdt = {};
> >+    int entry_size = 4;
> >+    int addr_off = 16 /* RsdtAddress */;
> >     uint8_t *ent;
> > 
> >-    /* read RSDT table */
> >+    if (data->rsdp_table[15 /* Revision offset */] != 0) {
> >+        addr_off = 24 /* XsdtAddress */;
> >+        entry_size = 8;
> >+        sig = "XSDT";
> >+    }
> >+    /* read [RX]SDT table */
> >     acpi_fetch_table(data->qts, &rsdt.aml, &rsdt.aml_len,
> >-                     &data->rsdp_table[16 /* RsdtAddress */], "RSDT", true);
> >+                     &data->rsdp_table[addr_off], sig, true);
> > 
> >     /* Load all tables and add to test list directly RSDT referenced tables */
> >-    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, 4 /* Entry size */) {
> >+    ACPI_FOREACH_RSDT_ENTRY(rsdt.aml, rsdt.aml_len, ent, entry_size) {
> >         AcpiSdtTable ssdt_table = {};
> > 
> >         acpi_fetch_table(data->qts, &ssdt_table.aml, &ssdt_table.aml_len, ent,
> >@@ -521,7 +529,7 @@ static void test_acpi_one(const char *params, test_data *data)
> >     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
> >     test_acpi_rsdp_address(data);
> >     test_acpi_rsdp_table(data);
> >-    test_acpi_rsdt_table(data);
> >+    test_acpi_rxsdt_table(data);
> >     test_acpi_fadt_table(data);
> > 
> >     if (iasl) {
> >-- 
> >2.7.4  
> 


