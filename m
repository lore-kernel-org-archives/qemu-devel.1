Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0BEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC1A20792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZDzRaTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC1A20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp5W-00087L-Lq
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2L-0001qf-CQ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41933)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2J-0007an-Rl
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id j10so10837897wrw.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BULJelpXGG4oceHKJESiwUE25IojeXa0K35GUnG/ea0=;
 b=UZDzRaTHfRMdBdOMrvC/dUnp3bt3JxhmGE+AMmZjOYwCotpleoL6YjttZr9wpknCY0
 pKVDcJdFwGaMWXSaaaibrywS2QextLgBnI9MxCFjVerpgL+eATsi/+dQZ/1hOdRLQr8g
 3WFkAGaPaN+03O6+5yGKARJ9kgR42drWLKzcflFMt9A+aMPEEyeUshU6o3vqc+IhN9+X
 2oqnDyqSQeLPgTBCJt5Tq9J0037enXYhz5rwKqqmsGBqFGQX1L/lBTnMOKrdviu577WN
 Kx8qbiotoWmmSTOgVFW/S1KaE+1HzkBevzgRHtpkzFew2LIEp2lzXDdrRK4zEoHLlVVw
 kcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BULJelpXGG4oceHKJESiwUE25IojeXa0K35GUnG/ea0=;
 b=ktSM4dKchE/FrRu96A3iUiM7fV1n5a7SZnh6R2vyWPgOR/eUEYnY+yQ9krKMmFpYGU
 fR8Zl7w4VA2iH9fLusz6KHdDuhL1a0XWNcY3K/1EcU9b0irKwa6+ow/KGZIMsn0NuRFF
 tUniJJGx6I1KDOEXbmqfL8rdLh/lW1h89C5dgYyEzeINOoXed2qA/vB3DTg+MRgQqJV7
 dhLjXwIrWk9fnZ/f9GckBgxnEl0G1KBA1ePC4Ykh0GLJzUIL0cKQ4qT7p7Y1HOFp/P5q
 HhFmn3YywTBQR9Oka6JFK5nXz9yvToZiZUn4UD9t1SYqvv4371DHaSK2Rcedzz71/S6b
 Jm9A==
X-Gm-Message-State: AOAM532HVUmPgOGyM3aDiyv+jP2gJ9eZRNBb/LXVmK49CuAfPN66VjzM
 ArtGu7RVrHnljq2fxqxTj6spWg==
X-Google-Smtp-Source: ABdhPJz/AbuxjPc2UFjO1ztytRYs48mNHG7j62ivs/2R+mxDNfWhcPn4Oq4k4RaYE36BZKHHKZy/dA==
X-Received: by 2002:a1c:4189:: with SMTP id o131mr321693wma.183.1591988890779; 
 Fri, 12 Jun 2020 12:08:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z8sm11339099wru.33.2020.06.12.12.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:08:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 184761FFA5;
 Fri, 12 Jun 2020 20:02:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 18/18] cirrus.yml: serialise make check
Date: Fri, 12 Jun 2020 20:02:37 +0100
Message-Id: <20200612190237.30436-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do this on our other platforms to make it easier to see what has
broken.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index ce7850a320e..69342ae031b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -14,7 +14,7 @@ freebsd_12_task:
     - cd build
     - ../configure || { cat config.log; exit 1; }
     - gmake -j8
-    - gmake -j8 V=1 check
+    - gmake V=1 check
 
 macos_task:
   osx_instance:
@@ -26,7 +26,7 @@ macos_task:
     - cd build
     - ../configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check -j$(sysctl -n hw.ncpu)
+    - gmake check
 
 macos_xcode_task:
   osx_instance:
@@ -39,4 +39,4 @@ macos_xcode_task:
     - cd build
     - ../configure --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check -j$(sysctl -n hw.ncpu)
+    - gmake check
-- 
2.20.1


