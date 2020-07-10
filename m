Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27E62075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT5iB4AZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27E62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxgW-0005B4-6A
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtxff-0004ik-7t
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:22:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:33458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtxfc-0005Dr-Ii
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 14:22:50 -0400
Received: by mail-wr1-x42b.google.com with SMTP id f18so6931495wrs.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W8YijSp1XovDqq+uZ6Y8l5WapxpQV/F42/auP5exDO0=;
 b=VT5iB4AZxe3xkdztq8ENtu/pjsTAaTFKMQHxqEhgjUSInnt0qiOckc8fIDFI0lQGee
 UndZcSGHnIH66h2umu4eDxzMLRTAGmWkVhYt3+fCLuktHVgzrlLZv+AAfmy2J9nWiD5p
 KVPAUUlRbYaMRitNz9wozLJbXMl0m/cTO1HCXs/eL832//yf/+n7cn7x34+HQbeBJsng
 Y24gCHDyh3LxtZOndedcuwCP+GMXhW3avqiti5/CFuY5xaIaY50/JbxVGys7bKFq/IfH
 sJUAfDP/afB4YuzadCLfED4NT3gwH2qeUk/bELOreJVODeqCTXbS91+6cUFpmveMF6ou
 mVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W8YijSp1XovDqq+uZ6Y8l5WapxpQV/F42/auP5exDO0=;
 b=NiV+QPlKWTjN6jqPEs5F2VhjnQoPuUVS+nK8+BrRhK6iux4kqIqVeTUzCMx21A22JU
 seIiyUTilYoksMkhgnbaDWO+og3fHb1Df0Q7vq+q61xkknX0b/+aPzetV8QOX1zr0MqH
 Xv1zgStEQeU9/EuKXB6GQ8DY9oXfJOLL3TGyOoy0Bv1p/sEAX7OAixbLsliJSACWdktx
 ZzGic9fCxWMac76t1HhO3p/l2c5QRc+W89egCFA0tDivES7FgHaCPeNZkWpFR5HPYEWh
 czqErEiXKC3IFvfZNOsB/kuH9zdAUjs4mwh+TQhyIQRnXqLHPTUsZZ/wcpOgu2waxb1L
 m/YQ==
X-Gm-Message-State: AOAM533z7pi1SBkB9MGQwSCIINMLct7DmYiX7jrey99AWyMHf+Zd2X/R
 bFzvdyEUjstFVjpNSNls+mZ3Og==
X-Google-Smtp-Source: ABdhPJy7LTDkSSUDj4IL3eRmSuAF142iQTvv113HHbMwKQl5znrpS7vdHddBfp+N0jJBpCUGmvY1qQ==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr65992494wrs.270.1594405366943; 
 Fri, 10 Jul 2020 11:22:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q5sm11249313wrp.60.2020.07.10.11.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 11:22:45 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 94BA11FF7E;
 Fri, 10 Jul 2020 19:22:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .cirrus.yml: add bash to the brew packages
Date: Fri, 10 Jul 2020 19:22:38 +0100
Message-Id: <20200710182238.10675-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like the sed we include earlier we want something more recent for
iotests to work.

Fixes: 57ee95ed
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 69342ae031bc..f287d23c5b9b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -20,7 +20,7 @@ macos_task:
   osx_instance:
     image: mojave-base
   install_script:
-    - brew install pkg-config python gnu-sed glib pixman make sdl2
+    - brew install pkg-config python gnu-sed glib pixman make sdl2 bash
   script:
     - mkdir build
     - cd build
@@ -33,7 +33,7 @@ macos_xcode_task:
     # this is an alias for the latest Xcode
     image: mojave-xcode
   install_script:
-    - brew install pkg-config gnu-sed glib pixman make sdl2
+    - brew install pkg-config gnu-sed glib pixman make sdl2 bash
   script:
     - mkdir build
     - cd build
-- 
2.20.1


