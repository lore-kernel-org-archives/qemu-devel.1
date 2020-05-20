Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C88C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF832065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JYadaoSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF832065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRj5-0006rH-1c
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40290bcd2=alistair.francis@wdc.com>)
 id 1jbRi2-0005CJ-0K; Wed, 20 May 2020 12:36:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40290bcd2=alistair.francis@wdc.com>)
 id 1jbRi1-0002lX-6B; Wed, 20 May 2020 12:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589992605; x=1621528605;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DOagZFIyWIOdVZLyXWb+AMorfmw3jWNAx6DX9j9m1ns=;
 b=JYadaoSS+1z9J2fXqAgMLtEyHPEUWCcCLmGQ7ybEvTZGWJk5aHG57iKP
 3ARROFDl0LANkd0i3+sJdkvn8LysyDYckgrCSn9/LGbtp+MlGYISrVL6E
 98Gmi4JCsT4IcdfI4kgz75UH2fYCp/4oZe/7TxaWAG+uUzPlP+YANsDpe
 dPeioAHVFRV2BPIVhqi51SGz8a9mcWE3recz+l4I+4PsoLCi3YS3GgfGA
 bzm82rDpPAfeldQrF3hYQLtaoHAE06IDeg6Bzi40eFHIO0ESg/GPniPyg
 W6HPPm67m/JXl+/4ZGPLNXJV1WIE6ipqjLJmC1GbubpNe3HvsgjsNpw2A w==;
IronPort-SDR: JNlcbRFmI/YXLsQp/CEPDQbu0LQk5a8GcqafmwcylkxAuDXVug/epTkP6zKMt0AiHi22ZOJH/L
 EOIzONzH/xZ7+DgoP1xpvPhCJzLU0iTnBavaugm29bl6IZkKhApguDMPM9n1t0GifuQGvnq8mC
 oS6IuNDZL6f6V5TQVlkLZIFwmlFS0BctxH/d/JbvS8Ml5iJQQvZxvT16kqkQoRtMxIZ/ykgrlx
 4ophXDQnW/sBb9mOz+GVQ8ddCVqpHc7Wax7B7+wFU/RdqNjcAkDMlt4ckHkCmE+rvtwy3AZrUn
 PaQ=
X-IronPort-AV: E=Sophos;i="5.73,414,1583164800"; d="scan'208";a="138468215"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 00:36:44 +0800
IronPort-SDR: THwWWngZAjQ84jL8glqVb88OIZ63FQpRMEFlOWX4dRH0aFNV+pXyFjy13CagFGTyu5pjpZpBlw
 RMtdit1SampdjxSVWgwnnEv2DyL9J6zkI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2020 09:26:46 -0700
IronPort-SDR: BO2RXBNVmC0/n1sGE6nS4bygGRRdEcWAX/Y8QorFtY/bxftrqIza4LsjeD3i4yE1LK5jUV/SNo
 hoVvnN/8kyng==
WDCIronportException: Internal
Received: from 96yhgc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.51])
 by uls-op-cesaip02.wdc.com with ESMTP; 20 May 2020 09:36:43 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 2/2] sifive_e: Support the revB machine
Date: Wed, 20 May 2020 09:28:15 -0700
Message-Id: <9a45e819e850f6c913340a03c475b93428e9d139.1589992028.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589992028.git.alistair.francis@wdc.com>
References: <cover.1589992028.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=40290bcd2=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 12:36:38
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
Cc: alistair.francis@wdc.com, philmd@redhat.com, palmer@dabbelt.com,
 bmeng.cn@gmail.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_e.h |  1 +
 hw/riscv/sifive_e.c         | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

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
-- 
2.26.2


