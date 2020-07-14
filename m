Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1FBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C9C2256C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXVRAz4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C9C2256C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPA2-0001Kb-C3
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvP9M-0000tn-Es
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:55:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvP9K-0001Ml-NO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:55:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id o2so7951520wmh.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=te1Lipa6RAlKihwVxFQMxJOFkEWkdgE8ydfZcX6Ytlo=;
 b=mXVRAz4+5aNHllwYiljrg1VX9rt2esWD0298i0FmSjz7izS9wndZoC6Z+BgQ3gHG+T
 rfSQGpmLSQv1Xh9f1cosJLFwSsGVT1TOrjgJZrjhfxKLjjAgzcdO89S2sW17EaCExfKK
 6dsasCuGs5Qck9p6qXaShSM1a6IJ5Yym0HRN9F7QY/h0kmCLBDZb/mwJFpKfn9dayFQ2
 g2NiOvIsvFSaDK+LfNGzhJZ+ElUTOPRquVD7oxWprCXS+k4vWz7h0iA1UZeoJugGzQgx
 5ip1iBHFM+1hOAOEwyrdwZlB48NR4rkSlYz0XgkYquCOa46GKhqCaSvOFWVtRLRTUzPf
 Pidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=te1Lipa6RAlKihwVxFQMxJOFkEWkdgE8ydfZcX6Ytlo=;
 b=GHdB4eU7Z3HRTL+6s8jqPYCduWO7fEB8GDxVx6AGbr4sYZvivfd8ilxFO8LTIOkOCX
 lwQ9gihZqhBeD7AJUeLc1RyfyDJq8LgEIkbQH6ryOrRtnnpbmL8qWezJJan4G+tQg5a/
 lQGOiPIjFZY58/GPFm9RplvNrpTx73y+yoA1BjTaa8CbKm4sz5GShzAFX6Ros6uJLBM5
 W5OsXw/emC9F3tmh9aOTlmJefUFX+cU6zrV+7qUETYzN00X0iZf+As37hB3y5Xg7FTi6
 aCz+ZWb60ml9Q5Ylvjk2XfAPeE8rG1De3cPzUjejhy3AxaULLkiD4p1FcfLIfqtFuUst
 pMYA==
X-Gm-Message-State: AOAM5300MHWGpLZTChKnef0FX5LrVNjLj7gxpIZeUVU3PCP4qs063uBh
 pFsVnx2UG9dZvRFVASynOMh7Ag==
X-Google-Smtp-Source: ABdhPJw+c+y9FBB6+ZgJ9HlQZ5rfawK4mwbXr3gbX+FFj7FSxt5z2Pwwtiwcq0WNb5EUocyjyROdbw==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr5296558wmh.159.1594749324732; 
 Tue, 14 Jul 2020 10:55:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o21sm5386465wmh.18.2020.07.14.10.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 10:55:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E51141FF7E;
 Tue, 14 Jul 2020 18:55:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] .travis.yml: skip ppc64abi32-linux-user with plugins
Date: Tue, 14 Jul 2020 18:55:16 +0100
Message-Id: <20200714175516.5475-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We actually see failures on threadcount running without plugins:

  retry.py -n 1000 -c -- \
    ./ppc64abi32-linux-user/qemu-ppc64abi32 \
    ./tests/tcg/ppc64abi32-linux-user/threadcount

which reports:

  0: 978 times (97.80%), avg time 0.270 (0.01 varience/0.08 deviation)
  -6: 21 times (2.10%), avg time 0.336 (0.01 varience/0.12 deviation)
  -11: 1 times (0.10%), avg time 0.502 (0.00 varience/0.00 deviation)
  Ran command 1000 times, 978 passes

But when running with plugins we hit the failure a lot more often:

  0: 91 times (91.00%), avg time 0.302 (0.04 varience/0.19 deviation)
  -11: 9 times (9.00%), avg time 0.558 (0.01 varience/0.11 deviation)
  Ran command 100 times, 91 passes

The crash occurs in guest code which is the same in both pass and fail
cases. However we see various messages reported on the console about
corrupted memory lists which seems to imply the guest memory allocation
is corrupted. This lines up with the seg fault being in the guest
__libc_free function. So we think this is a guest bug which is
exacerbated by various modes of translation. If anyone has access to
real hardware to soak test the test case we could prove this properly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index ab429500fc..6695c0620f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -350,9 +350,10 @@ jobs:
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
     # we skip cris-linux-user as it doesn't use the common run loop
+    # we skip ppc64abi32-linux-user as it seems to have a broken libc
     - name: "GCC plugins check-tcg (user)"
       env:
-        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
+        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user,ppc64abi32-linux-user"
         - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-- 
2.20.1


