Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA37C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0048F206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjnfAnTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0048F206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWXi-0003gH-Tz
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWU-0002Ho-Es
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWS-00058w-NX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id z4so6733290wrr.4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8nU58X0zzaaWcyDZcOEKgi4a/LGSYI6Yhv+R+cwBRHY=;
 b=KjnfAnTD231rc79q8Rhs6Zt0DC9lJ3L+MkUjPYjiOgIUHkVsV+eC36s1SooEmZyalS
 5XDsOhVuPtHPx/K8X9JOkroILp2n5SH/PWv3XBFq3YKnKUWveqmbv5zOM3sFgDQ5hdNw
 ghaB3di6pa7VpBZIZ/7czHCGn7JVDIurR99L8VAli7RoU8lv1hCRSJz6i/+TYa9QIJkA
 Ln3Tdp8brxQL9N7PcNcSSiPg8mUyJTie69HOMbVFRvXTidGB+LWc7368e03MUxxvvr4M
 C7OsIyHo6mx/Y1bes+fmUJbc7zqV80vEiVIs5wqA2QlwOkXaGcS4Ocvy3pquU3WfQIS4
 dJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8nU58X0zzaaWcyDZcOEKgi4a/LGSYI6Yhv+R+cwBRHY=;
 b=bW1mrAzcWmdtKGAIBy/Zy4VeIb5L1NxDwuScTjDDoD00sJSW1xtXFR3XbZRb74puxZ
 XhmKAEJc5hTxsPDcHDCQoxhkOfTaQYl6DFqS5EFRbWDdf0B1pr0myLWpODY7RrR6XOof
 8glAd76W137DN0TosscxOCOuvz2pwe+7hNlSqWexIyeX0K7YMSoPle/Tr2dNFz5acZNX
 Wu4WUOiRu5+0edDlO3vphSjhhvyNVCtGdTQQGSkyATMK2trOqMlMYZoaNakS3aK65H/r
 Bj11mXLq5Y2AuPwjCqbGKTK8bm25d19a2W11umSIPmKCVM9qt2BbehbHiTkTXPi3eSS7
 kLQw==
X-Gm-Message-State: AOAM533Rh7q9nzZ1+cpECMeFfw2ywMBP9wt1cAONLxfDonW3F7RlNr9s
 QqaVphRuWM/u6NYhelDI150wq/pfftjkiw==
X-Google-Smtp-Source: ABdhPJzyhcrE8OAxIZrYbE64qLwGY43/x7qy28RN6VZsNX3nbiwXvvDPg4ifZtP3MeB14eTUT+wfAQ==
X-Received: by 2002:adf:e481:: with SMTP id i1mr26324512wrm.391.1600259211249; 
 Wed, 16 Sep 2020 05:26:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q12sm31148471wrs.48.2020.09.16.05.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8DC921FF87;
 Wed, 16 Sep 2020 13:26:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 1/8] linux-user: test,
 don't assert addr != test in pgb_reserved_va
Date: Wed, 16 Sep 2020 13:26:41 +0100
Message-Id: <20200916122648.17468-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Bug 1895080 <1895080@bugs.launchpad.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On older kernels which don't implement MAP_FIXED_NOREPLACE the kernel
may still fail to give us the address we asked for despite having
already probed the map for a valid hole. Asserting isn't particularly
useful to the user so let us move the check up and expand the
error_report a little to give them a fighting chance of working around
the problem.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: Bug 1895080 <1895080@bugs.launchpad.net>
Ameliorates: ee94743034
Message-Id: <20200915134317.11110-2-alex.bennee@linaro.org>

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


