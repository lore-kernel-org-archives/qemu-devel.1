Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAABEC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0248A20795
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK5GYPDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0248A20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBio-0006DZ-0Y
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBho-0004wP-Aq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:50:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVBhm-0000hz-CM
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:50:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id c77so1373840wmd.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HDkuFBTSf9PfxMFUSQsII/3TQvG3KWBBsCKA4dEtXq0=;
 b=bK5GYPDt7cantE00Sw1249BE4KvqtYpbDr/Sxxt37k1cYqjeoedUB9/p/VtP/1D/KI
 m3E0hXW/+KVxc2P/tN97AlUpI6+1yTl8tLlF9+yOQQcisHdqhqAdi6QM4BVVaZixINIp
 jwTtaBGqKy970mkL+1ibPoNXAesw2opNEyqpazTtjET4JHgAFRViNRlyuP9nFbkz7Wik
 u7twqUTVs834DOPVD2MA5034WsZCG7105beHpA0ROkiIDfEVKBObR7kMTZTYPaE2W6Us
 uq/S1s+0Haoi+7YiCj9gOzI9Pt8ZAt7eewDcy6hdbiSb9QpLraHRSCcMw81493gXcZr/
 8DuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HDkuFBTSf9PfxMFUSQsII/3TQvG3KWBBsCKA4dEtXq0=;
 b=LFzxA63yP0uHEMDjhvd/5dYCb5cRByyTG5xkfxXeUEVqD63+OmCbozRwS2FB5zgKBx
 fyyaMPh4fu24th6sQpUfy0ruf7geAWr8z0l8NA3R9v2M7Twnn/GWD0Jc/4QQ9WG6UZtD
 WFMTiYEncdqvLCLlJAfRuZ/F5qFY+nSNLmM4ueCJPpmSgu4soMnye5WhIBfjZT+z0eI0
 uOD3UhRomj7GNCUHa2WIkekesBsQKXMOMOOf+OSAGQsZdACazFWTLtRfle4tHws2yTtf
 GW0ZTlqLrQOaUhegWzPUOTMpybuJjB1IsGunkbbMx+iaWZwHTdD3upj4c7JdrakWDmrf
 D++Q==
X-Gm-Message-State: AOAM530Ys9W2TVUHyadL+oB0Drajj78TdvZBgmBmCfwru3Q947peZKR3
 vfEHE06GBSCld5XRvl8z6uOu3XSQNQA=
X-Google-Smtp-Source: ABdhPJx5HxH9RBzULE6fqH/E7B8THu1Q/w0fZwryntr0toSwRMSG3bwXy1kqIBv6rjpDEHop8wuKjg==
X-Received: by 2002:a1c:4856:: with SMTP id v83mr2948606wma.118.1603277452507; 
 Wed, 21 Oct 2020 03:50:52 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x65sm3079700wmg.1.2020.10.21.03.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 03:50:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] tests/acceptance: Extract tesseract_available() helper in
 new namespace
Date: Wed, 21 Oct 2020 12:50:32 +0200
Message-Id: <20201021105035.2477784-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021105035.2477784-1-f4bug@amsat.org>
References: <20201021105035.2477784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to reuse tesseract_available(). Extract it to
a new 'tesseract_utils' namespace.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/machine_m68k_nextcube.py | 25 +++-----------------
 tests/acceptance/tesseract_utils.py       | 28 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 22 deletions(-)
 create mode 100644 tests/acceptance/tesseract_utils.py

diff --git a/tests/acceptance/machine_m68k_nextcube.py b/tests/acceptance/machine_m68k_nextcube.py
index 2baba5fdc26..3c7400c43e4 100644
--- a/tests/acceptance/machine_m68k_nextcube.py
+++ b/tests/acceptance/machine_m68k_nextcube.py
@@ -1,19 +1,19 @@
 # Functional test that boots a VM and run OCR on the framebuffer
 #
-# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
+# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
 import os
-import re
 import time
 import logging
 
 from avocado_qemu import Test
 from avocado import skipUnless
 from avocado.utils import process
-from avocado.utils.path import find_command, CmdNotFoundError
+
+from tesseract_utils import tesseract_available
 
 PIL_AVAILABLE = True
 try:
@@ -22,25 +22,6 @@
     PIL_AVAILABLE = False
 
 
-def tesseract_available(expected_version):
-    try:
-        find_command('tesseract')
-    except CmdNotFoundError:
-        return False
-    res = process.run('tesseract --version')
-    try:
-        version = res.stdout_text.split()[1]
-    except IndexError:
-        version = res.stderr_text.split()[1]
-    return int(version.split('.')[0]) == expected_version
-
-    match = re.match(r'tesseract\s(\d)', res)
-    if match is None:
-        return False
-    # now this is guaranteed to be a digit
-    return int(match.groups()[0]) == expected_version
-
-
 class NextCubeMachine(Test):
     """
     :avocado: tags=arch:m68k
diff --git a/tests/acceptance/tesseract_utils.py b/tests/acceptance/tesseract_utils.py
new file mode 100644
index 00000000000..acd6e8c2faa
--- /dev/null
+++ b/tests/acceptance/tesseract_utils.py
@@ -0,0 +1,28 @@
+# ...
+#
+# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import re
+
+from avocado.utils.path import find_command, CmdNotFoundError
+
+def tesseract_available(expected_version):
+    try:
+        find_command('tesseract')
+    except CmdNotFoundError:
+        return False
+    res = process.run('tesseract --version')
+    try:
+        version = res.stdout_text.split()[1]
+    except IndexError:
+        version = res.stderr_text.split()[1]
+    return int(version.split('.')[0]) == expected_version
+
+    match = re.match(r'tesseract\s(\d)', res)
+    if match is None:
+        return False
+    # now this is guaranteed to be a digit
+    return int(match.groups()[0]) == expected_version
-- 
2.26.2


