Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8D120756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xw1g51n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8D120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyRF-0004o0-VD
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJO-0001LU-BQ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:30 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJK-0001FT-U8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417607; x=1635953607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bxfmTayuMlAkbdWAwkDMu9qmrbCTEm5F3jlbPoZ/kFE=;
 b=Xw1g51n1RRvtIQV0X+Vqlai9/4IvAui2mYWAdR3ZJ7+QjWjKc61HiI64
 txJagizXtDkXpa385yTspJsEzL5HOSVtJdvNgXcWeT6VFB8xQg+DNzIzQ
 EMKA0YMkBz6MCetFQe+uuLzPjpsl5ERsVPdug1E+sCyZEM+MQQ8niT8B8
 jBnuYKgH6CQS8a8itaO7a1VgJuS9u2L2eNz5bSgeK3zE9Irs3DROG4bXZ
 LmIbECBNLtBBcVMk3SMSqLFXnzZur8Y+q9GY4DUCsmHKO+VTsBjixNoOY
 4eZiQN8IY4i24SeCcNMqTO8O1y/DIVvmcUYNqIEVJDR5Dw4APwx1AEQP+ w==;
IronPort-SDR: 5Cp4p1Qn5d0EpSlKfMYxYvjbm1ILCuxccATXY6EAVFyPEtxkqVYyH/fi2XasuyWU6t2aMm7Vx4
 ITiL3j2MiCYfbC9b35mj0ARWHM6e6mNW6Lqa8IO9/qttcaR9H90fHB4vl7U82g13jpgQSZOlc9
 BERmpS7YBaqQojAT7H+U6Q6oQhAGAuSiaXKx9UGDrr7VRyTMem3KLB0nTezFFFLDUfKejQkIJQ
 3TvWxwKUvJwXidgd2xd6ty/gwxLrYiYLZpwSnrQIfayzJk5Etbt67ujYnVFliJwo13LP+vOqvS
 T44=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867448"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:24 +0800
IronPort-SDR: LqLRVBZfHp+arN0o7N2LidaP5jag88m2mZKfUOxaSayg4kvj+GTgdFH+L4inRPNB9b1dL3ngR1
 rtRmKhua3B6onEVKv3I1IvSiWyFijhNaAVK26yLlzsT/E6NhbRWkz2Py1/NrDTiWFs7EwcPvrV
 3xp3k98+u2aN53greBh/Q2Qn9wGZGhEbtmpTpeOGbf0Aw986vo9RwzN6dhEps+EXuXu1aN9G5e
 I0gQb79otCuYywbYSEP4WR7/pYqN+r5td+PdnKLV6CNGnQcbBDvmn93uQ5mtbK0Ue5QcstoP59
 PIds6T4rWktwhKi9ItzGcyyu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:32 -0800
IronPort-SDR: d7jjGrTv0QmwftNlaBPkEXcnyaFEz5TG72GXJ28q/ou8fugFd7V/vOMFUyIGFPJae5MjiR+Tgx
 J1z6cefoCOJHDDehALb98kyr48SVDXE355J1rhUjmkNvYqHJoZxU4r/ehJEkYEQqeFFHcQ1Cog
 Ovh9dir0joI0JZAxnHqlFJclnOj4jewETTsqjA8wJPVSKyJu2+jnCzsj0IE2PsTWmJGOkWXDRz
 ajbtlTbAQPeLAwGET0gEqyOHnb4aSWdlUZ6s9dqCjX/ZK9jvfZ/5OkXmFPe5XORH8K3ZuFbm33
 eZQ=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:24 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 01/19] hw/riscv: sifive_u: Allow passing custom DTB
Date: Tue,  3 Nov 2020 07:21:32 -0800
Message-Id: <20201103152150.2677566-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

Extend sifive_u machine to allow passing custom DTB using "-dtb"
command-line parameter. This will help users pass modified DTB
or Linux SiFive DTB to sifive_u machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20201022053225.2596110-1-anup.patel@wdc.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b2472c6627..2f19a9cda2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -100,14 +100,25 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
+    const char *dtb_filename;
     char ethclk_names[] = "pclk\0hclk";
     uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
-    fdt = s->fdt = create_device_tree(&s->fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
+    dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
+    if (dtb_filename) {
+        fdt = s->fdt = load_device_tree(dtb_filename, &s->fdt_size);
+        if (!fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+        goto update_bootargs;
+    } else {
+        fdt = s->fdt = create_device_tree(&s->fdt_size);
+        if (!fdt) {
+            error_report("create_device_tree() failed");
+            exit(1);
+        }
     }
 
     qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
@@ -390,13 +401,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    if (cmdline) {
-        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
-    }
-
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
+
+update_bootargs:
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
 }
 
 static void sifive_u_machine_reset(void *opaque, int n, int level)
-- 
2.28.0


