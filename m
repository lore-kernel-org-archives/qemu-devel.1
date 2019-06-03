Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F971C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48C12744C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 17:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6F7jAxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48C12744C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqiI-0001YW-W8
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 13:25:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUT-0007Sd-Ur
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hXqUQ-0004Ww-56
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:19 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hXqUO-0004MJ-1L
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 13:11:18 -0400
Received: by mail-wr1-x431.google.com with SMTP id e16so4656460wrn.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6lNgOMh83d+owFjOzMGpgB7V4MpxWZDFyB9agcLkI6o=;
	b=W6F7jAxuFJ0IytjGJ/MCkygD434A4TBTkxNE/31KtuKrLF2uw9D5r6rh4J4q0s7yL8
	2CRZZoXP0J5aOCmIfC/gqSqCsSeiyhKk8+lG2epZY8eMypIbUBuoeZZQXNmsXFEunFdW
	KKlPEdj5hhJ2uTMFie4cq/+go6hzHfQ0TIsbachat4PqBxoYgEW1ZRfKXPzykAdhuDUq
	Oq3kXqS+h/bp+L5FXE9d9ODm422tF31vZKS34xu9/V5F+f1RSo/pFC8K0QyBpT1OTYYA
	WYQmVeKF9efIfid4XXgyWyY3IZxaRQHZmNsJ0NxxKKpXvsG1woesl4NNqru1R8a/Cl1C
	q7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references;
	bh=6lNgOMh83d+owFjOzMGpgB7V4MpxWZDFyB9agcLkI6o=;
	b=SPGGVAdbwbUmz+eCRCnPdjb7q74g1gN1JuUqhcmEzfJYjecomFoji4PXfsi49QSoHU
	K9B0dsoc7QaYwqUMmPrUVir60Z1AHDMeSksnTUvuUPF5JND3Dq1DO69m96gEgbSRm710
	iadwL5CslGfGCDeTr/yXftEjIk2Wqn917D4vXHGxwU1/wYOoeUcUm0dXM6gRxuu7KK4Y
	gt45Yi15wF21j7ilpJpkV3O9wYwHkEJdnIj4QOacNEgI8QmN+IiK327sz7y2veTDfNhw
	TlOh53Bx2Ur/LGvrY9UFqcsL54TMfJ3O1Oja5baRzWWQwLYsstY03OtZG32Twhwnl2a+
	lNIA==
X-Gm-Message-State: APjAAAXgJKb7DnPXn4SeTsuH4g032iJhwhRjFI9tVf09IXozNJ5ddLyH
	q7/PH96N4L16ne6l6ChBeebCdJ8v
X-Google-Smtp-Source: APXvYqyHwYcPi2dph6ZAi1NWsmYXE7z1y+3+pbOFYvb4mxADKj3IxLTKTFoF2IjiJ9KRRc+h9u3GcA==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr3499660wrn.201.1559581871572; 
	Mon, 03 Jun 2019 10:11:11 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	r131sm3325045wmf.4.2019.06.03.10.11.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 10:11:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 19:10:43 +0200
Message-Id: <1559581843-3968-25-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
References: <1559581843-3968-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 24/24] q35: Revert to kernel irqchip
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Williamson <alex.williamson@redhat.com>

Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
the default for the pc-q35-4.0 machine type to use split irqchip, which
turned out to have disasterous effects on vfio-pci INTx support.  KVM
resampling irqfds are registered for handling these interrupts, but
these are non-functional in split irqchip mode.  We can't simply test
for split irqchip in QEMU as userspace handling of this interrupt is a
significant performance regression versus KVM handling (GeForce GPUs
assigned to Windows VMs are non-functional without forcing MSI mode or
re-enabling kernel irqchip).

The resolution is to revert the change in default irqchip mode in the
pc-q35-4.1 machine and create a pc-q35-4.0.1 machine for the 4.0-stable
branch.  The qemu-q35-4.0 machine type should not be used in vfio-pci
configurations for devices requiring legacy INTx support without
explicitly modifying the VM configuration to use kernel irqchip.

Link: https://bugs.launchpad.net/qemu/+bug/1826422
Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <155786484688.13873.6037015630912983760.stgit@gimli.home>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c    |  3 +++
 hw/i386/pc.c         |  3 +++
 hw/i386/pc_q35.c     | 16 ++++++++++++++--
 include/hw/boards.h  |  3 +++
 include/hw/i386/pc.h |  3 +++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 16ba667..f1a0f45 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,6 +24,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
 
+GlobalProperty hw_compat_4_0_1[] = {};
+const size_t hw_compat_4_0_1_len = G_N_ELEMENTS(hw_compat_4_0_1);
+
 GlobalProperty hw_compat_4_0[] = {};
 const size_t hw_compat_4_0_len = G_N_ELEMENTS(hw_compat_4_0);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2632b73..edc240b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -110,6 +110,9 @@ struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
+GlobalProperty pc_compat_4_0_1[] = {};
+const size_t pc_compat_4_0_1_len = G_N_ELEMENTS(pc_compat_4_0_1);
+
 GlobalProperty pc_compat_4_0[] = {};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 37dd350..dcddc64 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -357,7 +357,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->units_per_default_bus = 1;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
-    m->default_kernel_irqchip_split = true;
+    m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -374,10 +374,22 @@ static void pc_q35_4_1_machine_options(MachineClass *m)
 DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
                    pc_q35_4_1_machine_options);
 
-static void pc_q35_4_0_machine_options(MachineClass *m)
+static void pc_q35_4_0_1_machine_options(MachineClass *m)
 {
     pc_q35_4_1_machine_options(m);
     m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_4_0_1, hw_compat_4_0_1_len);
+    compat_props_add(m->compat_props, pc_compat_4_0_1, pc_compat_4_0_1_len);
+}
+
+DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
+                   pc_q35_4_0_1_machine_options);
+
+static void pc_q35_4_0_machine_options(MachineClass *m)
+{
+    pc_q35_4_0_1_machine_options(m);
+    m->default_kernel_irqchip_split = true;
+    m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6f7916f..6ff02bf 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -292,6 +292,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_4_0_1[];
+extern const size_t hw_compat_4_0_1_len;
+
 extern GlobalProperty hw_compat_4_0[];
 extern const size_t hw_compat_4_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 43df723..5d56362 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -293,6 +293,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+extern GlobalProperty pc_compat_4_0_1[];
+extern const size_t pc_compat_4_0_1_len;
+
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
 
-- 
1.8.3.1


