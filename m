Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6543AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEE12078C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Tfwt5eIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEE12078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOSC-0002Fh-Ay
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOMC-0000lu-Ho
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:24 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35578 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOMB-00076V-AI
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:24 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 2035F4C861;
 Thu, 28 May 2020 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694684; x=1592509085; bh=NKFcYE5L699uPHjvHDqV4i9kX8ozuDFlECW
 9ew8jO0c=; b=Tfwt5eIMU5A8CnyOa7KdZEKL8lpLqv2UvjkuVyczSk889E/CU+b
 akDQd0f5aSSQ9D9YCWn0A6rLN7mvxUpCykQ/5FgrPVVWG0ug/8dcg7IvRthEUn4F
 rfFHeNckOZH3BiH4sabqSz81PGNVETAkJUYrIAkX+1XNkTIdPzwPiKDE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BarkcSVXlCOi; Thu, 28 May 2020 22:38:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 407A04C863;
 Thu, 28 May 2020 22:38:04 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:06 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 09/13] i386: hvf: Drop copy of RFLAGS defines
Date: Thu, 28 May 2020 22:37:54 +0300
Message-ID: <20200528193758.51454-10-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the ones provided in target/i386/cpu.h instead.

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
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
2.26.1


