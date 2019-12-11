Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724A9C00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434B521556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kV/jaE6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434B521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5j5-0000PJ-23
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WD-0003I9-Qp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WA-0003Cf-AN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:19 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5W9-00039J-5m
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:17 -0500
Received: by mail-wr1-x433.google.com with SMTP id t2so24916319wrr.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fd9ZwTx/nGTAxWisTrByxsrJjTVOwFrJUX5QQ3jkZWE=;
 b=kV/jaE6fFAGZMT3/aeJHFvXk1z6TUA52oVIFUnOUjRgXyAVlMwkBoKyuxbkp6nV7dM
 XmqSgKHml9CZUsj6VOmNo2Dy6odoffwnELEOQU8TUsAxsLE8vKalzC5pAk2AqnmxBZI6
 yXM2E1bBr7UhtLTSeGxT+FfRsZUcsHhf19uzr7HQfVqWXykVJ2M5vPL7Swn6CEPbhJb3
 L5KJTO3kg6+9HJBAq5nICGBTqz3n5dC9D6xI375ibDxK0NShHK4YHSMZD/4KpTbdjXN0
 DZrI1oD/IpHBr5QRaVpW+imSCssNGa6tv4QExPCmQK/nClFsw5oyRTW+8rM/aryj/8xC
 08/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fd9ZwTx/nGTAxWisTrByxsrJjTVOwFrJUX5QQ3jkZWE=;
 b=Pbjlz22FYiUHjWbaKpObulm9AyglaHxJowE6KWd+pDx1NMlEhory3OV4aAt30rK/Bd
 M+1foPatuz8UB1O8xFF0m26OMmT+ntQS3J0S7u0teAfc2dcnUy57x0vVsDNzd49/9krF
 4gjLdX5/xrbwHqoeAtHBj6+VYP+/NIQKlDCRWoxWNLc3vre9YL0qwoZhlTjmO2tBUgjc
 Ri5k1m+bWrHOH3h6WhVnRBJBmXlvYVEbA6lSG789Oe13ZztjI+bKs5pqpZsa+EPePten
 WszIv5jRYJp3gWjR1+Xs0WiGXlGc33dVO4bWCuyJjL58956Yjjio1jN37uGDjY8n5pzK
 uxfw==
X-Gm-Message-State: APjAAAWVQ/W6NN5bZW6wHOoBVGoIkMfsLKb4oiLDumpY6Mewix6tYGJB
 P/UHFXOiztyrotAdX3gc03zWNg==
X-Google-Smtp-Source: APXvYqyDE29TXeUNjufnIfM0DpsklG+p8mEZHSQJxH1pkC1JpRPUoYoi1aXEvbr5sajfOZz0CD4UHw==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr909433wru.52.1576084275417;
 Wed, 11 Dec 2019 09:11:15 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p26sm2955730wmc.24.2019.12.11.09.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:11:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9D3321FF9F;
 Wed, 11 Dec 2019 17:05:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 17/20] tests/guest-debug: add a simple test runner
Date: Wed, 11 Dec 2019 17:05:17 +0000
Message-Id: <20191211170520.7747-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test runners job is to start QEMU with guest debug enabled and
then spawn a gdb process running a test script that exercises the
functionality it wants to test.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100755 tests/guest-debug/run-test.py

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
new file mode 100755
index 00000000000..8c49ee2f225
--- /dev/null
+++ b/tests/guest-debug/run-test.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Run a gdbstub test case
+#
+# Copyright (c) 2019 Linaro
+#
+# Author: Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import argparse
+import subprocess
+import shutil
+import shlex
+
+def get_args():
+    parser = argparse.ArgumentParser(description="A gdbstub test runner")
+    parser.add_argument("--qemu", help="Qemu binary for test",
+                        required=True)
+    parser.add_argument("--qargs", help="Qemu arguments for test")
+    parser.add_argument("--binary", help="Binary to debug",
+                        required=True)
+    parser.add_argument("--test", help="GDB test script",
+                        required=True)
+    parser.add_argument("--gdb", help="The gdb binary to use", default=None)
+
+    return parser.parse_args()
+
+if __name__ == '__main__':
+    args = get_args()
+
+    # Search for a gdb we can use
+    if not args.gdb:
+        args.gdb = shutil.which("gdb-multiarch")
+    if not args.gdb:
+        args.gdb = shutil.which("gdb")
+    if not args.gdb:
+        print("We need gdb to run the test")
+        exit(-1)
+
+    # Launch QEMU with binary
+    if "system" in args.qemu:
+        cmd = "%s %s %s -s -S" % (args.qemu, args.qargs, args.binary)
+    else:
+        cmd = "%s %s -g 1234 %s" % (args.qemu, args.qargs, args.binary)
+
+    inferior = subprocess.Popen(shlex.split(cmd))
+
+    # Now launch gdb with our test and collect the result
+    gdb_cmd = "%s %s -ex 'target remote localhost:1234' -x %s" % (args.gdb, args.binary, args.test)
+
+    result = subprocess.call(gdb_cmd, shell=True);
+
+    exit(result)
-- 
2.20.1


