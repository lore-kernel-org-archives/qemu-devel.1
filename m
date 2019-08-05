Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E44DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF6920B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5uFMW+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF6920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huiMd-0005b9-Oi
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 15:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45854)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ramiro.polla@gmail.com>) id 1huiMI-0005BS-5w
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ramiro.polla@gmail.com>) id 1huiMH-0000Ch-AO
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:09:26 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:42170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ramiro.polla@gmail.com>)
 id 1huiMH-0000CP-78
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:09:25 -0400
Received: by mail-qk1-x742.google.com with SMTP id 201so60921270qkm.9
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Z/Dx1ta16cn55fWEn4uWVczq3jstV+9NQy0+kQziD18=;
 b=r5uFMW+Fx+6RwgUmjhxPp0gMPLmrqY0VVzQmsG1njosLmgvJn8w8BGvPj3ZKxHzCfH
 gG4E2ClG+3KXOsCmr4TGJRFroBMHuCy4KjPDQyPu0YKgiKpfFWNq3bhx3XYHf7TVI2On
 bajqhr17xR8FWIVpCeLoiKw8PQq0RUv8SMj+NwfnmIovkhjiJpuOaDxGm3LoygltknRM
 8K3AgAoUmHTlEgx2UjsdIJLj1DTu9IsaGsbq859eNVhJRoVZBOQi/XtxxWNQ/Mp0A2rX
 SqGaVA28fihzRKy6ubL0qY3Aq+5Zw2HY/zSEjAUi6swyPcbGAsaT6rRbdwU4aNg9/HUZ
 Ifcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Z/Dx1ta16cn55fWEn4uWVczq3jstV+9NQy0+kQziD18=;
 b=pOE08lfPF8Jn8VYUNA3eCUsFKkF501TwXeRV4yWEfnjzvUDARpUWlX+JbXDq8DwtHk
 AVtCvQyy8IGkuvl9DQZR4IirFy/pvN4xDnlytHQSbY02Ram6uNjAHZblUaxI1V1SdTIl
 K7l57eX4AhQATVK7l4VBLi4d09jNr+l3HRy7gEQz+ehhmVlO9oOH8U2bJMuscbnWj+gN
 JCLbDGi5gnrwOddk2UHP2Tdl+HT6tU7TE/7C2dBZ9mJQ/dIeRmQG+h9Hvn1e9cTakpiN
 SIvpY+U6prU8AekpY3n0cWRBSlxB0Xrlu3ztJW5gua1QFgFpj1TW5RlkA11+AzqQbcB8
 FbGg==
X-Gm-Message-State: APjAAAUjWG5bnnQAHszwkaD8YN5soRukS0xKihkOgEbE6KMFFP0fzb3C
 fjTNna6WafJeGonJ49sCJVGVOLIy
X-Google-Smtp-Source: APXvYqwwyRaLJY/5BfjXcAzbNlR6NfGv6vGF9/3gi4Y97IuFa5Bcoi7l7squFENkHnvUDp/cQmTMlw==
X-Received: by 2002:ae9:f303:: with SMTP id p3mr101635277qkg.320.1565032163924; 
 Mon, 05 Aug 2019 12:09:23 -0700 (PDT)
Received: from baleia.domain.name (201-54-102-232.sercomtel.com.br.
 [201.54.102.232])
 by smtp.gmail.com with ESMTPSA id x205sm38797774qka.56.2019.08.05.12.09.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 12:09:23 -0700 (PDT)
From: Ramiro Polla <ramiro.polla@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 21:09:01 +0200
Message-Id: <20190805190901.14072-1-ramiro.polla@gmail.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH] gdbstub: Fix handling of '!' packet with new
 infra
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
Cc: philmd@redhat.com, Ramiro Polla <ramiro.polla@gmail.com>,
 alex.bennee@linaro.org, arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the '!' packet is not handled by the new infrastructure,
gdb_handle_packet() would call run_cmd_parser() with a NULL cmd_parser
value, which would lead to an unsupported packet ("$#00") being sent,
which could confuse the gdb client.

This also has a side-effect of speeding up the initial connection with
gdb.

Fixes: 3e2c12615b52 ("gdbstub: Implement deatch (D pkt) with new infra")
Signed-off-by: Ramiro Polla <ramiro.polla@gmail.com>
---
 gdbstub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index b470aec8ea..d051344488 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2587,7 +2587,9 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     }
 
-    run_cmd_parser(s, line_buf, cmd_parser);
+    if (cmd_parser) {
+        run_cmd_parser(s, line_buf, cmd_parser);
+    }
 
     return RS_IDLE;
 }
-- 
2.11.0


