Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F26C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF04E20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5RxjlOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF04E20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhYy-0006AW-Q2
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ7-0002Vm-M5
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQ5-0001Ow-Vv
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:29:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id l15so1591244wmh.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uRdMRxER7cb8oQTA+SlFFqVRv1uiq/QJ/9qurTpeFuY=;
 b=I5RxjlOyRFyDCOx7B2cHVipakBL84ekWCpjwOvzgBsEmNxB62h9R+u9yxpvDaFcykg
 dBzb4k9fzdlGBNYybAa09bN/8qIBzhR86PqinruMgjYuQCkw7tHrTYlhYtSJWMAEIdAg
 8RJmEaTDYvHWkc8LdoMCva5cOlIli3SPLExfnsflP6e1Rcl4qVoP4BFMROQ1oaf/6oL0
 ljKLf94Jv+GupLHuG3UKWH0zJfKCWcHFr+kxUOxXHC9Mf4sblx9iYkUNZRv0uWKPb0MX
 BFrn/qGvC+gkvSpMzFkR59qmO2VMdmHi7EIIduy9Oxhl+EqRp5pZmDdR7qQPUM45MNzY
 X6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uRdMRxER7cb8oQTA+SlFFqVRv1uiq/QJ/9qurTpeFuY=;
 b=YDK5s6VMASCD+734IRRhbZaQoCLC9+R2AKj9YrnciDVVWtwaGwZjd2wdexyhfmeGqf
 PR0ph4cC4f0kLuHWemTAkxxf7QQSPsWyKOoY3+/CASdg+OuwfFQ7b11IDJJTGzCz7wPR
 tCvgZgAiYh4TGT/wyBmb7ZfdMdiIOeo6z3NQP/4zaI/C+UJiSHDA4pH+tPQSQPNK69ju
 tfiqQwdhHhyuxAS934vvcngc6eHw982DZqW77lWriHNUK5UocJYa/waDsiHBs6m/Rf9H
 /ccKYrjXBHJbwn+tNy9pmGl1kSLJhHCd2tY6ZsnQdJ21b8NnXZ+lGUwo8apuHJO34opn
 mW7Q==
X-Gm-Message-State: AOAM531EmuzSgozXoBsxNwmFABUwRsJYklqhpl+5lZwQq8zzj0prCwI0
 0EK7spvcx0Ue90W06qQnM5qIJju8HdY=
X-Google-Smtp-Source: ABdhPJx0qPeCsMpmH7psxhr6lfDulKqVL9lep2Umi6rMuFnwdJXvTAwgahb/0mQMebOPcvGjIpdX+Q==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr3289979wms.30.1601969396276; 
 Tue, 06 Oct 2020 00:29:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:29:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/37] cpus: remove checks for non-NULL cpus_accel
Date: Tue,  6 Oct 2020 09:29:21 +0200
Message-Id: <20201006072947.487729-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudio Fontana <cfontana@suse.de>

now that all accelerators support the CpusAccel interface,
we can remove most checks for non-NULL cpus_accel,
we just add a sanity check/assert at vcpu creation.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/cpus.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 1180103ede..99f418437b 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -166,34 +166,46 @@ void cpu_synchronize_all_pre_loadvm(void)
 
 void cpu_synchronize_state(CPUState *cpu)
 {
-    if (cpus_accel && cpus_accel->synchronize_state) {
+    if (cpus_accel->synchronize_state) {
         cpus_accel->synchronize_state(cpu);
     }
 }
 
 void cpu_synchronize_post_reset(CPUState *cpu)
 {
-    if (cpus_accel && cpus_accel->synchronize_post_reset) {
+    if (cpus_accel->synchronize_post_reset) {
         cpus_accel->synchronize_post_reset(cpu);
     }
 }
 
 void cpu_synchronize_post_init(CPUState *cpu)
 {
-    if (cpus_accel && cpus_accel->synchronize_post_init) {
+    if (cpus_accel->synchronize_post_init) {
         cpus_accel->synchronize_post_init(cpu);
     }
 }
 
 void cpu_synchronize_pre_loadvm(CPUState *cpu)
 {
-    if (cpus_accel && cpus_accel->synchronize_pre_loadvm) {
+    if (cpus_accel->synchronize_pre_loadvm) {
         cpus_accel->synchronize_pre_loadvm(cpu);
     }
 }
 
 int64_t cpus_get_virtual_clock(void)
 {
+    /*
+     * XXX
+     *
+     * need to check that cpus_accel is not NULL, because qcow2 calls
+     * qemu_get_clock_ns(CLOCK_VIRTUAL) without any accel initialized and
+     * with ticks disabled in some io-tests:
+     * 030 040 041 060 099 120 127 140 156 161 172 181 191 192 195 203 229 249 256 267
+     *
+     * is this expected?
+     *
+     * XXX
+     */
     if (cpus_accel && cpus_accel->get_virtual_clock) {
         return cpus_accel->get_virtual_clock();
     }
@@ -207,7 +219,7 @@ int64_t cpus_get_virtual_clock(void)
  */
 int64_t cpus_get_elapsed_ticks(void)
 {
-    if (cpus_accel && cpus_accel->get_elapsed_ticks) {
+    if (cpus_accel->get_elapsed_ticks) {
         return cpus_accel->get_elapsed_ticks();
     }
     return cpu_get_ticks();
@@ -399,7 +411,7 @@ void cpus_kick_thread(CPUState *cpu)
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
-    if (cpus_accel && cpus_accel->kick_vcpu_thread) {
+    if (cpus_accel->kick_vcpu_thread) {
         cpus_accel->kick_vcpu_thread(cpu);
     } else { /* default */
         cpus_kick_thread(cpu);
@@ -573,12 +585,9 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    if (cpus_accel) {
-        /* accelerator already implements the CpusAccel interface */
-        cpus_accel->create_vcpu_thread(cpu);
-    } else {
-        g_assert_not_reached();
-    }
+    /* accelerators all implement the CpusAccel interface */
+    g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
+    cpus_accel->create_vcpu_thread(cpu);
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
-- 
2.26.2



