Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C3C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC60220873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grpkV6ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC60220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47427 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7A8-0002AV-6c
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:33:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6tk-0003cU-PN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0008OG-9j
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6tg-000805-Vm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id w15so1392460wmc.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Fq+y9Y8taPmtsyd8oOc7f9ZWDD3UWEkWOvqVLG/Lt40=;
	b=grpkV6nsRirFoFebYjC6MxNOtEAlrmjk4xmZdRENo8+NFdj8E4YmUbEy6w8x5uWIiB
	fVeL1722iLSrmD/gRUaJ5BijubBeonzVXGiFZ615e8QWTxuyLCgFhaoY1xR8BwdFGJvB
	tUOo5pFcTXd5grPFqmLkpM3kK1fHcJIxRvFt77VgPYN8ecwBrmH4k09VmX2jCI/6MjXh
	g2zjnN3HMcFroQGQoZy316iUxDJdzfU1OMPxTrYWByWK5DqVh1UYR+/BzD0+hDX0+i6S
	G5a7/FMKtcnmMGUURDoKSJAiQwAByr4wHgmlKnlDWmfRkQGWK64RqVs9PCheLVUNQoRJ
	9ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Fq+y9Y8taPmtsyd8oOc7f9ZWDD3UWEkWOvqVLG/Lt40=;
	b=TwEisCo3gIihh+PT0UpkoPcLBgMzy8xGc+MeSp7NvetJ/EV1jcJC1/4q76TxbnZykG
	dQU6TWmAt6V6h/k1bIlcaRiikYYtHf9Mp7axiMY6DJMwSF6aWeqBjkWg99P6aVtYFmWE
	G3KKPVW3aMObeo3+AyLhxSM2wH1J3BY5x+8cooAq5L/R107am7r9tnnoJ6ZciyFdGZ2T
	Lqwl7hcklAjKEsu5RBWw+2Vp18cnBcy24ZPwxpCBOOVYN8TDi14iKFFdDrxWpZr2B4RB
	akmQERONzcMIGxSJRwWZkPjn7FFgp/XqO2pIJSaP+yqXovgM2qN/9XqdbPU0cMUB3He/
	HRsQ==
X-Gm-Message-State: APjAAAXdtYfWPpOcU05KsnDq4lL2HEEWllupkytt19jxPAZnLZSlpZVf
	ICy12wukU5Q/iQR3m6F864pYDk83
X-Google-Smtp-Source: APXvYqxai+JM1yRaeKDe8Ko1NKXeAr/fb9HVj9Du0pq7EoYCTb3hrMeRJqOs2kgT5p7pp/5UpJw9gg==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr1308089wme.148.1556785006192; 
	Thu, 02 May 2019 01:16:46 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id
	d16sm44698367wra.54.2019.05.02.01.16.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 01:16:45 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 11:15:52 +0300
Message-Id: <20190502081554.5521-26-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v9 25/27] kvm: Add API to read/write a CPU MSR
 value
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502081552.2buO7tRqnWsD_0o19rNghT-ySp1qTCH9McxnZSSGYzs@z>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 accel/kvm/kvm-all.c  | 39 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/kvm.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 524c4ddfbd..35207d910b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2444,6 +2444,45 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
 }
 #endif /* !KVM_CAP_SET_GUEST_DEBUG */
 
+int kvm_arch_read_msr(CPUState *cpu, uint32_t index, uint64_t *value)
+{
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data;
+    int ret;
+
+    msr_data.info.nmsrs = 1;
+    msr_data.entries[0].index = index;
+    ret = kvm_vcpu_ioctl(cpu, KVM_GET_MSRS, &msr_data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    *value = msr_data.entries[0].data;
+    return 0;
+}
+
+int kvm_arch_write_msr(CPUState *cpu, uint32_t index, uint64_t value)
+{
+    struct {
+        struct kvm_msrs info;
+        struct kvm_msr_entry entries[1];
+    } msr_data;
+    int ret;
+
+    msr_data.info.nmsrs = 1;
+    msr_data.entries[0].index = index;
+    msr_data.entries[0].reserved = 0;
+    msr_data.entries[0].data = value;
+    ret = kvm_vcpu_ioctl(cpu, KVM_SET_MSRS, &msr_data);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
     KVMState *s = kvm_state;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd190f..409b1a5444 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -462,6 +462,8 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
 uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
+int kvm_arch_read_msr(CPUState *cpu, uint32_t index, uint64_t *value);
+int kvm_arch_write_msr(CPUState *cpu, uint32_t index, uint64_t value);
 
 
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
-- 
2.20.1


