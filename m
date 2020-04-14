Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E05C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA09B206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3SJYTvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA09B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOS0m-0006cG-Us
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyh-0003yT-Nc
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyg-0001hs-GI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:47053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORyg-0001h9-A7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id f13so16028450wrm.13
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pXOAgjF0MzY5dkIyjyLAmatYK5vlyk1VB17UWTeSYLg=;
 b=l3SJYTvEgPDRkSatLR4hF7MJ5Msw6QnVdjtiVi20VWWZ/2NEtk2cZuDWDkP0maoeQi
 /htFWipTBa7ExaFfx+BSNLxZmAawvkiskTaJE8mF9aYyi6eM3jWe23IHnpbTxXH/5K30
 2x1qntg5N8Ho0VyWYIrKSas+gqg1L+dQ0nQjDNfzh1Pa5EmnQvAl/GpW4luueidC5X9M
 LfUv19Yjd0oX8OAlN2isV+h2Ea38wjMTL29JjxnMuwk6xkdlPQHbsN66azMtqlHbjYTN
 Zf8rXDm9NdUdaCiEipH/2O+tzKIjHJxkch8jCgzfHeTSvLt/fPwZd76BmP94BT8a/kB+
 K6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pXOAgjF0MzY5dkIyjyLAmatYK5vlyk1VB17UWTeSYLg=;
 b=azXnwoB2lT4uFWzWefGKJbCLggypFpgb6zd20POvMKPFx47cmeOAmiUSoUR0canvDP
 wiIKd6QFgMgJSkXOWtGalft1yc02U2KER+1S+AUdffnjqIu11pxgDVcEpP9jOpgeFwhW
 Vixa4ZA0JPQbcjpcX/jW8pFIcPxbWbYlnTiR47pcoso4DlSamm7DVKYQ9tmwhBOA4M3d
 RxoJkq/cSA3c4NtGobQDb/A7AH+jEPPig14koYGRzKQTHI+f8qU6XzHMyQI8IhcLRPEb
 DcgWEQ6u3fyDHVO26bIIqdWTznaElvd25ttmFcT5OakiTbpparO5tR8my0Jx9iZ7aFwA
 X5Kw==
X-Gm-Message-State: AGi0PubcaBjsJTG9ReCs9gQppZS0ubbIE0DOf2lwel2m2PAhF1vDp9yu
 2UMKCy/cYEZdUWwzczypgfAF/Bo8D5U=
X-Google-Smtp-Source: APiQypLaSu3pKs0nGVbFd13L3R+mqpY2ZGE/dCFEyFZZUsPJG2wAINYZvaofW/JDSphOpNDeQDu6Hg==
X-Received: by 2002:adf:fe45:: with SMTP id m5mr17771336wrs.124.1586895373108; 
 Tue, 14 Apr 2020 13:16:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p6sm12977676wrt.3.2020.04.14.13.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:16:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 587BD1FF9F;
 Tue, 14 Apr 2020 21:06:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 17/17] tests/tcg: add a multiarch linux-user gdb test
Date: Tue, 14 Apr 2020 21:06:31 +0100
Message-Id: <20200414200631.12799-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the gdbstub code was converted to the new API we missed a few
snafus in the various guests. Add a simple gdb test script which can
be used on all our linux-user guests to check for obvious failures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 15 ++++++
 tests/tcg/multiarch/gdbstub/sha1.py | 81 +++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 tests/tcg/multiarch/gdbstub/sha1.py

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 035b09c8533..47fd675aba5 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -42,5 +42,20 @@ run-test-mmap-%: test-mmap
 	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<,\
 		"$< ($* byte pages) on $(TARGET_NAME)")
 
+ifneq ($(HAVE_GDB_BIN),)
+GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
+
+MULTIARCH_TESTS += gdbstub-sha1
+
+.PHONY: gdbstub-sha1
+run-gdbstub-sha1: sha1
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(HAVE_GDB_BIN) \
+		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
+		--bin $< --test $(MULTIARCH_SRC)/gdbstub/sha1.py, \
+	"basic gdbstub support")
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


