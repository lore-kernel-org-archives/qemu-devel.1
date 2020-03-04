Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCDC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7585520866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hbsHZCPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7585520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9dBd-0001Ic-Lj
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:12:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d9C-0006UV-Lh
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d9B-0004mh-FJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:50 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d9B-0004Sp-3S; Wed, 04 Mar 2020 18:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583363388; x=1614899388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tS5/RYzfypa8UbTHT+8AIRjr2yDX25RBNIWTk7q2aqE=;
 b=hbsHZCPad/BVRzrnPrw4uCeco24HQ0B4OonZW/eZuTh2dMrmm3ffCxCL
 V2+dWSsE+Bw6FHX0VrkVsWnbDkZe8vrcFkvBcIN9plpWHTBe8k5HblyvH
 v7u5Y9yNuGii2ND7YrHrAuj1qLIMypy2TLq8u/YllQQJqm8rZyWAjY4DS
 QDTD9Tx4RIufUUWt1PdAx8ObMJPG+2PPsscDRLNtDMtAOEFJUj/ia5nde
 uY0XAFqG/sUtLzUB8eEcT0h6ilPdqPWQ84T/QmGCzj3CjHk+tsa+DSe28
 mSfSOvAyZkSCQIoSzftZuIX6ioS2eo9hwIhTVjvMeb7yFmrq0PmYjCkDT Q==;
IronPort-SDR: jrCXHObxTmDKEm/h2ZTm66pw1Th3Ga5rlLUO/UEYYiAIuFd1JSOoFJFoVuC7Z6rK6y28nbBIGX
 fJOGjkT9Hg4FP4jF2hw/Th7Uor9I01bkU4rZy5+c7xNPFoeUphpxF1BcmCuX3Fcp63S4Q6Trxi
 usfU8ynxskFlsvtHvug+elG9Rn+LMdMCEv/hi/Dhz4jYSo0BOs6VLXNr5x0ZoardcqnRlsTYNq
 fYXgs2CRo0tmdFpXFPyh5VHcx7r5klPz3cFURqBeekku2GQ2RLBZ3AFLWIX7/RalKueQpiuHLs
 0X4=
X-IronPort-AV: E=Sophos;i="5.70,515,1574092800"; d="scan'208";a="131477247"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2020 07:09:48 +0800
IronPort-SDR: axKrKTCEOTEJ08L/PWoWqH/QHKexsBnmjAW5yvJ6qOc+mQPsNEpqGZ94iNLL/8vlwh8W5rZBBv
 MIDBZFCONH8rA3xnKU9wok/XMiHEuoarqhGOc2szisbfOgKtjCO6Gz8owSyoD4onojZ6sRDs8c
 6Xvrrs1M9nmZJDgMfudVMYb39rZsis0JQR4rDyYWf87QjawRjtwlskL4Jq/Ui7jJdJrdBKCQTT
 JexwSvWWi2tYqCIgFstf8YNZSxODt25Ge+cfhsUL6cnkYiarVNaxDbzaN4B87YF42L6iY24njm
 +xm7nL5jwFbDKLp8Kf9ihbgN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 15:01:37 -0800
IronPort-SDR: pCYkyyjdUfZ4L5T2j+POINtVe9Mnim3T5sxviv2INBJNgDwd+x2LITu0IXmY92qTi3oOJPqBTO
 dl/M37Gi9/kMu7d73LWVHR9wo5HTImO63ASgNSAISekojbQKnvkCGkfbuhwo0q5RbUhsex+w5I
 qvNDy6or8BP90gsNF/4MZQgWjcixzt5g1jZiWcWKboYZkNeOso1ICWaoenBAC6GNyIiyGhKbTZ
 /d1Nue3BQNhReX3ntWRp5yJq0GRBF/zOkDp0kOIN/DKjm9MU1NEbzt722F1/O15CjU4prPGlio
 Sp0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Mar 2020 15:09:48 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 3/3] riscv/sifive_u: Add a serial property to the sifive_u
 machine
Date: Wed,  4 Mar 2020 15:02:33 -0800
Message-Id: <237a53529eae97b79e63938cd45672f1420ab954.1583362888.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583362888.git.alistair.francis@wdc.com>
References: <cover.1583362888.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

From: Bin Meng <bmeng.cn@gmail.com>

At present the board serial number is hard-coded to 1, and passed
to OTP model during initialization. Firmware (FSBL, U-Boot) uses
the serial number to generate a unique MAC address for the on-chip
ethernet controller. When multiple QEMU 'sifive_u' instances are
created and connected to the same subnet, they all have the same
MAC address hence it creates a unusable network.

A new "serial" property is introduced to specify the board serial
number. When not given, the default serial number 1 is used.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1573916930-19068-1-git-send-email-bmeng.cn@gmail.com>
[ Changed by AF:
 - Use the SoC's serial property to pass the info to the SoC
 - Fixup commit title
 - Rebase on file restructuring
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 20 ++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index aed8249d0b..4299a5addc 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -34,6 +34,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
@@ -322,6 +323,8 @@ static void riscv_sifive_u_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             sizeof(s->soc), TYPE_RISCV_U_SOC,
                             &error_abort, NULL);
+    object_property_set_uint(OBJECT(&s->soc), s->serial, "serial",
+                            &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized",
                             &error_abort);
 
@@ -413,6 +416,18 @@ static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
     s->start_in_flash = value;
 }
 
+static void sifive_u_get_serial(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
+}
+
+static void sifive_u_set_serial(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
+}
+
 static void riscv_sifive_u_machine_instance_init(Object *obj)
 {
     SiFiveUState *s = RISCV_U_MACHINE(obj);
@@ -424,6 +439,11 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
                                     "Set on to tell QEMU's ROM to jump to " \
                                     "flash. Otherwise QEMU will jump to DRAM",
                                     NULL);
+
+    s->serial = OTP_SERIAL;
+    object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
+                        sifive_u_set_serial, NULL, &s->serial, NULL);
+    object_property_set_description(obj, "serial", "Board serial number", NULL);
 }
 
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index a2baa1de5f..16c297ec5f 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -61,6 +61,7 @@ typedef struct SiFiveUState {
     int fdt_size;
 
     bool start_in_flash;
+    uint32_t serial;
 } SiFiveUState;
 
 enum {
-- 
2.25.1


