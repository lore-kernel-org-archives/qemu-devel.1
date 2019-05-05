Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2546BC04AAA
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 01:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1FD206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 01:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1FD206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34932 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hN5y1-00031n-6i
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 21:29:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hN5xE-0002jq-D0
	for qemu-devel@nongnu.org; Sat, 04 May 2019 21:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hN5x5-0003ji-K6
	for qemu-devel@nongnu.org; Sat, 04 May 2019 21:28:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:17056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hN5wy-0003dy-Ah
	for qemu-devel@nongnu.org; Sat, 04 May 2019 21:28:22 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 May 2019 18:28:14 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga002.jf.intel.com with ESMTP; 04 May 2019 18:28:11 -0700
Date: Sun, 5 May 2019 09:27:45 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190505012745.GD20071@richard>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556808723-226478-6-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH v4 05/15] tests: acpi: fetch X_DSDT if
 pointer to DSDT is 0
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
	linuxarm@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>,
	Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505012745.ldCKVdM5yoEfhDLCY-LNCk5oPyxnj5df6LwVFb1eoE4@z>

On Thu, May 02, 2019 at 04:51:53PM +0200, Igor Mammedov wrote:
>that way it would be possible to test a DSDT pointed by
>64bit X_DSDT field in FADT.
>
>PS:
>it will allow to enable testing arm/virt board, which sets
>only newer X_DSDT field.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>---
>v4:
> * dropping Reviewed-bys due to acpi_fetch_table() change
>   introduced by earlier patch:
>   "tests: acpi: make acpi_fetch_table() take size of fetched table pointer"
>v2:
>  add 'val = le32_to_cpu(val)' even if it doesn't necessary
>  it works as reminder that value copied from table is in
>  little-endian format (Philippe Mathieu-Daudé <philmd@redhat.com>)
>---
> tests/bios-tables-test.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index a164d27..d165a1b 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -140,6 +140,9 @@ static void test_acpi_fadt_table(test_data *data)
>     AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
>     uint8_t *fadt_aml = table.aml;
>     uint32_t fadt_len = table.aml_len;
>+    uint32_t val;
>+    int dsdt_offset = 40 /* DSDT */;
>+    int dsdt_entry_size = 4;
> 
>     g_assert(compare_signature(&table, "FACP"));
> 
>@@ -148,8 +151,14 @@ static void test_acpi_fadt_table(test_data *data)
>                      fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
>     g_array_append_val(data->tables, table);
> 
>+    memcpy(&val, fadt_aml + dsdt_offset, 4);
>+    val = le32_to_cpu(val);
>+    if (!val) {
>+        dsdt_offset = 140 /* X_DSDT */;

In case we can point out where we get it, e.g. ACPI 5, Table 5-34 FADT Format.

This may be more helpful for reviewing and maintaining.

Do you think so?

>+        dsdt_entry_size = 8;
>+    }
>     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>-                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
>+                     fadt_aml + dsdt_offset, dsdt_entry_size, "DSDT", true);
>     g_array_append_val(data->tables, table);
> 
>     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

