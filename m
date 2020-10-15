Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0AC43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F95D20795
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F95D20795
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDSk-0007Dr-CP
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTDRQ-0005gb-Fn; Thu, 15 Oct 2020 20:17:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:30046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTDRM-0006vh-L2; Thu, 15 Oct 2020 20:17:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 725C1747627;
 Fri, 16 Oct 2020 02:17:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F16CD747620; Fri, 16 Oct 2020 02:17:35 +0200 (CEST)
Message-Id: <b4c714e03690deb6f94f80f7a5b2af47d90550ae.1602805637.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1602805637.git.balaton@eik.bme.hu>
References: <cover.1602805637.git.balaton@eik.bme.hu>
Subject: [PATCH v8 3/5] mac_oldworld: Drop a variable, use get_system_memory()
 directly
Date: Fri, 16 Oct 2020 01:47:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:17:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

Half of the occurances already use get_system_memory() directly
instead of sysmem variable, convert the two other uses to
get_system_memory() too which seems to be more common and drop the
variable.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/mac_oldworld.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0a40769b3e..5b30fa0739 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -87,7 +87,6 @@ static void ppc_heathrow_init(MachineState *machine)
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *initrd_filename = machine->initrd_filename;
     const char *boot_device = machine->boot_order;
-    MemoryRegion *sysmem = get_system_memory();
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
@@ -129,12 +128,12 @@ static void ppc_heathrow_init(MachineState *machine)
         exit(1);
     }
 
-    memory_region_add_subregion(sysmem, 0, machine->ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /* allocate and load firmware ROM */
     memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
                            &error_fatal);
-    memory_region_add_subregion(sysmem, PROM_BASE, bios);
+    memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
 
     if (!bios_name) {
         bios_name = PROM_FILENAME;
-- 
2.21.3


