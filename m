Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E163AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3D922363
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCf3KC0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3D922363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Hs-00032p-E7
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63t-0001y2-88
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63r-00068B-U8
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:05 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:56265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63r-00067d-NS
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:03 -0500
Received: by mail-wm1-x335.google.com with SMTP id b11so3787858wmb.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=x/7dL5GKaLKKTQGfreBczzCpIjJHYavx06Q35HIG390=;
 b=TCf3KC0qFWAh0xKFRO1aICnowVi48ggU3kqnGK086BL9n8CxtURNgl33MjgnWfcCfS
 11IdGh/KNEzM1Ex2dcIEaJxlbMcgq94DL6fRsI93VYBQp29SsVCqKm/RIYmqi65CwYcF
 Pkre4xgIisl53+qcgLCjnsKunoVtr4lRYIq3wShUGaGdacc10ZwgNZHS2ZkHhIDGtEup
 2VomiIS4/sOdDXppw4TkVFZdKp6ZvHTSb9kEkWSuYafZFJ/yZqEBY44QWSyUY8s1Qxir
 LT0lPQVB/prsSzp2wC9ov+lx55hLmBP2BNBBp0KDcCcVzMRNcZ1Fjx85Zc6kdTMwqZ4G
 quGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=x/7dL5GKaLKKTQGfreBczzCpIjJHYavx06Q35HIG390=;
 b=OuezyzA277/kjf9YGpCu01E5rCblh0KeJra6v4jrPliu33UQBNaAs2o5AeAnytMid6
 4kmPhVGolzcF7ipLJI0PJn3qDvTO8rIqhBxeiZrqQnc03FKfsxksXm23zpIgP4B7364n
 oSO378pcQ8tDE8oISMAxZY4nCurGvtMt9ON/tuzUmimeo6gDi8ZuA/f6B/AEx/8Zshe6
 s2sXLhbrXQEfv1PVbNpyVcdXrE6duhaJYemuYC7biXyfuJ1H0tReIVNDpn95d53bdMGb
 S+mt3RqWed2xtUkd6/B7FP4MohUr+Ag2Noun7BN1x/7q3jnmSn2gaxDbp6DAm/1YH7rO
 o8gQ==
X-Gm-Message-State: APjAAAUUWFT1cZzA5g5Jsv0vY2xBdFB7TQbgA0z3fiJCzECmjG8Brqus
 Ocm2dTWTIcpHwUo4lerQwXuzpPxa
X-Google-Smtp-Source: APXvYqwQehVMicSYylTIpO1o1FBNKYcTaIYZYtkjBXfK9aqFrSoKcoEKuYZrZ6X04o21HnedQw/1Sg==
X-Received: by 2002:a1c:1b86:: with SMTP id b128mr4551301wmb.127.1574179742270; 
 Tue, 19 Nov 2019 08:09:02 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.09.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:09:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] hw/i386: Move save_tsc_khz from PCMachineClass to
 X86MachineClass
Date: Tue, 19 Nov 2019 17:08:45 +0100
Message-Id: <1574179728-35535-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liam Merwick <liam.merwick@oracle.com>

Attempting to migrate a VM using the microvm machine class results in the source
QEMU aborting with the following message/backtrace:

target/i386/machine.c:955:tsc_khz_needed: Object 0x555556608fa0 is not an
instance of type generic-pc-machine

abort()
object_class_dynamic_cast_assert()
vmstate_save_state_v()
vmstate_save_state()
vmstate_save()
qemu_savevm_state_complete_precopy()
migration_thread()
migration_thread()
migration_thread()
qemu_thread_start()
start_thread()
clone()

The access to the machine class returned by MACHINE_GET_CLASS() in
tsc_khz_needed() is crashing as it is trying to dereference a different
type of machine class object (TYPE_PC_MACHINE) to that of this microVM.

This can be resolved by extending the changes in the following commit
f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineState from it")
and moving the save_tsc_khz field in PCMachineClass to X86MachineClass.

Fixes: f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineState from it")
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <1574075605-25215-1-git-send-email-liam.merwick@oracle.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c          | 1 -
 hw/i386/pc_piix.c     | 4 ++--
 hw/i386/pc_q35.c      | 4 ++--
 hw/i386/x86.c         | 1 +
 include/hw/i386/pc.h  | 2 --
 include/hw/i386/x86.h | 2 ++
 target/i386/machine.c | 4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 96715f8..ac08e63 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2195,7 +2195,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
      * to be used at the moment, 32K should be enough for a while.  */
     pcmc->acpi_data_size = 0x20000 + 0x8000;
-    pcmc->save_tsc_khz = true;
     pcmc->linuxboot_dma_enabled = true;
     pcmc->pvh_enabled = true;
     assert(!mc->get_hotplug_handler);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 849ee12..1bd70d1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -567,10 +567,10 @@ DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
 
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
 
     pc_i440fx_2_6_machine_options(m);
-    pcmc->save_tsc_khz = false;
+    x86mc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d51f524..385e5cf 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -508,10 +508,10 @@ DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
 
 static void pc_q35_2_5_machine_options(MachineClass *m)
 {
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
 
     pc_q35_2_6_machine_options(m);
-    pcmc->save_tsc_khz = false;
+    x86mc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index fd84b23..394edc2 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -763,6 +763,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     x86mc->compat_apic_id_mode = false;
+    x86mc->save_tsc_khz = true;
     nc->nmi_monitor_handler = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e6fa841..1f86eba 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -116,8 +116,6 @@ typedef struct PCMachineClass {
     bool enforce_aligned_dimm;
     bool broken_reserved_end;
 
-    /* TSC rate migration: */
-    bool save_tsc_khz;
     /* generate legacy CPU hotplug AML */
     bool legacy_cpu_hotplug;
 
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 82d09fd..4b84917 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -30,6 +30,8 @@ typedef struct {
 
     /*< public >*/
 
+    /* TSC rate migration: */
+    bool save_tsc_khz;
     /* Enables contiguous-apic-ID mode */
     bool compat_apic_id_mode;
 } X86MachineClass;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 6481f84..7bdeb78 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -988,8 +988,8 @@ static bool tsc_khz_needed(void *opaque)
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
-    return env->tsc_khz && pcmc->save_tsc_khz;
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(mc);
+    return env->tsc_khz && x86mc->save_tsc_khz;
 }
 
 static const VMStateDescription vmstate_tsc_khz = {
-- 
1.8.3.1



