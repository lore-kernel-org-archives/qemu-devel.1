Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C762AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9422B20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbiJ4Txk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9422B20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCJw-0005op-SM
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB55-0008MV-6M
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZB54-0005xj-3M
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZB53-0005wn-SU
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:22:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id g135so1270028wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K60puiqqk977DMRGqqyet05oJzMhJ6Klb8DUPo/1Vlw=;
 b=GbiJ4TxkuDOA1cloaOY2UICFfE7xXXjk1cGMBJlz9lpbopmmJ5brGwZtMEpj1+E3RW
 RNn9dTHlY/10bq/wMimwjAnlbhD765sdE1Tbr65ta8xL6wFMmT5VWYqDNlYQVCzh9dQq
 wVNZ6Tm/Aze1m1rOh2hmx01OKCRFi8ZsZSc7o+CnttIIEjCRixZlDSQAc+RKbSShVqdC
 sxo3/weY9ncDjfP4blP+2n7r9uLVULKJqDYKBhOdJneCguPYh/LrbxAbUkC0EZKAPs94
 diw0ewizv1XIRfytlerX9aD1eWm5bixaVTP4r4sD/OdZMcMa3wfPy5vgyyOeHV+M+jNU
 06RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K60puiqqk977DMRGqqyet05oJzMhJ6Klb8DUPo/1Vlw=;
 b=s+QaDsT1sRIsP9zsnNi/rpqsDuQOesN6Kx5Oeucc0Qx3xWnIt1IWuNLgyTz0njRb7y
 fTEUyyB8IddhmbKiekYl+/apwFw18CRg5SDPxfH6TPHN1Lw+o9GiA+tWK+OpLRq1Z81e
 OQBT6SVS1ZnlWLmrX1RC92/dQzbvf9++bcFB8wI5aDTtJVL97blXyEgzO4HKS7AG40n6
 /5hJ7liE/jhBS+DAfsqUjo+JSfF/QKNNdrL4ElV2UEP5KK1V4NzzJaMW7asBotjMSUga
 BQDOwny7EzT/2WowQH44LeXJSEtHVMMFv6M/8z8861GdlDcG0OlSlWrWtGa0p2mTOu/z
 Gd3Q==
X-Gm-Message-State: APjAAAXQQmsSMTiFyLID02NNN62SzfZUeVpocjV7H9P+IWef2RP2fRqb
 6v2ni6i3Jo0GLeCm0wqH0AfY3A==
X-Google-Smtp-Source: APXvYqzvF+8YkoM1rf3g6a1r5cnH9j9m5nExakkI6bGkwUy9ILHLYvkIOAOAn2YlrHzK7Z0lvtNclg==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr3040412wmf.7.1559899356679; 
 Fri, 07 Jun 2019 02:22:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a17sm1159492wrr.80.2019.06.07.02.22.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:22:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 217081FF9D;
 Fri,  7 Jun 2019 10:05:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:13 +0100
Message-Id: <20190607090552.12434-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 14/52] tests/vm: send proxy environment
 variables over ssh
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

Packages are fetched via proxy that way, if configured on the host.
That might be required to pass firewalls, and it allows to route
package downloads through a caching proxy server.

Needs AcceptEnv setup in sshd_config on the guest side to work.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190520124716.30472-4-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 4847549592..5e30bac661 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -38,6 +38,13 @@ class BaseVM(object):
     GUEST_PASS = "qemupass"
     ROOT_PASS = "qemupass"
 
+    envvars = [
+        "https_proxy",
+        "http_proxy",
+        "ftp_proxy",
+        "no_proxy",
+    ]
+
     # The script to run in the guest that builds QEMU
     BUILD_SCRIPT = ""
     # The guest name, to be overridden by subclasses
@@ -106,6 +113,8 @@ class BaseVM(object):
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
+        for var in self.envvars:
+            ssh_cmd += ['-o', "SendEnv=%s" % var ]
         if interactive:
             ssh_cmd += ['-t']
         assert not isinstance(cmd, str)
-- 
2.20.1


