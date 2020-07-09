Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01ABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC642073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OETuDee/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC642073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXOr-0000kT-Vx
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXJ5-0000WQ-SD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXJ4-0001Lj-9m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id o2so1980048wmh.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CYKi9P2sb/KSIxgc0hWiYAqxm+j/yuO8AIw+hiHGW8Q=;
 b=OETuDee/gKUepqTzzA/1/0eB6wAG5xehvoDlGLBs6bNt2ti9btU+hhAceHcDMOYElT
 rzL7GxahM3ZtGIcsloTe5H34ZbCaXhwhVxidIu9dWtneytypgR2+6p7kbKybc/uLVuLR
 shPjIkRoE8lo5jqdnxkr6oflWTh/8MXHMQZjNqx22W/n+vOxOJL0yDbnCjMzEddyo3OU
 +abbvrojblXAchnsJBI6d5Djn2XdAQSxw5zs8iBoCnATDepT1YGYCpX6rNuvYp2i83H3
 4ZGk1NA5kGETuGUzngktPYxVBjVuNGHqmF3U690GCQjt03fSfncTQruQPW4e5OiSrOFb
 8O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CYKi9P2sb/KSIxgc0hWiYAqxm+j/yuO8AIw+hiHGW8Q=;
 b=MJKovdGgXHUwaPOVnV6lzEuEZwuOkHEi57mJHvRMrUWGAhK/B8TESBnFRkORUwDTPe
 147EG6kXBqHpTHTirD/5+Qp30jiirKLuzhValM4/uMve+9/Jh/x/73uhM261rey1AscW
 /FU5V/faGxLggnNQJhJZ3yUUn5v9lPqTsE6VEIrJFlCc1RCyxiV3o1JHzdBN/4BNxOG9
 Q5XiTLrCqgDWEcb8p87oP4RYpIXuGLQu6zOr/25wN6IOola5LuhxdJt+M49JR3FV5HPW
 53aTXOCMTDTE6T4JNxcy9mrcir3G6c22aSGW68E/WWaHEPRCjys+jrTYEfxf4J1Yc2JV
 gGuQ==
X-Gm-Message-State: AOAM532RXY+DqZBQgZxn22+M6kUVa01HSXLf2AQHRmfbITFylv1O/jXj
 2Eq9xbDQqu6KUa+b4HU17SZtkw==
X-Google-Smtp-Source: ABdhPJwkZeCZEfVW5RqQTV63WvCaNdyx1TrfFh/9NAamKk1BnPKryAqsZwDaZWuQ29dEnjELNd+z+A==
X-Received: by 2002:a1c:f60d:: with SMTP id w13mr215476wmc.51.1594304021844;
 Thu, 09 Jul 2020 07:13:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm4932417wmc.1.2020.07.09.07.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6EF8E1FF9A;
 Thu,  9 Jul 2020 15:13:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 11/13] tests/docker: fall back more gracefully when pull
 fails
Date: Thu,  9 Jul 2020 15:13:25 +0100
Message-Id: <20200709141327.14631-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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

I only spotted this in the small window between my testing with my
registry while waiting for the gitlab PR to go in. As we pre-pull the
registry image we know if that fails there isn't any point attempting
to use the cache. Fall back to the way we used to do it at that point.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9684f07bdebe..2d67bbd15a5b 100755
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


