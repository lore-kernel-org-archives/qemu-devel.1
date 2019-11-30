Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC32DC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25FD2075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cMp9bfAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25FD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayYg-0006lX-7P
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iayWl-0004zh-RU
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iayWk-0006b3-8S
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:54:55 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iayWj-0006Zm-VC
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:54:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id f129so17439228wmf.2
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0hbLzhNEhCkMRqzYtd3EEZ7EkJxE7ghYQ9NzTVxAhLY=;
 b=cMp9bfAX6rqIB9B9bf2a5nQ3fl7fPyda4CGBOZk4sL64+iVvB5aPrcwwCpm0s7B709
 SzTtRU/A9MBvqB0cQeyPrElKy/2MbV+sfE1fLE5642k3h8E3eEccdZeE30KOJJ7U0h8Y
 99ME+/AvgCp2IMQ6jtVUhcMdeJVaqVvG103jXmeHPnqB6T4CNX2fgGUHDsZiO562Ihif
 a1JNty+1bjBKidHVFsbby5RzNVVpxAebVh+Gr7U2dS77vE2XQKGnJJ2TGJQ62ZmuIivh
 igSCr4khpKw/7U+lahEkCJATRn79Tu4JmPzyVSrJ20dQ/wxa2o0LirT0ravvfIJZUBHR
 wFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0hbLzhNEhCkMRqzYtd3EEZ7EkJxE7ghYQ9NzTVxAhLY=;
 b=UEzyltEne2SNz1by58369Za0/1o0GjcvRfq+QNfM4B7OBm7jAOfeZYIR8KvgB4FH8x
 TkAcTBIZTUirdEy0Qlw2xyZ30pwDQP1ubXvgIU3hE+euc4PX5QT9jTc+7X8aZccKYkUr
 T5fA6wiha5CdDipA5D9A6BFwcrm1oBk3gFWfkFe+T/+m1Y8NrlS63gm+GUJQaWXf0t8P
 Utsji0QXx+p0d8pHn56Hy/GiMg2cW7rXvtVNS7SS3S/A4C4yxdaHF8E9pHswDmZR/1eP
 bo1Tbx93GmebW9NbE9qpHrnRXF/cVn7QQPzWFHYd2Gh6Pe4g9FqM+bs+u9c30UPYRS4+
 afVg==
X-Gm-Message-State: APjAAAWOd97HJ4WOdBrd8bdPxXhvGUnNjA14OW+R7gxlmRYxkceO7dUL
 H9+B/lS/5mXf/f0EcrZr3sQXlw==
X-Google-Smtp-Source: APXvYqzkkVGcX2XvNq87zBxharw0ePdo+ffW5gtFe5fWkNF175rym5oupTkPWkkJNKtRwRc7SYzGnw==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr18384833wmh.157.1575104092674; 
 Sat, 30 Nov 2019 00:54:52 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s19sm11896968wmc.4.2019.11.30.00.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2019 00:54:50 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41F7C1FF9D;
 Sat, 30 Nov 2019 08:46:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/14] tests/tcg: add a gdbstub testcase for SVE registers
Date: Sat, 30 Nov 2019 08:46:02 +0000
Message-Id: <20191130084602.10818-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191130084602.10818-1-alex.bennee@linaro.org>
References: <20191130084602.10818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't plumb this in yet as there are complications involved with
binutils and cross-architectiure debugging but it is one step closer.

Example:

  ./tests/guest-debug/run-test.py \
    --qemu ./aarch64-linux-user/qemu-aarch64 \
    --qargs "-cpu max" \
    --bin ./tests/tcg/aarch64-linux-user/hello \
    --test ~/lsrc/qemu.git/tests/tcg/aarch64/gdbstub/test-sve.py \
    --gdb /home/alex/src/tools/binutils-gdb.git/install/bin/gdb

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/.gitignore                      |  1 +
 tests/tcg/aarch64/gdbstub/test-sve.py | 75 +++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

diff --git a/tests/.gitignore b/tests/.gitignore
index f9c01708812..8cc428b58bb 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -10,6 +10,7 @@ qht-bench
 rcutorture
 test-*
 !test-*.c
+!test-*.py
 !docker/test-*
 test-qapi-commands.[ch]
 include/test-qapi-commands-sub-module.[ch]
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
new file mode 100644
index 00000000000..11bc96fc06d
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -0,0 +1,75 @@
+from __future__ import print_function
+#
+# Test the SVE registers are visable and changeable via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+
+MAGIC = 0xDEADBEEF
+
+failcount = 0
+
+def report(cond, msg):
+    "Report success/fail of test"
+    if cond:
+        print ("PASS: %s" % (msg))
+    else:
+        print ("FAIL: %s" % (msg))
+        global failcount
+        failcount += 1
+
+def run_test():
+    "Run through the tests one by one"
+
+    gdb.execute("info registers")
+    report(True, "info registers")
+
+    gdb.execute("info registers vector")
+    report(True, "info registers vector")
+
+    # Now all the zregs
+    frame = gdb.selected_frame()
+    for i in range(0, 32):
+        rname = "z%d" % (i)
+        zreg = frame.read_register(rname)
+        report(True, "Reading %s" % rname)
+        for j in range(0, 4):
+            cmd = "set $%s.q.u[%d] = 0x%x" % (rname, j, MAGIC)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+        for j in range(0, 4):
+            reg = "$%s.q.u[%d]" % (rname, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint128_t", "size of %s" % (reg))
+        for j in range(0, 8):
+            cmd = "set $%s.d.u[%d] = 0x%x" % (rname, j, MAGIC)
+            gdb.execute(cmd)
+            report(True, "%s" % cmd)
+        for j in range(0, 8):
+            reg = "$%s.d.u[%d]" % (rname, j)
+            v = gdb.parse_and_eval(reg)
+            report(str(v.type) == "uint64_t", "size of %s" % (reg))
+            report(int(v) == MAGIC, "%s is 0x%x" % (reg, MAGIC))
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+
+try:
+    # These are not very useful in scripts
+    gdb.execute("set pagination off")
+    gdb.execute("set confirm off")
+
+    # Run the actual tests
+    run_test()
+except:
+    print ("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount += 1
+
+print("All tests complete: %d failures" % failcount)
+
+# Finally kill the inferior and exit gdb with a count of failures
+gdb.execute("kill")
+exit(failcount)
-- 
2.20.1


