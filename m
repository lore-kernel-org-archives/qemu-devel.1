Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0066C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8E221871
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 21:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8E221871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hin8k-0007PQ-SU
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 17:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38615)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1himWA-0006gh-1k
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1himW7-0007YT-3r
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1himW6-0007WQ-RQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:10:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B31560CC;
 Wed,  3 Jul 2019 21:10:14 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E0E01001925;
 Wed,  3 Jul 2019 21:10:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 18:08:21 -0300
Message-Id: <20190703210821.27550-44-ehabkost@redhat.com>
In-Reply-To: <20190703210821.27550-1-ehabkost@redhat.com>
References: <20190703210821.27550-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 21:10:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v5 43/43] tests: use -numa memdev option in
 tests instead of legacy 'mem' option
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

it will test preferred memdev option more extensively and remove
undesired deprecation warnings during 'make check'

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190702140745.27767-3-imammedo@redhat.com>
[ehabkost: remove numa-test.c changes]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/bios-tables-test.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 0ce55182f2..d863233fe9 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -688,6 +688,8 @@ static void test_acpi_q35_tcg_mmio64(void)
     };
 
     test_acpi_one("-m 128M,slots=1,maxmem=2G "
+                  "-object memory-backend-ram,id=ram0,size=128M "
+                  "-numa node,memdev=ram0 "
                   "-device pci-testdev,membar=2G",
                   &data);
     free_test_data(&data);
@@ -701,7 +703,9 @@ static void test_acpi_piix4_tcg_cphp(void)
     data.machine = MACHINE_PC;
     data.variant = ".cphp";
     test_acpi_one("-smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -715,7 +719,9 @@ static void test_acpi_q35_tcg_cphp(void)
     data.machine = MACHINE_Q35;
     data.variant = ".cphp";
     test_acpi_one(" -smp 2,cores=3,sockets=2,maxcpus=6"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -766,7 +772,9 @@ static void test_acpi_q35_tcg_memhp(void)
     data.machine = MACHINE_Q35;
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -780,7 +788,9 @@ static void test_acpi_piix4_tcg_memhp(void)
     data.machine = MACHINE_PC;
     data.variant = ".memhp";
     test_acpi_one(" -m 128,slots=3,maxmem=1G"
-                  " -numa node -numa node"
+                  " -object memory-backend-ram,id=ram0,size=64M"
+                  " -object memory-backend-ram,id=ram1,size=64M"
+                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
                   " -numa dist,src=0,dst=1,val=21",
                   &data);
     free_test_data(&data);
@@ -793,7 +803,8 @@ static void test_acpi_q35_tcg_numamem(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_Q35;
     data.variant = ".numamem";
-    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node -numa node,memdev=ram0", &data);
     free_test_data(&data);
 }
 
@@ -804,7 +815,8 @@ static void test_acpi_piix4_tcg_numamem(void)
     memset(&data, 0, sizeof(data));
     data.machine = MACHINE_PC;
     data.variant = ".numamem";
-    test_acpi_one(" -numa node -numa node,mem=128", &data);
+    test_acpi_one(" -object memory-backend-ram,id=ram0,size=128M"
+                  " -numa node -numa node,memdev=ram0", &data);
     free_test_data(&data);
 }
 
@@ -818,17 +830,21 @@ static void test_acpi_tcg_dimm_pxm(const char *machine)
     test_acpi_one(" -machine nvdimm=on,nvdimm-persistence=cpu"
                   " -smp 4,sockets=4"
                   " -m 128M,slots=3,maxmem=1G"
-                  " -numa node,mem=32M,nodeid=0"
-                  " -numa node,mem=32M,nodeid=1"
-                  " -numa node,mem=32M,nodeid=2"
-                  " -numa node,mem=32M,nodeid=3"
+                  " -object memory-backend-ram,id=ram0,size=32M"
+                  " -object memory-backend-ram,id=ram1,size=32M"
+                  " -object memory-backend-ram,id=ram2,size=32M"
+                  " -object memory-backend-ram,id=ram3,size=32M"
+                  " -numa node,memdev=ram0,nodeid=0"
+                  " -numa node,memdev=ram1,nodeid=1"
+                  " -numa node,memdev=ram2,nodeid=2"
+                  " -numa node,memdev=ram3,nodeid=3"
                   " -numa cpu,node-id=0,socket-id=0"
                   " -numa cpu,node-id=1,socket-id=1"
                   " -numa cpu,node-id=2,socket-id=2"
                   " -numa cpu,node-id=3,socket-id=3"
-                  " -object memory-backend-ram,id=ram0,size=128M"
+                  " -object memory-backend-ram,id=ram4,size=128M"
                   " -object memory-backend-ram,id=nvm0,size=128M"
-                  " -device pc-dimm,id=dimm0,memdev=ram0,node=1"
+                  " -device pc-dimm,id=dimm0,memdev=ram4,node=1"
                   " -device nvdimm,id=dimm1,memdev=nvm0,node=2",
                   &data);
     free_test_data(&data);
-- 
2.18.0.rc1.1.g3f1ff2140


