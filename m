Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31577C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC23720897
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em2ve5lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC23720897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyL2-0008D2-R9
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGa-0000AW-RV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGY-0006XR-PI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id e17so1925605wme.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2wib51BYj97MEFhKwrNgtCLNnnQOCcdqhgLn/CsHDZc=;
 b=Em2ve5lrd9ZZKxn4Cn/JECZc1TlBb12aNYVlNoyy5J871gJakUhjiFhdmSkwh3ughZ
 eJEq0FmiMu0DYt8ONOrZxauJzYAdTvR5YB8hXl0YvWeYoRNFeNqXw22GhfIITXYsKl4w
 6jEUEnzMyf7TcalcN24z8CCS/LLgqbtxd4lqY9SsG4VCvsX+HUQXJGsHWCcuyPF7zhBo
 BXp5yIGfKnzB3r2Nh27454O+d6l/dBYfgYPJKTvTN6XXfFv7P4fmbgXWdjvI64r7QetC
 l3xDZWPHntg0A/oOFqmx1uWHLL5tY23GrZStfUl7L/mv2Rtc3MFVd9SIfdQCyqSR3olw
 NICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2wib51BYj97MEFhKwrNgtCLNnnQOCcdqhgLn/CsHDZc=;
 b=dhcMpOczyFYuQu+OV2r7Qhbhau0GVUhBKDTtsJmGHQWT6hDcWlR0IcOiCOCnl/wInG
 /Ve6phKeRUSF7BF/R4bIeC1PxYTpkQbff9Rn3nwdXy0LAOMU4ycROAvDjFn8T1/klLel
 IrbBTXa2IIVc51DEKhQ/3FqGlCPXXIQCQVMDeyZal/eImoI24h4K9WsS4vLEzu9/HSRL
 B/0yUu5IuJrQ7LoMsVtyUiUDPhb3y3LWOIAbCq3PMPSCpL07GNyI2yYOguJYRgrHn5/9
 C7fdb6BpS9OCYCc1Ob42rDSxTEZaG2/fehsefPeTj4zCri2IydiEATxjZti6R/Mz3hzJ
 4mtQ==
X-Gm-Message-State: AOAM532Tag1x2DDyy6ciXv4aUQxlyItJ/7pUnJgXvK+mu3ZkA639THlK
 m3PvrmbgNH4ibTMnEJ+lnjPeGQ==
X-Google-Smtp-Source: ABdhPJz5vEzIU2NEWoT1UM/YOrc0BTqamn44r0OqFF1xA62SaxZHOwcH2xC8pb4F+E6dBBs6vJ3dCg==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr3056879wme.89.1599650873459;
 Wed, 09 Sep 2020 04:27:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i3sm3733647wrs.4.2020.09.09.04.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:27:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C40901FF96;
 Wed,  9 Sep 2020 12:27:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 08/10] tests: bump avocado version
Date: Wed,  9 Sep 2020 12:27:39 +0100
Message-Id: <20200909112742.25730-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909112742.25730-1-alex.bennee@linaro.org>
References: <20200909112742.25730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Willian Rampazzo <willianr@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

Reverse debugging test uses gdb remote client of avocado framework.
This client was fixed since the currently used version 76.
Therefore this patch bumps the version to 81 and fixes command
line version compatibility issue.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Message-Id: <159903462803.28509.16851113546106095750.stgit@pasha-ThinkPad-X280>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200908202352.298506-2-philmd@redhat.com>
---
 tests/Makefile.include | 2 +-
 tests/requirements.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f93e6112202..2baebc179e7 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -127,7 +127,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
             $(AVOCADO_TAGS) \
-            $(if $(GITLAB_CI),,--failfast=on) tests/acceptance, \
+            $(if $(GITLAB_CI),,--failfast) tests/acceptance, \
             "AVOCADO", "tests/acceptance")
 
 # Consolidated targets
diff --git a/tests/requirements.txt b/tests/requirements.txt
index f9c84b4ba1a..036691c9221 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,5 +1,5 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework==76.0
+avocado-framework==81.0
 pycdlib==1.9.0
-- 
2.20.1


