Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A75C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E921206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ss2wj+1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E921206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igytJ-0002pM-Cf
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybR-0005Ov-9X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybQ-0007Sd-9P
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:33 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybQ-0007Qh-3y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:32 -0500
Received: by mail-pf1-x443.google.com with SMTP id 2so6376934pfx.6
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1+xmXAmgTNTTPDSwdxL19l0lBXnRZdS0RxSiPt4HA6M=;
 b=ss2wj+1Z8IZ3MbqKwyMdrJDLtgPuMGuFfIFI2TidxBZr/ukpUfS49i2qJmmvUYs8ot
 Ym6CQwq4PXl1k6+cQrd+EeneimIuOzCrs4ChgYtVg7xEZRi0liy0ftvBdVk4tHANgb5d
 CQn8H/tyyC29FLY+DWOsWj5MszdxHwuzN8ldEtTcJoGgmoFRwPOKAkfIh7VGUptwNEWd
 YiMFeiROydklUhKhuLQj2x7lXmEK06RckDzmYS6sGeGhGJRGbNzfWdja4N33lWj4P0Pk
 QgJ9TAbJ0EmHBNMiUOunSUAGjX54IWhBv0F+R1+wIuoL8FRMKIYRCKsQvvppXG5s9fb9
 3F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+xmXAmgTNTTPDSwdxL19l0lBXnRZdS0RxSiPt4HA6M=;
 b=RVAY+CLdqxbH3CCF8OEuJtx4gKHItl23NxBrnWz6CvjuaViaxSIkxNj3YL1rqrsdCn
 ua7qyk+0YgVbbxn5fFtQl5lM/ICSLjfGG3Nc60LOncz43YW9Dd5C/eBfWuPs9qKTX+Gk
 I6mTa24459JsU3uOa4F+L23Thv9kcLop1Qnn5LeOsEG65EBQOs+spw98jdrHi9Uw1CPO
 LeDi1o4x/d81RY7TMSGOpUMtYNqZDsfittuw3qozriIW+wBMY4Qf7aYdnva1cb3BJi/Z
 FWazVhd6QlmGlKFeolwFP0eQlAB2WqonzYbJ5wvap9iiuXXGjwmPHm66EgypTPf5BP37
 S0gw==
X-Gm-Message-State: APjAAAWQRGe45yZfrMItWqGN8TkcyHpkwVy+Mv8K4C+VZFimHqRb7IW1
 wkWIsJuO2Q1nJPcoQMue2PFd7GzNZOw=
X-Google-Smtp-Source: APXvYqzqL8bPJR0gpmdxqNlQ9dLFnUnlXITRozE5fl2zlSz/sePsNC6KuvAsXuV5MvUOQWKUASmJbg==
X-Received: by 2002:a63:541e:: with SMTP id i30mr20553662pgb.183.1576534350881; 
 Mon, 16 Dec 2019 14:12:30 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/28] target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
Date: Mon, 16 Dec 2019 12:11:49 -1000
Message-Id: <20191216221158.29572-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 95773089aa..32522f606b 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -328,9 +328,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinfo,
 #define cpu_signal_handler cpu_mb_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _nommu
-#define MMU_MODE1_SUFFIX _kernel
-#define MMU_MODE2_SUFFIX _user
 #define MMU_NOMMU_IDX   0
 #define MMU_KERNEL_IDX  1
 #define MMU_USER_IDX    2
-- 
2.20.1


