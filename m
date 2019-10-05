Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E9C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AE1222CA
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AE1222CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsJb-0002B9-0M
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5m-0005XX-PZ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 18:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5k-0004Wc-GI
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5i-0004Uq-Hj
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:56 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACB7483F3F
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:53 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id c8so10911647qtd.20
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aQhVmGkFzS24dv6PIBrmiGUubZt2us2kS6DieR1TqNw=;
 b=SCEic/vGnslQrb71wjx8wMy4YWgZB18HZbBJZX89+CUrUDkPTZaE/Flre4x+AH4d7u
 OFgEPvDFlpRiderAQjpox2pSakfdIa0P0bZgnB3tbh+qCn/OMx9XzbL6OYLpcDwWayHA
 dXRiSkRcV8+8XiUPqrs3a1h7rz7JfMQjYSx7Ils/4pdZCDzWRXZz3U0xEiYubFmbYbL7
 SQdZ/AQWD757s3N6OVQe39dy5dZoQ50xjm7hVCysh654JKqDwtdpOBZpu81ZLu7EgakP
 edbBr0x+1pLYfX6NkOQ3PIPIIorx4ScaB767t9D5xP1lfMKiQiDprfl1ooU7SMYSZDZ6
 JtEA==
X-Gm-Message-State: APjAAAW9NefyLEtYlEGDYmkWgT4J8q4zQOu6WWgQX3sa9ofcr3b8WkxD
 AcqGXIrkxCzphVosPKU3R56GtFkbC9eeiA3Qi9O1MOgcswG4JnfGfl946piEiEyBTEvrVLgfRP8
 TQ3WSkTt+4nDBypA=
X-Received: by 2002:ac8:1b32:: with SMTP id y47mr3743436qtj.241.1570312792724; 
 Sat, 05 Oct 2019 14:59:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwyC2qocKVRtP6UHS8xs0VDycXjYq3O+tEhByXDc1tGyfaIMW95s8anX7RlK3BMV9kqDfUOxQ==
X-Received: by 2002:ac8:1b32:: with SMTP id y47mr3743421qtj.241.1570312792548; 
 Sat, 05 Oct 2019 14:59:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 v7sm4883430qte.29.2019.10.05.14.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:51 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] tests: Add bios tests to arm/virt
Message-ID: <20190918130633.4872-12-shameerali.kolothum.thodi@huawei.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215947.KdbXKDWPuiTDiz18h0CWXe7gbmxsa8uicqKN-8VcVsc@z>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This adds numamem and memhp tests for arm/virt platform.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190918130633.4872-12-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 8b066cc8f9..652a78773f 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -873,6 +873,53 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
     test_acpi_tcg_dimm_pxm(MACHINE_PC);
 }
 
+static void test_acpi_virt_tcg_memhp(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .accel = "tcg",
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 256ULL * 1024 * 1024,
+    };
+
+    data.variant = ".memhp";
+    test_acpi_one(" -cpu cortex-a57"
+                  " -m 256M,slots=3,maxmem=1G"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -object memory-backend-ram,id=ram1,size=128M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
+                  " -numa dist,src=0,dst=1,val=21",
+                  &data);
+
+    free_test_data(&data);
+
+}
+
+static void test_acpi_virt_tcg_numamem(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .accel = "tcg",
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * 1024 * 1024,
+    };
+
+    data.variant = ".numamem";
+    test_acpi_one(" -cpu cortex-a57"
+                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node,memdev=ram0",
+                  &data);
+
+    free_test_data(&data);
+
+}
+
 static void test_acpi_virt_tcg(void)
 {
     test_data data = {
@@ -919,6 +966,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
     } else if (strcmp(arch, "aarch64") == 0) {
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
+        qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
+        qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
MST


