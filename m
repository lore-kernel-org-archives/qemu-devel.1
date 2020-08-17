Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BD8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5935C2054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCEfY4y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5935C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7htn-00083h-HA
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqj-00029D-Az
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqh-000539-HL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id t14so14376058wmi.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5o+8zFBOWm3p7LnG75e3VpkH6O/dHPqDS3Ofte53ZGM=;
 b=DCEfY4y/rGKcmZ/42cFavRPdYlWV26f4P28jXg9EKe5X4GNvty+sBalaztPiHlGyR/
 sunTBtPsCrOC5HO8sDbjUpiIeMPM686eHW2wlUrFcFXz8K1q36imW4/0S4FvYnhk9rbS
 d2EAOI6QHby65JbpavxwG69Wa8byfzEXPGkBESDDpHih+iLxKAIm47yw0ZQ2q2GEoiNT
 xBIi6Ax2bnihvrMeXBPVyC4UffR/ScbnJW9j6vTPPSStONori8eynwE4JyZXVkr5VCef
 /CV7CPhcyqgMeyppfUH8e0IxJbLXnMnuDYR5yyoy/DUuORGevV93enVDisu1kgbWSSUd
 QRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5o+8zFBOWm3p7LnG75e3VpkH6O/dHPqDS3Ofte53ZGM=;
 b=QX/sFYCsDxfpjJqzzvE4doj2c8dId+sEy++knZ0C63TgX3NM/yEwt334sXUccuzUAm
 eUqpXtV6F4eNbV95M6rl5vq3CEsCmou3f45f/gVdX+wE7DXVoX3VKyaHwMQwO79TF01C
 W6413nYV3wU0re/JANnt5ffvC993d4SQyeW1H6xAjYSozgYtu3t1aLckQlMQ9ifc7EvT
 oHwrJMbuAYY8F1hL8fdkmGDKVdTFjtd+bpnGQVXNoyXXG0IS8C0wsh+x1dsLEDlxWcU2
 GJxbXPu/NH+/IX4ePeZB3FHQPGYQ2Vt5xVumaOB4Xi/DjkDWIZL66NNa7iN2wZY6x/45
 O+sg==
X-Gm-Message-State: AOAM530kZ2JG2gBiw7LfT9NRXhuqncRrZrsQeZ5WxRZTa437ct8/DRSP
 jRXoWTf7N4CUU6QYpLCaALB2h+5mAho=
X-Google-Smtp-Source: ABdhPJyHcxr5wezhzOujaWzLrh4Rv8l/9ijVgGmz/MujOMmh0Jj/P4w86JkwR9vfFE1RsfJIVpor2g==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr15933169wmj.90.1597681141078; 
 Mon, 17 Aug 2020 09:19:01 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:19:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 3/9] qtest: Directly use global address_space_memory when
 no CPU available
Date: Mon, 17 Aug 2020 18:18:47 +0200
Message-Id: <20200817161853.593247-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently all qtest MMIO access are dispatched via the first CPU
available. This limitation doesn't allow use to use the 'none'
machine to run tests. Unleash this limitation by selecting the
global address_space_memory when no CPU is available.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 softmmu/qtest.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/softmmu/qtest.c b/softmmu/qtest.c
index 81b5110783..7f018d2faf 100644
--- a/softmmu/qtest.c
+++ b/softmmu/qtest.c
@@ -19,6 +19,7 @@
 #include "chardev/char-fe.h"
 #include "exec/ioport.h"
 #include "exec/memory.h"
+#include "exec/address-spaces.h"
 #include "hw/irq.h"
 #include "sysemu/accel.h"
 #include "sysemu/cpus.h"
@@ -276,6 +277,13 @@ static void qtest_irq_handler(void *opaque, int n, int level)
 /* Default address space for MMIO accesses */
 static AddressSpace *qtest_mem_as(void)
 {
+    if (!first_cpu) {
+        /*
+         * The 'none' machine doesn't have any CPU,
+         * directly access the main address space.
+         */
+        return &address_space_memory;
+    }
     return first_cpu->as;
 }
 
-- 
2.26.2


