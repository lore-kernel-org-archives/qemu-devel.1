Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71298C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E85B2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 09:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AicGphKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E85B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWlX-0005y0-6l
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 04:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhD-0001y9-0N
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iZWhB-00036B-W6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:42 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:56089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iZWhB-00035t-Ph
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:59:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id b11so2235874wmb.5
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1aRvALnP398ABUJ0eW1IYZpL7dhiZ4eC2+LSX0yMJZQ=;
 b=AicGphKu2ROG9WcDbclcUt88U0z8njY4tKz7vZTbWp0+2U3aW1idnPK2FdKekqdATA
 dS/aRrqLBy+CuhXSot16NHj9EAH2BhM+ZGVamkID0fkCuBuvSfOggS3jYIcp/Vj5yKxv
 L/0sTZv81iSSQ9wyaLGYx5EgA38LBGY+jB/DyfmM6ZsR4NJqRFFIDK/L9FP7S4Qjx5RT
 8w50i1E4BvOQ6Gt5fFgg43mBSX94X6AT1SzI6v2KQy93Dx8JBZSqU0iAVw+LIXTsyUWI
 hyck4ennSbZNgzhxhDRljbpwMZ/77fC0k1mkQHdAMv4M7Cnpa6OkYbeR25KgAu25oxIR
 L0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1aRvALnP398ABUJ0eW1IYZpL7dhiZ4eC2+LSX0yMJZQ=;
 b=Lzwci0CN8p0O2yAJYi5N0q4bNx0H8sdUgiDRygasiEgWQbzp8EsNwqSNBRaxorrQV0
 QGBBDHOx+e5GKGeX9lVW9QyZJ2DrchZPXTLLnlud4stUE+8rHmyAdLAKNC/CVchvh9mV
 OyhNUkdKmGNJlFrQAD0hzJHoE85QPdmAGQ8QS+YLqIMVMmq2X00FZKCxYZ6L4UMJ2vf4
 yRK/Sj7I7Ek+k9P0+fZNmP0Xn7LTcXFLORce5/P++x1oPmCNYdGLBuNdC2rClDeEXc4T
 UFYbp/w5gw1ESyCgIXiM+uADw/I4pBn7y5P5+x6mzq5N7bEsbnBS5vL2YdKzJ4yA/lNd
 dQyw==
X-Gm-Message-State: APjAAAVFe0GKZvw4lVV8i914/2hFnhCyPG2XwNlpPG4YrKHIGCpjTyj+
 vYArCmbUQqeuUDQ+HLyVzfwiZXPI
X-Google-Smtp-Source: APXvYqywPdeM6xF72r7EfA6KXx6SwMmiMLJfImeX5uTHG56XfJJXYLHgdjf94SagETfhlbzv/vZyMg==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr3204942wma.130.1574758780461; 
 Tue, 26 Nov 2019 00:59:40 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id a206sm2349172wmf.15.2019.11.26.00.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 00:59:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] hvf: remove TSC synchronization code because it isn't
 fully complete
Date: Tue, 26 Nov 2019 09:59:34 +0100
Message-Id: <20191126085936.1689-4-pbonzini@redhat.com>
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

The existing code in QEMU's HVF support to attempt to synchronize TSC
across multiple cores is not sufficient.  TSC value on other cores
can go backwards.  Until implementation is fixed, remove calls to
hv_vm_sync_tsc().  Pass through TSC to guest OS.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-Id: <44c4afd2301b8bf99682b229b0796d84edd6d66f.1574625592.git.dirty@apple.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c     | 3 +--
 target/i386/hvf/x86_emu.c | 3 ---
 target/i386/hvf/x86hvf.c  | 4 ----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 0b50cfcbc6..90fd50acfc 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -518,7 +518,6 @@ void hvf_reset_vcpu(CPUState *cpu) {
         wreg(cpu->hvf_fd, HV_X86_R8 + i, 0x0);
     }
 
-    hv_vm_sync_tsc(0);
     hv_vcpu_invalidate_tlb(cpu->hvf_fd);
     hv_vcpu_flush(cpu->hvf_fd);
 }
@@ -612,7 +611,7 @@ int hvf_init_vcpu(CPUState *cpu)
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_GSBASE, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_KERNELGSBASE, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_TSC_AUX, 1);
-    /*hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_TSC, 1);*/
+    hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_TSC, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_CS, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_EIP, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_IA32_SYSENTER_ESP, 1);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 1b04bd7e94..3df767209d 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -772,9 +772,6 @@ void simulate_wrmsr(struct CPUState *cpu)
 
     switch (msr) {
     case MSR_IA32_TSC:
-        /* if (!osx_is_sierra())
-             wvmcs(cpu->hvf_fd, VMCS_TSC_OFFSET, data - rdtscp());
-        hv_vm_sync_tsc(data);*/
         break;
     case MSR_IA32_APICBASE:
         cpu_set_apic_base(X86_CPU(cpu)->apic_state, data);
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index e0ea02d631..1485b95776 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -152,10 +152,6 @@ void hvf_put_msrs(CPUState *cpu_state)
 
     hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_GSBASE, env->segs[R_GS].base);
     hv_vcpu_write_msr(cpu_state->hvf_fd, MSR_FSBASE, env->segs[R_FS].base);
-
-    /* if (!osx_is_sierra())
-         wvmcs(cpu_state->hvf_fd, VMCS_TSC_OFFSET, env->tsc - rdtscp());*/
-    hv_vm_sync_tsc(env->tsc);
 }
 
 
-- 
2.21.0



