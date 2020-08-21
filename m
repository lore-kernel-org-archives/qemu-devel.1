Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45217C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1168420738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rb3jWaYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1168420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B3i-0007Ya-Bt
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArF-0001Yz-9t; Fri, 21 Aug 2020 13:29:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArD-0001DC-MZ; Fri, 21 Aug 2020 13:29:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id u18so2637013wmc.3;
 Fri, 21 Aug 2020 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t2AXewhSqJh0kBZThS6xJGNW5Vas7WuOoZOyr5gsCOA=;
 b=rb3jWaYbqU5x2TEg+8pRIeXF7iFkU/pWYrnxC1Rqn+Y9K+t0VJiNjO+wg2M+bm9jri
 i+O1f9ANL/aiNVv+4LXoKl6M/IkDwaXoD0lC6OwFuKpVpxCae7t3337DiX7KHj5j3j3Y
 uQJcAS+K6t/cW6OhfCiprUR18+9zxxKMkpk1R0uIQ+xGWERSge3nKGf9vQAuqfP8s4iV
 1IyWYLzCXn8M8pk+kC+wXchjQcAYRc7+IRYEs24rcr1lQ7DQoLiBR7jApxWifx1B6iqR
 kCUYeN4OrrBald7pj90JXCGHObN86BIP39G+27cgAFk78W8ptCcnqzQAD3ILIgz+tV3z
 D0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=t2AXewhSqJh0kBZThS6xJGNW5Vas7WuOoZOyr5gsCOA=;
 b=jxN3NOnNOYJP+xT3MehoggxwmamOYrd+J0YISrqdDrxZSalf/MeEvxY3BjcoAAVKMF
 hbGNOur2v52mY0P4QRJWGazJbxSJios9JsbEYaez/xFZ9QImJT/vIskI6hcJedvpti1Z
 jyybzMH5vQOX7hr7HcpAAyYsduJPcjgSNjT22k3sIne7vVTnmiR9FReQwlyb1327jikF
 EMV9oJjInhdoMlHj9Zn0dxRacE8MAtAePAbN0BSMTw4MHDXVz3oeBFVO8uQk0aLyn/+I
 fnwCe8s8FoVhLQYQfMchxEw8hUE0C1yvtEGsnxuWRBydiO7uUVzpupgPXpBof3ibI15M
 LSjg==
X-Gm-Message-State: AOAM530J5ZHzi2QIUFkuuODRcpzJEd+geQMKlBOAFdhRDEcGH1VMlCrb
 3VLYOXcdbAUjdZUftPxumOC8rd8JCrM=
X-Google-Smtp-Source: ABdhPJwk5l/PemqQCGVeDNc80kLtrrN3zqvVc9OVi7Fzv56o9/FDWT4GkyVlWwVHyo5u0KNcDMUlaQ==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4348800wmc.149.1598030977295; 
 Fri, 21 Aug 2020 10:29:37 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/23] hw/sd/pl181: Replace disabled fprintf()s by trace events
Date: Fri, 21 Aug 2020 19:29:05 +0200
Message-Id: <20200821172916.1260954-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x336.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert disabled DPRINTF() to trace events and remove ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200705204630.4133-9-f4bug@amsat.org>
---
 hw/sd/pl181.c      | 26 +++++++++-----------------
 hw/sd/trace-events | 10 ++++++++++
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index f69488ebac3..574500ce600 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -17,15 +17,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-
-//#define DEBUG_PL181 1
-
-#ifdef DEBUG_PL181
-#define DPRINTF(fmt, ...) \
-do { printf("pl181: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#include "trace.h"
 
 #define PL181_FIFO_LEN 16
 
@@ -158,7 +150,7 @@ static void pl181_fifo_push(PL181State *s, uint32_t value)
     n = (s->fifo_pos + s->fifo_len) & (PL181_FIFO_LEN - 1);
     s->fifo_len++;
     s->fifo[n] = value;
-    DPRINTF("FIFO push %08x\n", (int)value);
+    trace_pl181_fifo_push(value);
 }
 
 static uint32_t pl181_fifo_pop(PL181State *s)
@@ -172,7 +164,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
     value = s->fifo[s->fifo_pos];
     s->fifo_len--;
     s->fifo_pos = (s->fifo_pos + 1) & (PL181_FIFO_LEN - 1);
-    DPRINTF("FIFO pop %08x\n", (int)value);
+    trace_pl181_fifo_pop(value);
     return value;
 }
 
@@ -184,7 +176,7 @@ static void pl181_do_command(PL181State *s)
 
     request.cmd = s->cmd & PL181_CMD_INDEX;
     request.arg = s->cmdarg;
-    DPRINTF("Command %d %08x\n", request.cmd, request.arg);
+    trace_pl181_command_send(request.cmd, request.arg);
     rlen = sdbus_do_command(&s->sdbus, &request, response);
     if (rlen < 0)
         goto error;
@@ -201,16 +193,16 @@ static void pl181_do_command(PL181State *s)
             s->response[2] = ldl_be_p(&response[8]);
             s->response[3] = ldl_be_p(&response[12]) & ~1;
         }
-        DPRINTF("Response received\n");
+        trace_pl181_command_response_pending();
         s->status |= PL181_STATUS_CMDRESPEND;
     } else {
-        DPRINTF("Command sent\n");
+        trace_pl181_command_sent();
         s->status |= PL181_STATUS_CMDSENT;
     }
     return;
 
 error:
-    DPRINTF("Timeout\n");
+    trace_pl181_command_timeout();
     s->status |= PL181_STATUS_CMDTIMEOUT;
 }
 
@@ -262,11 +254,11 @@ static void pl181_fifo_run(PL181State *s)
         s->status |= PL181_STATUS_DATAEND;
         /* HACK: */
         s->status |= PL181_STATUS_DATABLOCKEND;
-        DPRINTF("Transfer Complete\n");
+        trace_pl181_fifo_transfer_complete();
     }
     if (s->datacnt == 0 && s->fifo_len == 0) {
         s->datactrl &= ~PL181_DATA_ENABLE;
-        DPRINTF("Data engine idle\n");
+        trace_pl181_data_engine_idle();
     } else {
         /* Update FIFO bits.  */
         bits = PL181_STATUS_TXACTIVE | PL181_STATUS_RXACTIVE;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 5f09d32eb2c..a87d7355fb8 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -62,3 +62,13 @@ milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value
 # pxa2xx_mmci.c
 pxa2xx_mmci_read(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
 pxa2xx_mmci_write(uint8_t size, uint32_t addr, uint32_t value) "size %d addr 0x%02x value 0x%08x"
+
+# pl181.c
+pl181_command_send(uint8_t cmd, uint32_t arg) "sending CMD%02d arg 0x%08" PRIx32
+pl181_command_sent(void) "command sent"
+pl181_command_response_pending(void) "response received"
+pl181_command_timeout(void) "command timeouted"
+pl181_fifo_push(uint32_t data) "FIFO push 0x%08" PRIx32
+pl181_fifo_pop(uint32_t data) "FIFO pop 0x%08" PRIx32
+pl181_fifo_transfer_complete(void) "FIFO transfer complete"
+pl181_data_engine_idle(void) "data engine idle"
-- 
2.26.2


