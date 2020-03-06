Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3F0C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A4520674
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fL0qbioq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A4520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAKo3-0003Qz-PZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 16:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlP-0008Vw-KY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 16:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlO-0002TW-6D
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 16:44:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlN-0002H3-Su; Fri, 06 Mar 2020 16:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583531054; x=1615067054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tEzL81El13tYmLmo6YAcOeK5VWAlJ13nWzj+eXR7lfk=;
 b=fL0qbioqL/XAv7LfQbveyDTd1tsEEEOHkQwFgs2TVWhEOlIMzD2M46ya
 RGDk02X+YBM0WZq2gkkT4Va3VK4jYg9snvMAZSPqNrgkZvC9C43duLG34
 5djFPHL+WNYO4dn1MSj6w2y9659TUWeqctOMt0Su13dEqfC0UMJLlOGO3
 Jv5Enb8SH+V11i/KZdHteAl2ZgUXvxKnsjPv0q0T5MFdDAJmOVEDXKt4U
 UkN3uFKQstg9LkXjMcuykEoE0gTEEgBULhdZ8DuU7em9Rjngxumha8d8H
 x0ozFFOT6W63el8DlJn4W1Z3l5R+ReRasRcB60ErRj5Gk0c2hOkVZ4R0a w==;
IronPort-SDR: xR+CnMLaASdk/pNNLYHR4i21bLy2FvSH2P8RSj1nZUlKNs/teafnD4RpasNLAQoyvlwNHViwst
 c3PrvxO7dU/RebWjF+ArTP46JJVS/QZyaB82f8cc8drJN1ceeRJ9j0/ZEBREW8Tiqp8mMj7OlP
 JQtenTulSBx8R2O4L5OOcOeyOzEtkchNFD23E3Vf3OTRo78VfqUeh6mfY55mH84zsgtnLghkPY
 dlAfW4W+0pXw2SpmQOBJPRv/XmU0LrhrVBBFfk3Qj7ld2t/Vb9b2LXa+03dgt4ApIj1Ijn4386
 ZdM=
X-IronPort-AV: E=Sophos;i="5.70,523,1574092800"; d="scan'208";a="233784281"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2020 05:44:12 +0800
IronPort-SDR: Pj/xc92iQ7KecwDlwgkTNrI7Qqy4kFp1BvSB+CJ0HK7qkyQ2XhAHbA5AlCJPlImihziHvvDHzk
 obc6NSM7CYKl56yXaOCPPn8W/LEF3meA2y+wrI+S/VtK6ZYvEOGJlZazH2DGBN/gc9p3taYq5H
 YKOGWfd5b1V+jHk8xq25VqFDK5VvaN5sH6K2TEtcBlmw6otBc2/BTuDcvknBCEGvIwGheDsf45
 pS9C3eA+GZDETRx5dBWqHgQBkM+y0RDix5EnUQUXwpiH1OCGi2phO8USPDxG6DGmSu9s626XAN
 0RS8OxULfpuG8gaauo8Nqam5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 13:35:55 -0800
IronPort-SDR: L5hd0MYa3rZv5REWrK7xpr3Y4w+/MnpR4HdqW+x5hvapx3mSd0EHAVTzuUoEbr1ciQSCjRmobj
 QKiKONOwfGi0ag08H4j9u/1sfkJQ5dpDQxUdBExasgfF5T/lRqJRCgO8qzmdF9zah3LtzbVQLG
 oSZ5WcRp4vtnOwuVJAa3eC27SCFJAm1KQ6M2NzOQ6iUySQv2DF1hIbJef/HmWVIcHeUbhsZGun
 qRttz4ibgmirH/E6jse1NBzyq3VJ2o0XHQJMjpWK2qlhZ+grRJerwJg0sj5vuVYFHMtPuawDnC
 mos=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Mar 2020 13:44:09 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 2/3] riscv/sifive_u: Add a serial property to the sifive_u
 SoC
Date: Fri,  6 Mar 2020 13:36:50 -0800
Message-Id: <b6b63cfb5d126df115f1090d5980a788d8e24289.1583530528.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583530528.git.alistair.francis@wdc.com>
References: <cover.1583530528.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At present the board serial number is hard-coded to 1, and passed
to OTP model during initialization. Firmware (FSBL, U-Boot) uses
the serial number to generate a unique MAC address for the on-chip
ethernet controller. When multiple QEMU 'sifive_u' instances are
created and connected to the same subnet, they all have the same
MAC address hence it creates a unusable network.

A new "serial" property is introduced to the sifive_u SoC to specify
the board serial number. When not given, the default serial number
1 is used.

Suggested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
---
 hw/riscv/sifive_u.c         | 8 +++++++-
 include/hw/riscv/sifive_u.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 4688837216..dc572c761a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -488,7 +488,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_SIFIVE_U_PRCI);
     sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
                           TYPE_SIFIVE_U_OTP);
-    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
 }
@@ -581,6 +580,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
+    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
     object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
@@ -607,10 +607,16 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
+static Property riscv_sifive_u_soc_props[] = {
+    DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, riscv_sifive_u_soc_props);
     dc->realize = riscv_sifive_u_soc_realize;
     /* Reason: Uses serial_hds in realize function, thus can't be used twice */
     dc->user_creatable = false;
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 82667b5746..a2baa1de5f 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -42,6 +42,8 @@ typedef struct SiFiveUSoCState {
     SiFiveUPRCIState prci;
     SiFiveUOTPState otp;
     CadenceGEMState gem;
+
+    uint32_t serial;
 } SiFiveUSoCState;
 
 #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
-- 
2.25.1


