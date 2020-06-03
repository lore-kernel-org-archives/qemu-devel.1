Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D35C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE2320679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="POMB9JDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE2320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWF1-00076b-Es
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAF-0007hJ-PC
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAE-000625-PY
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201371; x=1622737371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ORE7QyYcMOsNvtsv4aawW11202e/vbLm4srPqvw5q60=;
 b=POMB9JDJC+RqUKT7oRNVpmCuApG4enMK1PN5lpJ9Oe0d/laDilCynFv+
 FAh654lgqinuVLm1kkYaiOH925Y7AzSnS7f56T7XD0SmYeTC8G4AJgsy2
 gLakgMyhA6NLQqgzzEMRM636gxdfRiXN1rMsTOrXM8MeO9ypu6qnQz9PL
 oRJmdXN/Zc0oRc+6RJMB67TiEePVvrH6tSw/TUUr901FAWNL9OIeZEckE
 1Z3bAfhkR7zsRudiw9s/Yd/9vp37YrUKRW8C5TyzUaMQD08Fgh/CW+Ysf
 tXXfDfZi1ISXiDMhWLwxdWfg3d9rB0bZZqMGiG0uj00tENvdQSYZTEvln A==;
IronPort-SDR: l715QZFRMjJEK6tMQoibHZpmIoUhZxqgR1myE1VlM8RRKTnb61H/kBR3B+ZAwZ2/h7qA8Sbfp8
 rGzB8z79yOCbJ4mOhRiNaNfa5W0aAL0IFJZXmMHixx5XNUV2EjXCclgrh7+NvUxf1tSF+JR8/M
 OLXaLe/ApJpxQ1hgM2i5QeA59UWIJTUZTYXVA+1VAf5PApkCntBUZmnb9r39ByWvrT9PG1R54E
 vq8h5UMuTNGqC4gshjaK/3263anl7WRmdtTYmh7jlKT7EAbJ+2H+Wp+XTv86q3Mm29FNOuWFmf
 fjs=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451360"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:41 +0800
IronPort-SDR: zkpshR5Fj4ZWu+Nq5u/vYWpXBQYV5l09qjSC0TJs6OVG6Md++c8z4wVjWgqKaeousY1W6uX8+P
 nv9f0YWpklvpvooFQq0gCuZQG2PpZ0L2w=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:46 -0700
IronPort-SDR: m+akeVPDYEp1yj8EzI7aBcd3oHiEjprWTzBk0VNv07WwAlrwRRrsbqDA1tLs+B0Cnc7hvnbafK
 glnhmwTzGVOA==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:40 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 03/15] hw/riscv: sifive_u: Remove the riscv_ prefix of the soc*
 functions
Date: Wed,  3 Jun 2020 09:13:46 -0700
Message-Id: <20200603161352.744204-4-alistair.francis@wdc.com>
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

To keep consistency with the machine* functions, remove the riscv_
prefix of the soc* functions.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1590072147-13035-1-git-send-email-bmeng.cn@gmail.com
Message-Id: <1590072147-13035-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 4299bdf480..f9fef2be91 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -481,7 +481,7 @@ static void sifive_u_machine_init_register_types(void)
 
 type_init(sifive_u_machine_init_register_types)
 
-static void riscv_sifive_u_soc_init(Object *obj)
+static void sifive_u_soc_instance_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
@@ -520,7 +520,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
-static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
+static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
@@ -635,32 +635,32 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
-static Property riscv_sifive_u_soc_props[] = {
+static Property sifive_u_soc_props[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
+static void sifive_u_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    device_class_set_props(dc, riscv_sifive_u_soc_props);
-    dc->realize = riscv_sifive_u_soc_realize;
+    device_class_set_props(dc, sifive_u_soc_props);
+    dc->realize = sifive_u_soc_realize;
     /* Reason: Uses serial_hds in realize function, thus can't be used twice */
     dc->user_creatable = false;
 }
 
-static const TypeInfo riscv_sifive_u_soc_type_info = {
+static const TypeInfo sifive_u_soc_type_info = {
     .name = TYPE_RISCV_U_SOC,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(SiFiveUSoCState),
-    .instance_init = riscv_sifive_u_soc_init,
-    .class_init = riscv_sifive_u_soc_class_init,
+    .instance_init = sifive_u_soc_instance_init,
+    .class_init = sifive_u_soc_class_init,
 };
 
-static void riscv_sifive_u_soc_register_types(void)
+static void sifive_u_soc_register_types(void)
 {
-    type_register_static(&riscv_sifive_u_soc_type_info);
+    type_register_static(&sifive_u_soc_type_info);
 }
 
-type_init(riscv_sifive_u_soc_register_types)
+type_init(sifive_u_soc_register_types)
-- 
2.26.2


