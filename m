Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E60CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134532068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFvg5uhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134532068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfwps-0005l7-3C
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 22:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwp4-0004q0-9R
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:38:40 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwp3-0005Ms-BC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:38:37 -0400
Received: by mail-pl1-x643.google.com with SMTP id y11so712272plt.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 19:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OK/DTB71BDOFzUlV1g9OxdUAuN7LmiZPAncyEdpJig8=;
 b=rFvg5uhk7b7AoAXbSJ33+Sk8HSHqN9/3UuNd5Xzd50dEwW6p0z7tiyPun7TBK0OH+V
 rN+SJ6MIDVptx9sG2qBFB/CCCcaH7c3oZ6yLP3r3Vq4SSBXw0EA9vE+nPPrLULAY4UDJ
 UJqPtzVrAsaXEl+vhUD3Uqtb9ocrflQ8uReT3phb/XZWJ0ETl0LvLDYGLYzyL6Ec2eT/
 4aEsCweMJt0g14zeGmFiKcXHyGS0nwdTvel/o9hd8OlVRgeDHttfCyOH83/b3qoxla0b
 CnvBH3lQeWNdZ2qsT8Y2zZEvOpa3K0xCjEZK/iQ2idLy4BNG6f3lu2+rAfHtR6wbALA8
 JNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OK/DTB71BDOFzUlV1g9OxdUAuN7LmiZPAncyEdpJig8=;
 b=cpWnHt5z4n/yFPCX5kj163yZ08eOroP1vJ8oUzLiKIxF0foEFJ6yGPw78UVkfkOOiW
 vNNoKO0i7VnK/bwiCw18G1C98nElcQUyrlPcMiHJLRKFBmqefiycNqMs+WCHCIA32i5D
 owfJYHcnPPJMFEKvwBofivxLIXahGVEPcrJHsGSwODLNAINGCUwrxEV3+4MlcFlpIYnI
 j4VqM80XIC3aXPuagXB5fKG9f8+BeLAVvUqjmScbIWtnvg//QNm5oWjzfx+emWTdrZOg
 mbj91lJugzpt+Oe10FrVdAxXfC96eUelYxwfq63Nn9wi8eJEQrvKLOHo/Z4i9c4PQyXW
 fJKQ==
X-Gm-Message-State: AOAM533YFjPASJgMCYIsvOT+T2LvkCqVSXtSE2v7SDUX7iFi+bWBObpv
 n8WUtE4h4rLsLofglApz97Y=
X-Google-Smtp-Source: ABdhPJxQyIXhCmXDNRIto+ZAvJehoiL4IR6mUqzq5P623uRpfNB3fZ6j0GpHbzDplxNyawQHgRGPNQ==
X-Received: by 2002:a17:90a:3261:: with SMTP id
 k88mr2813656pjb.0.1591065515874; 
 Mon, 01 Jun 2020 19:38:35 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id j186sm630761pfb.220.2020.06.01.19.38.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 19:38:35 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V4 1/4] hw/mips: Implement the kvm_type() hook in
 MachineClass
Date: Tue,  2 Jun 2020 10:39:14 +0800
Message-Id: <1591065557-9174-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
MachineClass. Besides, libvirt uses a null-machine to detect the kvm
capability, so by default it will return "KVM not supported" on a VZ
platform. Thus, null-machine also need the kvm_type() hook.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/core/Makefile.objs  |  2 +-
 hw/core/null-machine.c |  4 ++++
 hw/mips/Makefile.objs  |  2 +-
 hw/mips/common.c       | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/mips/mips.h |  3 +++
 5 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 hw/mips/common.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 1d540ed..b5672f4 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -17,11 +17,11 @@ common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
-common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
 common-obj-$(CONFIG_SOFTMMU) += numa.o
 common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
+obj-$(CONFIG_SOFTMMU) += null-machine.o
 obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index cb47d9d..94a36f9 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,6 +17,7 @@
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/mips/mips.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -50,6 +51,9 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->max_cpus = 1;
     mc->default_ram_size = 0;
     mc->default_ram_id = "ram";
+#ifdef TARGET_MIPS
+    mc->kvm_type = mips_kvm_type;
+#endif
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 739e2b7..3b3e6ea 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += addr.o mips_int.o
+obj-y += addr.o common.o mips_int.o
 obj-$(CONFIG_R4K) += r4k.o
 obj-$(CONFIG_MALTA) += gt64xxx_pci.o malta.o
 obj-$(CONFIG_MIPSSIM) += mipssim.o
diff --git a/hw/mips/common.c b/hw/mips/common.c
new file mode 100644
index 0000000..4d8e141
--- /dev/null
+++ b/hw/mips/common.c
@@ -0,0 +1,42 @@
+/*
+ * Common MIPS routines
+ *
+ * Copyright (c) 2020 Huacai Chen (chenhc@lemote.com)
+ * This code is licensed under the GNU GPL v2.
+ */
+
+#include <linux/kvm.h>
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/boards.h"
+#include "hw/mips/mips.h"
+#include "sysemu/kvm_int.h"
+
+#ifndef CONFIG_KVM
+
+int mips_kvm_type(MachineState *machine, const char *vm_type)
+{
+    return 0;
+}
+
+#else
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
+
+#endif
diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
index 0af4c3d..2ac0580 100644
--- a/include/hw/mips/mips.h
+++ b/include/hw/mips/mips.h
@@ -20,4 +20,7 @@ void rc4030_dma_write(void *dma, uint8_t *buf, int len);
 
 DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr);
 
+/* common.c */
+int mips_kvm_type(MachineState *machine, const char *vm_type);
+
 #endif
-- 
2.7.0


