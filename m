Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F7120DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VO/FtQjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F7120DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKYb-0002nJ-9F
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUM-0000qN-DY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUF-0004Pk-Ld
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586456; x=1624122456;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dMdIIDoCv7W8aOLzjHKqNqNnPV7covUPMRH4EMqR6ec=;
 b=VO/FtQjWbqVoqNBHl3ljvpysi/gR2EKDJOzZqjnecx5D7QygQf06beuo
 jVzoCC9zF/USv38lAwERzjxAmeKILUzEArlatNBZyttC1gKBgKAPiB9V3
 DmS+3TEriISspEKYCp9txdrJ9Ur//bH3+itb9vmbtbP2+Lx1kId8qwjhA
 1Hqn8ZatarsBKuIV+FLqifc3o5jppI8aBG/tF3DfGRX2I8nEMYSRN78c/
 xpt1N71Xku3tNwARhEKDwhiogCY+cwOkkCC12og8tF7HkpIAbsxOAqXO/
 AkXwikGDiF6cw9fEwKruDH9qE2DcI43h+G6sMRAmzUz04AJ1fbBud6iq0 Q==;
IronPort-SDR: mRrwEKAmWDORzXLQG6jL9uYe5e9c06SWN8vJIgQ/r+SjiC2o5Sq9kTg+A3N75qK/+CE+9lhG1m
 NChX9if8k7njuRD56hQIlGuTIQExs3GLIjIBEYmf22h5U+lExyA6bGfz4Ume1na4+3Z44Jnca8
 X6xQpw8dlpLkiLeve2MPKOlz/I0X61H4uXTDxW9zMUz3C1eb7EUsQA5DQabl2KIZopAId8C79i
 m+G2Fy8q1iiJxxxc9Vtal2+TDyeVRXZNE1ywgIbyJuLiR6nEnULxN4E8v2kij4LI2Lb5flyeod
 pMw=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417003"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:27 +0800
IronPort-SDR: Avgnrck5NOHTymscd4ti83DHdpP6mYa8CMBWFqAegM+tAMDrl2kCeuN1/cbswKQCQihkzFmCuX
 DrHZklQVHb4mVIxb8KTqaIhZyS3hc+rxc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:03 -0700
IronPort-SDR: FSR5p7C+wVa6RzhHe+IX2VX+pOzUeISzcc0dL+h00/YAaxlAulpVWr+w0ebOFbY01AfJ51wCJu
 9hk6KPJax+Vg==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 20/32] hw/riscv: sifive_u: Generate device tree node for OTP
Date: Fri, 19 Jun 2020 09:58:05 -0700
Message-Id: <20200619165817.4144200-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Upstream U-Boot v2020.07 codes switch to access SiFive FU540 OTP
based on device tree information. Let's generate the device tree
node for OTP.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-5-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-5-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 20b0276ea3..a6dfce4273 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -207,6 +207,17 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/otp@%lx",
+        (long)memmap[SIFIVE_U_OTP].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "fuse-count", SIFIVE_U_OTP_REG_SIZE);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_OTP].base,
+        0x0, memmap[SIFIVE_U_OTP].size);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+        "sifive,fu540-c000-otp");
+    g_free(nodename);
+
     prci_phandle = phandle++;
     nodename = g_strdup_printf("/soc/clock-controller@%lx",
         (long)memmap[SIFIVE_U_PRCI].base);
-- 
2.27.0


