Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E386B20729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVtlytva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E386B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gWQ-00012o-3U
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGn-0003rP-Sp
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGm-00064Y-2o
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id t14so14086099wmi.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fWHmrkva6tvROSN57DBDe2O0fpTnZMaLKw/ALz8PEs=;
 b=FVtlytvaAve3GcMDhQdxr5X9toHXT1xvY7A2ZrsL9I3rxDL1pkGjRalXo8+mkP1AOd
 v2gEmQd07oZLnj4M/9LJZLbAgz+A8bVOAfbhEXqHZ//F9KhY29zmyEBVIP+Vi6N+HFd8
 DW2z9YrZyXXGkdrTdAu5qQlLzLKDhb1YohYuADeU47MSHIeG8Vz+DuRjQBgJ0nuu6D7K
 nsKR6qc3+6VytGdvy9wnjlw8GKuBYksnpNInDpfNkEaz0/4AB9bsb5RVsncGkb3k3yTd
 sANS16jIGxx6ZhY1jDGlqelIwjXFO3yY1nRIb5Z+gSfZYfq+3T5wZs5b3v2y6786NejY
 x0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2fWHmrkva6tvROSN57DBDe2O0fpTnZMaLKw/ALz8PEs=;
 b=FLhrVB/lymvSfWIirygwO2jyNZ1/FTBvQRy/6Dxp8kb3NoXjhGTJIAKo0RqdfKHCYW
 CkplnBrsLlaQ/Vt80NPrpSsl8777dAI8MgfPBC1BcEgaknummX0cS5oaOpLdnZ+q3zvM
 Rljuu9Do/gMVR5CgFqYUCzSLvdlRUNovRdD/9dWtiI9FnpYaQhvkpHBMZ52YpOQZU9GS
 RSDJTrky/EBlG2FX6oVRX2qX6SBEUUaRRG+4fgZRsCA+8m8+pZHlhjR1+BZQJWj8TrCL
 Eh9Qk66DGiNgv6j3eiQZF341myTdLHRQzfWCGGYkCNM/XFIX1XvkEZQobJyj41zcGE7V
 1Pmg==
X-Gm-Message-State: AOAM531ju8t4Zdk/gZaxEZqeeaWr8jbFK3BCCjOK/RE+LPOTHf5adBn7
 VdQFMPSsjjue3Uqkxf7aRH8smUHc8ec=
X-Google-Smtp-Source: ABdhPJzUkt1qUSPF9/ziSduy3dmFwjfTA+ovErqwarlsYvhXrLA3NeoUnNyDaCCgpiVYv29+ZsS15w==
X-Received: by 2002:a1c:a1c7:: with SMTP id k190mr14167969wme.1.1597675070373; 
 Mon, 17 Aug 2020 07:37:50 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.49 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 023/150] meson: add testsuite Makefile generator
Date: Mon, 17 Aug 2020 16:35:16 +0200
Message-Id: <20200817143723.343284-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rules to execute tests are generated by a simple Python program
that integrates into the existing "make check" mechanism.  This
provides familiarity for developers, and also allows piecewise
conversion of the testsuite Makefiles to meson.

The generated rules are based on QEMU's existing test harness
Makefile and TAP parser.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               |   6 ++-
 scripts/mtest2make.py  | 102 +++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   1 -
 3 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 scripts/mtest2make.py

diff --git a/Makefile b/Makefile
index 8288e2fbd2..b4dff89204 100644
--- a/Makefile
+++ b/Makefile
@@ -63,6 +63,10 @@ clean-ctlist:
 ninja-clean::
 ninja-distclean::
 
+Makefile.mtest: build.ninja scripts/mtest2make.py
+	$(MESON) introspect --tests | $(PYTHON) scripts/mtest2make.py > $@
+-include Makefile.mtest
+
 .git-submodule-status: git-submodule-update config-host.mak
 
 # Check that we're not trying to do an out-of-tree build from
