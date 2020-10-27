Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD88FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5872621D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYUd285e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5872621D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLrL-0004cI-AB
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlc-0006iL-SC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:48 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlb-0000Px-3z
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id y12so1151794wrp.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ri9ZPbou4O80XpPc4WvyYHSH7gy/FoC28327DlYeuec=;
 b=zYUd285elqVuf73XY/0ewPWK+rlda7UFTaZITM71ZPSRtQIws1m48QD4fsgSQgIDVa
 SDVsnGXK6gTx/SR6EorAAeAFrQ6zcZbwnxgL0/i/hSMgSQ6tQoBhp7hZFeESLgTMeDYf
 o1mxMK0KqiqkzvDF+I1q1MyGFz2Va2mhJ4TW6LyU8EnLArbb5NJwq2BY/YnWuX60Rzln
 3//J7tEGaHvVe5YO026GuyNU9+QfIOw8Drk0+nVhaBr/V0RE7zcTgjXWCe9YLryvyMoT
 //+Uyf1RT6NGIt8ugmZVm1vnDfwe8apk60zqUtXK9xxHEcGBUFR8AxCEoRhg36UjFZWf
 Koxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ri9ZPbou4O80XpPc4WvyYHSH7gy/FoC28327DlYeuec=;
 b=ev5mLkhB8L94QYGoeguER/MbogUa5BOluzb5qOurFU9YeZNXwhEL/Iym6fkoYR6exR
 paDX/OfjnUg+qwWt88t0wm6purZpWhSBmToK/xtu/DslmYQxP0WjDkmCVp/Q8/OhNgfv
 e7lOR8tRZpdOiedWLaHQH141qAI9w8BfsizLnyFiIO+U4yxjOyF4j2knu1X3nayLwMLN
 01p2DsyIfWmyFoIKWwKqAdRynwJvSoCq8Dp136odnwb4l6N/ntW84MetDqqgmIM43f5n
 yXXq5WDSYhvJqfc4AELJqG7U9ZPxYoVSHlg84D0IhMgwNqkK4DHuVoPKn1pxj3dynRzX
 Ugbg==
X-Gm-Message-State: AOAM531uPCuNcZaKOkOGyY9+oNXGyHZYydSR/GQlC4Ti3v094vz6MszL
 XPSXtKxY+LHOKebcsBohICdFLLzy1T3ARw==
X-Google-Smtp-Source: ABdhPJzQSyGgq/6uEkOnFKix+fxaKCxELewlTQ4ZZBmUkuuNSrFknz0lDnZMGvzS7Q6Rr7csf6Z7Eg==
X-Received: by 2002:adf:bc13:: with SMTP id s19mr1901073wrg.338.1603792785826; 
 Tue, 27 Oct 2020 02:59:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm1368226wru.15.2020.10.27.02.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 241861FF90;
 Tue, 27 Oct 2020 09:59:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 4/8] gitlab: skip checkpatch.pl checks if no commit delta on
 branch
Date: Tue, 27 Oct 2020 09:59:34 +0000
Message-Id: <20201027095938.28673-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
References: <20201027095938.28673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

If the current branch is synced to the current upstream git master,
there are no commits that need checking. This causes checkpatch.pl
to print an error that it found no commits. We need to avoid calling
checkpatch.pl in this case.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201019143537.283094-2-berrange@redhat.com>
Message-Id: <20201021163136.27324-5-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/check-patch.py b/.gitlab-ci.d/check-patch.py
index 5a14a25b13..0ff30ee077 100755
--- a/.gitlab-ci.d/check-patch.py
+++ b/.gitlab-ci.d/check-patch.py
@@ -33,8 +33,16 @@ ancestor = subprocess.check_output(["git", "merge-base",
 
 ancestor = ancestor.strip()
 
+log = subprocess.check_output(["git", "log", "--format=%H %s",
+                               ancestor + "..."],
+                              universal_newlines=True)
+
 subprocess.check_call(["git", "remote", "rm", "check-patch"])
 
+if log == "":
+    print("\nNo commits since %s, skipping checks\n" % ancestor)
+    sys.exit(0)
+
 errors = False
 
 print("\nChecking all commits since %s...\n" % ancestor)
-- 
2.20.1


