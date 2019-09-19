Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E39FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C485217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H8m0R2SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C485217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4zo-0006cA-CG
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vG-0001HL-KU
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vF-0004zu-Cp
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vF-0004yW-4f; Thu, 19 Sep 2019 18:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568932165; x=1600468165;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B2gJ3AYtGJfxpiBCTCmZcHguxPxVbHMIn0H3NBT5lCc=;
 b=H8m0R2SIOj9lfUPDpWY315f8TKuMSUa3HnB2Xb01nFBUh+1n89SmFFgn
 sKuNfk8u2TIekTLWeQLGpbGEHUglnXtom5A2I5dsm1aJI46MCwaWfL03N
 ZHk+l+hJGM+jJSNsYES7XA6ohSLftyh5oAhWutZ9pB8wUNLDrJbYvb2ni
 z4BfwdsNKvp9ukmqI5TYtGfYqdjEDTEoGmZ47Mo7N8+eulObPYk4RZBJH
 2fdKNoQR3moiERPls0dX7UuF3UE/n8Hd3mlOC95k4Is2WWdJMQqnNW7Rc
 T/oT96ObLYGO1BT6GVpJr8Z6G9283WN/CMeS1A6d223K2L9wyXtfKpqxa Q==;
IronPort-SDR: BOFiuVx0rC55x8Dy7XB38bM5HQqUIXk37K9kFd+ga8JXz7TR47gXJXFgqk2iMcnKJlNG67f0ZD
 Q6suqSRP1B8+e3saJ0loxY3AVCf8B7fTfh57/k5+TFUaCLBTabEolvqqD6Fa/1wvYwxYWMS+nd
 N+RsMrMTqJBNZeE1OICoi+qHH3sZlh+IKu1/ggs18nFfLRYB+J1LTDG07pA1+48L8PCiRnZbYS
 1rRrFNmEiLQpbsjnJHBFegmVwPFhINhL/5FzBU0BcRPPJF3hlXJ0TLphpbcjYoQhio3ViqaK92
 zjg=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; d="scan'208";a="219490590"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 06:29:24 +0800
IronPort-SDR: dknlNu4v2ne05JLeKaEV/m1AQPpApQxKj99nx4GBwLpBB5OnNMPs5fzMQepZ7J+lwYUi9VrWRD
 9cw5SeymXOuPsw5U1eXM9YirZ1oQE5h/JSJVYpoSLsTrT+VkljjHnJq6vm/sBEWNGqmmY9TnwS
 8gsRsA2An5z2ErI7zOAwsT/cIXEPU0e4aGtcZRx9SF53MWCyVEAyrPrJb10n8OJuKDxRYYVDHL
 GNw+Xt7fj6/CInagQfBZC7hxPX/dt0tDH1sZ+J2S0QGxPsHFvTTcisQpR1es3WHwODb+7L+UZ3
 a9GRh4kB9aB7CXNSOQHyloaZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:25:41 -0700
IronPort-SDR: phdgGjJsfcLJhzJUTi8ibtLU18q2CllfPiFfZkBEYzAq0SFXoATo3vKRxRtCPxdx39hPTp3iNF
 9MQYdSa/Oxau6JqarwKYWNAeYUqErrqiBobpgrUenoChocoK85BoMnkUGyYJffcqb2rEFgo83x
 gC3b38vzaAZUT17ZVJ5STXXWR4GdehiafbwlY8MifFbkIHdnbhPKzxGG3xq6lrSj/2ml+UUjI3
 /yYWFXsSGAb8Jc+Oc2ehLh1FnNakjgun/ZiWX4ZQmnYTLHCvDXB4iDWBQTHuIKHxr355uf/7NQ
 AbY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Sep 2019 15:29:09 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 3/6] riscv/sifive_u: Manually define the machine
Date: Thu, 19 Sep 2019 15:25:01 -0700
Message-Id: <95b47a08da3038df82cd1cc9d69cd005270906f8.1568931866.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568931866.git.alistair.francis@wdc.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using the DEFINE_MACHINE() macro to define the machine let's
do it manually. This allows us to specify machine properties.

This patch is no functional change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++----
 include/hw/riscv/sifive_u.h |  7 ++++++-
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9c5d791320..c3949fb316 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -310,8 +310,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 static void riscv_sifive_u_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
-
-    SiFiveUState *s = g_new0(SiFiveUState, 1);
+    SiFiveUState *s = RISCV_U_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
@@ -545,8 +544,15 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
-static void riscv_sifive_u_machine_init(MachineClass *mc)
+static void riscv_sifive_u_machine_instance_init(Object *obj)
+{
+
+}
+
+static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "RISC-V Board compatible with SiFive U SDK";
     mc->init = riscv_sifive_u_init;
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
@@ -554,7 +560,20 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
     mc->default_cpus = mc->min_cpus;
 }
 
-DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
+static const TypeInfo riscv_sifive_u_machine_init_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sifive_u"),
+    .parent     = TYPE_MACHINE,
+    .class_init = riscv_sifive_u_machine_class_init,
+    .instance_init = riscv_sifive_u_machine_instance_init,
+    .instance_size = sizeof(SiFiveUState),
+};
+
+static void riscv_sifive_u_machine_init_register_types(void)
+{
+    type_register_static(&riscv_sifive_u_machine_init_typeinfo);
+}
+
+type_init(riscv_sifive_u_machine_init_register_types)
 
 static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
 {
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 2a08e2a5db..a921079fbe 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -44,12 +44,17 @@ typedef struct SiFiveUSoCState {
     CadenceGEMState gem;
 } SiFiveUSoCState;
 
+#define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
+#define RISCV_U_MACHINE(obj) \
+    OBJECT_CHECK(SiFiveUState, (obj), TYPE_RISCV_U_MACHINE)
+
 typedef struct SiFiveUState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent_obj;
 
     /*< public >*/
     SiFiveUSoCState soc;
+
     void *fdt;
     int fdt_size;
 } SiFiveUState;
-- 
2.23.0


