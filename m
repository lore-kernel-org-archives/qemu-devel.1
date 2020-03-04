Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40866C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5442073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eHHTBxC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5442073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Izo-0005pN-5S
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 20:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxZ-0003CP-On
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxY-0004Rl-Jc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:29 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxY-0004Pn-2B; Tue, 03 Mar 2020 20:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583285789; x=1614821789;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RZGMEj8rnsYsgj6Tk32enNLXX4pUHrwlRy91vxUcAFs=;
 b=eHHTBxC228ZNnaDMHOBhLBCE7pZaB8DDmyrRoH1VtDwIX58EP/0ekhSm
 G6Dg7DgqJSTtDNM4EL91UrQESLbjNzMmq2yOPShGhRPxioIgoS/+Ocf4E
 xi6hQ1Uz7/SAUrN4weYfsCdGe4w7jJh/CK3wl3Sh2e9Rx+Z4CDRQzhxbo
 5iFUVA6J9OzWqxUZ0SRgxmbb0h7ZoTR+/D+tnCA6z3w3hkx2fXL8Cgl4L
 NQ+uWjFw+1XRtOjTIX9C4mtZ76SCVq+bSLCeLITFVzPqBZBtUuHcN7Yn+
 G8MtXDc83XZ3BcAFS7MpSz5MDcTQq8b4qY7uquP2uCItUzEpWz/AFS5Zg g==;
IronPort-SDR: UxCGwN7B8zlSZ4cpLNVPXQFsVHZeYEdSr5xrBsSLcNqM2ybk4pdUMLIEdQwqpvpkWOEph4gtEy
 Cau6hcVSUtm/MCseMYLlFsCJB53W53te2TFlZ3iZh85oG7y9dJW2p1TxA2TOSL4bDGOWPzE/Hy
 nsLrs0gci27pKNxXb7SYSkYAJmd9fUymuk02duC3nHYYREDB0oOzie3RkvuiTA6+P1ol9Q7+XQ
 mYBfpBuh9WHdQD4H+9WddhIpQPvqfgFeAMN2wD7/fM+s/A5Cdnsop4PpuEGPmNXcfuMSQ+bHDS
 F/0=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="131866061"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 09:36:28 +0800
IronPort-SDR: sOl+Bhyb4NFVap+qtqa3MaodzFHKbdv3TzGKq7SRRr+Glvq1Eg9rwO3kQkL9yPP8p6AKsqpAfo
 yXo7UUDBgKjGrqPCam4b3n1YqfwAgs+2e43MRQ/aCCtl6hGbynAG72suBFvXqUuIBCXB/1byAb
 ON4Gx0+uH0h6BWHcGhBqYSNE/KapC4cIWBvySaVx4kp5a9XAk5j0Q5HjA98+BE+bqRh4A7pLZ7
 nzJuFQ09Z8BDViuwkjQJIdHsyoNyTIOi/Nog49pQTQ4OK0WOkM5X6dyQeFY9YaeLGjat+xbGpY
 Ee2oRZlUdOY+xLlsV/inCSmQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 17:28:18 -0800
IronPort-SDR: 2j8N8RQsraNEVUYYYc9XRnf46+7QO4N73zwN3MultxmD0Y1gsL9Zjungj4vk+2sVK3YUHu5+Fk
 0070HmnJHxnFsuR+mmTDzZnqomW0fgqGqjdQ+wCLVrfRZDMXPNkfl0E2iWyYiHPa1T1CpJmRsV
 SjrGi8mtINsMzx6vrfMG3C/8ypnL29+/cdKL/vnySBbjhoEHibi0S2JpE+U2o9RTKZURt8CQ4+
 5chBLeVFo5bw+A/TGWz+Q8bosi4JUG+ojnKJW/yoZhtnO893cQRCgMVcKqoiqapo/OEtjfkvPz
 oE4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Mar 2020 17:36:26 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/3] riscv/sifive_u: Add a serial property to the sifive_u
 SoC
Date: Tue,  3 Mar 2020 17:29:13 -0800
Message-Id: <e91f9fccc49a42482d964f380b2ae085de5bfab2.1583285287.git.alistair.francis@wdc.com>
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
index 9a0145b5b4..e52f9d0bd4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -488,7 +488,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_SIFIVE_U_PRCI);
     sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
                           TYPE_SIFIVE_U_OTP);
-    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
+    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
     sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
                           TYPE_CADENCE_GEM);
 }
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


