Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A901C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6194A206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6194A206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0Yy-00062s-IZ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ut-0007qf-Qn; Wed, 10 Jun 2020 09:10:27 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45539)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Us-0003gq-HS; Wed, 10 Jun 2020 09:10:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIdW9-1jg0D53fAz-00EahL; Wed, 10 Jun 2020 15:10:23 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 14/16] target/unicore32: Prefer qemu_semihosting_log_out()
 over curses
Date: Wed, 10 Jun 2020 15:10:09 +0200
Message-Id: <20200610131011.1941209-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nujbTLVeKt9LpZQbtZRxvpwXyfbarq8r5Bk1K42Ndq6YN0OacSQ
 RM56+kdZz5ysrbbSarasKGjY3EURD0bJo4Mz7hLzRHGQWNdyDGCLlx1Ocoa3hcs0OQ+B6n+
 GXaSjO4a31/Yz+hUunQI2HM/axggTOjV3spR0vhJMZhCon2SHBQMfWw3oXq6W0tCSYf99WZ
 maom1MPm1jNzid/hHLUxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:31TZV5x5tDg=:XrbprX7eZQeHeu4ew2uE2e
 NiKAqgGKP87b+jo8vIHXujuIXGkAEH6HZkkkdr/4VexALoV8uU9BA0T2eaIpTtQFg+6NbJeQQ
 ssE+kug7hMqlS/P85p+Y8SYoTKmCuWf7TDzS81qHp8AB2yUVRsLviXUhsQbI4ncGolyRM+iDx
 FESoMm7n9tw9ylLTCTNUi5cbZ7/HycYTENnVqgrwTdddoPIhaz79Y6jj0tiyNmpjMFUWtotAB
 Na8azqLuZLq15zd//b5471kN5k9PwXQSPAUI8oNnOE400tQZwKTc/nmp5HyyatrzwaUT/jCNd
 VwAYB4s2Jd3p/iE0goxtStM794sKKc0hj5APO0TH0ZnhqPObkaf9o5tCnJXXP8xkZo0gcr4k9
 8VTGpjWMGJSgHk/YBi3MHfQhXlnpqR46TCcdcXE5GNY3rb2KcM0L9tzv+GLQou7gbd7zHlIDu
 l/TU6pOjaLqZoFd+hjZ5kjI42h8Ityz0mg4hTTMzzZ0C6Mi5XEe0ZTAiKPad/7q5DKTdIhdgN
 pePwzIntf3XoDgCbQr+VDhJD3C20e1HkylQ4SYTqD2RArHbG8IwhkbUrjLupmgLKG9LO31pP5
 ocl4vMCoCSfNGpidenuZxRPwIiQc1e5R7GByKe8TfhFdHdjyIDPFt7D+D6OP+1G7yxmNHzSrP
 /0alf45SSeZbnNybSHQSkEsXQ5GN23f3O2+5L/4iEKHIOaIYSf43NQCUg+T6vMn343mTnLw8l
 fRG2ict5eA8JYdLNIsf4VpvS6CJNaeILE40A4nFyN6+Byv5lpkGQBmJfCXsdn3i6Bgnn/lG0z
 oB/fciBqwR38r9NsTCv58/6ulBoJKPqVRpHiRofMIg82ubJ06k=
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use the common API for semihosting logging.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200603123754.19059-4-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 default-configs/unicore32-softmmu.mak |  1 +
 target/unicore32/helper.c             | 57 +++------------------------
 2 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/default-configs/unicore32-softmmu.mak b/default-configs/unicore32-softmmu.mak
index 0bfce48c6da7..899288e3d715 100644
--- a/default-configs/unicore32-softmmu.mak
+++ b/default-configs/unicore32-softmmu.mak
@@ -3,3 +3,4 @@
 # Boards:
 #
 CONFIG_PUV3=y
+CONFIG_SEMIHOSTING=y
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 00371a7da660..54c26871feab 100644
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
-
-    if (!init) {
-        /* Assume 80 * 30 screen to minimize the implementation */
-        localwin = newwin(30, 80, 0, 0);
-        scrollok(localwin, TRUE);
-        init = TRUE;
-    }
+    const char c = regval;
 
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
-}
-#else
-#define putc_on_screen(c)               do { } while (0)
-#endif
-
-void helper_cp1_putc(target_ulong x)
-{
-    putc_on_screen((unsigned char)x);   /* Output to screen */
-    DPRINTF("%c", x);                   /* Output to stdout */
+    qemu_semihosting_log_out(&c, sizeof(c));
 }
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
 bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-- 
2.26.2


