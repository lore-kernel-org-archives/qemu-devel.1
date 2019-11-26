Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137A5C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F8D2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 12:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCfpE4aX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F8D2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZZdU-0006ea-Tf
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 07:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZL-00029N-Nx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iZZZK-0003uX-GZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:47 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iZZZK-0003u1-AL
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 07:03:46 -0500
Received: by mail-wm1-x333.google.com with SMTP id f129so3012526wmf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 04:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EZvC6M5Okiw6xdR39XJHzGm7uhokIaGLNODjax7GyCw=;
 b=gCfpE4aX8PLZC1ubNw3yy8FpMZ0K99otPpJtkS11m4P63NFXWS0djo4VMgOplsP8Uk
 hUuntBWZt4KjH7LKP8tE1cv3RMZaTgwx+KCJGfCyzfStEpFm/6G/YEA5RMXt2AdOEY6V
 pIFywhc7CY38zNoyJt/qBtwftuydPIZOl1C0qfFB12UhCPnymnWELgWvOIY+BuUmZBuk
 J+vyO9GgD9C+07zP6Utvtj8uYltsmKrzem6JBCgQwbLoxfklxXpF09WOV6eVZ8h2hn4p
 rJB6P7LGvsjL3lfUTcUT3nT2ahspn68GGnWfAy22mtzS0tXMRLUmFTOENKKTay1pi04i
 W6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EZvC6M5Okiw6xdR39XJHzGm7uhokIaGLNODjax7GyCw=;
 b=dmrm8xKhG7RPwfi+t04v1locFxzNyUQ1jCEerK6ZsicdvIu5T+2qxERZqRbNFC5b8b
 P1WrIxfg8DLu8ZOmdPbHxqxFEFY5uiRkc8MZWlOdEsfawrdeC4SIeJz+zz1gLbQ2sV/Z
 nh1YJBEdHxqpzVpePbk307Ha+wuBuCMLwl3Inkd7wu3bqsK/+heteQ1ECeNPFdOjku8f
 6feB7CHZ/+5sSRPKPoDAd/nbcuGxeVjivGmdOo7kPLzGXv27iVzrqncBPK5LQvbs6pZO
 rD3/qwAFTdFhlicOgJe7zSsHtwaZRoZPz40SgnDkkO4nuw0TUvveM5attr/Pm2rWcr8I
 I2cw==
X-Gm-Message-State: APjAAAW03E0ZX8XK6tq+oZOOISIjsBqUmf/g2Gz7WQ8swEzfLp5kyqq7
 ARJvIzUZjW4JIHmPUXVJO9/qkg==
X-Google-Smtp-Source: APXvYqxTwTvLUg9+vEezzgyc5lZ3r5hZ/dagDMgXa17tV40oxfBMXkeVHiqCukh6BZ2fH/OBJm7oUQ==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr3917550wmi.141.1574769825068; 
 Tue, 26 Nov 2019 04:03:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm14572964wrq.22.2019.11.26.04.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 04:03:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5E921FF90;
 Tue, 26 Nov 2019 12:03:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/3] tests/vm/ubuntu: update i386 image to 18.04
Date: Tue, 26 Nov 2019 12:03:39 +0000
Message-Id: <20191126120339.18059-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126120339.18059-1-alex.bennee@linaro.org>
References: <20191126120339.18059-1-alex.bennee@linaro.org>
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current image is broken while running qtests but the bug go away
when built with a newer Ubuntu i386 image. I was unable to replicate
the crash on Debian Buster for i386 either so I'm concluding it is a
distro problem. Let's paper over that crack by updating our 32 bir
test image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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


