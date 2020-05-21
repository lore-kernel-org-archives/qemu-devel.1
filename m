Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F03DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3083120759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4Arfkbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3083120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboeh-0000Uh-DB
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIn-0003jq-Ml
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:13 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jboIm-0006c6-Mq
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:44:13 -0400
Received: by mail-qk1-x743.google.com with SMTP id b6so7813608qkh.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s4hrOWLlZCdJWXysypnArxYHpdNRngJdlfVjmEHFHi0=;
 b=u4ArfkbxegKy6OUgbVv2mkmVN0sz0duoLipCvIIiUEPoNRNVN634iz7hLO1AcVv4fE
 73Ev/Xkn8zoRWuZlF3FcA384xrqqDbBHYLTposjM2f+njbGox0FUfydWkt+5lEo0lUAV
 farZEEcSZ3yCpGgpDH5DDGgx1qf6pkJGY7aphwd82lPPcUtHYWD+uJvsZ9DxjGJaEIFU
 b1Pq/JUZtIQVm/NpUN9tbTCh1PMDQGuOVDp8RZLSrf+OH1HVqWKNYllgCgQhaC08ACk2
 H3feNnkzuN4+zlSiZu/Ptm2tSJNZV7uuw47hOsIFwrpNLTXVVMjHxLG6pjlLq/PQuR+d
 3lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s4hrOWLlZCdJWXysypnArxYHpdNRngJdlfVjmEHFHi0=;
 b=Cw/3VHZF0dMa8iIoPj3SP+8q38hK4ezQCBx8l5KWrOUYTmEnpz3vgVB1mln0NeOqBj
 80yMbI59tJMQaqjqGJrkhv5HvVFEf9aQRpOtn2EB+gGyThtYeDaL/7mh0brcT1VDeTFb
 bZh7LaOWYP6m7lf9KRVyJm4+udfmChLZp0L5Q7asaFaVlyob5QJ72+0Zh04dtoSrY/+U
 G0Zp46At6w9ks7U7lFuPTe4aJN3KtXgTP+VF6d8Ctqr33mLjyC+eQhODAFLT/IqiihY+
 ETOdYEAgtPcJ3RoFK/j4LwFdS7xq4vOUiGKLPYz6xZ+oygI4E45EboWgUzStFbP4Rw+r
 +nMw==
X-Gm-Message-State: AOAM531BxS1lUtYKW89zBs9kZ+fesnsdBhQT+hNZnzbJK1YVWKWpa+na
 k+hGNbpw8aTEP8UDYroi9Vz0a1oe8qP+nQ==
X-Google-Smtp-Source: ABdhPJx1LT88MTQ6mKkBlIW9WI2xe30FN6BuxKYTgY20kHhSMQpkPAUzu7sa6KYBs5IJVi5Fttjq1Q==
X-Received: by 2002:a05:620a:204e:: with SMTP id
 d14mr9449775qka.13.1590079451503; 
 Thu, 21 May 2020 09:44:11 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:1944:c530:655c:5583])
 by smtp.gmail.com with ESMTPSA id x24sm5923829qth.57.2020.05.21.09.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:44:10 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 42/74] i386/hax-all: convert to cpu_interrupt_request
Date: Thu, 21 May 2020 12:39:39 -0400
Message-Id: <20200521164011.638-43-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521164011.638-1-robert.foley@linaro.org>
References: <20200521164011.638-1-robert.foley@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Converted new code to cpu_interrupt_request]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/i386/hax-all.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 1edd6c77df..66de14b27b 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -285,7 +285,7 @@ int hax_vm_destroy(struct hax_vm *vm)
 
 static void hax_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
@@ -419,7 +419,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * Unlike KVM, HAX kernel check for the eflags, instead of qemu
      */
     if (ht->ready_for_interrupt_injection &&
-        (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        (cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         int irq;
 
         irq = cpu_get_pic_interrupt(env);
@@ -433,7 +433,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * interrupt, request an interrupt window exit.  This will
      * cause a return to userspace as soon as the guest is ready to
      * receive interrupts. */
-    if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         ht->request_interrupt_window = 1;
     } else {
         ht->request_interrupt_window = 0;
@@ -472,7 +472,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         return 0;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
@@ -495,20 +495,20 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
      *  c) INIT signal;
      *  d) SIPI signal.
      */
-    if (((cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD) &&
          (env->eflags & IF_MASK)) ||
-        (cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
+        (cpu_interrupt_request(cpu) & CPU_INTERRUPT_NMI)) {
         cpu_halted_set(cpu, 0);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_INIT) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_INIT) {
         DPRINTF("\nhax_vcpu_hax_exec: handling INIT for %d\n",
                 cpu->cpu_index);
         do_cpu_init(x86_cpu);
         hax_vcpu_sync_state(env, 1);
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_SIPI) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_SIPI) {
         DPRINTF("hax_vcpu_hax_exec: handling SIPI for %d\n",
                 cpu->cpu_index);
         hax_vcpu_sync_state(env, 0);
@@ -577,13 +577,17 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
             ret = -1;
             break;
         case HAX_EXIT_HLT:
-            if (!(cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
-                !(cpu->interrupt_request & CPU_INTERRUPT_NMI)) {
-                /* hlt instruction with interrupt disabled is shutdown */
-                env->eflags |= IF_MASK;
-                cpu_halted_set(cpu, 1);
-                cpu->exception_index = EXCP_HLT;
-                ret = 1;
+            {
+                uint32_t interrupt_request = cpu_interrupt_request(cpu);
+
+                if (!(interrupt_request & CPU_INTERRUPT_HARD) &&
+                    !(interrupt_request & CPU_INTERRUPT_NMI)) {
+                    /* hlt instruction with interrupt disabled is shutdown */
+                    env->eflags |= IF_MASK;
+                    cpu_halted_set(cpu, 1);
+                    cpu->exception_index = EXCP_HLT;
+                    ret = 1;
+                }
             }
             break;
         /* these situations will continue to hax module */
-- 
2.17.1


