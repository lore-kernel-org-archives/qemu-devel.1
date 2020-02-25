Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E409C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F134B2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhWYQJvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F134B2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZCQ-0000fB-2v
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl3-0001F6-5v
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykz-0008Fy-6p
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:13 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Ykx-00084Y-FF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:08 -0500
Received: by mail-wr1-x42e.google.com with SMTP id z3so14384161wru.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ItI3fRDtU/zzNqxISOjM3JewIShkqFsorUHppZV+U1E=;
 b=PhWYQJvsnGSGvi3EAMg0tO5eKahr6Ld4lcnwq61cVrUJTXhnN8kmfs55bKzKMrXYys
 sLUWIUunkOU7IJH4T4qa/md+2tE9eroTK1DNZtLZZIW65O0xNE6z2Hmygr73FjJuHZ7K
 eFOWChlLPx7qYznbsw+OfH4gASE8ct1KQo2L8aj/OeMRuVa7i0Dp7niGnFOgPFbDufCi
 cyZ9qWE0dSGMXNVo4N/4bRikPiBXO4xxfuXeY6Khmw9j6bHpFf0IYeiUthHkMk6IIKpD
 UxV+wLBuAE3BPSlhHa8P6XssfZZN1Vwufnj7owJ7QDzDEWlct/zmlnDalFEvcmYXGeCh
 8+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ItI3fRDtU/zzNqxISOjM3JewIShkqFsorUHppZV+U1E=;
 b=LTEUBY7ochhu9gGjseIV8t7Q8I0GVQxrF4vuIfhmLOBIcJk4rIPvlpiO3zq4JCOMuZ
 Qvqd1rDL7r8Qc8eAk570DjBemHf0QP+quT0A1uqyX8zLr0kMYEIEVunydae95lWDHTqf
 0ppozr/Ed68h7ldY8uOQMW5Y1wgboN6Cq6sWLoXaxpzOZHikAKgC1xln6AepmSBSBykW
 AD9igaXA/qCIEoglhc4m9Ic2b6ktL8z2jksQISF10vu3gl3Vo/PkYuatY2WIRxPWJoLX
 n8x8hbbUK5/mWG1NNc/xr4zCBllsO3jqU9XqMkPTHLW7nFDw9CuofJ5+MRGEg3lesSJP
 k4Dg==
X-Gm-Message-State: APjAAAUeWW2SEtqs7fpwpPEEXrLB8lgZ0WJCYVSVS+w1FbXRxnt22iVo
 FaTMOp/SvbOnVA9YISVa0ezxttu5
X-Google-Smtp-Source: APXvYqztmI+v60WCA4T11A7aw4X3XCZsJfa2byZ2Y38dnquZQ3h/Y86jQ75M9nyFAQVS6yeZSBhCwg==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr74676386wru.398.1582631520466; 
 Tue, 25 Feb 2020 03:52:00 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 059/136] ppc/e500: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:49 +0100
Message-Id: <1582631466-13880-59-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-60-imammedo@redhat.com>
---
 hw/ppc/e500.c      | 5 +----
 hw/ppc/e500plat.c  | 1 +
 hw/ppc/mpc8544ds.c | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 960024b..d5dfe9f 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -831,7 +831,6 @@ static void ppce500_power_off(void *opaque, int line, int on)
 void ppce500_init(MachineState *machine)
 {
     MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     PPCE500MachineState *pms = PPCE500_MACHINE(machine);
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
     PCIBus *pci_bus;
@@ -912,9 +911,7 @@ void ppce500_init(MachineState *machine)
     }
 
     /* Register Memory */
-    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(address_space_mem, 0, ram);
+    memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     dev = qdev_create(NULL, "e500-ccsr");
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 7078386..bddd5e7 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -97,6 +97,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->init = e500plat_init;
     mc->max_cpus = 32;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
+    mc->default_ram_id = "mpc8544ds.ram";
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index c2c5e11..8117750 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -55,6 +55,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->init = mpc8544ds_init;
     mc->max_cpus = 15;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
+    mc->default_ram_id = "mpc8544ds.ram";
 }
 
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
-- 
1.8.3.1



