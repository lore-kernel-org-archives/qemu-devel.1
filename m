Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4403C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1598F2177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/0pcr7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1598F2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHA5-0000ih-2I
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1p-0006TL-JS
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:55471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVH1f-0005Za-FG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:31:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id a72so2810738wme.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 09:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LhygKOKV71hOHLVNgr5mPedwpcPQ3omR/3pUMR7xNGA=;
 b=X/0pcr7ziNndg4fZdf2oV+GKR+NTK0JpV0HqhbZ49vqija666WSl6uIDWtPNbF9zF5
 5LTrz1k7QwZ6ob89dyMd2ksXSCaixADH9uaUtdIjGuVl6pYjxXlAQX/orf3RAFqDTway
 rv7CVIYyGSAFLqbppUkZaaCuve1TKykSwUNrdHy+zTVy5+T6naLyLp9VoWoyPkDLGvcY
 EY750KFYqTSusZ8d7vA+txSZbPAAmumvCXRBZ+3CssW3YJSLdCPL6X7k84LfIJiuUhoJ
 ZfFOuoZ95f76PilvnwYFp9WSFd6ezcmugYlI7ATswymDGDN+3zIZR48QHtGc6K4XPeXJ
 1ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LhygKOKV71hOHLVNgr5mPedwpcPQ3omR/3pUMR7xNGA=;
 b=Hy06E+/6dvem5IVewr157LEDXNPVwFgEJZNkNGKgjJCzGbDzdu4zEmB7nhhZ9HrXZw
 zkSbAqEXOa7SBfzpH5OoUAhR00oWfzDOOnSQeqPRtE0N8Qg7lnFiVioNmqtziL/6icjG
 ixUBxPLoW5h8nMbFkYj64sw3XSJXB/OivP0pDtEZkDPuRsRRuLfT0xNhCyU29lYKAqbb
 UrdTyV/vT/gsN2qLL5xMhm1/BVN3swnMWysaLEUUnLrkfoPlC6alWSpUoUXCxh0wFqee
 dxGMLghG/mlTRgnVreEeADMfF2PWAChg7BzvNnn2M+MtFwcLLfrqBhVE/bglsgEdSE0f
 nAgQ==
X-Gm-Message-State: AOAM530UqSCDM0cUXGNY69TJf2oSalgFLSltl8G5XzFtGhuStSqN1bg/
 GPGrDN0sHpI3r4ZR00hKIp5fujeyO2bNJw==
X-Google-Smtp-Source: ABdhPJwpyEKFN885QoEpngNFuQNnaIkJiiR1kGZrfo2oldq4IRm8SMDGNbTdXI6VqKso5C5PEHh4lQ==
X-Received: by 2002:a1c:8057:: with SMTP id b84mr4449411wmd.116.1603297903878; 
 Wed, 21 Oct 2020 09:31:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h7sm4633865wrt.45.2020.10.21.09.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 09:31:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34E7A1FF90;
 Wed, 21 Oct 2020 17:31:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/6] gitlab: skip checkpatch.pl checks if no commit delta
 on branch
Date: Wed, 21 Oct 2020 17:31:34 +0100
Message-Id: <20201021163136.27324-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201021163136.27324-1-alex.bennee@linaro.org>
References: <20201021163136.27324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

If the current branch is synced to the current upstream git master,
there are no commits that need checking. This causes checkpatch.pl
to print an error that it found no commits. We need to avoid calling
checkpatch.pl in this case.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20201019143537.283094-2-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/check-patch.py | 8 ++++++++
 1 file changed, 8 insertions(+)

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


