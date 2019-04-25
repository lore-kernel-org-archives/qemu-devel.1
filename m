Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E198C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32086217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32086217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZT0-0003ND-A5
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:10:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZRa-0002an-DN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZRY-0007os-Qb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:09:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:45788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZRY-0007nH-Fy
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:09:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 01:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; d="scan'208";a="164695777"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2019 01:09:09 -0700
Date: Thu, 25 Apr 2019 16:08:42 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425080842.GE24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-9-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1556170489-131927-9-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH v3 08/13] tests: acpi: add a way to start
 tests with UEFI firmware
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
Message-ID: <20190425080842.Amufc_O7vQwBvMCk09MAQ-MtcnBNdjgm8rxBsU16avg@z>

On Thu, Apr 25, 2019 at 07:34:44AM +0200, Igor Mammedov wrote:
>For testcase to use UEFI firmware, one needs to provide and specify
>firmwarei and varstore blobs names in test_data { uefi_fl1, uefi_fl2) }
                                                                     ^
					               a typo here?

>fields respectively and RAM start address plus size where to look for
>test structure signature. Additionally testcase should specify
>bootable cdrom image uefi-boot-images EFI test utility.
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>---
>v3:
>  * drop data_dir prefix and firmware will come from pc-bios directly
>  * add cdrom option so test could use it for providing boot cdrom image
>  * add TODO comment convert '-drive if=pflash' to new syntax (Laszlo)
>v2:
>  * move RAM start address and size to test_data, as it could differ
>    between boards (and even versions)
>---
> tests/bios-tables-test.c | 44 ++++++++++++++++++++++++++++++++++----------
> 1 file changed, 34 insertions(+), 10 deletions(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index 5790ee4..0f24540 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -26,6 +26,11 @@
> typedef struct {
>     const char *machine;
>     const char *variant;
>+    const char *uefi_fl1;
>+    const char *uefi_fl2;
>+    const char *cd;
>+    const uint64_t ram_start;
>+    const uint64_t scan_len;
>     uint64_t rsdp_addr;
>     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
>     GArray *tables;
>@@ -522,21 +527,40 @@ static void test_smbios_structs(test_data *data)
> static void test_acpi_one(const char *params, test_data *data)
> {
>     char *args;
>-
>-    /* Disable kernel irqchip to be able to override apic irq0. */
>-    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
>-                           "-net none -display none %s "
>-                           "-drive id=hd0,if=none,file=%s,format=raw "
>-                           "-device ide-hd,drive=hd0 ",
>-                           data->machine, "kvm:tcg",
>-                           params ? params : "", disk);
>+    bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
>+
>+    if (use_uefi) {
>+        /*
>+         * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
>+         * when arm/virt boad starts to support it.
>+         */
>+        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
>+            "-drive if=pflash,format=raw,file=%s,readonly "
>+            "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
>+            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
>+            data->cd, params ? params : "");
>+
>+    } else {
>+        /* Disable kernel irqchip to be able to override apic irq0. */
>+        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
>+            "-net none -display none %s "
>+            "-drive id=hd0,if=none,file=%s,format=raw "
>+            "-device ide-hd,drive=hd0 ",
>+             data->machine, "kvm:tcg", params ? params : "", disk);
>+    }
> 
>     data->qts = qtest_init(args);
> 
>-    boot_sector_test(data->qts);
>+    if (use_uefi) {
>+        g_assert(data->scan_len);
>+        data->rsdp_addr = acpi_find_rsdp_address_uefi(data->qts,
>+            data->ram_start, data->scan_len);

Is this possible to merge this in test_acpi_rsdp_address()? Both of them set
the data->rsdp_addr.

>+    } else {
>+        boot_sector_test(data->qts);
>+        test_acpi_rsdp_address(data);
>+    }
> 
>     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
>-    test_acpi_rsdp_address(data);
>     test_acpi_rsdp_table(data);
>     test_acpi_rxsdt_table(data);
>     test_acpi_fadt_table(data);
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

