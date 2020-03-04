Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A5C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6794720866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TR5oRXXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6794720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9dAL-00087t-Nq
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d9A-0006SO-0z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d98-0004h1-AK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d98-0004Sp-1U; Wed, 04 Mar 2020 18:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583363385; x=1614899385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=piq3GJJCoPHXlSP1vfQ7BZnPzHD9F56ACnt/w7CyrmA=;
 b=TR5oRXXVPQNzwcspI8zBQoTXafSbDk7UHyQlfG52OYy392eyTNL26PT6
 BydyII/ea3QAQDSkRAnkOXPr8rkvGTuCWa67MUPmOnRq3xvO8a0E1K1kV
 bzkOpzQ2A9Brbs+9NQ2RqOWMhG97LI2ia/jPuwiNa+uglzxu6C+qORRmG
 kqcnGMXcJ8geAuOVQ7NdPHCrdEaM0Qcma5wStjvQbqqd630JBLrDrFZQW
 lSul929raVaC33PEzg76njCGIJBCeIKmuacCoD0s8ap9B50FJRDUG9Tmx
 rhCcEymjLg222o2NalI1ZKdgeIvIhuDuP/RgNene7i4tsUNX8YZTNfTr3 w==;
IronPort-SDR: +Z2Ki2NKCmDD2c/Ggb0n390E9/SnssQAsaoEd7sOQgUjDG/e537Om5m503164FzBV+UWP+1Rmm
 zLEQ+XF6mATd5LTfK0n+opJpo37NJCruieys5RuburiLLKzTxgodIcGrS7uT3fmzpXeE/HWtpx
 nidIoLQVWZoRxcUdwlcLZno7h9oB4TqINV+0owxMsvLXWFIIVJVKwCYClIBVxjpr/NnQk6uH9H
 o5YdbOBzOrZnmz5DGXXd0na2J1fs8a/C8xkkOiriga7X7f8rvFwfITYKt/RGKCyVLKbZS9RUqY
 uMg=
X-IronPort-AV: E=Sophos;i="5.70,515,1574092800"; d="scan'208";a="131477239"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2020 07:09:45 +0800
IronPort-SDR: mXx/M+fkVMlPhSnK8MAZZYKq+xj0WxVlB3slTPDX+xipXNQYhh3c88QeMbA8F2GX89ftL/MEMP
 YX/RufuNkI7lSxlDNQpKFbEIOfBhaIoCAWDRsSn3dvnbtlO+7EEC7wBdpOQPTaj5n6pxRkFEvF
 XQHsHOAHOA5HXW6gtlThayF4ygSj4oCoG4Z8+ckx8QJ7rZKWJMLeXewNVRG5rAkwQukdBCXsDo
 whT4cAdAnLjn2wlUzreSU3GrDOeLmARvvH0G1Iv2lz30sXHVs/mU3Sn3lfaBt5mEBe75QyHyIE
 WQXtW6pT1jjEzy3+sKKvlZub
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 15:01:34 -0800
IronPort-SDR: ECRiPOqgWAO8YOzvludlC6jnZxYt7E/CK8CTv1YcKuGws4xmBhZ/5cPciDkm0QpRpWGwACNkPB
 O9NiYt53m0Pa22PIObeEWxCgHKFKEzGvwPfIuldR0YNj6K2yA3x++YDZ459NsTij6kb2mwoxfe
 kHv1UcMdFPQjLDGSBFdCizESOlfKqorKBbQ4wj2vkr1ymXWUQB4DZkVkp40LznkSObQmOf6sUY
 PfHbTtMzg2+ztYBX8m998NNir7DykAjH+YOXr7MbzoRD6s3I5vdq2gvqV10TzXcZmxp01y+25W
 cG0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Mar 2020 15:09:45 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 2/3] riscv/sifive_u: Add a serial property to the sifive_u
 SoC
Date: Wed,  4 Mar 2020 15:02:30 -0800
Message-Id: <d1942aa2b5ce772070507bbe7c1cd1d280b36323.1583362888.git.alistair.francis@wdc.com>
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
---
 hw/riscv/sifive_u.c         | 8 +++++++-
 include/hw/riscv/sifive_u.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9a0145b5b4..aed8249d0b 100644
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