@@ -818,7 +822,7 @@ distclean: clean ninja-distclean
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -rf meson-private meson-logs meson-info compile_commands.json
-	rm -f Makefile.ninja ninjatool ninjatool.stamp
+	rm -f Makefile.ninja ninjatool ninjatool.stamp Makefile.mtest
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
new file mode 100644
index 0000000000..bdb257bbd9
--- /dev/null
+++ b/scripts/mtest2make.py
@@ -0,0 +1,102 @@
+#! /usr/bin/env python3
+
+# Create Makefile targets to run tests, from Meson's test introspection data.
+#
+# Author: Paolo Bonzini <pbonzini@redhat.com>
+
+from collections import defaultdict
+import json
+import os
+import shlex
+import sys
+
+class Suite(object):
+    def __init__(self):
+        self.tests = list()
+        self.slow_tests = list()
+        self.executables = set()
+
+print('''
+SPEED = quick
+
+# $1 = test command, $2 = test name
+.test-human-tap = $1 < /dev/null | ./scripts/tap-driver.pl --test-name="$2" $(if $(V),,--show-failures-only)
+.test-human-exitcode = $1 < /dev/null
+.test-tap-tap = $1 < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $2/" || true
+.test-tap-exitcode = printf "%s\\n" 1..1 "`$1 < /dev/null > /dev/null || echo "not "`ok 1 $2"
+.test.print = echo $(if $(V),'$1','Running test $2') >&3
+.test.env = MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))}
+
+# $1 = test name, $2 = test target (human or tap)
+.test.run = $(call .test.print,$(.test.cmd.$1),$(.test.name.$1)) && $(call .test-$2-$(.test.driver.$1),$(.test.cmd.$1),$(.test.name.$1))
+
+define .test.human_k
+        @exec 3>&1; rc=0; $(foreach TEST, $1, $(call .test.run,$(TEST),human) || rc=$$?;) \\
+              exit $$rc
+endef
+define .test.human_no_k
+        $(foreach TEST, $1, @exec 3>&1; $(call .test.run,$(TEST),human)
+)
+endef
+.test.human = \\
+        $(if $(findstring k, $(MAKEFLAGS)), $(.test.human_k), $(.test.human_no_k))
+
+define .test.tap
+        @exec 3>&1; { $(foreach TEST, $1, $(call .test.run,$(TEST),tap); ) } \\
+              | ./scripts/tap-merge.pl | tee "$@" \\
+              | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only)
+endef
+''')
+
+suites = defaultdict(Suite)
+i = 0
+for test in json.load(sys.stdin):
+    env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
+                    for k, v in test['env'].items()))
+    executable = os.path.relpath(test['cmd'][0])
+    if test['workdir'] is not None:
+        test['cmd'][0] = os.path.relpath(test['cmd'][0], test['workdir'])
+    else:
+        test['cmd'][0] = executable
+    cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
+    if test['workdir'] is not None:
+        cmd = '(cd %s && %s)' % (shlex.quote(test['workdir']), cmd)
+    driver = test['protocol'] if 'protocol' in test else 'exitcode'
+
+    i += 1
+    print('.test.name.%d := %s' % (i, test['name']))
+    print('.test.driver.%d := %s' % (i, driver))
+    print('.test.cmd.%d := %s' % (i, cmd))
+
+    test_suites = test['suite'] or ['default']
+    is_slow = any(s.endswith('-slow') for s in test_suites)
+    for s in test_suites:
+        # The suite name in the introspection info is "PROJECT:SUITE"
+        s = s.split(':')[1]
+        if s.endswith('-slow'):
+            s = s[:-5]
+        if is_slow:
+            suites[s].slow_tests.append(i)
+        else:
+            suites[s].tests.append(i)
+        suites[s].executables.add(executable)
+
+print('.PHONY: check check-report.tap')
+print('check:')
+print('check-report.tap:')
+print('\t@cat $^ | scripts/tap-merge.pl >$@')
+for name, suite in suites.items():
+    executables = ' '.join(suite.executables)
+    slow_test_numbers = ' '.join((str(x) for x in suite.slow_tests))
+    test_numbers = ' '.join((str(x) for x in suite.tests))
+    print('.test.suite-quick.%s := %s' % (name, test_numbers))
+    print('.test.suite-slow.%s := $(.test.suite-quick.%s) %s' % (name, name, slow_test_numbers))
+    print('check-build: %s' % executables)
+    print('.PHONY: check-%s' % name)
+    print('.PHONY: check-report-%s.tap' % name)
+    print('check: check-%s' % name)
+    print('check-%s: all %s' % (name, executables))
+    print('\t$(call .test.human, $(.test.suite-$(SPEED).%s))' % (name, ))
+    print('check-report.tap: check-report-%s.tap' % name)
+    print('check-report-%s.tap: %s' % (name, executables))
+    print('\t$(call .test.tap, $(.test.suite-$(SPEED).%s))' % (name, ))
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c7e4646ded..ad54100369 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -674,7 +674,6 @@ check-report-unit.tap: $(check-unit-y)
 # Reports and overall runs
 
 check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
-	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
 
 # FPU Emulation tests (aka softfloat)
 #
-- 
2.26.2



