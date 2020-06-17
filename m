Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C66C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E8B21582
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMYikFss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E8B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfGx-0008FZ-4u
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDc-0002iK-E0
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:36 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDP-0008QF-Qe
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:03:34 -0400
Received: by mail-qk1-x742.google.com with SMTP id n11so3487335qkn.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hf6KnrMMAO78JvrEU5J5AEUZKfa7iIkvGpGZcKZJQGs=;
 b=XMYikFsscz06ROPMZ9LLk/ydPwrUpyhSe/DtawZ3X35OB/tmH6mv3wRhWZ8VU65em+
 4675uYtMi9RFmjkG4w5PHAXD5xfxs2FpNGzAKvDqLXiBFGbcr9B7knrDL2y0xX5/40HR
 /IMu4cdcct442Zw7n1ccynwRASWFWG5Tl5stH3eCrdHpf6Bd7mulfVUqhx8JOLcXJrBE
 +BAcAi+dt6FBYYDEv69Df5AUPRQyUGa/BTWep0zgYRhryK0uXE9LyCB//QX269jGtpk0
 IdJKSzS2z2h1uRWz3u8H/GVrPWI5OzsL+37T+4RrexjJDnJ5Av+rkFeS9Z4hofImj6Xq
 JgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hf6KnrMMAO78JvrEU5J5AEUZKfa7iIkvGpGZcKZJQGs=;
 b=nDPrUWdda/Eqi5i6PtvwOIc/7EqF2+2AKe4XFgVPCG8P/DUrdkvM0v+m8LXlap7lm4
 pD02JFDiS3GvZFlmBuVcVdAccn+gMvqZolIUFTzDjTQLp1/tKTrk5+Z49g7eSvIbEfAv
 qQ5rvRKoOa8WQ2dRVq74ZDd3sHkg9Hr4LjmvZL9aC1Mc8JssKtFV1zBV2Q+s3xoRx4t2
 gVRMj8j8BowD+0uXonZb7r27OT38ASdclt/SBWT8NePWYPgjPY2epofagGvKWPLfEGu9
 sfjduspvIFZG/+dmIRQnlv4twx9JYZuhnciEl4SdEDObjGISlQY9snsVfngafGKjaKR7
 lztg==
X-Gm-Message-State: AOAM530SKy1Qkf7lPqc2Vj/OA12zHZsseEyQN2SQNRBDy7DLNiN8yYNB
 sI1X383UuwSxXTjKRv3Az/pUnxwXnGbcXg==
X-Google-Smtp-Source: ABdhPJwJScHxgvcaDYcTqrc8O45oc6j+JH+aVCCY4gj6ZTvULScEi7dh3OC12yj3fMlgoWH4lwMIPQ==
X-Received: by 2002:a37:4ed2:: with SMTP id c201mr602204qkb.138.1592427802647; 
 Wed, 17 Jun 2020 14:03:22 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:21 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 05/73] cpu: introduce process_queued_cpu_work_locked
Date: Wed, 17 Jun 2020 17:01:23 -0400
Message-Id: <20200617210231.4393-6-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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

This completes the conversion to cpu_mutex_lock/unlock in the file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index b1069193c1..6f51ae127c 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -329,20 +329,19 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
-void process_queued_cpu_work(CPUState *cpu)
+/* Called with the CPU's lock held */
+static void process_queued_cpu_work_locked(CPUState *cpu)
 {
     struct qemu_work_item *wi;
     bool has_bql = qemu_mutex_iothread_locked();
 
-    qemu_mutex_lock(&cpu->lock);
     if (QSIMPLEQ_EMPTY(&cpu->work_list)) {
-        qemu_mutex_unlock(&cpu->lock);
         return;
     }
     while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
         wi = QSIMPLEQ_FIRST(&cpu->work_list);
         QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
-        qemu_mutex_unlock(&cpu->lock);
+        cpu_mutex_unlock(cpu);
         if (wi->exclusive) {
             /* Running work items outside the BQL avoids the following deadlock:
              * 1) start_exclusive() is called with the BQL taken while another
@@ -368,13 +367,19 @@ void process_queued_cpu_work(CPUState *cpu)
                 qemu_mutex_unlock_iothread();
             }
         }
-        qemu_mutex_lock(&cpu->lock);
+        cpu_mutex_lock(cpu);
         if (wi->free) {
             g_free(wi);
         } else {
             atomic_mb_set(&wi->done, true);
         }
     }
-    qemu_mutex_unlock(&cpu->lock);
     qemu_cond_broadcast(&cpu->cond);
 }
+
+void process_queued_cpu_work(CPUState *cpu)
+{
+    cpu_mutex_lock(cpu);
+    process_queued_cpu_work_locked(cpu);
+    cpu_mutex_unlock(cpu);
+}
-- 
2.17.1


