Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C2C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6693F20738
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lcPT8Nt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6693F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBMP-0001z3-AB
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBEz-0000aD-Cj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIBEw-00047C-I1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:43:25 -0400
Received: by mail-wm1-x344.google.com with SMTP id d4so3417737wmd.5
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WnEEcW5T8TnW3Xg2cKGofSTt8rnGAByMYZea8oHCeVE=;
 b=lcPT8Nt8NDBiWax1mtggMu8WdBMIa5exaHhnN9E1LM4n6RThzzvWH0zY/SpsE8doIK
 TPk3C5YAvBu39S+nxRzC+hFOY/eGKBgKEgvqzXqOfQNJRaqwmseW1DS+72gPnaZzumG/
 Fb1lmHfbYb0kcY1PLES+TWeh8hEXDrBSezYSf8qJ2HkGMUksy++CGX3xRJmVTD0QcGxF
 LSNMiL460xOCrfYLk45fOrVe2ImcsxypaRxHezFJVT0bmhTiRJ1atHmMf9mbBCwmBnMw
 D1jnpaIUNgXtpKHXAttJrql1JRqt8ebo2UPZBOOevFdsWsG1zC4qwc6aIsLoXgsLEdl+
 yZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WnEEcW5T8TnW3Xg2cKGofSTt8rnGAByMYZea8oHCeVE=;
 b=sP9VYIEm2lBw1xr3Q9UqDyrG4EtJN2JhNhDyRLjGejaMuKF6aEMQ5gCQBgfjElAY9/
 0IhcLRn9bJUInSw/yEwkvvazQQTNW0fhOVXxa03kkT1mDJkqFNtIq9xOXckKWA9EaRei
 Am+JTj+iznwzhRgB5VUQE4KkM7o66AtMFmRIpC8O9n+5qj8EqtPsfiiIDGRM7zAOQToR
 SqsimkdTBU1muspCqeL8Q1TjPmyhR/t6Sf97v2UEuBSdyoBnahuLu2WlSz3PeBL3mPfL
 3huIM9OL83f1KlsEsv5YEmAI8VWBOVcdZqBmcf4MsAmgFZu60U40S61JJVhLhsGtxpup
 sppg==
X-Gm-Message-State: AOAM530NbileDAMFdpWuBKSVZIrdzKKIDEfL1A2Z6dLnDGpNae8SYweL
 GYdNuAstY1Io2TEKIc+Sgoe3lQ==
X-Google-Smtp-Source: ABdhPJxomF8lITxXQi/khxQxpuir52lK02fWHKRgWfYrFLmkYPsx/ouvQqMVLQb8r+nigqeuLffvxw==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr4736638wmc.123.1600177399761; 
 Tue, 15 Sep 2020 06:43:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm26280408wrx.75.2020.09.15.06.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 06:43:17 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 406501FF87;
 Tue, 15 Sep 2020 14:43:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 1/8] linux-user: test,
 don't assert addr != test in pgb_reserved_va
Date: Tue, 15 Sep 2020 14:43:10 +0100
Message-Id: <20200915134317.11110-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200915134317.11110-1-alex.bennee@linaro.org>
References: <20200915134317.11110-1-alex.bennee@linaro.org>
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
 Laurent Vivier <laurent@vivier.eu>, Bug 1895080 <1895080@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On older kernels which don't implement MAP_FIXED_NOREPLACE the kernel
may still fail to give us the address we asked for despite having
already probed the map for a valid hole. Asserting isn't particularly
useful to the user so let us move the check up and expand the
error_report a little to give them a fighting chance of working around
the problem.

Ameliorates: ee94743034
Cc: Bug 1895080 <1895080@bugs.launchpad.net>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/elfload.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4961e6119e24..f6022fd70493 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2331,14 +2331,13 @@ static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
     assert(guest_base != 0);
     test = g2h(0);
     addr = mmap(test, reserved_va, PROT_NONE, flags, -1, 0);
-    if (addr == MAP_FAILED) {
+    if (addr == MAP_FAILED || addr != test) {
         error_report("Unable to reserve 0x%lx bytes of virtual address "
-                     "space (%s) for use as guest address space (check your "
-                     "virtual memory ulimit setting or reserve less "
-                     "using -R option)", reserved_va, strerror(errno));
+                     "space at %p (%s) for use as guest address space (check your"
+                     "virtual memory ulimit setting, min_mmap_addr or reserve less "
+                     "using -R option)", reserved_va, test, strerror(errno));
         exit(EXIT_FAILURE);
     }
-    assert(addr == test);
 }
 
 void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
-- 
2.20.1


