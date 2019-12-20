Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2832C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7F7206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lp3dcu10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7F7206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHUh-0000fn-NS
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAt-0000g6-8z
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAr-0001LX-Pt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiHAr-0001Gz-Dq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:29 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so9020885wma.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r6DZWz56Ou8zN9swvxhZLHdPuxthEvVWZNmtroVIhWQ=;
 b=Lp3dcu100TH5P0m6J/X71PizRAWRciZTSkHXfRhcpa3fQm7p8bAwdiBzCj32BLhj9N
 f8aj7+iV7C15MrAlH+gQxtnaOjMIDeHZxPlJyaWzYDjUgNUWfZgL+Gr0BFrwUEkAID9p
 G5ogaOSgyt07L9nCHNGrB3vsOM2aCB/r7AghorMR8EGvWgCRmSAVek4kjvMRTDozO+7x
 pbuw6bi6CqXKKTd8cnvXie6IJrSVducWBQYDYb5cbnKIOgy6a0V7G66+q+BA9A0/ERTd
 PNUQXqX1zC0vUhVaNZKzpLCSNgiJD8V4uGhwLyBhaRDKH0FkEE/sILFKY3Ebowk3LZK+
 kREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r6DZWz56Ou8zN9swvxhZLHdPuxthEvVWZNmtroVIhWQ=;
 b=LKT2V9tC2cDwgY/HlUuOjdk/hCPHVApVTplAiyhG17lsZzAjovzwIqVT8WEeIGg4ir
 bWnFsmP2gvkOS5cPUAKRokIRx5DjrZ0W6+BwPB6GI7djv9V/NmCRPdksQuLRNyzp5WFS
 b6F5C5H+hsJNc6ThSjDmUiw1MDnbUSXUPzH+fKfIl/dgrGL1ykdwaLB3pnF5v3IFNhPK
 Sr7jeHOXDbSCXqDdZ7WMjZ4IB5mEmwOLiFP9vvKeKD5KvB3P67Zxnbt/FWhgOTrvx6wx
 f9SmlR+/7Po+NQ6CA01v5N5MxuhoaqZpr4IO+iPdm1Nha4CgUEiP/J6aoPOTB+iUDTjP
 X3LA==
X-Gm-Message-State: APjAAAX/Tjmo7hzv1KZV+RerBVXHyVJRXx70BD1R7YMOp0qSopBfzHip
 Y3Sa8VdJKbRAN+0nYb/xWnYCmP/fcLA=
X-Google-Smtp-Source: APXvYqwxmUzS7OCpzZMAX+qzXircRfq6uZ7XzmIFS6VRxGjrIqh2YD1g8XNpZNxRsJLKklLyYcZfew==
X-Received: by 2002:a1c:a795:: with SMTP id q143mr15308301wme.52.1576844068237; 
 Fri, 20 Dec 2019 04:14:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x10sm10077775wrp.58.2019.12.20.04.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:14:25 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE3101FFA9;
 Fri, 20 Dec 2019 12:04:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/21] tests/tcg/aarch64: add test-sve-ioctl guest-debug
 test
Date: Fri, 20 Dec 2019 12:04:36 +0000
Message-Id: <20191220120438.16114-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 alan.hayward@arm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test exercises the gdbstub while runing the sve-iotcl test. I
haven't plubmed it into make system as we need a way of verifying if
gdb has the right support for SVE.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - interrogate ZCR_EL1 directly as no longer have vg
---
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py | 71 +++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py

diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
new file mode 100644
index 00000000000..6b6b6c83f2d
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -0,0 +1,71 @@
+from __future__ import print_function
+#
+# Test the SVE ZReg reports the right amount of data. It uses the
+# sve-ioctl test and examines the register data each time the
+# __sve_ld_done breakpoint is hit.
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+
+initial_vlen = 0
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
+class TestBreakpoint(gdb.Breakpoint):
+    def __init__(self, sym_name="__sve_ld_done"):
+        super(TestBreakpoint, self).__init__(sym_name)
+        # self.sym, ok = gdb.lookup_symbol(sym_name)
+
+    def stop(self):
+        val_i = gdb.parse_and_eval('i')
+        global initial_vlen
+        for i in range(0, int(val_i)):
+            val_z = gdb.parse_and_eval("$z0.b.u[%d]" % i)
+            report(int(val_z) == i, "z0.b.u[%d] == %d" % (i, i))
+        for i in range(i + 1, initial_vlen):
+            val_z = gdb.parse_and_eval("$z0.b.u[%d]" % i)
+            report(int(val_z) == 0, "z0.b.u[%d] == 0" % (i))
+
+
+def run_test():
+    "Run through the tests one by one"
+
+    print ("Setup breakpoint")
+    bp = TestBreakpoint()
+
+    global initial_vlen
+    vg = gdb.parse_and_eval("$ZCR_EL1")
+    initial_vlen = int(vg) * 16
+
+    gdb.execute("c")
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
+    import code
+    code.InteractiveConsole(locals=globals()).interact()
+    raise
+
+print("All tests complete: %d failures" % failcount)
+exit(failcount)
-- 
2.20.1


