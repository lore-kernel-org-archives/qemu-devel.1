Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A23B2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cgRmWjVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A23B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAda-0007OI-NK
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbi-0005Tj-0H
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbe-00028R-Sn
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548471; x=1624084471;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XXem7lAIy5JLne6cVjjQsO7guKTzZZhyfFB1ov8zLOg=;
 b=cgRmWjVikj2071JeB3c0rHBBVuLXhMhpFuXV77aD8VdYZzLAtQzkZhfa
 eOy3yBKGwtIGg2GX8SR8sKv7P2D7vY5o9b5ZN/6/nhyz+is9vna/b497A
 wU3xAR6sCWhZY+yHcIP2QN3z0iCgfh5o2icmUhI/3sxuCig3QrrjJLRRb
 CnXI4ZdsDPiLj1E89QBjBnEKnK+vapybTZzpJzr/LGRu6yVvfLCEpqp01
 pLU9EWBARWYdVpLNqIhXoQpSHeSVb4vFj6vcFJph+lt20hmDnAGPnqbBv
 2nyZntzCpwtD6xcXC1O+YG7UaDQiAV0IzkMlxBZ9J0rKGHRLb97wZWmEA g==;
IronPort-SDR: TFQ9XjMGLCWarpT088r05XMeI1RHg6y5VyhsZNkZObyyDWWZXW0izl+UkBo0SE5bBxxQb6UGAe
 GDcwr6fkpcNz3MflODWAYwEjpZk5cLLjq0olo7ElH2p5EP6cgUwJELp2nQ59O1H4+gi7juqyOQ
 oK+5m6ytmeObEWj2/8Op2YOuv/C/JC1wkWl2SPI+1R4cSYa/Dz9zlQxOkyYwYGltulcWMIcT+f
 WGQDCwl9xab0ItYcdjS/W7smJCDomxYeuD+qJjUqhmCnoEnptMt4hz1yeAxF6gyvti2210Gm4f
 u/c=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="144724275"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:26 +0800
IronPort-SDR: VvVzRsiW2wv9u21dNy2iSKQuylj1yd9VqLDc0s2XwLSV5qzbk9XjAf0xsrCCwCxlXtypU9aaFr
 kAK2zdCb0sIK9FM6yTv7T5C/K1mPbUjeI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:37 -0700
IronPort-SDR: 1MGTkrQNFI0ltoqwg7lwC2zV3i17156UZcleuCkRjuLzMWYC+j3IDAZDHr3tuPhjV5J5uFaM9d
 V5NOJBCjIX4A==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/32] sifive_e: Support the revB machine
Date: Thu, 18 Jun 2020 23:24:48 -0700
Message-Id: <20200619062518.1718523-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:26
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_e.h |  1 +
 hw/riscv/sifive_e.c         | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index d386ea9223..637414130b 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -45,6 +45,7 @@ typedef struct SiFiveEState {
 
     /*< public >*/
     SiFiveESoCState soc;
+    bool revb;
 } SiFiveEState;
 
 #define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1c17d02cf0..36486b72d2 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -95,10 +95,14 @@ static void riscv_sifive_e_init(MachineState *machine)
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
@@ -112,8 +116,30 @@ static void riscv_sifive_e_init(MachineState *machine)
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
+                             sifive_e_machine_set_revb);
+    object_property_set_description(obj, "revb",
+                                    "Set on to tell QEMU that it should model "
+                                    "the revB HiFive1 board");
 }
 
 static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
-- 
2.27.0


