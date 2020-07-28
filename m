Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A1FC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFA1206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDsBtBmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFA1206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QK6-0004SF-TB
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0QJ3-0003IM-Hd
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:10:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k0QIz-0006cu-QF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:10:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id r4so15478605wrx.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Bs/LPxHzL/OGO5wpdwqQ/5KO2ACTK4oqT2PKMk5ANuA=;
 b=TDsBtBmu70dmODvkhtTeb1aH9ZnYtsMFJyCr7wo7IOuPZOI82C+63EescHYXdDRIOd
 7E1CdNNIQQ05lUjxgawnDpYlL8oEJwzX0TVYAWQPihDPXw9e7h6SejnLwaS+C5H247sm
 vwZzriasAg+qk2KXewaKqH7dycIkYiynQ+IiU9S1BTcIywfc904bZ4jjZL7/HRibvMRf
 75I18CtMlUWaV84oqN3kD2Ud0QeypiKrXx/v++kMz3NXACs4xyw8v+LsNsmLMXKKMVpX
 tMxmCtuh7ZroZpRUcTqNaxX4MEVlq9s2GDkAhHbZkWqdrS7OtBCdbp9v4+MiCz+g5dQn
 bz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bs/LPxHzL/OGO5wpdwqQ/5KO2ACTK4oqT2PKMk5ANuA=;
 b=LNy1Qz8jghl/ICEymGTzOCEB1xX9JecZ6v7O9efYv4FIMs/DBi8TpiBThd9efIYyhX
 pfJYqocF8Ygh/UT+PL5C1SL+Xfx4X0FI4xMDVSNbn4KDm5PMGRtBFKOBJxJ3xlCznfgm
 EqesoqU1dGblng54FURGnUf4I6yL7yS3a8a5XQ1T/TZxOlcN4V6538rL8mEKkBkkY4Zm
 q8i/1Wy8tAck4UG+Uy+YCFdB3yP1vzM38QZOFn38uul5MqVx29g2cS1vXHawIZVO9aTn
 5GwD1s9l+AhZfV44lcy438PLImDSAFDxXszRfBbuXgs+YwpAL6YRm8X2+xaaL0hL2avv
 3yqA==
X-Gm-Message-State: AOAM530vaa75MglgXJw+fFNlJ84bH5iXetZxyjJXxiuzYtjkYY1YeYvg
 ckVYGkqE+9RYrqWRDArFenNhrQ==
X-Google-Smtp-Source: ABdhPJzZ8f5Ky6acy6VQI23uTwNNjxp8z04jWKr85pksPj9N9r/ljm7s1fOdjDdx7Y2OWsJkDwiqpg==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr26835670wrq.357.1595945408262; 
 Tue, 28 Jul 2020 07:10:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v29sm18527824wrv.51.2020.07.28.07.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 07:10:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8EB461FF87;
 Tue, 28 Jul 2020 15:10:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/2] qemu-timer: gracefully handle the end of time
Date: Tue, 28 Jul 2020 15:10:04 +0100
Message-Id: <20200728141005.28664-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728141005.28664-1-alex.bennee@linaro.org>
References: <20200728141005.28664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: boost.lists@gmail.com, victor.clement@openwide.fr, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous behaviour was rather user hostile as timers set for
INT64_MAX would continually re-arm leaving the system locked in a loop
and the console unavailable. With this patch we detect the situation
and gracefully suspend the machine.

NB: we need a proper fix before the 23rd century.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/cpus.h |  2 ++
 softmmu/cpus.c        | 13 +++++++++++++
 util/qemu-timer.c     | 16 ++++++++++++++++
 stubs/Makefile.objs   |  1 +
 4 files changed, 32 insertions(+)

diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 3c1da6a0183..7da3a5b60b5 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -15,6 +15,8 @@ void configure_icount(QemuOpts *opts, Error **errp);
 extern int use_icount;
 extern int icount_align_option;
 
+void qemu_handle_outa_time(void);
+
 /* drift information for info jit command */
 extern int64_t max_delay;
 extern int64_t max_advance;
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899abb..46b6f346370 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -657,6 +657,19 @@ static bool shift_state_needed(void *opaque)
     return use_icount == 2;
 }
 
+/* Handler for reaching the end of time */
+void qemu_handle_outa_time(void)
+{
+    static bool reported = false;
+    if (runstate_is_running()) {
+        if (!reported) {
+            error_report("ran out of time, suspending emulation");
+            reported = true;
+        }
+        vm_stop(RUN_STATE_PAUSED);
+    }
+}
+
 /*
  * Subsection for warp timer migration is optional, because may not be created
  */
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index f62b4feecdb..06f6818eb3d 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -540,6 +540,22 @@ bool timerlist_run_timers(QEMUTimerList *timer_list)
      * done".
      */
     current_time = qemu_clock_get_ns(timer_list->clock->type);
+
+    /*
+     * Check to see if we have run out of time. Most of our time
+     * sources are nanoseconds since epoch (some time around the fall
+     * of Babylon 5, the start of the Enterprises five year mission
+     * and just before the arrival of the great evil ~ 2262CE).
+     * Although icount based time is ns since the start of emulation
+     * it is able to skip forward if the device is sleeping (think IoT
+     * device with a very long heartbeat). Either way we don't really
+     * handle running out of time so lets catch it and report it here.
+     */
+    if (current_time == INT64_MAX) {
+        qemu_handle_outa_time();
+        goto out;
+    }
+
     qemu_mutex_lock(&timer_list->active_timers_lock);
     while ((ts = timer_list->active_timers)) {
         if (!timer_expired_ns(ts, current_time)) {
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index d42046afe4e..d363d8b551b 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,5 +1,6 @@
 stub-obj-y += blk-commit-all.o
 stub-obj-y += cmos.o
+stub-obj-y += cpus.o
 stub-obj-y += cpu-get-clock.o
 stub-obj-y += cpu-get-icount.o
 stub-obj-y += dump.o
-- 
2.20.1


