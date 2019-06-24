Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA24C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21F520820
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqgCuy9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21F520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51366 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPRi-0007zE-4K
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0006fk-Ci
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGE-0007dO-Hf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40884)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGD-0007MF-5z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id p11so13968664wre.7
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xtIRwzundNicszHIR+Xc5ItZ9WkO8ULjpABGU4hH988=;
 b=KqgCuy9dPwLZhtEumpwHuY0ekl0UMQfJ8xPf2t/6KOJqLtBZfrA5FOlV1KJq0c1WMO
 jLzy6koClz0+DQlyOy0L/tAVy74tN7JDEbY6HV99VPZ01R5Z2tKcA5T/xz1q1u2Mb9Oq
 gcx9c2DMj72roCBKZQZOQvEvebLYfTADFuphEyiGHpQ6yob2K6wc+oCgx4/WxJ8EBE3x
 W7H+3BGRLVIGzDpUXGx6llmqrsKSKqTanWgiF1Gwif3R/Rn7p9a+aqMLQbkezqSwJxEo
 cXnjZq3sChMNzj2YwG8uzQGOITYwRQGF5qHyWFAbLvKb9j2t+/7u63jpIu7dX1R4X8HS
 Yh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xtIRwzundNicszHIR+Xc5ItZ9WkO8ULjpABGU4hH988=;
 b=lNj7LB/EzBLawQdbJBKkezVOd320eGgJBY8UxPZ93HM0nUCViiXj45B1ooh4qgO1bZ
 LuD9OXpdSIJmYrJQQgd8V0ZukxvY9/Fgtx1OSAmo4jVzCvXV+RfL3iaMcs0c5KyA1TiV
 nK3mv9i5Qxnj8foZhAvR5VYFdoGHnrscnme8R8K+ZpRy1XNDbuquHywGb1Sjhx4nfmv3
 xz56tZk0hjCaM9ApnxWhri33oDm4E4uW8hWOBE5YdNjjooR3G3dfuDyVViEvUO+e4g8N
 Jvn2ek1tUJ8vV5GamQ9oG86BtLuDKpqADQgBCCKCJ9gY0yBxONLaSQ/m56YpifbP6Qfh
 eyGw==
X-Gm-Message-State: APjAAAV11cwHrFYSjbBB55msWtvqMKWuy6K47JwONFofYkR3F6uwXFtd
 cHvNX/a7ak+CWPiuCXXqh/rl6g==
X-Google-Smtp-Source: APXvYqyeAkZE74pKnqCICtUk3qdhnBAAwYal5kKyb7jyJAToRm/c9mncO1JqyM/q9FGQc48U0hEBlg==
X-Received: by 2002:a5d:6190:: with SMTP id j16mr16866483wru.49.1561383821278; 
 Mon, 24 Jun 2019 06:43:41 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 32sm22683122wra.35.2019.06.24.06.43.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C12351FF90;
 Mon, 24 Jun 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:21 +0100
Message-Id: <20190624134337.10532-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 03/19] tests/vm: pin ubuntu.i386 image
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

It's a good practice to always have the same components used in tests.
According to:

   https://cloud-images.ubuntu.com/releases/16.04/

New images are released from time to time, and the "release/"
directory points to the latest release.  Let's pin to the latest
available version, and while at it, set a hash for verification.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190613130718.3763-4-crosa@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 12867b193f..7017e6d388 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -61,7 +61,9 @@ class UbuntuX86VM(basevm.BaseVM):
         return os.path.join(cidir, "cloud-init.iso")
 
     def build_image(self, img):
-        cimg = self._download_with_cache("https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.img")
+        cimg = self._download_with_cache(
+            "https://cloud-images.ubuntu.com/releases/16.04/release-20190605/ubuntu-16.04-server-cloudimg-i386-disk1.img",
+            sha256sum="e30091144c73483822b7c27193e9d47346dd1064229da577c3fedcf943f7cfcc")
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
-- 
2.20.1


