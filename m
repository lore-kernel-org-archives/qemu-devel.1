Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C18C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46C152468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fan+f77n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C152468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istc6-0001id-V5
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ista9-0008R9-LW
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ista8-0001PO-EF
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:29 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ista8-0001OT-8c; Sat, 18 Jan 2020 14:16:28 -0500
Received: by mail-wm1-x341.google.com with SMTP id d139so11824595wmd.0;
 Sat, 18 Jan 2020 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K+cZ6I/QpgXaxA05OKDA44Z96Grs/O31aTUTE91bprM=;
 b=Fan+f77nzTO2u4vl+CbNzzt6b8TfqkQkLOn49CElsLYfX3g0Q1D3GL4hkCgBsKJCz+
 dKRXP570N+OmEUOlOoSitVlsdwPBk2HYxUrFa+KoNk8nA3SOTeSPmW7osXYopPja2fXr
 pM48WxWwKWrSL+1juokIsR5GZNkzfRdcrpb84mGE1sC3U5GA0fJOCd2iai6/g0d9LhKS
 skbX9QCHPcJ9bkuO4EdC+lCZS2M/2+mRQQn+vtBkOf87AOSo7Y1Gza4VNnyCvFJR7qss
 hFlc44tlIND9u7J4xBqL5ZJRbI1pFxzWnyDrQA9MaISV3vLMI+fmDXFBzWQ/3pUUuhXX
 k+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=K+cZ6I/QpgXaxA05OKDA44Z96Grs/O31aTUTE91bprM=;
 b=r08w7Iam2wnTyt8gbMNfWNy0TteQg/WJDihq60Ilz0gEDQC7bvRYNIcpHn8FWuinh0
 LxPTV7Z+TM1AW/JWYjrQNpi8fbA2A6FT9xgTKD91j7x4Fpd8wpq76M7CzBfXfN91q7Es
 K5gna/qbRtL8xB+b2U1JCH3rMxQcOcQC+OJFOpU+gffczNNPLIyAGhpt9umo/Bh+RtxH
 cnI8mMopQhxqUmO33/1ewes/jifYuPESdS40xlOUKVtInDqvdKLjb56Q+8+2ocSsWGxZ
 hcHz+1Wg+RXZHzlYFCnLFiqfHkLUoG923YMaAL7gf8y8PTUnR7rcM1Qja/iROYoe2coC
 rI2w==
X-Gm-Message-State: APjAAAVLAF4FZGRZy6Wwg3ggt7nC8CydkT2St2NcwLE3G85uE7qbqZaL
 S53haNMWCm6zB3QKrPqk91YC09di
X-Google-Smtp-Source: APXvYqyoSRprmjZR7Gibuqtr+8P7ZS5CeGu8n/nSb06P6XoKX20MrnbivQMxnNp5PJMm4dhIkEK2HQ==
X-Received: by 2002:a05:600c:2959:: with SMTP id
 n25mr7665791wmd.185.1579374987022; 
 Sat, 18 Jan 2020 11:16:27 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z11sm41339690wrt.82.2020.01.18.11.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 11:16:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 1/4] Acceptance tests: Extract _console_interaction()
Date: Sat, 18 Jan 2020 20:16:20 +0100
Message-Id: <20200118191623.32549-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200118191623.32549-1-f4bug@amsat.org>
References: <20200118191623.32549-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we are going to re-use the code shared between
wait_for_console_pattern() and exec_command_and_wait_for_pattern(),
extract the common part into a local function.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/avocado_qemu/__init__.py | 31 +++++++++++++----------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 6618ea67c1..0a50fcf2be 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -55,19 +55,14 @@ def pick_default_qemu_bin(arch=None):
         return qemu_bin_from_src_dir_path
 
 
-def wait_for_console_pattern(test, success_message, failure_message=None):
-    """
-    Waits for messages to appear on the console, while logging the content
-
-    :param test: an Avocado test containing a VM that will have its console
-                 read and probed for a success or failure message
-    :type test: :class:`avocado_qemu.Test`
-    :param success_message: if this message appears, test succeeds
-    :param failure_message: if this message appears, test fails
-    """
+def _console_interaction(test, success_message, failure_message,
+                         send_string):
     console = test.vm.console_socket.makefile()
     console_logger = logging.getLogger('console')
     while True:
+        if send_string:
+            test.vm.console_socket.sendall(send_string.encode())
+            send_string = None # send only once
         msg = console.readline().strip()
         if not msg:
             continue
@@ -79,6 +74,17 @@ def wait_for_console_pattern(test, success_message, failure_message=None):
             fail = 'Failure message found in console: %s' % failure_message
             test.fail(fail)
 
+def wait_for_console_pattern(test, success_message, failure_message=None):
+    """
+    Waits for messages to appear on the console, while logging the content
+
+    :param test: an Avocado test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`avocado_qemu.Test`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    """
+    _console_interaction(test, success_message, failure_message, None)
 
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=None):
@@ -94,10 +100,7 @@ def exec_command_and_wait_for_pattern(test, command,
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
-    command += '\r'
-    test.vm.console_socket.sendall(command.encode())
-    wait_for_console_pattern(test, success_message, failure_message)
-
+    _console_interaction(test, success_message, failure_message, command + '\r')
 
 class Test(avocado.Test):
     def _get_unique_tag_val(self, tag_name):
-- 
2.21.1


