Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0174FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C203820738
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ar7YY6PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C203820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGRl-0000cb-SC
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN1-0000au-Ks
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN0-00034n-AC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMz-0002wj-S4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id 11so256618wmo.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yf5LYbxQ7vZFI2e7ouWmWtLtY/JYKItbGmCRFHATcOA=;
 b=ar7YY6PNDtBqwBxuuw77nK1CTRBikQxIeKKSjsbxOrQa+qHhyxe1YJP6AVKl8kRihS
 O3wyXI7Fl64axSinztzBt+J0flUQ//Y0waq5IO+gLyEVJcCKiiV9xAjM0HkIC3823aA3
 b0zC0f8h3pvsSPtpdpbAUzMsHr86kQqgN5ojW+URw0cZSI80ICFJWPXseJGfhLUQ5B4v
 6jeaDaEq3gL12l0XtMDXVlz34yw0kQBb0ZaJs/mTvc0FiwEYy9mFWxZYZTbmL78wklRv
 s+fQsLsHKDzE6Ps8PUx1S/CsX58hq1c5coU2PR6SAy7Qzl629XYyRIYIkn3kGFeZa3zk
 6OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yf5LYbxQ7vZFI2e7ouWmWtLtY/JYKItbGmCRFHATcOA=;
 b=KIjyLfDBgmrdMCUhuD+sguYXFcYsB+18+wdkKkFiWQpk7hYFt7W7lBUYXT8QWoesnb
 8EvdCGRz6jUIZbYgBoHMapIMSBqcuiAG+5A3p4o7/Hluo6IXrLAIP+Hq37U5prkiznhW
 VXKUlhLTeb633+o7Kj2nJ6y58xbLkg2yn5FOG+Vz6It7V4exHLtp1BCWVqLBOxP/hOUG
 XvWw74mxak/Hiwp2/n79FbBOOZaaGtODx1x41inPOXRT/QyoxNXg93SK4z+ADmlRgOnq
 q/Dy6nGA6yAjawi+rJYTHqV+VcVY7UnpnQ7d44iyaMqtJpW+JRHpMmOQJn6EGjt7Ldzm
 zE8g==
X-Gm-Message-State: ANhLgQ0VeFiJPm2KJ4EoWTs7LoV1tWLxIVjMzEFKzn7kG8qZM9HVIMgO
 oBlja9CZVKHc4sQ5V7CG3n6bkg==
X-Google-Smtp-Source: ADFU+vv3h1OZTj5f0cfBXnJh45WsJdvOA7Cq+xe2HKHdd0OIU0eBA5Tjji5K016mb0pvQjv9PhlBNA==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr174541wme.49.1584467472729; 
 Tue, 17 Mar 2020 10:51:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 133sm237427wmd.5.2020.03.17.10.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:51:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59F201FF9B;
 Tue, 17 Mar 2020 17:50:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 12/28] target/m68k: use gdb_get_reg helpers
Date: Tue, 17 Mar 2020 17:50:37 +0000
Message-Id: <20200317175053.5278-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200316172155.971-13-alex.bennee@linaro.org>

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index baf7729af00..c23b70f854d 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,19 +72,15 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        stfq_p(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
-        return 8;
+        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(mem_buf, 0);
     }
     return 0;
 }
@@ -112,21 +108,18 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
-        stw_be_p(mem_buf, env->fregs[n].l.upper);
-        memset(mem_buf + 2, 0, 2);
-        stq_be_p(mem_buf + 4, env->fregs[n].l.lower);
-        return 12;
+        int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
+        len += gdb_get_reg16(mem_buf + len, 0);
+        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        return len;
     }
     switch (n) {
     case 8: /* fpcontrol */
-        stl_be_p(mem_buf, env->fpcr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        stl_be_p(mem_buf, env->fpsr);
-        return 4;
+        return gdb_get_reg32(mem_buf, env->fpsr);
     case 10: /* fpiar, not implemented */
-        memset(mem_buf, 0, 4);
-        return 4;
+        return gdb_get_reg32(mem_buf, 0);
     }
     return 0;
 }
-- 
2.20.1


