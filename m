Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397C6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033FB23A78
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkA+N4Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033FB23A78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y2t-0004ty-AC
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6xyx-00073Y-4V; Sat, 15 Aug 2020 11:20:31 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34]:45369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6xyv-0002J4-1t; Sat, 15 Aug 2020 11:20:30 -0400
Received: by mail-vk1-xa34.google.com with SMTP id j7so2623207vkk.12;
 Sat, 15 Aug 2020 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5njM7C5XfgSvx6bHiN8HLMYG6CwV6Nqjs2xvulr+tFs=;
 b=VkA+N4Z/Fxp7Lx/xgWyhoWW13NfzVmozeg/LNc59BraQWLHIukeJVFYdeuzUwGsj8F
 rJ2vPrtcUrmdp22i01ZuTv3mmiibWs7dRBPZMI1iQRKYjIpS4ivwoaGtiTAVGv74HSbq
 R3FcLt6jKp7Nl3iWvtkfpYJjfWMA5kMmgZ98iOHWHnuk1V97ecZvQPJHKeYzUtiyHQia
 IzlXkTntFde4B83eMf8GW1IDJ9c8cjl5KiWw0dgjuV/sxYtbV6rLqFG+C9AubbyuR+Rx
 dwKFQoLiFXe4OKssgTNMbm74iP98Ky/Xc7cCF3OYPdfCkcJ1bQI8KypIDawgob9o6eoL
 Tmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5njM7C5XfgSvx6bHiN8HLMYG6CwV6Nqjs2xvulr+tFs=;
 b=Y2ayOxPMmdHP98sf7T1uuOm+26YzHelT8EeLde7vOT//KHQJcm8kv2akDS/tt0c6Kc
 Ko5KbcdDshKMIJK2ViqaJxbeLx9RLoCeNTL+BsI6KOBww4ZFWGTkJfLFcxiahRaGledW
 t0KOQ3xarj7lU5zaeHcTQi/8/GSU+utXlxrwz25nQX1wCrTnimjo2eIAiV5d/lVuVSUm
 /EStq4Eke4RwvThxtb4ENwBQotN0D/idNi7OfICAm9S+7070JCy5mKsVaR40wgMfaBUl
 TExHLSK2xg/aSBx2ZT1HX+AUmO+UWS/rSF+pQDQzG9eN2PYOM9OnK7cnZ5VoyNe3jdpG
 /0uQ==
X-Gm-Message-State: AOAM532a/35GIfHbuirQ0TkHm19nsiaFpMFFX58y2kS0y7jtQMH69AUY
 N07kPmgXbUwimLnqWlD1vptwBjbL3HfgBQ==
X-Google-Smtp-Source: ABdhPJw13N5RVWW9bEP5Qlw1OTijdx49xyhHpHdZDnrr7rJZM56ho0DmcyT/SKwFDsNYucHkQP2vEw==
X-Received: by 2002:ad4:438e:: with SMTP id s14mr4340185qvr.18.1597438479050; 
 Fri, 14 Aug 2020 13:54:39 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:38 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] hw: add compat machines for 5.2
Date: Fri, 14 Aug 2020 17:54:15 -0300
Message-Id: <20200814205424.543857-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=danielhb413@gmail.com; helo=mail-vk1-xa34.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

Add 5.2 machine types for arm/i440fx/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 9 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ecfee362a1..acf9bfbece 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2546,10 +2546,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_5_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
+
 static void virt_machine_5_1_options(MachineClass *mc)
 {
+    virt_machine_5_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
+DEFINE_VIRT_MACHINE(5, 1)
 
 static void virt_machine_5_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8d1a90c6cf..cf5f2dfaeb 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,6 +28,9 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
 
+GlobalProperty hw_compat_5_1[] = {};
+const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
+
 GlobalProperty hw_compat_5_0[] = {
     { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
     { "virtio-balloon-device", "page-poison", "false" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 47c5ca3e34..9aa813949c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,6 +97,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
+GlobalProperty pc_compat_5_1[] = {};
+const size_t pc_compat_5_1_len = G_N_ELEMENTS(pc_compat_5_1);
+
 GlobalProperty pc_compat_5_0[] = {
 };
 const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b789e83f9a..c5ba70ca17 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,7 +426,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
-static void pc_i440fx_5_1_machine_options(MachineClass *m)
+static void pc_i440fx_5_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -435,6 +435,18 @@ static void pc_i440fx_5_1_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
+                      pc_i440fx_5_2_machine_options);
+
+static void pc_i440fx_5_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_5_2_machine_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+    compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
+}
+
 DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
                       pc_i440fx_5_1_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a3e607a544..0cb9c18cd4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -353,7 +353,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_5_1_machine_options(MachineClass *m)
+static void pc_q35_5_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -361,6 +361,17 @@ static void pc_q35_5_1_machine_options(MachineClass *m)
     pcmc->default_cpu_version = 1;
 }
 
+DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
+                   pc_q35_5_2_machine_options);
+
+static void pc_q35_5_1_machine_options(MachineClass *m)
+{
+    pc_q35_5_2_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
+}
+
 DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
                    pc_q35_5_1_machine_options);
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a5bb0736e2..dd2fa4826b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4581,15 +4581,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-5.2
+ */
+static void spapr_machine_5_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
+
 /*
  * pseries-5.1
  */
 static void spapr_machine_5_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_5_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(5_1, "5.1", true);
+DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
 
 /*
  * pseries-5.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e72c61d2ea..f4ea6a9545 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -801,14 +801,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_5_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_5_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(5_2, "5.2", true);
+
 static void ccw_machine_5_1_instance_options(MachineState *machine)
 {
+    ccw_machine_5_2_instance_options(machine);
 }
 
 static void ccw_machine_5_1_class_options(MachineClass *mc)
 {
+    ccw_machine_5_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
-DEFINE_CCW_MACHINE(5_1, "5.1", true);
+DEFINE_CCW_MACHINE(5_1, "5.1", false);
 
 static void ccw_machine_5_0_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 426ce5f625..bc5b82ad20 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -319,6 +319,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_5_1[];
+extern const size_t hw_compat_5_1_len;
+
 extern GlobalProperty hw_compat_5_0[];
 extern const size_t hw_compat_5_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 3d7ed3a55e..fe52e165b2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -193,6 +193,9 @@ void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
 
+extern GlobalProperty pc_compat_5_1[];
+extern const size_t pc_compat_5_1_len;
+
 extern GlobalProperty pc_compat_5_0[];
 extern const size_t pc_compat_5_0_len;
 
-- 
2.26.2


