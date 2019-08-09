Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25AAC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7485C2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="teMuLjpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7485C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Aw-000264-Ok
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52499)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7AJ-0000pO-UV
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7AI-00067Q-V9
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw7AI-00066S-P0
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id m125so1992592wmm.3
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j4PZI6C+KI6YUoFuKrIXwjHB5VmW7j+uAWrAYQYSYjg=;
 b=teMuLjpButNO+nfJ2vyhNTOA9keIOww/qXbMp3VuZikYudritmOwTFDvWVUwXqJpge
 9Q1cmrF4vsx/16auI/kAQOwiMngS8njKfNcn3YvlU3Mt9cQQK7gyAilBhwG/YmBEZ7fd
 44bCz1Yx35+IKJRRfnECUHc1HCWh6A/JLHzLSGeNm/Y7R3mMUtTSM+ugif4LhETUHMBt
 4AWnrNWlt6HmU9bjdJHgelihsEJ8+IQ7m3LxlTtaaY1Bn/f29+55ZXGS6gVIT0e/N/qm
 Rfg7v4RRe01XGoTjH7DZjklPPry4HGGjf7w8mbe0vck8E6dUmqlRY9mqkpf5hZa/s7tN
 B5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j4PZI6C+KI6YUoFuKrIXwjHB5VmW7j+uAWrAYQYSYjg=;
 b=n+tjsw+cay/xLdU4dtdSbbuaziZLoYMusJg2TmcTbOychtm8FBUbmg7YaIA8zz4J03
 YVGsqisFgClaPtoTaO6asK8ai3GbR3iSuFVY882pj4/zPrPsg82LW4uYU8SJhK/8EUuf
 DqwICeSeL66wXkJQlPip718jXZe6bjXAupgDFEe11lW3ULUvHfd8kWrkZ9DepjCilo2+
 r5Yy2AJJ6Ll94LLklNsr6LilntLjdTURb73E75mNOoggvR1OkrhkYor5s8oHeqB26wv5
 RUrHKERsC6Ivfg63YaC2G+LJTn9MMcV8tmh5MXZzZHRHie/PZ7aWnAIksLfnUlEa2OHb
 /r9Q==
X-Gm-Message-State: APjAAAXcZgXScflRQxdKzmRGWl1tbk/O5LxCS0TENdFjwg8ebcpryenN
 /Tc8Ne92RbyyRXu1GBlA8UsyOQ==
X-Google-Smtp-Source: APXvYqxx4o8mXV5yts67SWyuQh2uoiILh9WCwYzxVsGQapWtZDIIJRbKn9y+lXyhJlg1uhjRmSAzSw==
X-Received: by 2002:a1c:c78d:: with SMTP id x135mr11660329wmf.82.1565365849316; 
 Fri, 09 Aug 2019 08:50:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e10sm17047098wrn.33.2019.08.09.08.50.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 08:50:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C0671FF8C;
 Fri,  9 Aug 2019 16:50:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 16:50:46 +0100
Message-Id: <20190809155047.24526-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809155047.24526-1-alex.bennee@linaro.org>
References: <20190809155047.24526-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 1/2] tests/docker: move DEF_TARGET_LIST
 setting to common.rc
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We might as well not repeat ourselves. At the same time allow it to be
overridden which we will use later from docker targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/common.rc  | 4 ++++
 tests/docker/test-build | 1 -
 tests/docker/test-mingw | 1 -
 tests/docker/test-quick | 1 -
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 4011561587a..512202b0a19 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -11,6 +11,10 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
 
+# This might be set by ENV of a docker container... it is always
+# overriden by TARGET_LIST if the user sets it.
+DEF_TARGET_LIST=${DEF_TARGET_LIST:-"x86_64-softmmu,aarch64-softmmu"}
+
 requires()
 {
     for c in $@; do
diff --git a/tests/docker/test-build b/tests/docker/test-build
index 22766cfacc0..2b2a7832f15 100755
--- a/tests/docker/test-build
+++ b/tests/docker/test-build
@@ -15,7 +15,6 @@
 
 cd "$BUILD_DIR"
 
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 install_qemu
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index fdb1c2c879d..c30eb654eb7 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -16,7 +16,6 @@
 requires mingw dtc
 
 cd "$BUILD_DIR"
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 
 for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
     TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
diff --git a/tests/docker/test-quick b/tests/docker/test-quick
index eee59c55fba..feee44b2476 100755
--- a/tests/docker/test-quick
+++ b/tests/docker/test-quick
@@ -15,7 +15,6 @@
 
 cd "$BUILD_DIR"
 
-DEF_TARGET_LIST="x86_64-softmmu,aarch64-softmmu"
 TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
 build_qemu
 check_qemu
-- 
2.20.1


