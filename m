Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E31C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1D62072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfwqlyMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1D62072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYDi-0004hv-5z
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY38-0006Ij-3z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY35-0000UK-SR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:29 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY35-0000S2-4b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:27 -0500
Received: by mail-wr1-x442.google.com with SMTP id q6so1979344wro.9
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=qHzAYil75oWgqUim8nsgFtlMQDggWDpdj4zdhH7uJus=;
 b=AfwqlyMePoFrXnYTXAao1184Gfqx9QXeSDYt0iZVA3f4JnTa2aCADz9195135gptbp
 CxnzdtxR9tfynaMgcvdyDTWVxGvBw3un+TRamLKaqDfc01hQQz3CV/UK4OZgMnCowTT7
 hBFdl5tKw6yxLHCOfZGTJcySvALWiFa1t5w8D8ixpfRXlaJ9FFdlNoKVDNpoDvgZVl9i
 yA36IGQSvg7OY4aqgK5pCTuLv3uoFNTx9eNtAsl6eUkBiWAWUHzsVRqWi7gjWp2673lt
 Q2h9j6ORBucWQmvQ3h2LDjW6ebgY6EtlMRPE8DgA/500W2SUmWGS3m49g4ZMQoEr5glA
 g7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=qHzAYil75oWgqUim8nsgFtlMQDggWDpdj4zdhH7uJus=;
 b=iDSznrG+t6B/KzLaxUVIPKlpjyt0dNrEDXtzi1oabXWg+nCO1Vm9zfKtKejVdBVYdp
 h5+TiB4Cdt2nZxa5+Q9QHcyRb5oPeeK78jZgo7itI723LK6X1MhsulaZCysqcsV7De6r
 wkWgFMs9LL9xsqdQgo9DmYplUQkm0YbfHPLG+CbW72EoLFGm2mM6MFSNswcHpKk+gVax
 qihy4V9iw3gjcVpRAaKIYM4MTdiSltwrR31gDrd1UyTXov2IKkv5jzOsW2zOtVMijmj3
 GeprAC+Jik/crYxtJ+pQdh+iEjlQX3HrY9Mxt7WXpALsWNsce2TuGuGMPzSxQiOQ716E
 5zwQ==
X-Gm-Message-State: APjAAAV9up282XW6yx89IJ0rxbOx4HQvu9EXCv9GfUcpXZSbq6P+MIus
 IN7El/zoIeuVCVuDFMv1xOHJPGCD
X-Google-Smtp-Source: APXvYqzaKKYv15lcGA9UB6z/A+2hptCrImiWFa2PXvjW1SN6deL1S/uI7ODw5jGwQTc6z99kg/+1uQ==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr2413681wrp.238.1576670601352; 
 Wed, 18 Dec 2019 04:03:21 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/87] xen: convert "-machine igd-passthru" to an accelerator
 property
Date: Wed, 18 Dec 2019 13:01:52 +0100
Message-Id: <1576670573-48048-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

The first machine property to fall is Xen's Intel integrated graphics
passthrough.  The "-machine igd-passthru" option does not set anymore
a property on the machine object, but desugars to a GlobalProperty on
accelerator objects.

The setter is very simple, since the value ends up in a
global variable, so this patch also provides an example before the more
complicated cases that follow it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   | 20 --------------------
 hw/xen/xen-common.c | 18 ++++++++++++++++++
 hw/xen/xen_pt.c     |  2 ++
 include/hw/boards.h |  1 -
 qemu-options.hx     |  7 ++++---
 vl.c                | 14 ++++----------
 6 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index e661fa6..05cea3a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -417,20 +417,6 @@ static void machine_set_graphics(Object *obj, bool value, Error **errp)
     ms->enable_graphics = value;
 }
 
-static bool machine_get_igd_gfx_passthru(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return ms->igd_gfx_passthru;
-}
-
-static void machine_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    ms->igd_gfx_passthru = value;
-}
-
 static char *machine_get_firmware(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -867,12 +853,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "graphics",
         "Set on/off to enable/disable graphics emulation", &error_abort);
 
