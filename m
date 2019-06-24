Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D1C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34E12133F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+gFRtDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34E12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPLk-0000JO-2t
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41434)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGC-0006ac-Ij
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGA-0007XZ-JK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:52 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPG6-0007NP-OB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id s15so13429318wmj.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=INLzBrnOdVpVaX735jR9Ql7IOiOc8rJWuc+qFiZ4wMM=;
 b=w+gFRtDHcBs4MeHAgFdm7/Q0W6J8DVe7h0IihpVSwDry2bm0ZDph9Mwr/57vjLqinJ
 79gqC8ZVTWXl/y+N6bPt29fwP8uEfU8jVeaaPqxQCA5oCxsRFRfCFFieZZ4Yqv7jZp4B
 tj8mA3BrjR9dVY7S6vssL3CxTzL8Gjc5pOvvmwkb0rgXjLw86+CT0GH/qg1RE102xp+m
 HIMoPlQmtgWJK2uiVu5Yhser7X4b8/yiWDeoOoeyA3H00vqg7U0fS6kBFeXFHCIE017d
 +G5xqP9HvjBJFyCUuUbnn1QhzwtorKfz3++GhRv1gImjRqwccC6m6QQSwhdid9zIEYyL
 hCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=INLzBrnOdVpVaX735jR9Ql7IOiOc8rJWuc+qFiZ4wMM=;
 b=TV0T3Mm7VI0Uweg2Z6ygZh033BPy2roBE3NsdrvdF28Ea09Cfe9sePfwvY1iHBSFdo
 x/5YNysu0TFN7E5gzefXNt4AllGhgbxMgOhoAOR+VKu9W2Cxmu25TdYmmlFYv8hSFCWN
 SgWHzmtsFB/BuJzaHAdmARsoNjnLfjSmv1grvLTrGtonHTMZ3bUNttZXW1wzLyOvnwTC
 ZeOrQHosfqTiLKzfIYsn+VN9U1/omox+m/kbhM3sMxCd4Wpsprys08KruiN0HeIMehUd
 xCFebbtODBBwGs4FNP1JNNOp0BdFyCr7NLvTHMKuYMMdeJoMgN3nm63jYdfc0Upcg2Dc
 38yA==
X-Gm-Message-State: APjAAAW0byZCrcPDzBskyE03VJXZyQx3Cdn6xClCrWTXenNilliCqnhe
 q69jkPt2BN/lzoQF7dZIUb4wXw==
X-Google-Smtp-Source: APXvYqw1Pv/fO7fw8xSRQpHWa4REIbOC1voPCqmg4wybZQLfTBY5tEDaNCOL6UB8YOYssPM2oMiQmg==
X-Received: by 2002:a1c:b146:: with SMTP id a67mr15829427wmf.124.1561383822192; 
 Mon, 24 Jun 2019 06:43:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p3sm8196123wrd.47.2019.06.24.06.43.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:39 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A2AE1FF93;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:24 +0100
Message-Id: <20190624134337.10532-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 06/19] tests/vm: use ssh with pty unconditionally
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
Message-Id: <20190617043858.8290-3-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5e30bac661..395eefaec9 100755
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


