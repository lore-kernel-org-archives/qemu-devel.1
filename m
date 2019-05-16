Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5A6C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C8A20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C8A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFVt-00010t-51
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:29:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNX-0001p7-Nr
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNU-0002w5-NG
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:55 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNU-0002ve-KW
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:52 -0400
Received: by mail-qk1-f177.google.com with SMTP id a132so2023828qkb.13
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=im+qbcew1Qe+0x5KgoK3OVmxTwCql9ERQ/Z1WYRFGjA=;
	b=KTTpP5Py3OB6db5bWOG6Pe/JFjSKZkp9qK9fHGX5oEjnBVtILiFoKYqrA0Kwf84TiN
	p1UwHAfROuz5y/LYBO7yPe5tFSLTllZcstWRcUdQ8+LmXtg0xeyjpImfSxTHLHt+vtTU
	V+BZ3LB24sfoDjqDOCgEDWoiun3LZQI6OBrToHNGeJ7xEch+zAMj8xCDh/Ondm+J7dcE
	LF1k26xnmfm8TuLfG5s4RVEo2nAfUtDlAuCZ4Qkp4p/mt4Q7MwaFzSPhNxX+UXeaxIwN
	YXdoEG0uNq4+/nkB8qi5auZI7vrZFcApP93JjRUtxTP8zawXqugd06B41Aj1xPBgJQlB
	C4qA==
X-Gm-Message-State: APjAAAWced/1TC43R/clazxE1yeJ329lJqCr1dBZO+KjsaS9hmPf9L86
	l6sS/liEvspev2xwMCN53a48B2GV+uI=
X-Google-Smtp-Source: APXvYqzjGo9wq+Re2v+JKm0JeZ9jzOLSfjDPdR3VfthW2h/69+HH9bFPDs7vrwlYrmdP3/nHuliqGw==
X-Received: by 2002:a05:620a:1012:: with SMTP id
	z18mr38072891qkj.205.1558009251771; 
	Thu, 16 May 2019 05:20:51 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	t17sm3555117qte.66.2019.05.16.05.20.49
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:20:51 -0700 (PDT)
Date: Thu, 16 May 2019 08:20:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-10-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.177
Subject: [Qemu-devel] [PULL 31/37] tests: acpi: add a way to start tests
 with UEFI firmware
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516122048.4_EMfQpueWVwZtrsxYOdU1lFdocwhTyLvfL1Af-gEBY@z>

From: Igor Mammedov <imammedo@redhat.com>

For testcase to use UEFI firmware, one needs to provide and specify
firmware and varstore blob names in test_data { uefi_fl1, uefi_fl2 }
fields respectively and RAM start address plus size where to look for
test structure signature. Additionally testcase should specify
bootable cdrom image from uefi-boot-images with EFI test utility.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <1556808723-226478-10-git-send-email-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 50 +++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4d13a3cce6..84e1ce2972 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -26,6 +26,11 @@
 typedef struct {
     const char *machine;
     const char *variant;
+    const char *uefi_fl1;
+    const char *uefi_fl2;
+    const char *cd;
+    const uint64_t ram_start;
+    const uint64_t scan_len;
     uint64_t rsdp_addr;
     uint8_t rsdp_table[36 /* ACPI 2.0+ RSDP size */];
     GArray *tables;
@@ -77,13 +82,6 @@ static void free_test_data(test_data *data)
     g_array_free(data->tables, true);
 }
 
-static void test_acpi_rsdp_address(test_data *data)
-{
-    uint32_t off = acpi_find_rsdp_address(data->qts);
-    g_assert_cmphex(off, <, 0x100000);
-    data->rsdp_addr = off;
-}
-
 static void test_acpi_rsdp_table(test_data *data)
 {
     uint8_t *rsdp_table = data->rsdp_table;
@@ -524,21 +522,41 @@ static void test_smbios_structs(test_data *data)
 static void test_acpi_one(const char *params, test_data *data)
 {
     char *args;
+    bool use_uefi = data->uefi_fl1 && data->uefi_fl2;
 
-    /* Disable kernel irqchip to be able to override apic irq0. */
-    args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
-                           "-net none -display none %s "
-                           "-drive id=hd0,if=none,file=%s,format=raw "
-                           "-device ide-hd,drive=hd0 ",
-                           data->machine, "kvm:tcg",
-                           params ? params : "", disk);
+    if (use_uefi) {
+        /*
+         * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
+         * when arm/virt boad starts to support it.
+         */
+        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
+            "-drive if=pflash,format=raw,file=%s,readonly "
+            "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
+            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
+            data->cd, params ? params : "");
+
+    } else {
+        /* Disable kernel irqchip to be able to override apic irq0. */
+        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
+            "-net none -display none %s "
+            "-drive id=hd0,if=none,file=%s,format=raw "
+            "-device ide-hd,drive=hd0 ",
+             data->machine, "kvm:tcg", params ? params : "", disk);
+    }
 
     data->qts = qtest_init(args);
 
-    boot_sector_test(data->qts);
+    if (use_uefi) {
+        g_assert(data->scan_len);
+        data->rsdp_addr = acpi_find_rsdp_address_uefi(data->qts,
+            data->ram_start, data->scan_len);
+    } else {
+        boot_sector_test(data->qts);
+        data->rsdp_addr = acpi_find_rsdp_address(data->qts);
+        g_assert_cmphex(data->rsdp_addr, <, 0x100000);
+    }
 
     data->tables = g_array_new(false, true, sizeof(AcpiSdtTable));
-    test_acpi_rsdp_address(data);
     test_acpi_rsdp_table(data);
     test_acpi_rxsdt_table(data);
     test_acpi_fadt_table(data);
-- 
MST


