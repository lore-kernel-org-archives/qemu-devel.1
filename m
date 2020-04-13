Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81250C2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489D1206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 20:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNw7cq3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489D1206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO5ns-0006MG-E9
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 16:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO5mK-0005DD-Or
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO5mJ-0000lw-MW
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:34:00 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jO5mJ-0000lg-GB
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 16:33:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id k11so11016170wrp.5
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TSTOgqIqkHP/A6SEq23VPb4QmBizW4+fbueFj4i2CPw=;
 b=aNw7cq3+8KXzWk3JWdUnifnGtCtfiMMk9+0FNN4hsxYU8NUL4ihIN0QZ/59z7S5oAE
 9wCoMBzMHzsuOao8uSC9ItkEplzIn3uL1PJpbDCefxQ9g4Zn20GqutEnIt5wa6ONZUM2
 CDsFJTJF/Q/bfNc6Xw2d4j9VZYqmF2aXwD+UZGL1/d8VxyMKK94dtCqkvnDzZ3+nIHIH
 v/uDVu5yOfqgBWGWUCbzozu9fcaWmEcV7zDHXx+8qEVwv2+TnC44sgOdr2lJNc/MJGw6
 i3FnY1fimduDHHiB/vR6osAUYNHbKd82bulwPjA606/g9LsGyt3q/d26FgwU1LcIq9Dv
 jwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=TSTOgqIqkHP/A6SEq23VPb4QmBizW4+fbueFj4i2CPw=;
 b=PFfxoaVRnFcWHoUcYc6ElZCAvwVnQHJ7YuwroiGlmdEUkr0zN6CjDL5JYc33E5SiAm
 acwYgcWBLzrEoKNJIh6SGvtO1IyCtT+8VggsrdRor3y2OmN8UYOrWaNypLpGGBQc7Yhg
 XPHEu6wD0N42gF4Q+qwkyxGaqe8YPogjDlyttt4RCcjfAkQ5nzwuSnxNl95vYjp5JP0n
 Fzf6NY29tzOfq3z2i9ldkhmjqpNTTimzxkY3TdWSIrhKrISQKLh034y7GA5aBcuYQ9Ay
 rKEy7blegW+ERzqeIfpy1tc+e7OhzNPqw4UhF3JOopgqBN6iJtJOCtK0OLNf8QcXbAD0
 +PQQ==
X-Gm-Message-State: AGi0PuagBcJu5PNssGlsl8qFM4Nvw8ChCA/oOsfWsTLugg5JV2e3xGAe
 +xXPhCzUBCat2SJsl5/g09OAOk3rBJ/4Lg==
X-Google-Smtp-Source: APiQypJiBME2Z8nP2c+ZIdmqOWuUO4dAGgiEvbalzHjaDeEA0+leygUgmTik2/BLaBUTZP/DabfxCg==
X-Received: by 2002:a05:6000:4:: with SMTP id
 h4mr20875286wrx.386.1586810037973; 
 Mon, 13 Apr 2020 13:33:57 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id i97sm17519238wri.1.2020.04.13.13.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 13:33:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 6/7] hw/mips/mips_malta: Use &error_abort in
 MachineClass::init -> create_cps
Date: Mon, 13 Apr 2020 22:33:49 +0200
Message-Id: <20200413203349.30590-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: 20200412224517.12869-1-f4bug@amsat.org
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Running the coccinelle script produced:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
    --keep-comments --smpl-spacing --dir .
  HANDLING: ./hw/mips/mips_malta.c
  [[manual check required: error_propagate() might be missing in object_property_set_int() ./hw/mips/mips_malta.c:1193:4]]
  [[manual check required: error_propagate() might be missing in object_property_set_str() ./hw/mips/mips_malta.c:1192:4]]

Since create_cps() is called from a MachineClass::init(),
replace local Error* by &error_abort.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Use &error_fatal (rth)
---
 hw/mips/mips_malta.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e4c4de1b4e..477ee6cc5b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -51,7 +51,6 @@
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
-#include "qemu/error-report.h"
 #include "hw/empty_slot.h"
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
@@ -1185,17 +1184,13 @@ static void create_cpu_without_cps(MachineState *ms,
 static void create_cps(MachineState *ms, MaltaState *s,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
-    Error *err = NULL;
-
     sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->cps),
                           TYPE_MIPS_CPS);
-    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", &err);
-    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &err);
-    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
-    if (err != NULL) {
-        error_report("%s", error_get_pretty(err));
-        exit(1);
-    }
+    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
+                            &error_fatal);
+    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
+                            &error_fatal);
+    object_property_set_bool(OBJECT(&s->cps), true, "realized", &error_fatal);
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
-- 
2.21.1


