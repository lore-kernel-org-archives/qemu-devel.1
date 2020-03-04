Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E598C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A04C2073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VAGxd6+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A04C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Izv-00061u-IN
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 20:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9Ixc-0003Ei-JR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9Ixb-0004W4-EM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9Ixb-0004Pn-5U; Tue, 03 Mar 2020 20:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583285792; x=1614821792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hLfzBwQY0GHBELl4LwyEgvgs3lqC1dQdMfJRHFbzMPY=;
 b=VAGxd6+EdaiWi7MJ4eT8mf5kNabXeNB4ezQB5Uf47Z8cFrzh71k7483H
 Mxxicd6nVD5Y0ITvTSPWbBkmdWIDQGdgkZWk3VBm4xP/cxXshwWzEP3tz
 ff8RpDcdq0IacxLc4fUPcH52aHpd5Jf1jklFTqFdinl3WiofnrjfS94EI
 GkzJRTAVfmaFKhZcfM6bqo2CkumRAX35edS6Z87h9ppQjU/5NkbhGOunw
 cgjHxQIujCD9s+6c7H/jd7s1x9v8D6Ygg/0wq7Gjb44fasA59hFuOiUBR
 NLd+kQak/wwV48cx6Gn+aNz+VoQqX/kZls/uAqc33ui0vPyzomfRuqn5K g==;
IronPort-SDR: RbUBcKzTaBXoQlSyelxrW+DOQKQOixwj5WrJHc3iIW4rs6XeBtRU6ZECKZOcv7RamPFFahN83Y
 glK5rY5qw9ZrK3QyQ/twnOY9eaoQDt8Bex7di0MW6xFUOEaJ6IfwvYtieuH4PyWjU1Br1VtEhF
 ywKeRc+5/CwadryLg54HOxI3q8Jp3EkYOd3+ahjCcy6CuqKuiyaqtE5wjP288b0JNihrONcV/A
 93Zemzs9iayYKATevvrG6foxwnz1Ff+6JdEPUX0mCN6Cg2u4Shmtpok82VfmqIVxX9kdTQilPg
 VKQ=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="131866070"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 09:36:31 +0800
IronPort-SDR: +Rv7o+QWpKbJaMl0VCvcKjzrXQm4mH9kXjLwrksKm3AgRXISWaGC8zNgDhL1sMMhm0yjee0Dyo
 TS7jVp5AjST8IZR9crIR+dPipD0qesQ29uWEWjXeAEM6sXEmZuGeUcEqaUWt2Q6BhgwHw12bGi
 6xg13OnoqW1wM6PnypJkb00ASUeD33OC5CJKQz/MHqKCUwqrI0e0wi48Bpi5bkKXptzlgTmadr
 h6eujJMvBxf9jf7Pk/dCsec5XcYa9diJ6zCo5wOn21iq5uq4GFnz9Psits+NtYU/4VmFiQQqFp
 7BGFRydmGwN6sat3XQT1aAqY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 17:28:21 -0800
IronPort-SDR: AU/UdIHFl+8WWvgg1bZIN22I63oe+qy6xca90DwU4fJkuUoL7Akxh0aG6aZdyI9oEwvuK4wN8A
 8/AVMLo7LX/uCm0rrz5r+FJNoABTr0SIl8KHd9Ht3EWXRpxUVshV4GLZNaTnv3y08UPANJCakN
 dWQn8KdlqDcHqC5X0mRPRuNhYa502oPOybIAUADOsZh4zQFcit+HP67uaHpNzcFRATn5fT33WC
 /w91QclCAJ4f5u0Laxz0VOWa4SycGdhMe2ROBUdVA2JVdhI9EubzPOxd9knHYn1l1yX1mcHOuS
 qs8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Mar 2020 17:36:30 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 3/3] riscv/sifive_u: Add a serial property to the sifive_u
 machine
Date: Tue,  3 Mar 2020 17:29:17 -0800
Message-Id: <edb4719fd6a829eb7ec4cf4c4d73f3d2f02dbf2d.1583285287.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583285287.git.alistair.francis@wdc.com>
References: <cover.1583285287.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
index e52f9d0bd4..f3f67cc0e3 100644
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


