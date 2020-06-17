Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32F42166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeIjDad8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32F42166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfq5-0000mo-2c
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEz-0004kL-11
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:05:01 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEu-0000Pw-Gg
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:59 -0400
Received: by mail-qt1-x842.google.com with SMTP id c12so2732467qtq.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E8xOKg6zl9lpl0+sHu1MbBAzWMqSY0gf0lTzZwybF5o=;
 b=eeIjDad8QZZSwiPDJPlhK/CUYY5xjxWhWsCKEVDRwD3prmDhbP4OuHsTXGFXpyrqcq
 fgL/59sa1tTdZYAx6uk1lLa5Q+Se/972AnxrO01Cr8/UbSGVL7bn9NSGDkTMTMbicdhQ
 aH/doqCOF3vW6zSGP+7cYoR2f1igNxpmw1+vimHRxx+divzGubxR3ypvQNKYjIj+oXwa
 48NS/Hj43H6dv3L/tKAC9jBK21DOMfFZlfHZ4LAGuFfFQdKm6EdjWN7e2YQTkxIee/fu
 vOU7ri095drXYoDMfOlLhttYnZPJTQZHypybF08Lqdh60s/NBK+ZJVNp/n6DyPSKPbae
 PvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E8xOKg6zl9lpl0+sHu1MbBAzWMqSY0gf0lTzZwybF5o=;
 b=sK5Gk8ZWfHUjZaOIMN5+6k6nwzG3NAmRgUnZJdh+omn0cPJxYsflrqjKUxytgBWIqc
 n090WGK/hOT3DTGCzMVyu4yQzfzOyI/Ref6/5wNfuuBdByS/6NAFL5VoaLMSA56hQms/
 JfnMUYRjmCl1dkZ+s0OYdfRXViqX6AuVXnkEgEawo1PMSzuL5SDky5+uvCwIwY81MeHk
 XXCo+JNaK39KXtTKcGOO2oAduPEK5Pj8jwyNFaFRodU2cBVhheT9a0cfmQsnyJFCap/s
 9E+syn7r6E390Y09vM3cP8Gedxz9/BZMjjCWHc3OGOTKDh0nGcahLErK5o+Zz9IzU0bF
 AeOw==
X-Gm-Message-State: AOAM533Jfeu8PiAaqTpp248VUgzbsJY8qiZiCFa5s0mVqlej560yD1Gj
 +IbCxTG3ri1EGhuiK4CKo/t3f8jsWJMQkQ==
X-Google-Smtp-Source: ABdhPJxNIzeZBOZW0gNtxYteNvYRgBJc+2t1LbJsDe88yOKZZbS2v0yNUfFBlPV9NqI3svqHVeS7nA==
X-Received: by 2002:ac8:4281:: with SMTP id o1mr1113527qtl.322.1592427894841; 
 Wed, 17 Jun 2020 14:04:54 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:54 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 69/73] cpu: rename all_cpu_threads_idle to
 qemu_tcg_rr_all_cpu_threads_idle
Date: Wed, 17 Jun 2020 17:02:27 -0400
Message-Id: <20200617210231.4393-70-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This function is only called from TCG rr mode, so add
a prefix to mark this as well as an assertion.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cpus.c b/cpus.c
index e070bffbff..2e9c19ae36 100644
--- a/cpus.c
+++ b/cpus.c
@@ -230,10 +230,12 @@ static bool cpu_thread_is_idle(CPUState *cpu)
     return true;
 }
 
-static bool all_cpu_threads_idle(void)
+static bool qemu_tcg_rr_all_cpu_threads_idle(void)
 {
     CPUState *cpu;
 
+    g_assert(qemu_is_tcg_rr());
+
     CPU_FOREACH(cpu) {
         if (!cpu_thread_is_idle(cpu)) {
             return false;
@@ -642,7 +644,7 @@ void qemu_start_warp_timer(void)
     }
 
     if (replay_mode != REPLAY_MODE_PLAY) {
-        if (!all_cpu_threads_idle()) {
+        if (!qemu_tcg_rr_all_cpu_threads_idle()) {
             return;
         }
 
@@ -1320,7 +1322,7 @@ static void qemu_tcg_rr_wait_io_event(void)
 {
     CPUState *cpu;
 
-    while (all_cpu_threads_idle()) {
+    while (qemu_tcg_rr_all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
         qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
     }
@@ -1676,7 +1678,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        if (use_icount && all_cpu_threads_idle()) {
+        if (use_icount && qemu_tcg_rr_all_cpu_threads_idle()) {
             /*
              * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
              * in the main_loop, wake it up in order to start the warp timer.
-- 
2.17.1


