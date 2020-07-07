Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4D5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B4D2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E40GmlbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B4D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshwD-0006Ns-9R
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoU-00076I-1e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoS-0004vB-C8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id f18so45349343wml.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zR5BJqrW2UupwJs+QSJfBgbca4bCAOfpAid0iolRfp8=;
 b=E40GmlbH5NU8U5ZP+dpwlPsLKoqCj+kM280DWC/BvC0BCvQmZckY6SiD1nX2RTLkGh
 uQ8Bzp1t8BQBkMcaCElhRpcN1apmOr5kD6dZrIj1PAeOWbYQBBhd/QS+z+oylJc8N1xf
 Mt09FGGt4PwNQGn8GnY1/LONPGfu+BRjUJ0NFA4Z71h/RykUHUZN5ZPm8Txv326ZXKbJ
 MuA04qaPdVudbgIEdWC+XY4HwLrXZkA5/NL2pPuHDTug62QFeS3VFfeiOa+T1jyj0hmc
 9qA/nlXfqzFVTIGY+3ylqzzJN+CtuC1Vg4tqjFXZ19O+HqpPvjOBx2Zt8YwZUEfjwyQQ
 UiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zR5BJqrW2UupwJs+QSJfBgbca4bCAOfpAid0iolRfp8=;
 b=IxjPE/rFFOgwqarXaHqanM7Lls9/2zcA5M/TuQcJKNHNVjswdA7T6lI3mewGNDzf0A
 q/BKc1LbWfvC6U9EE7VaMQsDlwnEPXF82QF20bAVobmBt7g7xMenhISCADMuPKFQMIEc
 uvcYFiy54A1ZvZshyfrwppgv9k2RZMEyodshAodrC6PjvhGe4IYv3ytsWCm/0sdH393q
 AQ1XaLEALnI2bloYucctqQyvOHipkjYw76jvYuf46tKR8Ai7yiBFM+Y/zeBxaaGNqJWF
 o3FOWerIbdQOAgVLjwY42XTXe5bBdfSKwDMBK2PyjQDk9Vcq4TDj5Zyt4k4yZPr8Q1lz
 AC8Q==
X-Gm-Message-State: AOAM530tPdNuL3DydejciuyfSHBZ9CtJ3fHdpo+aiaA3jrrY8hXAmgHA
 woMdFecZSxSJHFq+T7pAQXrgsg==
X-Google-Smtp-Source: ABdhPJwQmSNBqxWQGvGqpqXU7TtMKBiY1YYvF4FFXJVJNaYgZCZ+KhJuj2n8UTLqorIF3oBNBS4Tpw==
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr2627522wmz.124.1594106081675; 
 Tue, 07 Jul 2020 00:14:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e23sm2106022wme.35.2020.07.07.00.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B3DF01FFBA;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 32/41] gitlab: enable check-tcg for linux-user tests
Date: Tue,  7 Jul 2020 08:08:49 +0100
Message-Id: <20200707070858.6622-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Switch to building in the new debian-all-test-cross image which has
most of the cross compilers inline.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200701135652.1366-35-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 93baf98232d7..257947853b72 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -143,10 +143,9 @@ build-tcg-disabled:
 build-user:
   <<: *native_build_job_definition
   variables:
-    IMAGE: ubuntu2004
-    CONFIGURE_ARGS: --disable-system --disable-guest-agent
-      --disable-capstone --disable-slirp --disable-fdt
-    MAKE_CHECK_ARGS:  run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system
+    MAKE_CHECK_ARGS: check-tcg
 
 build-clang:
   <<: *native_build_job_definition
-- 
2.20.1


