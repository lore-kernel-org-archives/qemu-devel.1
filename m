Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA44C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C5A20409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSPpIb8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C5A20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPkg-0002cl-Uh
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjU-0000ug-1X
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjT-0002Mw-10
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:19 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:34354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjS-0002ML-RF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:18 -0400
Received: by mail-wr1-x42a.google.com with SMTP id 65so1130239wrl.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D0cmFVYKra4nTJ8iH24pGP8hCfO1y6Nqvh+waFDMgsk=;
 b=rSPpIb8K2rP+CfanbmsnKD2KUpJjBiHuSgaXenodWHe0WpdnC9i/Bm3LvZBuy+C2Mv
 GJ4EJCa6cHF1XIQHKx9VhPWm6dH6/XdXBQBVQRDed0Tvbk6SvaGt/QO+mDxtCOE6+jHz
 g8T9AJPVPvYp4MHgblMiyfaszwsduGvMUx0bXeWpfVCZ58/Ckzew8rtMUL1bQu0p8YVO
 bK3Qs6iH9+GpkmAyfN3a/LpQyuRB7YU5/AOvQTlyYZjO+ywGPjl7In2qZLKcRfJNIOaF
 BJDBxczyoqfYSrdPVVFCiANZpYyVZ1WukeSrwixmb2q4qVvFZr2NGOGQCVVXa64+cwpG
 MFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D0cmFVYKra4nTJ8iH24pGP8hCfO1y6Nqvh+waFDMgsk=;
 b=KrH+a/XrtI2zEb4YXqZNpt/bPkr5oyDPzw2RrEyN5SnpokFKyDXBgB35TISAvyaoIU
 nzKOP5liifN2UlUXpKLUn6Rw5oKpC8Yl7Lmw6WxTc/3Tyi7i9DIVQaQ+AalVP23D8d4u
 j88tZlsKvnf6zOlxi2I/Kzr8e0CTRikhA2Ncta/ytwJbFgbh69/FkQLAneHhL7atK42G
 nt2/HuyRYiRoBZ51wutxVuFRkDeY0GemXz0nt2rsEe2+68U8BwKTf6sGTda0vdFoER3/
 U8LbIZfdJZpfxTkl4zwJehZ9tcwWR4GikNegxSszv7RTkDy6hgUyc7Pr9zeKhwFApr/z
 gjng==
X-Gm-Message-State: ANhLgQ32oB2BdPxb+uhp3rW6aPuCKAfyW5SIoWQS752Wr8eiUbfV1kjG
 rbv1XwJ9QTeeZV6tPrEI4DUGoQ==
X-Google-Smtp-Source: ADFU+vuly/8PgnTsqRtcbHTQjIWI/htBVIII3CFNG63bA+9Qk0OWScdr329K2C0ZHYc3QpbE29x2ng==
X-Received: by 2002:adf:bbcd:: with SMTP id z13mr30810887wrg.389.1584980117770; 
 Mon, 23 Mar 2020 09:15:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z12sm25359870wrt.27.2020.03.23.09.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:15 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D17F51FF87;
 Mon, 23 Mar 2020 16:15:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 01/11] tests/vm: write raw console log
Date: Mon, 23 Mar 2020 16:15:04 +0000
Message-Id: <20200323161514.23952-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
to watch the install console.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200310083218.26355-2-kraxel@redhat.com>
---
 tests/vm/basevm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 8400b0e07f6..c53fd354d95 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -213,6 +213,9 @@ class BaseVM(object):
     def console_init(self, timeout = 120):
         vm = self._guest
         vm.console_socket.settimeout(timeout)
+        self.console_raw_path = os.path.join(vm._temp_dir,
+                                             vm._name + "-console.raw")
+        self.console_raw_file = open(self.console_raw_path, 'wb')
 
     def console_log(self, text):
         for line in re.split("[\r\n]", text):
@@ -234,6 +237,9 @@ class BaseVM(object):
         while True:
             try:
                 chars = vm.console_socket.recv(1)
+                if self.console_raw_file:
+                    self.console_raw_file.write(chars)
+                    self.console_raw_file.flush()
             except socket.timeout:
                 sys.stderr.write("console: *** read timeout ***\n")
                 sys.stderr.write("console: waiting for: '%s'\n" % expect)
-- 
2.20.1


