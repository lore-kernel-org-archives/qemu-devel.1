Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4446C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9C82176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2fJz7vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9C82176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yuz-0002YX-NF
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkG-0000FV-GX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkC-0005pu-Ko
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:24 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkC-0005jc-Dv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:20 -0500
Received: by mail-wr1-x42c.google.com with SMTP id r11so14366001wrq.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NMGdW07jz13RpgDTLjRHK9kFAyaDSaygZzRyKnVqlko=;
 b=U2fJz7vd5VQv4yBy9Kjh61LgOJpW57+tiPffWdG/pMfvBTYL2GOVQy0w1BaP5pVeDy
 /+augoL28WpFxhN632Bhvty/0+EV9cr1D11iIKDOiugwS2KcXJBcAdmq2lobUTXkUw29
 FAIkn5ChIXVPkCXPIcMHXvhsmvJtigGsa8ldnNhaTnY/CFejqtagMMJnTqBswVfE4ZUB
 hm8ufyYnKkIwDNQ2MzkcAk8hlsxUoTTTk9Rv60/8WK4ztKdh2a0jUJfusCBsteAzZife
 TUS3bfOnRhsSelry2tHyFkH/u4dz+GVTXQvakWYqjfztvtVUSQF1rR626qEczbYxDjq7
 Tvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NMGdW07jz13RpgDTLjRHK9kFAyaDSaygZzRyKnVqlko=;
 b=PMNp7niwMvyqvja67EXyJWncgGglgsG0kL24bNk2CADkh9FhZl76DaC8I5J760k/yo
 EkoCT8M8mTfOagVvcwuGDbIsYv9iZEwuL7+3PXXNNpW/E2NRMgbhV+aK8GgG2hLW2nXU
 XI+dZu6BrmOGF+etX2b5lnZOklDpOEP4+FaX16gqncutaFykAUzgfaFASmyC5q54KMgg
 x8GQfbzmdVfMsXRSEiaj/HOcecWKkQMfiJPLNmFLkNAly3z3ggIz2rK3TKav6EZ2TkrJ
 o3/F+5Z7fqPn4JWlBGJuaC2qm4PqbwwYYxuQezD0XMd+/KtUwobc6GYHczc7aWn80N7g
 PkhQ==
X-Gm-Message-State: APjAAAWCRfEAljRCz93HXx7yHsGOkEGzcJjYBHfNDR6mxClNjMM+itH8
 MmXyl9+K6VecsRtsmgblB4AoviQq
X-Google-Smtp-Source: APXvYqwalFwVEoQAUrdVhh9nZ0i9U0UgLKXoxlqSYUWNT4CeOUiWHFr7IhEnPcGh6V4zwoHJ2Zmd7A==
X-Received: by 2002:adf:e550:: with SMTP id z16mr74669773wrm.5.1582631478780; 
 Tue, 25 Feb 2020 03:51:18 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 013/136] arm/digic_boards: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:03 +0100
Message-Id: <1582631466-13880-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
 remove no longer needed DigicBoardState

PS2:
 while at it add check for user supplied RAM size and error
 out if it mismatches board expected value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-14-imammedo@redhat.com>
---
 hw/arm/digic_boards.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index ef3fc2b..518a63e 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -35,39 +35,40 @@
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
 
 #define DIGIC4_ROM0_BASE      0xf0000000
 #define DIGIC4_ROM1_BASE      0xf8000000
 #define DIGIC4_ROM_MAX_SIZE   0x08000000
 
-typedef struct DigicBoardState {
-    DigicState *digic;
-    MemoryRegion ram;
-} DigicBoardState;
-
 typedef struct DigicBoard {
-    hwaddr ram_size;
-    void (*add_rom0)(DigicBoardState *, hwaddr, const char *);
+    void (*add_rom0)(DigicState *, hwaddr, const char *);
     const char *rom0_def_filename;
-    void (*add_rom1)(DigicBoardState *, hwaddr, const char *);
+    void (*add_rom1)(DigicState *, hwaddr, const char *);
     const char *rom1_def_filename;
 } DigicBoard;
 
-static void digic4_board_init(DigicBoard *board)
+static void digic4_board_init(MachineState *machine, DigicBoard *board)
 {
     Error *err = NULL;
+    DigicState *s = DIGIC(object_new(TYPE_DIGIC));
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    if (machine->ram_size != mc->default_ram_size) {
+        char *sz = size_to_str(mc->default_ram_size);
+        error_report("Invalid RAM size, should be %s", sz);
+        g_free(sz);
+        exit(EXIT_FAILURE);
+    }
 
-    DigicBoardState *s = g_new(DigicBoardState, 1);
-
-    s->digic = DIGIC(object_new(TYPE_DIGIC));
-    object_property_set_bool(OBJECT(s->digic), true, "realized", &err);
+    object_property_set_bool(OBJECT(s), true, "realized", &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't realize DIGIC SoC: ");
         exit(1);
     }
 
-    memory_region_allocate_system_memory(&s->ram, NULL, "ram", board->ram_size);
-    memory_region_add_subregion(get_system_memory(), 0, &s->ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     if (board->add_rom0) {
         board->add_rom0(s, DIGIC4_ROM0_BASE, board->rom0_def_filename);
@@ -78,7 +79,7 @@ static void digic4_board_init(DigicBoard *board)
     }
 }
 
-static void digic_load_rom(DigicBoardState *s, hwaddr addr,
+static void digic_load_rom(DigicState *s, hwaddr addr,
                            hwaddr max_size, const char *def_filename)
 {
     target_long rom_size;
@@ -118,7 +119,7 @@ static void digic_load_rom(DigicBoardState *s, hwaddr addr,
  * Samsung K8P3215UQB
  * 64M Bit (4Mx16) Page Mode / Multi-Bank NOR Flash Memory
  */
-static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
+static void digic4_add_k8p3215uqb_rom(DigicState *s, hwaddr addr,
                                       const char *def_filename)
 {
 #define FLASH_K8P3215UQB_SIZE (4 * 1024 * 1024)
@@ -135,14 +136,13 @@ static void digic4_add_k8p3215uqb_rom(DigicBoardState *s, hwaddr addr,
 }
 
 static DigicBoard digic4_board_canon_a1100 = {
-    .ram_size = 64 * 1024 * 1024,
     .add_rom1 = digic4_add_k8p3215uqb_rom,
     .rom1_def_filename = "canon-a1100-rom1.bin",
 };
 
 static void canon_a1100_init(MachineState *machine)
 {
-    digic4_board_init(&digic4_board_canon_a1100);
+    digic4_board_init(machine, &digic4_board_canon_a1100);
 }
 
 static void canon_a1100_machine_init(MachineClass *mc)
@@ -150,6 +150,8 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->desc = "Canon PowerShot A1100 IS";
     mc->init = &canon_a1100_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_ram_size = 64 * MiB;
+    mc->default_ram_id = "ram";
 }
 
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
-- 
1.8.3.1



