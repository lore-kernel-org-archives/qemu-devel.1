Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB73C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5150220721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFzDwUz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5150220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef4W-0004dB-GD
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezJ-0004gu-9L
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:53 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezI-0003ew-8w
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:52 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ci21so1341149pjb.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=mGW6wnv9FlzkC02Bo8Bk1So4QHTwo22NecRxOgB5aoI=;
 b=KFzDwUz0qmHA3ULFQs62is1dlym1KjMxCz7QHytByajg9YXKw3fNmWRKR6EH5Ky7kW
 4JKfsNQ+ZVDM+BPyKe7zVh+MCSCgo/kzRcpzZgYmCeNixvvg+z+QpcmNeexDJAjxYULY
 y9DM8HqjwGPBlFGuJ0P7XqnSMvOREJUY5ddJxT/RpvRPcJNk/OhE30txVCMqbKbbAV3s
 d8GEUR4Su+uTZShn1O+6YoVdCIR/gwKTFUiLIR8gtCEGLgpVV+gWu45yuJs0Bg+Zj9IR
 HWASs/NVP5KVvdIzORPltuHjD9niHxbA+P/pGcPXKDaf3pORipzIuG3DsntNHII0lWuN
 pJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=mGW6wnv9FlzkC02Bo8Bk1So4QHTwo22NecRxOgB5aoI=;
 b=sPbtEEIPGoHCjY5Yh/hGCfgi+594oQEaLvg6j+ocsSrG4FMajuXqRTUB8KUtEeW0PT
 2VT8/31beiFJkVIiwPSPpriGYpseg06Ru+RPpUskw+aEKv4QQjkt7bzYXk5XC2cIAM7M
 KBcA3l7pHMvwc4hglLThaDKAZlzsScBU1BPHxuGRQGqMq8noUQkMHaCbX1tEeceAZ5FZ
 iA4Rwp8yFKPkabs/9r5XtBNZ8t/7rRSrubsr+bVlyee4KYQR4M9762CfI+hNQTo11ENm
 C1dtqY46rE3GkBVRjv7ZydGBe3eJ3ECNYGUNSSPph4ypx41lJGMhDuDyOnqfoc9ExP4t
 Gpsg==
X-Gm-Message-State: AOAM533GthxIwUMPEx3TldNYp7csWFn/rYUbiQ+eP/hLACHEZigPi9Z/
 1umiaUV3H0+saWizdOdbA+F/HtmRK4cPbw==
X-Google-Smtp-Source: ABdhPJy3LBU7U4vWZIml69K09YTeDCX4bKcknVQXRxuLDpwOo1LGjb3BaPOpIw5Cr81VoaOBcSbD5w==
X-Received: by 2002:a17:90a:f292:: with SMTP id
 fs18mr9260316pjb.37.1590758630496; 
 Fri, 29 May 2020 06:23:50 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:49 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/12] thread: add tsan annotations to QemuSpin
Date: Fri, 29 May 2020 09:23:38 -0400
Message-Id: <20200529132341.755-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 include/qemu/thread.h | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index e50a073889..43fc094b96 100644
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
2.17.1


