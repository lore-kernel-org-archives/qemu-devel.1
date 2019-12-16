Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F140BC2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00C7206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgD8GBdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00C7206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtma-0005Qu-9k
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFE-0005By-Tc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFD-0007dG-BI
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFD-0007av-3u
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:15 -0500
Received: by mail-wm1-x344.google.com with SMTP id m24so6035390wmc.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=NVo33N0FsKPj4cNIkeQafvuALm/KQiBH5T2GSzmJXco=;
 b=bgD8GBdhRu825gSUvICJw/RmoPcpgFYWFfUg46yXL0Xt9dErQuc3sRCvAJFrdJLCjC
 G4yX8O7+5B/+BU3Q0Qwst5e9fDYjrgtCSrujTrGE9yVVZsu9FNufLoeiMfGh36gkNZIm
 3jnzluz+cGoAwmdgVi4A+vmYjoIZiSDlRNmjv+VAKiVZwSyDheQCGEA+rgB5dn4GqKXC
 N97vToH2BwT7nkFmcmWlvDdw+cgDHfnfRqZzb8O0sdSb1+0xzmeAtgHSV+0/1mABBhCS
 /Sihs80pJ4CIbb/OF7DStu3qaqcjpOPvtYbUpTHyj8KXFQAZVYttYU9AJUBnQt737Idz
 jssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=NVo33N0FsKPj4cNIkeQafvuALm/KQiBH5T2GSzmJXco=;
 b=Iiu6fo/9CTHoSPJAWGmy97oKgEaOjbT+KwCsvIrRgATbezIJwgFDjVqTQbH0y2mJGj
 /qXWzcC+/G3oCBcHgRRBMYXZgw9ptktcWSwWV1mG4cIGg/PN4XwmfLU0qaac/Zwrt/vr
 BBEIo6NQdB6hJWioxsibFZYmG6XvjEW909/D1Y4FfvARFgdZ58zY9XGGxcZFYkPTWL9Q
 MWdsjFQu24v9aJzwis+cATqiKBytXz++fv0vl/1h6i48x1Z6wGx2qqERrlQG1VbkebAw
 10umq3BtAVGfpqFd86juHXvxJPW8sy32BnKlQ3gHhphuRslf4hTb3iqakDTxr50215qc
 nJuQ==
X-Gm-Message-State: APjAAAWe6x2C7sJUmb0MULAu24nv/ENsEo3cfNq5ueAC1uLjsyqqj0Ut
 pvqwlVpKtweBr5eigG63jMu5AJ0d
X-Google-Smtp-Source: APXvYqxZfivsH4Tq2WFSXZF0iwy+lQRXaZVg4J+DkYPGMdu6SoD25rTC6YZXZVZip+izMwcgC3tULQ==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr31658408wmb.96.1576513753709; 
 Mon, 16 Dec 2019 08:29:13 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/62] xen: convert "-machine igd-passthru" to an accelerator
 property
Date: Mon, 16 Dec 2019 17:28:10 +0100
Message-Id: <1576513726-53700-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
index 6cd61dd..7278e59 100644
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
index 6eb885b..c02d486 100644
--- a/vl.c
+++ b/vl.c
@@ -1257,13 +1257,6 @@ static void configure_msg(QemuOpts *opts)
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
 
@@ -2642,6 +2635,10 @@ static int machine_set_property(void *opaque,
     if (g_str_equal(qom_name, "accel")) {
         return 0;
     }
+    if (g_str_equal(qom_name, "igd-passthru")) {
+        object_register_sugar_prop(ACCEL_CLASS_NAME("xen"), qom_name, value);
+        return 0;
+    }
 
     return object_parse_property_opt(opaque, name, value, "type", errp);
 }
@@ -4433,9 +4430,6 @@ int main(int argc, char **argv, char **envp)
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



