Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF07C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B902072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spLQRCt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B902072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhtp-0007s8-Ck
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jnhna-0000SU-4O
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:13:10 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jnhnY-00043E-Be
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:13:09 -0400
Received: by mail-pj1-x1043.google.com with SMTP id u8so1396344pje.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6zv4LKrUNZWMbaVi6BSvUFBtq8jf6g3exSrZ11NT8kw=;
 b=spLQRCt0Y4/TyOw3VLkZP9SKZhuN5SYJ13ICSq54UdiDmYlnYod1b3PpIPkxcsipMT
 Sv79N7i7/n5rrJjfRwNAPJyGpmmAmK5SMWrElsH1ak3EvrlNpvCsGH5rB3eym+ULLQKK
 x1orVh6nFzK/QOmqgYuAMFyvYCxAIXk/Iisz3q+nJtKPj39GZ9OIlRuMKAK3UFTCRxtl
 XBk5X8BB9QfTsWXPYRR/3RjuYx+VBVeb/l7Chm2wsY/EXxffoSPii18Bciv1pO6YBe1J
 kGQIP/Y3c6NPMLuyiYb1yi4iN4eegkh+GT3s6fSXvGEDC/t8V5MkBypYp+pd1vcDIQkU
 QVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6zv4LKrUNZWMbaVi6BSvUFBtq8jf6g3exSrZ11NT8kw=;
 b=JgwuDUk/RsUveUat4nNVObAdOZWaGMnFd3/qgE3OOhfQZlnKSamiQDNJ4e34y3XzET
 p9TFoF2mYL+R+FEkfNtt+vdsqSAu7n21MkWv8PH6RR5mKDnwcsn2lTtrN03U9BOCuAHp
 ivyu6qarBZEHlMJ4A2014Dy7/j270AU9zyWPTSDYqedQWtsOQiOqcUf1Kr41N1DpCig1
 XI37dsPbKMPJRTrfnaCyadsSyhztgRArI/8N3qufh8x14GYii+srJmkmHOTjA05zZwAr
 W1EOOrxzCk7rcWXMbokmfWt1CMz5TiCSUSdTRVDgKszfwAkNHGhAGD3/2KULFGof2/En
 UvvQ==
X-Gm-Message-State: AOAM5327nZ7omeHonmVE29ZOskLgBcIgSFQ9VyGn4Vej4b09K+uQDE3H
 rn0E2cziOebvRdvHPhlmp5M=
X-Google-Smtp-Source: ABdhPJxbM4TQhJZKtJ+VeCOaq0doWDkvpt8fHmUNzivtfQQr6J4qZ754QjKjzGfI8O1Fbjm9Q/dxzQ==
X-Received: by 2002:a17:90a:2843:: with SMTP id
 p3mr21629341pjf.187.1592914386911; 
 Tue, 23 Jun 2020 05:13:06 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id m18sm17022782pfo.173.2020.06.23.05.13.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jun 2020 05:13:06 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V5 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
Date: Tue, 23 Jun 2020 20:13:55 +0800
Message-Id: <1592914438-30317-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1043.google.com
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