-    object_class_property_add_bool(oc, "igd-passthru",
-        machine_get_igd_gfx_passthru, machine_set_igd_gfx_passthru,
-        &error_abort);
-    object_class_property_set_description(oc, "igd-passthru",
-        "Set on/off to enable/disable igd passthrou", &error_abort);
-
     object_class_property_add_str(oc, "firmware",
         machine_get_firmware, machine_set_firmware,
         &error_abort);
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 5284b0d..15650d7 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -11,7 +11,9 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "hw/xen/xen-legacy-backend.h"
+#include "hw/xen/xen_pt.h"
 #include "chardev/char.h"
 #include "sysemu/accel.h"
 #include "sysemu/runstate.h"
@@ -124,6 +126,16 @@ static void xen_change_state_handler(void *opaque, int running,
     }
 }
 
+static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
+{
+    return has_igd_gfx_passthru;
+}
+
+static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
+{
+    has_igd_gfx_passthru = value;
+}
+
 static void xen_setup_post(MachineState *ms, AccelState *accel)
 {
     int rc;
@@ -177,6 +189,12 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
     ac->compat_props = g_ptr_array_new();
 
     compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
+
+    object_class_property_add_bool(oc, "igd-passthru",
+        xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
+        &error_abort);
+    object_class_property_set_description(oc, "igd-passthru",
+        "Set on/off to enable/disable igd passthrou", &error_abort);
 }
 
 #define TYPE_XEN_ACCEL ACCEL_CLASS_NAME("xen")
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 8fbaf2e..9e767d4 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -65,6 +65,8 @@
 #include "qemu/range.h"
 #include "exec/address-spaces.h"
 
+bool has_igd_gfx_passthru;
+
 #define XEN_PT_NR_IRQS (256)
 static uint8_t xen_pt_mapped_machine_irq[XEN_PT_NR_IRQS] = {0};
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 96f2084..5025c1a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -287,7 +287,6 @@ struct MachineState {
     bool mem_merge;
     bool usb;
     bool usb_disabled;
-    bool igd_gfx_passthru;
     char *firmware;
     bool iommu;
     bool suppress_vmdesc;
diff --git a/qemu-options.hx b/qemu-options.hx
index ee1f676..1535390 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -37,7 +37,6 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                kvm_shadow_mem=size of KVM shadow MMU in bytes\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
-    "                igd-passthru=on|off controls IGD GFX passthrough support (default=off)\n"
     "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
@@ -71,8 +70,6 @@ more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @item kernel_irqchip=on|off
 Controls in-kernel irqchip support for the chosen accelerator when available.
-@item gfx_passthru=on|off
-Enables IGD GFX passthrough support for the chosen machine when available.
 @item vmport=on|off|auto
 Enables emulation of VMWare IO port, for vmmouse etc. auto says to select the
 value based on accel. For accel=xen the default is off otherwise the default
@@ -120,6 +117,7 @@ ETEXI
 DEF("accel", HAS_ARG, QEMU_OPTION_accel,
     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
     "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
+    "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
     "                tb-size=n (TCG translation block cache size)\n"
     "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
 STEXI
@@ -130,6 +128,9 @@ kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If th
 more than one accelerator specified, the next one is used if the previous one
 fails to initialize.
 @table @option
+@item igd-passthru=on|off
+When Xen is in use, this option controls whether Intel integrated graphics
+devices can be passed through to the guest (default=off)
 @item tb-size=@var{n}
 Controls the size (in MiB) of the TCG translation block cache.
 @item thread=single|multi
diff --git a/vl.c b/vl.c
index 900f97a..774305c 100644
--- a/vl.c
+++ b/vl.c
@@ -1133,13 +1133,6 @@ static void configure_msg(QemuOpts *opts)
 }
 
 
-/* Now we still need this for compatibility with XEN. */
-bool has_igd_gfx_passthru;
-static void igd_gfx_passthru(void)
-{
-    has_igd_gfx_passthru = current_machine->igd_gfx_passthru;
-}
-
 /***********************************************************/
 /* USB devices */
 
@@ -2517,6 +2510,10 @@ static int machine_set_property(void *opaque,
     if (g_str_equal(qom_name, "accel")) {
         return 0;
     }
+    if (g_str_equal(qom_name, "igd-passthru")) {
+        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, value);
+        return 0;
+    }
 
     return object_parse_property_opt(opaque, name, value, "type", errp);
 }
@@ -4297,9 +4294,6 @@ int main(int argc, char **argv, char **envp)
             exit(1);
     }
 
-    /* Check if IGD GFX passthrough. */
-    igd_gfx_passthru();
-
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     qemu_opts_foreach(qemu_find_opts("device"),
-- 
1.8.3.1



