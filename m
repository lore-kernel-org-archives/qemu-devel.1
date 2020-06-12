Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448B4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1257320792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZpMozKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1257320792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp1I-0007zv-5h
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxK-0000tW-Pr
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34194)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjoxE-0006to-QX
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:03:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id r7so10846718wro.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wncxlPgJ5yWTGynznYgamvSG3vnXu4D4fFkpbE/UPyQ=;
 b=nZpMozKFkYag2fraf+i1bA0R+qJ2XaaRga7vV2cGh5higPCt6Vk+gm7H1Qzrd/lefR
 pO86QWNbOKEioYrCv1t0k1Gf+om4t5wQU5+zcxN/4MGVgq30ZZxCFeScjXY1q/L/nkI+
 ZaoK1UMymuL+oMUsgsyhyDQI6AhX/ECYavMDQaIYVG7dgDZvd3I/12zVIXoBQwh3WAlK
 zIDU3Fd5AR8XR+0Vk3qTEodfdgfUXt+gf1onbGm6DJvH1qFnSjdARiQzAQM7jzeW+zSG
 tyOrN+g+1cZVmg4dX8zvTO9qx/ZnTrI31RMMQcX9MS47hgRwKBLQvFl0y0pdOp2Hw6Ow
 tqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wncxlPgJ5yWTGynznYgamvSG3vnXu4D4fFkpbE/UPyQ=;
 b=JkTWX6Iqxuxu8WEhtdWDMLD5UAtKMS1h7M2E/86WU6gJ0MzQJwLENoGpjwHu7ogBO8
 3obgTAcwCgQA3D8IcgNvqy/gNQr6TJXGtv6gxqWK/u1BgmgXzXfigWHPA60wrAM4u7FE
 Ea79P+niV8UFakkW7uq/8tPWPuZZYeGZ6YP/ynq3tMuOt2uqf/KdErsOafiLrzmvaTRz
 qRU7yM5A7gjlQ1QMFKwmcj08qNo2oPaX+xsfDY/jPVyV6yfn7+vuzDjURiJF00OW5nPl
 ZTb/d8hQFJn3vtIm8zYYr1dXpq92FHNlLmkVbuWMMSZFCKM4RuottiIQwwavK7z5F4Lk
 GZ1A==
X-Gm-Message-State: AOAM530xS0nqZzk9fBbL+AZ8IVo6uC6RrOZu+6d5AO9/OFGhP5Z39JKy
 hVG7NvRRPG7vjZpKpsi46HUKVQ==
X-Google-Smtp-Source: ABdhPJwq29mwAnOZnCNNCXFPw1I3gqVZhCCPF93fHYKGARaAYVnXBYGpdrAOjdubuX2sZM0yUACJVQ==
X-Received: by 2002:a05:600c:1403:: with SMTP id
 g3mr344714wmi.136.1591988575687; 
 Fri, 12 Jun 2020 12:02:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s18sm13233513wra.85.2020.06.12.12.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:02:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B0AC01FF99;
 Fri, 12 Jun 2020 20:02:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 10/18] translate-all: call qemu_spin_destroy for PageDesc
Date: Fri, 12 Jun 2020 20:02:29 +0100
Message-Id: <20200612190237.30436-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

The radix tree is append-only, but we can fail to insert
a PageDesc if the insertion races with another thread.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-8-robert.foley@linaro.org>
---
 accel/tcg/translate-all.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c937210e217..c3d37058a17 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -547,6 +547,15 @@ static PageDesc *page_find_alloc(tb_page_addr_t index, int alloc)
 #endif
         existing = atomic_cmpxchg(lp, NULL, pd);
         if (unlikely(existing)) {
+#ifndef CONFIG_USER_ONLY
+            {
+                int i;
+
+                for (i = 0; i < V_L2_SIZE; i++) {
+                    qemu_spin_destroy(&pd[i].lock);
+                }
+            }
+#endif
             g_free(pd);
             pd = existing;
         }
-- 
2.20.1


