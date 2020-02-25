Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A23C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFC820CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EquZz8uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFC820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZIN-0004P7-Fq
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z08-0003RJ-Dx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z07-0003Sc-9v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:48 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:38099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z07-0003Qx-2u
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:47 -0500
Received: by mail-wr1-x42b.google.com with SMTP id e8so14440500wrm.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zImrZqaCtNdmyup7javw5z/mhdhAiY3TaxeN+q5aFF0=;
 b=EquZz8uYv+ZyardH0OhVQQEgay72xYV74g71LjVLx2Y32rRavf3dZ0JsYOBDkDQc31
 chzTL/IPAMaaEF8daRNcfyNzO2F76Xq1JL6KW56oFOaip6lFLSRc1lLLVJV9rx6ZDj8J
 9f3i8DAb6HzrqnYoMgiNV9a4IlvOwyggbVPnWdPFm+4d3zkmIPo7aosW7gMaLCVycRQV
 E8Vza/2BWvZXr7dz9aQbJyyLCFx+GIr2JewQwfePvaJfeGqXJhSiMlaXVlhQV/sWWl5V
 C1rJThtW+SKZVhy0J7UjhG6pRb0hlIln40K0UcBpkLPNfpF702iX1TkPqnK4aGGe6Vte
 i7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zImrZqaCtNdmyup7javw5z/mhdhAiY3TaxeN+q5aFF0=;
 b=V4FNyFxqo628Fv8IswoQ5CIlscstxaDqDOmNk6l2CqXS/k1ilceYkuu7pw+vnPQIrO
 44ymz0qP+ajH9m33bHQp8fChAVOfQ+BBBMjCQZYHIcxs2C5R9/dksEP5T87LIgwlPZyj
 aS9S6NwlnwahAHiuISw7MPjlopFUShKjIIL1rKfH3wxM4CMO4Jze5M4p1ItmiiFm7hUF
 nTmPPC6A6LZYDTC3RJ5oo6LGAD7c8xTisZ5v7QO4K5vAtD0UmWZYWYSQtib4HCNPGNqt
 p27Px4A+szdzmG7llD+Ztl4KuW2qOcc6KcXzzZoPlEmtxMW1stZif/WRGvbxXwrNVehx
 ayVw==
X-Gm-Message-State: APjAAAVNgyKGmS6fTGsiejd/iy/IhZP9TtgZAlPCHCXoswu/NLhYCQ4z
 H0Ex2SFBrQo5lXm1pOsMagws3Jk+
X-Google-Smtp-Source: APXvYqxVTLcWwCTML1bVJGByVpbDPrj63kfXi/BL0Og2UhhfZjbkDevXM6FuzpyHSlcBVXL1NoJA5g==
X-Received: by 2002:a5d:61c8:: with SMTP id q8mr1315616wrv.415.1582632462924; 
 Tue, 25 Feb 2020 04:07:42 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 109/136] hw/ppc: Use memory_region_init_rom() with read-only
 regions
Date: Tue, 25 Feb 2020 13:07:07 +0100
Message-Id: <1582632454-16491-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-12-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/ppc/mac_newworld.c | 3 +--
 hw/ppc/mac_oldworld.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 464d012..566413e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -156,13 +156,12 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
                            &error_fatal);
 
     if (bios_name == NULL)
         bios_name = PROM_FILENAME;
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    memory_region_set_readonly(bios, true);
     memory_region_add_subregion(get_system_memory(), PROM_ADDR, bios);
 
     /* Load OpenBIOS (ELF) */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 7318d7e..8b22ff6 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -132,13 +132,12 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0, ram);
 
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
                            &error_fatal);
 
     if (bios_name == NULL)
         bios_name = PROM_FILENAME;
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    memory_region_set_readonly(bios, true);
     memory_region_add_subregion(sysmem, PROM_ADDR, bios);
 
     /* Load OpenBIOS (ELF) */
-- 
1.8.3.1



