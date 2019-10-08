Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0723C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B969A21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nFCnRB2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B969A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHz6N-0004XB-T1
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2B-0000S6-Jn
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2A-0006R3-6G
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz29-0006Q6-Qj; Tue, 08 Oct 2019 19:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570577809; x=1602113809;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kWWrsx1bcsXXl1QzJ4Tk9h5X2ZCbYLwy/+8InmU8BBo=;
 b=nFCnRB2ptBmw0TQSmJ/znwgkYrJjGgFTeOwkP+DVT4w7ktBmRgiK9A/u
 SsZWblvuFuxjQNfr1S/MrYs/WCf2Fc3bemad0ULjmr21py6/t/LFPrLAf
 4ZHGL2/2yupYNJj/ToLoQ8WdDtpy95TUEfGKl2pTb3xPEAFKmmzBU+DER
 jkF2Pyr4g09BRty3k61J0eSpkc2zZk0IBmI+TahZeyrsY3MSLyfqV59BB
 5HrDYTbX5VnSGNPmPlWmbP7Iyd34M34qnkOrJiJfue1omqpB5HSXi6DOe
 yXNZFlFTNdbbCw5YDLzhwRcUwRx48xVNAFU30vxwGTi7fPB/aUJ7hYYC/ w==;
IronPort-SDR: kVtfbpcNZYIz3AuZbK4nKlbBRHBlanrXYJeYUZdPH1rRTBS/IrIBjqCkvcRAOCL4uFBTU+x0wA
 j2QCI+4uNJY/V4jsBUq5yyKjEY0Kl/2tAFJbcrNlzxqJGYMzvy9lkUQBf48bKSyGsxr7jy/4aq
 7g6AMoIua7ApB9hUZlkkLsxpDxs2uYgr1c0nWBEH8oqW6xBmZYGmghcSzml8jkksM4qgNcNS5I
 qsl6fk+g2/+43Ad5deIGQEUXYD8LRgx5M2kNGes5n4p/G+1pc05bEc9geK5kVC4b0QvkLIvsrV
 nGk=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; d="scan'208";a="227059691"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 07:36:49 +0800
IronPort-SDR: 8S9p4T3edRmpRczheR7YEnHExnkK86UVXRriUTeyVzqTCFZYh+n6rwnX5ICB59bOtPesZM+sd8
 TavoPf0bLEGmD8hZeJQqjyQKjeDjfIU2AN32HAkl403pssA9Vd1Lb7kWorLCbnOW8C9/A1E+2Y
 z7ykdfl1x37r9PJHHemH8v5G26lRdtYoG7+uYZK3sg9FJo7zFIvHHIZcEpkFr+nbdGy+m2UWad
 OYF3BQtNkX0gRPTzRYk9zxVTjnCpcZ1/IzlKXUMdulbWugG4yeEyz1RlAH4wqhERdoDsxlGWrQ
 fgkONK4HhZHZkQaHLYaEe1HO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 16:32:50 -0700
IronPort-SDR: PpyqTvErwLcqIF4bQ/xLNCYIYheoec60zDy6Y97jXAvsP+Nf2vTvxiayjoO9AdolGSM3W7ZZfU
 TxKjA4Ln+UYN7XD4Eo8WmbkCzaL5KNLByzbKzKglNsVhnuqDXGV1kkHJpTR5VScr9ileuZzQtV
 ZcIzyOl8eh71Rk7K8/YP+E5UApzQKwdAOn2VrXu0uxomT2KWTpmJo7IrHcWlcloWlEQiCLNQQl
 qX3PuSRlUqIq1IX6JIjon6FW4qcyAESruNYZn3CpGTEjPSyMntPogEGfNfusxiB0d1v3AFJydg
 jzY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 16:36:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 4/7] riscv/sifive_u: Add the start-in-flash property
Date: Tue,  8 Oct 2019 16:32:18 -0700
Message-Id: <03cc7cf5c8400dffd6af60f06fe637f117747d9a.1570577500.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570577500.git.alistair.francis@wdc.com>
References: <cover.1570577500.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

Add a property that when set to true QEMU will jump from the ROM code to
the start of flash memory instead of DRAM which is the default
behaviour.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v3:
 - Use the start_addr variable instead of editing reset vector
 - Fix function names

 hw/riscv/sifive_u.c         | 30 +++++++++++++++++++++++++++++-
 include/hw/riscv/sifive_u.h |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f5741e9a38..43e9f744a3 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -314,6 +314,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
+    target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
     int i;
 
     /* Initialize SoC */
@@ -356,6 +357,10 @@ static void riscv_sifive_u_init(MachineState *machine)
         }
     }
 
+    if (s->start_in_flash) {
+        start_addr = memmap[SIFIVE_U_FLASH0].base;
+    }
+
     /* reset vector */
     uint32_t reset_vec[8] = {
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
@@ -368,7 +373,7 @@ static void riscv_sifive_u_init(MachineState *machine)
 #endif
         0x00028067,                    /*     jr     t0 */
         0x00000000,
-        memmap[SIFIVE_U_DRAM].base, /* start: .dword DRAM_BASE */
+        start_addr,                    /* start: .dword */
         0x00000000,
                                        /* dtb: */
     };
@@ -432,8 +437,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
+static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    return s->start_in_flash;
+}
+
+static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = value;
+}
+
 static void riscv_sifive_u_machine_instance_init(Object *obj)
 {
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = false;
+    object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
+                             sifive_u_set_start_in_flash, NULL);
+    object_property_set_description(obj, "start-in-flash",
+                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "flash. Otherwise QEMU will jump to DRAM",
+                                    NULL);
 }
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index a921079fbe..2656b43c58 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -57,6 +57,8 @@ typedef struct SiFiveUState {
 
     void *fdt;
     int fdt_size;
+
+    bool start_in_flash;
 } SiFiveUState;
 
 enum {
-- 
2.23.0


