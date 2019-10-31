Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D9BCA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B10C20862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 10:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7Xwnto3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B10C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ7ME-0003vN-S2
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 06:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Hy-0002Bg-92
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iQ7Hw-0008RL-DD
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iQ7Hu-0008Bv-7g
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 06:02:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id e11so5526872wrv.4
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 03:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WHX8BWJY25VVyhrmg2lG/ZkSNqLFz5iW9yrN1cd506s=;
 b=c7Xwnto3mTZb2ieQwHWZUiyeMY9Hr+EM+N7iO4GBk5Aw+ep4K4BfV22VYclZ76oYn4
 JWL76+qtTvq5QOsGEBKvod/gsqg8yATnl8wqXWIHsuWwntCr+bb9fUwHYtzYPxAIcPj3
 uU1/HvibP5xPSi1u86mpxQuUB8fo3cMcwthk6h8I+D1SplEPwU7uqDO+Kgi844XljKIi
 XLPFdBCkNkBmXwmLnA+YdFdfdRINR/88dUVKVzkZ3tksGOBfmyGRknWy+djJ6mHyWvs6
 3BOjz3cQtJ/WWdGDBlltltg7sbip+Jo8VlTSAXvtvRhPViKhPFmAJ8hF7VklL5JH3glt
 RIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WHX8BWJY25VVyhrmg2lG/ZkSNqLFz5iW9yrN1cd506s=;
 b=KF7o5AAgmAhgzdO+KsoX8nG8L6EnGmgWn85HV81zBkJnLdoaVcNWbkydVhcG8imOvG
 iBrQ73kGEecVCoyH9rfe4/PoGHJdPzvNtiwJLAf6DdWkwscRsSr6YCeaFtfVy2Tp99ym
 u3U2cRqHvUKb+xpG/5/y12owQyB4CVL9IYPC+C6jPvuxQbmhKepja7KFy5yJeEbmxH9z
 Pwftzm9HQA54G9dWwN4uz2LhB+2vzyPde1KBQRRo167fbsZjh3DwzEng+Vtn/VrXWUrr
 Qo+W+fTeqLR1w8cK3FwyWsQD77NYJ77nypHu24OmJ8FVJBZ8TaIwcshYe8fr++KKm2Sl
 s1ag==
X-Gm-Message-State: APjAAAWSUtH5ocR18XxbwPocdaBydxUQJ/QsEvrYv0XI2duCaFdrdsFA
 tMsD4cWkw0EOwSJSyVgWIwOnXjxOYjDN+g==
X-Google-Smtp-Source: APXvYqzs5Z6KjIzP8yT4M5/R5rWZfpevrz7MOfaJrcv3TvxhzKjckbUsod23Bm5Sy697bXt6xOEkLA==
X-Received: by 2002:adf:fd4a:: with SMTP id h10mr4406555wrs.90.1572516158391; 
 Thu, 31 Oct 2019 03:02:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j63sm3383307wmj.46.2019.10.31.03.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2019 03:02:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D7411FF8F;
 Thu, 31 Oct 2019 10:02:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 2/3] Acceptance test: cancel test if m68k kernel packages goes
 missing
Date: Thu, 31 Oct 2019 10:02:31 +0000
Message-Id: <20191031100232.21992-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031100232.21992-1-alex.bennee@linaro.org>
References: <20191031100232.21992-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

The Linux kernel that is extracted from a Debian package for the q800
machine test is hosted on a "pool" location.  AFAICT, it gets updated
without too much ceremony, and I don't see any archival location that
is stable enough.

For now, to avoid test errors, let's cancel the test if fetching the
package fails.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191029232320.12419-2-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 4e9ac0ecc36..880a4b31ee1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -482,7 +482,10 @@ class BootLinuxConsole(Test):
         deb_url = ('http://ftp.ports.debian.org/debian-ports/pool-m68k/main'
                    '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.udeb')
         deb_hash = '0797e05129595f22f3c0142db5e199769a723bf9'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        try:
+            deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        except OSError as exp:
+            self.cancel(exp)
         kernel_path = self.extract_from_deb(deb_path,
                                             '/boot/vmlinux-5.2.0-2-m68k')
 
-- 
2.20.1


