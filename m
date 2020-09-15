Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA6EC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C3E20672
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wridOrpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C3E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1RQ-0005Jr-CD
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O7-0000Eg-8C
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:11 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O3-0001fm-Lk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id 34so1186500pgo.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fLJn3KGoDv4U0zm6QvQGS4S6fFA4pWWn06jbXE+Tvuk=;
 b=wridOrpG5CScKhmqwIxVFGd3J5VE6XNpo8HYGuvrk0FXgI0Z7wJXOCIUwexMCAfh5h
 xM8RAk+ObbXIZDY/MjfGaqPksQE7S8w+62/6DXBcygOlnKp79q8bPn7EgY6eV27Y4cwU
 2xfIJWFymvYSzuw8eHQBbdFp/JCKrnz4a3Km9BSsfeInn1Q7vAayZW+yS8ewMg3vL/1q
 JHq5f4AO9mXeOcWrLPO4koLC0hUexM96RpTs6GEkAXGsJeudV6u2I9G3DBq+a53w8N0p
 1r07yf0FLknjnwajCNM6st1Z9Xhtf8XScHm8LsGIUWhwYthyyjTfMr4TkhvO9QefR4j3
 +xKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fLJn3KGoDv4U0zm6QvQGS4S6fFA4pWWn06jbXE+Tvuk=;
 b=J+xANwrLQU992JYb+1LtT0yI4dsacqEoYLFqTleEiB+MSvqCjFlTcqdqMSQkZRRWYy
 FAEsXbncDzKnOsIBFAXLHWM57SqqIkQcj4hxBylsW650wnD4WGFwvlRDQmlC6/QihriR
 itjLwnsbHy7XYS26kB135i5YG72e7/08AZD3/xLzTaZmlxlAYOC96n2gA8t/wYrNgSEZ
 S0RePsENUY2BPC3rwRbHHp1FSOTwT8HP6X83jUbhzlCMx1bJQxfnpFsKgJWypjvyJ39S
 BufJ7lmA+46HvQ4dfGmueouDz8S6igLsG1ohoMoHshPXAuU3WNxsnk9l2Y0Rf5d/2TvG
 IxSg==
X-Gm-Message-State: AOAM530vflebMQXeIGuZRTtW/uNnlFQGxxpOzFQlnyQ+XIIOAM7SmbRX
 9LEJrYjb0f+DADG2d8dMhxVF
X-Google-Smtp-Source: ABdhPJwBXdvl9yr7pM5TSrJ/l+3T4lJ7BDCsxgqvLYdzTHAYMIArMlDdj0taTZ1SAWWRUbn6ibLv7A==
X-Received: by 2002:a62:17c5:: with SMTP id 188mr15658196pfx.148.1600139526235; 
 Mon, 14 Sep 2020 20:12:06 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:05 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 02/12] target/arm/kvm: spe: Add helper to detect SPE when
 using KVM
Date: Tue, 15 Sep 2020 03:11:38 +0000
Message-Id: <c32b0afe693c158115499da7b32321011deeedd9.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/kvm.c     |  5 +++++
 target/arm/kvm_arm.h | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378..58f991e890 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -214,6 +214,11 @@ bool kvm_arm_pmu_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
 }
 
+bool kvm_arm_spe_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SPE_V1);
+}
+
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index adb38514bf..f79655674e 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -283,6 +283,14 @@ bool kvm_arm_aarch32_supported(void);
  */
 bool kvm_arm_pmu_supported(void);
 
+/**
+ * kvm_arm_spe_supported:
+ *
+ * Returns: true if the KVM VCPU can enable its SPE
+ * and false otherwise.
+ */
+bool kvm_arm_spe_supported(void);
+
 /**
  * kvm_arm_sve_supported:
  *
@@ -366,6 +374,11 @@ static inline bool kvm_arm_pmu_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_spe_supported(void)
+{
+    return false;
+}
+
 static inline bool kvm_arm_sve_supported(void)
 {
     return false;
-- 
2.17.1


