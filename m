Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB9AC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 15:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F0220723
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrUuZOsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F0220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVzi1-0004pV-Vw
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 10:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iVzh7-0004ME-UC
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 10:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iVzh5-00039c-SG
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 10:09:01 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iVzh3-00038l-TX; Sat, 16 Nov 2019 10:08:59 -0500
Received: by mail-pf1-x443.google.com with SMTP id p26so8085572pfq.8;
 Sat, 16 Nov 2019 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=5YsOfTa1cfXjS3bx9/f+FRPYPJZ5Mz1/XjfoAdU9Gaw=;
 b=WrUuZOsZIJpSAj4KH6vcCCeKJF0hgi9FjhNH3kRLTQsAf680Hoyo6kPCiCINukVy/5
 fkUfiK5Wx44ph1rFnaeOAU0pdrlLL71SYmBCG3ciRNAZ9QsdhQVoPRLUtennt2vSlBtc
 Ci+1mx9vP/dPW0sburarfSqBaEbJ2/P2DA6hCAVCNBpBhLyF7SxEEMjqN6VXu1Nb3pW9
 qwWXbhRf6O6+3G2dErk11Kr7mdUpUwb/90d4ID4TN2BzyQJoUwZQKGELojSYxZ4FKAtk
 4JkJJmMIKSdJfcSGrKNvEX3JyDeZRVw6vWFFNn4NCZhLMiFjaihGK4Blzm1Vn2o4fYiM
 jriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=5YsOfTa1cfXjS3bx9/f+FRPYPJZ5Mz1/XjfoAdU9Gaw=;
 b=N73twSDl3KOfCxo02KvnX9aOZRebbznOvkJOuZF8VXadOQ4/SgJxpJ5mBCBaxkpjVe
 brvjOzRtYYIcCYJli4prsV9oQcrUGXx/6IQ4Tb8YVN47IvFggzwo7SSvP2RKfQqBxyZQ
 o0UdRLzwUpXt+/vRLwTqlVeggf9rmyXdtxwoAA7VeFhki9TFt6i9nIKqJeEEW8Qrds0a
 f/EqjJ0tUbDOKHZmcAcG99DSVoeMBpBpeywDvp/ypUM/Hf709I5Pg4+0Bq9DMWIJsgPJ
 7133T1qj8tl8Z6fi+wl1JrxWTeIqy0fOn0uvEhekISyY7Bfp2LsEwK9YEiHXeegXr9K5
 pI6A==
X-Gm-Message-State: APjAAAUSYMDYcIEvYVzE3lRN52Co31lCehoIOhgdAI3lBUcWrWzGs8VB
 WgEmyfSKZaaZ5tuWfYnAmnc=
X-Google-Smtp-Source: APXvYqwndQR7n+Jw7DU5rc+tt5/OtxMXnIogW9BvCRNQVXE+4/PeTv9aN/m+6BNy3vxzA/6v+tsUUA==
X-Received: by 2002:a63:9d41:: with SMTP id i62mr23324215pgd.310.1573916935725; 
 Sat, 16 Nov 2019 07:08:55 -0800 (PST)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id r10sm12968577pgn.68.2019.11.16.07.08.54
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 16 Nov 2019 07:08:55 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] riscv: sifive_u: Add a "serial" property for board serial
 number
Date: Sat, 16 Nov 2019 07:08:50 -0800
Message-Id: <1573916930-19068-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At present the board serial number is hard-coded to 1, and passed
to OTP model during initialization. Firmware (FSBL, U-Boot) uses
the serial number to generate a unique MAC address for the on-chip
ethernet controller. When multiple QEMU 'sifive_u' instances are
created and connected to the same subnet, they all have the same
MAC address hence it creates a unusable network.

A new "serial" property is introduced to specify the board serial
number. When not given, the default serial number 1 is used.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
 include/hw/riscv/sifive_u.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9552abf..e1a5536 100644
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
@@ -401,6 +402,7 @@ static void riscv_sifive_u_init(MachineState *machine)
 static void riscv_sifive_u_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
+    SiFiveUState *us = RISCV_U_MACHINE(ms);
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
     object_initialize_child(obj, "e-cluster", &s->e_cluster,
@@ -433,7 +435,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_SIFIVE_U_PRCI);
     sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
                           TYPE_SIFIVE_U_OTP);
-    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
+    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", us->serial);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
 }
@@ -452,6 +454,18 @@ static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
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
@@ -463,6 +477,11 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
                                     "Set on to tell QEMU's ROM to jump to " \
                                     "flash. Otherwise QEMU will jump to DRAM",
                                     NULL);
+
+    s->serial = OTP_SERIAL;
+    object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
+                        sifive_u_set_serial, NULL, &s->serial, NULL);
+    object_property_set_description(obj, "serial", "Board serial number", NULL);
 }
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 82667b5..7cf742e 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -59,6 +59,7 @@ typedef struct SiFiveUState {
     int fdt_size;
 
     bool start_in_flash;
+    uint32_t serial;
 } SiFiveUState;
 
 enum {
-- 
2.7.4


