Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5BCC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1FA20797
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/MsKliW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1FA20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERkW-0000D3-Pg
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcf-0007QS-Pg; Sat, 05 Sep 2020 02:24:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:38388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcd-0003Yv-Vi; Sat, 05 Sep 2020 02:24:25 -0400
Received: by mail-pl1-x62d.google.com with SMTP id c3so1863643plz.5;
 Fri, 04 Sep 2020 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wj+Yr1ojVwv967bfAJb6JSFv1AmJxc96MtVHTxvr4+4=;
 b=T/MsKliWg2sRL4/K6Deq4W7T5vAlFTNji/sRCl2TvVsEj+UK//5bQcUSri+uxh8zPR
 ZJeTjbODywXw8JZ2JlZQX+tsh8IpHqW4j5I4vSqQaSqecOhsz2azENK0+6xpx7CugHOM
 B1CsPwig3jk92P/zri8qG/EC3F0RszWg0ymwn5b/Il+PRqu+pkHTb3kxFDh4lIdSZVh+
 7iL30CvyIvcFympD6KHjGx6vZAZf4HAeaCiLJQ7RUm8W13EaW8Gz5YbCqd2Q2NMM+czK
 /znrARICtMjo0cuWepiGwCRZHNJIWBDq5QZqCgyHTeTf0YgNHFL8B8Cm1ClQBDGjOFyx
 VDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wj+Yr1ojVwv967bfAJb6JSFv1AmJxc96MtVHTxvr4+4=;
 b=iVUx7R5yHpOdF5qrXhBxTOuXNbL1gxJUwKvl3cvKwg3pJDqRwWdDs39i2fCFdUaahX
 /G1QX/y5g6M2TIQZ3RrOM9VDV6Yqt3zRMaATQHn675CbJz8IYuictqEDjyGT0MmcLNvz
 u1UFKw0pOKPePJCiWj+gwXNjO+SsAA2gkaNWoEfBXq4waEWSm9qYNq/enNXkbVybtOAs
 7LeM3gpzwbcM62R9XmBIL5dvxiUmuRnpS8u1UPohCqawqyLQGBQ3jXQJ6nkegvETPfPR
 2Pg6MzdZCB0uBjdrMbzyoz164jzF3efEFWHFRPJDlyCqDC5c/9r+t8xhifpfpNohC8Ib
 5u4A==
X-Gm-Message-State: AOAM530rF+X1aPfT0bmluOi8xslaLEu9z1q3Vc5EL7esEmDeTEGB40YT
 qer4Imnad3QzpXTXLFkvG3nFHrxhq6Y8i4ug
X-Google-Smtp-Source: ABdhPJwNLzba9j1GjbOsJw39l8dvPJFWSIl/NRowNmSCuaS5aszefhK/m72BJMwaCrsgpQYohocusA==
X-Received: by 2002:a17:90b:108e:: with SMTP id
 gj14mr11690122pjb.225.1599287061802; 
 Fri, 04 Sep 2020 23:24:21 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:24:21 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/11] ci: Enable Github actions.
Date: Sat,  5 Sep 2020 14:23:33 +0800
Message-Id: <20200905062333.1087-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .github/workflows/main.yml            | 31 +++++++++++++++++++++++++++
 scripts/ci/windows/msys2-download.bat |  4 ++++
 2 files changed, 35 insertions(+)
 create mode 100644 .github/workflows/main.yml
 create mode 100644 scripts/ci/windows/msys2-download.bat

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
new file mode 100644
index 0000000000..758bbf6641
--- /dev/null
+++ b/.github/workflows/main.yml
@@ -0,0 +1,31 @@
+# This is a basic workflow to help you get started with Actions
+
+name: CI
+
+# Controls when the action will run. Triggers the workflow on push or pull request
+# events but only for the master branch
+on:
+  push:
+    branches: [ master, msys2 ]
+  pull_request:
+    branches: [ master ]
+
+# A workflow run is made up of one or more jobs that can run sequentially or in parallel
+jobs:
+  msys2-build:
+    name: C++ msys2 (Windows)
+    runs-on: windows-latest
+    strategy:
+      fail-fast: false
+    steps:
+      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
+      - uses: actions/checkout@v2
+      - name: Install MSYS2
+        run: scripts/ci/windows/msys2-download
+      - name: Build
+        env:
+          MSYS: winsymlinks:nativestrict
+          MSYSTEM: MINGW64
+          CHERE_INVOKING: 1
+        run: C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2-build.sh"
+
diff --git a/scripts/ci/windows/msys2-download.bat b/scripts/ci/windows/msys2-download.bat
new file mode 100644
index 0000000000..2c7c41899e
--- /dev/null
+++ b/scripts/ci/windows/msys2-download.bat
@@ -0,0 +1,4 @@
+mkdir C:\tools
+cd /d C:\tools
+curl -LJ -s https://github.com/lygstate/qemu/releases/download/v5.1.0/msys64-v5.1.0.7z --output msys64.7z
+7z -mmt8 x msys64.7z
-- 
2.28.0.windows.1


