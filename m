Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B52C17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BF92067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="By6FVuPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BF92067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXWU-00052w-NU
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV5-0003P4-NN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXV4-00033l-O2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXV4-00033H-Hr
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:50:34 -0500
Received: by mail-wm1-x333.google.com with SMTP id z19so3253715wmk.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SGYCyiXxj6y3DiaxBTG3xzzW6T9viHeKAsigKYTsu2c=;
 b=By6FVuPAO3hW+33sD4y/FG/PozqoAeSCi2REuBa0rN+OhK2Aft9JA9EaxNpeAx9DHF
 q8RmGMD6BATwI80V56nvsOyTSlyTmW0WoNekzf9kP1q3Y+Lh+JvJ6x6A9+dLHc3V9kzO
 uj5NBC1P2gE3kgNHrwmqfRQS77jzCZYmprt5MXt2risz0SohRlxyyO5/wRV7yi38MuUW
 OwQhynYrZzFxbC5Guw5ewvU2beIvYSym0LBOYDLja/fh1BOlZqyI90JeAZzmgjlE3utw
 o8m6fCp6SUHfMg8M/f1wNb6VfPIYt2SCaQl+/CraeZ4e9kN0gX/7tKGVKLoYd5rLYv9r
 rl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SGYCyiXxj6y3DiaxBTG3xzzW6T9viHeKAsigKYTsu2c=;
 b=mTJ+mWGyy9AjRUSHWvMDvbhAlv4aPuB46cyuS66txRhE9pzfJ6AxC1Rkt65NbzmghC
 JAFwYqykJEbWsQipfJCA67+afoFJoBlj2C0o0e+c7+oza2DZ2f0NxmEWi4r47/Bm8ial
 P+4LXrYfQD0z1emk86tE2b+A1+YwPDVpNagu9iLiUPUzW1Hy/9oWVT+znrY/1J6wnRcv
 y+9XZrA5bLdK9fo+SMw/a/Wv/qlt4J+CF+tze21D++KOqEEIOMQLNxlsquSl7YoqFNBE
 6NcyRmFaIMObY/qDJwG4bW4U7WHJnPKjpCDRJEQttvBvKT6PcYm/V86HQ/0dcKQWmfbx
 xfFg==
X-Gm-Message-State: APjAAAVWrN40xwRGpfFj2kkkK78Oj9FJbBZcT5zuO6nMbtlG0LFP97lG
 BiL3pEScm+deu0RnhYY3BpkW7A==
X-Google-Smtp-Source: APXvYqxLX5ZYpOfnhI0TVnQkXLOS5qjhKA6pCRxQ/klesjfWk58sIjylLtZFvjmkkqWW2dLKiV2yHw==
X-Received: by 2002:a1c:810d:: with SMTP id c13mr4674846wmd.154.1573570233426; 
 Tue, 12 Nov 2019 06:50:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 16sm3669610wmf.0.2019.11.12.06.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 06:50:30 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 385061FF8F;
 Tue, 12 Nov 2019 14:50:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 2/8] tests/vm: add console_consume helper
Date: Tue, 12 Nov 2019 14:50:22 +0000
Message-Id: <20191112145028.26386-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112145028.26386-1-alex.bennee@linaro.org>
References: <20191112145028.26386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Helper function to read all console output.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20191031085306.28888-3-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 2929de23aa7..086bfb2c66d 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -242,6 +242,25 @@ class BaseVM(object):
             return False
         return True
 
+    def console_consume(self):
+        vm = self._guest
+        output = ""
+        vm.console_socket.setblocking(0)
+        while True:
+            try:
+                chars = vm.console_socket.recv(1)
+            except:
+                break
+            output += chars.decode("latin1")
+            if "\r" in output or "\n" in output:
+                lines = re.split("[\r\n]", output)
+                output = lines.pop()
+                if self.debug:
+                    self.console_log("\n".join(lines))
+        if self.debug:
+            self.console_log(output)
+        vm.console_socket.setblocking(1)
+
     def console_send(self, command):
         vm = self._guest
         if self.debug:
-- 
2.20.1


