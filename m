Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D07C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55F820659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qwefnfc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55F820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOR6-0004gm-Qh
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIe-000825-F9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIc-0007Cd-WC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40650)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOIc-00077f-Mf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id t3so3691243wru.7
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m8trnK4dsJcOAkqMwuDk8oN/65638+mbTVeX6RjAM68=;
 b=Qwefnfc3n1Wkhys+i9/hx/cJU+f/bC8yCkcETsKFHe8n+IjDCmQrTJ0UjTsPvNFzJ/
 9LVD7NkonCfEagIlVABleRVkPcW7Oz97nX9535Y+oQgina4z0W1Pdg1i7ABSjeMii0lC
 3vDwV+GH0XWh3P/TIue40IQmse5fjS0/w/ZK0tRjU6LZc5GZAfA68BdkwfPPRKhzeD03
 YaKLh4cH4n+8Q/M8J83zlJimGK+qOe2etcPCsfVKtsWoNPzqE3WRGIXmQv8TCXQtHyTd
 LZbZ+BNrZQDnwbtYEs3o+yPBCStjvKCwqoreenNHgxCS64+ffSaazpRdqx1bA4y/Q8ne
 L7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m8trnK4dsJcOAkqMwuDk8oN/65638+mbTVeX6RjAM68=;
 b=sLUg+WYsNLbJrsK1Rjq1FdNhh5Csjqx7/dEm9eFG7Kb68BBbfp46hhky45HFxdkXYm
 M8eTvvjTHsictlTI8RIjlaHez50MF9TJ/5uQuSjdrYpDOIEPZqbvn1NR0mtJJcWwLvQt
 /wLOyxlVN5ji0ZV76AMGYYotFrxEtC4f9ozptTFUy4HQGXe+mwLsTDy1zKDu02l5D/NS
 4YE6rI+4KWSRtGWFKp4KDYxuE/n0bhZw4cQRVaJRNNhE8n5Bho8Vt7qeNDqT6p04uS/3
 nrS6zszbg0E+Dky2z6ahwalDWbFjZvbsrdC/aJXIa8orrucOIx9p+HFgqXKL7HncTQtP
 /3Xw==
X-Gm-Message-State: APjAAAXParyBONZWEmBK6gd0ugF1xa7vDi7VWX2nlM+XJGjJ/2PcH7LU
 yCqs47ehARrftUdDGA6dKgdxUw==
X-Google-Smtp-Source: APXvYqyI3i/36PBUBxJWjDSX6rr1vi998ugpr2YdzDGC9aiwEv3iAOHG93oBvOH5p25Mm4lk6EMPZw==
X-Received: by 2002:a05:6000:1252:: with SMTP id
 j18mr31723283wrx.103.1580923033720; 
 Wed, 05 Feb 2020 09:17:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a132sm314424wme.3.2020.02.05.09.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:17:10 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 76B171FFA9;
 Wed,  5 Feb 2020 17:10:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 18/22] tests/tcg/aarch64: add a gdbstub testcase for SVE
 registers
Date: Wed,  5 Feb 2020 17:10:27 +0000
Message-Id: <20200205171031.22582-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

A very simple test case which sets and reads SVE registers while
running a test case. We don't really need to compile a SVE binary for
this case but we will later so keep it simple for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - properly plumb in
  - skip if fails to connect
---
 tests/.gitignore                      |  1 +
 tests/tcg/aarch64/Makefile.target     | 15 +++++
 tests/tcg/aarch64/gdbstub/test-sve.py | 81 +++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py

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
index 00000000000..90201d80094
--- /dev/null
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -0,0 +1,81 @@
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


