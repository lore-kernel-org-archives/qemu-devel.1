Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D61C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:27:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79382467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZba/916"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79382467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irO5y-0001vw-CA
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNy2-00005Q-Ks
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNy1-0008Dj-6p
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:54 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNy1-0008Ch-0F
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:53 -0500
Received: by mail-wr1-x441.google.com with SMTP id d16so12547791wre.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EPas9RAwcTKazprjvyJbjCOrku4t6UH+C/f0DKBx7ts=;
 b=jZba/916s27vJxQX6tojUJvd9miShs2H21F/VFJSHsQh1ZPii9oX2mV3bBJnQGs58C
 721/cD0XHGZzLOdHfWz8CqZBvnPex0osMKPqBISShzHptPT7ulc8vL7y533EwtzmlwOo
 auzRL7sx5UkgMqF93OYerFCG6jMuY5cBYsTEdXWnprMouAB/D7jbsddm84tyqdjFaDuO
 SxTUGkqb/+aJEAMpwvqqrQ4BwilgmeMr8uNq6uzZ6XauKk/xcuqXFxsc6Rn8o2By+n31
 AyVe5DFO1s8QiLsjdIqjCMXU1Z8Ro7aOhbJZKpnpbFRDGDo36LrEbX/ufmphIrymnT7+
 Ultw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EPas9RAwcTKazprjvyJbjCOrku4t6UH+C/f0DKBx7ts=;
 b=Q1vB3lP3foMhx3NXZJ81tm0ryPIPe4yc1fTCgN7TSOc5cg1gO650s8I4vqifMJhqi3
 UGjWRz6QTXu7S1aHrGAs/WgxrX90I/1sLfxLjTgA/fuBdJrwYE/wlaT5jKgGPIM66xPU
 e17rw/a/ky9oa4cDDvYAC5df1i0xczQZB4HYMNcXZVigJiEOuH9RPbFUZHqiNh/SKOuX
 W/S2o//Xl6fEQmyabsBbVSdsVgnmAaOGsrVKtYpgGi8cKowe2ZV9z4+S7OZfoIrcwVsz
 Au8RCmfN0Y7DLJ3oS00YUVcjvZcxuA9kFU2GR0CimDEQAR5YjhNNnUnGL+2HSL2G9maq
 VZpw==
X-Gm-Message-State: APjAAAVD9tJN/VVkOOcnSyRkPwUjiB7SaxvRvyKDU3pC4L5W7VbG6iz5
 PUqvykufIp6WzJvYW1sLlk4ckM80d7M=
X-Google-Smtp-Source: APXvYqxk1TmKtIQ/jyOmo3K9b1B5va53z3+zwsjFrrGOsKUdjmmr4pha8E20Ve2w0M7lfq427aG81Q==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr26704257wrs.237.1579015132009; 
 Tue, 14 Jan 2020 07:18:52 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p7sm18489517wmp.31.2020.01.14.07.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:18:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B9FE1FFA6;
 Tue, 14 Jan 2020 15:09:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 20/22] tests/tcg/aarch64: add test-sve-ioctl guest-debug
 test
Date: Tue, 14 Jan 2020 15:09:51 +0000
Message-Id: <20200114150953.27659-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
v5
  - plumb in
  - skip if fails to connect
---
 tests/tcg/aarch64/Makefile.target           | 11 ++-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py | 79 +++++++++++++++++++++
 2 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 66addbc52f..914ab81872 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -51,15 +51,22 @@ sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
 ifneq ($(HAVE_GDB_BIN),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-AARCH64_TESTS += gdbstub-sysregs
+AARCH64_TESTS += gdbstub-sysregs gdbstub-sve-ioctls
 
-.PHONY: gdbstub-sysregs
+.PHONY: gdbstub-sysregs gdbstub-sve-ioctls
 run-gdbstub-sysregs: sysregs
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
 	"basic gdbstub SVE support")
+
+run-gdbstub-sve-ioctls: sve-ioctls
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
+	"basic gdbstub SVE ZLEN support")
 endif
 
 endif
diff --git a/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
new file mode 100644
index 0000000000..6f4f429cf2
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve-ioctl.py
@@ -0,0 +1,79 @@
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
+import sys
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
+try:
+    inferior = gdb.selected_inferior()
+    arch = inferior.architecture()
+    report(arch.name() == "aarch64", "connected to aarch64")
+except (gdb.error, AttributeError):
+    print("SKIPPING (not connected)", file=sys.stderr)
+    exit(0)
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


