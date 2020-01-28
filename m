Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACAAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DB2214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+dRQ59x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DB2214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVL1-0004Wv-JH
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV4B-0006Q5-KK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV49-00088M-4p
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:37751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV48-00085X-Se
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:21 -0500
Received: by mail-wm1-x332.google.com with SMTP id f129so3574816wmf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HVk4rk8Hs1aHWLt8//y3A+CwPwqc2G6pl0VklRB6s3U=;
 b=U+dRQ59xaEnQ9FxMU+Qi/hn+nPFFoTZGRaTotxR+jjuHfiNcLFX7GB8q7zi8Jm9q/6
 fkaeBckJkKLX19LF8AgMi9h+nPRoZgiIlG7nb5dFmxcMs4BuArawS3VSSO5n+uGrLYU7
 cYMdDYT0BPJ+THETPZ7CFlX1iSgHgqn2LfJlAZU5ND59x/L3dpP9SueSl07Qsy4vVKCj
 IbzaJo6AeqKulb1QG1TzhGWnudlVZTp6c1pEq9HzNLLdiB3Dh5JV/4ENIisfdeB6kyR/
 0tV83cottLg8ffNY0XW8a8WOjYhvMbMf3Lb06PbwhNaXL+lIfxSmfm2/29D5LswrrABh
 5XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HVk4rk8Hs1aHWLt8//y3A+CwPwqc2G6pl0VklRB6s3U=;
 b=d1uBXb9uQQO+lH0PGTuXaxZFDkqp94xHNKr54KWD9wJbUQuXBuFtlqriycC4JTfdNy
 ZW22jRLKmrpSLEZC6M5puPozsH93Mrstag3PzyX1huiH9WY7qpm3hnRDnyUOh9eod7Gy
 iHLufbHJd6yNDeT1UzFhlg/S4hKPgUMcTFLykhWR03VXA+YBojNf/25m9GWxdpf5vsmU
 QW3u7N8q+xt/CvVX/+5uB7feczHVD6uWNs4z+uSaRWpStBXzEp2nm6W/jHdBdx2FOipf
 OSQw8+MQ6nr5rbfIcmJvkQ2MmJtFoGLevyEo0pisOahFM1PboBm0WMBOq+DnfJbEBfMz
 psaA==
X-Gm-Message-State: APjAAAWg3jCbOFWSPQzPV5ytzulXpulS4jru5qI38H3CgGeRiZu7pbFv
 Jjm5KtheO4rw4KLfkcu7mAPcGotT
X-Google-Smtp-Source: APXvYqztby9Bt1WnlIj9WjbqI3r55vtOQ7MEwpJCjTB3lWFUCh+xPqJk2OiP9UDHOtx0E+wcx7KHWg==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr6610655wmo.12.1580234058715; 
 Tue, 28 Jan 2020 09:54:18 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 012/142] meson: add testsuite Makefile generator
Date: Tue, 28 Jan 2020 18:51:32 +0100
Message-Id: <20200128175342.9066-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
---
 Makefile               |   4 ++
 scripts/mtest2make.py  | 101 +++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   1 -
 3 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 scripts/mtest2make.py

diff --git a/Makefile b/Makefile
index 9aa0808649..fee6f739fd 100644
--- a/Makefile
+++ b/Makefile
@@ -61,6 +61,10 @@ ninjatool: ninjatool.stamp
 ninjatool.stamp: $(SRC_PATH)/scripts/ninjatool.py
 	$(MESON) setup --reconfigure . $(SRC_PATH) && touch $@
 
+Makefile.mtest: build.ninja scripts/mtest2make.py
+	$(MESON) introspect --tests | $(PYTHON) scripts/mtest2make.py > $@
+-include Makefile.mtest
+
 .git-submodule-status: git-submodule-update config-host.mak
 
 # Check that we're not trying to do an out-of-tree build from
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
new file mode 100644
index 0000000000..ac4010ff8f
--- /dev/null
+++ b/scripts/mtest2make.py
@@ -0,0 +1,101 @@
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
+.test-human-tap = $1 < /dev/null | ./scripts/tap-driver.pl --test-name="$2" $(if $(V),, --show-failures-only)
+.test-human-exitcode = $1 < /dev/null $(if $(V),,> /dev/null 2>&1)
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
+    is_slow = 'slow' in test_suites
+    for s in test_suites:
+        if s == 'slow':
+            continue
+        # The suite name in the introspection info is "PROJECT:SUITE"
+        s = s.split(':')[1]
+        if is_slow:
+            suites[s].slow_tests.append(i)
+        else:
+            suites[s].tests.append(i)
+        suites[s].executables.add(executable)
+
+print('.PHONY: check check-report.tap')
+print('check:')
+print('check-report.tap:')
+print('\t$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")')
+for name, suite in suites.items():
+    executables = ' '.join(suite.executables)
+    slow_test_numbers = ' '.join((str(x) for x in suite.slow_tests))
+    test_numbers = ' '.join((str(x) for x in suite.tests))
+    print('.test.suite-quick.%s := %s' % (name, test_numbers))
+    print('.test.suite-slow.%s := $(.test.suite-quick.%s) %s' % (name, name, slow_test_numbers))
+    print('.PHONY: check-%s' % name)
+    print('.PHONY: check-report-%s.tap' % name)
+    print('check: check-%s' % name)
+    print('check-%s: %s' % (name, executables))
+    print('\t$(call .test.human, $(.test.suite-$(SPEED).%s))' % (name, ))
+    print('check-report.tap: check-report-%s.tap' % name)
+    print('check-report-%s.tap: %s' % (name, executables))
+    print('\t$(call .test.tap, $(.test.suite-$(SPEED).%s))' % (name, ))
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9146e1bdee..eaa57196f9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -936,7 +936,6 @@ check-report-unit.tap: $(check-unit-y)
 # Reports and overall runs
 
 check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
-	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
 
 # FPU Emulation tests (aka softfloat)
 #
-- 
2.21.0



