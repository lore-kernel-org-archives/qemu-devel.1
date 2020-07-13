Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9913BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6465C20674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRoIvctJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6465C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4kF-0006fW-L6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gb-0007zx-Qe
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4ga-0006Gg-6W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id l17so1153429wmj.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zYmy6YbAdYCCn5X7N7JnznTD44q8kk8nDaLydetiUF4=;
 b=iRoIvctJRweIWyuMWsjAtE8+JehMQIOHYYgkXVVIUgeOajqBilO/1mv4VT3kLduKqH
 Rdg5OhIxUXu7LbK67T5qfGAPbc2BUbtDrNnS0g5Axfio4PVe3bsdDRes7jHLLZzXXm/z
 iIwMbORvDonXZlZqGuI3boDjSOFy/TfKyTFhpeEjqXOBFm3V4aoU4EvfHqGD2/4uCnNu
 i53jSVpmZRtkTVQEqACbZGjXNMoO0NUCDuV2sfHuMjOcGd6UK+WfBAudmxK6PM1CzSE5
 RMC3OgP6rcORKhr3QL0sia9O8g+pg9ih25NnHtU4zlCEir5cR3mcs2+k+6c+OgHOqhE+
 sDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zYmy6YbAdYCCn5X7N7JnznTD44q8kk8nDaLydetiUF4=;
 b=HNqmLK5dHVdgpgJtIVE1zXsqWdj3j/UAtVUqro/3EibFBXt8iH1Gjv1i41JCGd0/cc
 0JQvlTLt2W6FnXvpzW+2gPcC7FeRqL9W4cgTUo6bndBOzUo4xQr2DyK2FrM+Oaa6bs0i
 KAzgN+npg6dzn6DCU+A2i0HfblM4ZpZdpspGjkMRyM6xVRhDYgsUn+r3sDY7InccoOzH
 heCOPWA5aOKi7JYrCvPTlXt9/swTj9sL4O3a9SXzlHuM7miC3vVuOeFGs1rrzRE9WtII
 gFnV+0Ro8eOrwR562iczceVelI5foC3mcZqItTFTqz/rDIoSXFqvjxIrczNluOULO4rs
 akTA==
X-Gm-Message-State: AOAM5334BpKciG5PG37g1NI5H919uEpnFBDadrtn0j3xmfijB8IWH+PM
 oBD8ZcOX21rQf0Q8b+/44/ZBQw==
X-Google-Smtp-Source: ABdhPJzSrbKIXuJ8ILQ/QnaQ/CNa5R0OBK58LYhieUHmOMwKHju6XbS+JqIXxVUYBU5CWTYEzuZVKg==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr1071156wme.42.1594670662723; 
 Mon, 13 Jul 2020 13:04:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w16sm30261370wrg.95.2020.07.13.13.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D86141FF8F;
 Mon, 13 Jul 2020 21:04:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 03/11] docker.py: fix fetching of FROM layers
Date: Mon, 13 Jul 2020 21:04:07 +0100
Message-Id: <20200713200415.26214-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This worked on a system that was already bootstrapped because the
stage 2 images already existed even if they wouldn't be used. What we
should have pulled down was the FROM line containers first because
building on gitlab doesn't have the advantage of using our build
system to build the pre-requisite bits.

We still pull the image we want to build just in case we can use the
cached data.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/docker.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 2d67bbd15a..c9f20d8d09 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -306,14 +306,18 @@ class Docker(object):
         checksum = _text_checksum(_dockerfile_preprocess(dockerfile))
 
         if registry is not None:
-            # see if we can fetch a cache copy, may fail...
-            pull_args = ["pull", "%s/%s" % (registry, tag)]
-            if self._do(pull_args, quiet=quiet) == 0:
+            sources = re.findall("FROM qemu\/(.*)", dockerfile)
+            # Fetch any cache layers we can, may fail
+            for s in sources:
+                pull_args = ["pull", "%s/qemu/%s" % (registry, s)]
+                if self._do(pull_args, quiet=quiet) != 0:
+                    registry = None
+                    break
+            # Make substitutions
+            if registry is not None:
                 dockerfile = dockerfile.replace("FROM qemu/",
                                                 "FROM %s/qemu/" %
                                                 (registry))
-            else:
-                registry = None
 
         tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
                                              encoding='utf-8',
@@ -339,6 +343,8 @@ class Docker(object):
             build_args += ["--build-arg", "BUILDKIT_INLINE_CACHE=1"]
 
         if registry is not None:
+            pull_args = ["pull", "%s/%s" % (registry, tag)]
+            self._do(pull_args, quiet=quiet)
             cache = "%s/%s" % (registry, tag)
             build_args += ["--cache-from", cache]
         build_args += argv
-- 
2.20.1


