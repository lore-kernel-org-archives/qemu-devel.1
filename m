Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FA32075A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxlMvvEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FA32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sg4-0002xa-H2
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2scu-0006sw-OD
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:52 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2sct-0003TJ-4T
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:48:52 -0400
Received: by mail-ej1-x643.google.com with SMTP id a26so15734049ejc.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rhEk173TreA8qSG0gwJ1Jz+1yGbkH/pbXlXTIivjow8=;
 b=CxlMvvEFCLAOuqWMxcmTJo3loyyUZLjGEra2AkK+h8U+c9VQ7EkNwTDa8mP51h1Rkr
 aFtnty9/zfzM39WB3hdrTTXksKPQny1hhSAV6i7UvuCJeY3JrdGvQvi1ai9fYDY2j4AR
 lFvYl7Xp6hHKBZ7Zzj7MmnXvX6QmITSvMavCpB1/ZO2iZk7l6uaoe48XtP+jHL/pMc+f
 z7rNSwgc8nHA+xPVC5c6FDtyTQh+H70hl6+CHJA1mwFeRYujCuSWj4t2rXEE9KWn2Ogm
 pLsT42VrMGTRYLLYn8IxoSQI+BM00+V8ZFtkI9bM18Grr2XTuINYgStrdTVsp/iblaGK
 w5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rhEk173TreA8qSG0gwJ1Jz+1yGbkH/pbXlXTIivjow8=;
 b=qnGS9pu5MURs/hkYvML0p44BySZWxg7iRdScbc79C9RpH6qwVCxvXIB+QUgGkcoPPi
 UaTXNGgqI4M7wiwPbFxI0EakyxgtLkLmEJYJb3t/ZtE+s+uA4UYZZ6yaE2wTrw4o6dGB
 28G+CoAo0mz/AUJ27ZGXZp982oIHz6UQq/OmBqTWAGz28hWII9YRO7QE+RhxN12azCim
 WeqUQTWbV9WF+aFeyo1WucztHNPqrebrMajXM0mrhSo2GO0Pz5FOdrcBC3vRfAyecXfJ
 G1GG0GYQPJum3wqN9v8daa6M73zFBGAqXwTgJIfLypI8ulnAkmjhIejBOR3pOH/LrL4Y
 pUQA==
X-Gm-Message-State: AOAM533AmZQ+SEmEu8oDh4vTrzLl5cmxkEqzWBfcQMB3n+CCJwK5B5tE
 91MllLs6h33mg+h/NdUekEkjgATP
X-Google-Smtp-Source: ABdhPJytTd5ex/4048vm4WWmcx27DA4d89CaLE9a+o7XLo/TUBHbUkwOlSBvpsgEGDpNqf6SlZn1Zg==
X-Received: by 2002:a17:906:c04d:: with SMTP id
 bm13mr19850138ejb.321.1596530929323; 
 Tue, 04 Aug 2020 01:48:49 -0700 (PDT)
Received: from x1w.redhat.com (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id q11sm1299641edn.12.2020.08.04.01.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 01:48:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] .github/workflows: Use matrix strategy to parallelize
 builds
Date: Tue,  4 Aug 2020 10:48:43 +0200
Message-Id: <20200804084843.31075-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804084843.31075-1-f4bug@amsat.org>
References: <20200804084843.31075-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using sequencial builds, both jobs take almost 2h to build.
By using the matrix strategy we can build the jobs in parallel,
reducing the total build time to 1h12m (as of v5.1.0-rc2).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .github/workflows/build.sh |  8 ++++----
 .github/workflows/win.yml  | 23 +++++++----------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/.github/workflows/build.sh b/.github/workflows/build.sh
index c430a367be..4f2c6b56f3 100755
--- a/.github/workflows/build.sh
+++ b/.github/workflows/build.sh
@@ -7,10 +7,10 @@
 #~ set -e
 set -x
 
-ARCH=$1
-DLLS="libgcc_s_sjlj-1.dll libgomp-1.dll libstdc++-6.dll"
-
-if test "$ARCH" != "i686"; then
+if test "$1" == "32"; then
+  ARCH=i686
+  DLLS="libgcc_s_sjlj-1.dll libgomp-1.dll libstdc++-6.dll"
+else
   ARCH=x86_64
   DLLS="libgcc_s_seh-1.dll libgomp-1.dll libstdc++-6.dll"
 fi
diff --git a/.github/workflows/win.yml b/.github/workflows/win.yml
index 81cf48530f..afd827db8e 100644
--- a/.github/workflows/win.yml
+++ b/.github/workflows/win.yml
@@ -9,26 +9,17 @@ name: Cross build for Windows
 on: [push]
 
 jobs:
-  build32:
+  build:
+    strategy:
+      matrix:
+        arch: [32, 64]
     if: github.repository == 'qemu/qemu'
     runs-on: [ubuntu-20.04]
     steps:
     - uses: actions/checkout@v2
-    - name: Build QEMU installer (32 bit)
-      run: .github/workflows/build.sh i686
+    - name: Build QEMU installer (${{ matrix.arch }} bit)
+      run: .github/workflows/build.sh ${{ matrix.arch }}
     - uses: actions/upload-artifact@v1
       with:
-        name: QEMU Installer Windows 32 bit
-        path: dist
-
-  build64:
-    if: github.repository == 'qemu/qemu'
-    runs-on: [ubuntu-20.04]
-    steps:
-    - uses: actions/checkout@v2
-    - name: Build QEMU installer (64 bit)
-      run: .github/workflows/build.sh x86_64
-    - uses: actions/upload-artifact@v1
-      with:
-        name: QEMU Installer Windows 64 bit
+        name: QEMU Installer Windows ${{ matrix.arch }} bit
         path: dist
-- 
2.21.3


