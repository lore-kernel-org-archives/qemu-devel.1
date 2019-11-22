Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E33AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC9720679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogcbkAU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC9720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY73Q-0004Dl-8J
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iY71M-00018e-IG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iY71L-0003gl-6M
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iY71L-0003gQ-0U
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:39 -0500
Received: by mail-wm1-x343.google.com with SMTP id n188so5233922wme.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KKcSFjLEc9pMOuNeERmTc4UAB4wYmWhCfSPB7yES0w4=;
 b=ogcbkAU3+OtUvHehJqBcpLuWEmQ4Dblaw/UGf9Xb1sq658wyLP2HbnMYjrSvuFt4KA
 5/b+wQeesgn5sQHrZiY7LM27TDr8gpXYCJcvEyfyR61vPAxEu9yeTz3i6fUvUNXK+bu6
 SO38HQGymMcXP+4QrRGqEBJBjaJVrpjycPDNyz9QqjPZWL4U2LoJPgmYsdP+9R5Gv6nH
 W3hQVtzHgQTNUm8dS/ecGMtMYFd5dgI7d5taIvxvwTvBNvI0zLZtrln2HUTGLoA99zAy
 GVL+3MIQh73oLFvE+ZgPgrbrPVqZD2l7/o1IX4qcY6JCqoY9WkF2yJwvtK8UsYXfLaLq
 KY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KKcSFjLEc9pMOuNeERmTc4UAB4wYmWhCfSPB7yES0w4=;
 b=WGvd3gnllMxSTAp8JtIFmlXA+xr23xnCH9w8Ji1szhxKEUf0VhXSls7c0wqg/sRokh
 UqcXvF3QXawEdoz+oXOiZxbJocPMe11OvytGOeYhS/tsgKeunIFMHomzFgRNYIqbOPNN
 Dgytwpznyc6QOtsFFpaQjFX6ZM7jJPaSXBe7c/46p353s7x2Ob+CKd631OWed0cbsxAf
 llhuaoYXHsPMpt01dsp3ZRC1mcOKZQja+EWHUWP4vU6rp1VIgdWN9xGxE45z3sudiehs
 qBFLh7v9dvrR1oaDAevYtV0MUL6c6A+nBoCYKIDyTZviXyjC6BxfS0SDSBI5qfAFF7C7
 gPFg==
X-Gm-Message-State: APjAAAVlrGip4Swqgo4z0zsa+Y08vA2Ns8asQ+t2IisVgP4BrcBxAZX6
 zVYgpRJ3JdFRd2Bsc65DoWltow==
X-Google-Smtp-Source: APXvYqwlwHeUXEKR2tFFRZ1RDbBv8Ct7z2lm4vdOUW/sGLW0dmS+19cBGS7Y1YH+oEiV9beUcvCMuQ==
X-Received: by 2002:a1c:7701:: with SMTP id t1mr16853472wmi.113.1574421757884; 
 Fri, 22 Nov 2019 03:22:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c1sm5825758wrs.24.2019.11.22.03.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 03:22:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4563A1FF90;
 Fri, 22 Nov 2019 11:22:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 3/3] tests/vm/ubuntu: update i386 image to 18.04
Date: Fri, 22 Nov 2019 11:22:31 +0000
Message-Id: <20191122112231.18431-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122112231.18431-1-alex.bennee@linaro.org>
References: <20191122112231.18431-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current image is broken while running qtests but the bug go away
when built with a newer Ubuntu i386 image. I was unable to replicate
the crash on Debian Buster for i386 either so I'm concluding it is a
distro problem. Let's paper over that crack by updating our 32 bir
test image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/ubuntu.i386 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 18b1ea2b72c..f611bebdc9d 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -66,8 +66,8 @@ class UbuntuX86VM(basevm.BaseVM):
 
     def build_image(self, img):
         cimg = self._download_with_cache(
-            "https://cloud-images.ubuntu.com/releases/16.04/release-20190605/ubuntu-16.04-server-cloudimg-i386-disk1.img",
-            sha256sum="e30091144c73483822b7c27193e9d47346dd1064229da577c3fedcf943f7cfcc")
+            "https://cloud-images.ubuntu.com/releases/bionic/release-20191114/ubuntu-18.04-server-cloudimg-i386.img",
+            sha256sum="28969840626d1ea80bb249c08eef1a4533e8904aa51a327b40f37ac4b4ff04ef")
         img_tmp = img + ".tmp"
         subprocess.check_call(["cp", "-f", cimg, img_tmp])
         subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
-- 
2.20.1


