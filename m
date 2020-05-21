Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CE7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C67120759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZjevvvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C67120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbokn-0005OY-E5
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJO-0004tf-Jc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:50 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:36688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboJN-0006yJ-HY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:50 -0400
Received: by mail-qt1-x842.google.com with SMTP id v4so6015583qte.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wDuYpfs9QlEw4aXWAwthoPylqu8S5OXh9Q7CXYLnZi8=;
 b=CZjevvvF6bG4rCc0U5MLQJHndBYJxGCsV3rZ6cqVid5/gU7z5/OLRRXWDlHzJEYLKg
 MqGFVdFeTgG95hEhesAEUceMWkuoXakdW7it+cVZ5h69dHCvFwMaEQCPbg8A+5hKcNcG
 PlczMlUEeDA3YFl69KyA+c01SQjvMbmAqmEAuuP1JTv1CkCIoWySh1tT7TmCpzcSMX6O
 fkSzA7zgf284yCKefG6Rbg3scpsfGMtvtAKkyVXe/ImUy7A74ez1sljGsXCdO0VgXjpg
 2makoZ+nIuJgc1D6ykPsxl33oXEG0s8hC33OOOi1A6I/Gtrj88YUtnh2EjaYIuwYH2oc
 uSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wDuYpfs9QlEw4aXWAwthoPylqu8S5OXh9Q7CXYLnZi8=;
 b=CcXS9E6BAx2Evo+4qB17bEaCJVlXU0IJaLwi9AQloC5fp4/8ndGnh9R2nlx7h4D2Sd
 ZFbVzl9Z1TXONOSSqGBxFpzp4VnT8meKwVa0if0dDmfYAuwyYhPXOrdmi96zpxXQuNpB
 7ucfPCkMLeo3GXhHWGV6DUUNezCO7hKaAF0hFmH5Ev24tAx6pbE1T+0rEq/cVTZOB5/F
 T5rQcAew7IHNWOJEsgFiUvXiUbYBKsgDKdp08br86PvKjGplqAmjY6KYtXL+UkBL8LW5
 YIVD3EVREXoV8bokxX1sgFDjVaxtyhTvSAuejtzDSY9QCZko7HQaOWJImfBlv7MAlHm3
 KDQQ==
X-Gm-Message-State: AOAM531CW0KuKDOgvyMwtQ/aeJa1MjiZcj+QlLST70KXo1NovrPs2DTw
 Nqusu2qsNQtKzbU6OM7QOXytv8Bw7fpl8Q==
X-Google-Smtp-Source: ABdhPJy+ztiScICekgyUDMqsyocmXAcMSbF2lnIgx3oJ6lD6op6mruD+TTzT3uALuY/JD6U/qXWbKQ==
X-Received: by 2002:ac8:393a:: with SMTP id s55mr11528006qtb.48.1590079488317; 
 Thu, 21 May 2020 09:44:48 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:47 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 70/74] cpu: rename all_cpu_threads_idle to
 qemu_tcg_rr_all_cpu_threads_idle
Date: Thu, 21 May 2020 12:40:07 -0400
Message-Id: <20200521164011.638-71-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
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
index ff67fa9f5f..bcba0552bf 100644
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
@@ -641,7 +643,7 @@ void qemu_start_warp_timer(void)
     }
 
     if (replay_mode != REPLAY_MODE_PLAY) {
-        if (!all_cpu_threads_idle()) {
+        if (!qemu_tcg_rr_all_cpu_threads_idle()) {
             return;
         }
 
@@ -1300,7 +1302,7 @@ static void qemu_tcg_rr_wait_io_event(void)
 {
     CPUState *cpu;
 
-    while (all_cpu_threads_idle()) {
+    while (qemu_tcg_rr_all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
         qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
     }
@@ -1656,7 +1658,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
-        if (use_icount && all_cpu_threads_idle()) {
+        if (use_icount && qemu_tcg_rr_all_cpu_threads_idle()) {
             /*
              * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
              * in the main_loop, wake it up in order to start the warp timer.
-- 
2.17.1


