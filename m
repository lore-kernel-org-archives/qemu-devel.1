Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B03A20659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MCmdh6Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B03A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWHg-0001vd-Et
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAG-0007hn-0m
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAF-00060J-1D
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201371; x=1622737371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wwPImWk1wm0+wyKyb3GoOt99XLA5qpd/VeaKzQuuvmk=;
 b=MCmdh6WrmuP4LX/MAsNC4NnyBWOt12Yp3QPrtzkGJIKwlo3RasyzO9cT
 t9/G7+N5I5HHfm/1xykh5bpFgpZJ6Gav5jzuAedHP0YzoYYwmhtO4svZt
 /cgBWG2PzeFqXQNQHY3CP4zAl2j8K1Jd5zp7R2ZO5nYyvOtuzh5z9iHp8
 bYV/6k5EnXFJJfyHPlN8cpJNyIOVPR/6Zi2n5SRflGYG1rSpyRFj2erXE
 9USGNPnlBsctHdtSqcIcEL+3mUoBlo3OLiCFg3T1UvM5LM67dNt2gCp2W
 Hfj99E2i6/+z70RFeDiywg5tyBO3DwDqu6KSXEMoAp0t97aTuVToYs3yc A==;
IronPort-SDR: td39yrFRXqRDUDAZemdPvhUpc4hd94iwlZ3uvnniygqzhAtThFgpUc4Yun/YWoW7E4jdjZN/ut
 I69VUWdI7TrWDICtxLcoYPTKZ9ENRVAjkzTinqcKH0bGLpmZT7bW+cRFTHMU0GG24C/0KtA270
 oRux30GnT4okO5/cpMUv7XCqDB+RcUBzHCA6S6DEL9CMGlKpFD28wd+nTJytxkle+W/8ILGN8+
 8sJH/2vDhlUCDe+Boe6YZjsQaTmCn6JU4XlImX7cJqebX3+T0s1ZBR1sMIDsJ9aFAsk5tbB6oJ
 iI4=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451362"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:41 +0800
IronPort-SDR: NIXqGhn9H+dFo/A1LdAPFLopVQKPtzw68GN4nfb17ryiCM8LsyfrezRSIhm9q0S8Vz6PJV7kj5
 2aQXusE/xoi7WF9iQuFdXkL3Zh6S560vc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:46 -0700
IronPort-SDR: Xvzz8rb+vgMaP4LwuwdQzNnxyZ91NAt41mfJ7VRA2Zypq+df/wPBNOziWyvKJDVEdKewO/QIdk
 INoXBj8PnQYA==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 04/15] hw/riscv: virt: Remove the riscv_ prefix of the machine*
 functions
Date: Wed,  3 Jun 2020 09:13:47 -0700
Message-Id: <20200603161352.744204-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603161352.744204-1-alistair.francis@wdc.com>
References: <20200603161352.744204-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=416cc4bc0=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:22:40
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Remove the riscv_ prefix of the machine* functions.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1590072147-13035-2-git-send-email-bmeng.cn@gmail.com
Message-Id: <1590072147-13035-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7ce28895bc..4e4c494a70 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -471,7 +471,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     return dev;
 }
 
-static void riscv_virt_board_init(MachineState *machine)
+static void virt_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = virt_memmap;
     RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
@@ -632,32 +632,32 @@ static void riscv_virt_board_init(MachineState *machine)
     g_free(plic_hart_config);
 }
 
-static void riscv_virt_machine_instance_init(Object *obj)
+static void virt_machine_instance_init(Object *obj)
 {
 }
 
-static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
+static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V VirtIO board";
-    mc->init = riscv_virt_board_init;
+    mc->init = virt_machine_init;
     mc->max_cpus = 8;
     mc->default_cpu_type = VIRT_CPU;
     mc->pci_allow_0_address = true;
 }
 
-static const TypeInfo riscv_virt_machine_typeinfo = {
+static const TypeInfo virt_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("virt"),
     .parent     = TYPE_MACHINE,
-    .class_init = riscv_virt_machine_class_init,
-    .instance_init = riscv_virt_machine_instance_init,
+    .class_init = virt_machine_class_init,
+    .instance_init = virt_machine_instance_init,
     .instance_size = sizeof(RISCVVirtState),
 };
 
-static void riscv_virt_machine_init_register_types(void)
+static void virt_machine_init_register_types(void)
 {
-    type_register_static(&riscv_virt_machine_typeinfo);
+    type_register_static(&virt_machine_typeinfo);
 }
 
-type_init(riscv_virt_machine_init_register_types)
+type_init(virt_machine_init_register_types)
-- 
2.26.2


