Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDAC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D9C206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 20:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D9C206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbA6C-0006X9-Jd
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 16:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53622)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hbA5B-0005lj-BP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hbA53-00075y-Sd
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:42:52 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:40544
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hbA4x-0006Tt-5A
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 16:42:45 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
 ([81.158.188.206] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hbA1e-0003CX-Rd; Wed, 12 Jun 2019 21:39:19 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	atar4qemu@gmail.com,
	pbonzini@redhat.com
Date: Wed, 12 Jun 2019 21:39:16 +0100
Message-Id: <20190612203916.16875-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PATCH] sun4m: set default display type to TCX
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 6807874d55 "sun4m: obey -vga none" changed the sun4m machines so that
they could be started without a framebuffer installed, but as no default
display type was configured the machines would start in headless mode without
an explict -vga option.

Set the default display type for all sun4m machines to TCX so that they will
start with a framebuffer if one is not specifically requested.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/sun4m.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 7e4f61fc3e..99f53e87f7 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1406,6 +1406,7 @@ static void ss5_class_init(ObjectClass *oc, void *data)
     mc->is_default = 1;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo ss5_type = {
@@ -1424,6 +1425,7 @@ static void ss10_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo ss10_type = {
@@ -1442,6 +1444,7 @@ static void ss600mp_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo ss600mp_type = {
@@ -1460,6 +1463,7 @@ static void ss20_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo ss20_type = {
@@ -1477,6 +1481,7 @@ static void voyager_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo voyager_type = {
@@ -1494,6 +1499,7 @@ static void ss_lx_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo ss_lx_type = {
@@ -1511,6 +1517,7 @@ static void ss4_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo ss4_type = {
@@ -1528,6 +1535,7 @@ static void scls_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo scls_type = {
@@ -1545,6 +1553,7 @@ static void sbook_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
+    mc->default_display = "tcx";
 }
 
 static const TypeInfo sbook_type = {
-- 
2.11.0


