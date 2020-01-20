Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F7BC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA7C206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJNplbe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA7C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgtm-0006J6-CC
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:56:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq0-0000n5-Cj
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpz-0007X5-7y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:40815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgpz-0007Wo-0t; Mon, 20 Jan 2020 18:52:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id t14so1130336wmi.5;
 Mon, 20 Jan 2020 15:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mHOBTTcVp9EP98oXfsYEhgEPBD3nh+UXg7LeIFUoJ4Q=;
 b=TJNplbe2btvc0+SuQm0uMKluglrZPDz6clmgWyWIp/0bj2pml6R1qYMYimlABEC8vu
 bpUC3OBQO/Q75PBKmo61h9fxw5fh394PQKFJZqiMt7khYTAEYuzaFMJsZTuGo4cVHUxB
 +nXTQm3RciCbTdUDE8E0UQVstb2xpcnsD1XWyQUuIZYda4Mi9i0ZhS/DuJJ3iTKryt5U
 LN/8Qtck4j7/Cld47VdJkLPsrE8WgvNU3P1h6F0cfD19/n8YNKy1Mm6sIgPeV/XnJwZE
 NSW5JMugdg2Jn9LIA+NBXRpiPk3YlRTn9rM1d4S7mvhD+9WDIC/6ieaTcYCercEB3aSk
 5HmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mHOBTTcVp9EP98oXfsYEhgEPBD3nh+UXg7LeIFUoJ4Q=;
 b=Bw1jX+dmIWEeq1PYGPVToyHIlMN4ZXm/1XLpj9AiWl9h+Gl6xTHE907Bz60sFfAyt9
 PG+q2Vco5Ibqu4Rxm7zqSpqmL7LQNPo3MD9OF7phggw04SlTZaRt2uTWFraXsC7RY/rM
 taDwOKjPbfuVkgGbf6Lq3VAvhgyqVKN9kYXdmGfQe0iqL+NjiTiFPS7Rguq+NrqgHnPx
 AuWujcVWuHtip4STsfKCC4vC9l1tfsSG3ljIzYXTwP/9YqJxJ6TOltLZnRJ7rFea+g1f
 IU1mC6jeEQwxnM/iZBxrot6XsvG91uJmUrdi/6gNKlocfMLjEaSw94CyF5xm3Th1gqQB
 eP+A==
X-Gm-Message-State: APjAAAX2c57bHnXxM/k4KU6smJ8YbHRBWoicQWCQL7sOTAH0B51hhdQT
 H5jRD6Sa8rr0XriiDnv2cBlumot9
X-Google-Smtp-Source: APXvYqyGsLNH2wfr8Mk4tnXUJV/4J72Bnw9ZmIo3LHUvtoRV3y+zge5jwgIKbS1+mujuWyTRvkmYyw==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr1229047wmb.150.1579564325471; 
 Mon, 20 Jan 2020 15:52:05 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/7] Acceptance tests: Extract _console_interaction()
Date: Tue, 21 Jan 2020 00:51:54 +0100
Message-Id: <20200120235159.18510-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we are going to re-use the code shared between
wait_for_console_pattern() and exec_command_and_wait_for_pattern(),
extract the common part into a local function.

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
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


