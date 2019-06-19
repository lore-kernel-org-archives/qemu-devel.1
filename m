Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D1C31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F76C21721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 19:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOTKH/so"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F76C21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdgZe-0003c4-Lh
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 15:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRZ-00067x-Kg
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdgRY-000062-8G
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:29 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdgRY-0008Vd-1r
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 15:40:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id d18so493485wrs.5
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qdTjyQaBb0/jp//KyLcDmonBqL8NDTLZR4EMwIjuiJg=;
 b=GOTKH/soekvQHQvQQZP5TPI1o9LeBPGGBj4hpcm3CPKG6FJS53AN2siCH0/8AIWmb+
 0HnbD8z7Jf0isQiji37McaIHJtmIRpsC+eYQ0SfdVlhaBBCY3sWWQB8bB5Ius3YCqqMa
 pinEzJ2r7BlCc9s1mxwrpiW6mC+Xp6cp+7myNa2KDis5aAPWK/Jr4Eq2hSnkYNYFY7H5
 QMYkSt7ogRJ8XLtS2MMByFcrvh6ths0kkO5uTaC5oYeYJwH8Q5Z84yT2LG/pVQa8hOCQ
 e9qypKc8m5sdlCQkTe680JjGtFcnxaX20XvdmXltfiWfvx8nKqB9ymqZsobAXGQsEjIn
 DFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qdTjyQaBb0/jp//KyLcDmonBqL8NDTLZR4EMwIjuiJg=;
 b=IZBarWLlhwVkTcDNP0QXOtwnf1/8xbF6WEFut7No16d6orUxZ/xVAfhumyPBOdDt2p
 h5qRiP0vBfU5CYVZtP/x6RzRtTAfL1Y4cwY1k6MEe73COaj6/kJyWKJyJyOZNCiLHokW
 tchU/HTpp6Cem2+ICXbTT4lp9hpXgVvpHAHTaJV5ctdCNpqGyHpm1WvPPWEPvwubUHNQ
 T4IQrg0tdEhfWDYEcTqSu7MJILat7lF26z8Sb4pAea9Jecl+xoXAnMIRrGwhRzN+8uLB
 B3ppYVKpcVDNydU+kO7NYkLAKXoM4czkd684j5ARynOKUmON7kf7OkNlHmddT+gQapTq
 vlfg==
X-Gm-Message-State: APjAAAVSS2cOoqHkTielA8iwZzt1g4FPy4to2xt3jjlN+O6jheuOCVzr
 CJfrZWAkEJ90fYymRc2DDGS7o+lTBZs=
X-Google-Smtp-Source: APXvYqzDrYudV2r87KauE420Wnm/Nt62hqdSrM237yLMwfXyYKLsD4VDQ02JABe4i+pm3pfrZoXjug==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr11569882wrp.220.1560973226941; 
 Wed, 19 Jun 2019 12:40:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id i25sm7844878wrc.91.2019.06.19.12.40.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 12:40:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DD8FB1FF92;
 Wed, 19 Jun 2019 20:40:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 20:40:09 +0100
Message-Id: <20190619194021.8240-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619194021.8240-1-alex.bennee@linaro.org>
References: <20190619194021.8240-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 05/17] tests/vm: send proxy environment
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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
Message-Id: <20190617043858.8290-2-kraxel@redhat.com>
---
 tests/vm/basevm.py | 9 +++++++++
 1 file changed, 9 insertions(+)

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


