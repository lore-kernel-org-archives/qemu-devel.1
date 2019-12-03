Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92277C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0772064B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQBZ/qCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0772064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3Ls-0004Mf-CO
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ic3J2-00034K-1N
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ic3Iv-0000DW-OT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:13:07 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:39851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ic3Iv-0008Qn-HB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:13:05 -0500
Received: by mail-wr1-x433.google.com with SMTP id y11so2442983wrt.6
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 00:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ETrwLMQWqEqRlW82wI0iG/fYZD4nBOjxfTYJr7Z8waQ=;
 b=oQBZ/qCq1Qc1AOAKx4OWUDMD8Zdlul+BGXyzNgSgIlx/WjLt9kMKcU0B9WRAR9BFEp
 3capNJSFgdb4yLn69YMDJJw5tamGZiGprMKsZPfFWPSLRtxICfysSEr9FTqn6GBMwBHb
 M9076IN7qHJF+yFa4uRCvpUuExIrObfHiIUb0aVQNSFiY1bYTF/TDEdYftTFXFk7Niz5
 WVvaXTs9vHfjm0CkG1SkSjB5TIord3a5ny34PegsSa1dF1bt3W4anH84kYyq5n+7gciZ
 2mcO7kh5gPMGA2B/iDsX3vSwyWW5QOFz4/XNZQNttMn6DLM1dRtRH/OY5udtKJRvYirb
 /quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ETrwLMQWqEqRlW82wI0iG/fYZD4nBOjxfTYJr7Z8waQ=;
 b=VWjP+/685IdwW7TuZTZFd7B2qVTZivEZB2IJdmmN+zY4gcaMOsFId8KzSWVnG+hew/
 Yc86IV15pej1ygTU4xxDcJWWec4EO8Mz67e/n0Yrt6rnoSLSJEVk8ZPEleOE53wS3LGZ
 3YR6AVvlPV1SF1fOyukfpyjQpLImBuq4XAfsj/FZ7LYfKRxfO5xWOWRmPKN2p/isuyDM
 2FTYgeEe7eu386CDQUxQCCgDRAXUIUNLPhN1sYHF5d1xBx5EVyJozfLZ7M6N16VSnWW0
 gWDzlviGM+KEfqvhOolePr5Gf3NkxeYIKSdWPNIGDHqTILG/Qq2PT3TtOjAYokFzeR+Q
 d4UA==
X-Gm-Message-State: APjAAAXUGHCIF6bhYpliRdhCUYd3V3pYB61uNu9gdQPsCPhhxaYzYm/6
 a2odIZueAnssO5S2BBNPYsCZpvc1
X-Google-Smtp-Source: APXvYqwDjFwzLbe07E0XhrKXv/jS2zIRUYoFrAE2wMaKBf73IHXZ8TmQK7+spRc+uQjo1EUqzMvazA==
X-Received: by 2002:adf:cd0a:: with SMTP id w10mr3529397wrm.107.1575360781319; 
 Tue, 03 Dec 2019 00:13:01 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id d14sm2711593wru.9.2019.12.03.00.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 00:13:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] hvf: correctly inject VMCS_INTR_T_HWINTR versus
 VMCS_INTR_T_SWINTR.
Date: Tue,  3 Dec 2019 09:12:59 +0100
Message-Id: <20191203081259.906-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203081259.906-1-pbonzini@redhat.com>
References: <20191203081259.906-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cameron Esfahani <dirty@apple.com>

Previous implementation in hvf_inject_interrupts() would always inject
VMCS_INTR_T_SWINTR even when VMCS_INTR_T_HWINTR was required.  Now
correctly determine when VMCS_INTR_T_HWINTR is appropriate versus
VMCS_INTR_T_SWINTR.

Make sure to clear ins_len and has_error_code when ins_len isn't
valid and error_code isn't set.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <bf8d945ea1b423786d7802bbcf769517d1fd01f8.1575330463.git.dirty@apple.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c    |  4 +++-
 target/i386/hvf/x86hvf.c | 14 +++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 784e67d77e..d72543dc31 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -637,6 +637,8 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
     env->exception_injected = 0;
     env->interrupt_injected = -1;
     env->nmi_injected = false;
+    env->ins_len = 0;
+    env->has_error_code = false;
     if (idtvec_info & VMCS_IDT_VEC_VALID) {
         switch (idtvec_info & VMCS_IDT_VEC_TYPE) {
         case VMCS_IDT_VEC_HWINTR:
@@ -659,7 +661,7 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
             (idtvec_info & VMCS_IDT_VEC_TYPE) == VMCS_IDT_VEC_SWINTR) {
             env->ins_len = ins_len;
         }
-        if (idtvec_info & VMCS_INTR_DEL_ERRCODE) {
+        if (idtvec_info & VMCS_IDT_VEC_ERRCODE_VALID) {
             env->has_error_code = true;
             env->error_code = rvmcs(cpu->hvf_fd, VMCS_IDT_VECTORING_ERROR);
         }
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 1485b95776..edefe5319a 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -345,8 +345,6 @@ void vmx_clear_int_window_exiting(CPUState *cpu)
              ~VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING);
 }
 
-#define NMI_VEC 2
-
 bool hvf_inject_interrupts(CPUState *cpu_state)
 {
     X86CPU *x86cpu = X86_CPU(cpu_state);
@@ -357,7 +355,11 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     bool have_event = true;
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
-        intr_type = VMCS_INTR_T_SWINTR;
+        if (env->ins_len) {
+            intr_type = VMCS_INTR_T_SWINTR;
+        } else {
+            intr_type = VMCS_INTR_T_HWINTR;
+        }
     } else if (env->exception_nr != -1) {
         vector = env->exception_nr;
         if (vector == EXCP03_INT3 || vector == EXCP04_INTO) {
@@ -366,7 +368,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
             intr_type = VMCS_INTR_T_HWEXCEPTION;
         }
     } else if (env->nmi_injected) {
-        vector = NMI_VEC;
+        vector = EXCP02_NMI;
         intr_type = VMCS_INTR_T_NMI;
     } else {
         have_event = false;
@@ -390,6 +392,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
             if (env->has_error_code) {
                 wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_EXCEPTION_ERROR,
                       env->error_code);
+                /* Indicate that VMCS_ENTRY_EXCEPTION_ERROR is valid */
+                info |= VMCS_INTR_DEL_ERRCODE;
             }
             /*printf("reinject  %lx err %d\n", info, err);*/
             wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
@@ -399,7 +403,7 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
             cpu_state->interrupt_request &= ~CPU_INTERRUPT_NMI;
-            info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | NMI_VEC;
+            info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
             wvmcs(cpu_state->hvf_fd, VMCS_ENTRY_INTR_INFO, info);
         } else {
             vmx_set_nmi_window_exiting(cpu_state);
-- 
2.21.0


