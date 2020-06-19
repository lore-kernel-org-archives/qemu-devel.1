Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FD320771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fDJBD3Lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FD320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKWi-0005ak-VE
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUC-0000dg-AB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKU9-0004Pg-Er
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586445; x=1624122445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XXem7lAIy5JLne6cVjjQsO7guKTzZZhyfFB1ov8zLOg=;
 b=fDJBD3Lb1Id4RjgL1jb3NMfvkQQChnqvtRDkIgZ0wYCC1Lprzh+zKudw
 MKSEQiY+MKGdCdoS1xC3bF6baikh2LUJ15xKJwXq/8G9pctQf7hEOOvXM
 w/XQHZMSrKbMxM9Xb6JDDSXGgiRERg8+j1M7M0+G/GfT+Zd6a1pbuFBYB
 rrgl+IAe10GdUA0RYxE81khI6MGyHYpiemNqck8iCzDtmlMjJ30cBZ+yh
 Lc7JnLG8DiWx6K+CmGiikCjoA4Jn4k0m7GZnYUFoZPc4DQUKPoycCyGqf
 8O4nR9VENED1Ylv/NvTJrHx4mOkrmA35mpaLdRXt6TkhB4EnP6xhA/USj Q==;
IronPort-SDR: PsBj6//sU9a46ErTf0rrGd6tuHngG6nN938ms+NykNGIlUhgP8bFquJ7r6k3VYZPbDzdDK/wQB
 YZ2z5ojysGICa+f+bp0EsffI/pVQNn7rxR0YMaQt0wBkElfyk3nFFdrKk6lmwMVjgn8pOvhom5
 6HhOODZGoNl9t5FPc5hD+UKxZdSZD+3MgwwpE0H4u6jkfeecUnf93jfav5VUTQ0s3Ij7GPF3Kc
 s/ExnknwhapLj06ARUszLVbdysOdpqeePK47DMdzLZ0gVwZFrGtHDwFbHr+lmAt73Msp6gckVK
 VOs=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="144763300"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:21 +0800
IronPort-SDR: +ynqII+RQpn9KyggGqUbxBy2CO+IDhNOIynbfEXfRH7/djzP8R8Ri2cKJogDnOrmVpZ3kd86ze
 k8GmIXtgdqJQAiTI8AsKWncMbz2tmives=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:55:58 -0700
IronPort-SDR: T6GGQ2U2sA+ZAKGSh3Dynnzy1N78sGu0jSHtkZWP/EqF5CE5OXgwscwW7AWGy0erN+ieDxZ025
 bwvZuZmtCz0Q==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 02/32] sifive_e: Support the revB machine
Date: Fri, 19 Jun 2020 09:57:47 -0700
Message-Id: <20200619165817.4144200-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:21
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


