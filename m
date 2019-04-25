Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF777C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1ED7217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 07:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1ED7217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZ8u-0006aJ-2Z
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 03:50:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZ7f-00061K-AQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZ7d-00023R-O6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:36762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZ7d-00022f-Ew
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 03:48:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 00:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; d="scan'208";a="318815659"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga005.jf.intel.com with ESMTP; 25 Apr 2019 00:48:40 -0700
Date: Thu, 25 Apr 2019 15:48:13 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425074813.GC24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556170489-131927-6-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH v3 05/13] tests: acpi: skip FACS table if
 board uses hw reduced ACPI profile
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
Message-ID: <20190425074813.bMyuT9SzSHmlZxtOeqEIf9DceiQ7n4x6YttQEgFEem4@z>

On Thu, Apr 25, 2019 at 07:34:41AM +0200, Igor Mammedov wrote:
>If FADT has HW_REDUCED_ACPI flag set, do not attempt to fetch
>FACS as it's not provided by the board.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/bios-tables-test.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index ed62a17..e944d00 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -146,9 +146,13 @@ static void test_acpi_fadt_table(test_data *data)
>     g_assert(compare_signature(&table, "FACP"));
> 
>     /* Since DSDT/FACS isn't in RSDT, add them to ASL test list manually */
>-    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>-                     fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
>-    g_array_append_val(data->tables, table);
>+    memcpy(&val, fadt_aml + 112 /* Flags */, 4);
>+    val = le32_to_cpu(val);
>+    if (!(val & 1UL << 20 /* HW_REDUCED_ACPI */)) {
>+        acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
>+                         fadt_aml + 36 /* FIRMWARE_CTRL */, "FACS", false);
>+        g_array_append_val(data->tables, table);
>+    }
> 
>     memcpy(&val, fadt_aml + dsdt_offset, 4);
>     val = le32_to_cpu(val);
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

