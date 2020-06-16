Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800E8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBDA20DD4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqu6kKxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBDA20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlBAD-00048I-GM
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB67-0004Al-3o
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlB64-000097-Qp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:53:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id q25so2965880wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MxmxIyQX9ayQ5hPd4gIq4mQ/EgZcZo3pK+5EExUMVzw=;
 b=bqu6kKxHrJ796bfx8IEmNKueau3ph1STuTkpj/lW9/cKdjP/XE4wrt/L3EGnkCHU2E
 373bmjmFM6uByLN7UYNlGCUvF+xE0FAyTwDJPH1/yUqTT+EucetiKKRZwbf87sYqfeco
 0D6KeHffSgtmAAZvvvfF1HqggApNwcbAvd+n6aBTrj0c4YcYD5eu93udoTmFkndqBmmv
 1hJq0vpgVaS5tXSXHSwIneHa3lBEbs2aiDRQPA6XwY8H3YO6VL5qCKL1+zW4VGmU3aLn
 hywP/dNWA+gnw2qJBv6FE/vw0AO3xiha0ggZQTrpGjW41Vai2OeoWCVSBPHYsUo0aA11
 JrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MxmxIyQX9ayQ5hPd4gIq4mQ/EgZcZo3pK+5EExUMVzw=;
 b=ibpzV7Tlz+ZoXfohxKahki+G2L8wOPjYp7Y1pibFvqC3WJjLxSanPaiV1HEXlOTYIF
 L8btR7Sqsvtckm501IK7CkfoFtoFGB0GqKN4S8BIxV37RACg//I61sp6VQuCB9rpv4Vy
 b/HN1zfTmP9OrvKaNdrXtre2B2qN0ntVqsGSXB7mkcrANfNpZb1xl+TXwt4AKhl0mbzu
 3nlyPeSd0W2uex03VeTwioS6Pml115oJX2v3hDsnVpvTp9A44xeGJeDGVDP/EkzejuTx
 7m4203alfr102BnmxNwlfyU7ugLZ/8/viZkHAwSAd9YP05XTwZDRIjFGVKSMfJhgRbRY
 fpSw==
X-Gm-Message-State: AOAM530hDZ8w1C9YIULlq1GTit+Yr2PwRWI1Jkhe4bEBlJQO/dOOWQOK
 uRGrI2vaMU7I8Zt/pfhMqLMitg==
X-Google-Smtp-Source: ABdhPJy8n+Ss1TC5epOBPBFuV50cRj6660OjEhlJ5+Np1+bm+Y1Z/4udvk/n54+XYR+d3sejen2UIQ==
X-Received: by 2002:a1c:154:: with SMTP id 81mr3039193wmb.23.1592312023173;
 Tue, 16 Jun 2020 05:53:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r2sm30080373wrg.68.2020.06.16.05.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:53:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 551241FF9A;
 Tue, 16 Jun 2020 13:53:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/21] thread: add tsan annotations to QemuSpin
Date: Tue, 16 Jun 2020 13:53:14 +0100
Message-Id: <20200616125324.19045-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616125324.19045-1-alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-9-robert.foley@linaro.org>
Message-Id: <20200612190237.30436-12-alex.bennee@linaro.org>

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9479facdcc5..4baf4d17157 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -206,6 +206,10 @@ void qemu_thread_atexit_add(struct Notifier *notifier);
  */
 void qemu_thread_atexit_remove(struct Notifier *notifier);
 
+#ifdef CONFIG_TSAN
+#include <sanitizer/tsan_interface.h>
+#endif
+
 struct QemuSpin {
     int value;
 };
@@ -213,23 +217,46 @@ struct QemuSpin {
 static inline void qemu_spin_init(QemuSpin *spin)
 {
     __sync_lock_release(&spin->value);
+#ifdef CONFIG_TSAN
+    __tsan_mutex_create(spin, __tsan_mutex_not_static);
+#endif
 }
 
-static inline void qemu_spin_destroy(QemuSpin *spin)
-{ }
+/* const parameter because the only purpose here is the TSAN annotation */
+static inline void qemu_spin_destroy(const QemuSpin *spin)
+{
+#ifdef CONFIG_TSAN
+    __tsan_mutex_destroy((void *)spin, __tsan_mutex_not_static);
+#endif
+}
 
 static inline void qemu_spin_lock(QemuSpin *spin)
 {
+#ifdef CONFIG_TSAN
+    __tsan_mutex_pre_lock(spin, 0);
+#endif
     while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {
         while (atomic_read(&spin->value)) {
             cpu_relax();
         }
     }
+#ifdef CONFIG_TSAN
+    __tsan_mutex_post_lock(spin, 0, 0);
+#endif
 }
 
 static inline bool qemu_spin_trylock(QemuSpin *spin)
 {
-    return __sync_lock_test_and_set(&spin->value, true);
+#ifdef CONFIG_TSAN
+    __tsan_mutex_pre_lock(spin, __tsan_mutex_try_lock);
+#endif
+    bool busy = __sync_lock_test_and_set(&spin->value, true);
+#ifdef CONFIG_TSAN
+    unsigned flags = __tsan_mutex_try_lock;
+    flags |= busy ? __tsan_mutex_try_lock_failed : 0;
+    __tsan_mutex_post_lock(spin, flags, 0);
+#endif
+    return busy;
 }
 
 static inline bool qemu_spin_locked(QemuSpin *spin)
@@ -239,7 +266,13 @@ static inline bool qemu_spin_locked(QemuSpin *spin)
 
 static inline void qemu_spin_unlock(QemuSpin *spin)
 {
+#ifdef CONFIG_TSAN
+    __tsan_mutex_pre_unlock(spin, 0);
+#endif
     __sync_lock_release(&spin->value);
+#ifdef CONFIG_TSAN
+    __tsan_mutex_post_unlock(spin, 0);
+#endif
 }
 
 struct QemuLockCnt {
-- 
2.20.1


