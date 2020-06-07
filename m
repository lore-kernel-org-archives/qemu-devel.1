Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC5C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D786F20760
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXYq7VgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D786F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1Q1-0000TF-3C
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fn-00040c-Eu
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fi-0004nS-0p
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id j198so12848001wmj.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aUlCJw+6El2mvALXgA8SUmaXD8jt5vbb1e1YOwjFRjY=;
 b=vXYq7VgWIFrJovJ8nqEE7sdJRuYalGDnkVYWGYqg4XC27sQ8buxbLm1bDCPIp2yO2c
 oNezLHDq3DniFapaTW0BLyLLD9v4qu5KzVRk1/Vrxb0BuI/jbGE7GLLM6Ew76L5sBLfL
 O2qPC/6DAAAsLOwOgoCT/6/2sJREb4kbOqRC83ek/Pg8VCTgqOPg+ISxkYMff94WIobd
 3TC4Wf6Iy1XzcV7UgBp+IeYVYyDUeHgBRgnQJW/uT3JOZX1wtuDZ2Gjyrw2bFURm3lf0
 n+hM1QuXWwPUbpvceg4lahgtKeHH/jukyNenMhKqUHb4ilU4vI9qtBzcZWM+sdmrH9xY
 PfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aUlCJw+6El2mvALXgA8SUmaXD8jt5vbb1e1YOwjFRjY=;
 b=dlkkkVPA+ozy7DJtkdtsov6FRxFBRDsl5hklrl1A0YImOeNowTjgUKRUXrU4R6lOdQ
 DyS9pPDVXaBb0GUHMchcwpGtx1+PqW+1I5ThnEBSnGPcbj95DUJ0MxwZOXxUszOC7yt0
 BBcqNlhL8RmJ6kF17fM3S1w2YzpFf0RynHmq7oMnoEnRoURr1MGHLUOQ9wee5A9Cbbxe
 ybIhXPbe5/4iFkGhf2Z3ypqg5063119nneng8/8+63VectPM1ruuS2XGNRNwFjP/qIG7
 m9h6YxGsoN2vl85ZLPNg6kqHl1uSTdimk1U5OTQleBab504/9/K8sx3w5TR6IhJY10co
 8zQQ==
X-Gm-Message-State: AOAM533YWk4KWv43OJKCNQSYe+2Ejwja56j6/dsj7P9WowfqsrYDW5QL
 HdDv6U2+EiWh4TurUkDgJWgO2YVP
X-Google-Smtp-Source: ABdhPJy9ilUzZ5q8aklpYLCh/PCHR/4F7v1ibUtNkyoCC5bwdbvpo3G+uce92JFtMoOMIkqO4aPMjA==
X-Received: by 2002:a7b:cd94:: with SMTP id y20mr12678901wmj.87.1591559200039; 
 Sun, 07 Jun 2020 12:46:40 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:39 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 19/21] hw/mips: Implement the kvm_type() hook in MachineClass
Date: Sun,  7 Jun 2020 21:46:23 +0200
Message-Id: <1591559185-31287-20-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x331.google.com
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

MIPS has two types of KVM: TE & VZ, and TE is the default type. Now we
can't create a VZ guest in QEMU because it lacks the kvm_type() hook in
MachineClass. Besides, libvirt uses a null-machine to detect the kvm
capability, so by default it will return "KVM not supported" on a VZ
platform. Thus, null-machine also need the kvm_type() hook.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1591065557-9174-2-git-send-email-chenhc@lemote.com>
---
 include/hw/mips/mips.h |  3 +++
 hw/core/null-machine.c |  4 ++++
 hw/mips/common.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/core/Makefile.objs  |  2 +-
 hw/mips/Makefile.objs  |  2 +-
 5 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 hw/mips/common.c

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
diff --git a/hw/mips/common.c b/hw/mips/common.c
new file mode 100644
index 0000000..fd7e10a
--- /dev/null
+++ b/hw/mips/common.c
@@ -0,0 +1,55 @@
+/*
+ *  Common MIPS routines
+ *
+ *  Copyright (C) 2020  Huacai Chen <chenhc@lemote.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
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
-- 
2.7.4


