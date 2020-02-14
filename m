Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD85C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EAF2082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIWlvMIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EAF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2P9m-0002sw-9G
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2P9D-0002US-3E
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2P9B-000183-Oh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:47:58 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2P9B-00016l-Fw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:47:57 -0500
Received: by mail-wm1-x341.google.com with SMTP id a9so8824338wmj.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jrHsrciOVEWIlCjTCOW49db7lwtH9oDQHM2KLgoGjN4=;
 b=XIWlvMIPT2Y4/0Bzh8W1jvwFF58EPC6OuI9hJws/HNqB+STbsQeJoL72Tlz5ls8Ykv
 uubMWXep6j6Dn7j739s1k7TXTzflUidT+MZnTcSu3wTcYtHPnF5iCARhJJuGuqeJFLbT
 ZOVambFmqWsQndbvYPtbuG9QC3gWdSQYOE5ruEpdTKxSlecc2EujHEDr+w2s43KAN4yb
 W57D1ZyIUeWbiv+1OToTCyXdddjynQWPxqWwXc8Qq/+411b8Wz9Ja6mmEFQVBDNyJCNQ
 NQaWN4jYZE1niQaLGixJUj39C4fp9+14VkGvUJZA/5o02RWEbFo8/B8sF5N4nDXGRcwb
 xIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jrHsrciOVEWIlCjTCOW49db7lwtH9oDQHM2KLgoGjN4=;
 b=D3FyDLSsva9PNCkrr9nOIc+JHB+nXcfdNhnaMV1Ux1LvsWeCZjXhZSYPch7dRP07JX
 De2Rr46N4rzJj9g9ZEaXL5Wc6TJcI1dpuiImD2Nf610bMT+Zw/l08AtyJy6q8W9+XR1Y
 xce/HLrM/y4bE06sBPck4HZThqFd34hbdJlXoStCt/oCeCdmaGj21zkz2OQO+P+QCKKL
 CvQONnUR2D89dedQJlH+SZXwPAYL6cjy2IQjjxL/8JRV5F/icWUUgM2S1QouTkWujqF5
 Cgf5YF8v35exSxTAMll94JtxxFgfmh0qPdluXiPu088qQXhSaQJ76LDaHAdEtBmZfDKP
 TK4g==
X-Gm-Message-State: APjAAAVRSX2prE8FfMrB1hkX61TLKEBB47/fKxFRSGPDYm9hBxKYwcYA
 EjYEYENDksN+d2X94YI7YltdZOuAMMs=
X-Google-Smtp-Source: APXvYqz+IHrXIY0ADBtLlorugH6n893HdwupKUHny610CoLL6p9VmauhzGpLV4YBD+4CGH+y3xolBA==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr798000wmg.139.1581641275930;
 Thu, 13 Feb 2020 16:47:55 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y131sm5185415wmc.13.2020.02.13.16.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 16:47:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH] hw/net/i82596: Correct command bitmask (CID 1419392)
Date: Fri, 14 Feb 2020 01:47:53 +0100
Message-Id: <20200214004753.15736-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command is 32-bit, but we are loading the 16 upper bits with
the 'get_uint16(s->scb + 2)' call.

Once shifted by 16, the command bits match the status bits:

- Command
  Bit 31 ACK-CX   Acknowledges that the CU completed an Action Command.
  Bit 30 ACK-FR   Acknowledges that the RU received a frame.
  Bit 29 ACK-CNA  Acknowledges that the Command Unit became not active.
  Bit 28 ACK-RNR  Acknowledges that the Receive Unit became not ready.

- Status
  Bit 15 CX       The CU finished executing a command with its I(interrupt) bit set.
  Bit 14 FR       The RU finished receiving a frame.
  Bit 13 CNA      The Command Unit left the Active state.
  Bit 12 RNR      The Receive Unit left the Ready state.

Add the SCB_COMMAND_ACK_MASK definition to simplify the code.

This fixes Coverity 1419392 (CONSTANT_EXPRESSION_RESULT):

  /hw/net/i82596.c: 352 in examine_scb()
  346         cuc = (command >> 8) & 0x7;
  347         ruc = (command >> 4) & 0x7;
  348         DBG(printf("MAIN COMMAND %04x  cuc %02x ruc %02x\n", command, cuc, ruc));
  349         /* and clear the scb command word */
  350         set_uint16(s->scb + 2, 0);
  351
  >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
  >>>     "command & (2147483648UL /* 1UL << 31 */)" is always 0 regardless of the values of its operands. This occurs as the logical operand of "if".
  352         if (command & BIT(31))      /* ACK-CX */
  353             s->scb_status &= ~SCB_STATUS_CX;
  >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
  >>>     "command & (1073741824UL /* 1UL << 30 */)" is always 0 regardless of the values of its operands. This occurs as the logical operand of "if".
  354         if (command & BIT(30))      /*ACK-FR */
  355             s->scb_status &= ~SCB_STATUS_FR;
  >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
  >>>     "command & (536870912UL /* 1UL << 29 */)" is always 0 regardless of the values of its operands. This occurs as the logical operand of "if".
  356         if (command & BIT(29))      /*ACK-CNA */
  357             s->scb_status &= ~SCB_STATUS_CNA;
  >>>     CID 1419392:    (CONSTANT_EXPRESSION_RESULT)
  >>>     "command & (268435456UL /* 1UL << 28 */)" is always 0 regardless of the values of its operands. This occurs as the logical operand of "if".
  358         if (command & BIT(28))      /*ACK-RNR */
  359             s->scb_status &= ~SCB_STATUS_RNR;

Fixes: Covertiy CID 1419392 (commit 376b851909)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/i82596.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 3a0e1ec4c0..b7c2458a96 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -43,6 +43,9 @@
 #define SCB_STATUS_CNA  0x2000 /* CU left active state */
 #define SCB_STATUS_RNR  0x1000 /* RU left active state */
 
+#define SCB_COMMAND_ACK_MASK \
+        (SCB_STATUS_CX | SCB_STATUS_FR | SCB_STATUS_CNA | SCB_STATUS_RNR)
+
 #define CU_IDLE         0
 #define CU_SUSPENDED    1
 #define CU_ACTIVE       2
@@ -349,14 +352,7 @@ static void examine_scb(I82596State *s)
     /* and clear the scb command word */
     set_uint16(s->scb + 2, 0);
 
-    if (command & BIT(31))      /* ACK-CX */
-        s->scb_status &= ~SCB_STATUS_CX;
-    if (command & BIT(30))      /*ACK-FR */
-        s->scb_status &= ~SCB_STATUS_FR;
-    if (command & BIT(29))      /*ACK-CNA */
-        s->scb_status &= ~SCB_STATUS_CNA;
-    if (command & BIT(28))      /*ACK-RNR */
-        s->scb_status &= ~SCB_STATUS_RNR;
+    s->scb_status &= ~(command & SCB_COMMAND_ACK_MASK);
 
     switch (cuc) {
     case 0:     /* no change */
-- 
2.21.1


