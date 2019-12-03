Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A60C43215
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C922620848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnJtkF8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C922620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHHj-0001of-K3
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3e-0002wm-Ru
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icH3Z-0006ue-5R
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:11 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:36581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icH3V-0006Zp-Tg
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 17:54:07 -0500
Received: by mail-pj1-x102c.google.com with SMTP id n96so2120386pjc.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 14:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zIHslnUoGfikMY/tOISXoUEjJ6B+SC/aIId9fLfQVxs=;
 b=CnJtkF8ZTefan5dRJ/FlnlnsN9Bl085KXHD9S5KUxhOY3kcVUZUr+mjfmIqvdDG8Fx
 Yrcg5wVcSTYVV60HTxBczy6HtmryhUMJXN+YEHiaHQMnVkgil2Zx/v40INj2ASwyttsg
 aFj8KH/r/LPwZAJ4O+IwkMvsDJE29RYsPAZU1yVtkvEcIReLQkRa9UngxFjp7Bb31gQC
 vz8d+U9mUdDLc3HXrJTTlS7fG/XKHpyZDZgZQQe5K1s2YyW6LYOxv2EczLRXivGgFGQ+
 Gr7EhiJNwZHpN8KKWLvv7DG6K0CNjzeJmGkaiOs0NT5/h68HS4Rj2xklSJgz+Xt3h8kK
 76Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zIHslnUoGfikMY/tOISXoUEjJ6B+SC/aIId9fLfQVxs=;
 b=JoRTPdOYhSoyzzfje8G99xoWbtztc5j5QzuzMkYz1xVwKJgd43xGZZcVHs3tSguQae
 pw2F+oBeaETxM9cvt3Ui8CHUztD98cBoRQdNiJSeWY+ukDCkfQakIbz3ranbReKGSvhO
 U8O8k4dSgRr9J9OfMB+aQHNAwkx7RD0b3bJWh1QU9Xbz4PpkxMT25Obk9fWmi9+x+aX6
 mQMDrb3JoBvAsFnqIOrRiVthMKpvi4KBbMd7QIoFdEW3hjcscKdhyhmLMdWvwkUGSOga
 4c/o6TlUEZzuiYcKPGo+NPxnQBustWQajR5Kmz3CjacrXC6HIPsZKagFo0ihahr5UlZD
 asZg==
X-Gm-Message-State: APjAAAUwHiRsvc0HDDVIOVgkWDJo9UhCleDYZJK0UnLXrKTWVNboAysK
 8i++yj5Azfh3YEKbplGerXwsiGceWM0=
X-Google-Smtp-Source: APXvYqxEdNOANe2spkGfjIoKhF3O9uFG0a+GWUvvoCQ38xCbbmjgBiCXOGjoOFSOAeLgyYBa9krcIA==
X-Received: by 2002:a17:902:9a8d:: with SMTP id
 w13mr355806plp.330.1575413625366; 
 Tue, 03 Dec 2019 14:53:45 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d22sm3789713pjd.2.2019.12.03.14.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 14:53:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] target/arm: Enforce PAN semantics in get_S1prot
Date: Tue,  3 Dec 2019 14:53:30 -0800
Message-Id: <20191203225333.17055-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203225333.17055-1-richard.henderson@linaro.org>
References: <20191203225333.17055-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102c
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we have a PAN-enforcing mmu_idx, set prot == 0 if user_rw != 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 13 +++++++++++++
 target/arm/helper.c    |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2408953031..ab3b436379 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -893,6 +893,19 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
+static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_EL10_1_PAN:
+    case ARMMMUIdx_EL20_2_PAN:
+    case ARMMMUIdx_SE1_PAN:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /* Return the FSR value for a debug exception (watchpoint, hardware
  * breakpoint or BKPT insn) targeting the specified exception level.
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6c65dd799e..a1dbafb9b2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9444,6 +9444,9 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
     if (is_user) {
         prot_rw = user_rw;
     } else {
+        if (user_rw && regime_is_pan(env, mmu_idx)) {
+            return 0;
+        }
         prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
     }
 
-- 
2.17.1


