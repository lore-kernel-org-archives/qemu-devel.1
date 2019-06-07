Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B3EC28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72421208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1d2RMPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72421208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47638 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBWK-00078e-6A
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42217)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvT-0002Ft-Ct
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvR-00050K-1d
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:43 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004mk-M5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wr1-x432.google.com with SMTP id r18so1351590wrm.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/mgOWUVQfFqS8c2PmAMUGsA0PAuyGOHp1Inf8fc96Sk=;
 b=j1d2RMPMtwyfSlpxp7P3wjBaDONJs3e34kgogE6dwdbGCbef3q4rAfnvRSmVj69BMI
 +e6GxvTwpqSoWRyin6zvftQoPFfwHs4k3ahAI0LkbuwIpkDLuSTixDt2ZNw8TTUWj16e
 k8PMbxHuxMq4ppH5Qq45R0v/8KGYO7p2gl3bZ/kJqvyDNgefLE9tja5AgrAQ2SrDtPq8
 TGhgmQ0Lqyk6dI5zJG0THE4M2jyE/e6XB4IAG8v4y9fdhiIbOLMg6lcg31kqSt8dga2t
 y+M8GRdhbIBa3z+3DU9BGUO9skOcgJMrn9oj0KkT4Q46oXmiU8RhZs5EX5jYLBnR8k0T
 yXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/mgOWUVQfFqS8c2PmAMUGsA0PAuyGOHp1Inf8fc96Sk=;
 b=txelfEcLP0m0O95/S72VMLFhyrLr4jtB1WR1FuvpeWb00e9NIy5/0TT5ZoEU39jg8I
 sTeGvdOOzbEn8gDDuUL2xR3FXCwGtfctyS1c3ON9li9l0p+I6mlNNuOMIt0cGdwfpluc
 os/cR6sNisilSmc8hZRuXi60ltK0SwAXbakBcU2JGxovxICJb105e9YUizgaX/neIOIz
 EYTp66fO16wur44lJpvmvwh4ILocm/iNcDC4h5DFq+BYoNTEvjfIEZpl6S5WGeJ16jxn
 exMBuPdZ2XNMZHqpvxHOiM5egKb9hS1XD7lEhzMLISJjTHVSFUDG93migDsx0gxUMdBG
 JD7A==
X-Gm-Message-State: APjAAAWyhRE7owf9aZ+FWhxAIxVX9Sok+tQEcQDBZ5QSeA0hM62M9ewX
 6JqRL/Oqn1wWMk1pDnUhyLYH7Q==
X-Google-Smtp-Source: APXvYqxAcmyNwdQPMMw70mD9eafnRSjj0zh3ct8AXnziKdiFNtfCm6Tp4C+yF0CgnNN5MPnBpzQ11A==
X-Received: by 2002:adf:9267:: with SMTP id 94mr10741052wrj.338.1559898754163; 
 Fri, 07 Jun 2019 02:12:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x3sm1654450wrp.78.2019.06.07.02.12.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34CA01FF9E;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:14 +0100
Message-Id: <20190607090552.12434-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 15/52] tests/vm: use ssh with pty unconditionally
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
Message-Id: <20190520124716.30472-5-kraxel@redhat.com>
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


