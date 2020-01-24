Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F727C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EABA2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="njASb2Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EABA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5qa-0001vY-J1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ku-000849-Kq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kt-00062Z-J0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5kt-0005ym-Cs
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:39 -0500
Received: by mail-wr1-x443.google.com with SMTP id q6so3562389wro.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/e7JMoVkTL0YKCvYVnwUpluBW/+JXre0urP4WxCc+Fo=;
 b=njASb2Z4HS1dS6ACGg4UJLEI/O8RRNj12xgogyBc129TZFz/7pP7fYHHKhzfXWsfDF
 WEfcL8/XhZxrFFFsSN5LRdcKcsbGTVZckN+RLpWJRH4hY+RQf6J4NTtHOlF1DG2Bkg7R
 FuOULJxMcoCOOVuMG+jPyZx/DVJ6kns+yG2JQmkKQtEFaPY05THZFlnwQwlChFjo69qx
 Kp0H9XYZb1BBy5xc61h6X4u7mIeVHie1XGp5cM1d4j66r0M+kR6630Vi8rGuzJQgcmXR
 4GzVO9uuouNh7zt74FGs9PCCreEJ7OhjAZtdFsEBp7f7YU5B2of8RY9ANbeY7roX54bK
 6lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/e7JMoVkTL0YKCvYVnwUpluBW/+JXre0urP4WxCc+Fo=;
 b=GqgMI5RdvpgKNtmJSNIXn8kyEXS/gllAGZPk0kEe52s4xNEMPrzouPIh/yCDf/yvIB
 F2pDZWHc4OeDt1GE1Md/Vdkfs2mk+V9njLscS5O5WISLAf7T6YuxNfyL41im3ntKfQH6
 f1s1xE2/K6R0adSzHqArb7eA+MJ6gI0MKGpsSNWgvBoGmKqrI64yGAfdA3BuBoB570+b
 th2XzF4VSX5tAg9fbc6I9hXOeb/DQHg/WpNkzGcrUxEvoh/a5MjLabpZFRHqfdjE0429
 QOGBdQ4GmkykHsI83eYBngT7Nv/Taq8nK6T152AJ27GsEBODAMp6zyUzgpQrlen0TFVF
 Fk5g==
X-Gm-Message-State: APjAAAUHSKouOWDZQ9cvRwW4E/iT46B8cSlujKaz22TdduOArewvtMmi
 d/aVQZ7p8MOSBDJSPQVJ0zlvHA==
X-Google-Smtp-Source: APXvYqwhCtlbwkoHD2lDPeWQTl7db9w2SN7joRX+EF7YdLH6pfmBklQ7cQhDaWc7jUaIMhdDQWzkKQ==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr6271916wrt.343.1579898438340; 
 Fri, 24 Jan 2020 12:40:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm8864167wrt.37.2020.01.24.12.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1CE311FF98;
 Fri, 24 Jan 2020 20:40:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/13] tests/docker: search the tests/docker tree to inline
 parent dockerfile
Date: Fri, 24 Jan 2020 20:40:21 +0000
Message-Id: <20200124204026.2107-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The changes to a multi-directory set of dockerfiles means we can't
rely on hardcoding any more. Just search down the tree until we find
the file we are looking for.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 7dfca63fe4..892d70b568 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -189,9 +189,10 @@ def _read_qemu_dockerfile(img_name):
     if img_name.startswith("debian") and img_name.endswith("user"):
         img_name = "debian-bootstrap"
 
-    df = os.path.join(os.path.dirname(__file__), "dockerfiles",
-                      img_name + ".docker")
-    return _read_dockerfile(df)
+    dockerfile = img_name + ".docker"
+    for root, dirs, files in os.walk(os.path.dirname(__file__)):
+        if dockerfile in files:
+            return _read_dockerfile(os.path.join(root, dockerfile))
 
 
 def _dockerfile_preprocess(df):
-- 
2.20.1


