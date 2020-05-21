Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0BE22072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFnHTXzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BE22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboIx-0003Za-3H
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboI0-0001kD-EY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:24 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboHz-0006Un-Gb
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:43:24 -0400
Received: by mail-qk1-x742.google.com with SMTP id i14so7812530qka.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HfcAo2caqwFqp8BpPOPBnSoEMj4Sv7hELhtAr2WNKok=;
 b=SFnHTXzSh2ag6jIBf0pEydEZ6td6e1OCXQWpaRBK5Z25C14+eNLrsTjzuMwcWjaeZV
 XFm7hX2k6nPMHxLdiD1aRFtsHYOKDkAG4ReAiP9Xg20iMlHHFxdg4PbmSlDCrMN70d8k
 jk2GidJ3/O1yjPuRNt0tCazvwcUohnPS6DeG+PwbPYHpEjjnnW8/c2bZ0Uq7ZgEZtMBJ
 cfIowcnah10R7q/0J2eJY83Fv9DtxyvewE4gAfR2/AUgNLM80HjJN+Jd1x8bWTt8k+4k
 9t1tQpxhNFyEWype+wcQ10lv2vO205UjVu0mrqlHccR407AgUANYXUnnaEoO0bD6a3Wn
 oAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HfcAo2caqwFqp8BpPOPBnSoEMj4Sv7hELhtAr2WNKok=;
 b=SwSiaf2mEYfsM0N222XHUGLigR5cDCX3n5L8rbt+7QV7UjU3fgAFLhl8sCcTDJSLFY
 VOnpb2xyawU+1UTDihKsquRMqYUvcAn6rvt3yvSPz+T70Ef557SgmnHqMZmoWFDB2nES
 /4+0cAB/LudDCdUKbnpghPXL2qL1lCOxrROImT0MEON8ED7Jj3j0DqcG9HQhFMT1FZae
 vFZE43oBOAUI5/VH7BAHQs4lkd44TghZ9tZKfuspqTjALaLvfecexip6Z0+H5pd9bTHd
 K/V6Bmvpw0mZuChwR+g+1PTBC6UjpGhoy/wB3ZUV0gLC7c9NY7fTF1ULbgy59NaPu15G
 HUAQ==
X-Gm-Message-State: AOAM530YC8VT48RluHUN8KSpCgBY2Rhfn6bmBoWqzAb1RI9BOG0xvDfU
 OSjR6q67xI9+zye3Iaal0yQPLeKAnlk+zA==
X-Google-Smtp-Source: ABdhPJwoRIEF3ujvJ+O4jPhLxFI1fmn7mr+Nv75o3Pg9HhhjTeeFjB7Jgb5HaOb9Evlu3n/eHgTD6g==
X-Received: by 2002:a37:9d09:: with SMTP id g9mr10904604qke.154.1590079401889; 
 Thu, 21 May 2020 09:43:21 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:43:21 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 06/74] cpu: introduce process_queued_cpu_work_locked
Date: Thu, 21 May 2020 12:39:03 -0400
Message-Id: <20200521164011.638-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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

This completes the conversion to cpu_mutex_lock/unlock in the file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus-common.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 907ba5f0fc..e2f609c8e2 100644
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


