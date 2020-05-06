Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082F5C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1409206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fv2QuiVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1409206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIxR-0005su-V3
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIoD-0006VE-OO
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:50863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo9-0001KO-Ij
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id x25so2318080wmc.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nyAFPIx+jq/Ehvwqrvfm8Rt93l3rNEG7Vx2OIJ8VkIQ=;
 b=Fv2QuiVPyYdVWGbLkrMIrlVppH+Uqa6EA92bXpKXg2FW7AV89P/JCOLPNXc4DWPH0F
 wFMkRq0tTgVjRJmId+mAffp6jdGJ5yCmmQUH32X1/MSIXz9Xz6DmrA+DbAq9dv2W7bB4
 zVkJW7+q7Jq3ZPzhavJnPaYOOhS25Uvc+mnb1k+XpE/dzznLmOJLGuc5hNunsBqlPkMn
 uMuZlewPvePHSWuXXT9baVzQ9Z45+ib7QpoybC1FCoPEwIeoC+zKWuD4TW7pzkHQi3LH
 lvymEb6M2lMShWmBz70LtIQA1cY3OJAz+GriMcoQyRt79viRzJhGWOc9IqKnkgrcR+a3
 fUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nyAFPIx+jq/Ehvwqrvfm8Rt93l3rNEG7Vx2OIJ8VkIQ=;
 b=JbiHLgi1k+lISQ+VxW+WWEMQAexFgwQeLqOUYSbtGnU39b32tWBhJnjsRRnR18F8vZ
 E6jSQKIk5gjBWm4PqmJkpASH7xiI2Vcz2JCusp0lDcIlpu2QibkyMzt0kHnmtTe65wWQ
 Jv11Zfb38JR5oT2esy7OiS7WP5/TUwiD5JYxKakEtXTuHWZ94oZ9LTDUKOBC5RyrMSL3
 uPYU07eJmOzJbeoQzC43k2CIR4RSqODKY7R0rcirnapDsN6dLoMOWjig5QIAPYV6c9dK
 2vozimWdbbhEJAI3dOZT7oIQk556A7gr48PT8mk1zULAOzduFOTZ3tR2n7x/pw+Znsh8
 V3ig==
X-Gm-Message-State: AGi0Pua4D/LaJnvw+jwNuGly+KIQmOOREiy+YHNYe2IaZfbIiSCVDAQ6
 upDMyVyq6UYLGr8RTju5fc205Q==
X-Google-Smtp-Source: APiQypLrV6q5jm9EqKG/26cy/pXbFw87ZVA4HzZ69cnDNOfqe6nihnOFWY49E6EDL+KmAfnXYJM+2A==
X-Received: by 2002:a05:600c:2314:: with SMTP id
 20mr3944827wmo.35.1588766748127; 
 Wed, 06 May 2020 05:05:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 185sm2935370wmc.32.2020.05.06.05.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E32711FF9C;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/14] tests/tcg: add a multiarch linux-user gdb test
Date: Wed,  6 May 2020 13:05:28 +0100
Message-Id: <20200506120529.18974-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the gdbstub code was converted to the new API we missed a few
snafus in the various guests. Add a simple gdb test script which can
be used on all our linux-user guests to check for obvious failures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200430190122.4592-9-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index d99b2a9eced..312f36cde5f 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -54,9 +54,6 @@ sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
 ifneq ($(HAVE_GDB_BIN),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
-AARCH64_TESTS += gdbstub-sysregs gdbstub-sve-ioctls
-
-.PHONY: gdbstub-sysregs gdbstub-sve-ioctls
 run-gdbstub-sysregs: sysregs
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(HAVE_GDB_BIN) \
@@ -70,6 +67,8 @@ run-gdbstub-sve-ioctls: sve-ioctls
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
 		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
 	"basic gdbstub SVE ZLEN support")
+
+EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
 endif
 
 endif
diff --git a/tests/tcg/cris/Makefile.target b/tests/tcg/cris/Makefile.target
index 24c7f2e7616..e72d3cbdb23 100644
--- a/tests/tcg/cris/Makefile.target
+++ b/tests/tcg/cris/Makefile.target
@@ -23,6 +23,7 @@ CRIS_RUNS = $(patsubst %, run-%, $(CRIS_USABLE_TESTS))
 
 # override the list of tests, as we can't build the multiarch tests
 TESTS = $(CRIS_USABLE_TESTS)
+EXTRA_RUNS =
 VPATH = $(CRIS_SRC)
 
 AS	= $(CC) -x assembler-with-cpp
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 035b09c8533..51fb75ecfdd 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -42,5 +42,19 @@ run-test-mmap-%: test-mmap
 	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<,\
 		"$< ($* byte pages) on $(TARGET_NAME)")
 
+ifneq ($(HAVE_GDB_BIN),)
+GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
+
+run-gdbstub-sha1: sha1
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
+	"basic gdbstub support")
+
+EXTRA_RUNS += run-gdbstub-sha1
+endif
+
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/gdbstub/sha1.py b/tests/tcg/multiarch/gdbstub/sha1.py
new file mode 100644
index 00000000000..734553b98bb
--- /dev/null
+++ b/tests/tcg/multiarch/gdbstub/sha1.py
@@ -0,0 +1,81 @@
+from __future__ import print_function
+#
+# A very simple smoke test for debugging the SHA1 userspace test on
+# each target.
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
+        print("PASS: %s" % (msg))
+    else:
+        print("FAIL: %s" % (msg))
+        global failcount
+        failcount += 1
+
+def check_break(sym_name):
+    "Setup breakpoint, continue and check we stopped."
+    sym, ok = gdb.lookup_symbol(sym_name)
+    bp = gdb.Breakpoint(sym_name)
+
+    gdb.execute("c")
+
+    # hopefully we came back
+    end_pc = gdb.parse_and_eval('$pc')
+    report(bp.hit_count == 1,
+           "break @ %s (%s %d hits)" % (end_pc, sym.value(), bp.hit_count))
+
+    bp.delete()
+
+def run_test():
+    "Run through the tests one by one"
+
+    check_break("SHA1Init")
+
+    # check step and inspect values
+    gdb.execute("next")
+    val_ctx = gdb.parse_and_eval("context->state[0]")
+    exp_ctx = 0x67452301
+    report(int(val_ctx) == exp_ctx, "context->state[0] == %x" % exp_ctx);
+
+    gdb.execute("next")
+    val_ctx = gdb.parse_and_eval("context->state[1]")
+    exp_ctx = 0xEFCDAB89
+    report(int(val_ctx) == exp_ctx, "context->state[1] == %x" % exp_ctx);
+
+    # finally check we don't barf inspecting registers
+    gdb.execute("info registers")
+
+#
+# This runs as the script it sourced (via -x, via run-test.py)
+#
+try:
+    inferior = gdb.selected_inferior()
+    arch = inferior.architecture()
+    print("ATTACHED: %s" % arch.name())
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
+except (gdb.error):
+    print ("GDB Exception: %s" % (sys.exc_info()[0]))
+    failcount += 1
+    pass
+
+print("All tests complete: %d failures" % failcount)
+exit(failcount)
-- 
2.20.1


