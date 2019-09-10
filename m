Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F217C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED07F21479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX1Bn+L7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED07F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hX9-0006jn-Hv
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNl-0005PV-RP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNk-0004zj-Gk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNk-0004z7-Am
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:36 -0400
Received: by mail-wr1-x441.google.com with SMTP id a11so11068229wrx.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fZA5qZtHref6EES7glsBu8W4zydJFLjuwr0G2I/qEek=;
 b=IX1Bn+L75xsE7wR97ujQGTwx7gERV6QZ/5uUFlJkg4cM3TAIGRuAZ2f8MUOuzmaH/l
 7p/3UeB5SACUV7ULkrYPZf4l2JC6jj9Ia/1JBrdu/hhdk1juMbf8qBwLTe92d8CIm2NH
 WqRilXdkGprmhh3ov14IQ7t9hsiz58myU8OUi1MYToYLLjsE8dU5/PPSjzbfSGiJadSs
 odf3GudeX81c3LIKoUY4DDPGTQ+v4lqfc74WKRh2/Rk+9uigZLmqKWZKFn9C/RpQPWBT
 H58yH/v9YQlvo4v5LyWy2MbX0gUfHO+LhyDje0OVd5RAKY69sFsgMk0+YMYgWXUZ/p/I
 WqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fZA5qZtHref6EES7glsBu8W4zydJFLjuwr0G2I/qEek=;
 b=ixugX+z0mqG66vfI4OGO/XOLf+l+SJOHKwsJM8jhWeqmsiUXwvOd8c+Zyba9i1NPiv
 E5BVJyEjKsgsRm1MO3HAZwBpKAtjr4ItgLjYHd6xf4D18QM4yVGEiSB80k/N+91mzicY
 wjjLjpcq5nbAtfh237hNR1qIToHMskbl9JEmpkUiaeOdf40iFb4z52Ecs9S8CH30mK2Q
 SG9vJF079+gudjxizzl2dr6/PW4I5TURjWpG2Yjn/uis2GdkmDZZj+HrisuAl2VOk/xC
 ATfCB0h2Dc/BwS2jygBzWZP5BVesvtBlNlh5/ISP8nImsQHwAUk85Oi3U9hLl7eT4SeC
 lSdw==
X-Gm-Message-State: APjAAAVBNMSEB0jX5944EZh0WBSqN/nEMi1GYPR5ZiSgDqlgPX3SSB5j
 JXv+F4C+PfCfwmiH5Lk7tSJJEA==
X-Google-Smtp-Source: APXvYqyjTDUzvzPnMlLUmbXH/biyEgBm1jIvMwQN4NQDq7w/thO6i/dyCQ8UT1ZuDnQfQbIgeCbTqA==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr18411913wrn.352.1568126675477; 
 Tue, 10 Sep 2019 07:44:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:19 +0100
Message-Id: <20190910144428.32597-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910144428.32597-1-peter.maydell@linaro.org>
References: <20190910144428.32597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 04/13] target/arm/arm-semi: clean up TaskState*
 usage in non-user-only code
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The semihosting code has to build for both user-only and softmmu;
for user-only it needs access to the TaskState struct that holds
per-thread information. For softmmu we don't need it.

Currently the softmmu set_swi_errno() takes a CPUARMState *,
which it doesn't use, and the 'ts' variable in do_arm_semihosting()
is set to either be a TaskState* or a CPUARMState* depending on
whether CONFIG_USER_ONLY is set, so that the callsite always
passes 'ts'. Since we don't actually need the CPUARMState *,
we can instead make set_swi_errno() always take a TaskState*,
by providing a local-to-this-file dummy typedef for the softmmu
case and setting ts to NULL for softmmu.

This will make it easier to have other functions which pass
through the TaskState*, because now they can have the same
prototype regardless of whether they're CONFIG_USER_ONLY or not.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 48 ++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 05491bf5248..ce3ba554bef 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -36,6 +36,13 @@
 #else
 #include "exec/gdbstub.h"
 #include "qemu/cutils.h"
+
+/*
+ * Dummy typedef so that we can have functions that take
+ * a TaskState* even if we're building for softmmu; in that
+ * case the argument will always be NULL.
+ */
+typedef void TaskState;
 #endif
 
 #define TARGET_SYS_OPEN        0x01
@@ -213,27 +220,24 @@ static GuestFD *get_guestfd(int guestfd)
     return gf;
 }
 
-#ifdef CONFIG_USER_ONLY
-static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
-{
-    if (code == (uint32_t)-1)
-        ts->swi_errno = errno;
-    return code;
-}
-#else
+#ifndef CONFIG_USER_ONLY
 static target_ulong syscall_err;
 
-static inline uint32_t set_swi_errno(CPUARMState *env, uint32_t code)
-{
-    if (code == (uint32_t)-1) {
-        syscall_err = errno;
-    }
-    return code;
-}
-
 #include "exec/softmmu-semi.h"
 #endif
 
+static inline uint32_t set_swi_errno(TaskState *ts, uint32_t code)
+{
+    if (code == (uint32_t)-1) {
+#ifdef CONFIG_USER_ONLY
+        ts->swi_errno = errno;
+#else
+        syscall_err = errno;
+#endif
+    }
+    return code;
+}
+
 static target_ulong arm_semi_syscall_len;
 
 static void arm_semi_cb(CPUState *cs, target_ulong ret, target_ulong err)
@@ -374,13 +378,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
     int nr;
     uint32_t ret;
     uint32_t len;
-#ifdef CONFIG_USER_ONLY
-    TaskState *ts = cs->opaque;
-#else
-    CPUARMState *ts = env;
-#endif
+    TaskState *ts;
     GuestFD *gf;
 
+#ifdef CONFIG_USER_ONLY
+    ts = cs->opaque;
+#else
+    ts = NULL;
+#endif
+
     if (is_a64(env)) {
         /* Note that the syscall number is in W0, not X0 */
         nr = env->xregs[0] & 0xffffffffU;
-- 
2.20.1


