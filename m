Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468BBECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15BC420872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTi6my3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BC420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9Zk-0000GI-UE
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91F-0001Dv-14
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91D-0006dT-Rz
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:52:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iL91D-0006dF-Ly; Thu, 17 Oct 2019 12:52:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id p14so3179498wro.4;
 Thu, 17 Oct 2019 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OkDO1VIo+NhoE89bty8RovMaMRgboGY/bTEV8ryUKfQ=;
 b=QTi6my3ki+JBZBovHcw7Vn13vrwE1556oa6dcixHUpB2dqdY8dVZQweEzDzqvAIXSB
 2hiiM7UB5vWmURwWOfbUPKNcoxq9mwqECpUH3diLSRLETELH1hf3uL9ejy5zcb9Hx7B3
 ac69AqNq4CkEwuqCeBiRJSXgRj1+x0R7bAXdblS0D+0KyEIpqCVUjT8W0deSsl3AQIKp
 neCQNpjOjDGAD0tEgviqX+OYeXPlvQludFhaMF+kDeftaiZHpq/sSJsOeyxnSMb1nbHT
 VFtBQJZFwx/RRkzYXoDO+XGKIgBJcvLubTMdgs+x7xSO+8/6jOEcn3cfIjHtG6GEEuKt
 C8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OkDO1VIo+NhoE89bty8RovMaMRgboGY/bTEV8ryUKfQ=;
 b=qFSRatyo+Mpym1sAXHrRCFDKwvLjxgjRHOUy/ylnjYy5HeeoGEQLSI9aO4vD9a7Ys2
 GD2G8j37fMbHFv22mUPgIVWdTfh4aUv04XgBe6IcajEb46GFTu3BzJty5nMODrglLbyN
 bRRRhNn7+cqnGMsDyhi3TCB9XodBM+aK9JkFbXXrE/4/51bB8hJLh96otexIUrvLLBpn
 8opiJlNgwxQo1oE/LnYVs/JipdGl6SQIfXekwPrS8hJTZ3CPW7blVxRoSuxbGnVp/7Qc
 e53OUnylPVjawM1cw4TQIGAXLtlFR/RzHq6Y2txOUcG9/vdfNU1sLhCXo04Bb2ZOirTN
 aAHQ==
X-Gm-Message-State: APjAAAXeB5MbhPy7Jk2fOnwKnBEW3H2qe4qkGqnCKdB2PYIjl+s4sXii
 wVi6hEZnGNQ7KbCpEVQkCpkS9SYFwUM=
X-Google-Smtp-Source: APXvYqy6JjWwyZeMYa52ZZuvrWR9XNseuTfd6oKcMnMo94utkrpiPbj2J1LDfQeDrkcza67Pgxxgkw==
X-Received: by 2002:adf:f010:: with SMTP id j16mr3990190wro.317.1571331174423; 
 Thu, 17 Oct 2019 09:52:54 -0700 (PDT)
Received: from x1w.redhat.com (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id w22sm2557363wmc.16.2019.10.17.09.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:52:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] tests/acceptance: Refactor
 exec_command_and_wait_for_pattern()
Date: Thu, 17 Oct 2019 18:52:34 +0200
Message-Id: <20191017165239.30159-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017165239.30159-1-f4bug@amsat.org>
References: <20191017165239.30159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The same utility method is already present in two different test
files, so let's consolidate it into a single utility function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++++++++
 tests/acceptance/boot_linux_console.py    | 12 ++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 39f72945cd..4d7d6b640a 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -80,6 +80,25 @@ def wait_for_console_pattern(test, success_message,
             test.fail(fail)
 
 
+def exec_command_and_wait_for_pattern(test, command,
+                                      success_message, failure_message):
+    """
+    Send a command to a console (appending CRLF characters), then wait
+    for success_message to appear on the console, while logging the.
+    content. Mark the test as failed if failure_message is found instead.
+
+    :param test: an Avocado test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`avocado_qemu.Test`
+    :param command: the command to send
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    command += '\r\n'
+    self.vm.console_socket.sendall(command.encode())
+    wait_for_console_pattern(self, success_message)
+
+
 class Test(avocado.Test):
     def setUp(self):
         self._vms = {}
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index bf9861296a..cc4d9be625 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -14,6 +14,7 @@ import gzip
 import shutil
 
 from avocado_qemu import Test
+from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
@@ -29,11 +30,6 @@ class BootLinuxConsole(Test):
 
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    def exec_command_and_wait_for_pattern(self, command, success_message):
-        command += '\r\n'
-        self.vm.console_socket.sendall(command.encode())
-        wait_for_console_pattern(self, success_message)
-
     def extract_from_deb(self, deb, path):
         """
         Extracts a file from a deb package into the test workdir
@@ -162,11 +158,11 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         wait_for_console_pattern(self, 'Boot successful.')
 
-        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                'BogoMIPS')
-        self.exec_command_and_wait_for_pattern('uname -a',
+        exec_command_and_wait_for_pattern(self, 'uname -a',
                                                'Debian')
-        self.exec_command_and_wait_for_pattern('reboot',
+        exec_command_and_wait_for_pattern(self, 'reboot',
                                                'reboot: Restarting system')
 
     def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
-- 
2.21.0


