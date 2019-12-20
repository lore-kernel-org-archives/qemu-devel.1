Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C239C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388E724679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4H6UdB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388E724679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHEE-0004Va-9A
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1s-00051x-JR
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:05:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiH1o-0008Px-Iw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:05:11 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiH1o-0008Mv-0o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:05:08 -0500
Received: by mail-wr1-x431.google.com with SMTP id c9so9181934wrw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0hbLzhNEhCkMRqzYtd3EEZ7EkJxE7ghYQ9NzTVxAhLY=;
 b=A4H6UdB2S/92fnWU47nEN9m9Bh7bPxF+RJJFgzvQ4fOYUptOB8ZpYYtR+DmKDQm47l
 iCMacMxkIhA3qGQiS0J154sHigRiXYwQSI3IgjloX8DCq0ZxnL6Dquh6j2t+t7/vSlkC
 siLoqhVr1KUINloRsgyCwzzhkVq9ldeHXO/J86PFms6wsBcQ9Zj38QUTCkGgR3u64S4i
 vN7c+AG6ET+xD6ChpMJB2xhJQxHEs8A7xEfin/iNCt1ulKetW1KwoWAJWhwht9z++vAh
 wxReIq7I7KnF24EvL/S8/46wHa+pff5kumdlN1Y4b1yG8pTl4H8lEkZMfDqjzsz4bkAR
 hcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0hbLzhNEhCkMRqzYtd3EEZ7EkJxE7ghYQ9NzTVxAhLY=;
 b=GxC8bHC++ShKF+KerpLBQcRQvmNkkrS7AIRaorNpqXB+e8kxE8DQZk7FWerE/k/LqP
 3jGTgxefdUi/LjAMlmF4JzdDeGgLvQPlsyMP+wwGh/lhtVqXrfsXjNamibpe5dMquViq
 d8t9o/D6v94kCAkOqghqzqT2C1Vo9G2qGkbcvElMVu9LYaaq90jyNOcbuYXXupoM3b16
 WV/HUAIKtJwV3Bdf4YVCxSPyuIpoxsoEFYJQTH4NvTk1gdzVFS8fxE6Slm9h/bQIevLY
 dDiwme/Njknbu/HQsbv5Vx9EeHV7qVRbTY8QpL2SaCt7ZpOt8CQY4B+pBj+RIee2K7cR
 og5g==
X-Gm-Message-State: APjAAAWug4kwx70D1ZD5ltvEuH0a7JDyKJ8DmYUC8gcX57cx8s8n6LwG
 qZCoAd1s3lCto2gbZJRks1y2Cg==
X-Google-Smtp-Source: APXvYqxGJ1T4j1mvQjmf99AqecCv0QI1ym7PpPewJNJazc81ar+W1Ju9bk3vCVDz9g2E7iU1Zb37QQ==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr15576168wrs.237.1576843505701; 
 Fri, 20 Dec 2019 04:05:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s128sm9713941wme.39.2019.12.20.04.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:04:53 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF5D61FFA5;
 Fri, 20 Dec 2019 12:04:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/21] tests/tcg/aarch64: add a gdbstub testcase for SVE
 registers
Date: Fri, 20 Dec 2019 12:04:34 +0000
Message-Id: <20191220120438.16114-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 luis.machado@linaro.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 alan.hayward@arm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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


