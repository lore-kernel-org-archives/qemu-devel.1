Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:55:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5A2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bO9MuSq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE5A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlg1g-0007J3-N8
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfF1-0004mC-BO
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:05:03 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:34526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEx-0000Qd-99
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:05:01 -0400
Received: by mail-qk1-x743.google.com with SMTP id f18so3525502qkh.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kEALw3cb/snp1kLPThKHADdrwsKNjGM+CsHVn0z1BOY=;
 b=bO9MuSq1OMXIKKUrkq0Ed1xUAKaGJHYI3TUP8sVHeVVlXy8kYH34c8iZgMJ7FGnlqe
 LtFgPKywurlzQsVGxJ+n385Gxywl8qMKrJusr9swyNSfM3ix8tHpJMafEU+pLWKQI6iH
 sVjHNyiQd+vTndm/NIBFjdGdApsInLbwWq+1lIdmXpRff6HaHI5VmnqhejNxGBQNCpI3
 GNpwgL8Zt05GSWMz2KJLeu9VCQbJ9U826hXuqgwsQM9KtnHQrZtRU5FCUohfbxYRBzC1
 PNdle87wdF5h7jtxISc2tomBatJOEAFx1/oThnriGf/ZERfyrgcuLg8ymi0XmJw604ib
 irjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kEALw3cb/snp1kLPThKHADdrwsKNjGM+CsHVn0z1BOY=;
 b=OeTJPSthp0iRxitLyTqHbD5M/iqIBSnoczQpJizvzhgr29lwQHwbcN61hg+XOLkzXU
 9jhvshn0mZC/Y7LMO9VyqWR5v31LbDTIkteyjGPGX0/t0c3WB8kYuA/zfXvE7XcrDfJO
 BiiwCwRd7GgXiW2fYL8sRb51aM8iGkmhHNl2bcd2I7GBAxGoguzzFk5MyWAbC9pxaVF/
 d7S8FR1p6gGzkVZ73glcDiW6e68M/w36p7cPzhdsXaN4HtnnJTPWrvGrQPRx0rBOLjfK
 bo4MSiodYnkyg5a05ysSPgXWE/NzQi5afTHTrVnTstmoY8EnWOElrGANGPr9h/3eD3kF
 HTIw==
X-Gm-Message-State: AOAM531B26OfLKMZWk+WZ7Abg75wgkFjTQQ+IhzUT5iZWoKeXkkJgBjP
 uBUki7tdWDM8WLvu968Y0sgIGQ/rPhX3xw==
X-Google-Smtp-Source: ABdhPJyzFaP57/N9Q4K0gShHJH+xWEY+/KTNguIWfv27cMjyiMhByKkqR1X3YNWLKaDskUXg6ijGRA==
X-Received: by 2002:a37:d246:: with SMTP id f67mr578006qkj.300.1592427897910; 
 Wed, 17 Jun 2020 14:04:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:57 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 71/73] cpus-common: release BQL earlier in run_on_cpu
Date: Wed, 17 Jun 2020 17:02:29 -0400
Message-Id: <20200617210231.4393-72-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

After completing the conversion to per-CPU locks, there is no need
to release the BQL after having called cpu_kick.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 0287018dc4..eecd63029a 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -135,6 +135,11 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
         return;
     }
 
+    /* We are going to sleep on the CPU lock, so release the BQL */
+    if (has_bql) {
+        qemu_mutex_unlock_iothread();
+    }
+
     wi.func = func;
     wi.data = data;
     wi.done = false;
@@ -143,21 +148,6 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 
     cpu_mutex_lock(cpu);
     queue_work_on_cpu_locked(cpu, &wi);
-
-    /*
-     * We are going to sleep on the CPU lock, so release the BQL.
-     *
-     * During the transition to per-CPU locks, we release the BQL _after_
-     * having kicked the destination CPU (from queue_work_on_cpu_locked above).
-     * This makes sure that the enqueued work will be seen by the CPU
-     * after being woken up from the kick, since the CPU sleeps on the BQL.
-     * Once we complete the transition to per-CPU locks, we will release
-     * the BQL earlier in this function.
-     */
-    if (has_bql) {
-        qemu_mutex_unlock_iothread();
-    }
-
     while (!atomic_mb_read(&wi.done)) {
         CPUState *self_cpu = current_cpu;
 
-- 
2.17.1


