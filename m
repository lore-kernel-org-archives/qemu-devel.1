Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D435FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3ED207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 20:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="owmy5G41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3ED207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZKuC-0002ky-Nx
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 16:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=396c018a7=alistair.francis@wdc.com>)
 id 1jZKtF-0001tF-Ud; Thu, 14 May 2020 16:55:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=396c018a7=alistair.francis@wdc.com>)
 id 1jZKtE-0005rX-Fy; Thu, 14 May 2020 16:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589489737; x=1621025737;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2HDd/C2UWnadtJ9ZSqd7xPDn/jXNijxuJWKSqqsdZKU=;
 b=owmy5G41oDAJgFcorltQLaT7n+YsyyBxcttN24NtjRMyqrVhpHnJ6+gl
 en/7OOS2mCOVFkZM7mNGDtkQkggWyVE5a3VuF0mRYowWMKt8hSKjC/RGP
 FT1RoOV0+MiR1o77pjrdFvZIXkRcHH/VXpYYKAFyUjjCV7hZDFeQWMmrc
 act0Mrrw6TqzinUHa9iqndHtlDlAypJD+vfasfeV/qUjFC3kVmVaV+qjE
 +bkDjZjZXBaxpOY8ikW96O9hQFiVgWqxR3GAsQynMGQgoleKMEvQER2IL
 retuvsrho8/sSykHOwcj2WY7qjI1I9CseLqGewPvVjJRh17ldiKPDbaxT g==;
IronPort-SDR: VC7ZxqmZUDxyWlLvOQSrYwyz2pznHltx1EO9j1RTdN46OVkwxMZW8u3vvGBSel0sSa1XKq8tZJ
 YKL+qMdva2IykdGsKzB7U/DpeqYW/Z1kJ/26+TbL9wCOFYoFhkSscZtVrDnQuXMPMO3lTuGPms
 Bm7OwPJFgz0tNcrOQhRh2LNOQdrOUTserRr3TQtJjyAiuHbozoHlxPuOpdBCQ9d/h5Z1Nc1RAJ
 pRnAgMbGj4BaSbGVJnr5vB3BQv/ujLZ8YvIqgIB7tXhMEzlXeYRME4G/k963qHWfV4/ySy/lcB
 efY=
X-IronPort-AV: E=Sophos;i="5.73,392,1583164800"; d="scan'208";a="142061443"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 04:55:34 +0800
IronPort-SDR: N49YgIYFQliNrVT0XfGTMH2iZ8AZWYyP+KZ3jBJVvagCSah1g0jzyt5RGy/jIA3WzcedR1eoNx
 w6MEdvZf3bDt8zSE4v8E3CXJAGUOC18to=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2020 13:45:45 -0700
IronPort-SDR: ZT/kF2VWgLu0eBO8tNBKvHO2fy7vaLq35sCHTqIJ+V/bOWUmW1RN62Ty8Vx7nFsS0yD04YXNyy
 OlDcjNZDl2xQ==
WDCIronportException: Internal
Received: from 327gvz1.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2020 13:55:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/2] sifive_e: Support the revB machine
Date: Thu, 14 May 2020 13:47:10 -0700
Message-Id: <925bdcd2b3536014306a8800975fb63592fd051a.1589489213.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <da77b1e0a31f2f8fb18117b20a1493ab1ec0471f.1589489213.git.alistair.francis@wdc.com>
References: <da77b1e0a31f2f8fb18117b20a1493ab1ec0471f.1589489213.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=396c018a7=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 16:55:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c         | 35 +++++++++++++++++++++++++++++++----
 include/hw/riscv/sifive_e.h |  1 +
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 472a98970b..cb7818341b 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -98,10 +98,14 @@ static void riscv_sifive_e_init(MachineState *machine)
         memmap[SIFIVE_E_DTIM].base, main_mem);
 
     /* Mask ROM reset vector */
-    uint32_t reset_vec[2] = {
-        0x204002b7,        /* 0x1000: lui     t0,0x20400 */
-        0x00028067,        /* 0x1004: jr      t0 */
-    };
+    uint32_t reset_vec[2];
+
+    if (s->revb) {
+        reset_vec[0] = 0x200102b7;        /* 0x1000: lui     t0,0x20010 */
+    } else {
+        reset_vec[0] = 0x204002b7;        /* 0x1000: lui     t0,0x20400 */
+    }
+    reset_vec[1] = 0x00028067;        /* 0x1004: jr      t0 */
 
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
@@ -115,8 +119,31 @@ static void riscv_sifive_e_init(MachineState *machine)
     }
 }
 
+static bool sifive_e_machine_get_revb(Object *obj, Error **errp)
+{
+    SiFiveEState *s = RISCV_E_MACHINE(obj);
+
+    return s->revb;
+}
+
+static void sifive_e_machine_set_revb(Object *obj, bool value, Error **errp)
+{
+    SiFiveEState *s = RISCV_E_MACHINE(obj);
+
+    s->revb = value;
+}
+
 static void sifive_e_machine_instance_init(Object *obj)
 {
+    SiFiveEState *s = RISCV_E_MACHINE(obj);
+
+    s->revb = false;
+    object_property_add_bool(obj, "revb", sifive_e_machine_get_revb,
+                             sifive_e_machine_set_revb, NULL);
+    object_property_set_description(obj, "revb",
+                                    "Set on to tell QEMU that it should model "
+                                    "the revB HiFive1 board",
+                                    NULL);
 }
 
 static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 414992119e..0d3cd07fcc 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -45,6 +45,7 @@ typedef struct SiFiveEState {
 
     /*< public >*/
     SiFiveESoCState soc;
+    bool revb;
 } SiFiveEState;
 
 #define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
-- 
2.26.2


