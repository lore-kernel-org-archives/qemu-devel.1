Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABAEC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CED020878
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CED020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJYlq-0007nT-Tk
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 03:26:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJYl6-00071d-Bh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJYl5-00061E-B3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:25:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:58897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJYl5-00060R-32
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:25:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 00:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; d="scan'208";a="134224588"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga007.jf.intel.com with ESMTP; 25 Apr 2019 00:25:22 -0700
Date: Thu, 25 Apr 2019 15:24:55 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425072455.GB24344@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556170489-131927-3-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH v3 02/13] tests: acpi: rename
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
Message-ID: <20190425072455._6y5OeuVJJ89UgzqkrewV2jUGSEdouc_rEd1zawWiWk@z>

On Thu, Apr 25, 2019 at 07:34:38AM +0200, Igor Mammedov wrote:
>so name would reflect what the function does
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/acpi-utils.h       | 2 +-
> tests/acpi-utils.c       | 2 +-
> tests/bios-tables-test.c | 2 +-
> tests/vmgenid-test.c     | 2 +-
> 4 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/tests/acpi-utils.h b/tests/acpi-utils.h
>index 8c68201..75f78f2 100644
>--- a/tests/acpi-utils.h
>+++ b/tests/acpi-utils.h
>@@ -46,7 +46,7 @@ typedef struct {
> 
> uint8_t acpi_calc_checksum(const uint8_t *data, int len);
> uint32_t acpi_find_rsdp_address(QTestState *qts);
>-void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
>+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table);
> void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>                       const uint8_t *addr_ptr, const char *sig,
>                       bool verify_checksum);
>diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
>index 9a6d1d3..2dd4fe0 100644
>--- a/tests/acpi-utils.c
>+++ b/tests/acpi-utils.c
>@@ -51,7 +51,7 @@ uint32_t acpi_find_rsdp_address(QTestState *qts)
>     return off;
> }
> 
>-void acpi_parse_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
>+void acpi_fetch_rsdp_table(QTestState *qts, uint64_t addr, uint8_t *rsdp_table)
> {
>     uint8_t revision;
> 
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index 24bd102..2ee044c 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -89,7 +89,7 @@ static void test_acpi_rsdp_table(test_data *data)
>     uint8_t *rsdp_table = data->rsdp_table, revision;
>     uint32_t addr = data->rsdp_addr;
> 
>-    acpi_parse_rsdp_table(data->qts, addr, rsdp_table);
>+    acpi_fetch_rsdp_table(data->qts, addr, rsdp_table);
>     revision = rsdp_table[15 /* Revision offset */];
> 
>     switch (revision) {
>diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
>index ae38ee5..f400184 100644
>--- a/tests/vmgenid-test.c
>+++ b/tests/vmgenid-test.c
>@@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
>     g_assert_cmphex(rsdp_offset, <, RSDP_ADDR_INVALID);
> 
> 
>-    acpi_parse_rsdp_table(qts, rsdp_offset, rsdp_table);
>+    acpi_fetch_rsdp_table(qts, rsdp_offset, rsdp_table);
>     acpi_fetch_table(qts, &rsdt, &rsdt_len, &rsdp_table[16 /* RsdtAddress */],
>                      "RSDT", true);
> 
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

