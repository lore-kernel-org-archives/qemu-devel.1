Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF492C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEFE206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lw2/Uwd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEFE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGIz-0006Qd-Sp
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHm-0003WP-Ef
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:42 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHl-0003rQ-CT
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:42 -0400
Received: by mail-pf1-x444.google.com with SMTP id 23so4392891pfw.10
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KA74qkYRKvEU3ng1kAP13z7yTrox0/WpEe+h4sJiZmM=;
 b=lw2/Uwd8ZHKoaA5GuN/k3mU2SK9d8Uf+vZNl7PC/3t1lUu8jbQOB4SXaIsVyzWmdan
 GRPftAlfazcikKZGh4gBeGVRrXrDcw0v9el+qXwSJeajvb9FIm7dLDOJvpJ1oIcOYWgY
 5cA+a1cW4kWnp70n1UW0TdbAgwiLFMdAE9yS707VIXCmt2/us8ldRUelEyEeUOaRTcEU
 H5IiqTnAS0kjIBxhrALY8oAq3EBgvo3zHARtPauxyCW9y+FVzqqjrefoATCSU/3qnDgH
 tSM/0q1X4P0qVv6Js/wuuDrZRj+OG4ruI6mndCoFbHIUhl/p20t6OWzyeze6QC5C37Tf
 RisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KA74qkYRKvEU3ng1kAP13z7yTrox0/WpEe+h4sJiZmM=;
 b=JLzUZFNR4ODuhgfyb3CuAESpCsQRIpsJ9L30ASNF7tjrCrSjAH9vLdjfhytyL+aSDZ
 43mmRlqA3QlpYdQqFL+vbxyk3Sm6mNDyg8hbp8nAwH95SxSOJmC8cDYzyy3Zaz6yNChy
 9sF2eJk71/JX4aHqMtQ2/Bh9bSasd6OCW03c0sJgOwozsSAvb64Xbc1JgQ99Im87V73L
 NQluhtJRE/brsx25L1XBjYU8FLUSCohOjUiWyvVoiYPKO1r8esoRysUc7wr8kNdydpsu
 sIInAz7PiiLyl5CvbaD8Mf3FhLpSHoummpa4Cah3/3VZE7O+Drk4y7M3IUA8gtMxHeY7
 SUXQ==
X-Gm-Message-State: AOAM532ETORFXidpqNQa7AgcBbNp0gBQqwL5/m+rV5Uio/oFrZ5ZNii2
 QSXpCjba0TJ6+NObZVpG4z1e36FFHX2JgA==
X-Google-Smtp-Source: ABdhPJxA2O96zZ55IsBV3APgiv6CPJKSRMFbChmryneh1OAD2OWU7gaiafd8gWr/JnA4dGsHV0HObg==
X-Received: by 2002:a63:fc4a:: with SMTP id r10mr10624014pgk.417.1591378659877; 
 Fri, 05 Jun 2020 10:37:39 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:38 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/13] cputlb: destroy CPUTLB with tlb_destroy
Date: Fri,  5 Jun 2020 13:34:13 -0400
Message-Id: <20200605173422.1490-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: robert.foley@linaro.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

I was after adding qemu_spin_destroy calls, but while at
it I noticed that we are leaking some memory.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c      | 15 +++++++++++++++
 exec.c                  |  1 +
 include/exec/exec-all.h |  8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eb2cf9de5e..1e815357c7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -270,6 +270,21 @@ void tlb_init(CPUState *cpu)
     }
 }
 
+void tlb_destroy(CPUState *cpu)
+{
+    CPUArchState *env = cpu->env_ptr;
+    int i;
+
+    qemu_spin_destroy(&env_tlb(env)->c.lock);
+    for (i = 0; i < NB_MMU_MODES; i++) {
+        CPUTLBDesc *desc = &env_tlb(env)->d[i];
+        CPUTLBDescFast *fast = &env_tlb(env)->f[i];
+
+        g_free(fast->table);
+        g_free(desc->iotlb);
+    }
+}
+
 /* flush_all_helper: run fn across all cpus
  *
  * If the wait flag is set then the src cpu's helper will be queued as
diff --git a/exec.c b/exec.c
index 5162f0d12f..da3d60b034 100644
--- a/exec.c
+++ b/exec.c
@@ -892,6 +892,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
+    tlb_destroy(cpu);
     cpu_list_remove(cpu);
 
     if (cc->vmsd != NULL) {
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8792bea07a..3cf88272df 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -124,6 +124,11 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  * @cpu: CPU whose TLB should be initialized
  */
 void tlb_init(CPUState *cpu);
+/**
+ * tlb_destroy - destroy a CPU's TLB
+ * @cpu: CPU whose TLB should be destroyed
+ */
+void tlb_destroy(CPUState *cpu);
 /**
  * tlb_flush_page:
  * @cpu: CPU whose TLB should be flushed
@@ -284,6 +289,9 @@ void tlb_set_page(CPUState *cpu, target_ulong vaddr,
 static inline void tlb_init(CPUState *cpu)
 {
 }
+static inline void tlb_destroy(CPUState *cpu)
+{
+}
 static inline void tlb_flush_page(CPUState *cpu, target_ulong addr)
 {
 }
-- 
2.17.1


