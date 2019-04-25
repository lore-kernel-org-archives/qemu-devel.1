Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC6CC10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10D2217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10D2217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZ5J-0004pi-UR
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 03:46:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZ3o-0003sw-FQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZ3n-0007qO-FP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:44:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:26871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZ3n-0007nn-6l
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:44:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 00:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; d="scan'208";a="138673510"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga006.jf.intel.com with ESMTP; 25 Apr 2019 00:44:42 -0700
Date: Thu, 25 Apr 2019 15:44:16 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425074416.GB24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-5-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556170489-131927-5-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH v3 04/13] tests: acpi: fetch X_DSDT if
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
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425074416.thTBK5wUw39yWKDkAljKCv-OP43HSOodaDR2XkCB5GM@z>

On Thu, Apr 25, 2019 at 07:34:40AM +0200, Igor Mammedov wrote:
>that way it would be possible to test a DSDT pointed by
>64bit X_DSDT field in FADT.
>
>PS:
>it will allow to enable testing arm/virt board, which sets
>only newer X_DSDT field.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
>v2:
>  add 'val = le32_to_cpu(val)' even if it doesn't necessary
>  it works as reminder that value copied from table is in
>  little-endian format (Philippe Mathieu-Daudé <philmd@redhat.com>)
>---
> tests/bios-tables-test.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index c29dcf4..ed62a17 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -140,6 +140,8 @@ static void test_acpi_fadt_table(test_data *data)
>     AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
>     uint8_t *fadt_aml = table.aml;
>     uint32_t fadt_len = table.aml_len;
>+    uint32_t val;
>+    int dsdt_offset = 40 /* DSDT */;
> 
>     g_assert(compare_signature(&table, "FACP"));
> 
>@@ -148,8 +150,13 @@ static void test_acpi_fadt_table(test_data *data)
>                      fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
>     g_array_append_val(data->tables, table);
> 
>+    memcpy(&val, fadt_aml + dsdt_offset, 4);
>+    val = le32_to_cpu(val);
>+    if (!val) {
>+        dsdt_offset = 140 /* X_DSDT */;
>+    }
>     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>-                     fadt_aml + 40 /* DSDT */, "DSDT", true);
>+                     fadt_aml + dsdt_offset, "DSDT", true);
>     g_array_append_val(data->tables, table);
> 
>     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

