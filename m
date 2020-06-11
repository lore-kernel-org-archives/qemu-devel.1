Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B471C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2628A2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTsoW1o7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2628A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjULI-0006ca-2t
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAK-0001jV-AO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAI-0001P8-62
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMnr7zXWEWTvgAmjZlP3tjzkRRR2WfEvyUCiG7b0XSE=;
 b=VTsoW1o7DGFSf1JU82O5DULgvWtUExSCuBc1kStl2LNdagDMqNZ2wcW4N7sqIwC2Cmb/Zs
 6EV4+Qq8JYnPjHoEEq32ZiJLqYHGKl1ztQNNVHcjBv9AZ4NC9aLSYtjTlgAO4QNz4KuKVF
 n4uikH4ASKPOzYMXl52wZ2mnfNcAFFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-8SVmjhpvNceigRB55tpB7g-1; Thu, 11 Jun 2020 15:47:03 -0400
X-MC-Unique: 8SVmjhpvNceigRB55tpB7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ED9C845F29;
 Thu, 11 Jun 2020 19:47:02 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B63EE10013D7;
 Thu, 11 Jun 2020 19:47:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 094/115] i386: hvf: Drop copy of RFLAGS defines
Date: Thu, 11 Jun 2020 15:44:28 -0400
Message-Id: <20200611194449.31468-95-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

Use the ones provided in target/i386/cpu.h instead.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-10-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86.c        |  2 +-
 target/i386/hvf/x86.h        | 20 --------------------
 target/i386/hvf/x86_decode.c | 16 +++++++---------
 target/i386/hvf/x86_task.c   |  2 +-
 4 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index 7ebb5b45bd..fdb11c8db9 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -131,7 +131,7 @@ bool x86_is_v8086(struct CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-    return x86_is_protected(cpu) && (env->eflags & RFLAGS_VM);
+    return x86_is_protected(cpu) && (env->eflags & VM_MASK);
 }
 
 bool x86_is_long_mode(struct CPUState *cpu)
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index e309b8f203..f0d03faff9 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -42,26 +42,6 @@ typedef struct x86_register {
     };
 } __attribute__ ((__packed__)) x86_register;
 
-typedef enum x86_rflags {
-    RFLAGS_CF       = (1L << 0),
-    RFLAGS_PF       = (1L << 2),
-    RFLAGS_AF       = (1L << 4),
-    RFLAGS_ZF       = (1L << 6),
-    RFLAGS_SF       = (1L << 7),
-    RFLAGS_TF       = (1L << 8),
-    RFLAGS_IF       = (1L << 9),
-    RFLAGS_DF       = (1L << 10),
-    RFLAGS_OF       = (1L << 11),
-    RFLAGS_IOPL     = (3L << 12),
-    RFLAGS_NT       = (1L << 14),
-    RFLAGS_RF       = (1L << 16),
-    RFLAGS_VM       = (1L << 17),
-    RFLAGS_AC       = (1L << 18),
-    RFLAGS_VIF      = (1L << 19),
-    RFLAGS_VIP      = (1L << 20),
-    RFLAGS_ID       = (1L << 21),
-} x86_rflags;
-
 typedef enum x86_reg_cr0 {
     CR0_PE =            (1L << 0),
     CR0_MP =            (1L << 1),
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index d881542181..34c5e3006c 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -697,15 +697,13 @@ static void decode_db_4(CPUX86State *env, struct x86_decode *decode)
 
 
 #define RFLAGS_MASK_NONE    0
-#define RFLAGS_MASK_OSZAPC  (RFLAGS_OF | RFLAGS_SF | RFLAGS_ZF | RFLAGS_AF | \
-                             RFLAGS_PF | RFLAGS_CF)
-#define RFLAGS_MASK_LAHF    (RFLAGS_SF | RFLAGS_ZF | RFLAGS_AF | RFLAGS_PF | \
-                             RFLAGS_CF)
-#define RFLAGS_MASK_CF      (RFLAGS_CF)
-#define RFLAGS_MASK_IF      (RFLAGS_IF)
-#define RFLAGS_MASK_TF      (RFLAGS_TF)
-#define RFLAGS_MASK_DF      (RFLAGS_DF)
-#define RFLAGS_MASK_ZF      (RFLAGS_ZF)
+#define RFLAGS_MASK_OSZAPC  (CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C)
+#define RFLAGS_MASK_LAHF    (CC_S | CC_Z | CC_A | CC_P | CC_C)
+#define RFLAGS_MASK_CF      (CC_C)
+#define RFLAGS_MASK_IF      (IF_MASK)
+#define RFLAGS_MASK_TF      (TF_MASK)
+#define RFLAGS_MASK_DF      (DF_MASK)
+#define RFLAGS_MASK_ZF      (CC_Z)
 
 struct decode_tbl _1op_inst[] = {
     {0x0, X86_DECODE_CMD_ADD, 1, true, decode_modrm_rm, decode_modrm_reg, NULL,
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 6ea8508946..6f04478b3a 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -158,7 +158,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
     }
 
     if (reason == TSR_IRET)
-        env->eflags &= ~RFLAGS_NT;
+        env->eflags &= ~NT_MASK;
 
     if (reason != TSR_CALL && reason != TSR_IDT_GATE)
         old_tss_sel.sel = 0xffff;
-- 
2.26.2



