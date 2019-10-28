Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8CDCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A4A214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JXDOeJUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A4A214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8Qa-0003gj-LG
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pk-0005X7-03
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pi-0003xk-JD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:39 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:45639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pi-0003wv-Ds
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id y24so5768796plr.12
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=37C4bJsqwTYJDhkHJBdMxhyCv+2so2gtmom4EOj9zjo=;
 b=JXDOeJUWYhMycj2BTvOKus1X4Ik0jtZ7jbj+pPkWeYEvoGwTcUASClHKuIdVLhRRM6
 jqXq37jvmaQImZs1LH6l7CBEVkabWfTYeCgKYEU/o/+kQsqm/hEsleynUh8XQSnqdbdd
 jpmFgm3ArOFo7n2YwlOh6CpSe7XRIKYdKm4Mo0NquDbDAkXYGcjaB89Ez/d53qlJPiC2
 OGHxrXS/pi6195SKGCX25qyhPNg07l5xajakrTyEhvvY1/nyuMWdpjD8wc5E/EH9K333
 WCRBo7A/djIOIioALyvxKUOGg5tWBeiS3nEsHcdomzPA6h8D9zlfwmzQ3vm8sna9At9k
 tBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=37C4bJsqwTYJDhkHJBdMxhyCv+2so2gtmom4EOj9zjo=;
 b=Ql63bm3PYrXYyDbDe28i9Pfp6rlh4IdPR/7oTHVRGLVvvH9xnkgRnsfQr696tj1VKn
 Hie6t3gIhIlsgBHV7j4ihOezv7kxXnSf4got3hQLTuj/QLbsYR/SVabZb6fpJWkqm6qS
 +vUdLI3D+OWbHvYuqpYraLGKMZy88pMjKXsQc94mIqSvox8bu0ySjSY0gWsxVpdLaUba
 uop1vEk2snppJ2uWkRUXmRocc4ulugLZ/u/OpaJvbp2tQ/Og9sxWmJ0aLUs6wgRgK0+u
 ImGGNM2QD48f6XWzW6TyBkTJcytcJFIyb5K75g3bvjEYeMGV8zdE7UfdhiMHTCCMWE/5
 VjZg==
X-Gm-Message-State: APjAAAWwVxJ46/UlXuWwJBodLOK23ctI3DOuY7iCfm969zPhb/AFO9BZ
 Up1hlUO6UeSicXSyAbJ6RCtsM6ZgTAZ4eQ==
X-Google-Smtp-Source: APXvYqx0HXMw+WJ11vbGgtsG9Kubu3dUa5iE8U1RoUZGeEDgjuai8CtjCKDtjbHW8wjaOjeLZLK0mw==
X-Received: by 2002:a17:902:347:: with SMTP id
 65mr19256786pld.161.1572278317026; 
 Mon, 28 Oct 2019 08:58:37 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id s23sm11125289pgh.21.2019.10.28.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:36 -0700 (PDT)
Subject: [PULL 11/18] riscv/virt: Manually define the machine
Date: Mon, 28 Oct 2019 08:48:55 -0700
Message-Id: <20191028154902.32491-12-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62b
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Instead of using the DEFINE_MACHINE() macro to define the machine let's
do it manually. This allows us to use the machine object to create
RISCVVirtState. This is required to add children and aliases to the
machine.

This patch is no functional change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c         | 30 ++++++++++++++++++++++++------
 include/hw/riscv/virt.h |  7 ++++++-
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 13030619d4..bdbdfadd29 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -360,8 +360,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
 static void riscv_virt_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = virt_memmap;
-
-    RISCVVirtState *s = g_new0(RISCVVirtState, 1);
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
@@ -497,12 +496,31 @@ static void riscv_virt_board_init(MachineState *machine)
     g_free(plic_hart_config);
 }
 
-static void riscv_virt_board_machine_init(MachineClass *mc)
+static void riscv_virt_machine_instance_init(Object *obj)
 {
-    mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
+}
+
+static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V VirtIO board";
     mc->init = riscv_virt_board_init;
-    mc->max_cpus = 8; /* hardcoded limit in BBL */
+    mc->max_cpus = 8;
     mc->default_cpu_type = VIRT_CPU;
 }
 
-DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
+static const TypeInfo riscv_virt_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("virt"),
+    .parent     = TYPE_MACHINE,
+    .class_init = riscv_virt_machine_class_init,
+    .instance_init = riscv_virt_machine_instance_init,
+    .instance_size = sizeof(RISCVVirtState),
+};
+
+static void riscv_virt_machine_init_register_types(void)
+{
+    type_register_static(&riscv_virt_machine_typeinfo);
+}
+
+type_init(riscv_virt_machine_init_register_types)
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 68978a13e8..3d875305d3 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -22,13 +22,18 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
+#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define RISCV_VIRT_MACHINE(obj) \
+    OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_MACHINE)
+
 typedef struct {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent;
 
     /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
+
     void *fdt;
     int fdt_size;
 } RISCVVirtState;
-- 
2.21.0


