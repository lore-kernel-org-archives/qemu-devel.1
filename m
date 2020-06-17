Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED47BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82AE2080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rW65jctj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82AE2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfdp-0005i4-Ps
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEJ-0003fb-3G
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:19 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEH-0000As-8o
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:18 -0400
Received: by mail-qk1-x742.google.com with SMTP id c185so3482973qke.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VHZjlUaQqM5GtwqE4D5+D6h1EspkQ+6Rl4guLSEBSAc=;
 b=rW65jctjvH3r1V0QQCpLFxV92Q8HELkZYRBzjiw48re9Oq4ktX+sKEWxBDM3ToS+ER
 wGl/jf00OTfgHLkjaKMUpx/AoKKU56sPW8nVgfFS8xc0NHsBx5Z0SqUxpYJkHEqVT6PW
 wbVuh145a6dEWUWL2+NNgeydVGpTxRn1qBE03mNHOW6y+Jk3IcIWww6e+gJjG3X6WCQz
 uv7hoPuReXuxzaPsL4epXTzDdHp96L2z9q939unvGXhrUdAebUwJAsXMvaJGS/1D21Yk
 Cw0FKFVyrCJCa1VXdjTtSb/985jjNnylrH9eCKny0oMnxqVqYFs6AP37CcZNZV4uNSQW
 kulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VHZjlUaQqM5GtwqE4D5+D6h1EspkQ+6Rl4guLSEBSAc=;
 b=ooYWCfz2JyLcsMcxQqQjjVjhkxcUo9j5NadwiHv6lrqB597gDenFaIefD9pHKuN4mT
 Y/Ka5DrkWtInAusXne8sci/f4fgqr5zlYH60hA9vsbu8nxKmcNcGMDqOQ87dGZe7eVwQ
 IrIpTHnF+J15dCXuPVMJyOfJ8gqqeRy3iAPXxL79FBLZKTFeMWpO5XzeDSWoWoFdFv3x
 z0KQSk8OsNO5ojuOS8FhJzP57OECDEfiWcw+H7F4TTcf3YCUnld9J6iNT2wWuQNSqdD3
 OAf+V6wUFfAC2I79gx9Yr4/GS7PX440Em4s6ktybuFqERaYjTkkUa6Py8J1mbn4IWBau
 XN4A==
X-Gm-Message-State: AOAM530ofFmWDcdX/ZRPMNIP5zx3eiT/Wzmg+DfVhsNtm+0gFIXFB7fH
 knm7a3lUBMrZFggfaDf/FV0tIA0w3YPRlg==
X-Google-Smtp-Source: ABdhPJxyKdvZ4aTBFboYGa3cyD2sHZUkg6lAUtf1Rd1J2TFMKrvzXJSRmL1I18OvrnNIK6b3tMDH6g==
X-Received: by 2002:a37:9ad5:: with SMTP id c204mr548600qke.413.1592427855921; 
 Wed, 17 Jun 2020 14:04:15 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:15 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 41/73] i386/hax-all: convert to cpu_interrupt_request
Date: Wed, 17 Jun 2020 17:01:59 -0400
Message-Id: <20200617210231.4393-42-robert.foley@linaro.org>
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
Cc: robert.foley@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 cota@braap.org, "open list:X86 HAXM CPUs" <haxm-team@intel.com>,
 Colin Xu <colin.xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peter.puhov@linaro.org, Richard Henderson <rth@twiddle.net>,
 alex.bennee@linaro.org, Wenchao Wang <wenchao.wang@intel.com>
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
index 6a4152730f..20a75a891f 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -298,7 +298,7 @@ int hax_vm_destroy(struct hax_vm *vm)
 
 static void hax_handle_interrupt(CPUState *cpu, int mask)
 {
-    cpu->interrupt_request |= mask;
+    cpu_interrupt_request_or(cpu, mask);
 
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
@@ -432,7 +432,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * Unlike KVM, HAX kernel check for the eflags, instead of qemu
      */
     if (ht->ready_for_interrupt_injection &&
-        (cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+        (cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         int irq;
 
         irq = cpu_get_pic_interrupt(env);
@@ -446,7 +446,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
      * interrupt, request an interrupt window exit.  This will
      * cause a return to userspace as soon as the guest is ready to
      * receive interrupts. */
-    if ((cpu->interrupt_request & CPU_INTERRUPT_HARD)) {
+    if ((cpu_interrupt_request(cpu) & CPU_INTERRUPT_HARD)) {
         ht->request_interrupt_window = 1;
     } else {
         ht->request_interrupt_window = 0;
@@ -485,7 +485,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         return 0;
     }
 
-    if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
+    if (cpu_interrupt_request(cpu) & CPU_INTERRUPT_POLL) {
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         apic_poll_irq(x86_cpu->apic_state);
     }
@@ -508,20 +508,20 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
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
@@ -590,13 +590,17 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
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


