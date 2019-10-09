Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48303C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135B720B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Bg7qinyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135B720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iII7g-0008TK-Jb
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msmarduch@digitalocean.com>) id 1iIF5v-0001mG-Hq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msmarduch@digitalocean.com>) id 1iIF5u-0001fm-65
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:47 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:46056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msmarduch@digitalocean.com>)
 id 1iIF5u-0001fT-0J
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:46 -0400
Received: by mail-oi1-x234.google.com with SMTP id o205so2306669oib.12
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=J4YN86Aqb6P3nZBxZGbSB3JP/PFIgkq5SLiK3nAUEks=;
 b=Bg7qinyHGcIxIzh43Gh4AvNI1I8OAA9q3iGmWryMw9LKOHzcx8iehStOSOe90nGVrN
 s1BEiUMGVZA7uIyAn8LBBOGqTWObdreWCnaDf0kOYzpR9S4868LolXH3Sm8GRULs4Xyv
 Q2jb/nIgZNtC3U92+IbdLeQ0qUj7mGVIodjCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=J4YN86Aqb6P3nZBxZGbSB3JP/PFIgkq5SLiK3nAUEks=;
 b=AbwUGWfBJnv2wAlOR5JfEwYmRYVY8fCYanI7Nj7geD7vt2dDgoVF9kNAs6scbdzFjB
 ZFSbWQbccB0EnibNeK+LOTPq0g1n6LnrgzuxcGGJ1jA4jzJQeYhycbn1Bw1ocjkm0pyK
 x3JvUxp0OYAnU+IUaKlKYnzRjl7xYyY8kVt30mhKRKJ7tOE8Gf9vhx6JsR3p4pPwP/4x
 29f5ci4Ox3XolSOgpnBg5QS4xN7pxbSCOvcm05P+dEjmSqihTfPau7aeWc/kOdpUN7ru
 aJCRA/z6BNDkf4XVARhol9VmnEE/5P4vWJ16x0WSjM4t0ailJd23OCBRlqZLagFkq8wr
 l6EA==
X-Gm-Message-State: APjAAAW7bIc+cZKteiVGrQquz5p0/+4MJ09CMLBcFm8TxcBV3TKuu3/8
 pth1/yyBIKIFsr7kRGOqnbjLBA==
X-Google-Smtp-Source: APXvYqxpgL1jB9NOpbCUjK6IIrbvQI84iUiBkIeqIv5KGQqsTORaTjnKwLcKMnp6ml9ZTTs/VvYnAQ==
X-Received: by 2002:aca:90f:: with SMTP id 15mr3195748oij.92.1570639544552;
 Wed, 09 Oct 2019 09:45:44 -0700 (PDT)
Received: from msmarduch-ThinkPad-T460s.attlocal.net
 ([2600:1700:4a30:84c0:8d5e:794e:8a2e:ee89])
 by smtp.gmail.com with ESMTPSA id q1sm789818otn.8.2019.10.09.09.45.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 09:45:44 -0700 (PDT)
From: Mario Smarduch <msmarduch@digitalocean.com>
To: philmd@redhat.com, mtosatti@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, rth@twiddle.net,
 ehabkost@redhat.com, Mario Smarduch <msmarduch@digitalocean.com>
Subject: [PATCHv2 1/2] util/qemu-error: add guest name helper with -msg options
Date: Wed,  9 Oct 2019 09:44:58 -0700
Message-Id: <20191009164459.8209-2-msmarduch@digitalocean.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20191009164459.8209-1-msmarduch@digitalocean.com>
References: <20191009164459.8209-1-msmarduch@digitalocean.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds an option to enable/disable printing lead guest name in
logging messages.

A '-msg name=on|off' allows to turn on, off guest name logging.

If guest name is not set disabling this makes sense.

Verified with all combinations of 
  '-msg timestamp=yes|no,name=yes|no.

Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
---
 include/qemu/error-report.h |  1 +
 qemu-options.hx             | 10 ++++++----
 util/qemu-error.c           | 31 +++++++++++++++++++++++++++++++
 vl.c                        |  5 +++++
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 00d069b..9b44a06 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -74,5 +74,6 @@ void error_init(const char *argv0);
 
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
+extern bool enable_guestname_msg;
 
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6..6066001 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4164,14 +4164,16 @@ HXCOMM Deprecated by -accel tcg
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
-    "-msg timestamp[=on|off]\n"
+    "-msg [timestamp=on|off][name=on|off]\n"
     "                change the format of messages\n"
