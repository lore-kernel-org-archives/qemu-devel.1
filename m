Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD96BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F7820678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckfr5Lgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F7820678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSh8-0000mp-Tk
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSek-0005en-Gg; Wed, 03 Jun 2020 08:38:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSej-0006Oj-KN; Wed, 03 Jun 2020 08:38:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id j10so2180598wrw.8;
 Wed, 03 Jun 2020 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wVQrGfjTa1sxgMd1d+bkjIGbptx0TWESvdgxR7VrhSM=;
 b=ckfr5LgoZfi0o7wuYngz3NrYLphDXGCvOGG9f6Qa+RGXCDUTLi7SuDfE+loKFqkGqr
 cptkc061vEqz5Xyc8UFrh8DSrOtW+zV+Ejp+wmVTqvOBD6+2XqV/pKd7EeFsl7NAcJ1e
 5YIkCM6Q6eQ/5p5sQbkP3mmBox7WjbBj+9ZwU41+vC1pqTW6y2DDu9cAjaPnXH7U4eP+
 DAiJWeuobOAKD+o/KwQXEhBIsNcnuJmMHhhuNOzlVdUsPpNIwMsPI4HghPlgzQfY9JzG
 iy3oCS7RbdYucjCvb3U2hyiNCdZHSPNCYwpm70tiSmAUZCcd9rOg1/7y7pAEqWECBJoS
 lr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wVQrGfjTa1sxgMd1d+bkjIGbptx0TWESvdgxR7VrhSM=;
 b=XzmK1ogf8Eic5iKvUn5+rIS0TlCHHSAiOn82aLnmU9it6zBs4yBRIYWLcCQsiVbwxi
 PcNBrHJapSNCmA2GkOFqDD2AcOAdhzbOu7UuRBq6lWLsKRuP6EBCojo6TUXrV4Jn9u/x
 Hbq1x4nEcgjqVY62z3BDG2iDgrWQ/FwEQ09xex/XvvQvEutaK+4ytHCHaMwZIOuNO+4p
 2USBdJI3UnA0jnaS3O7+FPyGL6YCw7GGWot4c+le6LPBqg6FfMyMy2EjCTf8ws7e8Goh
 CjubviOOYsaxHC9OYM1bH1Araff+ozQIkQVD+tTcyspP/E45TX8yvgVqYaqMPKh3uo43
 bfEA==
X-Gm-Message-State: AOAM533i8rvGW67a++JiWRphX890nW36hBoDgLPFlHjNbxLrtWC/mWdS
 8++PvTM3HyvElKC1QKui2FeeZOCW
X-Google-Smtp-Source: ABdhPJzHGMjbe6t67I38yLD4Lk2j62mJjqkuhcOmj2OKn0A2RfaKPt0Kx/dUAz2+1lYMR+epF/XWRQ==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr32001218wrm.142.1591187882758; 
 Wed, 03 Jun 2020 05:38:02 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r5sm3370983wrq.0.2020.06.03.05.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 05:38:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/unicore32: Prefer qemu_semihosting_log_out() over
 curses
Date: Wed,  3 Jun 2020 14:37:54 +0200
Message-Id: <20200603123754.19059-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200603123754.19059-1-f4bug@amsat.org>
References: <20200603123754.19059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the common API for semihosting logging.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/unicore32-softmmu.mak |  1 +
 target/unicore32/helper.c             | 57 +++------------------------
 2 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/unicore32-softmmu.mak
index 0bfce48c6d..899288e3d7 100644
--- a/default-configs/unicore32-softmmu.mak
+++ b/default-configs/unicore32-softmmu.mak
@@ -3,3 +3,4 @@
 # Boards:
 #
 CONFIG_PUV3=y
+CONFIG_SEMIHOSTING=y
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 00371a7da6..54c26871fe 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -14,9 +14,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#ifndef CONFIG_USER_ONLY
-#include "ui/console.h"
-#endif
+#include "hw/semihosting/console.h"
 
 #undef DEBUG_UC32
 
@@ -161,58 +159,13 @@ uint32_t helper_cp0_get(CPUUniCore32State *env, uint32_t creg, uint32_t cop)
     return 0;
 }
 
-#ifdef CONFIG_CURSES
-
-/* KEY_EVENT is defined in wincon.h and in curses.h. Avoid redefinition. */
-#undef KEY_EVENT
-#include <curses.h>
-#undef KEY_EVENT
-
-/*
- * FIXME:
- *     1. curses windows will be blank when switching back
- *     2. backspace is not handled yet
- */
-static void putc_on_screen(unsigned char ch)
+void helper_cp1_putc(target_ulong regval)
 {
-    static WINDOW *localwin;
-    static int init;
+    const char c = regval;
 
-    if (!init) {
-        /* Assume 80 * 30 screen to minimize the implementation */
-        localwin = newwin(30, 80, 0, 0);
-        scrollok(localwin, TRUE);
-        init = TRUE;
-    }
-
-    if (isprint(ch)) {
-        wprintw(localwin, "%c", ch);
-    } else {
-        switch (ch) {
-        case '\n':
-            wprintw(localwin, "%c", ch);
-            break;
-        case '\r':
-            /* If '\r' is put before '\n', the curses window will destroy the
-             * last print line. And meanwhile, '\n' implifies '\r' inside. */
-            break;
-        default: /* Not handled, so just print it hex code */
-            wprintw(localwin, "-- 0x%x --", ch);
-        }
-    }
-
-    wrefresh(localwin);
+    qemu_semihosting_log_out(&c, sizeof(c));
 }
-#else
-#define putc_on_screen(c)               do { } while (0)
-#endif
-
-void helper_cp1_putc(target_ulong x)
-{
-    putc_on_screen((unsigned char)x);   /* Output to screen */
-    DPRINTF("%c", x);                   /* Output to stdout */
-}
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
 bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-- 
2.21.3


