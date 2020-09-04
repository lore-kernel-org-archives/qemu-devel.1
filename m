Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DAEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9084B206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9084B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAB1-0008W1-Oa
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA68-0008Cm-U6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:43 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50210
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA5x-0005B9-LD
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:40 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-0b0kqKP1Pu2IFVknbn-Z5Q-1; Fri, 04 Sep 2020 07:41:27 -0400
X-MC-Unique: 0b0kqKP1Pu2IFVknbn-Z5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65209420F3
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2928B5D9F7
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/46] mtest2make: unify tests that appear in multiple suites
Date: Fri,  4 Sep 2020 07:40:43 -0400
Message-Id: <20200904114122.31307-8-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Whenever a test appears in multiple suites, the rules generated
by mtest2make are currently running it twice.  Instead, after
this patch we generate a phony target for each test and we have
a generic "run-tests" target depend on all the tests that were
chosen on the command line.  Tests that appear in multiple suites
will be added to the prerequisites just once.

This has other advantages: it removes the handling of -k and
it increases parallelism.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 74 ++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 27425080cf..af6dd0d3b1 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -24,33 +24,20 @@ SPEED = quick
 .test-human-exitcode = $1 $(PYTHON) scripts/test-driver.py $(if $4,-C$4) $(if $(V),--verbose) -- $2 < /dev/null
 .test-tap-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $3/" || true
 .test-tap-exitcode = printf "%s\\n" 1..1 "`$1 $(if $4,(cd $4 && $2),$2) < /dev/null > /dev/null || echo "not "`ok 1 $3"
-.test.print = echo $(if $(V),'$1 $2','Running test $3') >&3
+.test.human-print = echo $(if $(V),'$1 $2','Running test $3') &&
 .test.env = MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))}
 
 # $1 = test name, $2 = test target (human or tap)
-.test.run = $(call .test.print,$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1)) && $(call .test-$2-$(.test.driver.$1),$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1),$(.test.dir.$1))
+.test.run = $(call .test.$2-print,$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1)) $(call .test-$2-$(.test.driver.$1),$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1),$(.test.dir.$1))
 
-define .test.human_k
-        @exec 3>&1; rc=0; $(foreach TEST, $1, $(call .test.run,$(TEST),human) || rc=$$?;) \\
-              exit $$rc
-endef
-define .test.human_no_k
-        $(foreach TEST, $1, @exec 3>&1; $(call .test.run,$(TEST),human)
-)
-endef
-.test.human = \\
-        $(if $(findstring k, $(MAKEFLAGS)), $(.test.human_k), $(.test.human_no_k))
-
-define .test.tap
-        @exec 3>&1; { $(foreach TEST, $1, $(call .test.run,$(TEST),tap); ) } \\
-              | ./scripts/tap-merge.pl | tee "$@" \\
-              | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only)
-endef
+.test.output-format = human
 ''')
 
-suites = defaultdict(Suite)
+introspect = json.load(sys.stdin)
 i = 0
-for test in json.load(sys.stdin):
+
+def process_tests(test, suites):
+    global i
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
     executable = test['cmd'][0]
@@ -75,6 +62,9 @@ for test in json.load(sys.stdin):
     print('.test.driver.%d := %s' % (i, driver))
     print('.test.env.%d := $(.test.env) %s' % (i, env))
     print('.test.cmd.%d := %s' % (i, cmd))
+    print('.PHONY: run-test-%d' % (i,))
+    print('run-test-%d: all' % (i,))
+    print('\t@$(call .test.run,%d,$(.test.output-format))' % (i,))
 
     test_suites = test['suite'] or ['default']
     is_slow = any(s.endswith('-slow') for s in test_suites)
@@ -89,22 +79,34 @@ for test in json.load(sys.stdin):
             suites[s].tests.append(i)
         suites[s].executables.add(executable)
 
-print('.PHONY: check check-report.tap')
-print('check:')
-print('check-report.tap:')
-print('\t@cat $^ | scripts/tap-merge.pl >$@')
-for name, suite in suites.items():
+def emit_prolog(suites, prefix):
+    all_tap = ' '.join(('%s-report-%s.tap' % (prefix, k) for k in suites.keys()))
+    print('.PHONY: %s %s-report.tap %s' % (prefix, prefix, all_tap))
+    print('%s: run-tests' % (prefix,))
+    print('%s-report.tap %s: %s-report%%.tap: all' % (prefix, all_tap, prefix))
+    print('''\t$(MAKE) .test.output-format=tap --quiet -Otarget V=1 %s$* | ./scripts/tap-merge.pl | tee "$@" \\
+              | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only)''' % (prefix, ))
+
+def emit_suite(name, suite, prefix):
     executables = ' '.join(suite.executables)
     slow_test_numbers = ' '.join((str(x) for x in suite.slow_tests))
     test_numbers = ' '.join((str(x) for x in suite.tests))
-    print('.test.suite-quick.%s := %s' % (name, test_numbers))
-    print('.test.suite-slow.%s := $(.test.suite-quick.%s) %s' % (name, name, slow_test_numbers))
-    print('check-build: %s' % executables)
-    print('.PHONY: check-%s' % name)
-    print('.PHONY: check-report-%s.tap' % name)
-    print('check: check-%s' % name)
-    print('check-%s: all %s' % (name, executables))
-    print('\t$(call .test.human, $(.test.suite-$(SPEED).%s))' % (name, ))
-    print('check-report.tap: check-report-%s.tap' % name)
-    print('check-report-%s.tap: %s' % (name, executables))
-    print('\t$(call .test.tap, $(.test.suite-$(SPEED).%s))' % (name, ))
+    target = '%s-%s' % (prefix, name)
+    print('.test.quick.%s := %s' % (target, test_numbers))
+    print('.test.slow.%s := $(.test.quick.%s) %s' % (target, target, slow_test_numbers))
+    print('%s-build: %s' % (prefix, executables))
+    print('.PHONY: %s' % (target, ))
+    print('.PHONY: %s-report-%s.tap' % (prefix, name))
+    print('%s: run-tests' % (target, ))
+    print('ifneq ($(filter %s %s, $(MAKECMDGOALS)),)' % (target, prefix))
+    print('.tests += $(.test.$(SPEED).%s)' % (target, ))
+    print('endif')
+
+testsuites = defaultdict(Suite)
+for test in introspect:
+    process_tests(test, testsuites)
+emit_prolog(testsuites, 'check')
+for name, suite in testsuites.items():
+    emit_suite(name, suite, 'check')
+
+print('run-tests: $(patsubst %, run-test-%, $(.tests))')
-- 
2.26.2



