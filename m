Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DDBC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7118B2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBDI0sl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7118B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGWB-00078k-5U
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUN-0005RJ-H8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUL-0008EI-Jx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUJ-00089B-DO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f7so261701wml.4
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cqKq7MlHK53nbIqC1omFbmt09y3THTY7GXgnExfxVbk=;
 b=LBDI0sl7amJCaml5FZsjxjTDsW20xiWIlpnwG8EdrMgJLRXsKHqlzOEnFnYDTKdwJa
 pG8BIl2CRNK1db550UVK0jC7eTiI8IUvrl+gMkv81L1H//FG+1Tg7esNf5cFdEAzRInk
 +M+zJUswKW0yU68su38rM4OITNzSi4h5QNjs5PpowJeoxRAd5UYOpH2YR7jxt5LAJXnU
 0bofDM3j3Q6cwQiBOseyV6vCaHNKzArQYVu/5PTaDRHlFZ86NhoRldXZcfYW+0OpAq+X
 /+e6xVVeCBQSiyVvS93YJXp/BQ5XEBpQSENMbui6RLzr3itnq6Iv57CWLuct85iWyYnv
 tvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cqKq7MlHK53nbIqC1omFbmt09y3THTY7GXgnExfxVbk=;
 b=PPDKo4mBCBDozdAE2XONvxiBSeBgl3T+N7p4HCMuftiz1sFqzJYl4H070k0QJ3Z/2G
 o4AP1uuiONyJO7CNk5KjkAl1ZyOpL3rHBkkemNdrqcOQYVC5xW2ZKN2uQTbDxNDr+ryg
 zqzuCC8RQXj9Grd9dpKMTIfAovIDxWzFXXnZu9JvdqsTLrqO5MN/Bg5zs7Sac6Ky+8XG
 fUq6OXA8WboAcRKSTVGHZs17DVHN8L0M1a4AT8niPMZdznu1Yvysgd5gBMGCRb1/cpg2
 Tm9D9RjVgDrBA1kh/VYLJkl8hbPs3ZG8eozu+aedadYwqn/4XmdY4vNOItaIdzdabxNe
 7vhw==
X-Gm-Message-State: ANhLgQ172l11EWL1VpcH0qSLpvWJvPgE7+X7BMIc0RgAvvqXKPc3LLrg
 +e9VHOLYHUQkVSQbhh9nqib7mA==
X-Google-Smtp-Source: ADFU+vs4ibaYJyFfzZPuXpmvvW8agMNaIF6bXDFRhN3m+fHQTP9h3Ob8wWummHiP2sr5fLbWx/WY9A==
X-Received: by 2002:a05:600c:2214:: with SMTP id
 z20mr191207wml.61.1584467925985; 
 Tue, 17 Mar 2020 10:58:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c124sm249927wma.10.2020.03.17.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7D711FFAC;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 23/28] tests/tcg/aarch64: add a gdbstub testcase for SVE
 registers
Date: Tue, 17 Mar 2020 17:50:48 +0000
Message-Id: <20200317175053.5278-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A very simple test case which sets and reads SVE registers while
running a test case. We don't really need to compile a SVE binary for
this case but we will later so keep it simple for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200316172155.971-24-alex.bennee@linaro.org>

diff --git a/tests/.gitignore b/tests/.gitignore
index 7306866f216..d03c037d772 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -10,6 +10,7 @@ qht-bench
 rcutorture
 test-*
 !test-*.c
+!test-*.py
 !docker/test-*
 test-qapi-commands.[ch]
 test-qapi-init-commands.[ch]
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index a25afc071cc..b61b53e4dd1 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -46,6 +46,21 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
 # System Registers Tests
 AARCH64_TESTS += sysregs
 sysregs: CFLAGS+=-march=armv8.1-a+sve
+
+ifneq ($(HAVE_GDB_BIN),)
+GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
+
+AARCH64_TESTS += gdbstub-sysregs
+
+.PHONY: gdbstub-sysregs
+run-gdbstub-sysregs: sysregs
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
+	"basic gdbstub SVE support")
+endif
+
 endif
 
 TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
new file mode 100644
index 00000000000..dbe7f2aa932
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -0,0 +1,84 @@
+from __future__ import print_function
+#
+# Test the SVE registers are visable and changeable via gdbstub
+#
+# This is launched via tests/guest-debug/run-test.py
+#
+
+import gdb
+import sys
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
+try:
+    inferior = gdb.selected_inferior()
+    if inferior.was_attached == False:
+        print("SKIPPING (failed to attach)", file=sys.stderr)
+        exit(0)
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
+
+print("All tests complete: %d failures" % failcount)
+
+exit(failcount)
-- 
2.20.1


