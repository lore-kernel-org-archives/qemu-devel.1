Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B1DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279D821019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279D821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59810 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFWd-0007JP-Dw
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 01:53:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hOFV3-0006IC-4I
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hOFV2-0000YO-1y
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:52:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:55763)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hOFV1-0000XR-Q9
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:52:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 22:52:13 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga007.fm.intel.com with ESMTP; 07 May 2019 22:52:10 -0700
Date: Wed, 8 May 2019 13:51:44 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190508055144.GA18891@richard>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
	<1556808723-226478-6-git-send-email-imammedo@redhat.com>
	<20190505012745.GD20071@richard>
	<20190507120408.32b49e99@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507120408.32b49e99@Igors-MacBook-Pro>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
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
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	linuxarm@huawei.com, Shannon Zhao <shannon.zhaosl@gmail.com>,
	Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 12:04:08PM +0200, Igor Mammedov wrote:
>On Sun, 5 May 2019 09:27:45 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>
>> On Thu, May 02, 2019 at 04:51:53PM +0200, Igor Mammedov wrote:
>> >that way it would be possible to test a DSDT pointed by
>> >64bit X_DSDT field in FADT.
>> >
>> >PS:
>> >it will allow to enable testing arm/virt board, which sets
>> >only newer X_DSDT field.
>> >
>> >Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> >---
>> >v4:
>> > * dropping Reviewed-bys due to acpi_fetch_table() change
>> >   introduced by earlier patch:
>> >   "tests: acpi: make acpi_fetch_table() take size of fetched table pointer"
>> >v2:
>> >  add 'val = le32_to_cpu(val)' even if it doesn't necessary
>> >  it works as reminder that value copied from table is in
>> >  little-endian format (Philippe Mathieu-Daudé <philmd@redhat.com>)
>> >---
>> > tests/bios-tables-test.c | 11 ++++++++++-
>> > 1 file changed, 10 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>> >index a164d27..d165a1b 100644
>> >--- a/tests/bios-tables-test.c
>> >+++ b/tests/bios-tables-test.c
>> >@@ -140,6 +140,9 @@ static void test_acpi_fadt_table(test_data *data)
>> >     AcpiSdtTable table = g_array_index(data->tables, typeof(table), 0);
>> >     uint8_t *fadt_aml = table.aml;
>> >     uint32_t fadt_len = table.aml_len;
>> >+    uint32_t val;
>> >+    int dsdt_offset = 40 /* DSDT */;
>> >+    int dsdt_entry_size = 4;
>> > 
>> >     g_assert(compare_signature(&table, "FACP"));
>> > 
>> >@@ -148,8 +151,14 @@ static void test_acpi_fadt_table(test_data *data)
>> >                      fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false);
>> >     g_array_append_val(data->tables, table);
>> > 
>> >+    memcpy(&val, fadt_aml + dsdt_offset, 4);
>> >+    val = le32_to_cpu(val);
>> >+    if (!val) {
>> >+        dsdt_offset = 140 /* X_DSDT */;
>> 
>> In case we can point out where we get it, e.g. ACPI 5, Table 5-34 FADT Format.
>> 
>> This may be more helpful for reviewing and maintaining.
>
>for fields we typically use only verbatim field name, so it would be easy
>to find by searching for it in spec. In this case it is obvious about which
>table it applies to, so reference to spec for a field probably excessive.
>
>Complete reference necessary for tables and API functions that implement
>ACPI primitive.
>

That's fine.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

-- 
Wei Yang
Help you, Help me

