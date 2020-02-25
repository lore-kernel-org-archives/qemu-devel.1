Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC98EC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE2121556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ev9x/A/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE2121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yli-0002Kp-PR
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkC-0000D9-GP
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0005ip-CK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:20 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkB-0005Zx-1Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id u6so14403144wrt.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DgpDgsU1LZ8UIKh23Ul5+S4M2ooKpM1J/352kEvw16w=;
 b=ev9x/A/7XcLcKq2sHbiFSyxx3GoWh8vSTp9EQI3WneJ+OG2u591RgrHeVyY5kA4MVs
 XRYZoZtdU8GwIaQaLzr/RDoyKWo8wnkXq8UQ9WzGTatGCqeLIJZWe9LSCrnvrzP/n0ZI
 CxWSIyqF1DjpUxVQL2m9nXcf8JDi5i0gsjhfzR4y1Nk3aW1FWd6+A758/4WuG5sW+pNZ
 sFMOFIXmhluO84pOgJuSDH6vc9WXKxmHbTxD2g6pX6iI45B2iNrvXFVbBaXy/UAgCQ0c
 cbztb2YyjsEMxpqtrt+QkV4C2jJEP2/iQqPaFlphUT/H1oBrkxjoAzveC/9OuW03HPJf
 HfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DgpDgsU1LZ8UIKh23Ul5+S4M2ooKpM1J/352kEvw16w=;
 b=BhyJD/xCnRjese+wyJuenu9BGmol2Q2m/0TPOyPs39jTCIEcRgsP7p8MAiL9LVPLUA
 qfnzu5e0zwuZe9oP7x4BsXgyCbEDuNUsMsEI/yejH3jdBbMm4nYL+Z3B5FzBrL6HT/Wm
 33xZEGCFW04YsZKaEMVOmh0iLf/vfSUwZyn5T31A5Epo1bTRyRXiFCq6ia0ZFEyLbASA
 xpa3KqmdXQ0rlh+KzyAjLZ3a1FK9dN5T1a6dUDg0dSPQvr4qEUDW5ug2X2Cijsa4Px2z
 wt7SWYzohphFTrj4yf9QzVSPMP8EMX0cS5iLBZy6iXk1nAKaTBMU4z7fwkpOhrfHRkvI
 R6kw==
X-Gm-Message-State: APjAAAWGxD920kE8tRvw/XbaD4Tc7CB1Vq2WozG/lHMF1ttZzJ5ZfNui
 sW/5XITAqYwwMgnX3q0Hgh2xLGPY
X-Google-Smtp-Source: APXvYqwoc2XAD136/Zb+mx9RNXLLFfTB7UqRu/TQwKzW7D9aZaYEbRL0beGOmG2ELKY8yGDnoF/yGg==
X-Received: by 2002:adf:f349:: with SMTP id e9mr10190116wrp.56.1582631477089; 
 Tue, 25 Feb 2020 03:51:17 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 011/136] arm/collie: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:01 +0100
Message-Id: <1582631466-13880-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

PS:
 - while at it add check for user supplied RAM size and error
   out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-12-imammedo@redhat.com>
---
 hw/arm/collie.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 970a440..4992084 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -10,6 +10,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "strongarm.h"
@@ -27,13 +28,18 @@ static void collie_init(MachineState *machine)
 {
     StrongARMState *s;
     DriveInfo *dinfo;
-    MemoryRegion *sdram = g_new(MemoryRegion, 1);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
 
     s = sa1110_init(machine->cpu_type);
 
-    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
-                                         collie_binfo.ram_size);
-    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
+    memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine->ram);
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
@@ -57,6 +63,8 @@ static void collie_machine_init(MachineClass *mc)
     mc->init = collie_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
+    mc->default_ram_size = 0x20000000;
+    mc->default_ram_id = "strongarm.sdram";
 }
 
 DEFINE_MACHINE("collie", collie_machine_init)
-- 
1.8.3.1



