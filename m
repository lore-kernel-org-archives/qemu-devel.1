Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D5320644
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyKehYlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D5320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2tz-00010n-Gq
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jo2t6-000087-B4
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:44:16 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jo2t4-0007FC-OW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:44:16 -0400
Received: by mail-pl1-x644.google.com with SMTP id x8so12064plm.10
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6zv4LKrUNZWMbaVi6BSvUFBtq8jf6g3exSrZ11NT8kw=;
 b=lyKehYlC3nPymjcC/Esz1X+YtU7MT/JufUjitssMiVduviY8jZbfDI+sRx6gtJ7KSX
 yrDditTiuWrOYvUzcBs4Gb7XtTnSvE01HsmmoGrqLbmijQJ2a8wGrmpNbZQS0bS/F7Sg
 hRk7u1dBAK8CqbbHy4zC7dCjmtvaPCijtgLoauCOV/rVrk7Ev/aIvNLiKPkEgJCRfHwu
 p63Hf8KXx3GnSsrVlfbhNQfkw7MCd6Gil3tfU4AgY0CLICAwZg0+4z/74/3gIDOUUue8
 +QkBpRRMo2b4GagY8Jf65W+7/cKAAXeE1U+2FPX2Ixwzf1Pizt454lAMtL7gzyPQpjBI
 sR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6zv4LKrUNZWMbaVi6BSvUFBtq8jf6g3exSrZ11NT8kw=;
 b=N7JwE3KyF4ftqAjD+22s9phJGFPwqELcj0+TRyEn+kBxClciSv2/t27aG7k3RlHyEd
 I9aWPdq4hQU6ggXeTv51Jmt3Vy/eERYQdoiFN+lxCEOMmbLRj8EBdkEKyagTlh0ZztHx
 i3S1XFl1dam1nr1da9yPXn5ho1KObbtNtn7r2qFlWmxnn2ABDb+U2AXd0LUbG+2P2ax0
 9OhFcDSJpC0UoX8tEwvFySrrfzwDnqDU5A+K0Q5k9nUrGzKYgkAQB96Ro40p34dWJ7iD
 syxokkE7KAvIEK9/7Kf3TS9IROg9PyPI8eHH1GdX3lkdccHPNajE2zpy812Mkhht1UOr
 CZ3g==
X-Gm-Message-State: AOAM532/gzM/Xe0XgDnvd56AdeWtWcqx11KH/f0Y7YjcC5lbzCDNAVr6
 YUp25E9yEgDuLUCGgEL+wJc=
X-Google-Smtp-Source: ABdhPJyJHkKpPekpV9mYL1k+ulMTYvopXSV+KbczZ4AcluCRmfjWWCE8BPr/oR/6o+jSAGtPVj818w==
X-Received: by 2002:a17:90a:950e:: with SMTP id
 t14mr25492150pjo.99.1592995453438; 
 Wed, 24 Jun 2020 03:44:13 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id q6sm19772395pff.163.2020.06.24.03.44.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jun 2020 03:44:12 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V6 1/4] hw/mips: Implement the kvm_type() hook in MachineClass
Date: Wed, 24 Jun 2020 18:45:28 +0800
Message-Id: <1592995531-32600-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
References: <1592995531-32600-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
MachineClass. This patch add the the kvm_type() hook to support both of
the two types.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/kvm.c      | 20 ++++++++++++++++++++
 target/mips/kvm_mips.h | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 96cfa10..373f582 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -21,10 +21,12 @@
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 #include "sysemu/kvm.h"
+#include "sysemu/kvm_int.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cpus.h"
 #include "kvm_mips.h"
 #include "exec/memattrs.h"
+#include "hw/boards.h"
 
 #define DEBUG_KVM 0
 
@@ -1270,3 +1272,21 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     abort();
 }
+
+int mips_kvm_type(MachineState *machine, const char *vm_type)
+{
+    int r;
+    KVMState *s = KVM_STATE(machine->accelerator);
+
+    r = kvm_check_extension(s, KVM_CAP_MIPS_VZ);
+    if (r > 0) {
+        return KVM_VM_MIPS_VZ;
+    }
+
+    r = kvm_check_extension(s, KVM_CAP_MIPS_TE);
+    if (r > 0) {
+        return KVM_VM_MIPS_TE;
+    }
+
+    return -1;
+}
diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
index 1e40147..171d53d 100644
--- a/target/mips/kvm_mips.h
+++ b/target/mips/kvm_mips.h
@@ -12,6 +12,8 @@
 #ifndef KVM_MIPS_H
 #define KVM_MIPS_H
 
+#include "cpu.h"
+
 /**
  * kvm_mips_reset_vcpu:
  * @cpu: MIPSCPU
@@ -23,4 +25,13 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu);
 int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level);
 int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level);
 
+#ifdef CONFIG_KVM
+int mips_kvm_type(MachineState *machine, const char *vm_type);
+#else
+static inline int mips_kvm_type(MachineState *machine, const char *vm_type)
+{
+    return 0;
+}
+#endif
+
 #endif /* KVM_MIPS_H */
-- 
2.7.0


