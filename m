Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6ACC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9461C21872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blgiVHdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9461C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXkb-0001Rr-Eq
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iUXgZ-0005vS-6H
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iUXgY-0002F3-2m
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:27 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iUXgX-0002E9-Tl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:02:26 -0500
Received: by mail-pg1-x542.google.com with SMTP id 15so12023136pgh.5
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UZ1i/qk2uiqDPVsu76k+F9DPkKMPM0uCow51hxWGol0=;
 b=blgiVHdUZkbRYrRhl3aD2DIHIc+2XDmBTBSvyCP2Hwwhc+kDWTgo9/HyLyKAlI1NkA
 FmsaDV+dakK0vmdo2V3r7LPFwXg6EviIey2jmjCdzg0egVWFEbcSsxJczFM/obzOX8YR
 GCWeyoJQr9OsPIo3NjI0bG70tllZGZY7wG8LyUAXMJwbXQAFuJ4V1xyhyGWGJrlZw6nG
 7nnYxuhwEsJf6oQyDrXqgLuQV9YU45eAglpeeYL3ep5LPBYmZdssdbOibjuF0xUi83d/
 AcP8nLteLiKebLHfZAa6PR7brO3VYbhpFnPBi9bQL9Jl0fOhEv4YmQvCCSwdrE5iuu08
 Bfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UZ1i/qk2uiqDPVsu76k+F9DPkKMPM0uCow51hxWGol0=;
 b=e97KYr6PSW707LASXnOkWve1KtdT4rwsr0slMG60IgwZ/lXXamAQkpqTqfvAONkDO7
 OLpCNjFCL59KQtHsV4LAFlje3ETq/eOBDbbs6KGWwYTaFTfjBlPgCA8pprPrBW1a4GqS
 e0k6+rPv16JM+UkeqH9NwV5NARdLByKgSAy9kbD/mIwLV8jKgOUP7a5W8vGJ1kqSRG1y
 m/egivc9i8GLWfkueSASre7v6to+NS9FDvPFbxEXAqi1AD+W90XCZvpdUMI9ce2udnaZ
 4i1wtRIMBwh7uFilpDDiZWXFqsQXIPzwkBkC0iPwg0J7DG5Yz+xXwTKWDnRq/Stp92xb
 qBLQ==
X-Gm-Message-State: APjAAAXHo3T2UFGXMcxpEiaB1fhoMbAAyKiWTws+/xxBg53i+BSr1GyX
 WOzzpX46yscw+dh/HdmOfBElFOy+Q+U=
X-Google-Smtp-Source: APXvYqw8118Mw2x7BBr2JrDePQzZeCCM6Pu4w3mzMHDr8PquS31TWDGVaOmDHlHXCn4BlMPoR5eWOA==
X-Received: by 2002:a17:90a:1b69:: with SMTP id
 q96mr7090424pjq.89.1573570944161; 
 Tue, 12 Nov 2019 07:02:24 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id a3sm8235511pfo.71.2019.11.12.07.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 07:02:23 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] Add a mutex to guarantee single writer to qemu_logfile
 handle.
Date: Tue, 12 Nov 2019 10:01:01 -0500
Message-Id: <20191112150105.2498-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112150105.2498-1-robert.foley@linaro.org>
References: <20191112150105.2498-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also added qemu_logfile_init() for initializing the logfile mutex.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
v1
    - changed qemu_logfile_init() to use __constructor__.
---
 util/log.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/util/log.c b/util/log.c
index 1ca13059ee..c25643dc99 100644
--- a/util/log.c
+++ b/util/log.c
@@ -24,8 +24,10 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "trace/control.h"
+#include "qemu/thread.h"
 
 static char *logfilename;
+static QemuMutex qemu_logfile_mutex;
 FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
@@ -49,6 +51,11 @@ int qemu_log(const char *fmt, ...)
     return ret;
 }
 
+static void __attribute__((__constructor__)) qemu_logfile_init(void)
+{
+    qemu_mutex_init(&qemu_logfile_mutex);
+}
+
 static bool log_uses_own_buffers;
 
 /* enable or disable low levels log */
@@ -58,6 +65,9 @@ void qemu_set_log(int log_flags)
 #ifdef CONFIG_TRACE_LOG
     qemu_loglevel |= LOG_TRACE;
 #endif
+
+    g_assert(qemu_logfile_mutex.initialized);
+    qemu_mutex_lock(&qemu_logfile_mutex);
     if (!qemu_logfile &&
         (is_daemonized() ? logfilename != NULL : qemu_loglevel)) {
         if (logfilename) {
@@ -93,6 +103,7 @@ void qemu_set_log(int log_flags)
             log_append = 1;
         }
     }
+    qemu_mutex_unlock(&qemu_logfile_mutex);
     if (qemu_logfile &&
         (is_daemonized() ? logfilename == NULL : !qemu_loglevel)) {
         qemu_log_close();
@@ -230,12 +241,15 @@ void qemu_log_flush(void)
 /* Close the log file */
 void qemu_log_close(void)
 {
+    g_assert(qemu_logfile_mutex.initialized);
+    qemu_mutex_lock(&qemu_logfile_mutex);
     if (qemu_logfile) {
         if (qemu_logfile != stderr) {
             fclose(qemu_logfile);
         }
         qemu_logfile = NULL;
     }
+    qemu_mutex_unlock(&qemu_logfile_mutex);
 }
 
 const QEMULogItem qemu_log_items[] = {
-- 
2.17.1


