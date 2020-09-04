Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0319C28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B01F2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B01F2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEA7U-0001bn-M8
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA63-00089x-Ok
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA5x-0005B1-K9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:41:35 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-zvPwHASjMVSUXDDPK10Hlw-1; Fri, 04 Sep 2020 07:41:27 -0400
X-MC-Unique: zvPwHASjMVSUXDDPK10Hlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07D6685EE95
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C12C85D9F7
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/46] mtest2make: hide output of successful tests
Date: Fri,  4 Sep 2020 07:40:42 -0400
Message-Id: <20200904114122.31307-7-pbonzini@redhat.com>
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

The softfloat tests are quite noisy; before the Meson conversion
they buffered the output in a file and emitted the output only
if the test failed.  Tweak mtest2make.py so that the courtesy
is extended to all non-TAP tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py  |  2 +-
 scripts/test-driver.py | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 scripts/test-driver.py

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index c709b37f28..27425080cf 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -21,7 +21,7 @@ SPEED = quick
 
 # $1 = environment, $2 = test command, $3 = test name, $4 = dir
 .test-human-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only)
-.test-human-exitcode = $1 $(if $4,(cd $4 && $2),$2) < /dev/null
+.test-human-exitcode = $1 $(PYTHON) scripts/test-driver.py $(if $4,-C$4) $(if $(V),--verbose) -- $2 < /dev/null
 .test-tap-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $3/" || true
 .test-tap-exitcode = printf "%s\\n" 1..1 "`$1 $(if $4,(cd $4 && $2),$2) < /dev/null > /dev/null || echo "not "`ok 1 $3"
 .test.print = echo $(if $(V),'$1 $2','Running test $3') >&3
diff --git a/scripts/test-driver.py b/scripts/test-driver.py
new file mode 100644
index 0000000000..eef74b29a8
--- /dev/null
+++ b/scripts/test-driver.py
@@ -0,0 +1,35 @@
+#! /usr/bin/env python3
+
+# Wrapper for tests that hides the output if they succeed.
+# Used by "make check"
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# Author: Paolo Bonzini <pbonzini@redhat.com>
+
+import subprocess
+import sys
+import os
+import argparse
+
+parser = argparse.ArgumentParser(description='Test driver for QEMU')
+parser.add_argument('-C', metavar='DIR', dest='dir', default='.',
+                    help='change to DIR before doing anything else')
+parser.add_argument('-v', '--verbose', dest='verbose', action='store_true',
+                    help='be more verbose')
+parser.add_argument('test_args', nargs=argparse.REMAINDER)
+
+args = parser.parse_args()
+os.chdir(args.dir)
+
+test_args = args.test_args
+if test_args[0] == '--':
+    test_args = test_args[1:]
+
+if args.verbose:
+    result = subprocess.run(test_args, stdout=None, stderr=None)
+else:
+    result = subprocess.run(test_args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
+    if result.returncode:
+        sys.stdout.buffer.write(result.stdout)
+sys.exit(result.returncode)
-- 
2.26.2



