Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA58CC32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9524E246AE
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpVnW+p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9524E246AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isz41-0003Xn-NU
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 20:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoO-0007Aj-5r
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoM-0008Rf-QD
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:31 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40387)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyoM-0008R9-Jw; Sat, 18 Jan 2020 19:51:30 -0500
Received: by mail-wm1-x32b.google.com with SMTP id t14so11161283wmi.5;
 Sat, 18 Jan 2020 16:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L8aTerMeWcsMXP4TJC7rS1Fx5gyQ/tHzqzZUZvCWPPA=;
 b=EpVnW+p1pvtHulH/HfG35ccOR6YyIg7+MQpftC+toClCRsAN2mZL3u6Jz4IhS78jOH
 PXoywau3TvxAf0uU1ziz/Fwn12zt4zAjZsknt7cyz1EbYGyxQvLdyoSw7WMzYwaentGO
 qeNU4q/4yAhOQ+3CQ3G3kQ8vGyhqAnsc7+HODXm9t3rZmBZoESqFrx8TF5FURy5tMnzH
 tldexQYyJuLlv/f3K+OLcFIqYhLrVmp9jOgi7qcfDhyUIYaDMqhZJS13iNeD/VFMsANN
 1F899QBSGU1ETpu1LV5jcC7n/uC4dhX7/jkp33wRGOw3rhF0egc9zkXCSkpRhLuCuAow
 vpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L8aTerMeWcsMXP4TJC7rS1Fx5gyQ/tHzqzZUZvCWPPA=;
 b=GmiIjIwekCe02SoA4o5/Ntxl3EYQUqBS6LrqKJtP4HyP6YH4kvpLFjJ+3xphhMRTOs
 KKlB1UgdnBKGcLW2ppIrEmxwZUCUSuvvIZ/htma1S4pSB0Ft8/fBOC2aONWiO80D/Ve8
 4Eoeqtqs/rSf5AjBAsQT3pgjA1MPp5+j8JG8smxUn2KfNw37geIiFwkGIQhs2Wko0ys9
 2UlmBm7PNCG5vGp5lSzl2RnC1HwZ+JC9XczZPkTIpXLfG2PmoVw59aZEE4NnKyYHVF94
 FkmFt0ONEwYYL6eqfG20/suCVbBRbYh6PwTugw876tVuXarXLnOnbvY0yd4ZT/xpwDSG
 4DBQ==
X-Gm-Message-State: APjAAAX8+QoMzy541ruhDOw/gY2aNmaEY7ypU7ChpFXydEzmynDyinrw
 N2nhhWaQgK9QiNa3uW0MIMkMoC2TvLQ=
X-Google-Smtp-Source: APXvYqyI1hqwTBLcORj3dcLFwrp8knVbcJs89umOzr7P4oDwGrq2IMLaf5GUOXsqOy2t+y/AAcSbVg==
X-Received: by 2002:a7b:c946:: with SMTP id i6mr11963402wml.28.1579395089446; 
 Sat, 18 Jan 2020 16:51:29 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id h2sm41763568wrv.66.2020.01.18.16.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 16:51:29 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 18/20] Acceptance tests: Add
 interrupt_interactive_console_until_pattern()
Date: Sun, 19 Jan 2020 01:51:00 +0100
Message-Id: <20200119005102.3847-19-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119005102.3847-1-nieklinnenbank@gmail.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We need a function to interrupt interactive consoles.

Example: Interrupt U-Boot to set different environment values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
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
2.17.1


