Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62150C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21971206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd4ijWyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21971206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIsj-0007cJ-6B
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIoA-0006OE-JY
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:56021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo8-0001AS-V5
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id e26so2291608wmk.5
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=To1Amsuya8/2bNrwNOCG3a0ICGx1JiOCuX19yjy7Jus=;
 b=jd4ijWydmt2SVD8mmixo09H/irXxNi7pM1YtA+gCa4YR7FPhWDky+spPeQ7hD7DM1v
 G4T9/0rBu3NnfW5ppt05zcgTIDo0TTciWizHFsOWSsTgUtIYAS6jgaXB6d3fLPv2/kWS
 jHTLIRJdz7Y1Wad9EX67LesLfCLjeyvNNomS6L/UeJSN3AHPEuo4wHvJbRVAu1fC2dU9
 8vypFbxH3efYWZzw66ugsYRddMz+CqjEUJxXIPkDgLI8302kgrfDUkQ6qYTK1QmLifPx
 8WupfYSmOHgJsCN2HTDQRLHXKSHtwKPSIPIOzIZD1PZ0oyTM6+5xeWLz9t/chM6QuTuM
 b8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=To1Amsuya8/2bNrwNOCG3a0ICGx1JiOCuX19yjy7Jus=;
 b=hYDEVVFNPwFjcanfmjj2zvRpQsA7ST0JDiBt38fnPkLdFkVg2fA+CWMwIX/UyLnjkT
 xBu0ZLzVgiLYFUJO2+0lYWvlBruyQuzJmJnQn8eaGB6eOF1Zqv2qfNCeIcRT7DfIQEyh
 DJz8U7QmXt0GHho9WV41dSnyyv39M9CN30vrZVpT9MynsjuzDjFZPQBRMnM5qtZsWlfL
 vNIepr/gxb1cyTFJ4tcjYFromXn3Oy/2jYGGeSFb4FCFnSPH+7EC49kEEbPUh3qlrIEJ
 GPQcfzdv2f4dLiuC1SGu1Dp0gbJ9brZBSflNIjsMxEJllXwh+bZ5shBNlnIB6ouGr+rl
 3Rog==
X-Gm-Message-State: AGi0PuZUuf/c6Xgfg/Af6KF/1JGEEygztHCkfjWawOvJ0F+DQo5cQ7BW
 1OfeDO8M+9QcwKAUuOMDhLiyPA==
X-Google-Smtp-Source: APiQypIMU0I8bT2uNzbVDK+pHBqkm1wp5JZwCUwx5/YpHRBiXpTl6pckbWQLYjfzXA9YoAWmhpTMFA==
X-Received: by 2002:a1c:4956:: with SMTP id w83mr4022950wma.43.1588766746737; 
 Wed, 06 May 2020 05:05:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h74sm1839374wrh.76.2020.05.06.05.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C3CC41FF9B;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/14] tests/guest-debug: use the unix socket for linux-user
 tests
Date: Wed,  6 May 2020 13:05:27 +0100
Message-Id: <20200506120529.18974-13-alex.bennee@linaro.org>
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have support for debugging over a unix socket for linux-user
lets use it in our test harness.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200430190122.4592-8-alex.bennee@linaro.org>

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index 2bbb8fbaa38..d9af9573b9e 100755
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


