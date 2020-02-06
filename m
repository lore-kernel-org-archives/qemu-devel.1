Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC5EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC0520659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKDWRgMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC0520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izesY-0003SS-2M
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:59:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoD-0002ok-6t
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoB-0006IG-7I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:56 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoA-0006BC-VL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:54:55 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so6576591wrt.6
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=terXZY92WjXcbsOvhD48ytuhDD/Edrk9JWjZRUMMrDU=;
 b=WKDWRgMAu9GQ6v9q8gcuW3d8yzd2pQ8+Ead2Cvj0jYG0zDTLFIZcuvN7TVJe93sV4T
 kyi0dinblj3p45t/J5ZuE+WuXuaC/TAWRfbq29SSY+GVyIhJ4QEZ8MNp95IMEbc/xwpc
 AZUtGtsPfKbEcG212l/MfshbAwJpEBHfIgQ+rkLfMu/Nfg12oBFtLIG37hzQzdUS/78u
 aNLOAmjcjKHh/qHcwcniEYOJr42GRok79qmKGxr6l1fWUPLcvBxW+rDE25DtnTzsdUww
 w+r6xRqebkMaZLBos7WSGvjY84YmlJ0eml7jyADeUohed6DBVJLfP3ui2g6aPs1Rluhw
 CmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=terXZY92WjXcbsOvhD48ytuhDD/Edrk9JWjZRUMMrDU=;
 b=p+LTx98ozfJHDbum6LPWG9PAlykGh4si99vYdmCaRWs6XDTzKDnkvZdB4zT6R+LOA8
 luwd0P3J/qc5wlwkoljnq92rTGv+rXdJdVTfwdoAlUATi9Mc50RcuWH60UnCTl0l+VG3
 UpS2nHoh2b04rUI1JWCZCtbloW7Aok35JYqZAGRoK0ihHpbyyRpy79J1LjNK11xXGK2V
 tCFeaXO22isGP+TioPPlGKW0vvxy5v6gCYWia4F2kwEXb3VnHoUr4Q/wkf996azpHlu/
 2OeZ0mxHDFtL+2x5L0EPagFiHj6IDewTt+3IRotTJrRytQDDabo15LJM1baVG2+o7eIB
 nDWA==
X-Gm-Message-State: APjAAAXD8jlXcF6bduu8VeMFh5ItYmMJWHGkeDEzZH5idU+ZOYfJ1f5S
 9i3H/ih0/lqU3WNRfWNinc+1nv7A+kjwYQ==
X-Google-Smtp-Source: APXvYqzYU/KJCKhAn2J7nlvO2PyWO5itPgA5JRTezW66UK7YwZQ9SflGmHm0NUGxDOfDrlinE+X7dA==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr3213146wrs.237.1580986493688; 
 Thu, 06 Feb 2020 02:54:53 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:54:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 05/41] target/arm: Update CNTVCT_EL0 for VHE
Date: Thu,  6 Feb 2020 10:54:12 +0000
Message-Id: <20200206105448.4726-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtual offset may be 0 depending on EL, E2H and TGE.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c7ee0d603f..dbfdf2324b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2515,9 +2515,31 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gt_get_countervalue(env);
 }
 
+static uint64_t gt_virt_cnt_offset(CPUARMState *env)
+{
+    uint64_t hcr;
+
+    switch (arm_current_el(env)) {
+    case 2:
+        hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            return 0;
+        }
+        break;
+    case 0:
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return 0;
+        }
+        break;
+    }
+
+    return env->cp15.cntvoff_el2;
+}
+
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - env->cp15.cntvoff_el2;
+    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2532,7 +2554,13 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
                       (gt_get_countervalue(env) - offset));
@@ -2542,7 +2570,13 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     trace_arm_gt_tval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-- 
2.20.1


