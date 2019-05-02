Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A19C04AAA
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0CF2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0CF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDMo-0004kw-ND
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:11:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4f-0005WL-RV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4e-00031Z-QU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4e-00030t-IX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC1B2307D962;
	Thu,  2 May 2019 14:52:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCF6471C80;
	Thu,  2 May 2019 14:52:31 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:51:59 +0200
Message-Id: <1556808723-226478-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 02 May 2019 14:52:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 11/15] tests: acpi: allow to override
 default accelerator
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502145159.d9v75JP6IrMZMrFFHO6wsw2Iu-AIAexrKw5yoZBSWdw@z>

By default test cases were run with 'kvm:tcg' accelerators to speed up
tests execution. While it works for x86, were change of accelerator
doesn't affect ACPI tables, the approach doesn't works for ARM usecase
though.

In arm/virt case, KVM mode requires using 'host' cpu model, which
isn't available in TCG mode. That could be worked around with 'max'
cpu model, which works both for KVM and TCG. However in KVM mode it
is necessary to specify matching GIC version, which also could use
'max' value to automatically pick GIC version suitable for host's CPU.
Depending on host cpu type, different GIC versions would be used,
which in turn leads to different ACPI tables (APIC) generated.
As result while comparing with reference blobs, test would fail if
host's GIC version won't match the version on the host where
reference blobs where generated.

Let's keep testing simple for now and allow ARM tests run in TCG only
mode. To do so introduce 'accel' parameter in test configuration, so
test case could override default "kvm:tcg" with accelerator of choice.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 8302ffc..39c1e24 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -24,6 +24,7 @@
 #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
 
 typedef struct {
+    const char *accel;
     const char *machine;
     const char *variant;
     const char *uefi_fl1;
@@ -532,8 +533,8 @@ static void test_acpi_one(const char *params, test_data *data)
         args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
             "-drive if=pflash,format=raw,file=%s,readonly "
             "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
-            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
-            data->cd, params ? params : "");
+            data->machine, data->accel ? data->accel : "kvm:tcg",
+            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
 
     } else {
         /* Disable kernel irqchip to be able to override apic irq0. */
@@ -541,7 +542,8 @@ static void test_acpi_one(const char *params, test_data *data)
             "-net none -display none %s "
             "-drive id=hd0,if=none,file=%s,format=raw "
             "-device ide-hd,drive=hd0 ",
-             data->machine, "kvm:tcg", params ? params : "", disk);
+             data->machine, data->accel ? data->accel : "kvm:tcg",
+             params ? params : "", disk);
     }
 
     data->qts = qtest_init(args);
-- 
2.7.4


