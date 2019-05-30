Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49D8C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15FB25758
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMhGNvsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15FB25758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50949 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIPA-0000rj-QX
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:35:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6g-0002jI-5c
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWI6f-0006dY-6O
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:22 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWI6e-0006ct-VY
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:16:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id w13so3790631wru.11
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=9J8E5pdedqRlrr8v2PQK1sYVyobiXRzGN2v10P6ZPKk=;
	b=tMhGNvsXWK1d8mDUvvdqV7C9zC2/n+/THau0y1371lKEvNRNUKDZUQ9Cy6q6uSZWKj
	FVByZuJI+k8nOrf4FKdJNo/EyKYe6cEq2n3IxVL+an7Xm2/XiL1P1crZWLRi00Y5ALyT
	YGV7zudJQnKsGm1UTeY/vTNo4vS6yjdvtaEhU3miGYxqjF591oU/ZJOsxOsglfUgsAT2
	zD86++d3933l0kQQbth+3eJu2ciEiK0DOXZSkUwiP9gF0b6YITdfb5LDbL9cNxefD3B1
	LeDt2h6ZKgafBJR7oinzDcEhX9cejKyWtlnnpYVFNh8+zKwJhMgOigVK+6UMvMNpyqs2
	7oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9J8E5pdedqRlrr8v2PQK1sYVyobiXRzGN2v10P6ZPKk=;
	b=tqHgcfXcWrDZf2I1MWMkuqMlyfvzfT3Qqsfoks+jswxS665ljsLM6ZKuyxxbRZLy2H
	Q6uOMT9IMzlVR9aWYfeSxMQCQPLMmqcsiLnSVR+B/Rtd1Vie4/KKoqNDPxqVPncA0UWH
	RohbBrMQ9bLMHksI+PKKL5k/7VepWq+Sa1MnhLH5AhNSOcMGwjQIt3OTTp+7Ce1pZtty
	E/4ExAzyiPiEWUqo3QiabTIC12gQk5k/B5AZB897FEuKyHjrbhKzhDY9E96vtBF+jLMb
	oLA2fgYXg3UopHYd++n6uOt1fxyjagU5UQutHycPnxCVBwap+cvox5iL/kme1kfA37Ix
	XBtg==
X-Gm-Message-State: APjAAAXPaIZCJVLHuWrg5uA0W0oMqYbIzsVoEQY09WY40A+cV1zTEI7G
	bx/bwECL7wsPSMCfsFy2NYZLJDeqAGM=
X-Google-Smtp-Source: APXvYqzjUiVGwtR65OWMLZfXyQsukgAjM//aQXBTnaXw6SiRdYXtnASARs3JV9AaNGQpL+I3sVxmiQ==
X-Received: by 2002:a5d:638a:: with SMTP id p10mr2048522wru.273.1559211379486; 
	Thu, 30 May 2019 03:16:19 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 32sm5445495wra.35.2019.05.30.03.16.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 30 May 2019 03:16:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 5FEA81FFA3;
	Thu, 30 May 2019 11:16:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:15:53 +0100
Message-Id: <20190530101603.22254-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530101603.22254-1-alex.bennee@linaro.org>
References: <20190530101603.22254-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v1 16/26] tests/vm: use ssh with pty
 unconditionally
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Allways ask ssh to run with a pseudo terminal.
Not having a terminal causes problems now and then.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190520124716.30472-5-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5e30bac6615..395eefaec94 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -107,16 +107,14 @@ class BaseVM(object):
         os.rename(fname + ".download", fname)
         return fname
 
-    def _ssh_do(self, user, cmd, check, interactive=False):
-        ssh_cmd = ["ssh", "-q",
+    def _ssh_do(self, user, cmd, check):
+        ssh_cmd = ["ssh", "-q", "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
         for var in self.envvars:
             ssh_cmd += ['-o', "SendEnv=%s" % var ]
-        if interactive:
-            ssh_cmd += ['-t']
         assert not isinstance(cmd, str)
         ssh_cmd += ["%s@127.0.0.1" % user] + list(cmd)
         logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
@@ -128,9 +126,6 @@ class BaseVM(object):
     def ssh(self, *cmd):
         return self._ssh_do(self.GUEST_USER, cmd, False)
 
-    def ssh_interactive(self, *cmd):
-        return self._ssh_do(self.GUEST_USER, cmd, False, True)
-
     def ssh_root(self, *cmd):
         return self._ssh_do("root", cmd, False)
 
@@ -284,9 +279,9 @@ def main(vmcls):
         return 2
 
     if args.interactive:
-        if vm.ssh_interactive(*cmd) == 0:
+        if vm.ssh(*cmd) == 0:
             return 0
-        vm.ssh_interactive()
+        vm.ssh()
         return 3
     else:
         if vm.ssh(*cmd) != 0:
-- 
2.20.1


