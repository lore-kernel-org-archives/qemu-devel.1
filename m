Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194A4C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD69B2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uetKLGrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD69B2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWj0-0003Wh-UD
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhF-00021c-6O
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhE-00037A-0A
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:45 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iZWhD-00036v-QG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:43 -0500
Received: by mail-wm1-x329.google.com with SMTP id y5so2302448wmi.5
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dmZ/MWljO9/7PIDmw2I60lQlo/07TU1Uam/BYY6gYeg=;
 b=uetKLGrR5RS0NrkqselYiyB93a6LmFbTNUuLi2ihlRE/fXsY3RJVAZzBq+asYQhVfM
 c0/3sJ6hrcMaRe3a5SrjpqC3JophyTtdmp+vQfh3qgo5YxsgffhJd9+N+7HvwQlzhLGe
 mpNgMM6jSKsyUKet+SnVG1VTLZwHhU/iyfsV/6eavl6XoJzhOAsIuOexq8gcAajrqfHT
 vMa96s9Df+OJFB2ooytLCXrA2aaedToPHfR89OBSp+ALe2AcRaXMbeVsHhbPdmIswFE2
 pQBrOuSTfndLWbRzL7qtP8aULrQE5nJ+4+lILvE+6K6iUpstKzjSocClCcJpGlmiWTQj
 z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dmZ/MWljO9/7PIDmw2I60lQlo/07TU1Uam/BYY6gYeg=;
 b=JBlXPh/zx2dX+hgM0E0vStk8XhckD+SndPf1iWoirc/133VDifSryMHZ2Cosz72jkh
 /1vZ4+13HEK1Tbj9vOXe7PzrrgKDOQ3gERfU0mOYEe3H2sQd6IMgeknM3kvw/ZLLRFCo
 EfkdB3J5TzOPY05Hk3lHQ1i5p4ulEFfd6ScfwzcxrS4BgfraW1oKW6D2UbUy8E1SUeL/
 8wF3iaRlmUxay7uBMd69lshrplmTc34lrnEItvS8XWj9cA7R2ijBgnSJRwgxlTBOkS8p
 A/loE5cUBpux8x2n1mTlunk0zHn0g6Kl/iHmJIMM3Aju7MXEx5yU5pzjQpEkQ0VgVxGs
 JEWA==
X-Gm-Message-State: APjAAAXoF5Y9lykvgSFZcuqo4DKLGV9KpqR3zqPdH8i9MG3q6U6YyRaG
 TU4O/GPWnUaMgQSraWYqoLW4pZbO
X-Google-Smtp-Source: APXvYqz1Pv06jyMP/q3aDbJRMixlvx00Q7s7eVLUOUWSZjrIfG/Ph3iisxGtYkZG6CXm/9U0B0uteQ==
X-Received: by 2002:a05:600c:2919:: with SMTP id
 i25mr3025663wmd.158.1574758782613; 
 Tue, 26 Nov 2019 00:59:42 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id a206sm2349172wmf.15.2019.11.26.00.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 00:59:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] hvf: more accurately match SDM when setting CR0 and PDPTE
 registers
Date: Tue, 26 Nov 2019 09:59:36 +0100
Message-Id: <20191126085936.1689-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126085936.1689-1-pbonzini@redhat.com>
References: <20191126085936.1689-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

More accurately match SDM when setting CR0 and PDPTE registers.

Clear PDPTE registers when resetting vcpus.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <464adb39c8699fb8331d8ad6016fc3e2eff53dbc.1574625592.git.dirty@apple.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c |  8 ++++++++
 target/i386/hvf/vmx.h | 18 ++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 90fd50acfc..784e67d77e 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -441,12 +441,20 @@ static MemoryListener hvf_memory_listener = {
 };
 
 void hvf_reset_vcpu(CPUState *cpu) {
+    uint64_t pdpte[4] = {0, 0, 0, 0};
+    int i;
 
     /* TODO: this shouldn't be needed; there is already a call to
      * cpu_synchronize_all_post_reset in vl.c
      */
     wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS, 0);
     wvmcs(cpu->hvf_fd, VMCS_GUEST_IA32_EFER, 0);
+
+    /* Initialize PDPTE */
+    for (i = 0; i < 4; i++) {
+        wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
+    }
+
     macvm_set_cr0(cpu->hvf_fd, 0x60000010);
 
     wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 5dc52ecad6..eb8894cd58 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -121,6 +121,7 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
     uint64_t pdpte[4] = {0, 0, 0, 0};
     uint64_t efer = rvmcs(vcpu, VMCS_GUEST_IA32_EFER);
     uint64_t old_cr0 = rvmcs(vcpu, VMCS_GUEST_CR0);
+    uint64_t mask = CR0_PG | CR0_CD | CR0_NW | CR0_NE | CR0_ET;
 
     if ((cr0 & CR0_PG) && (rvmcs(vcpu, VMCS_GUEST_CR4) & CR4_PAE) &&
         !(efer & MSR_EFER_LME)) {
@@ -128,18 +129,15 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
                          rvmcs(vcpu, VMCS_GUEST_CR3) & ~0x1f,
                          MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)pdpte, 32, 0);
+        /* Only set PDPTE when appropriate. */
+        for (i = 0; i < 4; i++) {
+            wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
+        }
     }
 
-    for (i = 0; i < 4; i++) {
-        wvmcs(vcpu, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
-    }
-
-    wvmcs(vcpu, VMCS_CR0_MASK, CR0_CD | CR0_NE | CR0_PG);
+    wvmcs(vcpu, VMCS_CR0_MASK, mask);
     wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
 
-    cr0 &= ~CR0_CD;
-    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
-
     if (efer & MSR_EFER_LME) {
         if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
             enter_long_mode(vcpu, cr0, efer);
@@ -149,6 +147,10 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
         }
     }
 
+    /* Filter new CR0 after we are finished examining it above. */
+    cr0 = (cr0 & ~(mask & ~CR0_PG));
+    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
+
     hv_vcpu_invalidate_tlb(vcpu);
     hv_vcpu_flush(vcpu);
 }
-- 
2.21.0


