Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D3C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C129F206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxuo5rVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C129F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgrf-0002Zm-Lj
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq1-0000o4-IL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq0-0007Xe-Fs
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:09 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq0-0007XJ-AA; Mon, 20 Jan 2020 18:52:08 -0500
Received: by mail-wr1-x435.google.com with SMTP id b6so1356224wrq.0;
 Mon, 20 Jan 2020 15:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=crNrzD0/605/2sD0Sp9He00HXeVMYerdORad4uvVDcE=;
 b=kxuo5rVWjDTffz4ytyrVJ/q30CW+2GTdviPsZYa2NvkcoNJd3VZUtS7E4b0ZQFhuwg
 QOj1MWlVc9Lg3xu9BHHQPw/s2YFRcTpnjQ/z6jvnkegS86XMVsX80SN86AOaHDs/MLGm
 Ba+b5Yl96YsykrBVuOC5VqMXvlEJrgL9o3R6A7R/qJTMYEjlup/Wb+Tgfm4q5r7Otsrn
 hM3EH/ns763E2JYr/e/LlENz54eieHe0PY89dNEskJ97UnwZ4Wvh9NfyKe7ETG34m85t
 jtxP8NeTgtqbm+8iJ3SeBVCpGPI0ikINCoXs8MsajD59ksGhY6V+JIn+cDfO0rILs7gV
 GN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=crNrzD0/605/2sD0Sp9He00HXeVMYerdORad4uvVDcE=;
 b=AJUTyZiT2UNphcTu+Dd0wOTZGJlX81Vqql2ZEugbv9vioM/r+aXNaZ5vN4CrO4T1Zw
 aB4yZJFyZ9HVldzcIpJJhRV/tiUde1KDSpZhIQ/ETT/aO3jEp4JO7rYbvmMuQ/2LFaXn
 0Bgxy85GsE4Nymy/saRJQUvIL1SwTK3mho+Twe84AAFb6MxK/S8rGVe/4N8sS9QZQyjq
 o7Lls1MrgFiqFGQa37gvu2jM9W7ztrFIXjQTG6+XxeTEBSsg+dZbRnFR1jk/ddSNiDYc
 CmZ1HlnVxnFtxeCEVsmRJhy4Z7jyUikdd3CYgahp+M4smItC05Jz9Kk2nfVOPeoinOXz
 wAgw==
X-Gm-Message-State: APjAAAUx9lvuLVUKI0jXlbmKb/WH4wmQHomFmtrwGpjdbg5jB9vfSuOE
 vwfiXnyrPc9zBmmSpCjvsei5BWWg
X-Google-Smtp-Source: APXvYqwYNLlmZM097nqk+YcYCBWtQA94HNSiH+j21tF7RlbBe77pze6scg1TfFhVvlavc+pg9ju7BA==
X-Received: by 2002:adf:e609:: with SMTP id p9mr1809278wrm.397.1579564326972; 
 Mon, 20 Jan 2020 15:52:06 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/7] Acceptance tests: Add
 interrupt_interactive_console_until_pattern()
Date: Tue, 21 Jan 2020 00:51:55 +0100
Message-Id: <20200120235159.18510-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

We need a function to interrupt interactive consoles.

Example: Interrupt U-Boot to set different environment values.

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
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