-    "                on|off controls leading timestamps (default:on)\n",
+    "                timestamp=on|off controls leading timestamps (default: on)\n"
+    "                name=on|off controls leading guest name (default: off)\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -msg timestamp[=on|off]
+@item -msg timestamp=on|off
+@item -msg name=on|off
 @findex -msg
-prepend a timestamp to each log message.(default:on)
+Prepend additional information to each log message
 ETEXI
 
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
diff --git a/util/qemu-error.c b/util/qemu-error.c
index f373f3b..8ece7b2 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -11,6 +11,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 
@@ -192,6 +194,8 @@ static void print_loc(void)
 }
 
 bool enable_timestamp_msg;
+bool enable_guestname_msg;
+
 /*
  * Print a message to current monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
@@ -228,6 +232,27 @@ static void vreport(report_type type, const char *fmt, va_list ap)
     error_printf("\n");
 }
 
+static const char *error_get_guestname(void)
+{
+    QemuOpts *opts = qemu_opts_find(qemu_find_opts("name"), NULL);
+    return qemu_opt_get(opts, "guest");
+}
+
+/*
+ * Also print the guest name, handy if we log to a server.
+ */
+static void error_print_guestname(void)
+{
+    const char *name;
+
+    if (enable_guestname_msg) {
+        name = error_get_guestname();
+        if (name && !cur_mon) {
+            error_printf("Guest [%s] ", name);
+        }
+    }
+}
+
 /*
  * Print an error message to current monitor if we have one, else to stderr.
  * Format arguments like vsprintf().  The resulting message should be
@@ -237,6 +262,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
  */
 void error_vreport(const char *fmt, va_list ap)
 {
+    error_print_guestname();
     vreport(REPORT_TYPE_ERROR, fmt, ap);
 }
 
@@ -248,6 +274,7 @@ void error_vreport(const char *fmt, va_list ap)
  */
 void warn_vreport(const char *fmt, va_list ap)
 {
+    error_print_guestname();
     vreport(REPORT_TYPE_WARNING, fmt, ap);
 }
 
@@ -274,6 +301,7 @@ void error_report(const char *fmt, ...)
 {
     va_list ap;
 
+    error_print_guestname();
     va_start(ap, fmt);
     vreport(REPORT_TYPE_ERROR, fmt, ap);
     va_end(ap);
@@ -289,6 +317,7 @@ void warn_report(const char *fmt, ...)
 {
     va_list ap;
 
+    error_print_guestname();
     va_start(ap, fmt);
     vreport(REPORT_TYPE_WARNING, fmt, ap);
     va_end(ap);
@@ -324,6 +353,7 @@ bool error_report_once_cond(bool *printed, const char *fmt, ...)
         return false;
     }
     *printed = true;
+    error_print_guestname();
     va_start(ap, fmt);
     vreport(REPORT_TYPE_ERROR, fmt, ap);
     va_end(ap);
@@ -344,6 +374,7 @@ bool warn_report_once_cond(bool *printed, const char *fmt, ...)
         return false;
     }
     *printed = true;
+    error_print_guestname();
     va_start(ap, fmt);
     vreport(REPORT_TYPE_WARNING, fmt, ap);
     va_end(ap);
diff --git a/vl.c b/vl.c
index 002bf49..024bdc6 100644
--- a/vl.c
+++ b/vl.c
@@ -417,6 +417,10 @@ static QemuOptsList qemu_msg_opts = {
             .name = "timestamp",
             .type = QEMU_OPT_BOOL,
         },
+        {
+            .name = "name",
+            .type = QEMU_OPT_BOOL,
+        },
         { /* end of list */ }
     },
 };
@@ -1263,6 +1267,7 @@ static void realtime_init(void)
 static void configure_msg(QemuOpts *opts)
 {
     enable_timestamp_msg = qemu_opt_get_bool(opts, "timestamp", true);
+    enable_guestname_msg = qemu_opt_get_bool(opts, "name", false);
 }
 
 
-- 
2.9.3


