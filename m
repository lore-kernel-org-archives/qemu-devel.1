Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1219C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:09:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A351C2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zt487m8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A351C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEYr-0002zt-Pa
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERH-0006JB-B9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERG-0003CS-H4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:39 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUERF-0003Bw-Ql
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:38 -0400
Received: by mail-wm1-x342.google.com with SMTP id z6so3317976wml.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vsRaPQgPWjspWGA09bn/H8qfGOOUy5/7Otme35R+WfU=;
 b=Zt487m8K8k279WZYkb87i8qKd6jadZ01ztkCPB2S+NRLtBdNGqrmwgb+Z4TDg/1QTV
 E0ILckzz/5dYesbKlFoE4PlEifErWm1CJV0cLdE+LZ4OytoYuuHTwBOy55vO/n1wBY8+
 +A4Vg5ec15a6u/SqiUOjQFRga1XfTzRKBcAWo/dM1lgjFZk1HZ9EXBVoNOoF11dtIVNQ
 hUK3g4jfksJwfKpBrgWQfLjTE41oHwM49N7f+7U+pTBSRVOuymLIWOyoXN5f02UPLZws
 Uq9KCJlYWoOIPJIicGOhMh+zJYYR7EaiTk5jxkv5JzZ5vBEijNXLfe6foYfaTXXPBEV5
 8maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vsRaPQgPWjspWGA09bn/H8qfGOOUy5/7Otme35R+WfU=;
 b=EemATmeI9D636DInmJcgrL5SMHjo0ndZgpQgdQcgzi7G+x3+v1ezRx0InHXvrIyxFv
 njoW1ic4DNE4QoKS8tDb23PULCZG7cim6kwSPFPZJj/1mkJVYRc8QzbsnP2IaJ99n0Wb
 W7jd1r32/DaT9RdrmXdQWJovIsbK2zdvLitPsZ1k5PzTGW/9gIbW001r+Yi06djiA5Oj
 GG7P8oUa3O1Sefv/nTvTN8I7S5fVZLzqJHTGdod9G9I+xSZF+VZD+vv50vrXUTMjTqqI
 UUDW0JHGRHXlbSTuQd6iokfVweosfOejJ50mw6oTka37dTMCiT6/rufVRhq1njUlL4jU
 PrtQ==
X-Gm-Message-State: AGi0PuZuACnONS5m9aqAfX2sntEl96womxpZQSgIwcfABGkMRLAUnQW5
 AQbN2z2NJYvhfqPCzL5QAamb4HKpwHg=
X-Google-Smtp-Source: APiQypLVJBOaklwhLZ8meiZ4uTPoSRuyAVg31tC9c2CV9c7IlGWUz1sM0iyRpg2TKyJVJeHqbOv5kQ==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr4672434wma.165.1588273296373; 
 Thu, 30 Apr 2020 12:01:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u3sm808638wrt.93.2020.04.30.12.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:01:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 466821FF93;
 Thu, 30 Apr 2020 20:01:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 7/9] tests/guest-debug: use the unix socket for linux-user
 tests
Date: Thu, 30 Apr 2020 20:01:20 +0100
Message-Id: <20200430190122.4592-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430190122.4592-1-alex.bennee@linaro.org>
References: <20200430190122.4592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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
 tests/guest-debug/run-test.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 2bbb8fbaa3..d9af9573b9 100755
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
@@ -41,11 +43,15 @@ if __name__ == '__main__':
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
+        cmd = "%s %s -g %s %s" % (args.qemu, args.qargs, socket_name,
+                                  args.binary)
 
     inferior = subprocess.Popen(shlex.split(cmd))
 
@@ -56,7 +62,10 @@ if __name__ == '__main__':
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


