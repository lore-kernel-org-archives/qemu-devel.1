Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E970EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FA920836
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFN4WrbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FA920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3at-00026E-WD
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jo3Yh-0006iR-Q5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:15 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jo3Yd-00075G-QN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:15 -0400
Received: by mail-lj1-x244.google.com with SMTP id i3so2153207ljg.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v/NS9YgRb0NXpU+G0HRMzylRBMOp+QQCcs98Z10vCR8=;
 b=LFN4WrbTHl5vTrshZmaHadc0Qnsu1rytPPNixo8yLuTJ0WR1ijl63DEZgCnk/QNNdw
 PNshVgPMrZWHF8ifp2ujUEf8SAquKwpZaivE1wZG5cYOCaazc6zzB8dYllCXgZcXh1+P
 P0aJK6U6RkOCRgb7PFxiPgRd/Saa5QAzCMVKZkO78wSKlILRza8Zz/mlXrM1cleZFa7Z
 SmPKUtLNFREi/1/FtvRo5niRFRgQATsREoGR12/GXPMjvxOoS4Fo0UdOr4QstkyieCUT
 NZe+WPaEO2Cl3T0YwzhnLcm0TpokHeX9prQ87EfJGiP2uPKEPw96p9RKWGva0QQvi67p
 eyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v/NS9YgRb0NXpU+G0HRMzylRBMOp+QQCcs98Z10vCR8=;
 b=fEnpsfSKTS84b9j72RdL1TlIgIz0pIsD6J5YMC9v7Y4wY6SJMcCJhdJwkZdPQdPm12
 oiPai0vvkYCND3UFin8D3E3v7SG02Uq7rNCn/xKc+64e4coZS9YbnvHROkYmHAcD0Zft
 aT6XEeBjrAhA6zX68lRXaRY4NVbidsRHEgz+Cl5j8F38bite+v9OsoD5H/jDYUsyqNzN
 AmsRpzWzVo5eQj0uq/KzQurMJNQLCOIJU/fX2/VF0Og7HgUy8GtcgH1iViCv1EHtG574
 UPtfj1Em/evJGkZo947jVEr+zdiF78Id3m8RoxWZS6PYXBYBr7eSVOjps3b3/5nduVVc
 gu9g==
X-Gm-Message-State: AOAM531teGV6pYCa/XYmXajpDyPiqn0eYuElcB7J8EyPQK2ea2a+J44+
 llTgKtBd1fOdegGtoX6ksQn+fhGCmAg3VQ==
X-Google-Smtp-Source: ABdhPJzqr/1zZummamrFZO2v2riepgtsy9VSAyfbkr8HQKRT0QJRwTd6aw1WRXQYI5IM9+/6iow9tg==
X-Received: by 2002:a2e:3a17:: with SMTP id h23mr13128295lja.7.1592998029809; 
 Wed, 24 Jun 2020 04:27:09 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id d6sm1202635lja.77.2020.06.24.04.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 04:27:09 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] main-loop: change the handling of SIGWINCH
Date: Wed, 24 Jun 2020 13:26:35 +0200
Message-Id: <20200624112640.82673-2-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624112640.82673-1-noh4hss@gmail.com>
References: <20200624112640.82673-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=noh4hss@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Block SIGWINCH, so it is delivered only via signalfd.
Install a handler that uses NotifierList to tell
interested parties about SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 include/qemu/main-loop.h |  4 ++++
 ui/curses.c              | 11 ++++++-----
 util/main-loop.c         | 21 +++++++++++++++++++++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index a6d20b0719..f27dba1fd8 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -325,4 +325,8 @@ typedef struct MainLoopPoll {
 void main_loop_poll_add_notifier(Notifier *notify);
 void main_loop_poll_remove_notifier(Notifier *notify);
 
+#ifndef _WIN32
+void sigwinch_add_notifier(Notifier *n);
+#endif
+
 #endif
diff --git a/ui/curses.c b/ui/curses.c
index a59b23a9cf..e5895d506f 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -34,6 +34,7 @@
 #include <iconv.h>
 
 #include "qapi/error.h"
+#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -146,7 +147,7 @@ static void curses_resize(DisplayChangeListener *dcl,
 }
 
 #if !defined(_WIN32) && defined(SIGWINCH) && defined(KEY_RESIZE)
-static volatile sig_atomic_t got_sigwinch;
+static bool got_sigwinch;
 static void curses_winch_check(void)
 {
     struct winsize {
@@ -169,17 +170,17 @@ static void curses_winch_check(void)
     invalidate = 1;
 }
 
-static void curses_winch_handler(int signum)
+static void curses_winch_handler(Notifier *n, void *data)
 {
     got_sigwinch = true;
 }
 
 static void curses_winch_init(void)
 {
-    struct sigaction old, winch = {
-        .sa_handler  = curses_winch_handler,
+    static Notifier n = {
+        .notify = curses_winch_handler
     };
-    sigaction(SIGWINCH, &winch, &old);
+    sigwinch_add_notifier(&n);
 }
 #else
 static void curses_winch_check(void) {}
diff --git a/util/main-loop.c b/util/main-loop.c
index eda63fe4e0..0f5c8f3af1 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -90,6 +90,7 @@ static int qemu_signal_init(Error **errp)
     sigaddset(&set, SIGIO);
     sigaddset(&set, SIGALRM);
     sigaddset(&set, SIGBUS);
+    sigaddset(&set, SIGWINCH);
     /* SIGINT cannot be handled via signalfd, so that ^C can be used
      * to interrupt QEMU when it is being run under gdb.  SIGHUP and
      * SIGTERM are also handled asynchronously, even though it is not
@@ -111,6 +112,26 @@ static int qemu_signal_init(Error **errp)
     return 0;
 }
 
+static NotifierList sigwinch_notifiers =
+    NOTIFIER_LIST_INITIALIZER(sigwinch_notifiers);
+
+static void sigwinch_handler(int signum)
+{
+    notifier_list_notify(&sigwinch_notifiers, NULL);
+}
+
+void sigwinch_add_notifier(Notifier *n)
+{
+    if (notifier_list_empty(&sigwinch_notifiers)) {
+        struct sigaction action = {
+            .sa_handler = sigwinch_handler,
+        };
+        sigaction(SIGWINCH, &action, NULL);
+    }
+
+    notifier_list_add(&sigwinch_notifiers, n);
+}
+
 #else /* _WIN32 */
 
 static int qemu_signal_init(Error **errp)
-- 
2.27.0


