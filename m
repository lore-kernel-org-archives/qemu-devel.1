Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD16C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B033C206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLnPJayx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B033C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJGa-0006h4-8R
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJEz-0004kE-Pz
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJEx-0006rv-V4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:53 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJEx-0006qK-K9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id c9so9604649wrw.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GWiMxTEjs1K381f2nVjRWYY51/PQXmyOS4rDiBkvF/0=;
 b=kLnPJayxqP72w5mBX4IXo1EFXPA6KdNLdeY6v6EdNT0vwpclJIXpTSgUu24oa9nB3o
 S1bZlcUwhfO6M8yYiRV9FIxi9d/erbPS0YM15y2RZrLqFiYaITLPSqFZWjKbg+g+v+qw
 ex4p9M7Zj/XVObYEC5T3uoTa6jm5GUhsp5dBejb0QXFS0dETVbCzXQ9ubeL3aR0YyfU3
 ImbstMQKTxuB6myWbWVWQq4E9u8KUtUjvY3Ehhicq/lP4XYlpgzZNBMZxW9mJJo3uJ6X
 BRHk3Sde8eRQoVrG3Fp5uNDvQyHZ+VF0lVUSbDpQb6/SlAUvdJNfaEnaL94Vgni6wRKZ
 IJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GWiMxTEjs1K381f2nVjRWYY51/PQXmyOS4rDiBkvF/0=;
 b=mSRWjD6asduSIDpJ0vX6YXQzNCXPvOkQtdInem7FMiOq4Xu0XNIYf+5Q3ipkvkB2IP
 zMtIIK7MXoYNNLNB2kShuSDF7rHk6W0yUmnI1/1EXwsGX12TrIxjoCNvMl2iwJkoor1M
 cp3ScJUQSAehMO5hxEUOSi5rXofQZfHVMzoTFwNYs9GC2fc1svQz/FaJuQCybmD1go6n
 cEMZ0cmL1EI3caH5ls201rZ0o9euC37plaKIVPUVQWFVBeHkzl2ZsS32ojGgXPKo+g8z
 w5Qt+AdV8YXecHdsOJxW2KeNBynyIE5etp9AupEj8NRQ+qsNKTrup6XgwccXmMuX0/nE
 xJWA==
X-Gm-Message-State: APjAAAWUr2sn9OQps8tKuKpte5GtLIclc4e96KQ44t+s2iy5Z9Rbpa6v
 zalbUfB3hYPCf8GgBTErYvIwv67xLQpClA==
X-Google-Smtp-Source: APXvYqw9rVIjfX44o1XXfAXzC3dMgGlpkXtEGgKnTwMotak4ie62XYTeg+oWalScQGGjTt3jPP+Hlw==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr15493960wrn.155.1576852009870; 
 Fri, 20 Dec 2019 06:26:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] target/arm: Abstract the generic timer frequency
Date: Fri, 20 Dec 2019 14:26:34 +0000
Message-Id: <20191220142644.31076-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jeffery <andrew@aj.id.au>

Prepare for SoCs such as the ASPEED AST2600 whose firmware configures
CNTFRQ to values significantly larger than the static 62.5MHz value
currently derived from GTIMER_SCALE. As the OS potentially derives its
timer periods from the CNTFRQ value the lack of support for running
QEMUTimers at the appropriate rate leads to sticky behaviour in the
guest.

Substitute the GTIMER_SCALE constant with use of a helper to derive the
period from gt_cntfrq_hz stored in struct ARMCPU. Initially set
gt_cntfrq_hz to the frequency associated with GTIMER_SCALE so current
behaviour is maintained.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 40bd8df043f66e1ccfb3e9482999d099ac72bb2e.1576215453.git-series.andrew@aj.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  5 +++++
 target/arm/cpu.c    |  8 ++++++++
 target/arm/helper.c | 10 +++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5f70e9e0438..40f2c45e17e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -932,8 +932,13 @@ struct ARMCPU {
      */
     DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
     DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
+
+    /* Generic timer counter frequency, in Hz */
+    uint64_t gt_cntfrq_hz;
 };
 
+unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
+
 void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dd51adac059..0abe288e38c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
     }
+
+    cpu->gt_cntfrq_hz = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
 }
 
 static Property arm_cpu_reset_cbar_property =
@@ -1055,6 +1057,12 @@ static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &cpu->init_svtor, errp);
 }
 
+unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
+{
+    return NANOSECONDS_PER_SECOND > cpu->gt_cntfrq_hz ?
+      NANOSECONDS_PER_SECOND / cpu->gt_cntfrq_hz : 1;
+}
+
 void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 31fab098c55..85963789f7d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2449,7 +2449,9 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
 
 static uint64_t gt_get_countervalue(CPUARMState *env)
 {
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
+    ARMCPU *cpu = env_archcpu(env);
+
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
 }
 
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
@@ -2485,7 +2487,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * set the timer for as far in the future as possible. When the
          * timer expires we will reset the timer for any remaining period.
          */
-        if (nexttick > INT64_MAX / GTIMER_SCALE) {
+        if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
             timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
         } else {
             timer_mod(cpu->gt_timer[timeridx], nexttick);
@@ -2914,11 +2916,13 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
 
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
+    ARMCPU *cpu = env_archcpu(env);
+
     /* Currently we have no support for QEMUTimer in linux-user so we
      * can't call gt_get_countervalue(env), instead we directly
      * call the lower level functions.
      */
-    return cpu_get_clock() / GTIMER_SCALE;
+    return cpu_get_clock() / gt_cntfrq_period_ns(cpu);
 }
 
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
-- 
2.20.1


