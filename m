Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF710C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD70020786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB5ldr8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD70020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJ20-00029z-2s
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyW-0003Uq-3h
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40540)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyU-0006ho-DU
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id f139so8926268wmf.5
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E9CuosGjk9g394MPaOCwB+YyiSzHRQhNU7g8s+eLFcU=;
 b=FB5ldr8osz/TSX0u/QFjRhnpH0+caCl5rAhip61Uuth6uGTdVdVV6J4iewPPBbxaUc
 hpaVH52rzxRgCukPcmqICXXelHyibjwSr9EjORG/x9WIhYxgnM/x0N3B7lcu9VF5DpX5
 76967JUM87Zy0YBfGtCNtQ0VgGTSpCdjrhbtyY/vUZJgSGA8/RmhZGvJPjPshNtSlarV
 MRzOxMgoShLkr4a5qRplWp6cZ1K+C/0tJe794U1Iee+vD8i5jJsBir4GPhTEVFuwzVfv
 VhFXiwpnKUXlO2twc8qaUutFNZcuXFxQXJCpKuM+C4GzXb65mqLR4NB+2g93FgCEfUFU
 n59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E9CuosGjk9g394MPaOCwB+YyiSzHRQhNU7g8s+eLFcU=;
 b=NOCeISqLDKDKPmQc32MzLZO6oBgJhW6Ke11rgvFUHMitkupHLkeYhv1g214evrDQHz
 2ACtE+Tu6CVhIjlORqc4kdtdv/RLKnohdNDwuYMK6c1v/pELz+6cBnZzvX9Ui9TKlvgb
 LxGRX9cRuqLjp2/PEGuD7r8Ja8fBMYDKRYAXEpvOm/YU83z1Hh9emDxwzOBnp6Y632ev
 b3hfD7N/RQnHyo0US98xqPmBNpHvGsc+MEJyKe2w6NwdSR4MUAWX1K7y7pS1gxUs/eS1
 wwvSc7SHe11AhNx8plSi5I9exnSqmCB8xmQpGaFCd9xwvQyAzULAI9Esqgzy/FFcLz4d
 LnvA==
X-Gm-Message-State: AOAM532hq09Ha75uUbovFC8g8kWT/wLB9vick0XtbaEOdNw57SxnU1EZ
 XJReH9x12JcFplmaagGlXd6NvA==
X-Google-Smtp-Source: ABdhPJzSWzViRVqTwJfNwLRlBR5WoRdyO5arEvu0JcaSzRZeq5uBSe7APyVx603uyQA/b6FWfMQ4BA==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr11473311wmc.106.1594487261113; 
 Sat, 11 Jul 2020 10:07:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm17558674wrh.54.2020.07.11.10.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91BF91FF91;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 45/50] tests/docker: fall back more gracefully when pull
 fails
Date: Sat, 11 Jul 2020 18:07:27 +0100
Message-Id: <20200711170732.26213-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I only spotted this in the small window between my testing with my
registry while waiting for the gitlab PR to go in. As we pre-pull the
registry image we know if that fails there isn't any point attempting
to use the cache. Fall back to the way we used to do it at that point.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200709141327.14631-12-alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9684f07bde..2d67bbd15a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -306,13 +306,14 @@ class Docker(object):
         checksum = _text_checksum(_dockerfile_preprocess(dockerfile))
 
         if registry is not None:
-            dockerfile = dockerfile.replace("FROM qemu/",
-                                            "FROM %s/qemu/" %
-                                            (registry))
             # see if we can fetch a cache copy, may fail...
             pull_args = ["pull", "%s/%s" % (registry, tag)]
-            self._do(pull_args, quiet=quiet)
-
+            if self._do(pull_args, quiet=quiet) == 0:
+                dockerfile = dockerfile.replace("FROM qemu/",
+                                                "FROM %s/qemu/" %
+                                                (registry))
+            else:
+                registry = None
 
         tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
                                              encoding='utf-8',
-- 
2.20.1


