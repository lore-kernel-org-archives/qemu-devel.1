Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4301CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054CD2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAYMMGdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054CD2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzve-0002HP-93
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juzuG-00013y-OZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:58:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juzuE-000724-O3
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:58:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id q5so16916143wru.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zjzJwG+hzX+Xi4FXzxMFQFE1NjjjSG71gG40wiP+lds=;
 b=QAYMMGdX5UCPBnIyngsxzUjKEq4Krs8j1zv8rTzNc15x8nFhqCnyOJ4tmu/filXhjd
 vg+JopimTl79sBUtYzREFrVxBnutRJi0lK1kMHb/XxS7FyUJ+MqXj6LK9BMbTjcD+eGU
 hVB/wFumz94CNjAr9N8QRiTkIIPAnLW8TTXqN46BQnEr7dfvqmpLYxr5+rN711JGyUOU
 sohul8l46CrlWHPjHT9qd1l+ncw3uZ1zmwuP6dJGD2ktza71HcduOfxRbEYMoDH22Gj5
 t5DT9YBBe2WgWVPtBBg/uNUgoF0Fnq8pyVOdtpQ1n7YQdJDm1fYUuu8ozw2E6Byd96Gt
 Q0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zjzJwG+hzX+Xi4FXzxMFQFE1NjjjSG71gG40wiP+lds=;
 b=QBjoF7M9XrV6DrG0tVxCB5z9N5lWmqIMj4HzKA24Pvevk7/340dBhQ/mSPIfY/aWbF
 yba7EYn2hn+Jqu7FOQwn8cFSRuBTXJCgWon9m9x2jMayW8TXlxCjroyMm79d3JSEfE8s
 LVh3hPmUPpAF0ycBVl4JChMIgNgSPlwBprXV/g4c7qp+RrsZ4vL1qa+udJNVn8yJG01+
 BjMhGUeRUaL5zUdHuiQ8X3j2viFQ9CdQufIiSbA4cDbj682Pr1y+f7f3QZrCBt4Zxr7X
 zrfPD3JzKjibUGTNIVCf1hQYf0edpk/seAfmtbtkmA00XYi70lHd+CpxSptZb3Nq9HtL
 6QiQ==
X-Gm-Message-State: AOAM533Zb5cLfBIshazwJaEMWZ1yep7k9tYX1m8c4zdjNnd8Hgn7brl6
 qpXaJ5EZyFVNYrzwVMBdbx9APA==
X-Google-Smtp-Source: ABdhPJzKuCpjKIajxCw83Taz0lXEJreq7YcP5J0vwG0dNBzavemBr9qF/T4x/RWCtF2JrvqlM1vRTw==
X-Received: by 2002:adf:f104:: with SMTP id r4mr83820168wro.90.1594652288900; 
 Mon, 13 Jul 2020 07:58:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm23694247wrs.1.2020.07.13.07.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:58:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B9DE1FF7E;
 Mon, 13 Jul 2020 15:58:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] docker.py: fix fetching of FROM layers
Date: Mon, 13 Jul 2020 15:58:01 +0100
Message-Id: <20200713145801.29278-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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


