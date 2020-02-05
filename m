Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB03C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A6220702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vBSthV3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A6220702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOP2-0001Vz-3i
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIa-0007se-HS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIZ-0006nD-0V
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:12 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOIY-0006g2-NN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:10 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so3708981wrh.5
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eSwmQ9XA2bwdY7fVj2P4vxFM2o9VugdkCcmqMvw8Uvk=;
 b=vBSthV3ZD4MVKGnGuvyLazWzQciPrPCI12GGugdBxFC7jIx94G0/CR41Pq4bzm6bQr
 dal+sLntS/Cc8orEYy8hCAYPtqFpphr+3Pc2e2TxI+O/I346N+c8E7VtF1pBx7GQ1wds
 R2nZzICFLNY+xJTvuG7DS5qdmcMlqNJ/Z9MjfhQrHhwJebW9Dh0cVBgp/NSjcnd802P8
 /veR43W3JvrNkY3v/qsm7HAwxZ2W3dYRphEiBTpa6nbSJoE07Fm2OH0qhe7QgmT4apvR
 QuzAlbqh6YRlDmEEPEc0E0dKv6/33dyHaPaEuYGgJY7HBLl3IdM/MqWDLbFxyQcYi1Dy
 P4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eSwmQ9XA2bwdY7fVj2P4vxFM2o9VugdkCcmqMvw8Uvk=;
 b=U6QmMcjIFwydS6n6RJ9aVv4rlDOKt+Ietl+GYf+B/Lb6QJSrEm/0agixjsdkyOcrxa
 dOB8iG93+OSlLxD5GlbH+Bn6ILwmdHmSGstg8k1BMc5QsytPrp5pg3PE7v8kB3dFvd5g
 KTMPaTL1DFzT6yJ+8a0QOrKIfAQr2CKpjJ5ztquhYbryPXvmzGHfmNsowsIQ6qc1e6+n
 5HoL3eePyh8lcbPZHHU4AUntpbWYH1uXrj0dTSQ5+k9cxmoIdArczeI6KTDDuakWY7Fo
 IK8InqbyxibQiPJdpoTHtugGoPC/JFAhNlEM0lPYdg/0wXBZJ/VnVT8bHd44ojVXBvAI
 1fOQ==
X-Gm-Message-State: APjAAAXNFbToiiG9jtG720J5AfEgo2Pxo9DAlX9bPCqKn/0Zg7AZx2OL
 Hb6VG5UH4PMDXS1AzhTM/jeVgw==
X-Google-Smtp-Source: APXvYqyIAVGnEqTfQohXMVYoSxQI7nrtilzN6b+2pTVGivralZPcqjXxEWdtNM4FiFoMUTyde66RvQ==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr28298324wru.382.1580923029753; 
 Wed, 05 Feb 2020 09:17:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a26sm301523wmm.18.2020.02.05.09.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:17:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A1A671FFAB;
 Wed,  5 Feb 2020 17:10:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 20/22] tests/tcg/aarch64: add test-sve-ioctl guest-debug
 test
Date: Wed,  5 Feb 2020 17:10:29 +0000
Message-Id: <20200205171031.22582-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
v6
  - fix for vg
---
 tests/tcg/aarch64/Makefile.target           | 11 ++-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py | 79 +++++++++++++++++++++
 2 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index c879932ff6c..d99b2a9eced 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -54,15 +54,22 @@ sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
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
index 00000000000..c4425cc9462
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
+    vg = gdb.parse_and_eval("$vg")
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


