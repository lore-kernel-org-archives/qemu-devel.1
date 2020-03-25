Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72942C54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403752076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY/7yBu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403752076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7m4-00055n-CJ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7kz-0003Sy-Pv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7ky-0007xD-R1
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7ky-0007wQ-Kh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:48 -0400
Received: by mail-wr1-x430.google.com with SMTP id j17so3521798wru.13
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gyO7FMb6Kog7HFYI2emP9ylf6WG5qE9183WrVkkssuU=;
 b=DY/7yBu2uCN1ul0cNqvpch+bDgQ2niscBAmEUfPjrotOI5WO2qoHoBatgOhQ3c4fFO
 ybIQKqQY4x3f0qFbMokyOLF5mWZPAnnHQ7+qSAzsp+wpYEYYckMQx8IJuCdQ/HaT6gmP
 McuB5WhqV6upz0+T1QhujcWyx53M9XVkHI/GV5o/DAqkx0Wh5E4T+7iGJy6yCf9J64+B
 grTlmY6kH5WXqW23EMNRRPOEYHmKtmp+eZsXRhTsNRnsbOG6tGk0B725uBFCZvxq1JEy
 VfVj5i/Sdvynaw2aVVLgkPybnvOgwRwKiuQtCP72T0ghkttmEY0HhICPZKLUjnnxXv1K
 CKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gyO7FMb6Kog7HFYI2emP9ylf6WG5qE9183WrVkkssuU=;
 b=QlUi9COy2JwbdKq6vXliGP1Fm/AcxXLJ2EuHffPlFFxjtp+zsjgeY50lulSeeqQRQe
 yyDZwdpm3x+SkTiBKGKDGBvzCv9JKwODZHJWf0581JRkfaFMweRsD8SKT2kg/TciJSae
 JV56uuG2dCqeF3aBnLk91PAR1t8MQg65a88p+nIBiUrF63hj7yEUAC+4taxnMMtX57F0
 TRNDi0eJnNRDciLXZ8qZORZj0r91voIlpew5sESN3SHHsKhqKsFlFL1NbDxb6a/oQf32
 TWgaCa5n5XPcfIijLVKPX8j+TQRIH7W3yq3Awk8xFCeXSP7+Of2ot1YdKFP00+i+CQuJ
 so8g==
X-Gm-Message-State: ANhLgQ2VXRatXTH+Z2RSv03OBLEEPZ8P2tEHp8m3TO2MOdJ9gW3WjArX
 Ly/9DLIk4tfTuB2+GByncNGthQ==
X-Google-Smtp-Source: ADFU+vvZMab3MeUi+oX1d9UeoZA+SH/1ImgDcwWUfa+cHM04konPwGt1zpcH8IYdjKA3U3G2XdjwsA==
X-Received: by 2002:a05:6000:111:: with SMTP id
 o17mr3911770wrx.111.1585149347375; 
 Wed, 25 Mar 2020 08:15:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u11sm1633773wrt.29.2020.03.25.08.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:15:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 56D371FF87;
 Wed, 25 Mar 2020 15:15:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/11] tests/vm: write raw console log
Date: Wed, 25 Mar 2020 15:15:33 +0000
Message-Id: <20200325151543.32478-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
to watch the install console.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200310083218.26355-2-kraxel@redhat.com>
Message-Id: <20200323161514.23952-2-alex.bennee@linaro.org>

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


