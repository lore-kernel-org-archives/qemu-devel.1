Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73718C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BA920702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAiPPEbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BA920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsi0c-00061f-FM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoM-0006rs-2u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoK-0004s1-GC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id j4so41571838wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nOeMTB5/6ChZR/18ZGCbrQXiHpw625FcDhLOCmlCX1o=;
 b=yAiPPEbX2CYDYS2BhR0qKxR2ADauDnMYTz56i0ATRL5hQii9XZi3rt0tf+pg0w/k6K
 wuQGw7dBTQaI4VMLCFFtMGRjB19BFxt4SvA7NPpriXcdh3ZRmSrjWVsHs2pbi/S9k6Br
 QyHEfdKRGBDnEUNEkGP21mdKfZu6PLWHzRP5RAAa2fnTQvkE3HGBTgQGqzm5lN2p5/mc
 /q+Wk5cauAlToqqSu+mnB3Ng653PWX5I+DCyZuv/b8bfQWc9jmfWYYuwEiuVjUHEueM9
 g7pvWljeVx9y6Vipdp+dx9OwORwfxplVTF9a+6II6YjQfTERGWVYpG6RM04JaggtEykt
 chFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nOeMTB5/6ChZR/18ZGCbrQXiHpw625FcDhLOCmlCX1o=;
 b=THiZ3SCjzMIZH98Cvxvz57XzMGiga5MLkJv3Xj8oaSFJR6oXM2jlaK7PRolx/wkW9O
 XRp8Vz8T4vAfZF1ROGXlN4OBSRpudXGxsxLrTTBmFMzvdbHI4tSTDYbTjq19Oqe0jSGf
 Dpfrhctm7NcpSLChUvzVPxuPi+bvWioXit0huqwhMqn1uVk8AIL0+iLt4CKXAqRhUPBg
 XPjwvjkj8B5AiFAjiUd4OmIr5AJkh08KOjxT2XI05fzubpwz/L1s3COycU2gYRQdsB5Z
 jtmkR3zexsRfT2dj9oWIY5PRcjyi4amIRuaxoDSJrnls5mzYHocSw9EZcTfretg93zo5
 F+ww==
X-Gm-Message-State: AOAM532f4VIX58k1QjPbNmjNQNh0Ks/2qzG0QjxSxkN2ckuWxIVLUM73
 nn3BiDUFpAnqIKBVfBViKe6sMg==
X-Google-Smtp-Source: ABdhPJxNKMQ3ly21sFhm8+o5JOFwvQ0H846xEUc/H5X6uxYsStTAAiHRFRsmZFX4/5twZ7XyPHIryQ==
X-Received: by 2002:a5d:4b44:: with SMTP id w4mr52893767wrs.275.1594106075180; 
 Tue, 07 Jul 2020 00:14:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h5sm3076543wrc.97.2020.07.07.00.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DED0B1FF8F;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 34/41] gitlab: split build-disabled into two phases
Date: Tue,  7 Jul 2020 08:08:51 +0100
Message-Id: <20200707070858.6622-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we run check-qtest in "SLOW" mode this can timeout so split into
two jobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>

Message-Id: <20200701135652.1366-37-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 13e9531724d2..83e38ea19f3d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -113,7 +113,7 @@ acceptance-system-fedora-alt:
     MAKE_CHECK_ARGS: check-acceptance
   <<: *post_acceptance
 
-build-disabled:
+build-system-fedora-disabled:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
@@ -124,6 +124,17 @@ build-disabled:
       --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
       --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
     TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
+  artifacts:
+    paths:
+      - build
+
+qtest-system-fedora-disabled:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-system-fedora-disabled
+      artifacts: true
+  variables:
+    IMAGE: fedora
     MAKE_CHECK_ARGS: check-qtest SPEED=slow
 
 build-tcg-disabled:
-- 
2.20.1


