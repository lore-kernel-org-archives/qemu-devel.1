Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF3C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78AC206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrqErS8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78AC206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0AY-0008Vw-RD
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT09X-000788-6x
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jT09V-0005Io-UY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:34:14 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jT09V-0005IB-Gv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:34:13 -0400
Received: by mail-pj1-x1044.google.com with SMTP id h12so4540065pjz.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PP5ZBO5V+/qsHiEs8q8QJMOieeCuo90ei1MsjiyJ2Hg=;
 b=qrqErS8ope1FTFgHEKEVKUE0jBupf1FEh3VtPHDSAf4YjeJGbgfWu31SEMtDz/bU3m
 3HtJl5y3CTG4WPwVsmGESP2LinxpDn3wndd/y32Av7C1jCcjrmcATGfWvghalpdh9Q0s
 Y+wEyBqOgXNu0lt1Lk+ccSSY6003f8WwkYuXRjrl7BHI0hx9EHSnHuNeFiraWbcymogR
 DMkvLs2AA/ZR0xVx/fX25TDcicpOtbN6sgty4mNo+ixBp6HVBz7Cp0KFYJ2I8longzJh
 Tn7pJ8fw/IGnP7TUai2ApsmSmz1vuvcy9x9XcYbE/lfLY0q1clM16CKAQ1k5ZaHn4tHv
 ySlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PP5ZBO5V+/qsHiEs8q8QJMOieeCuo90ei1MsjiyJ2Hg=;
 b=rfDcZcczXAbnQjpyvXNX8tehCZeeCmkxqPErQrTCIEuTZTr2AAJSBi/rmPaS0svgPI
 OCi7otOLdFjK326J+sxO9XP/1p4ERGbyuPi3vnCHoFHzR27Y4D8eZWJ0KIfHMidiSU7e
 K7u5EA2HEtomcgm/Wo+P10jAAZ/rhpJ4MMRaSLvDcN3jXdwwtpltMP2UZnjokwex6FNs
 bvjTU4dH3kWRSPqjIK5rnfURjB14nacpWWOdo+cn1xNmkzih+skpKN7MCYPlI5RR92uB
 Hb2uEm5i9lT+vVmhAfV1PZYCizSlWt+30SA5V3aweK19fiwsMgj+E5JYHGfg44EHMxWP
 eSbA==
X-Gm-Message-State: AGi0PubQHM+CurpxPOyQcZCQstslKP3OeWYACpnLICi2ZN2o3wm5eJO7
 Qs7NGJ//lsXUNaKqM4azLog=
X-Google-Smtp-Source: APiQypJUV57c6Ela9g+KOPTmKGsCcWtchi/kfQ1GGT/xDJlcqafH3AoQcZe115Nzy0tys5C8rmo5Lg==
X-Received: by 2002:a17:902:8643:: with SMTP id
 y3mr22053373plt.149.1587980052286; 
 Mon, 27 Apr 2020 02:34:12 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u9sm11333073pfn.197.2020.04.27.02.34.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 02:34:11 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 2/7] hw/mips: Implement the kvm_type() hook in
 MachineClass
Date: Mon, 27 Apr 2020 17:33:10 +0800
Message-Id: <1587979995-17717-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
MachineClass. Besides, libvirt uses a null-machine to detect the kvm
capability, so by default it will return "KVM not supported" on a VZ
platform. Thus, null-machine also need the kvm_type() hook.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/core/Makefile.objs  |  2 +-
 hw/core/null-machine.c |  4 ++++
 hw/mips/Makefile.objs  |  2 +-
 hw/mips/common.c       | 29 +++++++++++++++++++++++++++++
 include/hw/mips/mips.h |  3 +++
 5 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 hw/mips/common.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 6215e7c..7cfef1f 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -16,10 +16,10 @@ common-obj-$(CONFIG_SOFTMMU) += vm-change-state-handler.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
 common-obj-$(CONFIG_SOFTMMU) += machine.o
-common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
 common-obj-$(CONFIG_SOFTMMU) += numa.o
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
index 525809a..2f7795b 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += addr.o mips_int.o
+obj-y += addr.o common.o mips_int.o
 obj-$(CONFIG_R4K) += mips_r4k.o
 obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
 obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
diff --git a/hw/mips/common.c b/hw/mips/common.c
new file mode 100644
index 0000000..eb0c649
--- /dev/null
+++ b/hw/mips/common.c
@@ -0,0 +1,29 @@
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
+int mips_kvm_type(MachineState *machine, const char *vm_type)
+{
+    int r;
+    KVMState *s = KVM_STATE(machine->accelerator);;
+
+    r = kvm_check_extension(s, KVM_CAP_MIPS_VZ);
+    if (r > 0)
+        return KVM_VM_MIPS_VZ;
+
+    r = kvm_check_extension(s, KVM_CAP_MIPS_TE);
+    if (r > 0)
+        return KVM_VM_MIPS_TE;
+
+    return -1;
+}
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


