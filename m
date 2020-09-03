Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B37C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229E9206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMitENwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229E9206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwin-0000En-7J
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLf-0004Z3-QO; Thu, 03 Sep 2020 17:00:49 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLd-0007kv-QI; Thu, 03 Sep 2020 17:00:47 -0400
Received: by mail-ot1-x32e.google.com with SMTP id g10so3993933otq.9;
 Thu, 03 Sep 2020 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ux/8hJOIk7YJVgmu1a1t9+FNPCZkfsFV76/cqQ5+uRo=;
 b=eMitENwgwj05y27bwjJ2t3LSkA6V65hwme7MdoCdCgk5tSR+OMt0ci9AijpSLtKL1J
 y4bW1XioUX1czvUZd/JGJW640pxQfY5xBz+DP46DODwad5TJWD6olLRePtgIu8GkMBZs
 hAJN74g0RpiO1loAMFmYDgmwXLCjv05C765Ei4WNypHDuqnXkN3x0m4Jn83empegIlvd
 1hiG3oM/ayK5tGKN5NJfFBh3isQRJrxx5okOafSce5kHxeHpfuic6Xa9Q7W7eSzvJATp
 9kgBws783kNpiMudB5sbuZFlrW8LHqY+riQTbDO3WwaPooMKcIPlEzwIzvrhBIreQOy4
 ziLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ux/8hJOIk7YJVgmu1a1t9+FNPCZkfsFV76/cqQ5+uRo=;
 b=JucXsMzbVrJZDiCOKt2us3t6MO7z0NB8lXUc7x/A0cYtNmCPAQ9ZI2sVV3UuRhDmve
 Pmo6gAPHRZjtpOPX9deFKgha5GOiCI+sWh+xcss3AwGOsMREf/EMtrc8zif8ILSYfcoY
 nQlPnbScyIQRrxD+dfE4H+tybZ2uXd+LdMmV5a5ModPEHU+ISSkL8icbhnFqhPeB5rG0
 p8hUwiBC6Rk7EeBjMUojfFmk0mzChHb/aJQPoTN8SFzA8Uf9LmrE3A0Kk7ywNTHlTDKr
 c9tfhL6S5SEOKguW13AD0doJN38MA+vMBzfy0xSksSt47AhPnrjxOhvtzgx2Q01BEXsO
 Kh9Q==
X-Gm-Message-State: AOAM531cIRZseX1wiwZcudJ0RDIA/ePncxHc/ewxVHJZyaQ5QlTGr+H9
 zYANkotUMToou0a2i88qUuVRJ4HIbykdDw==
X-Google-Smtp-Source: ABdhPJyfJ6zCvTVTdZun6x1TJhInxj5REkyBXn1pB0GBkQ02qjzxeg2PJeQnuUMl9Iso+WbtMFmYLA==
X-Received: by 2002:a05:6830:48:: with SMTP id
 d8mr2967894otp.272.1599166843910; 
 Thu, 03 Sep 2020 14:00:43 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x4sm724813oic.11.2020.09.03.14.00.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:43 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 47/77] tests/acceptance: allow console interaction with
 specific VMs
Date: Thu,  3 Sep 2020 15:59:05 -0500
Message-Id: <20200903205935.27832-48-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

Console interaction in avocado scripts was possible only with single
default VM.
This patch modifies the function parameters to allow passing a specific
VM as a parameter to interact with it.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <159073587933.20809.5122618715976660635.stgit@pasha-ThinkPad-X280>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
(cherry picked from commit a5ba86d423c2b071894d86c60487f2317c7ffb60)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
index 59e7b4f763..77d1c1d9ff 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -69,13 +69,15 @@ def pick_default_qemu_bin(arch=None):
 
 
 def _console_interaction(test, success_message, failure_message,
-                         send_string, keep_sending=False):
+                         send_string, keep_sending=False, vm=None):
     assert not keep_sending or send_string
-    console = test.vm.console_socket.makefile()
+    if vm is None:
+        vm = test.vm
+    console = vm.console_socket.makefile()
     console_logger = logging.getLogger('console')
     while True:
         if send_string:
-            test.vm.console_socket.sendall(send_string.encode())
+            vm.console_socket.sendall(send_string.encode())
             if not keep_sending:
                 send_string = None # send only once
         msg = console.readline().strip()
@@ -115,7 +117,8 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     _console_interaction(test, success_message, failure_message,
                          interrupt_string, True)
 
-def wait_for_console_pattern(test, success_message, failure_message=None):
+def wait_for_console_pattern(test, success_message, failure_message=None,
+                             vm=None):
     """
     Waits for messages to appear on the console, while logging the content
 
@@ -125,7 +128,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None):
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
-    _console_interaction(test, success_message, failure_message, None)
+    _console_interaction(test, success_message, failure_message, None, vm=vm)
 
 def exec_command_and_wait_for_pattern(test, command,
                                       success_message, failure_message=None):
-- 
2.17.1


