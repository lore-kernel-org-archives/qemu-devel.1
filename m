Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C892C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298672468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fopJ2RMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298672468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istc9-0001lq-R8
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1istaA-0008RF-W4
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ista9-0001Qi-TH
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:16:30 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:43218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ista9-0001Px-NW; Sat, 18 Jan 2020 14:16:29 -0500
Received: by mail-wr1-x430.google.com with SMTP id d16so25731856wre.10;
 Sat, 18 Jan 2020 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vxrD2JWpr3rTdsCECp/XxWuqHq2ybHJ1OCxK1G7l1i0=;
 b=fopJ2RMd4xZA+wdP2LQ0A4+gSyiffnivy43ZXTloTRSgdIKG59gtwW06QiwMtnlUmq
 cI9AZv7GZfDVKSs/7JgKvLpto0dkmPiPt9WOgL96gkiPnqpfK26W7Z09iHExhvsOWZ4T
 umOli1/tHHIJ9DuaQOopk8gDkXOWm/7iIDM1AydGmrSg4lltm5HPsF7Zowwdr4hQ4AW2
 cVfOwhsGBNcbqZMExllNs9qnD5yNcsl1/Zt8MXQFJz4aEbDCib4r1M60ctiIVZwRN3xJ
 W7tCydiv/Mjc98ErcKn6WMt9ixC3zbUIU2WxvajPpgAq02cbHhXhncD73wXMP1V/ldGx
 +Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vxrD2JWpr3rTdsCECp/XxWuqHq2ybHJ1OCxK1G7l1i0=;
 b=OVN7TUqEdhLUOnJ/X+XxTQzWLVpM3Hbgg+lGkcv+t3BNA73RVKmlperO8yC1CnRRPL
 GP3PsBZ5tsh1P0kbS2fBc0zb59ms4tlHLln6tKdfM5Z5/xv9ccYwparsgZez8EKya9DB
 HdnzLYA9WKDbqPRHsZlONnQ2uQKUeqwqkfJ5UM7/rlT/bnPHuhjPV9Rwxaqzr5oo23rr
 WbsAe50ZzQKjUPjLndlKhBxrMrWOS1f7yrHMizGeerSQB+27+1b3uf+RIcJtUoS+YfIc
 nQWBq9NAIm04CCyWv+/xMkcb9AWbMLwv5nqVCyWYhagjlggdTzUs8H0s/8pcmbsSbiIm
 lcQw==
X-Gm-Message-State: APjAAAW5WQzh+FKr2CIcY2hNIHAWkApIE/7ID4FqwwImwr2FQSnD1uYz
 v9ASTFwJyIf2w84Lsym1JD0rysz9
X-Google-Smtp-Source: APXvYqzgr85uVMKa56MUfTDgG9FJNJZKYbzwpuDOJELm6p0HEiDkFNMbN3UF3NCanvB0u52zzNYASQ==
X-Received: by 2002:adf:f244:: with SMTP id b4mr9448075wrp.88.1579374988476;
 Sat, 18 Jan 2020 11:16:28 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z11sm41339690wrt.82.2020.01.18.11.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 11:16:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 2/4] Acceptance tests: Add
 interrupt_interactive_console_until_pattern()
Date: Sat, 18 Jan 2020 20:16:21 +0100
Message-Id: <20200118191623.32549-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200118191623.32549-1-f4bug@amsat.org>
References: <20200118191623.32549-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

We need a function to interrupt interactive consoles.

Example: Interrupt U-Boot to set different environment values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/avocado_qemu/__init__.py | 32 +++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 0a50fcf2be..d4358eb431 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -56,13 +56,15 @@ def pick_default_qemu_bin(arch=None):
 
 
 def _console_interaction(test, success_message, failure_message,
-                         send_string):
+                         send_string, keep_sending=False):
+    assert not keep_sending or send_string
     console = test.vm.console_socket.makefile()
     console_logger = logging.getLogger('console')
     while True:
         if send_string:
             test.vm.console_socket.sendall(send_string.encode())
-            send_string = None # send only once
+            if not keep_sending:
+                send_string = None # send only once
         msg = console.readline().strip()
         if not msg:
             continue
@@ -74,6 +76,32 @@ def _console_interaction(test, success_message, failure_message,
             fail = 'Failure message found in console: %s' % failure_message
             test.fail(fail)
 
+def interrupt_interactive_console_until_pattern(test, success_message,
+                                                failure_message=None,
+                                                interrupt_string='\r'):
+    """
+    Keep sending a string to interrupt a console prompt, while logging the
+    console output. Typical use case is to break a boot loader prompt, such:
+
+        Press a key within 5 seconds to interrupt boot process.
+        5
+        4
+        3
+        2
+        1
+        Booting default image...
+
+    :param test: an Avocado test containing a VM that will have its console
+                 read and probed for a success or failure message
+    :type test: :class:`avocado_qemu.Test`
+    :param success_message: if this message appears, test succeeds
+    :param failure_message: if this message appears, test fails
+    :param interrupt_string: a string to send to the console before trying
+                             to read a new line
+    """
+    _console_interaction(test, success_message, failure_message,
+                         interrupt_string, True)
+
 def wait_for_console_pattern(test, success_message, failure_message=None):
     """
     Waits for messages to appear on the console, while logging the content
-- 
2.21.1


