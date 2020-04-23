Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D491C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAB212076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYg220OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB212076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRfPJ-0008OM-1d
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 13:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIm-0001JC-F4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jRfIl-0005bo-Sp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jRfIl-0005bB-F1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 13:06:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id j1so7717940wrt.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y8OzSKmIFiuLHfxz8DEOePw2xLZ8ATDtg6VRRYMl4sc=;
 b=wYg220OTNpfgoYnWxxgyBCi5xOG4qmF9wbC9NzmnwLUZT6drZM0KuvZFIXnmpccHmb
 vauj8E/R7uYV7LmV1unP4OdVwij3vZ5S7QIYsR/L/3/zDgV3WI1ziUeJ7nR3rYxmKrK+
 qrgcB0AG0i/LJXScpR8lrmJRU77k253bf9eCKeWLhFhMFCaVl/dY9S9eyBBRqWNT7b2X
 H/nIgeJQ6Ooxva0ZoHX2dSAlJgthdW69OsmrCPb+6DEwYblUGei0bx2bpzb560Bld5da
 PnWdjFU8rJogvgtaqgWG9jH6Sv34ClIRVN96b9JGs4MV0Gy+gbMlWoUh1ROq/idW+zhQ
 HN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y8OzSKmIFiuLHfxz8DEOePw2xLZ8ATDtg6VRRYMl4sc=;
 b=F2k4V74Bu8vQynmfKHFOiHWQJeCKNO+nO+luudFBnMV2TOqVHxhWrrWfEBbfzibCOA
 tkGyel2bTSM5hqFFIdVXl66DMiXU+iY2avNUpaFM1Rp2TcRwwTSRvfPEJ0cRbcGo4Qi5
 C2OxFYbjCTWLtlUnGvgZ+yOHsNbA/QA92YuYGy39K+CBXKsb9p01ljLswJomNybajxnI
 jvDws7XcPQVH0dvEwAXvIsSZgqbRO7poKFK9q9Ue7BPHdk89Orkd2dIWYdpdHNtbvwGf
 E+c46ZaTEU9bPoZqZWE/QSJUYvHoPyVos+QmruPuCmwnVgTrupYCTzVhLouS9ALJcC4z
 WnHQ==
X-Gm-Message-State: AGi0PuaKzpr/H6NC978hUYMKASPjAXB9diAam1HQvtKyX7JP8TDHhmMg
 vTTb0HyU67s3k3iECuAQr206U4hhIOo=
X-Google-Smtp-Source: APiQypKpwqYtEdvaUVtZXKfPlyrJhRoOJEtsIJAPgXLz959wnpgEkhNH0DA3cHxZOCMbs17WI9daaQ==
X-Received: by 2002:a5d:4b43:: with SMTP id w3mr6095741wrs.208.1587661573681; 
 Thu, 23 Apr 2020 10:06:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b2sm5216121wrn.6.2020.04.23.10.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 10:06:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4EC961FF9A;
 Thu, 23 Apr 2020 18:05:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/14] tests/guest-debug: use the unix socket for
 linux-user tests
Date: Thu, 23 Apr 2020 18:05:54 +0100
Message-Id: <20200423170557.31106-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
References: <20200423170557.31106-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

Now we have support for debugging over a unix socket for linux-user
lets use it in our test harness.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 2bbb8fbaa3..2441a1d623 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -15,6 +15,8 @@ import argparse
 import subprocess
 import shutil
 import shlex
+import os
+from tempfile import TemporaryDirectory
 
 def get_args():
     parser = argparse.ArgumentParser(description="A gdbstub test runner")
@@ -41,11 +43,14 @@ if __name__ == '__main__':
         print("We need gdb to run the test")
         exit(-1)
 
+    socket_dir = TemporaryDirectory("qemu-gdbstub")
+    socket_name = os.path.join(socket_dir.name, "gdbstub.socket")
+
     # Launch QEMU with binary
     if "system" in args.qemu:
         cmd = "%s %s %s -s -S" % (args.qemu, args.qargs, args.binary)
     else:
-        cmd = "%s %s -g 1234 %s" % (args.qemu, args.qargs, args.binary)
+        cmd = "%s %s -g %s %s" % (args.qemu, args.qargs, socket_name, args.binary)
 
     inferior = subprocess.Popen(shlex.split(cmd))
 
@@ -56,7 +61,10 @@ if __name__ == '__main__':
     # disable prompts in case of crash
     gdb_cmd += " -ex 'set confirm off'"
     # connect to remote
-    gdb_cmd += " -ex 'target remote localhost:1234'"
+    if "system" in args.qemu:
+        gdb_cmd += " -ex 'target remote localhost:1234'"
+    else:
+        gdb_cmd += " -ex 'target remote %s'" % (socket_name)
     # finally the test script itself
     gdb_cmd += " -x %s" % (args.test)
 
-- 
2.20.1


